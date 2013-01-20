From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 3/3] Fix: Removed Python	bindings
	to static constructor and destructor.
Date: Sun, 20 Jan 2013 12:59:47 -0500
Message-ID: <20130120175947.GA19512__11605.5476516069$1358704841$gmane$org@Krystal>
References: <1358527534-16401-1-git-send-email-jeremie.galarneau@efficios.com>
	<1358527534-16401-3-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TwzBN-0001HC-9y
	for lttng-dev@lists.lttng.org; Sun, 20 Jan 2013 12:59:49 -0500
Content-Disposition: inline
In-Reply-To: <1358527534-16401-3-git-send-email-jeremie.galarneau@efficios.com>
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
> Resolves an undefined symbol on Python module load.

All 3 patches merged, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  bindings/python/babeltrace.i.in | 3 ---
>  1 file changed, 3 deletions(-)
> =

> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace=
.i.in
> index d45afb0..dd49ba5 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -194,9 +194,6 @@ extern struct format *bt_lookup_format(bt_intern_str =
qname);
>  extern void bt_fprintf_format_list(FILE *fp);
>  extern int bt_register_format(struct format *format);
>  =

> -void format_init(void);
> -void format_finalize(void);
> -
>  %pythoncode %{
>  =

>  def print_format_list(babeltrace_file):
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
