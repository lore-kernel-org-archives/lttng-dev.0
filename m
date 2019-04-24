From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v4 2/8] Add Unit test to poll
 compatibility layer
Date: Wed, 24 Apr 2019 16:39:50 -0400
Message-ID: <20190424203948.GA3226__21005.5910678179$1556138413$gmane$org@gmail.com>
References: <20190401175925.8512-1-ylamarre@efficios.com>
 <20190401175925.8512-3-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44qByL75Bqz1Jw0
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 16:39:54 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id l17so2788691qtp.2
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 13:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190401175925.8512-3-ylamarre@efficios.com>
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

On Mon, Apr 01, 2019 at 01:59:19PM -0400, Yannick Lamarre wrote:
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  .gitignore                          |   1 +
>  tests/unit/Makefile.am              |   9 +-
>  tests/unit/test_utils_compat_poll.c | 236 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 245 insertions(+), 1 deletion(-)
>  create mode 100644 tests/unit/test_utils_compat_poll.c
> =

> diff --git a/.gitignore b/.gitignore
> index 19276012..b5d2a55a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -73,6 +73,7 @@ TAGS
>  /tests/unit/test_session
>  /tests/unit/test_uri
>  /tests/unit/test_ust_data
> +/tests/unit/test_utils_compat_poll
>  /tests/unit/test_utils_parse_size_suffix
>  /tests/unit/test_utils_parse_time_suffix
>  /tests/unit/test_utils_expand_path
> diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> index 5f485f00..bcda6a5c 100644
> --- a/tests/unit/Makefile.am
> +++ b/tests/unit/Makefile.am
> @@ -12,6 +12,7 @@ TESTS =3D test_kernel_data \
>  	test_utils_parse_size_suffix \
>  	test_utils_parse_time_suffix \
>  	test_utils_expand_path \
> +	test_utils_compat_poll \
>  	test_string_utils \
>  	test_notification \
>  	ini_config/test_ini_config
> @@ -28,7 +29,8 @@ LIBLTTNG_CTL=3D$(top_builddir)/src/lib/lttng-ctl/libltt=
ng-ctl.la
>  # Define test programs
>  noinst_PROGRAMS =3D test_uri test_session test_kernel_data \
>                    test_utils_parse_size_suffix test_utils_parse_time_suf=
fix \
> -                  test_utils_expand_path test_string_utils test_notifica=
tion
> +                  test_utils_expand_path test_utils_compat_poll \
> +		  test_string_utils test_notification

Use spaces to indent here.

>  =

