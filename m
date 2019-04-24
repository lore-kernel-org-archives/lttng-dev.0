From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v4 6/8] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Wed, 24 Apr 2019 17:08:53 -0400
Message-ID: <20190424210852.GB4486__41609.9961077393$1556140152$gmane$org@gmail.com>
References: <20190401175925.8512-1-ylamarre@efficios.com>
 <20190401175925.8512-7-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 44qCbs1nSrz1Jxh
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 17:08:57 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id l17so2886215qtp.2
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 14:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190401175925.8512-7-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On Mon, Apr 01, 2019 at 01:59:23PM -0400, Yannick Lamarre wrote:
> This removes the need to verify for idle file descriptors and mitigates
> risks of bug due to behaviour mismatch.
> =

> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> =

> The assert in the for loop is removed.
> =

>  src/common/compat/compat-poll.c | 37 +++++++++++++++++++++++++++++++++--=
--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> =

> diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-p=
oll.c
> index be655728..5b752a28 100644
> --- a/src/common/compat/compat-poll.c
> +++ b/src/common/compat/compat-poll.c
> @@ -293,7 +293,8 @@ error:
>   */
>  int compat_poll_wait(struct lttng_poll_event *events, int timeout)
>  {
> -	int ret;
> +	int ret, active_fd_count;
> +	int idle_pfd_index =3D 0;
>  =

>  	if (events =3D=3D NULL || events->current.events =3D=3D NULL) {
>  		ERR("poll wait arguments error");
> @@ -325,11 +326,39 @@ int compat_poll_wait(struct lttng_poll_event *event=
s, int timeout)
>  		goto error;
>  	}
>  =

> +	active_fd_count =3D ret;
> +
>  	/*
> -	 * poll() should always iterate on all FDs since we handle the pollset =
in
> -	 * user space and after poll returns, we have to try every fd for a mat=
ch.
> +	 * Swap all active pollfd structs to the beginning of the
> +	 * array to emulate compat-epoll behaviour. This algorithm takes
> +	 * advantage of poll's returned value and the burst nature of active
> +	 * events on the file descriptors. The while loop guarantees that
> +	 * idle_pfd will always point to an idle fd.
>  	 */
> -	return events->wait.nb_fd;
> +	if (active_fd_count =3D=3D events->wait.nb_fd) {
> +		goto end;
> +	}
> +	while (idle_pfd_index < active_fd_count &&
> +			events->wait.events[idle_pfd_index].revents !=3D 0) {
> +		idle_pfd_index++;
> +	}
> +
> +	for (int i =3D idle_pfd_index + 1; idle_pfd_index < active_fd_count;
> +			i++) {

Declare 'i' at the beginning of the function.

Thanks!
J=E9r=E9mie

> +		struct pollfd swap_pfd;
> +		struct pollfd *idle_pfd =3D &events->wait.events[idle_pfd_index];
> +		struct pollfd *current_pfd =3D &events->wait.events[i];
> +
> +		if (ipfd->revents !=3D 0) {
> +			swap_pfd =3D *current_pfd;
> +			*current_pfd =3D *idle_pfd;
> +			*idle_pfd =3D swap_pfd;
> +			idle_pfd_index++;
> +		}
> +	}
> +
> +end:
> +	return ret;
>  =

>  error:
>  	return -1;
> -- =

> 2.11.0
> =
