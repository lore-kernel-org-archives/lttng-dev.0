From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: regression tests
Date: Thu, 13 Aug 2015 15:48:59 -0400
Message-ID: <CA+jJMxvMWgn4UF09-haMf4NhqE4BJZe3eCH6WhG4DXnTmwnjFQ__36485.4727908552$1439495421$gmane$org@mail.gmail.com>
References: <1438895745-15529-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1207694951=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZPyUr-0006bV-8e
 for lttng-dev@lists.lttng.org; Thu, 13 Aug 2015 15:49:10 -0400
Received: by ykdz80 with SMTP id z80so50784771ykd.2
 for <lttng-dev@lists.lttng.org>; Thu, 13 Aug 2015 12:48:59 -0700 (PDT)
In-Reply-To: <1438895745-15529-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1207694951==
Content-Type: multipart/alternative; boundary=001a11394746631450051d36a0ea

--001a11394746631450051d36a0ea
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Thu, Aug 6, 2015 at 5:15 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Fix racy session/relayd wait-after-kill scheme.
> Fix racy live test where application may not have generated events yet
> when we attach to the live trace.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  tests/regression/tools/health/test_health.sh       |   4 +-
>  tests/regression/tools/live/test_kernel            |  47 +---------
>  tests/regression/tools/live/test_ust               |  60 ++++--------
>  .../regression/tools/live/test_ust_tracefile_count |  60 ++++--------
>  tests/regression/tools/save-load/test_load         |   6 +-
>  tests/utils/utils.sh                               | 103
> ++++++++++++++++-----
>  6 files changed, 120 insertions(+), 160 deletions(-)
>
> diff --git a/tests/regression/tools/health/test_health.sh
> b/tests/regression/tools/health/test_health.sh
> index ade4b0e..40d2f9e 100644
> --- a/tests/regression/tools/health/test_health.sh
> +++ b/tests/regression/tools/health/test_health.sh
> @@ -146,7 +146,9 @@ function test_health
>         fi
>
>         if [ ${test_relayd} -eq 1 ]; then
> -               stop_lttng_relayd_nocheck
> +               # We may fail to stop relayd here, and this is OK, since
> +               # it may have been killed volountarily by testpoint.
> +               stop_lttng_relayd_notap
>         fi
>         stop_lttng_sessiond
>
> diff --git a/tests/regression/tools/live/test_kernel
> b/tests/regression/tools/live/test_kernel
> index 4b958df..0e542da 100755
> --- a/tests/regression/tools/live/test_kernel
> +++ b/tests/regression/tools/live/test_kernel
> @@ -62,22 +62,8 @@ else
>         exit 0
>  fi
>
> -if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
> -       $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-sessiond"
> -               exit 1
> -       fi
> -fi
> -
> -opt=3D"--background -o $TRACE_PATH"
> -if [ -z $(pidof lt-$RELAYD_BIN) ]; then
> -       $DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-relayd (opt: $opt)"
> -               return 1
> -       fi
> -fi
> +start_lttng_sessiond_notap
> +start_lttng_relayd_notap "-o $TRACE_PATH"
>
>  setup_live_tracing
>
> @@ -86,30 +72,5 @@ $TESTDIR/regression/tools/live/live_test
>
>  clean_live_tracing
>
> -# Kill the relayd
> -PID_RELAYD=3D`pidof lt-$RELAYD_BIN`
> -kill $PID_RELAYD
> -if [ $? -eq 1 ]; then
> -       echo "Kill lttng-relayd (pid: $PID_RELAYD)"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$RELAYD_BIN)
> -               sleep 0.5
> -       done
> -fi
> -
> -# Kill the sessiond
> -PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`
> -kill $PID_SESSIOND
> -if [ $? -eq 1 ]; then
> -       echo "Kill sessiond daemon"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$SESSIOND_BIN)
> -               sleep 0.5
> -       done
> -fi
> +stop_lttng_relayd_notap
> +stop_lttng_sessiond_notap
> diff --git a/tests/regression/tools/live/test_ust
> b/tests/regression/tools/live/test_ust
> index ae69195..0b96858 100755
> --- a/tests/regression/tools/live/test_ust
> +++ b/tests/regression/tools/live/test_ust
> @@ -59,57 +59,29 @@ function clean_live_tracing()
>         rm -rf $TRACE_PATH
>  }
>
> -if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
> -       $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-sessiond"
> -               exit 1
> -       fi
> -fi
> -
> -opt=3D"-o $TRACE_PATH --background"
> -if [ -z $(pidof lt-$RELAYD_BIN) ]; then
> -       $DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-relayd (opt: $opt)"
> -               return 1
> -       fi
> -fi
> +file_sync_after_first=3D$(mktemp -u)
> +
> +start_lttng_sessiond_notap
> +start_lttng_relayd_notap "-o $TRACE_PATH"
>
>  setup_live_tracing
>
>  # Run app in background
> -$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
> +$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} >/dev/null
> 2>&1
> +
> +while [ ! -f "${file_sync_after_first}" ]; do
> +       sleep 0.5
> +done
>
>  # Start the live test
>  $TESTDIR/regression/tools/live/live_test
>
> +# Wait for the applications started in background
> +wait
> +
>  clean_live_tracing
>
> -# Kill the relayd
> -PID_RELAYD=3D`pidof lt-$RELAYD_BIN`
> -kill $PID_RELAYD
> -if [ $? -eq 1 ]; then
> -       echo "Kill lttng-relayd (pid: $PID_RELAYD)"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$RELAYD_BIN)
> -               sleep 0.5
> -       done
> -fi
> -
> -# Kill the sessiond
> -PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`
> -kill $PID_SESSIOND
> -if [ $? -eq 1 ]; then
> -       echo "Kill sessiond daemon"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$SESSIOND_BIN)
> -               sleep 0.5
> -       done
> -fi
> +rm -f ${file_sync_after_first}
> +
> +stop_lttng_relayd_notap
> +stop_lttng_sessiond_notap
> diff --git a/tests/regression/tools/live/test_ust_tracefile_count
> b/tests/regression/tools/live/test_ust_tracefile_count
> index 68e3722..54d6a52 100755
> --- a/tests/regression/tools/live/test_ust_tracefile_count
> +++ b/tests/regression/tools/live/test_ust_tracefile_count
> @@ -60,57 +60,29 @@ function clean_live_tracing()
>         rm -rf $TRACE_PATH
>  }
>
> -if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
> -       $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --quiet
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-sessiond"
> -               exit 1
> -       fi
> -fi
> -
> -opt=3D"-o $TRACE_PATH --background"
> -if [ -z $(pidof lt-$RELAYD_BIN) ]; then
> -       $DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt >/dev/null 2>&1
> -       if [ $? -eq 1 ]; then
> -               echo "Fail to start lttng-relayd (opt: $opt)"
> -               return 1
> -       fi
> -fi
> +file_sync_after_first=3D$(mktemp -u)
> +
> +start_lttng_sessiond_notap
> +start_lttng_relayd_notap "-o $TRACE_PATH"
>
>  setup_live_tracing
>
>  # Run app in background
> -$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT >/dev/null 2>&1
> +$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} >/dev/null
> 2>&1
> +
> +while [ ! -f "${file_sync_after_first}" ]; do
> +       sleep 0.5
> +done
>
>  # Start the live test
>  $TESTDIR/regression/tools/live/live_test
>
> +# Wait for the applications started in background
> +wait
> +
>  clean_live_tracing
>
> -# Kill the relayd
> -PID_RELAYD=3D`pidof lt-$RELAYD_BIN`
> -kill $PID_RELAYD
> -if [ $? -eq 1 ]; then
> -       echo "Kill lttng-relayd (pid: $PID_RELAYD)"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$RELAYD_BIN)
> -               sleep 0.5
> -       done
> -fi
> -
> -# Kill the sessiond
> -PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`
> -kill $PID_SESSIOND
> -if [ $? -eq 1 ]; then
> -       echo "Kill sessiond daemon"
> -       exit 1
> -else
> -       out=3D1
> -       while [ -n "$out" ]; do
> -               out=3D$(pidof lt-$SESSIOND_BIN)
> -               sleep 0.5
> -       done
> -fi
> +rm -f ${file_sync_after_first}
> +
> +stop_lttng_relayd_notap
> +stop_lttng_sessiond_notap
> diff --git a/tests/regression/tools/save-load/test_load
> b/tests/regression/tools/save-load/test_load
> index c6234ef..0a7ee3a 100755
> --- a/tests/regression/tools/save-load/test_load
> +++ b/tests/regression/tools/save-load/test_load
> @@ -29,7 +29,7 @@ EVENT_NAME=3D"tp:tptest"
>
>  DIR=3D$(readlink -f $TESTDIR)
>
> -NUM_TESTS=3D21
> +NUM_TESTS=3D23
>
>  source $TESTDIR/utils/utils.sh
>
> @@ -92,7 +92,7 @@ function test_complex_load()
>         fi
>         destroy_lttng_session_ok $sess
>
> -       stop_lttng_relayd_nocheck
> +       stop_lttng_relayd
>  }
>
>  function test_all_load()
> @@ -108,7 +108,7 @@ function test_all_load()
>         destroy_lttng_session_ok $SESSION_NAME
>         destroy_lttng_session_ok "$SESSION_NAME-complex"
>
> -       stop_lttng_relayd_nocheck
> +       stop_lttng_relayd
>  }
>
>  function test_overwrite()
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index 4282fbb..60adb4f 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -238,9 +238,10 @@ function lttng_disable_kernel_channel_fail()
>         lttng_disable_kernel_channel 1 "$@"
>  }
>
> -function start_lttng_relayd
> +function start_lttng_relayd_opt()
>  {
> -       local opt=3D$1
> +       local withtap=3D$1
> +       local opt=3D$2
>
>         DIR=3D$(readlink -f $TESTDIR)
>
> @@ -248,52 +249,77 @@ function start_lttng_relayd
>                 $DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt
> >$OUTPUT_DEST
>                 #$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv
> >>/tmp/relayd.log 2>&1 &
>                 if [ $? -eq 1 ]; then
> -                       fail "Start lttng-relayd (opt: $opt)"
> +                       if [ $withtap -eq "1" ]; then
> +                               fail "Start lttng-relayd (opt: $opt)"
> +                       fi
>                         return 1
>                 else
> -                       pass "Start lttng-relayd (opt: $opt)"
> +                       if [ $withtap -eq "1" ]; then
> +                               pass "Start lttng-relayd (opt: $opt)"
> +                       fi
>                 fi
>         else
>                 pass "Start lttng-relayd (opt: $opt)"
>         fi
>  }
>
> -function stop_lttng_relayd_nocheck
> +function start_lttng_relayd()
>  {
> +       start_lttng_relayd_opt 1 "$@"
> +}
> +
> +function start_lttng_relayd_notap()
> +{
> +       start_lttng_relayd_opt 0 "$@"
> +}
> +
> +function stop_lttng_relayd_opt()
> +{
> +       local withtap=3D$1
> +
>         PID_RELAYD=3D`pidof lt-$RELAYD_BIN`
>
> -       diag "Killing lttng-relayd (pid: $PID_RELAYD)"
> +       if [ $withtap -eq "1" ]; then
> +               diag "Killing lttng-relayd (pid: $PID_RELAYD)"
> +       fi
>         kill $PID_RELAYD >$OUTPUT_DEST
>         retval=3D$?
>
> -       if [ $retval -eq 1 ]; then
> +       if [ $? -eq 1 ]; then
> +               if [ $withtap -eq "1" ]; then
> +                       fail "Kill relay daemon"
> +               fi
> +               return 1
> +       else
>                 out=3D1
>                 while [ -n "$out" ]; do
>                         out=3D$(pidof lt-$RELAYD_BIN)
>                         sleep 0.5
>                 done
> +               if [ $withtap -eq "1" ]; then
> +                       pass "Kill relay daemon"
> +               fi
>         fi
>         return $retval
>  }
>
> -function stop_lttng_relayd
> +function stop_lttng_relayd()
>  {
> -       stop_lttng_relayd_nocheck
> +       stop_lttng_relayd_opt 1 "$@"
> +}
>
> -       if [ $? -eq 1 ]; then
> -               fail "Killed lttng-relayd (pid: $PID_RELAYD)"
> -               return 1
> -       else
> -               pass "Killed lttng-relayd (pid: $PID_RELAYD)"
> -               return 0
> -       fi
> +function stop_lttng_relayd_notap()
> +{
> +       stop_lttng_relayd_opt 0 "$@"
>  }
>
> -#First argument: load path for automatic loading
> -function start_lttng_sessiond()
> +#First arg: show tap output
> +#Second argument: load path for automatic loading
> +function start_lttng_sessiond_opt()
>  {
> +       local withtap=3D$1
> +       local load_path=3D$2
>
> -       local load_path=3D"$1"
>         if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]=
; then
>                 # Env variable requested no session daemon
>                 return
> @@ -311,19 +337,33 @@ function start_lttng_sessiond()
>
>         if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
>                 # Have a load path ?
> -               if [ -n "$1" ]; then
> +               if [ -n "$load_path" ]; then
>                         $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN
> --load "$1" --background
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
>                 else
>                         $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN
> --background
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
>                 fi
>                 #$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --backgroun=
d
> --consumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --consumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --verbose-consumer >>/tmp/sessiond.log 2>&1
>                 status=3D$?
> -               ok $status "Start session daemon"
> +               if [ $withtap -eq "1" ]; then
> +                       ok $status "Start session daemon"
> +               fi
>         fi
>  }
>
> -function stop_lttng_sessiond ()
> +function start_lttng_sessiond()
> +{
> +       start_lttng_sessiond_opt 1 "$@"
> +}
> +
> +function start_lttng_sessiond_notap()
>  {
> +       start_lttng_sessiond_opt 0 "$@"
> +}
> +
> +function stop_lttng_sessiond_opt()
> +{
> +       local withtap=3D$1
> +
>         if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]=
; then
>                 # Env variable requested no session daemon
>                 return
> @@ -334,8 +374,9 @@ function stop_lttng_sessiond ()
>         kill $PID_SESSIOND >$OUTPUT_DEST
>
>         if [ $? -eq 1 ]; then
> -               fail "Kill sessions daemon"
> -               return 1
> +               if [ $withtap -eq "1" ]; then
> +                       fail "Kill sessions daemon"
> +               fi
>         else
>                 out=3D1
>                 while [ -n "$out" ]; do
> @@ -347,10 +388,22 @@ function stop_lttng_sessiond ()
>                         out=3D$(pidof $CONSUMERD_BIN)
>                         sleep 0.5
>                 done
> -               pass "Kill session daemon"
> +               if [ $withtap -eq "1" ]; then
> +                       pass "Kill session daemon"
> +               fi
>         fi
>  }
>
> +function stop_lttng_sessiond()
> +{
> +       stop_lttng_sessiond_opt 1 "$@"
> +}
> +
> +function stop_lttng_sessiond_notap()
> +{
> +       stop_lttng_sessiond_opt 0 "$@"
> +}
> +
>  function list_lttng_with_opts ()
>  {
>         local opts=3D$1
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11394746631450051d36a0ea
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Aug=
 6, 2015 at 5:15 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@eff=
icios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Fix racy=
 session/relayd wait-after-kill scheme.<br>
Fix racy live test where application may not have generated events yet<br>
when we attach to the live trace.<br>
<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
=C2=A0tests/regression/tools/health/test_health.sh=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0tests/regression/tools/live/test_kernel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 47 +---------<br>
=C2=A0tests/regression/tools/live/test_ust=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 60 ++++--------<br>
=C2=A0.../regression/tools/live/test_ust_tracefile_count |=C2=A0 60 ++++---=
-----<br>
=C2=A0tests/regression/tools/save-load/test_load=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0tests/utils/utils.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 103 +++++++=
+++++++++-----<br>
=C2=A06 files changed, 120 insertions(+), 160 deletions(-)<br>
<br>
diff --git a/tests/regression/tools/health/test_health.sh b/tests/regressio=
n/tools/health/test_health.sh<br>
index ade4b0e..40d2f9e 100644<br>
--- a/tests/regression/tools/health/test_health.sh<br>
+++ b/tests/regression/tools/health/test_health.sh<br>
@@ -146,7 +146,9 @@ function test_health<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ ${test_relayd} -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_n=
ocheck<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We may fail to st=
op relayd here, and this is OK, since<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# it may have been =
killed volountarily by testpoint.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_n=
otap<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_lttng_sessiond<br>
<br>
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/too=
ls/live/test_kernel<br>
index 4b958df..0e542da 100755<br>
--- a/tests/regression/tools/live/test_kernel<br>
+++ b/tests/regression/tools/live/test_kernel<br>
@@ -62,22 +62,8 @@ else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 0<br>
=C2=A0fi<br>
<br>
-if [ -z $(pidof lt-$SESSIOND_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --=
background --quiet --consumerd32-path=3D&quot;$DIR/../src/bin/lttng-consume=
rd/lttng-consumerd&quot; --consumerd64-path=3D&quot;$DIR/../src/bin/lttng-c=
onsumerd/lttng-consumerd&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-sessiond&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
-<br>
-opt=3D&quot;--background -o $TRACE_PATH&quot;<br>
-if [ -z $(pidof lt-$RELAYD_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt &=
gt;/dev/null 2&gt;&amp;1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-relayd (opt: $opt)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
+start_lttng_sessiond_notap<br>
+start_lttng_relayd_notap &quot;-o $TRACE_PATH&quot;<br>
<br>
=C2=A0setup_live_tracing<br>
<br>
@@ -86,30 +72,5 @@ $TESTDIR/regression/tools/live/live_test<br>
<br>
=C2=A0clean_live_tracing<br>
<br>
-# Kill the relayd<br>
-PID_RELAYD=3D`pidof lt-$RELAYD_BIN`<br>
-kill $PID_RELAYD<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill lttng-relayd (pid: $PID_RELAYD)=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$R=
ELAYD_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
-<br>
-# Kill the sessiond<br>
-PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`<br>
-kill $PID_SESSIOND<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill sessiond daemon&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$S=
ESSIOND_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
+stop_lttng_relayd_notap<br>
+stop_lttng_sessiond_notap<br>
diff --git a/tests/regression/tools/live/test_ust b/tests/regression/tools/=
live/test_ust<br>
index ae69195..0b96858 100755<br>
--- a/tests/regression/tools/live/test_ust<br>
+++ b/tests/regression/tools/live/test_ust<br>
@@ -59,57 +59,29 @@ function clean_live_tracing()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $TRACE_PATH<br>
=C2=A0}<br>
<br>
-if [ -z $(pidof lt-$SESSIOND_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --=
background --quiet --consumerd32-path=3D&quot;$DIR/../src/bin/lttng-consume=
rd/lttng-consumerd&quot; --consumerd64-path=3D&quot;$DIR/../src/bin/lttng-c=
onsumerd/lttng-consumerd&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-sessiond&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
-<br>
-opt=3D&quot;-o $TRACE_PATH --background&quot;<br>
-if [ -z $(pidof lt-$RELAYD_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt &=
gt;/dev/null 2&gt;&amp;1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-relayd (opt: $opt)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
+file_sync_after_first=3D$(mktemp -u)<br>
+<br>
+start_lttng_sessiond_notap<br>
+start_lttng_relayd_notap &quot;-o $TRACE_PATH&quot;<br>
<br>
=C2=A0setup_live_tracing<br>
<br>
=C2=A0# Run app in background<br>
-$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &gt;/dev/null 2&gt;&amp;1<br>
+$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} &gt;/dev/null=
 2&gt;&amp;1<br>
+<br>
+while [ ! -f &quot;${file_sync_after_first}&quot; ]; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
+done<br>
<br>
=C2=A0# Start the live test<br>
=C2=A0$TESTDIR/regression/tools/live/live_test<br>
<br>
+# Wait for the applications started in background<br>
+wait<br>
+<br>
=C2=A0clean_live_tracing<br>
<br>
-# Kill the relayd<br>
-PID_RELAYD=3D`pidof lt-$RELAYD_BIN`<br>
-kill $PID_RELAYD<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill lttng-relayd (pid: $PID_RELAYD)=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$R=
ELAYD_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
-<br>
-# Kill the sessiond<br>
-PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`<br>
-kill $PID_SESSIOND<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill sessiond daemon&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$S=
ESSIOND_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
+rm -f ${file_sync_after_first}<br>
+<br>
+stop_lttng_relayd_notap<br>
+stop_lttng_sessiond_notap<br>
diff --git a/tests/regression/tools/live/test_ust_tracefile_count b/tests/r=
egression/tools/live/test_ust_tracefile_count<br>
index 68e3722..54d6a52 100755<br>
--- a/tests/regression/tools/live/test_ust_tracefile_count<br>
+++ b/tests/regression/tools/live/test_ust_tracefile_count<br>
@@ -60,57 +60,29 @@ function clean_live_tracing()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $TRACE_PATH<br>
=C2=A0}<br>
<br>
-if [ -z $(pidof lt-$SESSIOND_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --=
background --quiet --consumerd32-path=3D&quot;$DIR/../src/bin/lttng-consume=
rd/lttng-consumerd&quot; --consumerd64-path=3D&quot;$DIR/../src/bin/lttng-c=
onsumerd/lttng-consumerd&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-sessiond&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
-<br>
-opt=3D&quot;-o $TRACE_PATH --background&quot;<br>
-if [ -z $(pidof lt-$RELAYD_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt &=
gt;/dev/null 2&gt;&amp;1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Fail to =
start lttng-relayd (opt: $opt)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-fi<br>
+file_sync_after_first=3D$(mktemp -u)<br>
+<br>
+start_lttng_sessiond_notap<br>
+start_lttng_relayd_notap &quot;-o $TRACE_PATH&quot;<br>
<br>
=C2=A0setup_live_tracing<br>
<br>
=C2=A0# Run app in background<br>
-$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &gt;/dev/null 2&gt;&amp;1<br>
+$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT ${file_sync_after_first} &gt;/dev/null=
 2&gt;&amp;1<br>
+<br>
+while [ ! -f &quot;${file_sync_after_first}&quot; ]; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
+done<br>
<br>
=C2=A0# Start the live test<br>
=C2=A0$TESTDIR/regression/tools/live/live_test<br>
<br>
+# Wait for the applications started in background<br>
+wait<br>
+<br>
=C2=A0clean_live_tracing<br>
<br>
-# Kill the relayd<br>
-PID_RELAYD=3D`pidof lt-$RELAYD_BIN`<br>
-kill $PID_RELAYD<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill lttng-relayd (pid: $PID_RELAYD)=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$R=
ELAYD_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
-<br>
-# Kill the sessiond<br>
-PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`<br>
-kill $PID_SESSIOND<br>
-if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Kill sessiond daemon&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -n &quot;$out&quot; ]; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out=3D$(pidof lt-$S=
ESSIOND_BIN)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 0.5<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
-fi<br>
+rm -f ${file_sync_after_first}<br>
+<br>
+stop_lttng_relayd_notap<br>
+stop_lttng_sessiond_notap<br>
diff --git a/tests/regression/tools/save-load/test_load b/tests/regression/=
tools/save-load/test_load<br>
index c6234ef..0a7ee3a 100755<br>
--- a/tests/regression/tools/save-load/test_load<br>
+++ b/tests/regression/tools/save-load/test_load<br>
@@ -29,7 +29,7 @@ EVENT_NAME=3D&quot;tp:tptest&quot;<br>
<br>
=C2=A0DIR=3D$(readlink -f $TESTDIR)<br>
<br>
-NUM_TESTS=3D21<br>
+NUM_TESTS=3D23<br>
<br>
=C2=A0source $TESTDIR/utils/utils.sh<br>
<br>
@@ -92,7 +92,7 @@ function test_complex_load()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session_ok $sess<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_nocheck<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd<br>
=C2=A0}<br>
<br>
=C2=A0function test_all_load()<br>
@@ -108,7 +108,7 @@ function test_all_load()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session_ok $SESSION_NAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_lttng_session_ok &quot;$SESSION_NAME-co=
mplex&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_nocheck<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd<br>
=C2=A0}<br>
<br>
=C2=A0function test_overwrite()<br>
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh<br>
index 4282fbb..60adb4f 100644<br>
--- a/tests/utils/utils.sh<br>
+++ b/tests/utils/utils.sh<br>
@@ -238,9 +238,10 @@ function lttng_disable_kernel_channel_fail()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng_disable_kernel_channel 1 &quot;$@&quot;<b=
r>
=C2=A0}<br>
<br>
-function start_lttng_relayd<br>
+function start_lttng_relayd_opt()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local opt=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local withtap=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local opt=3D$2<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR=3D$(readlink -f $TESTDIR)<br>
<br>
@@ -248,52 +249,77 @@ function start_lttng_relayd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $DIR/../src/bin/ltt=
ng-relayd/$RELAYD_BIN -b $opt &gt;$OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #$DIR/../src/bin/lt=
tng-relayd/$RELAYD_BIN $opt -vvv &gt;&gt;/tmp/relayd.log 2&gt;&amp;1 &amp;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; th=
en<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fail &quot;Start lttng-relayd (opt: $opt)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if [ $withtap -eq &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail &quot;Start lttng-relayd (opt: $=
opt)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pass &quot;Start lttng-relayd (opt: $opt)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if [ $withtap -eq &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass &quot;Start lttng-relayd (opt: $=
opt)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass &quot;Start lt=
tng-relayd (opt: $opt)&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0}<br>
<br>
-function stop_lttng_relayd_nocheck<br>
+function start_lttng_relayd()<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_relayd_opt 1 &quot;$@&quot;<br>
+}<br>
+<br>
+function start_lttng_relayd_notap()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_relayd_opt 0 &quot;$@&quot;<br>
+}<br>
+<br>
+function stop_lttng_relayd_opt()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local withtap=3D$1<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID_RELAYD=3D`pidof lt-$RELAYD_BIN`<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Killing lttng-relayd (pid: $PID_RELA=
YD)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;Killing =
lttng-relayd (pid: $PID_RELAYD)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kill $PID_RELAYD &gt;$OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval=3D$?<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $retval -eq 1 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &=
quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fail &quot;Kill relay daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out=3D1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while [ -n &quot;$o=
ut&quot; ]; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 out=3D$(pidof lt-$RELAYD_BIN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sleep 0.5<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &=
quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pass &quot;Kill relay daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return $retval<br>
=C2=A0}<br>
<br>
-function stop_lttng_relayd<br>
+function stop_lttng_relayd()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_nocheck<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_opt 1 &quot;$@&quot;<br>
+}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail &quot;Killed l=
ttng-relayd (pid: $PID_RELAYD)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass &quot;Killed l=
ttng-relayd (pid: $PID_RELAYD)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+function stop_lttng_relayd_notap()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_relayd_opt 0 &quot;$@&quot;<br>
=C2=A0}<br>
<br>
-#First argument: load path for automatic loading<br>
-function start_lttng_sessiond()<br>
+#First arg: show tap output<br>
+#Second argument: load path for automatic loading<br>
+function start_lttng_sessiond_opt()<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local withtap=3D$1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local load_path=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local load_path=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -n $TEST_NO_SESSIOND ] &amp;&amp; [ &quot;=
$TEST_NO_SESSIOND&quot; =3D=3D &quot;1&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Env variable requ=
ested no session daemon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
@@ -311,19 +337,33 @@ function start_lttng_sessiond()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -z $(pidof lt-$SESSIOND_BIN) ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Have a load path =
?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -n &quot;$1&qu=
ot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -n &quot;$load=
_path&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --load &quot;$1&quo=
t; --background --consumerd32-path=3D&quot;$DIR/../src/bin/lttng-consumerd/=
lttng-consumerd&quot; --consumerd64-path=3D&quot;$DIR/../src/bin/lttng-cons=
umerd/lttng-consumerd&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --cons=
umerd32-path=3D&quot;$DIR/../src/bin/lttng-consumerd/lttng-consumerd&quot; =
--consumerd64-path=3D&quot;$DIR/../src/bin/lttng-consumerd/lttng-consumerd&=
quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #$DIR/../src/bin/lt=
tng-sessiond/$SESSIOND_BIN --background --consumerd32-path=3D&quot;$DIR/../=
src/bin/lttng-consumerd/lttng-consumerd&quot; --consumerd64-path=3D&quot;$D=
IR/../src/bin/lttng-consumerd/lttng-consumerd&quot; --verbose-consumer &gt;=
&gt;/tmp/sessiond.log 2&gt;&amp;1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status=3D$?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ok $status &quot;St=
art session daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &=
quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ok $status &quot;Start session daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0}<br>
<br>
-function stop_lttng_sessiond ()<br>
+function start_lttng_sessiond()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_sessiond_opt 1 &quot;$@&quot;<br>
+}<br>
+<br>
+function start_lttng_sessiond_notap()<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start_lttng_sessiond_opt 0 &quot;$@&quot;<br>
+}<br>
+<br>
+function stop_lttng_sessiond_opt()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local withtap=3D$1<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -n $TEST_NO_SESSIOND ] &amp;&amp; [ &quot;=
$TEST_NO_SESSIOND&quot; =3D=3D &quot;1&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Env variable requ=
ested no session daemon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
@@ -334,8 +374,9 @@ function stop_lttng_sessiond ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kill $PID_SESSIOND &gt;$OUTPUT_DEST<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail &quot;Kill ses=
sions daemon&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &=
quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fail &quot;Kill sessions daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out=3D1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while [ -n &quot;$o=
ut&quot; ]; do<br>
@@ -347,10 +388,22 @@ function stop_lttng_sessiond ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 out=3D$(pidof $CONSUMERD_BIN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sleep 0.5<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass &quot;Kill ses=
sion daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $withtap -eq &=
quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pass &quot;Kill session daemon&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0}<br>
<br>
+function stop_lttng_sessiond()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond_opt 1 &quot;$@&quot;<br>
+}<br>
+<br>
+function stop_lttng_sessiond_notap()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stop_lttng_sessiond_opt 0 &quot;$@&quot;<br>
+}<br>
+<br>
=C2=A0function list_lttng_with_opts ()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local opts=3D$1<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--001a11394746631450051d36a0ea--


--===============1207694951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1207694951==--
