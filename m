From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/6] Improve handling of test
 SIGTERM/SIGINT (v2)
Date: Thu, 5 Sep 2019 16:54:08 -0400
Message-ID: <20190905205408.GA20141__41066.9654536591$1567716868$gmane$org@gmail.com>
References: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by lists.lttng.org (Postfix) with ESMTPS id 46PXx04ZRFzsLf
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 16:54:12 -0400 (EDT)
Received: by mail-qk1-f193.google.com with SMTP id s18so3613234qkj.3
 for <lttng-dev@lists.lttng.org>; Thu, 05 Sep 2019 13:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190516190801.16878-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, joraj@efficios.com
List-Id: lttng-dev@lists.lttng.org

Series merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Thu, May 16, 2019 at 03:07:56PM -0400, Mathieu Desnoyers wrote:
> The current state of signal handling for test scripts is: on
> SIGTERM/SIGINT of the tests (e.g. a CTRL-C on the console), session
> daemon and relay daemon are killed with SIGKILL, thus leaking all their
> resources, and leaving lttng kernel modules loaded.
> =

> Revamp the "stop" functions to take a signal number and a timeout
> as optional parameters. The default signal number is SIGTERM.
> =

> The full_cleanup trap handler now tries to nicely kill relayd and
> sessiond (if they are present) with SIGTERM, and wait up to the
> user-configurable LTTNG_TEST_TEARDOWN_TIMEOUT environment variable
> (which has a default of 60s). Then, if there are still either relayd,
> sessiond, or consumerd present, it will SIGKILL them and wait for
> them to vanish. If it had to kill sessiond with SIGKILL, it will
> also explicitly try to unload the lttng modules with modprobe.
> =

> This approach is inspired from sysv init script shutdown behavior.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> Changes since v1:
> - Take care of feedback from Jonathan Rajotte,
> - Run through shellcheck.
> ---
>  tests/utils/utils.sh | 296 +++++++++++++++++++++++++++++--------------
>  1 file changed, 204 insertions(+), 92 deletions(-)
> =

> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index 94b3a3c4..8f6381eb 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -15,14 +15,12 @@
>  =

>  SESSIOND_BIN=3D"lttng-sessiond"
>  SESSIOND_MATCH=3D".*lttng-sess.*"
> -SESSIOND_PIDS=3D""
>  RUNAS_BIN=3D"lttng-runas"
>  RUNAS_MATCH=3D".*lttng-runas.*"
>  CONSUMERD_BIN=3D"lttng-consumerd"
>  CONSUMERD_MATCH=3D".*lttng-consumerd.*"
>  RELAYD_BIN=3D"lttng-relayd"
>  RELAYD_MATCH=3D".*lttng-relayd.*"
> -RELAYD_PIDS=3D""
>  LTTNG_BIN=3D"lttng"
>  BABELTRACE_BIN=3D"babeltrace"
>  OUTPUT_DEST=3D/dev/null
> @@ -48,11 +46,20 @@ export LTTNG_SESSIOND_PATH=3D"/bin/true"
>  =

>  source $TESTDIR/utils/tap/tap.sh
>  =

