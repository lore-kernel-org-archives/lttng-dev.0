From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] fix: check for dtrace and sdt.h
 before enabling SDT uprobe tests
Date: Mon, 4 Nov 2019 22:30:21 -0500
Message-ID: <20191105033021.GA8933__33484.2603349657$1572924643$gmane$org@gmail.com>
References: <20191031201246.5944-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 476ZtT6kMzzrNs
 for <lttng-dev@lists.lttng.org>; Mon,  4 Nov 2019 22:30:25 -0500 (EST)
Received: by mail-qt1-f196.google.com with SMTP id o49so27367107qta.7
 for <lttng-dev@lists.lttng.org>; Mon, 04 Nov 2019 19:30:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191031201246.5944-1-mjeanson@efficios.com>
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

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Thu, Oct 31, 2019 at 04:12:46PM -0400, Michael Jeanson wrote:
> Add a configure switch '--enable-sdt-uprobe / --disable-sdt-uprobe', the
> default behavior of enabling the test if the requirements are found is
> kept but it's now possible to explicitly disable it.
> =

> Also add the detection of the dtrace binary and its override trough the
> DTRACE environment variable.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  configure.ac                                  | 37 +++++++++++++++++--
>  tests/utils/testapp/Makefile.am               |  4 +-
>  .../userspace-probe-sdt-binary/Makefile.am    |  8 +++-
>  3 files changed, 42 insertions(+), 7 deletions(-)
> =

> diff --git a/configure.ac b/configure.ac
> index 8c0683fe2..ab0a15b2d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -25,9 +25,6 @@ AC_PROG_CXX
>  RW_PROG_CXX_WORKS
>  AM_CONDITIONAL([CXX_WORKS], [test "x$rw_cv_prog_cxx_works" =3D "xyes"])
>  =

> -LTTNG_CHECK_SDT_WORKS
> -AM_CONDITIONAL([SDT_WORKS], [test "x$lttng_cv_sdt_works" =3D "xyes"])
> -
>  # Checks for programs.
>  AC_PROG_GREP
>  AC_PROG_MAKE_SET
> @@ -815,6 +812,36 @@ AC_SUBST([RUN_PYTHON_AGENT_TEST])
>  AC_SUBST([PYTHON2_AGENT])
>  AC_SUBST([PYTHON3_AGENT])
>  =

> +AC_ARG_ENABLE([test-sdt-uprobe],
> +  [AS_HELP_STRING([--enable-test-sdt-uprobe], [enable the LTTng UST SDT =
uprobe tests [default=3Dautodetect]])],
> +  [test_sdt_uprobe=3D"$enableval"],
> +  [test_sdt_uprobe=3Dautodetect]
> +)
> +
> +AS_IF([test "$test_sdt_uprobe" !=3D "no"], [
> +  LTTNG_CHECK_SDT_WORKS
> +  AC_PATH_PROG([DTRACE], [dtrace])
> +])
> +
> +AS_IF([test "$test_sdt_uprobe" =3D "yes"], [
> +  AS_IF([test "$lttng_cv_sdt_works" =3D "no"], [
> +    AC_MSG_ERROR([Cannot find 'sys/sdt.h'.])
> +  ])
> +  AS_IF([test "x$DTRACE" =3D "x"], [
> +    AC_MSG_ERROR([Cannot find SystemTap dtrace. You can set the DTRACE v=
ariable to override automatic detection.])
> +  ])
> +])
> +
> +AS_IF([test "$test_sdt_uprobe" =3D "autodetect"], [
> +  AS_IF([test "$lttng_cv_sdt_works" =3D "yes"], [
> +    AS_IF([test "x$DTRACE" !=3D "x"], [
> +      test_sdt_uprobe=3Dyes
> +    ])
> +  ])
> +])
> +
> +AM_CONDITIONAL([TEST_SDT_UPROBE], [test "$test_sdt_uprobe" =3D "yes"])
> +
>  # Arguments for binaries build exclusion
>  AC_ARG_ENABLE([bin-lttng], AS_HELP_STRING([--disable-bin-lttng],[Disable=
 the build of lttng binaries]))
>  AC_ARG_ENABLE([bin-lttng-consumerd], AS_HELP_STRING([--disable-bin-lttng=
-consumerd],
> @@ -1243,6 +1270,10 @@ PPRINT_PROP_BOOL([LTTng-UST Python2 agent tests], =
$value)
>  test ! -z "$PYTHON3_AGENT" && value=3D1 || value=3D0
>  PPRINT_PROP_BOOL([LTTng-UST Python3 agent tests], $value)
>  =

> +# LTTng UST Java agent Log4j tests enabled/disabled
> +test "x$test_sdt_uprobe" =3D "xyes" && value=3D1 || value=3D0
> +PPRINT_PROP_BOOL([LTTng-UST SDT uprobe tests], $value)
> +
>  #Python binding enabled/disabled
>  test "x$enable_python_binding" =3D xyes && value=3D1 || value=3D0
>  AS_ECHO
> diff --git a/tests/utils/testapp/Makefile.am b/tests/utils/testapp/Makefi=
le.am
> index 2a4cf5c7b..e2ad1f235 100644
> --- a/tests/utils/testapp/Makefile.am
> +++ b/tests/utils/testapp/Makefile.am
> @@ -12,9 +12,9 @@ if CXX_WORKS
>  SUBDIRS +=3D userspace-probe-elf-cxx-binary
>  endif # CXX_WORKS
>  =

> -if SDT_WORKS
> +if TEST_SDT_UPROBE
>  SUBDIRS +=3D userspace-probe-sdt-binary
> -endif # SDT_WORKS
> +endif # TEST_SDT_UPROBE
>  =

>  if HAVE_MODULES_USERSPACE_CALLSTACK_CONTEXT
>  SUBDIRS +=3D gen-syscall-events-callstack
> diff --git a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am b=
/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
> index d79ce0ea3..591f4aa6c 100644
> --- a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
> +++ b/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
> @@ -26,10 +26,14 @@ libzzz_la_CFLAGS =3D -I$(abs_builddir)
>  libzzz_la_LDFLAGS =3D -module -shared -avoid-version -rpath $(abs_buildd=
ir)/.libs/
>  nodist_libzzz_la_SOURCES =3D $(abs_builddir)/foobar_provider.h
>  =

> +dtrace_verbose =3D $(dtrace_verbose_@AM_V@)
> +dtrace_verbose_ =3D $(dtrace_verbose_@AM_DEFAULT_V@)
> +dtrace_verbose_0 =3D @echo "  DTRACE  " $@;
> +
>  foobar_provider.h: foobar_provider.d
> -	dtrace -s $< -o $@ -h
> +	$(dtrace_verbose)$(DTRACE) -s $< -o $@ -h
>  =

>  foobar_provider.o: foobar_provider.d
> -	dtrace -s $< -o $@ -G
> +	$(dtrace_verbose)$(DTRACE) -s $< -o $@ -G
>  =

>  CLEANFILES =3D foobar_provider.h
> -- =

> 2.17.1
> =
