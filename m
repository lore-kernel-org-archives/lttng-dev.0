From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: tests: stderr not
	correctly redirected
Date: Wed, 12 Aug 2015 17:40:41 -0400
Message-ID: <CA+jJMxuuW7iZKknY+0yfX6QUEHkCpeOcajQTykBPAja4TXPhOw__49499.7312118814$1439415754$gmane$org@mail.gmail.com>
References: <1438207072-1122-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1482546929=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZPdlO-0008LZ-Rz
 for lttng-dev@lists.lttng.org; Wed, 12 Aug 2015 17:40:57 -0400
Received: by ykdz80 with SMTP id z80so25968481ykd.2
 for <lttng-dev@lists.lttng.org>; Wed, 12 Aug 2015 14:40:41 -0700 (PDT)
In-Reply-To: <1438207072-1122-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

--===============1482546929==
Content-Type: multipart/alternative; boundary=94eb2c0885befcf7ba051d2411c7

--94eb2c0885befcf7ba051d2411c7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged, thanks!

J=C3=A9r=C3=A9mie

On Wed, Jul 29, 2015 at 5:57 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  tests/utils/utils.sh | 75
> ++++++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index 4282fbb..ba0b10e 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -20,7 +20,8 @@ CONSUMERD_BIN=3D"lttng-consumerd"
>  RELAYD_BIN=3D"lttng-relayd"
>  LTTNG_BIN=3D"lttng"
>  BABELTRACE_BIN=3D"babeltrace"
> -OUTPUT_DEST=3D/dev/null 2>&1
> +OUTPUT_DEST=3D/dev/null
> +ERROR_OUTPUT_DEST=3D/dev/null
>
>  # Minimal kernel version supported for session daemon tests
>  KERNEL_MAJOR_VERSION=3D2
> @@ -103,7 +104,7 @@ function lttng_enable_kernel_event
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -k >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable kernel event $event_name for session $sess_name"
>  }
>
> @@ -126,7 +127,7 @@ function lttng_enable_kernel_syscall()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --syscall
> "$syscall_name" $chan -s $sess_name -k >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --syscall
> "$syscall_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_D=
EST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test $ret -ne "0"
> @@ -165,7 +166,7 @@ function lttng_disable_kernel_syscall()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event --syscall
> "$syscall_name" $chan -s $sess_name -k >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event --syscall
> "$syscall_name" $chan -s $sess_name -k 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_D=
EST
>
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
> @@ -192,7 +193,7 @@ function lttng_enable_kernel_channel()
>         local sess_name=3D$2
>         local channel_name=3D$3
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -k
> $channel_name -s $sess_name >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -k
> $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -218,7 +219,7 @@ function lttng_disable_kernel_channel()
>         local sess_name=3D$2
>         local channel_name=3D$3
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -k
> $channel_name -s $sess_name >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -k
> $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -245,7 +246,7 @@ function start_lttng_relayd
>         DIR=3D$(readlink -f $TESTDIR)
>
>         if [ -z $(pidof lt-$RELAYD_BIN) ]; then
> -               $DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt
> >$OUTPUT_DEST
> +               $DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>                 #$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv
> >>/tmp/relayd.log 2>&1 &
>                 if [ $? -eq 1 ]; then
>                         fail "Start lttng-relayd (opt: $opt)"
> @@ -263,7 +264,7 @@ function stop_lttng_relayd_nocheck
>         PID_RELAYD=3D`pidof lt-$RELAYD_BIN`
>
>         diag "Killing lttng-relayd (pid: $PID_RELAYD)"
> -       kill $PID_RELAYD >$OUTPUT_DEST
> +       kill $PID_RELAYD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         retval=3D$?
>
>         if [ $retval -eq 1 ]; then
> @@ -331,7 +332,7 @@ function stop_lttng_sessiond ()
>
>         PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`
>
> -       kill $PID_SESSIOND >$OUTPUT_DEST
> +       kill $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>
>         if [ $? -eq 1 ]; then
>                 fail "Kill sessions daemon"
> @@ -354,7 +355,7 @@ function stop_lttng_sessiond ()
>  function list_lttng_with_opts ()
>  {
>         local opts=3D$1
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts 1> $OUTPUT_DEST 2=
>
> $ERROR_OUTPUT_DEST
>         ok $? "Lttng-tool list command with option $opts"
>  }
>
> @@ -362,7 +363,7 @@ function create_lttng_session_no_output ()
>  {
>         local sess_name=3D$1
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name --no-outpu=
t
> >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN create $sess_name --no-outpu=
t
> 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Create session $sess_name in no-output mode"
>  }
>
> @@ -399,7 +400,7 @@ function enable_ust_lttng_channel ()
>         local sess_name=3D$2
>         local channel_name=3D$3
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u
> $channel_name -s $sess_name >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -u
> $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expect_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -424,7 +425,7 @@ function disable_ust_lttng_channel()
>         local sess_name=3D$1
>         local channel_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -u
> $channel_name -s $sess_name >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-channel -u
> $channel_name -s $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Disable channel $channel_name for session $sess_name"
>  }
>
> @@ -433,7 +434,7 @@ function enable_lttng_mmap_overwrite_kernel_channel()
>         local sess_name=3D$1
>         local channel_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name
> $channel_name -k --output mmap --overwrite >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name
> $channel_name -k --output mmap --overwrite 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable channel $channel_name for session $sess_name"
>  }
>
> @@ -442,7 +443,7 @@ function enable_lttng_mmap_overwrite_ust_channel()
>         local sess_name=3D$1
>         local channel_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name
> $channel_name -u --output mmap --overwrite >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name
> $channel_name -u --output mmap --overwrite 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable channel $channel_name for session $sess_name"
>  }
>
> @@ -460,7 +461,7 @@ function enable_ust_lttng_event ()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -u >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -u 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test $ret -ne "0"
> @@ -493,7 +494,7 @@ function enable_jul_lttng_event()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -j >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -j 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable JUL event $event_name for session $sess_name"
>  }
>
> @@ -511,7 +512,7 @@ function enable_jul_lttng_event_loglevel()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -j >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -j 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable JUL event $event_name for session $sess_name with
> loglevel $loglevel"
>  }
>
> @@ -528,7 +529,7 @@ function enable_log4j_lttng_event()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -l >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -l 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable LOG4J event $event_name for session $sess_name"
>  }
>
> @@ -546,7 +547,7 @@ function enable_log4j_lttng_event_loglevel()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -l >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -l 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable LOG4J event $event_name for session $sess_name with
> loglevel $loglevel"
>  }
>
> @@ -563,7 +564,7 @@ function enable_python_lttng_event()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -p >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name"
> $chan -s $sess_name -p 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable Python event $event_name for session $sess_name"
>  }
>
> @@ -581,7 +582,7 @@ function enable_python_lttng_event_loglevel()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -p >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event --loglevel
> $loglevel "$event_name" $chan -s $sess_name -p 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable Python event $event_name for session $sess_name wit=
h
> loglevel $loglevel"
>  }
>
> @@ -591,7 +592,7 @@ function enable_ust_lttng_event_filter()
>         local event_name=3D"$2"
>         local filter=3D"$3"
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --filter "$filter" >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --filter "$filter" 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable event $event_name with filtering for session
> $sess_name"
>  }
>
> @@ -601,7 +602,7 @@ function enable_ust_lttng_event_loglevel()
>         local event_name=3D"$2"
>         local loglevel=3D"$3"
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --loglevel $loglevel >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --loglevel $loglevel 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Enable event $event_name with loglevel $loglevel"
>  }
>
> @@ -611,7 +612,7 @@ function enable_ust_lttng_event_loglevel_only()
>         local event_name=3D"$2"
>         local loglevel=3D"$3"
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --loglevel-only $loglevel >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-event "$event_name" -=
s
> $sess_name -u --loglevel-only $loglevel 1> $OUTPUT_DEST 2>
> $ERROR_OUTPUT_DEST
>         ok $? "Enable event $event_name with loglevel-only $loglevel"
>  }
>
> @@ -628,7 +629,7 @@ function disable_ust_lttng_event ()
>                 chan=3D"-c $channel_name"
>         fi
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name"
> -s $sess_name $chan -u >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name"
> -s $sess_name $chan -u 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Disable event $event_name for session $sess_name"
>  }
>
> @@ -655,7 +656,7 @@ function disable_python_lttng_event ()
>         local sess_name=3D"$1"
>         local event_name=3D"$2"
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name"
> -s $sess_name -p >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-event "$event_name"
> -s $sess_name -p 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Disable Python event $event_name for session $sess_name"
>  }
>
> @@ -664,7 +665,7 @@ function start_lttng_tracing ()
>         local expected_to_fail=3D$1
>         local sess_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name >$OUTPUT_DE=
ST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN start $sess_name 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -689,7 +690,7 @@ function stop_lttng_tracing ()
>         local expected_to_fail=3D$1
>         local sess_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name >$OUTPUT_DES=
T
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess_name 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -714,7 +715,7 @@ function destroy_lttng_session ()
>         local expected_to_fail=3D$1
>         local sess_name=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name
> >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $sess_name 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -738,7 +739,7 @@ function destroy_lttng_session_fail ()
>
>  function destroy_lttng_sessions ()
>  {
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --all >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --all 1> $OUTPUT_DES=
T
> 2> $ERROR_OUTPUT_DEST
>         ok $? "Destroy all lttng sessions"
>  }
>
> @@ -748,7 +749,7 @@ function lttng_snapshot_add_output ()
>         local sess_name=3D$2
>         local trace_path=3D$3
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s
> $sess_name file://$trace_path >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output -s
> $sess_name file://$trace_path 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq 1 ]]; then
>                 test "$ret" -ne "0"
> @@ -774,7 +775,7 @@ function lttng_snapshot_del_output ()
>         local sess_name=3D$2
>         local id=3D$3
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s
> $sess_name $id >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output -s
> $sess_name $id 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ret=3D$?
>         if [[ $expected_to_fail -eq "1" ]]; then
>                 test "$ret" -ne "0"
> @@ -799,14 +800,14 @@ function lttng_snapshot_record ()
>         local sess_name=3D$1
>         local trace_path=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot record -s $sess_nam=
e
> >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot record -s $sess_nam=
e
> 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Snapshot recorded"
>  }
>
>  function lttng_snapshot_list ()
>  {
>         local sess_name=3D$1
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output -s
> $sess_name >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output -s
> $sess_name 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Snapshot list"
>  }
>
> @@ -815,7 +816,7 @@ function lttng_save()
>         local sess_name=3D$1
>         local opts=3D$2
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess_name $opts
> >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess_name $opts 1>
> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>         ok $? "Session successfully saved"
>  }
>
> @@ -823,7 +824,7 @@ function lttng_load()
>  {
>         local opts=3D$1
>
> -       $TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts >$OUTPUT_DEST
> +       $TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts 1> $OUTPUT_DEST 2=
>
> $ERROR_OUTPUT_DEST
>         ok $? "Load command successful"
>  }
>
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--94eb2c0885befcf7ba051d2411c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged, thanks!<div><br></div><div>J=C3=A9r=C3=A9mie</div>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jul=
 29, 2015 at 5:57 PM, Jonathan Rajotte <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajott=
e-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte-j=
ulien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0tests/utils/utils.sh | 75 ++++++++++++++++++++++++++-----------------=
---------<br>
=C2=A01 file changed, 38 insertions(+), 37 deletions(-)<br>
<br>
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh<br>
index 4282fbb..ba0b10e 100644<br>
--- a/tests/utils/utils.sh<br>
+++ b/tests/utils/utils.sh<br>
@@ -20,7 +20,8 @@ CONSUMERD_BIN=3D&quot;lttng-consumerd&quot;<br>
=C2=A0RELAYD_BIN=3D&quot;lttng-relayd&quot;<br>
=C2=A0LTTNG_BIN=3D&quot;lttng&quot;<br>
=C2=A0BABELTRACE_BIN=3D&quot;babeltrace&quot;<br>
-OUTPUT_DEST=3D/dev/null 2&gt;&amp;1<br>
+OUTPUT_DEST=3D/dev/null<br>
+ERROR_OUTPUT_DEST=3D/dev/null<br>
<br>
=C2=A0# Minimal kernel version supported for session daemon tests<br>
=C2=A0KERNEL_MAJOR_VERSION=3D2<br>
@@ -103,7 +104,7 @@ function lttng_enable_kernel_event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -k &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -k 1&gt; $OUTPUT_DEST 2&gt; =
$ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable kernel event $event_name for=
 session $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -126,7 +127,7 @@ function lttng_enable_kernel_syscall()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --syscall &quot;$syscall_name&quot; $chan -s $sess_name -k &gt;$OUTPUT_D=
EST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --syscall &quot;$syscall_name&quot; $chan -s $sess_name -k 1&gt; $OUTPUT=
_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test $ret -ne &quot=
;0&quot;<br>
@@ -165,7 +166,7 @@ function lttng_disable_kernel_syscall()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent --syscall &quot;$syscall_name&quot; $chan -s $sess_name -k &gt;$OUTPUT_=
DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent --syscall &quot;$syscall_name&quot; $chan -s $sess_name -k 1&gt; $OUTPU=
T_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
@@ -192,7 +193,7 @@ function lttng_enable_kernel_channel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -k $channel_name -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -k $channel_name -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_=
DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -218,7 +219,7 @@ function lttng_disable_kernel_channel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ch=
annel -k $channel_name -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ch=
annel -k $channel_name -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT=
_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -245,7 +246,7 @@ function start_lttng_relayd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR=3D$(readlink -f $TESTDIR)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -z $(pidof lt-$RELAYD_BIN) ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/ltt=
ng-relayd/$RELAYD_BIN -b $opt &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$DIR/../src/bin/ltt=
ng-relayd/$RELAYD_BIN -b $opt 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #$DIR/../src/bin/lt=
tng-relayd/$RELAYD_BIN $opt -vvv &gt;&gt;/tmp/relayd.log 2&gt;&amp;1 &amp;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; th=
en<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fail &quot;Start lttng-relayd (opt: $opt)&quot;<br>
@@ -263,7 +264,7 @@ function stop_lttng_relayd_nocheck<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID_RELAYD=3D`pidof lt-$RELAYD_BIN`<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag &quot;Killing lttng-relayd (pid: $PID_RELA=
YD)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kill $PID_RELAYD &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kill $PID_RELAYD 1&gt; $OUTPUT_DEST 2&gt; $ERRO=
R_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval=3D$?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $retval -eq 1 ]; then<br>
@@ -331,7 +332,7 @@ function stop_lttng_sessiond ()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PID_SESSIOND=3D`pidof lt-$SESSIOND_BIN`<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kill $PID_SESSIOND &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kill $PID_SESSIOND 1&gt; $OUTPUT_DEST 2&gt; $ER=
ROR_OUTPUT_DEST<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail &quot;Kill ses=
sions daemon&quot;<br>
@@ -354,7 +355,7 @@ function stop_lttng_sessiond ()<br>
=C2=A0function list_lttng_with_opts ()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local opts=3D$1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts=
 &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN list $opts=
 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Lttng-tool list command with option=
 $opts&quot;<br>
=C2=A0}<br>
<br>
@@ -362,7 +363,7 @@ function create_lttng_session_no_output ()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $se=
ss_name --no-output &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN create $se=
ss_name --no-output 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Create session $sess_name in no-out=
put mode&quot;<br>
=C2=A0}<br>
<br>
@@ -399,7 +400,7 @@ function enable_ust_lttng_channel ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -u $channel_name -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -u $channel_name -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_=
DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expect_fail -eq &quot;1&quot; ]]; then<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -424,7 +425,7 @@ function disable_ust_lttng_channel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ch=
annel -u $channel_name -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ch=
annel -u $channel_name -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT=
_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Disable channel $channel_name for s=
ession $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -433,7 +434,7 @@ function enable_lttng_mmap_overwrite_kernel_channel()<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -s $sess_name $channel_name -k --output mmap --overwrite &gt;$OUTPUT_D=
EST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -s $sess_name $channel_name -k --output mmap --overwrite 1&gt; $OUTPUT=
_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable channel $channel_name for se=
ssion $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -442,7 +443,7 @@ function enable_lttng_mmap_overwrite_ust_channel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local channel_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -s $sess_name $channel_name -u --output mmap --overwrite &gt;$OUTPUT_D=
EST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-cha=
nnel -s $sess_name $channel_name -u --output mmap --overwrite 1&gt; $OUTPUT=
_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable channel $channel_name for se=
ssion $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -460,7 +461,7 @@ function enable_ust_lttng_event ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -u &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -u 1&gt; $OUTPUT_DEST 2&gt; =
$ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test $ret -ne &quot=
;0&quot;<br>
@@ -493,7 +494,7 @@ function enable_jul_lttng_event()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -j &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -j 1&gt; $OUTPUT_DEST 2&gt; =
$ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable JUL event $event_name for se=
ssion $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -511,7 +512,7 @@ function enable_jul_lttng_event_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -j &gt;=
$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -j 1&gt=
; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable JUL event $event_name for se=
ssion $sess_name with loglevel $loglevel&quot;<br>
=C2=A0}<br>
<br>
@@ -528,7 +529,7 @@ function enable_log4j_lttng_event()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -l &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -l 1&gt; $OUTPUT_DEST 2&gt; =
$ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable LOG4J event $event_name for =
session $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -546,7 +547,7 @@ function enable_log4j_lttng_event_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -l &gt;=
$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -l 1&gt=
; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable LOG4J event $event_name for =
session $sess_name with loglevel $loglevel&quot;<br>
=C2=A0}<br>
<br>
@@ -563,7 +564,7 @@ function enable_python_lttng_event()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -p &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; $chan -s $sess_name -p 1&gt; $OUTPUT_DEST 2&gt; =
$ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable Python event $event_name for=
 session $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -581,7 +582,7 @@ function enable_python_lttng_event_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -p &gt;=
$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt --loglevel $loglevel &quot;$event_name&quot; $chan -s $sess_name -p 1&gt=
; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable Python event $event_name for=
 session $sess_name with loglevel $loglevel&quot;<br>
=C2=A0}<br>
<br>
@@ -591,7 +592,7 @@ function enable_ust_lttng_event_filter()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local event_name=3D&quot;$2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local filter=3D&quot;$3&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --filter &quot;$filter&quot; &g=
t;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --filter &quot;$filter&quot; 1&=
gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable event $event_name with filte=
ring for session $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -601,7 +602,7 @@ function enable_ust_lttng_event_loglevel()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local event_name=3D&quot;$2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local loglevel=3D&quot;$3&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --loglevel $loglevel &gt;$OUTPU=
T_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --loglevel $loglevel 1&gt; $OUT=
PUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable event $event_name with logle=
vel $loglevel&quot;<br>
=C2=A0}<br>
<br>
@@ -611,7 +612,7 @@ function enable_ust_lttng_event_loglevel_only()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local event_name=3D&quot;$2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local loglevel=3D&quot;$3&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --loglevel-only $loglevel &gt;$=
OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-eve=
nt &quot;$event_name&quot; -s $sess_name -u --loglevel-only $loglevel 1&gt;=
 $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Enable event $event_name with logle=
vel-only $loglevel&quot;<br>
=C2=A0}<br>
<br>
@@ -628,7 +629,7 @@ function disable_ust_lttng_event ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chan=3D&quot;-c $ch=
annel_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent &quot;$event_name&quot; -s $sess_name $chan -u &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent &quot;$event_name&quot; -s $sess_name $chan -u 1&gt; $OUTPUT_DEST 2&gt;=
 $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Disable event $event_name for sessi=
on $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -655,7 +656,7 @@ function disable_python_lttng_event ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local event_name=3D&quot;$2&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent &quot;$event_name&quot; -s $sess_name -p &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN disable-ev=
ent &quot;$event_name&quot; -s $sess_name -p 1&gt; $OUTPUT_DEST 2&gt; $ERRO=
R_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Disable Python event $event_name fo=
r session $sess_name&quot;<br>
=C2=A0}<br>
<br>
@@ -664,7 +665,7 @@ function start_lttng_tracing ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local expected_to_fail=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $ses=
s_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN start $ses=
s_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -689,7 +690,7 @@ function stop_lttng_tracing ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local expected_to_fail=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess=
_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN stop $sess=
_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -714,7 +715,7 @@ function destroy_lttng_session ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local expected_to_fail=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $s=
ess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy $s=
ess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -738,7 +739,7 @@ function destroy_lttng_session_fail ()<br>
<br>
=C2=A0function destroy_lttng_sessions ()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --=
all &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN destroy --=
all 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Destroy all lttng sessions&quot;<br=
>
=C2=A0}<br>
<br>
@@ -748,7 +749,7 @@ function lttng_snapshot_add_output ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local trace_path=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot a=
dd-output -s $sess_name file://$trace_path &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot a=
dd-output -s $sess_name file://$trace_path 1&gt; $OUTPUT_DEST 2&gt; $ERROR_=
OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq 1 ]]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -774,7 +775,7 @@ function lttng_snapshot_del_output ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local id=3D$3<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot d=
el-output -s $sess_name $id &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot d=
el-output -s $sess_name $id 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3D$?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [[ $expected_to_fail -eq &quot;1&quot; ]]; t=
hen<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test &quot;$ret&quo=
t; -ne &quot;0&quot;<br>
@@ -799,14 +800,14 @@ function lttng_snapshot_record ()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local trace_path=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot r=
ecord -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot r=
ecord -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Snapshot recorded&quot;<br>
=C2=A0}<br>
<br>
=C2=A0function lttng_snapshot_list ()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot l=
ist-output -s $sess_name &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot l=
ist-output -s $sess_name 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Snapshot list&quot;<br>
=C2=A0}<br>
<br>
@@ -815,7 +816,7 @@ function lttng_save()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local sess_name=3D$1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local opts=3D$2<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess=
_name $opts &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN save $sess=
_name $opts 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Session successfully saved&quot;<br=
>
=C2=A0}<br>
<br>
@@ -823,7 +824,7 @@ function lttng_load()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local opts=3D$1<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts=
 &gt;$OUTPUT_DEST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTDIR/../src/bin/lttng/$LTTNG_BIN load $opts=
 1&gt; $OUTPUT_DEST 2&gt; $ERROR_OUTPUT_DEST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok $? &quot;Load command successful&quot;<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div>

--94eb2c0885befcf7ba051d2411c7--


--===============1482546929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1482546929==--