> +if [ -z $LTTNG_TEST_TEARDOWN_TIMEOUT ]; then
> +	LTTNG_TEST_TEARDOWN_TIMEOUT=3D60
> +fi
> +
>  function full_cleanup ()
>  {
> -	if [ -n "${SESSIOND_PIDS}" ] || [ -n "${RELAYD_PIDS}" ]; then
> -		kill -9 ${SESSIOND_PIDS} ${RELAYD_PIDS} > /dev/null 2>&1
> -	fi
> +	# Try to kill daemons gracefully
> +	stop_lttng_relayd_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
> +	stop_lttng_sessiond_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
> +
> +	# If daemons are still present, forcibly kill them
> +	stop_lttng_relayd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
> +	stop_lttng_sessiond_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
> +	stop_lttng_consumerd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
>  =

>  	# Disable trap for SIGTERM since the following kill to the
>  	# pidgroup will be SIGTERM. Otherwise it loops.
> @@ -379,26 +386,25 @@ function start_lttng_relayd_opt()
>  	local withtap=3D$1
>  	local opt=3D$2
>  =

> -	DIR=3D$(readlink -f $TESTDIR)
> +	DIR=3D$(readlink -f "$TESTDIR")
>  =

> -	if [ -z $(pgrep $RELAYD_MATCH) ]; then
> -		$DIR/../src/bin/lttng-relayd/$RELAYD_BIN -b $opt 1> $OUTPUT_DEST 2> $E=
RROR_OUTPUT_DEST
> -		#$DIR/../src/bin/lttng-relayd/$RELAYD_BIN $opt -vvv >>/tmp/relayd.log =
2>&1 &
> +	if [ -z "$(pgrep "$RELAYD_MATCH")" ]; then
> +		# shellcheck disable=3DSC2086
> +		"$DIR/../src/bin/lttng-relayd/$RELAYD_BIN" -b $opt 1> $OUTPUT_DEST 2> =
$ERROR_OUTPUT_DEST
> +		#"$DIR/../src/bin/lttng-relayd/$RELAYD_BIN" $opt -vvv >>/tmp/relayd.lo=
g 2>&1 &
>  		if [ $? -eq 1 ]; then
> -			if [ $withtap -eq "1" ]; then
> +			if [ "$withtap" -eq "1" ]; then
>  				fail "Start lttng-relayd (opt: $opt)"
>  			fi
>  			return 1
>  		else
> -			if [ $withtap -eq "1" ]; then
> +			if [ "$withtap" -eq "1" ]; then
>  				pass "Start lttng-relayd (opt: $opt)"
>  			fi
>  		fi
>  	else
>  		pass "Start lttng-relayd (opt: $opt)"
>  	fi
> -
> -	RELAYD_PIDS=3D$(pgrep $RELAYD_MATCH)
>  }
>  =

>  function start_lttng_relayd()
> @@ -414,29 +420,60 @@ function start_lttng_relayd_notap()
>  function stop_lttng_relayd_opt()
>  {
>  	local withtap=3D$1
> +	local signal=3D$2
>  =

> -	if [ $withtap -eq "1" ]; then
> -		diag "Killing lttng-relayd (pid: $RELAYD_PIDS)"
> +	if [ -z "$signal" ]; then
> +		signal=3D"SIGTERM"
>  	fi
> -	kill $RELAYD_PIDS 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
> -	retval=3D$?
>  =

> -	if [ $? -eq 1 ]; then
> -		if [ $withtap -eq "1" ]; then
> +	local timeout_s=3D$3
> +	local dtimeleft_s=3D
> +
> +	# Multiply time by 2 to simplify integer arithmetic
> +	if [ -n "$timeout_s" ]; then
> +		dtimeleft_s=3D$((timeout_s * 2))
> +	fi
> +
> +	local retval=3D0
> +	local pids=3D
> +
> +	pids=3D$(pgrep "$RELAYD_MATCH")
> +	if [ -z "$pids" ]; then
> +		if [ "$withtap" -eq "1" ]; then
> +			pass "No relay daemon to kill"
> +		fi
> +		return 0
> +	fi
> +
> +	diag "Killing (signal $signal) lttng-relayd (pid: $pids)"
> +
> +	# shellcheck disable=3DSC2086
> +	if ! kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
> +		retval=3D1
> +		if [ "$withtap" -eq "1" ]; then
>  			fail "Kill relay daemon"
>  		fi
> -		return 1
>  	else
>  		out=3D1
>  		while [ -n "$out" ]; do
> -			out=3D$(pgrep $RELAYD_MATCH)
> +			out=3D$(pgrep "$RELAYD_MATCH")
> +			if [ -n "$dtimeleft_s" ]; then
> +				if [ $dtimeleft_s -lt 0 ]; then
> +					out=3D
> +					retval=3D1
> +				fi
> +				dtimeleft_s=3D$((dtimeleft_s - 1))
> +			fi
>  			sleep 0.5
>  		done
> -		if [ $withtap -eq "1" ]; then
> -			pass "Kill relay daemon"
> +		if [ "$withtap" -eq "1" ]; then
> +			if [ "$retval" -eq "0" ]; then
> +				pass "Wait after kill relay daemon"
> +			else
> +				fail "Wait after kill relay daemon"
> +			fi
>  		fi
>  	fi
> -	RELAYD_PIDS=3D""
>  	return $retval
>  }
>  =

