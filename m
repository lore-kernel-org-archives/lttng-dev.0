From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Remove unnused
	function	bt_trace_handle_get_id
Date: Wed, 26 Jun 2013 13:33:27 -0400
Message-ID: <20130626173327.GA32627__22514.6023360596$1372268043$gmane$org@Krystal>
References: <1372267657-1956-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Urtay-0006Zj-VY
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 13:33:29 -0400
Content-Disposition: inline
In-Reply-To: <1372267657-1956-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> This function was removed from trace-handle.h as part of commit
> e3d12cf93f067601df4179ef4b7e2a30aa0065f7 which changed the trace-handle A=
PI to
> use handle_ids instead of pointers to a struct bt_trace_handle.

Merged, with "unnused" -> unused. ;-)

Thanks,

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  lib/trace-handle.c | 8 --------
>  1 file changed, 8 deletions(-)
> =

> diff --git a/lib/trace-handle.c b/lib/trace-handle.c
> index 455e440..d5b906a 100644
> --- a/lib/trace-handle.c
> +++ b/lib/trace-handle.c
> @@ -52,14 +52,6 @@ void bt_trace_handle_destroy(struct bt_trace_handle *t=
h)
>  	g_free(th);
>  }
>  =

> -int bt_trace_handle_get_id(struct bt_trace_handle *th)
> -{
> -	if (!th)
> -		return -1;
> -
> -	return th->id;
> -}
> -
>  const char *bt_trace_handle_get_path(struct bt_context *ctx, int handle_=
id)
>  {
>  	struct bt_trace_handle *handle;
> -- =

> 1.8.3.1
> =


-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