>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS +=3D test_ust_data
> @@ -145,6 +147,11 @@ test_utils_parse_size_suffix_LDADD =3D $(LIBTAP) $(L=
IBHASHTABLE) $(LIBCOMMON) $(DL
>  test_utils_parse_time_suffix_SOURCES =3D test_utils_parse_time_suffix.c
>  test_utils_parse_time_suffix_LDADD =3D $(LIBTAP) $(LIBHASHTABLE) $(LIBCO=
MMON)
>  =

> +# compat_poll unit test
> +test_utils_compat_poll_SOURCES =3D test_utils_compat_poll.c
> +test_utils_compat_poll_LDADD  =3D $(LIBTAP) $(LIBHASHTABLE) $(DL_LIBS) \
> +		      $(top_builddir)/src/common/compat/libcompat.la $(LIBCOMMON)
> +
>  # expand_path unit test
>  test_utils_expand_path_SOURCES =3D test_utils_expand_path.c
>  test_utils_expand_path_LDADD =3D $(LIBTAP) $(LIBHASHTABLE) $(LIBCOMMON) =
$(DL_LIBS)
> diff --git a/tests/unit/test_utils_compat_poll.c b/tests/unit/test_utils_=
compat_poll.c
> new file mode 100644
> index 00000000..f2c49254
> --- /dev/null
> +++ b/tests/unit/test_utils_compat_poll.c
> @@ -0,0 +1,236 @@
> +/*
> + * test_utils_compat_poll.c
> + *
> + * Unit tests for the compatibility layer of poll/epoll API.
> + *
> + * Copyright (C) 2019 Yannick Lamarre <ylamarre@efficios.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by as
> + * published by the Free Software Foundation; only version 2 of the Lice=
nse.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License =
for
> + * more details.
> + */
> +
> +#include <assert.h>
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +#include <tap/tap.h>
> +
> +#include <common/compat/poll.h>
> +#include <common/readwrite.h>
> +
> +/* Verification without trashing test order in the child process */
> +#define childok(e, test, ...) do { \
> +	if (!(e)) { \
> +		diag(test, ## __VA_ARGS__); \
> +		_exit(EXIT_FAILURE); \
> +	} \
> +} while(0)
> +
> +/* For error.h */
> +int lttng_opt_quiet =3D 1;
> +int lttng_opt_verbose;
> +int lttng_opt_mi;
> +
> +#ifdef HAVE_EPOLL
> +#define NUM_TESTS 46
> +#else
> +#define NUM_TESTS 45
> +#endif
> +
> +#ifdef HAVE_EPOLL
> +#if defined(HAVE_EPOLL_CREATE1) && defined(EPOLL_CLOEXEC)
> +#define CLOE_VALUE EPOLL_CLOEXEC
> +#else
> +#define CLOE_VALUE FD_CLOEXEC
> +#endif
> +
> +/* Non-zero 8-bits arbitrary value below 0x7f to ensure no sign extension
> + * used to verify that the value is properly propagated throught the pip=
e.
> + */
> +#define MAGIC_VALUE ((char)0x5A)
> +
> +void test_epoll_compat(void)
> +{
> +	/*
> +	 * Type conversion present to disable warning of anonymous enum from
> +	 * compiler.
> +	 */
> +	ok((int)LTTNG_CLOEXEC =3D=3D (int)CLOE_VALUE, "epoll's CLOEXEC value");

Put a space between operators and operands (cast and value).

> +}
> +#endif
> +
> +void test_alloc(void)
> +{
> +	struct lttng_poll_event poll_events;
> +
> +	lttng_poll_init(&poll_events);
> +
> +	/* Null pointer */
> +	ok(lttng_poll_create(NULL, 1, 0) !=3D 0, "Create over NULL pointer fail=
s");
> +	/* Size 0 */
> +	ok(lttng_poll_create(&poll_events, 0, 0) !=3D 0, "Create with size 0 fa=
ils");
> +	/* without CLOEXEC */
> +	ok(lttng_poll_create(&poll_events, 1, 0) =3D=3D 0, "Create valid poll s=
et succeeds");
> +	/*
> +	 * lttng_poll_event structure untested due to incompatibility across
> +	 * sublayers. lttng_poll_clean cannot be tested. There is no success
> +	 * criteria. Verify set's max size cases.
> +	 */
> +	lttng_poll_clean(&poll_events);
> +}
> +
> +/* Tests stuff related to what would be handled with epoll_ctl. */
> +void test_add_del(void)
> +{
> +	struct lttng_poll_event poll_events;
> +
> +	lttng_poll_init(&poll_events);
> +	ok(lttng_poll_add(NULL, 1, LPOLLIN) !=3D 0, "Adding to NULL set fails");
> +	ok(lttng_poll_add(&poll_events, 1, LPOLLIN) !=3D 0, "Adding to uninitia=
lized structure fails");
> +	ok(lttng_poll_add(&poll_events, -1, LPOLLIN) !=3D 0, "Adding invalid FD=
 fails");
> +
> +	lttng_poll_create(&poll_events, 1, 0);
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 0, "Set created empty");
> +
> +	ok(lttng_poll_add(NULL, 1, LPOLLIN) !=3D 0, "Adding to NULL set fails");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 0, "Set still empty");
> +	ok(lttng_poll_add(&poll_events, -1, LPOLLIN) !=3D 0, "Adding invalid FD=
 fails");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 0, "Set still empty");
> +
> +	ok(lttng_poll_add(&poll_events, 1, LPOLLIN) =3D=3D 0, "Adding valid FD =
succeeds");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 1, "Nb of elements incremented=
");
> +
> +	ok(lttng_poll_del(NULL, 1) !=3D 0, "Removing from NULL set fails");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 1, "Number of FD in set unchan=
ged");
> +
> +	ok(lttng_poll_del(&poll_events, -1) !=3D 0, "Removing from negative FD =
fails");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 1, "Number of FD in set unchan=
ged");
> +
> +	ok(lttng_poll_del(&poll_events, 2) =3D=3D 0, "Removing invalid FD still=
 succeeds");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 1, "Number of elements unchang=
ed");
> +
> +	ok(lttng_poll_del(&poll_events, 1) =3D=3D 0, "Removing valid FD succeed=
s");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 0, "Nb of elements decremented=
");
> +
> +	ok(lttng_poll_del(&poll_events, 1) !=3D 0, "Removing from empty set fai=
ls");
> +	ok(LTTNG_POLL_GETNB(&poll_events) =3D=3D 0, "Nb of elements unchanged");
> +
> +	lttng_poll_clean(&poll_events);
> +}
> +
> +void test_mod_wait(void)
> +{
> +	struct lttng_poll_event poll_events;
> +	struct lttng_poll_event cpoll_events;
> +

Remove empty line here.

> +	int hupfd[2];
> +	int infd[2];
> +	pid_t cpid;
> +	char rbuf =3D 0, tbuf =3D MAGIC_VALUE;
> +	int wstatus;
> +
> +	lttng_poll_init(&poll_events);
> +	lttng_poll_init(&cpoll_events);
> +
> +	ok(pipe(hupfd) !=3D -1);
> +	ok(pipe(infd) !=3D -1);
> +
> +	cpid =3D fork();
> +	if (cpid =3D=3D 0) {
> +		childok(lttng_poll_create(&cpoll_events, 1, 0) =3D=3D 0, "Create valid=
 poll set succeeds");
> +		childok(lttng_poll_mod(NULL, infd[0], LPOLLIN) =3D=3D -1, "lttng_poll_=
mod with invalid input returns an error");
> +		childok(lttng_poll_mod(&cpoll_events, infd[0], LPOLLIN) =3D=3D -1, "lt=
tng_poll_mod with invalid input returns an error");
> +		childok(lttng_poll_add(&cpoll_events, infd[0], LPOLLHUP) =3D=3D 0, "Ad=
d valid FD succeeds");
> +		childok(lttng_poll_mod(&cpoll_events, -1, LPOLLIN) =3D=3D -1, "lttng_p=
oll_mod with invalid input returns an error");
> +		childok(lttng_poll_mod(&cpoll_events, hupfd[0], LPOLLIN) =3D=3D 0, "lt=
tng_poll_mod on unincluded FD goes on");
> +		childok(lttng_poll_mod(&cpoll_events, infd[0], LPOLLIN) =3D=3D 0, "Mod=
ify event type succeeds");
> +		childok(close(infd[1]) =3D=3D 0, "Close valid FD succeeds");
> +		childok(lttng_poll_wait(&cpoll_events, -1) =3D=3D 1, "Wait on close ti=
mes out");
> +		childok(lttng_read(infd[0], &rbuf, 1) =3D=3D 1, "Data is present in th=
e pipe");
> +		childok(rbuf =3D=3D MAGIC_VALUE, "Received data is consistent with tra=
nsmitted data");
> +		childok(lttng_poll_del(&cpoll_events, infd[0]) =3D=3D 0, "Removing val=
id FD succeeds");
> +		childok(close(infd[0]) =3D=3D 0, "Close valid FD succeeds");
> +		childok(close(hupfd[0]) =3D=3D 0, "Close valid FD succeeds");
> +		childok(close(hupfd[1]) =3D=3D 0, "Close valid FD succeeds");
> +		lttng_poll_clean(&cpoll_events);
> +		_exit(EXIT_SUCCESS);
> +	} else {
> +		ok(close(hupfd[1]) =3D=3D 0, "Close valid FD succeeds");
> +		ok(close(infd[0]) =3D=3D 0, "Close valid FD succeeds");
> +
> +		ok(lttng_poll_wait(NULL, -1) =3D=3D -1, "lttng_poll_wait call with inv=
alid input returns error");
> +
> +		ok(lttng_poll_create(&poll_events, 1, 0) =3D=3D 0, "Create valid poll =
set succeeds");
> +		ok(lttng_poll_wait(&poll_events, -1) =3D=3D -1, "lttng_poll_wait call =
with invalid input returns error");
> +		ok(lttng_poll_add(&poll_events, hupfd[0], LPOLLHUP) =3D=3D 0, "Add val=
id FD succeeds");
> +		ok(lttng_write(infd[1], &tbuf, 1) =3D=3D 1, "Write to pipe succeeds");
> +		ok(lttng_poll_wait(&poll_events, -1) =3D=3D 1, "Wakes up on one event"=
);
> +		ok(lttng_poll_del(&poll_events, hupfd[0]) =3D=3D 0, "Removing valid FD=
 succeeds");
> +		ok(close(hupfd[0]) =3D=3D 0, "Close valid FD succeeds");
> +		ok(close(infd[1]) =3D=3D 0, "Close valid FD succeeds");
> +		lttng_poll_clean(&poll_events);
> +
> +		ok(waitpid(cpid, &wstatus, 0) =3D=3D cpid, "waitpid returns child's pi=
d");
> +		ok(WIFEXITED(wstatus) =3D=3D 1, "Child process exited");
> +		ok(WEXITSTATUS(wstatus) =3D=3D (EXIT_SUCCESS & 0xff), "EXIT_SUCCESS is=
 %i while exit status is %i\n", EXIT_SUCCESS, WEXITSTATUS(wstatus));
> +	}
> +
> +}
> +
> +void test_func_def(void)
> +{
> +#ifdef LTTNG_POLL_GETFD
> +#define PASS_GETFD 1
> +#else
> +#define PASS_GETFD 0
> +#endif
> +
> +#ifdef LTTNG_POLL_GETEV
> +#define PASS_GETEV 1
> +#else
> +#define PASS_GETEV 0
> +#endif
> +
> +#ifdef LTTNG_POLL_GETSZ
> +#define PASS_GETSZ 1
> +#else
> +#define PASS_GETSZ 0
> +#endif
> +
> +#ifdef LTTNG_POLL_GET_PREV_FD
> +#define PASS_GET_PREV_FD 1
> +#else
> +#define PASS_GET_PREV_FD 0
> +#endif
> +
> +	ok(lttng_poll_reset =3D=3D lttng_poll_reset, "lttng_poll_reset is defin=
ed");
> +	ok(lttng_poll_init =3D=3D lttng_poll_init , "lttng_poll_reset is define=
d");

Replace 'reset' by 'init' in the test output.

> +	ok(PASS_GETFD, "GETFD is defined");
> +	ok(PASS_GETEV, "GETEV is defined");
> +	ok(PASS_GETSZ, "GETSZ is defined");
> +	ok(PASS_GET_PREV_FD, "GET_PREV_FD is defined");
> +

Remove empty line here.

Thanks!
J=E9r=E9mie

> +}
> +
> +int main(void)
> +{
> +	plan_tests(NUM_TESTS);
> +#ifdef HAVE_EPOLL
> +	test_epoll_compat();
> +#endif
> +	test_func_def();
> +	test_alloc();
> +	test_add_del();
> +	test_mod_wait();
> +	return exit_status();
> +}
> -- =

> 2.11.0
> =
