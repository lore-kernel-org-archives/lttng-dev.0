From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Python bindings build
	fix.	Reflects SEEK_END API change.
Date: Wed, 16 Jan 2013 17:59:28 -0500
Message-ID: <20130116225928.GA16371__20581.7916933031$1358377206$gmane$org@Krystal>
References: <1358358781-26056-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TvbxB-0000jb-LX
	for lttng-dev@lists.lttng.org; Wed, 16 Jan 2013 17:59:29 -0500
Content-Disposition: inline
In-Reply-To: <1358358781-26056-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

merged into bindings/python

Thanks!

Mathieu

> ---
>  bindings/python/babeltrace.i.in | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> =

> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace=
.i.in
> index c8e4923..b693f02 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -245,8 +245,7 @@ struct bt_iter_pos *bt_iter_create_time_pos(struct bt=
_iter *iter, uint64_t times
>  %rename("SEEK_RESTORE") BT_SEEK_RESTORE;
>  %rename("SEEK_CUR") BT_SEEK_CUR;
>  %rename("SEEK_BEGIN") BT_SEEK_BEGIN;
> -%rename("SEEK_END") BT_SEEK_END;
> -
> +%rename("SEEK_LAST") BT_SEEK_LAST;
>  =

>  // This struct is taken from iterator.h
>  // All changes to the struct must also be made here
> @@ -256,7 +255,7 @@ struct bt_iter_pos {
>  		BT_SEEK_RESTORE,	/* uses u.restore */
>  		BT_SEEK_CUR,
>  		BT_SEEK_BEGIN,
> -		BT_SEEK_END,
> +		BT_SEEK_LAST
>  	} type;
>  	union {
>  		uint64_t seek_time;
> -- =

> 1.8.1.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
