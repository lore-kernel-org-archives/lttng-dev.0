From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] fix: Use DL_LIBS variable in
 ust multi-lib test
Date: Tue, 5 Nov 2019 01:18:43 -0500
Message-ID: <20191105061843.GA315567__31948.121897743$1572934743$gmane$org@gmail.com>
References: <20191024153633.17551-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 476fcl4NCdzrcX
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 01:18:47 -0500 (EST)
Received: by mail-qt1-f196.google.com with SMTP id y10so21052036qto.3
 for <lttng-dev@lists.lttng.org>; Mon, 04 Nov 2019 22:18:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191024153633.17551-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master.

Thanks!
J=E9r=E9mie

On Thu, Oct 24, 2019 at 11:36:33AM -0400, Michael Jeanson wrote:
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  tests/regression/ust/multi-lib/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/tests/regression/ust/multi-lib/Makefile.am b/tests/regressio=
n/ust/multi-lib/Makefile.am
> index 0ce46a7ff..52a1635c2 100644
> --- a/tests/regression/ust/multi-lib/Makefile.am
> +++ b/tests/regression/ust/multi-lib/Makefile.am
> @@ -3,11 +3,11 @@ EXTRA_DIST =3D test_multi_lib
>  noinst_PROGRAMS =3D exec-with-callsites exec-without-callsites
>  =

>  exec_with_callsites_SOURCES =3D multi-lib-test.c callsites.c
> -exec_with_callsites_LDFLAGS =3D -ldl $(POPT_LIBS)
> +exec_with_callsites_LDFLAGS =3D $(DL_LIBS) $(POPT_LIBS)
>  exec_with_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSIT=
ES=3D1
>  =

>  exec_without_callsites_SOURCES =3D multi-lib-test.c
> -exec_without_callsites_LDFLAGS =3D -ldl $(POPT_LIBS) $(UST_LIBS)
> +exec_without_callsites_LDFLAGS =3D $(DL_LIBS) $(POPT_LIBS) $(UST_LIBS)
>  exec_without_callsites_LDADD =3D probes.o
>  exec_without_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALL=
SITES=3D0
>  =

> -- =

> 2.17.1
> =
