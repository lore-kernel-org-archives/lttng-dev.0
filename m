From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/3] epoll/poll compat: expose
 interruptible API
Date: Thu, 5 Sep 2019 16:57:16 -0400
Message-ID: <20190905205716.GB20141__43286.4163931058$1567717057$gmane$org@gmail.com>
References: <20190516190852.16946-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 46PY0c0b7LzsMq
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 16:57:19 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id g4so4565231qtq.7
 for <lttng-dev@lists.lttng.org>; Thu, 05 Sep 2019 13:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190516190852.16946-1-mathieu.desnoyers@efficios.com>
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

Series merged in master and stable-2.11.

Thanks,
J=E9r=E9mie

On Thu, May 16, 2019 at 03:08:50PM -0400, Mathieu Desnoyers wrote:
> Some use of the epoll/poll wrapper require interruption
> by signals to make the poll call return -1, errno EINTR.
> Expose a new lttng_poll_wait_interruptible API for this
> purpose.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/compat/compat-epoll.c |  9 +++++----
>  src/common/compat/compat-poll.c  |  9 +++++----
>  src/common/compat/poll.h         | 12 ++++++++----
>  3 files changed, 18 insertions(+), 12 deletions(-)
> =

> diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-=
epoll.c
> index 6a781c7a..7108b717 100644
> --- a/src/common/compat/compat-epoll.c
> +++ b/src/common/compat/compat-epoll.c
> @@ -241,7 +241,7 @@ error:
>  /*
>   * Wait on epoll set. This is a blocking call of timeout value.
>   */
> -int compat_epoll_wait(struct lttng_poll_event *events, int timeout)
> +int compat_epoll_wait(struct lttng_poll_event *events, int timeout, int =
interruptible)
>  {
>  	int ret;
>  	uint32_t new_size;
> @@ -273,10 +273,11 @@ int compat_epoll_wait(struct lttng_poll_event *even=
ts, int timeout)
>  =

>  	do {
>  		ret =3D epoll_wait(events->epfd, events->events, events->nb_fd, timeou=
t);
> -	} while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +	} while (!interruptible && ret =3D=3D -1 && errno =3D=3D EINTR);
>  	if (ret < 0) {
> -		/* At this point, every error is fatal */
> -		PERROR("epoll_wait");
> +		if (errno !=3D EINTR) {
> +			PERROR("epoll_wait");
> +		}
>  		goto error;
>  	}
>  =

> diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-p=
oll.c
> index 0220b278..dc507db5 100644
> --- a/src/common/compat/compat-poll.c
> +++ b/src/common/compat/compat-poll.c
> @@ -291,7 +291,7 @@ error:
>  /*
>   * Wait on poll() with timeout. Blocking call.
>   */
> -int compat_poll_wait(struct lttng_poll_event *events, int timeout)
> +int compat_poll_wait(struct lttng_poll_event *events, int timeout, int i=
nterruptible)
>  {
>  	int ret, active_fd_count;
>  	int idle_pfd_index =3D 0;
> @@ -320,10 +320,11 @@ int compat_poll_wait(struct lttng_poll_event *event=
s, int timeout)
>  =

>  	do {
>  		ret =3D poll(events->wait.events, events->wait.nb_fd, timeout);
> -	} while (ret =3D=3D -1 && errno =3D=3D EINTR);
> +	} while (!interruptible && ret =3D=3D -1 && errno =3D=3D EINTR);
>  	if (ret < 0) {
> -		/* At this point, every error is fatal */
> -		PERROR("poll wait");
> +		if (errno !=3D EINTR) {
> +			PERROR("poll wait");
> +		}
>  		goto error;
>  	}
>  =

> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index d7020f36..da7d6970 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -152,9 +152,11 @@ static inline int compat_glibc_epoll_create(int size=
, int flags)
>   * Wait on epoll set with the number of fd registered to the lttng_poll_=
event
>   * data structure (events).
>   */
> -extern int compat_epoll_wait(struct lttng_poll_event *events, int timeou=
t);
> +extern int compat_epoll_wait(struct lttng_poll_event *events, int timeou=
t, int interruptible);
>  #define lttng_poll_wait(events, timeout) \
> -	compat_epoll_wait(events, timeout)
> +	compat_epoll_wait(events, timeout, 0)
> +#define lttng_poll_wait_interruptible(events, timeout) \
> +	compat_epoll_wait(events, timeout, 1)
>  =

>  /*
>   * Add a fd to the epoll set and resize the epoll_event structure if nee=
ded.
> @@ -336,9 +338,11 @@ extern int compat_poll_create(struct lttng_poll_even=
t *events, int size);
>   * Wait on poll(2) event with nb_fd registered to the lttng_poll_event d=
ata
>   * structure.
>   */
> -extern int compat_poll_wait(struct lttng_poll_event *events, int timeout=
);
> +extern int compat_poll_wait(struct lttng_poll_event *events, int timeout=
, int interruptible);
>  #define lttng_poll_wait(events, timeout) \
> -	compat_poll_wait(events, timeout)
> +	compat_poll_wait(events, timeout, 0)
> +#define lttng_poll_wait_interruptible(events, timeout) \
> +	compat_poll_wait(events, timeout, 1)
>  =

>  /*
>   * Add the fd to the pollfd structure. Resize if needed.
> -- =

> 2.17.1
> =