> @@ -459,14 +496,16 @@ function start_lttng_sessiond_opt()
>  =

>  	local env_vars=3D""
>  	local consumerd=3D""
> -	local long_bit_value=3D$(getconf LONG_BIT)
>  =

> -	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; then
> +	local long_bit_value=3D
> +	long_bit_value=3D$(getconf LONG_BIT)
> +
> +	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; th=
en
>  		# Env variable requested no session daemon
>  		return
>  	fi
>  =

> -	DIR=3D$(readlink -f $TESTDIR)
> +	DIR=3D$(readlink -f "$TESTDIR")
>  =

>  	# Get long_bit value for 32/64 consumerd
>  	case "$long_bit_value" in
> @@ -483,32 +522,33 @@ function start_lttng_sessiond_opt()
>  =

>  	# Check for env. variable. Allow the use of LD_PRELOAD etc.
>  	if [[ "x${LTTNG_SESSIOND_ENV_VARS}" !=3D "x" ]]; then
> -		env_vars=3D${LTTNG_SESSIOND_ENV_VARS}
> +		env_vars=3D"${LTTNG_SESSIOND_ENV_VARS} "
>  	fi
> +	env_vars=3D"${env_vars}$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN"
>  =

> -	validate_kernel_version
> -	if [ $? -ne 0 ]; then
> +	if ! validate_kernel_version; then
>  	    fail "Start session daemon"
>  	    BAIL_OUT "*** Kernel too old for session daemon tests ***"
>  	fi
>  =

> -	: ${LTTNG_SESSION_CONFIG_XSD_PATH=3D${DIR}/../src/common/config/}
> +	: "${LTTNG_SESSION_CONFIG_XSD_PATH=3D"${DIR}/../src/common/config/"}"
>  	export LTTNG_SESSION_CONFIG_XSD_PATH
>  =

> -	if [ -z $(pgrep ${SESSIOND_MATCH}) ]; then
> +	if [ -z "$(pgrep "${SESSIOND_MATCH}")" ]; then
>  		# Have a load path ?
>  		if [ -n "$load_path" ]; then
> -			env $env_vars $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --load "$l=
oad_path" --background $consumerd
> +			# shellcheck disable=3DSC2086
> +			env $env_vars --load "$load_path" --background "$consumerd"
>  		else
> -			env $env_vars $DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --backgrou=
nd $consumerd
> +			# shellcheck disable=3DSC2086
> +			env $env_vars --background "$consumerd"
>  		fi
>  		#$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd=
32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-p=
ath=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --verbose-consumer =
>>/tmp/sessiond.log 2>&1
>  		status=3D$?
> -		if [ $withtap -eq "1" ]; then
> +		if [ "$withtap" -eq "1" ]; then
>  			ok $status "Start session daemon"
>  		fi
>  	fi
> -	SESSIOND_PIDS=3D$(pgrep $SESSIOND_MATCH)
>  }
>  =

