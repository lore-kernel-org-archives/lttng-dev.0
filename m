From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Move initialization of
 queue_pipe_fd after null check of handle
Date: Fri, 20 Sep 2019 17:32:03 -0400
Message-ID: <20190920213203.GD20024__48976.0387850524$1569015148$gmane$org@gmail.com>
References: <20190920150756.7959-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zn3r2MQpzqvP
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:32:08 -0400 (EDT)
Received: by mail-qk1-f196.google.com with SMTP id u186so8790052qkc.5
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:32:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920150756.7959-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11, but slightly modified to drop the
'const' qualifier and maintain the convention of declaring variables
at the earliest point in the scope.

Thanks!
J=E9r=E9mie

On Fri, Sep 20, 2019 at 11:07:55AM -0400, Jonathan Rajotte wrote:
> Fixes coverity #1399732
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/rotation-thread.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-ses=
siond/rotation-thread.c
> index 7bd6c6819..1ee3974f0 100644
> --- a/src/bin/lttng-sessiond/rotation-thread.c
> +++ b/src/bin/lttng-sessiond/rotation-thread.c
> @@ -832,8 +832,6 @@ void *thread_rotation(void *data)
>  	int ret;
>  	struct rotation_thread_handle *handle =3D data;
>  	struct rotation_thread thread;
> -	const int queue_pipe_fd =3D lttng_pipe_get_readfd(
> -			handle->rotation_timer_queue->event_pipe);
>  =

>  	DBG("[rotation-thread] Started rotation thread");
>  =

> @@ -842,6 +840,10 @@ void *thread_rotation(void *data)
>  		goto end;
>  	}
>  =

> +	/* Must be after null checking of handle for const assignment */
> +	const int queue_pipe_fd =3D lttng_pipe_get_readfd(
> +			handle->rotation_timer_queue->event_pipe);
> +
>  	rcu_register_thread();
>  	rcu_thread_online();
>  =

> -- =

> 2.17.1
> =
