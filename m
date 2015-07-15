From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Ust getcpu override
	plugin
Date: Wed, 15 Jul 2015 14:57:20 -0400
Message-ID: <CA+jJMxvn4vE7A+6j77QDfRP=Xi-bcmjTxUsOyDpoYPFaPaH6Nw__15662.3085531921$1436986723$gmane$org@mail.gmail.com>
References: <1436910771-23117-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409659275=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZFRry-0007Wg-C2
 for lttng-dev@lists.lttng.org; Wed, 15 Jul 2015 14:57:29 -0400
Received: by pdbep18 with SMTP id ep18so30623742pdb.1
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 11:57:20 -0700 (PDT)
In-Reply-To: <1436910771-23117-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0409659275==
Content-Type: multipart/alternative; boundary=047d7bd754bc40faea051aee86c4

--047d7bd754bc40faea051aee86c4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, thanks!

J=C3=A9r=C3=A9mie

On Tue, Jul 14, 2015 at 5:52 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  configure.ac                                       |   1 +
>  tests/fast_regression                              |   1 +
>  tests/regression/ust/Makefile.am                   |   3 +-
>  tests/regression/ust/getcpu-override/Makefile.am   |  37 +++++
>  .../lttng-ust-getcpu-override-test.c               |  84 +++++++++++
>  .../ust/getcpu-override/run-getcpu-override        |  13 ++
>  .../ust/getcpu-override/test_getcpu_override       | 166
> +++++++++++++++++++++
>  7 files changed, 304 insertions(+), 1 deletion(-)
>  create mode 100644 tests/regression/ust/getcpu-override/Makefile.am
>  create mode 100644
> tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
>  create mode 100755
> tests/regression/ust/getcpu-override/run-getcpu-override
>  create mode 100755
> tests/regression/ust/getcpu-override/test_getcpu_override
>
> diff --git a/configure.ac b/configure.ac
> index 1fcac72..287e3d4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -529,6 +529,7 @@ AC_CONFIG_FILES([
>         tests/regression/ust/java-jul/Makefile
>         tests/regression/ust/java-log4j/Makefile
>         tests/regression/ust/python-logging/Makefile
> +       tests/regression/ust/getcpu-override/Makefile
>         tests/stress/Makefile
>         tests/unit/Makefile
>         tests/unit/ini_config/Makefile
> diff --git a/tests/fast_regression b/tests/fast_regression
> index c14f7f2..037054f 100644
> --- a/tests/fast_regression
> +++ b/tests/fast_regression
> @@ -22,6 +22,7 @@ regression/ust/overlap/test_overlap
>  regression/ust/java-jul/test_java_jul
>  regression/ust/java-log4j/test_java_log4j
>  regression/ust/python-logging/test_python_logging
> +regression/ust/getcpu-override/test_getcpu_override
>  regression/ust/test_event_basic
>  regression/ust/test_event_tracef
>  regression/ust/test_event_wildcard
> diff --git a/tests/regression/ust/Makefile.am
> b/tests/regression/ust/Makefile.am
> index 0d11f90..e3a04c0 100644
> --- a/tests/regression/ust/Makefile.am
> +++ b/tests/regression/ust/Makefile.am
> @@ -1,7 +1,8 @@
>  if HAVE_LIBLTTNG_UST_CTL
>  SUBDIRS =3D nprocesses high-throughput low-throughput before-after
> multi-session \
>                 overlap buffers-pid linking daemon exit-fast fork
> libc-wrapper \
> -               periodical-metadata-flush java-jul java-log4j
> python-logging
> +               periodical-metadata-flush java-jul java-log4j
> python-logging \
> +               getcpu-override
>
>  EXTRA_DIST =3D test_event_basic test_event_wildcard test_event_tracef
> test_event_perf
>
> diff --git a/tests/regression/ust/getcpu-override/Makefile.am
> b/tests/regression/ust/getcpu-override/Makefile.am
> new file mode 100644
> index 0000000..f1026ac
> --- /dev/null
> +++ b/tests/regression/ust/getcpu-override/Makefile.am
> @@ -0,0 +1,37 @@
> +AM_CPPFLAGS =3D -I$(srcdir)
> +
> +# The rpath is necessary because libtool won't build a shared library
> +# if it's noinst_
> +GETCPU_LIBTOOL_FLAGS =3D \
> +    -module \
> +    -shared \
> +    -avoid-version \
> +    --no-as-needed \
> +    -rpath $(abs_builddir)
> +
> +noinst_LTLIBRARIES =3D lttng-ust-getcpu-override-test.la
> +lttng_ust_getcpu_override_test_la_LDFLAGS =3D $(GETCPU_LIBTOOL_FLAGS)
> +
> +if LTTNG_TOOLS_BUILD_WITH_LIBDL
> +lttng_ust_getcpu_override_test_la_LIBADD =3D -ldl
> +endif
> +if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
> +lttng_ust_getcpu_override_test_la_LIBADD =3D -lc
> +endif
> +
> +noinst_SCRIPTS =3D test_getcpu_override run-getcpu-override
> +EXTRA_DIST =3D test_getcpu_override run-getcpu-override
> +
> +all-local:
> +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> +               for script in $(EXTRA_DIST); do \
> +                       cp -f $(srcdir)/$$script $(builddir); \
> +               done; \
> +       fi
> +
> +clean-local:
> +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> +               for script in $(EXTRA_DIST); do \
> +                       rm -f $(builddir)/$$script; \
> +               done; \
> +       fi
> diff --git
> a/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
> b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c
> new file mode 100644
> index 0000000..f098e2c
> --- /dev/null
> +++ b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test=
.c
> @@ -0,0 +1,84 @@
> +/*
> + * lttng-ust-getcpu-override-test.c
> + * Based on lttng-getcpu-override-example.c from LTTng-ust exemple
> + *
> + * Copyright (c) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (c) 2015 Jonathan Rajotte <
> jonathan.rajotte-julien@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> IN THE
> + * SOFTWARE.
> + */
> +
> +#include <stdlib.h>
> +#include <time.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <lttng/ust-getcpu.h>
> +
> +int plugin_getcpu(void)
> +{
> +       /* Generate a sequence based on the number of configurated
> processor
> +        * by using sequence[i] % nb_configured_processors. Where sequenc=
e
> +        * is a static random sequence.
> +        * The expected cpu_id sequence can be regenerated on the test
> script
> +        * side and compared to the extracted cpu sequence for validation=
.
> +        * This does no guarantee in absolute the validity of the getcpu
> +        * plugin but provide a strong argument of it's validity.
> +        */
> +       static int i =3D 0;
> +       static int seq_seed[256] =3D {100, 57, 232, 236, 42, 193, 224, 18=
4,
> 216, 150,
> +               92, 91, 108, 118, 55, 243, 65, 101, 209, 0, 147, 36, 29,
> 34, 49, 188,
> +               174, 105, 253, 245, 227, 238, 112, 20, 222, 201, 102, 175=
,
> 119, 19, 132,
> +               41, 78, 90, 114, 64, 138, 14, 48, 18, 162, 85, 204, 124,
> 133, 73, 172,
> +               106, 241, 126, 28, 104, 111, 21, 127, 219, 9, 244, 237,
> 189, 59, 214,
> +               52, 141, 107, 26, 25, 199, 3, 157, 117, 234, 33, 44, 46,
> 84, 69, 155,
> +               122, 250, 231, 86, 239, 76, 190, 120, 1, 94, 206, 8, 148,
> 159, 167, 215,
> +               164, 31, 217, 61, 71, 125, 68, 109, 195, 177, 95, 82, 142=
,
> 182, 129, 87,
> +               37, 140, 134, 186, 173, 39, 116, 143, 254, 229, 131, 67,
> 121, 192, 240,
> +               15, 221, 30, 242, 185, 80, 170, 135, 51, 187, 194, 246,
> 12, 225, 181,
> +               137, 211, 228, 88, 218, 27, 233, 161, 77, 252, 123, 93,
> 220, 248, 205,
> +               223, 144, 128, 196, 70, 247, 210, 178, 203, 154, 24, 169,
> 149, 163, 35,
> +               7, 151, 103, 197, 139, 165, 158, 207, 72, 113, 145, 45,
> 183, 11, 198,
> +               43, 81, 230, 97, 96, 2, 66, 213, 146, 179, 22, 58, 54, 38=
,
> 160, 200,
> +               235, 226, 156, 56, 208, 249, 32, 176, 168, 110, 191, 79,
> 152, 115, 10,
> +               74, 60, 251, 17, 83, 180, 171, 202, 40, 166, 255, 53, 212=
,
> 98, 5, 50,
> +               99, 4, 89, 13, 63, 6, 136, 153, 23, 16, 47, 130, 75, 62};
> +
> +       int ret;
> +       ret =3D seq_seed[i] % sysconf(_SC_NPROCESSORS_CONF);
> +       i++;
> +       i =3D i % 256;
> +       return ret;
> +}
> +
> +void lttng_ust_getcpu_plugin_init(void)
> +{
> +       int ret;
> +
> +       ret =3D lttng_ust_getcpu_override(plugin_getcpu);
> +       if (ret) {
> +               fprintf(stderr, "Error enabling getcpu override: %s\n",
> +                       strerror(-ret));
> +               goto error;
> +       }
> +       return;
> +
> +error:
> +       exit(EXIT_FAILURE);
> +}
> diff --git a/tests/regression/ust/getcpu-override/run-getcpu-override
> b/tests/regression/ust/getcpu-override/run-getcpu-override
> new file mode 100755
> index 0000000..2e5d82b
> --- /dev/null
> +++ b/tests/regression/ust/getcpu-override/run-getcpu-override
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +# launch with: run-getcpu-override progname args
> +DIR=3D$(dirname $0)
> +DIR=3D$(readlink -f $DIR)
> +
> +if [ -x "$DIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
> +
>  ret=3D`LTTNG_UST_GETCPU_PLUGIN=3D"$DIR/.libs/lttng-ust-getcpu-override-t=
est.so"
> $@`
> +       exit $ret
> +else
> +       echo "Getcpu-override missing shared object"
> +       exit $1
> +fi
> diff --git a/tests/regression/ust/getcpu-override/test_getcpu_override
> b/tests/regression/ust/getcpu-override/test_getcpu_override
> new file mode 100755
> index 0000000..2492c9c
> --- /dev/null
> +++ b/tests/regression/ust/getcpu-override/test_getcpu_override
> @@ -0,0 +1,166 @@
> +#!/bin/bash
> +#
> +# Copyright (C) - 2015 Jonathan Rajotte <
> jonathan.rajotte-julien@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify i=
t
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
> for more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public Licen=
se
> +# along with this library; if not, write to the Free Software Foundation=
,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +TEST_DESC=3D"UST - Getcpu override plugin"
> +
> +CURDIR=3D$(dirname $0)/
> +TESTDIR=3D$CURDIR/../../..
> +SESSION_NAME=3D"sequence-cpu"
> +
> +TESTAPP_PATH=3D"$TESTDIR/utils/testapp"
> +TESTAPP_NAME=3D"gen-ust-events"
> +TESTAPP_BIN=3D"$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME"
> +TESTAPP_WRAPPER=3D"run-getcpu-override"
> +NUM_EVENT=3D256
> +EVENT_NAME=3D"tp:tptest"
> +
> +NUM_TESTS=3D20
> +
> +SEQUENCE_SEED=3D(
> +100 57 232 236 42 193 224 184 216 150 92 91 108 118 55 243 65 101 209 0
> 147 36
> +29 34 49 188 174 105 253 245 227 238 112 20 222 201 102 175 119 19 132 4=
1
> 78 90
> +114 64 138 14 48 18 162 85 204 124 133 73 172 106 241 126 28 104 111 21
> 127 219
> +9 244 237 189 59 214 52 141 107 26 25 199 3 157 117 234 33 44 46 84 69
> 155 122
> +250 231 86 239 76 190 120 1 94 206 8 148 159 167 215 164 31 217 61 71 12=
5
> 68 109
> +195 177 95 82 142 182 129 87 37 140 134 186 173 39 116 143 254 229 131 6=
7
> 121
> +192 240 15 221 30 242 185 80 170 135 51 187 194 246 12 225 181 137 211
> 228 88
> +218 27 233 161 77 252 123 93 220 248 205 223 144 128 196 70 247 210 178
> 203 154
> +24 169 149 163 35 7 151 103 197 139 165 158 207 72 113 145 45 183 11 198
> 43 81
> +230 97 96 2 66 213 146 179 22 58 54 38 160 200 235 226 156 56 208 249 32
> 176 168
> +110 191 79 152 115 10 74 60 251 17 83 180 171 202 40 166 255 53 212 98 5
> 50 99 4
> +89 13 63 6 136 153 23 16 47 130 75 62
> +)
> +
> +# Equivalent to the syconf(_SC_NPROCESSORS_CONF) call.
> +NPROC=3D`nproc --all`
> +
> +source $TESTDIR/utils/utils.sh
> +
> +if [ ! -x "$CURDIR/.libs/lttng-ust-getcpu-override-test.so" ]; then
> +       BAIL_OUT "No shared object generated"
> +fi
> +
> +# MUST set TESTDIR before calling those functions
> +
> +run_app()
> +{
> +       diag "Launching app without getcpu-plugin wrapper"
> +       $TESTAPP_BIN $NUM_EVENT
> +       ok $? "Application without wrapper done"
> +}
> +
> +run_getcpu_plugin_app()
> +{
> +       diag "Launching app with getcpu-plugin wrapper"
> +       $CURDIR/$TESTAPP_WRAPPER $TESTAPP_BIN $NUM_EVENT
> +       ok $? "Application with wrapper done"
> +}
> +
> +compare_ok()
> +{
> +       compare 0 "$@"
> +}
> +
> +compare_fail()
> +{
> +       compare 1 "$@"
> +}
> +
> +compare()
> +{
> +       local expected_to_fail=3D$1
> +       declare -a array_to_compare=3D("${!2}")
> +       local valid=3D0
> +
> +       test ${#array_to_compare[*]} -eq ${#SEQUENCE_SEED[*]}
> +       ok $? "Sequence seed and cpuid sequence are equal
> ${#SEQUENCE_SEED[*]}/${#array_to_compare[*]}"
> +
> +       for (( i =3D 0; i < ${#SEQUENCE_SEED[*]}; i++ )); do
> +               if [ "${array_to_compare[$i]}" -ne "$((
> ${SEQUENCE_SEED[$i]} % $NPROC))" ]; then
> +                       valid=3D1
> +                       break
> +               fi
> +       done
> +
> +       if [[ $expected_to_fail -eq "1" ]]; then
> +               test $valid -ne "0"
> +               ok $? "Cpuid extraction and seed sequence comparison fail
> as expected"
> +       else
> +               ok $valid "Cpuid extraction and seed sequence comparison"
> +       fi
> +}
> +
> +test_getcpu_override()
> +{
> +       diag "Getcpu plugin"
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME"
> +       start_lttng_tracing_ok $SESSION_NAME
> +       run_app
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       # Move output to an array by using =3D($())
> +       cpuid_events=3D($($BABELTRACE_BIN $TRACE_PATH | sed -n 's/.*cpu_i=
d =3D
> \([0-9]*\).*/\1/p'))
> +       num_events=3D${#cpuid_events[*]}
> +       test $num_events -eq $NUM_EVENT
> +       ok $? "Extraction without getcpu plugin have
> $num_events/$NUM_EVENT"
> +       compare_fail cpuid_events[@]
> +
> +       create_lttng_session_ok $SESSION_NAME $TRACE_PATH
> +       enable_ust_lttng_event_ok $SESSION_NAME "$EVENT_NAME"
> +       start_lttng_tracing_ok $SESSION_NAME
> +       run_getcpu_plugin_app
> +       stop_lttng_tracing_ok $SESSION_NAME
> +       destroy_lttng_session_ok $SESSION_NAME
> +
> +       cpuid_events=3D($($BABELTRACE_BIN $TRACE_PATH | sed -n 's/.*cpu_i=
d =3D
> \([0-9]*\).*/\1/p'))
> +       num_events=3D${#cpuid_events[*]}
> +       test $num_events -eq $NUM_EVENT
> +       ok $? "Extraction without getcpu plugin have
> $num_events/$NUM_EVENT"
> +
> +       compare_ok cpuid_events[@]
> +
> +       return $?
> +}
> +
> +plan_tests $NUM_TESTS
> +
> +print_test_banner "$TEST_DESC"
> +
> +TESTS=3D(
> +       "test_getcpu_override"
> +)
> +
> +TEST_COUNT=3D${#TESTS[@]}
> +i=3D0
> +
> +start_lttng_sessiond
> +
> +while [ "$i" -lt "$TEST_COUNT" ]; do
> +
> +       TRACE_PATH=3D$(mktemp -d)
> +
> +       # Execute test
> +       ${TESTS[$i]}
> +
> +       rm -rf $TRACE_PATH
> +
> +       let "i++"
> +done
> +
> +stop_lttng_sessiond
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd754bc40faea051aee86c4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged in master, thanks!<div><br></div><div>J=C3=A9r=C3=
=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Tue, Jul 14, 2015 at 5:52 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jon=
athan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt=
;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0tests/fast_regression=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<=
br>
=C2=A0tests/regression/ust/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0tests/regression/ust/getcpu-override/Makefile.am=C2=A0 =C2=A0|=C2=A0 =
37 +++++<br>
=C2=A0.../lttng-ust-getcpu-override-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 84 +++++++++++<br>
=C2=A0.../ust/getcpu-override/run-getcpu-override=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 13 ++<br>
=C2=A0.../ust/getcpu-override/test_getcpu_override=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 166 +++++++++++++++++++++<br>
=C2=A07 files changed, 304 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 tests/regression/ust/getcpu-override/Makefile.am<b=
r>
=C2=A0create mode 100644 tests/regression/ust/getcpu-override/lttng-ust-get=
cpu-override-test.c<br>
=C2=A0create mode 100755 tests/regression/ust/getcpu-override/run-getcpu-ov=
erride<br>
=C2=A0create mode 100755 tests/regression/ust/getcpu-override/test_getcpu_o=
verride<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 1fcac72..287e3d4 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -529,6 +529,7 @@ AC_CONFIG_FILES([<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/regression/ust/java-jul/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/regression/ust/java-log4j/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/regression/ust/python-logging/Makefile<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/regression/ust/getcpu-override/Makefile<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/stress/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/unit/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/unit/ini_config/Makefile<br>
diff --git a/tests/fast_regression b/tests/fast_regression<br>
index c14f7f2..037054f 100644<br>
--- a/tests/fast_regression<br>
+++ b/tests/fast_regression<br>
@@ -22,6 +22,7 @@ regression/ust/overlap/test_overlap<br>
=C2=A0regression/ust/java-jul/test_java_jul<br>
=C2=A0regression/ust/java-log4j/test_java_log4j<br>
=C2=A0regression/ust/python-logging/test_python_logging<br>
+regression/ust/getcpu-override/test_getcpu_override<br>
=C2=A0regression/ust/test_event_basic<br>
=C2=A0regression/ust/test_event_tracef<br>
=C2=A0regression/ust/test_event_wildcard<br>
diff --git a/tests/regression/ust/Makefile.am b/tests/regression/ust/Makefi=
le.am<br>
index 0d11f90..e3a04c0 100644<br>
--- a/tests/regression/ust/Makefile.am<br>
+++ b/tests/regression/ust/Makefile.am<br>
@@ -1,7 +1,8 @@<br>
=C2=A0if HAVE_LIBLTTNG_UST_CTL<br>
=C2=A0SUBDIRS =3D nprocesses high-throughput low-throughput before-after mu=
lti-session \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 overlap buffers-pid=
 linking daemon exit-fast fork libc-wrapper \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0periodical-metadata=
-flush java-jul java-log4j python-logging<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0periodical-metadata=
-flush java-jul java-log4j python-logging \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0getcpu-override<br>
<br>
=C2=A0EXTRA_DIST =3D test_event_basic test_event_wildcard test_event_tracef=
 test_event_perf<br>
<br>
diff --git a/tests/regression/ust/getcpu-override/Makefile.am b/tests/regre=
ssion/ust/getcpu-override/Makefile.am<br>
new file mode 100644<br>
index 0000000..f1026ac<br>
--- /dev/null<br>
+++ b/tests/regression/ust/getcpu-override/Makefile.am<br>
@@ -0,0 +1,37 @@<br>
+AM_CPPFLAGS =3D -I$(srcdir)<br>
+<br>
+# The rpath is necessary because libtool won&#39;t build a shared library<=
br>
+# if it&#39;s noinst_<br>
+GETCPU_LIBTOOL_FLAGS =3D \<br>
+=C2=A0 =C2=A0 -module \<br>
+=C2=A0 =C2=A0 -shared \<br>
+=C2=A0 =C2=A0 -avoid-version \<br>
+=C2=A0 =C2=A0 --no-as-needed \<br>
+=C2=A0 =C2=A0 -rpath $(abs_builddir)<br>
+<br>
+noinst_LTLIBRARIES =3D <a href=3D"http://lttng-ust-getcpu-override-test.la=
" rel=3D"noreferrer" target=3D"_blank">lttng-ust-getcpu-override-test.la</a=
><br>
+lttng_ust_getcpu_override_test_la_LDFLAGS =3D $(GETCPU_LIBTOOL_FLAGS)<br>
+<br>
+if LTTNG_TOOLS_BUILD_WITH_LIBDL<br>
+lttng_ust_getcpu_override_test_la_LIBADD =3D -ldl<br>
+endif<br>
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL<br>
+lttng_ust_getcpu_override_test_la_LIBADD =3D -lc<br>
+endif<br>
+<br>
+noinst_SCRIPTS =3D test_getcpu_override run-getcpu-override<br>
+EXTRA_DIST =3D test_getcpu_override run-getcpu-override<br>
+<br>
+all-local:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$(buil=
ddir)&quot; ]; then \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in $(EXT=
RA_DIST); do \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cp -f $(srcdir)/$$script $(builddir); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+clean-local:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$(buil=
ddir)&quot; ]; then \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in $(EXT=
RA_DIST); do \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rm -f $(builddir)/$$script; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
diff --git a/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override=
-test.c b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-te=
st.c<br>
new file mode 100644<br>
index 0000000..f098e2c<br>
--- /dev/null<br>
+++ b/tests/regression/ust/getcpu-override/lttng-ust-getcpu-override-test.c=
<br>
@@ -0,0 +1,84 @@<br>
+/*<br>
+ * lttng-ust-getcpu-override-test.c<br>
+ * Based on lttng-getcpu-override-example.c from LTTng-ust exemple<br>
+ *<br>
+ * Copyright (c) 2014 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desn=
oyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
+ * Copyright (c) 2015 Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajo=
tte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE<br>
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<=
br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE<br>
+ * SOFTWARE.<br>
+ */<br>
+<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;time.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;lttng/ust-getcpu.h&gt;<br>
+<br>
+int plugin_getcpu(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Generate a sequence based on the number of c=
onfigurated processor<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * by using sequence[i] % nb_configured_process=
ors. Where sequence<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is a static random sequence.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The expected cpu_id sequence can be regenera=
ted on the test script<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * side and compared to the extracted cpu seque=
nce for validation.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This does no guarantee in absolute the valid=
ity of the getcpu<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * plugin but provide a strong argument of it&#=
39;s validity.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static int i =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static int seq_seed[256] =3D {100, 57, 232, 236=
, 42, 193, 224, 184, 216, 150,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A092, 91, 108, 118, 5=
5, 243, 65, 101, 209, 0, 147, 36, 29, 34, 49, 188,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0174, 105, 253, 245,=
 227, 238, 112, 20, 222, 201, 102, 175, 119, 19, 132,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A041, 78, 90, 114, 64=
, 138, 14, 48, 18, 162, 85, 204, 124, 133, 73, 172,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0106, 241, 126, 28, =
104, 111, 21, 127, 219, 9, 244, 237, 189, 59, 214,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A052, 141, 107, 26, 2=
5, 199, 3, 157, 117, 234, 33, 44, 46, 84, 69, 155,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0122, 250, 231, 86, =
239, 76, 190, 120, 1, 94, 206, 8, 148, 159, 167, 215,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0164, 31, 217, 61, 7=
1, 125, 68, 109, 195, 177, 95, 82, 142, 182, 129, 87,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A037, 140, 134, 186, =
173, 39, 116, 143, 254, 229, 131, 67, 121, 192, 240,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A015, 221, 30, 242, 1=
85, 80, 170, 135, 51, 187, 194, 246, 12, 225, 181,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0137, 211, 228, 88, =
218, 27, 233, 161, 77, 252, 123, 93, 220, 248, 205,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0223, 144, 128, 196,=
 70, 247, 210, 178, 203, 154, 24, 169, 149, 163, 35,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07, 151, 103, 197, 1=
39, 165, 158, 207, 72, 113, 145, 45, 183, 11, 198,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A043, 81, 230, 97, 96=
, 2, 66, 213, 146, 179, 22, 58, 54, 38, 160, 200,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0235, 226, 156, 56, =
208, 249, 32, 176, 168, 110, 191, 79, 152, 115, 10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A074, 60, 251, 17, 83=
, 180, 171, 202, 40, 166, 255, 53, 212, 98, 5, 50,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099, 4, 89, 13, 63, =
6, 136, 153, 23, 16, 47, 130, 75, 62};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D seq_seed[i] % sysconf(_SC_NPROCESSORS_C=
ONF);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D i % 256;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+void lttng_ust_getcpu_plugin_init(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D lttng_ust_getcpu_override(plugin_getcpu=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Error enabling getcpu override: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0strerror(-ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
+}<br>
diff --git a/tests/regression/ust/getcpu-override/run-getcpu-override b/tes=
ts/regression/ust/getcpu-override/run-getcpu-override<br>
new file mode 100755<br>
index 0000000..2e5d82b<br>
--- /dev/null<br>
+++ b/tests/regression/ust/getcpu-override/run-getcpu-override<br>
@@ -0,0 +1,13 @@<br>
+#!/bin/sh<br>
+<br>
+# launch with: run-getcpu-override progname args<br>
+DIR=3D$(dirname $0)<br>
+DIR=3D$(readlink -f $DIR)<br>
+<br>
+if [ -x &quot;$DIR/.libs/lttng-ust-getcpu-override-test.so&quot; ]; then<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret=3D`LTTNG_UST_GETCPU_PLUGIN=3D&quot;$DIR/.li=
bs/lttng-ust-getcpu-override-test.so&quot; $@`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit $ret<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Getcpu-override missing shared objec=
t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit $1<br>
+fi<br>
diff --git a/tests/regression/ust/getcpu-override/test_getcpu_override b/te=
sts/regression/ust/getcpu-override/test_getcpu_override<br>
new file mode 100755<br>
index 0000000..2492c9c<br>
--- /dev/null<br>
+++ b/tests/regression/ust/getcpu-override/test_getcpu_override<br>
@@ -0,0 +1,166 @@<br>
+#!/bin/bash<br>
+#<br>
+# Copyright (C) - 2015 Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.raj=
otte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
+#<br>
+# This library is free software; you can redistribute it and/or modify it =
under<br>
+# the terms of the GNU Lesser General Public License as published by the F=
ree<br>
+# Software Foundation; version 2.1 of the License.<br>
+#<br>
+# This library is distributed in the hope that it will be useful, but WITH=
OUT<br>
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FI=
TNESS<br>
+# FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU Lesser General Public Licens=
e for more<br>
+# details.<br>
+#<br>
+# You should have received a copy of the GNU Lesser General Public License=
<br>
+# along with this library; if not, write to the Free Software Foundation, =
Inc.,<br>
+# 51 Franklin Street, Fifth Floor, Boston, MA=C2=A0 02110-1301 USA<br>
+TEST_DESC=3D&quot;UST - Getcpu override plugin&quot;<br>
+<br>
+CURDIR=3D$(dirname $0)/<br>
+TESTDIR=3D$CURDIR/../../..<br>
+SESSION_NAME=3D&quot;sequence-cpu&quot;<br>
+<br>
+TESTAPP_PATH=3D&quot;$TESTDIR/utils/testapp&quot;<br>
+TESTAPP_NAME=3D&quot;gen-ust-events&quot;<br>
+TESTAPP_BIN=3D&quot;$TESTAPP_PATH/$TESTAPP_NAME/$TESTAPP_NAME&quot;<br>
+TESTAPP_WRAPPER=3D&quot;run-getcpu-override&quot;<br>
+NUM_EVENT=3D256<br>
+EVENT_NAME=3D&quot;tp:tptest&quot;<br>
+<br>
+NUM_TESTS=3D20<br>
+<br>
+SEQUENCE_SEED=3D(<br>
+100 57 232 236 42 193 224 184 216 150 92 91 108 118 55 243 65 101 209 0 14=
7 36<br>
+29 34 49 188 174 105 253 245 227 238 112 20 222 201 102 175 119 19 132 41 =
78 90<br>
+114 64 138 14 48 18 162 85 204 124 133 73 172 106 241 126 28 104 111 21 12=
7 219<br>
+9 244 237 189 59 214 52 141 107 26 25 199 3 157 117 234 33 44 46 84 69 155=
 122<br>
+250 231 86 239 76 190 120 1 94 206 8 148 159 167 215 164 31 217 61 71 125 =
68 109<br>
+195 177 95 82 142 182 129 87 37 140 134 186 173 39 116 143 254 229 131 67 =
121<br>
+192 240 15 221 30 242 185 80 170 135 51 187 194 246 12 225 181 137 211 228=
 88<br>
+218 27 233 161 77 252 123 93 220 248 205 223 144 128 196 70 247 210 178 20=
3 154<br>
+24 169 149 163 35 7 151 103 197 139 165 158 207 72 113 145 45 183 11 198 4=
3 81<br>
+230 97 96 2 66 213 146 179 22 58 54 38 160 200 235 226 156 56 208 249 32 1=
76 168<br>
+110 191 79 152 115 10 74 60 251 17 83 180 171 202 40 166 255 53 212 98 5 5=
0 99 4<br>
+89 13 63 6 136 153 23 16 47 130 75 62<br>
+)<br>
+<br>
+# Equivalent to the syconf(_SC_NPROCESSORS_CONF) call.<br>
+NPROC=3D`nproc --all`<br>
+<br>
+source $TESTDIR/utils/utils.sh<br>
+<br>
+if [ ! -x &quot;$CURDIR/.libs/lttng-ust-getcpu-override-test.so&quot; ]; t=
hen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0BAIL_OUT &quot;No shared object generated&quot;=
<br>
+fi<br>
+<br>
+# MUST set TESTDIR before calling those functions<br>
+<br>
+run_app()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Launching app without getcpu-plugin =
wrapper&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN $NUM_EVENT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Application without wrapper done&qu=
ot;<br>
+}<br>
+<br>
+run_getcpu_plugin_app()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Launching app with getcpu-plugin wra=
pper&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$CURDIR/$TESTAPP_WRAPPER $TESTAPP_BIN $NUM_EVEN=
T<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Application with wrapper done&quot;=
<br>
+}<br>
+<br>
+compare_ok()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compare 0 &quot;$@&quot;<br>
+}<br>
+<br>
+compare_fail()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compare 1 &quot;$@&quot;<br>
+}<br>
+<br>
+compare()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local expected_to_fail=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0declare -a array_to_compare=3D(&quot;${!2}&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local valid=3D0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test ${#array_to_compare[*]} -eq ${#SEQUENCE_SE=
ED[*]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Sequence seed and cpuid sequence ar=
e equal ${#SEQUENCE_SEED[*]}/${#array_to_compare[*]}&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (( i =3D 0; i &lt; ${#SEQUENCE_SEED[*]}; i+=
+ )); do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;${array_=
to_compare[$i]}&quot; -ne &quot;$(( ${SEQUENCE_SEED[$i]} % $NPROC))&quot; ]=
; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0valid=3D1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test $valid -ne &qu=
ot;0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Cpuid e=
xtraction and seed sequence comparison fail as expected&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ok $valid &quot;Cpu=
id extraction and seed sequence comparison&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+}<br>
+<br>
+test_getcpu_override()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Getcpu plugin&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_ust_lttng_event_ok $SESSION_NAME &quot;$=
EVENT_NAME&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Move output to an array by using =3D($())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cpuid_events=3D($($BABELTRACE_BIN $TRACE_PATH |=
 sed -n &#39;s/.*cpu_id =3D \([0-9]*\).*/\1/p&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_events=3D${#cpuid_events[*]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test $num_events -eq $NUM_EVENT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Extraction without getcpu plugin ha=
ve $num_events/$NUM_EVENT&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compare_fail cpuid_events[@]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_ust_lttng_event_ok $SESSION_NAME &quot;$=
EVENT_NAME&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_getcpu_plugin_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_tracing_ok $SESSION_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_lttng_session_ok $SESSION_NAME<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cpuid_events=3D($($BABELTRACE_BIN $TRACE_PATH |=
 sed -n &#39;s/.*cpu_id =3D \([0-9]*\).*/\1/p&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0num_events=3D${#cpuid_events[*]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test $num_events -eq $NUM_EVENT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Extraction without getcpu plugin ha=
ve $num_events/$NUM_EVENT&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0compare_ok cpuid_events[@]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return $?<br>
+}<br>
+<br>
+plan_tests $NUM_TESTS<br>
+<br>
+print_test_banner &quot;$TEST_DESC&quot;<br>
+<br>
+TESTS=3D(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;test_getcpu_override&quot;<br>
+)<br>
+<br>
+TEST_COUNT=3D${#TESTS[@]}<br>
+i=3D0<br>
+<br>
+start_lttng_sessiond<br>
+<br>
+while [ &quot;$i&quot; -lt &quot;$TEST_COUNT&quot; ]; do<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE_PATH=3D$(mktemp -d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Execute test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0${TESTS[$i]}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $TRACE_PATH<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0let &quot;i++&quot;<br>
+done<br>
+<br>
+stop_lttng_sessiond<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--047d7bd754bc40faea051aee86c4--


--===============0409659275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0409659275==--
