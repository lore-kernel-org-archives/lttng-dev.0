From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Python agent: update
 after Python agent refactoring
Date: Mon, 3 Aug 2015 15:32:06 -0400
Message-ID: <CA+jJMxsvag=4gWq2R-hs1TLfSkJavf-3HQLH+Oqr+0UYRcBRCg__39742.6036805429$1438630402$gmane$org@mail.gmail.com>
References: <1427847007-29752-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0115860980=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZMLT2-0001VV-Q0
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 15:32:16 -0400
Received: by ykoo205 with SMTP id o205so29243045yko.0
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2015 12:32:07 -0700 (PDT)
In-Reply-To: <1427847007-29752-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0115860980==
Content-Type: multipart/alternative; boundary=001a1139cf22944c3e051c6d3994

--001a1139cf22944c3e051c6d3994
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Tue, Mar 31, 2015 at 8:10 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> This patch makes the tests follow the recent refactoring
> of the LTTng-UST Python agent.
>
> You need both python2 and python3 in your $PATH to run this
> test now (since the agent is compatible with both versions
> of Python).
>
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  tests/regression/ust/python-logging/LTTngTest.py   | 76
> ----------------------
>  tests/regression/ust/python-logging/test.py        | 71
> ++++++++++++++++++++
>  .../ust/python-logging/test_python_logging         | 76
> ++++++++++++----------
>  3 files changed, 112 insertions(+), 111 deletions(-)
>  delete mode 100644 tests/regression/ust/python-logging/LTTngTest.py
>  create mode 100644 tests/regression/ust/python-logging/test.py
>
> diff --git a/tests/regression/ust/python-logging/LTTngTest.py
> b/tests/regression/ust/python-logging/LTTngTest.py
> deleted file mode 100644
> index a3ed8f9..0000000
> --- a/tests/regression/ust/python-logging/LTTngTest.py
> +++ /dev/null
> @@ -1,76 +0,0 @@
> -#!/usr/bin/env python
> -#
> -# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
> -#
> -# This library is free software; you can redistribute it and/or modify i=
t
> under
> -# the terms of the GNU Lesser General Public License as published by the
> Free
> -# Software Foundation; version 2.1 of the License.
> -#
> -# This library is distributed in the hope that it will be useful, but
> WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> -# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
> for more
> -# details.
> -#
> -# You should have received a copy of the GNU Lesser General Public Licen=
se
> -# along with this library; if not, write to the Free Software Foundation=
,
> Inc.,
> -# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> -
> -import sys
> -import logging
> -import errno
> -
> -from time import sleep
> -
> -def cleanup(code, agent =3D None):
> -    """
> -    Cleanup agent and exit with given code.
> -    """
> -    if agent is not None:
> -        agent.destroy()
> -
> -    sys.exit(code)
> -
> -try:
> -    import lttng_agent
> -except ImportError as e:
> -    print("LTTng Agent not found. Aborting")
> -    cleanup(errno.ENOSYS)
> -
> -def run():
> -    """
> -    Main for this test program. Based on the Java testing program that
> behaves
> -    exactly the same.
> -    """
> -
> -    agent =3D lttng_agent.LTTngAgent()
> -    ev1 =3D logging.getLogger("python-ev-test1");
> -    ev2 =3D logging.getLogger("python-ev-test2");
> -
> -    try:
> -        nr_iter =3D int(sys.argv[1])
> -        wait_time =3D int(sys.argv[2])
> -        fire_debug_ev =3D 0
> -        fire_second_ev =3D 0
> -    except IndexError as e:
> -        print("Missing arguments. Aborting")
> -        cleanup(errno.EINVAL, agent)
> -    except ValueError as e:
> -        print("Invalid arguments. Aborting")
> -        cleanup(errno.EINVAL, agent)
> -
> -    if len(sys.argv) > 3:
> -        fire_debug_ev =3D int(sys.argv[3])
> -    if len(sys.argv) > 4:
> -        fire_second_ev =3D int(sys.argv[4])
> -
> -    for i in range(0, nr_iter):
> -        ev1.info("%s fired" % ev1.name)
> -        if fire_debug_ev !=3D 0:
> -            ev1.debug("%s DEBUG fired" % ev1.name)
> -        sleep(wait_time)
> -
> -    if fire_second_ev !=3D 0:
> -        ev2.info("%s fired" % ev2.name)
> -
> -if __name__ =3D=3D "__main__":
> -    run()
> diff --git a/tests/regression/ust/python-logging/test.py
> b/tests/regression/ust/python-logging/test.py
> new file mode 100644
> index 0000000..d08e623
> --- /dev/null
> +++ b/tests/regression/ust/python-logging/test.py
> @@ -0,0 +1,71 @@
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
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
> +
> +from __future__ import unicode_literals, print_function
> +import logging
> +import time
> +import sys
> +
> +
> +def _perror(msg):
> +    print(msg, file=3Dsys.stderr)
> +    sys.exit(1)
> +
> +
> +try:
> +    import lttngust
> +except (ImportError) as e:
> +    _perror('lttngust package not found: {}'.format(e))
> +
> +
> +def _main():
> +    ev1 =3D logging.getLogger('python-ev-test1');
> +    ev2 =3D logging.getLogger('python-ev-test2');
> +
> +    logging.basicConfig()
> +
> +    try:
> +        nr_iter =3D int(sys.argv[1])
> +        wait_time =3D float(sys.argv[2])
> +        fire_debug_ev =3D False
> +        fire_second_ev =3D False
> +    except (IndexError) as e:
> +        _perror('missing arguments: {}'.format(e))
> +    except (ValueError) as e:
> +        _perror('invalid arguments: {}'.format(e))
> +
> +    try:
> +        if len(sys.argv) > 3:
> +            fire_debug_ev =3D int(sys.argv[3])
> +        if len(sys.argv) > 4:
> +            fire_second_ev =3D int(sys.argv[4])
> +    except (ValueError) as e:
> +        _perror('invalid arguments: {}'.format(e))
> +
> +    for i in range(nr_iter):
> +        ev1.info('{} fired [INFO]'.format(ev1.name))
> +
> +        if fire_debug_ev:
> +            ev1.debug('{} fired [DEBUG]'.format(ev1.name))
> +
> +        time.sleep(wait_time)
> +
> +    if fire_second_ev:
> +        ev2.info('{} fired [INFO]'.format(ev2.name))
> +
> +
> +if __name__ =3D=3D '__main__':
> +    _main()
> diff --git a/tests/regression/ust/python-logging/test_python_logging
> b/tests/regression/ust/python-logging/test_python_logging
> index cb960da..4c2a3c6 100755
> --- a/tests/regression/ust/python-logging/test_python_logging
> +++ b/tests/regression/ust/python-logging/test_python_logging
> @@ -1,5 +1,6 @@
>  #!/bin/bash
>  #
> +# Copyright (C) - 2015 Philippe Proulx <pproulx@efficios.com>
>  # Copyright (C) - 2014 David Goulet <dgoulet@efficios.com>
>  #
>  # This program is free software; you can redistribute it and/or modify i=
t
> under
> @@ -15,13 +16,13 @@
>  # this program; if not, write to the Free Software Foundation, Inc., 51
>  # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>
> -TEST_DESC=3D"Java Python support"
> +TEST_DESC=3D"Python support"
>
>  CURDIR=3D$(dirname $0)/
>  TESTDIR=3D$CURDIR/../../..
>  NR_ITER=3D5
>  NR_SEC_WAIT=3D1
> -TESTAPP_NAME=3D"LTTngTest"
> +TESTAPP_NAME=3D"test"
>  TESTAPP_BIN=3D"$TESTAPP_NAME.py"
>  TESTAPP_PATH=3D"$CURDIR"
>  SESSION_NAME=3D"python-test"
> @@ -29,16 +30,17 @@ EVENT_NAME=3D"python-ev-test1"
>  EVENT_NAME2=3D"python-ev-test2"
>  OUTPUT_DEST=3D"/dev/null"
>
> -NUM_TESTS=3D156
> +NUM_TESTS=3D310
>
>  source $TESTDIR/utils/utils.sh
>
>  function run_app
>  {
> -       local debug_tp=3D$1
> -       local fire_second_tp=3D$2
> +       local python=3D$1
> +       local debug_tp=3D$2
> +       local fire_second_tp=3D$3
>
> -       python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_tp
> $fire_second_tp
> +       $python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_t=
p
> $fire_second_tp
>  }
>
>  function run_app_background
> @@ -94,7 +96,7 @@ function test_python_before_start ()
>         enable_python_lttng_event $SESSION_NAME $EVENT_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app_background
> +       run_app_background $1
>
>         start_lttng_tracing $SESSION_NAME
>
> @@ -120,7 +122,7 @@ function test_python_after_start ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app
> +       run_app $1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -141,7 +143,7 @@ function test_python_loglevel ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app
> +       run_app $1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -159,7 +161,7 @@ function test_python_loglevel ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app
> +       run_app $1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -177,7 +179,7 @@ function test_python_loglevel ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app
> +       run_app $1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -197,7 +199,7 @@ function test_python_loglevel_multiple ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire two TP.
> -       run_app 1
> +       run_app $1 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -214,7 +216,7 @@ function test_python_loglevel_multiple ()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire two TP.
> -       run_app 1
> +       run_app $1 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -239,7 +241,7 @@ function test_python_multi_session_loglevel()
>         start_lttng_tracing $SESSION_NAME-2
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 1 1
> +       run_app $1 1 1
>
>         stop_lttng_tracing $SESSION_NAME-1
>         stop_lttng_tracing $SESSION_NAME-2
> @@ -278,7 +280,7 @@ function test_python_multi_session_disable()
>         start_lttng_tracing $SESSION_NAME-2
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME-1
>         stop_lttng_tracing $SESSION_NAME-2
> @@ -313,7 +315,7 @@ function test_python_multi_session_disable_wildcard()
>         start_lttng_tracing $SESSION_NAME-1
>         start_lttng_tracing $SESSION_NAME-2
>
> -       run_app
> +       run_app $1
>
>         stop_lttng_tracing $SESSION_NAME-1
>         stop_lttng_tracing $SESSION_NAME-2
> @@ -346,7 +348,7 @@ function test_python_disable_all()
>
>         start_lttng_tracing $SESSION_NAME
>
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -372,7 +374,7 @@ function test_python_multi_session()
>         start_lttng_tracing $SESSION_NAME-2
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME-1
>         stop_lttng_tracing $SESSION_NAME-2
> @@ -401,7 +403,7 @@ function test_python_destroy_session()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app_background 0 1
> +       run_app_background $1 0 1
>
>         # Wait for the applications started in background
>         wait
> @@ -420,7 +422,7 @@ function test_python_destroy_session()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay
> -       run_app_background 0 1
> +       run_app_background $1 0 1
>
>         # Wait for the applications started in background
>         wait
> @@ -441,11 +443,11 @@ function test_python_filtering()
>
>         create_lttng_session $SESSION_NAME $TRACE_PATH/$SESSION_NAME
>         # Enable all event with a filter.
> -       enable_python_filter $SESSION_NAME '*' 'msg =3D=3D "python-ev-tes=
t2
> fired"'
> +       enable_python_filter $SESSION_NAME '*' 'msg =3D=3D "python-ev-tes=
t2
> fired [INFO]"'
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -459,11 +461,11 @@ function test_python_filtering()
>         create_lttng_session $SESSION_NAME $TRACE_PATH/$SESSION_NAME
>         # Enable first Logger but filter msg payload for the INFO one whi=
le
>         # triggering the debug and second TP.
> -       enable_python_filter $SESSION_NAME $EVENT_NAME 'msg =3D=3D
> "python-ev-test1 fired"'
> +       enable_python_filter $SESSION_NAME $EVENT_NAME 'msg =3D=3D
> "python-ev-test1 fired [INFO]"'
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay, fire debug and second TP.
> -       run_app 1 1
> +       run_app $1 1 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -487,7 +489,7 @@ function test_python_disable()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -511,7 +513,7 @@ function test_python_disable_enable()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -539,7 +541,7 @@ function test_python_filter_loglevel()
>         start_lttng_tracing $SESSION_NAME
>
>         # Run 5 times with a 1 second delay and fire second TP.
> -       run_app 0 1
> +       run_app $1 0 1
>
>         stop_lttng_tracing $SESSION_NAME
>         destroy_lttng_session $SESSION_NAME
> @@ -582,15 +584,19 @@ skip $withapp "Python support is needed. Skipping
> all tests." $NUM_TESTS ||
>                 test_python_filter_loglevel
>         )
>
> -       for fct_test in ${tests[@]};
> +       for python_version in 2 3;
>         do
> -               TRACE_PATH=3D$(mktemp -d)
> -
> -               ${fct_test}
> -               if [ $? -ne 0 ]; then
> -                       break;
> -               fi
> -               rm -rf $TRACE_PATH
> +               for fct_test in ${tests[@]};
> +               do
> +                       TRACE_PATH=3D$(mktemp -d)
> +
> +                       diag "(Python $python_version)"
> +                       ${fct_test} python$python_version
> +                       if [ $? -ne 0 ]; then
> +                               break;
> +                       fi
> +                       rm -rf $TRACE_PATH
> +               done
>         done
>
>         stop_lttng_sessiond
> --
> 2.3.0
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1139cf22944c3e051c6d3994
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Mar=
 31, 2015 at 8:10 PM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mail=
to:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">This patch makes the tes=
ts follow the recent refactoring<br>
of the LTTng-UST Python agent.<br>
<br>
You need both python2 and python3 in your $PATH to run this<br>
test now (since the agent is compatible with both versions<br>
of Python).<br>
<br>
Signed-off-by: Philippe Proulx &lt;<a href=3D"mailto:eeppeliteloop@gmail.co=
m">eeppeliteloop@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/regression/ust/python-logging/LTTngTest.py=C2=A0 =C2=A0| 76 ---=
-------------------<br>
=C2=A0tests/regression/ust/python-logging/test.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 71 ++++++++++++++++++++<br>
=C2=A0.../ust/python-logging/test_python_logging=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 76 ++++++++++++----------<br>
=C2=A03 files changed, 112 insertions(+), 111 deletions(-)<br>
=C2=A0delete mode 100644 tests/regression/ust/python-logging/LTTngTest.py<b=
r>
=C2=A0create mode 100644 tests/regression/ust/python-logging/test.py<br>
<br>
diff --git a/tests/regression/ust/python-logging/LTTngTest.py b/tests/regre=
ssion/ust/python-logging/LTTngTest.py<br>
deleted file mode 100644<br>
index a3ed8f9..0000000<br>
--- a/tests/regression/ust/python-logging/LTTngTest.py<br>
+++ /dev/null<br>
@@ -1,76 +0,0 @@<br>
-#!/usr/bin/env python<br>
-#<br>
-# Copyright (C) 2014 - David Goulet &lt;<a href=3D"mailto:dgoulet@efficios=
.com">dgoulet@efficios.com</a>&gt;<br>
-#<br>
-# This library is free software; you can redistribute it and/or modify it =
under<br>
-# the terms of the GNU Lesser General Public License as published by the F=
ree<br>
-# Software Foundation; version 2.1 of the License.<br>
-#<br>
-# This library is distributed in the hope that it will be useful, but WITH=
OUT<br>
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FI=
TNESS<br>
-# FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU Lesser General Public Licens=
e for more<br>
-# details.<br>
-#<br>
-# You should have received a copy of the GNU Lesser General Public License=
<br>
-# along with this library; if not, write to the Free Software Foundation, =
Inc.,<br>
-# 51 Franklin Street, Fifth Floor, Boston, MA=C2=A0 02110-1301 USA<br>
-<br>
-import sys<br>
-import logging<br>
-import errno<br>
-<br>
-from time import sleep<br>
-<br>
-def cleanup(code, agent =3D None):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 Cleanup agent and exit with given code.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 if agent is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 agent.destroy()<br>
-<br>
-=C2=A0 =C2=A0 sys.exit(code)<br>
-<br>
-try:<br>
-=C2=A0 =C2=A0 import lttng_agent<br>
-except ImportError as e:<br>
-=C2=A0 =C2=A0 print(&quot;LTTng Agent not found. Aborting&quot;)<br>
-=C2=A0 =C2=A0 cleanup(errno.ENOSYS)<br>
-<br>
-def run():<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 Main for this test program. Based on the Java testing progra=
m that behaves<br>
-=C2=A0 =C2=A0 exactly the same.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 agent =3D lttng_agent.LTTngAgent()<br>
-=C2=A0 =C2=A0 ev1 =3D logging.getLogger(&quot;python-ev-test1&quot;);<br>
-=C2=A0 =C2=A0 ev2 =3D logging.getLogger(&quot;python-ev-test2&quot;);<br>
-<br>
-=C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_iter =3D int(sys.argv[1])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_time =3D int(sys.argv[2])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_debug_ev =3D 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_second_ev =3D 0<br>
-=C2=A0 =C2=A0 except IndexError as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Missing arguments. Aborting&quot;)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cleanup(errno.EINVAL, agent)<br>
-=C2=A0 =C2=A0 except ValueError as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Invalid arguments. Aborting&quot;)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cleanup(errno.EINVAL, agent)<br>
-<br>
-=C2=A0 =C2=A0 if len(sys.argv) &gt; 3:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_debug_ev =3D int(sys.argv[3])<br>
-=C2=A0 =C2=A0 if len(sys.argv) &gt; 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_second_ev =3D int(sys.argv[4])<br>
-<br>
-=C2=A0 =C2=A0 for i in range(0, nr_iter):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://ev1.info" rel=3D"noreferrer"=
 target=3D"_blank">ev1.info</a>(&quot;%s fired&quot; % <a href=3D"http://ev=
1.name" rel=3D"noreferrer" target=3D"_blank">ev1.name</a>)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if fire_debug_ev !=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ev1.debug(&quot;%s DEBUG fired&q=
uot; % <a href=3D"http://ev1.name" rel=3D"noreferrer" target=3D"_blank">ev1=
.name</a>)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(wait_time)<br>
-<br>
-=C2=A0 =C2=A0 if fire_second_ev !=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://ev2.info" rel=3D"noreferrer"=
 target=3D"_blank">ev2.info</a>(&quot;%s fired&quot; % <a href=3D"http://ev=
2.name" rel=3D"noreferrer" target=3D"_blank">ev2.name</a>)<br>
-<br>
-if __name__ =3D=3D &quot;__main__&quot;:<br>
-=C2=A0 =C2=A0 run()<br>
diff --git a/tests/regression/ust/python-logging/test.py b/tests/regression=
/ust/python-logging/test.py<br>
new file mode 100644<br>
index 0000000..d08e623<br>
--- /dev/null<br>
+++ b/tests/regression/ust/python-logging/test.py<br>
@@ -0,0 +1,71 @@<br>
+# Copyright (C) 2015 - Philippe Proulx &lt;<a href=3D"mailto:pproulx@effic=
ios.com">pproulx@efficios.com</a>&gt;<br>
+# Copyright (C) 2014 - David Goulet &lt;<a href=3D"mailto:dgoulet@efficios=
.com">dgoulet@efficios.com</a>&gt;<br>
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
+<br>
+from __future__ import unicode_literals, print_function<br>
+import logging<br>
+import time<br>
+import sys<br>
+<br>
+<br>
+def _perror(msg):<br>
+=C2=A0 =C2=A0 print(msg, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 sys.exit(1)<br>
+<br>
+<br>
+try:<br>
+=C2=A0 =C2=A0 import lttngust<br>
+except (ImportError) as e:<br>
+=C2=A0 =C2=A0 _perror(&#39;lttngust package not found: {}&#39;.format(e))<=
br>
+<br>
+<br>
+def _main():<br>
+=C2=A0 =C2=A0 ev1 =3D logging.getLogger(&#39;python-ev-test1&#39;);<br>
+=C2=A0 =C2=A0 ev2 =3D logging.getLogger(&#39;python-ev-test2&#39;);<br>
+<br>
+=C2=A0 =C2=A0 logging.basicConfig()<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nr_iter =3D int(sys.argv[1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_time =3D float(sys.argv[2])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_debug_ev =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_second_ev =3D False<br>
+=C2=A0 =C2=A0 except (IndexError) as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _perror(&#39;missing arguments: {}&#39;.format=
(e))<br>
+=C2=A0 =C2=A0 except (ValueError) as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _perror(&#39;invalid arguments: {}&#39;.format=
(e))<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(sys.argv) &gt; 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_debug_ev =3D int(sys.argv[3=
])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(sys.argv) &gt; 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fire_second_ev =3D int(sys.argv[=
4])<br>
+=C2=A0 =C2=A0 except (ValueError) as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _perror(&#39;invalid arguments: {}&#39;.format=
(e))<br>
+<br>
+=C2=A0 =C2=A0 for i in range(nr_iter):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://ev1.info" rel=3D"noreferrer"=
 target=3D"_blank">ev1.info</a>(&#39;{} fired [INFO]&#39;.format(<a href=3D=
"http://ev1.name" rel=3D"noreferrer" target=3D"_blank">ev1.name</a>))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if fire_debug_ev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ev1.debug(&#39;{} fired [DEBUG]&=
#39;.format(<a href=3D"http://ev1.name" rel=3D"noreferrer" target=3D"_blank=
">ev1.name</a>))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(wait_time)<br>
+<br>
+=C2=A0 =C2=A0 if fire_second_ev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://ev2.info" rel=3D"noreferrer"=
 target=3D"_blank">ev2.info</a>(&#39;{} fired [INFO]&#39;.format(<a href=3D=
"http://ev2.name" rel=3D"noreferrer" target=3D"_blank">ev2.name</a>))<br>
+<br>
+<br>
+if __name__ =3D=3D &#39;__main__&#39;:<br>
+=C2=A0 =C2=A0 _main()<br>
diff --git a/tests/regression/ust/python-logging/test_python_logging b/test=
s/regression/ust/python-logging/test_python_logging<br>
index cb960da..4c2a3c6 100755<br>
--- a/tests/regression/ust/python-logging/test_python_logging<br>
+++ b/tests/regression/ust/python-logging/test_python_logging<br>
@@ -1,5 +1,6 @@<br>
=C2=A0#!/bin/bash<br>
=C2=A0#<br>
+# Copyright (C) - 2015 Philippe Proulx &lt;<a href=3D"mailto:pproulx@effic=
ios.com">pproulx@efficios.com</a>&gt;<br>
=C2=A0# Copyright (C) - 2014 David Goulet &lt;<a href=3D"mailto:dgoulet@eff=
icios.com">dgoulet@efficios.com</a>&gt;<br>
=C2=A0#<br>
=C2=A0# This program is free software; you can redistribute it and/or modif=
y it under<br>
@@ -15,13 +16,13 @@<br>
=C2=A0# this program; if not, write to the Free Software Foundation, Inc., =
51<br>
=C2=A0# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
<br>
-TEST_DESC=3D&quot;Java Python support&quot;<br>
+TEST_DESC=3D&quot;Python support&quot;<br>
<br>
=C2=A0CURDIR=3D$(dirname $0)/<br>
=C2=A0TESTDIR=3D$CURDIR/../../..<br>
=C2=A0NR_ITER=3D5<br>
=C2=A0NR_SEC_WAIT=3D1<br>
-TESTAPP_NAME=3D&quot;LTTngTest&quot;<br>
+TESTAPP_NAME=3D&quot;test&quot;<br>
=C2=A0TESTAPP_BIN=3D&quot;$TESTAPP_NAME.py&quot;<br>
=C2=A0TESTAPP_PATH=3D&quot;$CURDIR&quot;<br>
=C2=A0SESSION_NAME=3D&quot;python-test&quot;<br>
@@ -29,16 +30,17 @@ EVENT_NAME=3D&quot;python-ev-test1&quot;<br>
=C2=A0EVENT_NAME2=3D&quot;python-ev-test2&quot;<br>
=C2=A0OUTPUT_DEST=3D&quot;/dev/null&quot;<br>
<br>
-NUM_TESTS=3D156<br>
+NUM_TESTS=3D310<br>
<br>
=C2=A0source $TESTDIR/utils/utils.sh<br>
<br>
=C2=A0function run_app<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local debug_tp=3D$1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local fire_second_tp=3D$2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local python=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local debug_tp=3D$2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local fire_second_tp=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_=
SEC_WAIT $debug_tp $fire_second_tp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR=
_SEC_WAIT $debug_tp $fire_second_tp<br>
=C2=A0}<br>
<br>
=C2=A0function run_app_background<br>
@@ -94,7 +96,7 @@ function test_python_before_start ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_python_lttng_event $SESSION_NAME $EVENT_=
NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
@@ -120,7 +122,7 @@ function test_python_after_start ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -141,7 +143,7 @@ function test_python_loglevel ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -159,7 +161,7 @@ function test_python_loglevel ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -177,7 +179,7 @@ function test_python_loglevel ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -197,7 +199,7 @@ function test_python_loglevel_multiple ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire tw=
o TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -214,7 +216,7 @@ function test_python_loglevel_multiple ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire tw=
o TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -239,7 +241,7 @@ function test_python_multi_session_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME-2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 1 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-2<br>
@@ -278,7 +280,7 @@ function test_python_multi_session_disable()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME-2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-2<br>
@@ -313,7 +315,7 @@ function test_python_multi_session_disable_wildcard()<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME-2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-2<br>
@@ -346,7 +348,7 @@ function test_python_disable_all()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -372,7 +374,7 @@ function test_python_multi_session()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME-2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME-2<br>
@@ -401,7 +403,7 @@ function test_python_destroy_session()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Wait for the applications started in backgrou=
nd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait<br>
@@ -420,7 +422,7 @@ function test_python_destroy_session()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app_background $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Wait for the applications started in backgrou=
nd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait<br>
@@ -441,11 +443,11 @@ function test_python_filtering()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_lttng_session $SESSION_NAME $TRACE_PATH/=
$SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable all event with a filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME &#39;*&#39; =
&#39;msg =3D=3D &quot;python-ev-test2 fired&quot;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME &#39;*&#39; =
&#39;msg =3D=3D &quot;python-ev-test2 fired [INFO]&quot;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -459,11 +461,11 @@ function test_python_filtering()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_lttng_session $SESSION_NAME $TRACE_PATH/=
$SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable first Logger but filter msg payload fo=
r the INFO one while<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # triggering the debug and second TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME $EVENT_NAME =
&#39;msg =3D=3D &quot;python-ev-test1 fired&quot;&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_python_filter $SESSION_NAME $EVENT_NAME =
&#39;msg =3D=3D &quot;python-ev-test1 fired [INFO]&quot;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay, fire debug=
 and second TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 1 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 1 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -487,7 +489,7 @@ function test_python_disable()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -511,7 +513,7 @@ function test_python_disable_enable()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -539,7 +541,7 @@ function test_python_filter_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_lttng_tracing $SESSION_NAME<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run 5 times with a 1 second delay and fire se=
cond TP.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app 0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_app $1 0 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_tracing $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session $SESSION_NAME<br>
@@ -582,15 +584,19 @@ skip $withapp &quot;Python support is needed. Skippin=
g all tests.&quot; $NUM_TESTS ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_python_filter_=
loglevel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for fct_test in ${tests[@]};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for python_version in 2 3;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE_PATH=3D$(mkte=
mp -d)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${fct_test}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; th=
en<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $TRACE_PATH<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fct_test in ${t=
ests[@]};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TRACE_PATH=3D$(mktemp -d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0diag &quot;(Python $python_version)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0${fct_test} python$python_version<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rm -rf $TRACE_PATH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_sessiond<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.3.0<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a1139cf22944c3e051c6d3994--


--===============0115860980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0115860980==--
