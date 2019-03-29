From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v3 1/2] Fix: Add POPT_CFLAGS to
 lttng_CFLAGS
Date: Fri, 29 Mar 2019 14:36:08 -0400
Message-ID: <20190329183607.GF28162__29235.7535612368$1553884592$gmane$org@gmail.com>
References: <20190222193338.7240-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 44W9Rc4NWdz1KcD
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:36:12 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id x12so3727696qts.7
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190222193338.7240-1-ylamarre@efficios.com>
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

The first patch was merged in master, stable-2.11, and stable-2.10.
The second patch was merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Fri, Feb 22, 2019 at 02:33:37PM -0500, Yannick Lamarre wrote:
> The generated makefile was ignoring POPT_CFLAGS when compiling
> lttng, but was adding POPT_LIBS to lttng_LDADD. With this commit,
> make now honors both settings for applications and tests.
> =

> Fixes: #1165
> =

> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/bin/lttng/Makefile.am                  | 2 ++
>  tests/regression/kernel/Makefile.am        | 2 +-
>  tests/regression/ust/multi-lib/Makefile.am | 8 ++++----
>  3 files changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> index b0e1247d..62ae0593 100644
> --- a/src/bin/lttng/Makefile.am
> +++ b/src/bin/lttng/Makefile.am
> @@ -28,6 +28,8 @@ lttng_SOURCES =3D command.h conf.c conf.h commands/star=
t.c \
>  				commands/disable_rotation.c \
>  				utils.c utils.h lttng.c
>  =

> +lttng_CFLAGS =3D $(AM_CFLAGS) $(POPT_CFLAGS)
> +
>  lttng_LDADD =3D $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
>  			$(top_builddir)/src/common/libcommon.la \
>  			$(top_builddir)/src/common/config/libconfig.la \
> diff --git a/tests/regression/kernel/Makefile.am b/tests/regression/kerne=
l/Makefile.am
> index a787e4fa..3ab6d75b 100644
> --- a/tests/regression/kernel/Makefile.am
> +++ b/tests/regression/kernel/Makefile.am
> @@ -7,7 +7,7 @@ EXTRA_DIST =3D test_event_basic test_all_events test_sysc=
all \
>  noinst_PROGRAMS =3D select_poll_epoll
>  select_poll_epoll_SOURCES =3D select_poll_epoll.c
>  select_poll_epoll_LDADD =3D $(POPT_LIBS)
> -select_poll_epoll_CFLAGS =3D -fno-stack-protector -D_FORTIFY_SOURCE=3D0 =
$(AM_CFLAGS)
> +select_poll_epoll_CFLAGS =3D $(POPT_CFLAGS) -fno-stack-protector -D_FORT=
IFY_SOURCE=3D0 $(AM_CFLAGS)
>  =

>  all-local:
>  	@if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> diff --git a/tests/regression/ust/multi-lib/Makefile.am b/tests/regressio=
n/ust/multi-lib/Makefile.am
> index 3fb4ae74..17ccf3e6 100644
> --- a/tests/regression/ust/multi-lib/Makefile.am
> +++ b/tests/regression/ust/multi-lib/Makefile.am
> @@ -3,13 +3,13 @@ EXTRA_DIST =3D test_multi_lib
>  noinst_PROGRAMS =3D exec-with-callsites exec-without-callsites
>  =

>  exec_with_callsites_SOURCES =3D multi-lib-test.c callsites.c
> -exec_with_callsites_LDFLAGS =3D -ldl -lpopt
> -exec_with_callsites_CFLAGS =3D $(AM_CFLAGS) -DHAS_CALLSITES=3D1
> +exec_with_callsites_LDFLAGS =3D -ldl $(POPT_LIBS)
> +exec_with_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSIT=
ES=3D1
>  =

>  exec_without_callsites_SOURCES =3D multi-lib-test.c
> -exec_without_callsites_LDFLAGS =3D -ldl -lpopt -llttng-ust
> +exec_without_callsites_LDFLAGS =3D -ldl $(POPT_LIBS) -llttng-ust
>  exec_without_callsites_LDADD =3D probes.o
> -exec_without_callsites_CFLAGS =3D $(AM_CFLAGS) -DHAS_CALLSITES=3D0
> +exec_without_callsites_CFLAGS =3D $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALL=
SITES=3D0
>  =

>  PROBES_SRC=3Dprobes.c probes.h
>  PROBES_LDF=3D-shared -module -llttng-ust -avoid-version -rpath $(abs_bui=
lddir)/.libs/
> -- =

> 2.11.0
> =