>  function start_lttng_sessiond()
> @@ -525,44 +565,98 @@ function stop_lttng_sessiond_opt()
>  {
>  	local withtap=3D$1
>  	local signal=3D$2
> -	local kill_opt=3D""
>  =

> -	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; then
> +	if [ -z "$signal" ]; then
> +		signal=3DSIGTERM
> +	fi
> +
> +	local timeout_s=3D$3
> +	local dtimeleft_s=3D
> +
> +	# Multiply time by 2 to simplify integer arithmetic
> +	if [ -n "$timeout_s" ]; then
> +		dtimeleft_s=3D$((timeout_s * 2))
> +	fi
> +
> +	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; th=
en
>  		# Env variable requested no session daemon
> -		return
> +		return 0
>  	fi
>  =

> -	local pids=3D"${SESSIOND_PIDS} $(pgrep $RUNAS_MATCH)"
> +	local retval=3D0
>  =

> -	if [ -n "$2" ]; then
> -		kill_opt=3D"$kill_opt -s $signal"
> +	local runas_pids=3D
> +	runas_pids=3D$(pgrep "$RUNAS_MATCH")
> +
> +	local pids=3D
> +	pids=3D$(pgrep "$SESSIOND_MATCH")
> +
> +	if [ -n "$runas_pids" ]; then
> +		pids=3D"$pids $runas_pids"
>  	fi
> -	if [ $withtap -eq "1" ]; then
> -		diag "Killing $SESSIOND_BIN and lt-$SESSIOND_BIN pids: $(echo $pids | =
tr '\n' ' ')"
> +
> +	if [ -z "$pids" ]; then
> +		if [ "$withtap" -eq "1" ]; then
> +			pass "No session daemon to kill"
> +		fi
> +		return 0
>  	fi
> -	kill $kill_opt $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>  =

> -	if [ $? -eq 1 ]; then
> -		if [ $withtap -eq "1" ]; then
> +	diag "Killing (signal $signal) $SESSIOND_BIN and lt-$SESSIOND_BIN pids:=
 $(echo "$pids" | tr '\n' ' ')"
> +
> +	# shellcheck disable=3DSC2086
> +	if ! kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST; then
> +		retval=3D1
> +		if [ "$withtap" -eq "1" ]; then
>  			fail "Kill sessions daemon"
>  		fi
>  	else
>  		out=3D1
>  		while [ -n "$out" ]; do
> -			out=3D$(pgrep ${SESSIOND_MATCH})
> +			out=3D$(pgrep "${SESSIOND_MATCH}")
> +			if [ -n "$dtimeleft_s" ]; then
> +				if [ $dtimeleft_s -lt 0 ]; then
> +					out=3D
> +					retval=3D1
> +				fi
> +				dtimeleft_s=3D$((dtimeleft_s - 1))
> +			fi
>  			sleep 0.5
>  		done
>  		out=3D1
>  		while [ -n "$out" ]; do
> -			out=3D$(pgrep $CONSUMERD_MATCH)
> +			out=3D$(pgrep "$CONSUMERD_MATCH")
> +			if [ -n "$dtimeleft_s" ]; then
> +				if [ $dtimeleft_s -lt 0 ]; then
> +					out=3D
> +					retval=3D1
> +				fi
> +				dtimeleft_s=3D$((dtimeleft_s - 1))
> +			fi
>  			sleep 0.5
>  		done
>  =

> -		SESSIOND_PIDS=3D""
> -		if [ $withtap -eq "1" ]; then
> -			pass "Kill session daemon"
> +		if [ "$withtap" -eq "1" ]; then
> +			if [ "$retval" -eq "0" ]; then
> +				pass "Wait after kill session daemon"
> +			else
> +				fail "Wait after kill session daemon"
> +			fi
>  		fi
>  	fi
> +	if [ "$signal" =3D "SIGKILL" ]; then
> +		if [ "$(id -u)" -eq "0" ]; then
> +			local modules=3D
> +			modules=3D"$(lsmod | grep ^lttng | awk '{print $1}')"
> +
> +			if [ -n "$modules" ]; then
> +				diag "Unloading all LTTng modules"
> +				modprobe -r "$modules"
> +			fi
> +		fi
> +	fi
> +
> +	return $retval
>  }
>  =

