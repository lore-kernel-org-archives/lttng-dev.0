From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] fix: Re-add link to urcu-bp for
 _LGPL_SOURCE tests
Date: Tue, 5 Nov 2019 13:11:31 -0500
Message-ID: <20191105181131.GA1927__12242.9289900296$1572977514$gmane$org@gmail.com>
References: <20191105163024.5085-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 476yRD4JyTzsY6
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 13:11:36 -0500 (EST)
Received: by mail-qt1-f194.google.com with SMTP id o3so30578470qtj.8
 for <lttng-dev@lists.lttng.org>; Tue, 05 Nov 2019 10:11:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191105163024.5085-1-mjeanson@efficios.com>
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

On Tue, Nov 05, 2019 at 11:30:24AM -0500, Michael Jeanson wrote:
> Tests with tracepoints defined with _LGPL_SOURCE require to be
> explicitly linked against urcu-bp.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  tests/regression/ust/multi-session/Makefile.am      | 2 +-
>  tests/utils/testapp/gen-ust-events/Makefile.am      | 2 +-
>  tests/utils/testapp/gen-ust-nevents-str/Makefile.am | 2 +-
>  tests/utils/testapp/gen-ust-nevents/Makefile.am     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/tests/regression/ust/multi-session/Makefile.am b/tests/regre=
ssion/ust/multi-session/Makefile.am
> index 0d807a878..676c26f21 100644
> --- a/tests/regression/ust/multi-session/Makefile.am
> +++ b/tests/regression/ust/multi-session/Makefile.am
> @@ -2,7 +2,7 @@ AM_CFLAGS +=3D -I$(srcdir)
>  =

>  noinst_PROGRAMS =3D gen-nevents
>  gen_nevents_SOURCES =3D gen-nevents.c tp.c ust_gen_nevents.h
> -gen_nevents_LDADD =3D $(UST_LIBS) $(DL_LIBS)
> +gen_nevents_LDADD =3D $(UST_LIBS) -lurcu-bp $(DL_LIBS)
>  =

>  noinst_SCRIPTS =3D test_multi_session
>  EXTRA_DIST =3D test_multi_session
> diff --git a/tests/utils/testapp/gen-ust-events/Makefile.am b/tests/utils=
/testapp/gen-ust-events/Makefile.am
> index 38e620d75..8918fc80d 100644
> --- a/tests/utils/testapp/gen-ust-events/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-events/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(top_srcdir)/tests/utils -I$(srcdir) \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-events
>  gen_ust_events_SOURCES =3D gen-ust-events.c tp.c tp.h
> -gen_ust_events_LDADD =3D $(UST_LIBS) \
> +gen_ust_events_LDADD =3D $(UST_LIBS) -lurcu-bp \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am b/tests/=
utils/testapp/gen-ust-nevents-str/Makefile.am
> index 0e961b4c4..27cb9efa7 100644
> --- a/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-nevents-str/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(srcdir) -I$(top_srcdir)/tests/utils \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-nevents-str
>  gen_ust_nevents_str_SOURCES =3D gen-ust-nevents-str.c tp.c tp.h
> -gen_ust_nevents_str_LDADD =3D $(UST_LIBS) \
> +gen_ust_nevents_str_LDADD =3D $(UST_LIBS) -lurcu-bp \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> diff --git a/tests/utils/testapp/gen-ust-nevents/Makefile.am b/tests/util=
s/testapp/gen-ust-nevents/Makefile.am
> index c20910bd8..f85d35a13 100644
> --- a/tests/utils/testapp/gen-ust-nevents/Makefile.am
> +++ b/tests/utils/testapp/gen-ust-nevents/Makefile.am
> @@ -4,7 +4,7 @@ AM_CPPFLAGS +=3D -I$(srcdir) -I$(top_srcdir)/tests/utils \
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS =3D gen-ust-nevents
>  gen_ust_nevents_SOURCES =3D gen-ust-nevents.c tp.c tp.h
> -gen_ust_nevents_LDADD =3D $(UST_LIBS) \
> +gen_ust_nevents_LDADD =3D $(UST_LIBS) -lurcu-bp \
>  		$(top_builddir)/tests/utils/libtestutils.la \
>  		$(DL_LIBS)
>  endif
> -- =

> 2.17.1
> =
