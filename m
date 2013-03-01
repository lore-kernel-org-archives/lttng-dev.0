From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Ensure the specified
	input	format is CTF
Date: Thu, 28 Feb 2013 21:28:51 -0500
Message-ID: <20130301022851.GB3321__41640.1941948154$1362104973$gmane$org@Krystal>
References: <1362094212-27792-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UBFiO-0004b5-9N
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 21:28:52 -0500
Content-Disposition: inline
In-Reply-To: <1362094212-27792-1-git-send-email-jeremie.galarneau@efficios.com>
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
> Add a check to make sure the input trace format argument passed to the
> babeltrace converter is "ctf" as it is currently the only one supported.
> =

> Add a note to this effect in the man page.
> =

> Fixes #462

merged, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  converter/babeltrace.c | 2 +-
>  doc/babeltrace.1       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 20ded00..6847248 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -607,7 +607,7 @@ int main(int argc, char **argv)
>  		}
>  	}
>  	fmt_read =3D bt_lookup_format(g_quark_from_static_string(opt_input_form=
at));
> -	if (!fmt_read) {
> +	if (!fmt_read || fmt_read->name !=3D g_quark_from_static_string("ctf"))=
 {
>  		fprintf(stderr, "[error] Format \"%s\" is not supported.\n\n",
>  			opt_input_format);
>  		partial_error =3D 1;
> diff --git a/doc/babeltrace.1 b/doc/babeltrace.1
> index 3196299..78e9055 100644
> --- a/doc/babeltrace.1
> +++ b/doc/babeltrace.1
> @@ -29,7 +29,7 @@ Input trace FILE(s) or directory(ies)
>  Output trace path (default: stdout)
>  .TP
>  .BR "-i, --input-format FORMAT"
> -Input trace format (default: ctf)
> +Input trace format (default: ctf). CTF is currently the only supported i=
nput format.
>  .TP
>  .BR "-o, --output-format FORMAT"
>  Output trace format (default: text)
> -- =

> 1.8.1.4
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
