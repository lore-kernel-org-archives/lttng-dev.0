From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools 7/9] epoll/poll compat: expose
 interruptible API
Date: Wed, 15 May 2019 11:18:03 -0400
Message-ID: <20190515151803.GA14986__19404.6483886027$1557933506$gmane$org@joraj-alpa>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
 <20190503135547.12968-8-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 453yqN5vNCz11pQ
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 11:18:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190503135547.12968-8-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, joraj@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

This patch does not apply.

Please rebase.

Cheers

On Fri, May 03, 2019 at 09:55:45AM -0400, Mathieu Desnoyers wrote:
> Some use of the epoll/poll wrapper require interruption
> by signals to make the poll call return -1, errno EINTR.
> Expose a new lttng_poll_wait_interruptible API for this
> purpose.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/common/compat/compat-epoll.c |  9 +++++----
>  src/common/compat/compat-poll.c  |  9 +++++----
>  src/common/compat/poll.h         | 12 ++++++++----
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
> index 6a781c7a..7108b717 100644
> --- a/src/common/compat/compat-epoll.c
> +++ b/src/common/compat/compat-epoll.c
> @@ -241,7 +241,7 @@ error:
>  /*
>   * Wait on epoll set. This is a blocking call of timeout value.
>   */
> -int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
> +int compat_epoll_wait(struct lttng_poll_event *events, int timeout, int interruptible)
>  {
>  	int ret;
>  	uint32_t new_size;
> @@ -273,10 +273,11 @@ int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
>  
>  	do {
>  		ret = epoll_wait(events->epfd, events->events, events->nb_fd, timeout);
> -	} while (ret == -1 && errno == EINTR);
> +	} while (!interruptible && ret == -1 && errno == EINTR);
>  	if (ret < 0) {
> -		/* At this point, every error is fatal */
> -		PERROR("epoll_wait");
> +		if (errno != EINTR) {
> +			PERROR("epoll_wait");
> +		}
>  		goto error;
>  	}
>  
> diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
> index b45b39dc..cdb6f8b5 100644
> --- a/src/common/compat/compat-poll.c
> +++ b/src/common/compat/compat-poll.c
> @@ -281,7 +281,7 @@ error:
>  /*
>   * Wait on poll() with timeout. Blocking call.
>   */
> -int compat_poll_wait(struct lttng_poll_event *events, int timeout)
> +int compat_poll_wait(struct lttng_poll_event *events, int timeout, int interruptible)
>  {
>  	int ret;
>  
> @@ -308,10 +308,11 @@ int compat_poll_wait(struct lttng_poll_event *events, int timeout)
>  
>  	do {
>  		ret = poll(events->wait.events, events->wait.nb_fd, timeout);
> -	} while (ret == -1 && errno == EINTR);
> +	} while (!interruptible && ret == -1 && errno == EINTR);
>  	if (ret < 0) {
> -		/* At this point, every error is fatal */
> -		PERROR("poll wait");
> +		if (errno != EINTR) {
> +			PERROR("poll wait");
> +		}
>  		goto error;
>  	}
>  
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index d4bd87f5..5400e5b1 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -152,9 +152,11 @@ static inline int compat_glibc_epoll_create(int size, int flags)
>   * Wait on epoll set with the number of fd registered to the lttng_poll_event
>   * data structure (events).
>   */
> -extern int compat_epoll_wait(struct lttng_poll_event *events, int timeout);
> +extern int compat_epoll_wait(struct lttng_poll_event *events, int timeout, int interruptible);
>  #define lttng_poll_wait(events, timeout) \
> -	compat_epoll_wait(events, timeout)
> +	compat_epoll_wait(events, timeout, 0)
> +#define lttng_poll_wait_interruptible(events, timeout) \
> +	compat_epoll_wait(events, timeout, 1)
>  
>  /*
>   * Add a fd to the epoll set and resize the epoll_event structure if needed.
> @@ -334,9 +336,11 @@ extern int compat_poll_create(struct lttng_poll_event *events, int size);
>   * Wait on poll(2) event with nb_fd registered to the lttng_poll_event data
>   * structure.
>   */
> -extern int compat_poll_wait(struct lttng_poll_event *events, int timeout);
> +extern int compat_poll_wait(struct lttng_poll_event *events, int timeout, int interruptible);
>  #define lttng_poll_wait(events, timeout) \
> -	compat_poll_wait(events, timeout)
> +	compat_poll_wait(events, timeout, 0)
> +#define lttng_poll_wait_interruptible(events, timeout) \
> +	compat_poll_wait(events, timeout, 1)
>  
>  /*
>   * Add the fd to the pollfd structure. Resize if needed.
> -- 
> 2.11.0
> 

-- 
Jonathan Rajotte-Julien
EfficiOS
