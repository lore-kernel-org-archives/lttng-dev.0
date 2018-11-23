From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu v2] Fix: pthread_rwlock initialization
 on Cygwin
Date: Fri, 23 Nov 2018 17:04:20 -0500 (EST)
Message-ID: <1527722829.12256.1543010660311.JavaMail.zimbra__30096.5392766104$1543010550$gmane$org@efficios.com>
References: <20181123214718.27335-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 431r1y0hTnzvFM
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 17:04:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0B1CC9AAA4
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 17:04:21 -0500 (EST)
In-Reply-To: <20181123214718.27335-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged all 4 patches with some modifications to this patch:

- added missing abort in test_rwlock_timing.c
- added missing pthread_rwlock_destroy.

Thanks,

Mathieu

----- On Nov 23, 2018, at 4:47 PM, Michael Jeanson mjeanson@efficios.com wrote:

> On Cygwin the PTHREAD_RWLOCK_INITIALIZER macro is not
> sufficient to get a properly initialized pthread_rwlock_t
> struct. Use the pthread_rwlock_init function instead which
> should work on all platforms.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> tests/benchmark/test_rwlock.c        | 42 ++++++++++++++++++++++++----
> tests/benchmark/test_rwlock_timing.c | 33 +++++++++++++++++-----
> 2 files changed, 62 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/benchmark/test_rwlock.c b/tests/benchmark/test_rwlock.c
> index 4448597..76beb12 100644
> --- a/tests/benchmark/test_rwlock.c
> +++ b/tests/benchmark/test_rwlock.c
> @@ -48,7 +48,7 @@ struct test_array {
> 	int a;
> };
> 
> -pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
> +pthread_rwlock_t lock;
> 
> static volatile int test_go, test_stop;
> 
> @@ -173,14 +173,25 @@ void *thr_reader(void *_count)
> 	}
> 
> 	for (;;) {
> -		int a;
> +		int a, ret;
> +
> +		ret = pthread_rwlock_rdlock(&lock);
> +		if (ret) {
> +			fprintf(stderr, "reader pthread_rwlock_rdlock: %s\n", strerror(ret));
> +			abort();
> +		}
> 
> -		pthread_rwlock_rdlock(&lock);
> 		a = test_array.a;
> 		assert(a == 8);
> 		if (caa_unlikely(rduration))
> 			loop_sleep(rduration);
> -		pthread_rwlock_unlock(&lock);
> +
> +		ret = pthread_rwlock_unlock(&lock);
> +		if (ret) {
> +			fprintf(stderr, "reader pthread_rwlock_unlock: %s\n", strerror(ret));
> +			abort();
> +		}
> +
> 		URCU_TLS(nr_reads)++;
> 		if (caa_unlikely(!test_duration_read()))
> 			break;
> @@ -208,12 +219,25 @@ void *thr_writer(void *_count)
> 	cmm_smp_mb();
> 
> 	for (;;) {
> -		pthread_rwlock_wrlock(&lock);
> +		int ret;
> +
> +		ret = pthread_rwlock_wrlock(&lock);
> +		if (ret) {
> +			fprintf(stderr, "writer pthread_rwlock_wrlock: %s\n", strerror(ret));
> +			abort();
> +		}
> +
> 		test_array.a = 0;
> 		test_array.a = 8;
> 		if (caa_unlikely(wduration))
> 			loop_sleep(wduration);
> -		pthread_rwlock_unlock(&lock);
> +
> +		ret = pthread_rwlock_unlock(&lock);
> +		if (ret) {
> +			fprintf(stderr, "writer pthread_rwlock_unlock: %s\n", strerror(ret));
> +			abort();
> +		}
> +
> 		URCU_TLS(nr_writes)++;
> 		if (caa_unlikely(!test_duration_write()))
> 			break;
> @@ -321,6 +345,12 @@ int main(int argc, char **argv)
> 	printf_verbose("thread %-6s, tid %lu\n",
> 			"main", urcu_get_thread_id());
> 
> +	err = pthread_rwlock_init(&lock, NULL);
> +	if (err != 0) {
> +		fprintf(stderr, "pthread_rwlock_init: (%d) %s\n", err, strerror(err));
> +		exit(1);
> +	}
> +
> 	tid_reader = calloc(nr_readers, sizeof(*tid_reader));
> 	tid_writer = calloc(nr_writers, sizeof(*tid_writer));
> 	count_reader = calloc(nr_readers, sizeof(*count_reader));
> diff --git a/tests/benchmark/test_rwlock_timing.c
> b/tests/benchmark/test_rwlock_timing.c
> index a52da38..1e7863a 100644
> --- a/tests/benchmark/test_rwlock_timing.c
> +++ b/tests/benchmark/test_rwlock_timing.c
> @@ -42,7 +42,7 @@ struct test_array {
> 	int a;
> };
> 
> -pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
> +pthread_rwlock_t lock;
> 
> static struct test_array test_array = { 8 };
> 
> @@ -65,7 +65,7 @@ static caa_cycles_t
> __attribute__((aligned(CAA_CACHE_LINE_SIZE))) *writer_time;
> 
> void *thr_reader(void *arg)
> {
> -	int i, j;
> +	int i, j, ret;
> 	caa_cycles_t time1, time2;
> 
> 	printf("thread_begin %s, tid %lu\n",
> @@ -75,9 +75,15 @@ void *thr_reader(void *arg)
> 	time1 = caa_get_cycles();
> 	for (i = 0; i < OUTER_READ_LOOP; i++) {
> 		for (j = 0; j < INNER_READ_LOOP; j++) {
> -			pthread_rwlock_rdlock(&lock);
> +			ret = pthread_rwlock_rdlock(&lock);
> +			if (ret)
> +				fprintf(stderr, "reader pthread_rwlock_rdlock: %s\n", strerror(ret));
> +
> 			assert(test_array.a == 8);
> -			pthread_rwlock_unlock(&lock);
> +
> +			ret = pthread_rwlock_unlock(&lock);
> +			if (ret)
> +				fprintf(stderr, "reader pthread_rwlock_unlock: %s\n", strerror(ret));
> 		}
> 	}
> 	time2 = caa_get_cycles();
> @@ -93,7 +99,7 @@ void *thr_reader(void *arg)
> 
> void *thr_writer(void *arg)
> {
> -	int i, j;
> +	int i, j, ret;
> 	caa_cycles_t time1, time2;
> 
> 	printf("thread_begin %s, tid %lu\n",
> @@ -103,9 +109,16 @@ void *thr_writer(void *arg)
> 	for (i = 0; i < OUTER_WRITE_LOOP; i++) {
> 		for (j = 0; j < INNER_WRITE_LOOP; j++) {
> 			time1 = caa_get_cycles();
> -			pthread_rwlock_wrlock(&lock);
> +			ret = pthread_rwlock_wrlock(&lock);
> +			if (ret)
> +				fprintf(stderr, "writer pthread_rwlock_wrlock: %s\n", strerror(ret));
> +
> 			test_array.a = 8;
> -			pthread_rwlock_unlock(&lock);
> +
> +			ret = pthread_rwlock_unlock(&lock);
> +			if (ret)
> +				fprintf(stderr, "writer pthread_rwlock_unlock: %s\n", strerror(ret));
> +
> 			time2 = caa_get_cycles();
> 			writer_time[(unsigned long)arg] += time2 - time1;
> 			usleep(1);
> @@ -133,6 +146,12 @@ int main(int argc, char **argv)
> 	num_read = atoi(argv[1]);
> 	num_write = atoi(argv[2]);
> 
> +	err = pthread_rwlock_init(&lock, NULL);
> +	if (err != 0) {
> +		fprintf(stderr, "pthread_rwlock_init: (%d) %s\n", err, strerror(err));
> +		exit(1);
> +	}
> +
> 	reader_time = calloc(num_read, sizeof(*reader_time));
> 	writer_time = calloc(num_write, sizeof(*writer_time));
> 	tid_reader = calloc(num_read, sizeof(*tid_reader));
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