>  function stop_lttng_sessiond()
> @@ -579,43 +673,40 @@ function sigstop_lttng_sessiond_opt()
>  {
>  	local withtap=3D$1
>  	local signal=3DSIGSTOP
> -	local kill_opt=3D""
>  =

> -	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; then
> +	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" =3D=3D "1" ]; th=
en
>  		# Env variable requested no session daemon
>  		return
>  	fi
>  =

> -	PID_SESSIOND=3D"$(pgrep ${SESSIOND_MATCH}) $(pgrep $RUNAS_MATCH)"
> -
> -	kill_opt=3D"$kill_opt -s $signal"
> +	PID_SESSIOND=3D"$(pgrep "${SESSIOND_MATCH}") $(pgrep "$RUNAS_MATCH")"
>  =

> -	if [ $withtap -eq "1" ]; then
> -		diag "Sending SIGSTOP to lt-$SESSIOND_BIN and $SESSIOND_BIN pids: $(ec=
ho $PID_SESSIOND | tr '\n' ' ')"
> +	if [ "$withtap" -eq "1" ]; then
> +		diag "Sending SIGSTOP to lt-$SESSIOND_BIN and $SESSIOND_BIN pids: $(ec=
ho "$PID_SESSIOND" | tr '\n' ' ')"
>  	fi
> -	kill $kill_opt $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>  =

> -	if [ $? -eq 1 ]; then
> -		if [ $withtap -eq "1" ]; then
> +	# shellcheck disable=3DSC2086
> +	if ! kill -s $signal $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DES=
T; then
> +		if [ "$withtap" -eq "1" ]; then
>  			fail "Sending SIGSTOP to session daemon"
>  		fi
>  	else
>  		out=3D1
>  		while [ $out -ne 0 ]; do
> -			pid=3D$(pgrep $SESSIOND_MATCH)
> +			pid=3D"$(pgrep "$SESSIOND_MATCH")"
>  =

>  			# Wait until state becomes stopped for session
>  			# daemon(s).
>  			out=3D0
>  			for sessiond_pid in $pid; do
> -				state=3D$(ps -p $sessiond_pid -o state=3D )
> +				state=3D"$(ps -p "$sessiond_pid" -o state=3D )"
>  				if [[ -n "$state" && "$state" !=3D "T" ]]; then
>  					out=3D1
>  				fi
>  			done
>  			sleep 0.5
>  		done
> -		if [ $withtap -eq "1" ]; then
> +		if [ "$withtap" -eq "1" ]; then
>  			pass "Sending SIGSTOP to session daemon"
>  		fi
>  	fi
> @@ -635,46 +726,70 @@ function stop_lttng_consumerd_opt()
>  {
>  	local withtap=3D$1
>  	local signal=3D$2
> -	local kill_opt=3D""
>  =

> -	PID_CONSUMERD=3D$(pgrep $CONSUMERD_MATCH)
> +	if [ -z "$signal" ]; then
> +		signal=3DSIGTERM
> +	fi
> +
> +	local timeout_s=3D$3
> +	local dtimeleft_s=3D
>  =

> -	if [ -n "$2" ]; then
> -		kill_opt=3D"$kill_opt -s $signal"
> +	# Multiply time by 2 to simplify integer arithmetic
> +	if [ -n "$timeout_s" ]; then
> +		dtimeleft_s=3D$((timeout_s * 2))
>  	fi
>  =

> -	if [ $withtap -eq "1" ]; then
> -		diag "Killing $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n' ' '=
)"
> +	local retval=3D0
> +
> +	PID_CONSUMERD=3D"$(pgrep "$CONSUMERD_MATCH")"
> +
> +	if [ -z "$PID_CONSUMERD" ]; then
> +		if [ "$withtap" -eq "1" ]; then
> +			pass "No consumer daemon to kill"
> +		fi
> +		return 0
>  	fi
>  =

> -	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
> -	retval=3D$?
> +	diag "Killing (signal $signal) $CONSUMERD_BIN pids: $(echo "$PID_CONSUM=
ERD" | tr '\n' ' ')"
>  =

