From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add warning about default
	prefix	and library paths to README
Date: Wed, 15 May 2013 02:08:14 -0400
Message-ID: <20130515060814.GA16392__33417.4231546514$1368598125$gmane$org@Krystal>
References: <1368565886-20536-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcUsp-0001R8-K1
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 02:08:15 -0400
Content-Disposition: inline
In-Reply-To: <1368565886-20536-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, daniel.thibault@drdc-rddc.gc.ca
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Fixes #467
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  README | 5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/README b/README
> index 4b3053c..2a335ce 100644
> --- a/README
> +++ b/README
> @@ -52,6 +52,11 @@ INSTALLATION INSTRUCTIONS:
>    If compiling from the git repository, run ./bootstrap before running
>    the configure script, to generate it.
>  =

> +  Note that configure sets '/usr/local' as the default prefix for files =
it
> +  installs. However, this path is not part of most distributions' default
> +  library path which will cause builds depending on liblttng-ust to fail=
 unless
> +  '-L/usr/local/lib' is added to LDFLAGS. You may provide a custom prefi=
x to
> +  configure by using the --prefix switch.
>  =

>  USAGE:
>  =

> -- =

> 1.8.2.2
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
