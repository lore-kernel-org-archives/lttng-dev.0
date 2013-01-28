From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Added a null pointer
	check	to bt_ctf_field_name.
Date: Mon, 28 Jan 2013 11:09:50 -0500
Message-ID: <20130128160950.GA23309__2146.02768323875$1359389437$gmane$org@Krystal>
References: <1359369367-12876-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TzrHL-0000gs-Vv
	for lttng-dev@lists.lttng.org; Mon, 28 Jan 2013 11:09:52 -0500
Content-Disposition: inline
In-Reply-To: <1359369367-12876-1-git-send-email-jeremie.galarneau@efficios.com>
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
> This function is called indirectly when calling __repr__ (print) in the p=
ython
> bindings on the definition object returned by the get_top_level_scope met=
hod
> thus resulting in a segmentation fault when the name attribute is not set.

merged into master and python bindings branches, thanks!

Mathieu

> =

> Fixes #373
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  formats/ctf/events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/formats/ctf/events.c b/formats/ctf/events.c
> index ac7dce4..182d0de 100644
> --- a/formats/ctf/events.c
> +++ b/formats/ctf/events.c
> @@ -168,7 +168,7 @@ const char *bt_ctf_event_name(const struct bt_ctf_eve=
nt *ctf_event)
>  =

>  const char *bt_ctf_field_name(const struct definition *def)
>  {
> -	if (!def)
> +	if (!def || !def->name)
>  		return NULL;
>  =

>  	return rem_(g_quark_to_string(def->name));
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
