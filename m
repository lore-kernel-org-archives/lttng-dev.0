From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Remove test runner script
Date: Wed, 27 Mar 2013 10:19:29 -0400
Message-ID: <20130327141929.GF6283__33257.9152579003$1364394017$gmane$org@Krystal>
References: <CA+jJMxsk-JcPROObmKEtH1J+p_ArxwhXHp0yYcg1Xsu6DGDrpw@mail.gmail.com>
	<1364359059-15307-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKrCM-0005Y5-UF
	for lttng-dev@lists.lttng.org; Wed, 27 Mar 2013 10:19:31 -0400
Content-Disposition: inline
In-Reply-To: <1364359059-15307-1-git-send-email-jeremie.galarneau@efficios.com>
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
> Deprecated by the use of Perl prove and test lists.

merged, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/Makefile.am |  2 +-
>  tests/README      |  4 ++--
>  tests/runtests    | 36 ------------------------------------
>  tests/test_loop   |  2 +-
>  4 files changed, 4 insertions(+), 40 deletions(-)
>  delete mode 100755 tests/runtests
> =

> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 6f9b969..425440a 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -4,7 +4,7 @@ if CXX_WORKS
>  SUBDIRS +=3D hello.cxx
>  endif
>  =

> -dist_noinst_SCRIPTS =3D test_loop runtests trace_matches
> +dist_noinst_SCRIPTS =3D test_loop run.sh trace_matches unit_tests
>  =

>  noinst_LIBRARIES =3D libtap.a
>  =

> diff --git a/tests/README b/tests/README
> index 1c920eb..5f1da32 100644
> --- a/tests/README
> +++ b/tests/README
> @@ -1,8 +1,8 @@
>  Using the ust test suite.
>  =

>  Running
> -	./runtests
> -runs all the tests once. The output is in TAP format.
> +	./run.sh unit_tests
> +runs all the tests once.
>  =

>  Running
>  	./test_loop
> diff --git a/tests/runtests b/tests/runtests
> deleted file mode 100755
> index 8f5c874..0000000
> --- a/tests/runtests
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/bash
> -#
> -# Copyright 2010 Ericsson AB
> -#
> -#    This file is part of LTTng-UST.
> -#
> -#    LTTng-UST is free software: you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation, either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    LTTng-UST is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License
> -#    along with LTTng-UST.  If not, see <http://www.gnu.org/licenses/>.
> -
> -
> -tests_failed=3D0
> -
> -TESTDIR=3D$(dirname $0)
> -
> -function simple_harness_run() {
> -    if ! "$TESTDIR/$@"; then
> -	let tests_failed=3D$tests_failed+1
> -    fi
> -}
> -
> -./${TEST_DIR}/snprintf/run
> -
> -# This testcase is currently broken, do not run.
> -# simple_harness_run tracepoint/run
> -
> -exit 0
> diff --git a/tests/test_loop b/tests/test_loop
> index 619b1e3..be3e16c 100755
> --- a/tests/test_loop
> +++ b/tests/test_loop
> @@ -3,7 +3,7 @@
>  DIR=3D$(dirname $0)
>  =

>  while [ 0 ]; do
> -	$DIR/runtests
> +	$DIR/run.sh $DIR/unit_tests
>  	if [ "$?" !=3D "0" ]; then
>  		break;
>  	fi
> -- =

> 1.8.2
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