> -	if [ $? -eq 1 ]; then
> -		if [ $withtap -eq "1" ]; then
> +	# shellcheck disable=3DSC2086
> +	if ! kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DE=
ST; then
> +		retval=3D1
> +		if [ "$withtap" -eq "1" ]; then
>  			fail "Kill consumer daemon"
>  		fi
> -		return 1
>  	else
>  		out=3D1
>  		while [ $out -ne 0 ]; do
> -			pid=3D$(pgrep $CONSUMERD_MATCH)
> +			pid=3D"$(pgrep "$CONSUMERD_MATCH")"
>  =

>  			# If consumerds are still present check their status.
>  			# A zombie status qualifies the consumerd as *killed*
>  			out=3D0
>  			for consumer_pid in $pid; do
> -				state=3D$(ps -p $consumer_pid -o state=3D )
> +				state=3D"$(ps -p "$consumer_pid" -o state=3D )"
>  				if [[ -n "$state" && "$state" !=3D "Z" ]]; then
>  					out=3D1
>  				fi
>  			done
> +			if [ -n "$dtimeleft_s" ]; then
> +				if [ $dtimeleft_s -lt 0 ]; then
> +					out=3D0
> +					retval=3D1
> +				fi
> +				dtimeleft_s=3D$((dtimeleft_s - 1))
> +			fi
>  			sleep 0.5
>  		done
> -		if [ $withtap -eq "1" ]; then
> -			pass "Kill consumer daemon"
> +		if [ "$withtap" -eq "1" ]; then
> +			if [ "$retval" -eq "0" ]; then
> +				pass "Wait after kill consumer daemon"
> +			else
> +				fail "Wait after kill consumer daemon"
> +			fi
>  		fi
>  	fi
> +
>  	return $retval
>  }
>  =

> @@ -692,40 +807,37 @@ function sigstop_lttng_consumerd_opt()
>  {
>  	local withtap=3D$1
>  	local signal=3DSIGSTOP
> -	local kill_opt=3D""
>  =

> -	PID_CONSUMERD=3D$(pgrep $CONSUMERD_MATCH)
> +	PID_CONSUMERD=3D"$(pgrep "$CONSUMERD_MATCH")"
>  =

> -	kill_opt=3D"$kill_opt -s $signal"
> +	diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo "$PID_CONSUMERD" |=
 tr '\n' ' ')"
>  =

> -	if [ $withtap -eq "1" ]; then
> -		diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | =
tr '\n' ' ')"
> -	fi
> -	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
> +	# shellcheck disable=3DSC2086
> +	kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>  	retval=3D$?
>  =

> -	if [ $? -eq 1 ]; then
> -		if [ $withtap -eq "1" ]; then
> +	if [ $retval -eq 1 ]; then
> +		if [ "$withtap" -eq "1" ]; then
>  			fail "Sending SIGSTOP to consumer daemon"
>  		fi
>  		return 1
>  	else
>  		out=3D1
>  		while [ $out -ne 0 ]; do
> -			pid=3D$(pgrep $CONSUMERD_MATCH)
> +			pid=3D"$(pgrep "$CONSUMERD_MATCH")"
>  =

>  			# Wait until state becomes stopped for all
>  			# consumers.
>  			out=3D0
>  			for consumer_pid in $pid; do
> -				state=3D$(ps -p $consumer_pid -o state=3D )
> +				state=3D"$(ps -p "$consumer_pid" -o state=3D )"
>  				if [[ -n "$state" && "$state" !=3D "T" ]]; then
>  					out=3D1
>  				fi
>  			done
>  			sleep 0.5
>  		done
> -		if [ $withtap -eq "1" ]; then
> +		if [ "$withtap" -eq "1" ]; then
>  			pass "Sending SIGSTOP to consumer daemon"
>  		fi
>  	fi
> -- =

> 2.17.1
> =
