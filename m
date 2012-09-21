From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH] Fix: Change sempahore
	to	pthread conditions
Date: Fri, 21 Sep 2012 12:45:37 -0400
Message-ID: <20120921164537.GA30791__1925.36506006054$1348246047$gmane$org@Krystal>
References: <1348244909-13184-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TF6MF-0004n0-Dc
	for lttng-dev@lists.lttng.org; Fri, 21 Sep 2012 12:45:39 -0400
Content-Disposition: inline
In-Reply-To: <1348244909-13184-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Fixes #324
> 
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  src/bin/lttng-sessiond/consumer.h |    8 ++-
>  src/bin/lttng-sessiond/main.c     |  116 +++++++++++++++++++++++++++++--------
>  2 files changed, 96 insertions(+), 28 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
> index 1337f32..a5437d8 100644
> --- a/src/bin/lttng-sessiond/consumer.h
> +++ b/src/bin/lttng-sessiond/consumer.h
> @@ -18,8 +18,6 @@
>  #ifndef _CONSUMER_H
>  #define _CONSUMER_H
>  
> -#include <semaphore.h>
> -
>  #include <common/consumer.h>
>  #include <common/hashtable/hashtable.h>
>  #include <lttng/lttng.h>
> @@ -54,7 +52,11 @@ struct consumer_data {
>  	enum lttng_consumer_type type;
>  
>  	pthread_t thread;	/* Worker thread interacting with the consumer */
> -	sem_t sem;
> +
> +	/* Conditions used by the consumer thread to indicate readiness. */
> +	pthread_cond_t cond;
> +	pthread_condattr_t condattr;
> +	pthread_mutex_t cond_mutex;
>  
>  	/* Mutex to control consumerd pid assignation */
>  	pthread_mutex_t pid_mutex;
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 730ac65..df817c1 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -21,7 +21,6 @@
>  #include <grp.h>
>  #include <limits.h>
>  #include <pthread.h>
> -#include <semaphore.h>
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -90,6 +89,8 @@ static struct consumer_data kconsumer_data = {
>  	.cmd_sock = -1,
>  	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
>  	.lock = PTHREAD_MUTEX_INITIALIZER,
> +	.cond = PTHREAD_COND_INITIALIZER,
> +	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
>  };
>  static struct consumer_data ustconsumer64_data = {
>  	.type = LTTNG_CONSUMER64_UST,
> @@ -99,6 +100,8 @@ static struct consumer_data ustconsumer64_data = {
>  	.cmd_sock = -1,
>  	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
>  	.lock = PTHREAD_MUTEX_INITIALIZER,
> +	.cond = PTHREAD_COND_INITIALIZER,
> +	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
>  };
>  static struct consumer_data ustconsumer32_data = {
>  	.type = LTTNG_CONSUMER32_UST,
> @@ -108,6 +111,8 @@ static struct consumer_data ustconsumer32_data = {
>  	.cmd_sock = -1,
>  	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
>  	.lock = PTHREAD_MUTEX_INITIALIZER,
> +	.cond = PTHREAD_COND_INITIALIZER,
> +	.cond_mutex = PTHREAD_MUTEX_INITIALIZER,
>  };
>  
>  /* Shared between threads */
> @@ -213,6 +218,17 @@ enum consumerd_state {
>  static enum consumerd_state ust_consumerd_state;
>  static enum consumerd_state kernel_consumerd_state;
>  
> +/*
> + * This is a flag condition indicating that the consumer thread is ready and
> + * connected to the lttng-consumerd daemon.
> + *
> + * A value of 0 indicates that the thread is NOT ready. A value of 1 means that
> + * the thread consumer did connect successfully to the lttng-consumerd daemon.
> + * A negative value means that there is been an error and the thread as likely
> + * quit.
> + */
> +static int consumer_thread_is_ready;

This flag should go with each "cond" above, within struct consumer_data.
Sharing this flag across all conditions does not make much sense.

> +
>  /* Used for the health monitoring of the session daemon. See health.h */
>  struct health_state health_thread_cmd;
>  struct health_state health_thread_app_manage;
> @@ -789,6 +805,16 @@ error_poll_create:
>  }
>  
>  /*
> + * Signal pthread condition of the consumer data that the thread.
> + */
> +static void signal_consumer_condition(struct consumer_data *data)
> +{
> +	pthread_mutex_lock(&data->cond_mutex);

you should test the condition before sending the signal.

> +	pthread_cond_signal(&data->cond);
> +	pthread_mutex_unlock(&data->cond_mutex);
> +}
> +
> +/*
>   * This thread manage the consumer error sent back to the session daemon.
>   */
>  static void *thread_manage_consumer(void *data)
> @@ -801,6 +827,9 @@ static void *thread_manage_consumer(void *data)
>  
>  	DBG("[thread] Manage consumer started");
>  
> +	/* Make sure we set the readiness flag to 0 because we are NOT ready */
> +	consumer_thread_is_ready = 0;

no, this should always be updated with cond mutex held, or initialized
before you spawn the consumer thread. I recommend you set it to 0 before
you spawn the thread_manage_consumer thread, within
spawn_consumer_thread.

> +
>  	health_code_update(&consumer_data->health);
>  
>  	ret = lttcomm_listen_unix_sock(consumer_data->err_sock);
> @@ -886,13 +915,16 @@ restart:
>  		consumer_data->cmd_sock =
>  			lttcomm_connect_unix_sock(consumer_data->cmd_unix_sock_path);
>  		if (consumer_data->cmd_sock < 0) {
> -			sem_post(&consumer_data->sem);
> +			/* On error, signal condition and quit. */
> +			consumer_thread_is_ready = -1;

no. you need to hold mutex across setting condition and signalling.

> +			signal_consumer_condition(consumer_data);
>  			PERROR("consumer connect");
>  			goto error;
>  		}
> -		/* Signal condition to tell that the kconsumerd is ready */
> -		sem_post(&consumer_data->sem);
> -		DBG("consumer command socket ready");
> +		/* Signal condition to tell that the consumerd is ready */
> +		consumer_thread_is_ready = 1;

same here.

> +		signal_consumer_condition(consumer_data);
> +		DBG("Consumer command socket ready");
>  	} else {
>  		ERR("consumer error when waiting for SOCK_READY : %s",
>  				lttcomm_get_readable_code(-code));
> @@ -1446,16 +1478,33 @@ error_create_poll:
>   */
>  static int spawn_consumer_thread(struct consumer_data *consumer_data)
>  {
> -	int ret;
> +	int ret, clock_ret;
>  	struct timespec timeout;
>  
> -	timeout.tv_sec = DEFAULT_SEM_WAIT_TIMEOUT;
> -	timeout.tv_nsec = 0;
> +	/* Setup pthread condition */
> +	ret = pthread_condattr_init(&consumer_data->condattr);
> +	if (ret != 0) {
> +		errno = ret;
> +		PERROR("pthread_condattr_init consumer data");
> +		goto error;
> +	}
>  
> -	/* Setup semaphore */
> -	ret = sem_init(&consumer_data->sem, 0, 0);
> -	if (ret < 0) {
> -		PERROR("sem_init consumer semaphore");
> +	/*
> +	 * Set the monotonic clock in order to make sure we DO NOT jump in time
> +	 * between the clock_gettime() call and the timedwait call. See bug #324
> +	 * for a more details and how we noticed it.
> +	 */
> +	ret = pthread_condattr_setclock(&consumer_data->condattr, CLOCK_MONOTONIC);
> +	if (ret != 0) {
> +		errno = ret;
> +		PERROR("pthread_condattr_setclock consumer data");
> +		goto error;
> +	}
> +
> +	ret = pthread_cond_init(&consumer_data->cond, &consumer_data->condattr);
> +	if (ret != 0) {
> +		errno = ret;
> +		PERROR("pthread_cond_init consumer data");
>  		goto error;
>  	}
>  
> @@ -1467,31 +1516,48 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
>  		goto error;
>  	}
>  
> +	/* We are about to wait on a pthread condition */
> +	pthread_mutex_lock(&consumer_data->cond_mutex);
> +
>  	/* Get time for sem_timedwait absolute timeout */
> -	ret = clock_gettime(CLOCK_REALTIME, &timeout);
> -	if (ret < 0) {
> -		PERROR("clock_gettime spawn consumer");
> -		/* Infinite wait for the kconsumerd thread to be ready */
> -		ret = sem_wait(&consumer_data->sem);
> -	} else {
> -		/* Normal timeout if the gettime was successful */
> -		timeout.tv_sec += DEFAULT_SEM_WAIT_TIMEOUT;
> -		ret = sem_timedwait(&consumer_data->sem, &timeout);
> +	clock_ret = clock_gettime(CLOCK_MONOTONIC, &timeout);
> +	while (!consumer_thread_is_ready) {

ret = 0;

while (!consumer_thread_is_ready && ret != ETIMEDOUT) { ...

> +		if (clock_ret < 0) {
> +			PERROR("clock_gettime spawn consumer");
> +			/* Infinite wait for the consumerd thread to be ready */
> +			ret = pthread_cond_wait(&consumer_data->cond,
> +					&consumer_data->cond_mutex);
> +		} else {
> +			/* Normal timeout if the gettime was successful */
> +			timeout.tv_sec += DEFAULT_SEM_WAIT_TIMEOUT;

no, if you return due to EINTR, and loop, this increment is incorrect.

> +			ret = pthread_cond_timedwait(&consumer_data->cond,
> +					&consumer_data->cond_mutex, &timeout);
> +		}
>  	}
>  
> -	if (ret < 0) {
> -		if (errno == ETIMEDOUT) {
> +	/*
> +	 * Reset back the flag so we could respawn a consumer thread at some point
> +	 * and avoid skipping the above readiness wait period.
> +	 */
> +	consumer_thread_is_ready = 0;

no, if we set to 0 in spawn_consumer_thread before creating the thread,
we will be OK. No need to clear it here.

Thanks,

Mathieu

> +
> +	pthread_mutex_unlock(&consumer_data->cond_mutex);
> +
> +	if (ret != 0) {
> +		errno = ret;
> +		if (ret == ETIMEDOUT) {
>  			/*
>  			 * Call has timed out so we kill the kconsumerd_thread and return
>  			 * an error.
>  			 */
> -			ERR("The consumer thread was never ready. Killing it");
> +			ERR("Condition timed out. The consumer thread was never ready."
> +					" Killing it");
>  			ret = pthread_cancel(consumer_data->thread);
>  			if (ret < 0) {
>  				PERROR("pthread_cancel consumer thread");
>  			}
>  		} else {
> -			PERROR("semaphore wait failed consumer thread");
> +			PERROR("pthread_cond_wait failed consumer thread");
>  		}
>  		goto error;
>  	}
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
