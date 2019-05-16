From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/9] Improve handling of test
 SIGTERM/SIGINT
Date: Thu, 16 May 2019 12:00:29 -0400 (EDT)
Message-ID: <215297101.2451.1558022429312.JavaMail.zimbra__13997.5176354469$1558022453$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
 <20190503135547.12968-2-mathieu.desnoyers@efficios.com>
 <20190515161917.GC14986@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 454bjq17ltzyTJ
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2019 12:00:30 -0400 (EDT)
In-Reply-To: <20190515161917.GC14986@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On May 15, 2019, at 12:19 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Hi,
> 
> Please run shellcheck on this and fix only the issue introduced.

OK

> 
> This is valid for all patches of this series.

OK

> 
> Most comments for stop_*_opt functions applies to the others since the changes
> are similar.

OK

> 
> On Fri, May 03, 2019 at 09:55:39AM -0400, Mathieu Desnoyers wrote:
>> The current state of signal handling for test scripts is: on
>> SIGTERM/SIGINT of the tests (e.g. a CTRL-C on the console), session
>> daemon and relay daemon are killed with SIGKILL, thus leaking all their
>> resources, and leaving lttng kernel modules loaded.
>> 
>> Revamp the "stop" functions to take a signal number and a timeout
>> as optional parameters. The default signal number is SIGTERM.
>> 
>> The full_cleanup trap handler now tries to nicely kill relayd and
>> sessiond (if they are present) with SIGTERM, and wait up to the
>> user-configurable LTTNG_TEST_TEARDOWN_TIMEOUT environment variable
>> (which has a default of 60s). Then, if there are still either relayd,
>> sessiond, or consumerd present, it will SIGKILL them and wait for
>> them to vanish. If it had to kill sessiond with SIGKILL, it will
>> also explicitly try to unload the lttng modules with modprobe.
>> 
>> This approach is inspired from sysv init script shutdown behavior.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>  tests/utils/utils.sh | 180 +++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 137 insertions(+), 43 deletions(-)
>> 
>> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
>> index 94b3a3c4..d273b278 100644
>> --- a/tests/utils/utils.sh
>> +++ b/tests/utils/utils.sh
>> @@ -15,14 +15,12 @@
>>  
>>  SESSIOND_BIN="lttng-sessiond"
>>  SESSIOND_MATCH=".*lttng-sess.*"
>> -SESSIOND_PIDS=""
>>  RUNAS_BIN="lttng-runas"
>>  RUNAS_MATCH=".*lttng-runas.*"
>>  CONSUMERD_BIN="lttng-consumerd"
>>  CONSUMERD_MATCH=".*lttng-consumerd.*"
>>  RELAYD_BIN="lttng-relayd"
>>  RELAYD_MATCH=".*lttng-relayd.*"
>> -RELAYD_PIDS=""
>>  LTTNG_BIN="lttng"
>>  BABELTRACE_BIN="babeltrace"
>>  OUTPUT_DEST=/dev/null
>> @@ -48,11 +46,20 @@ export LTTNG_SESSIOND_PATH="/bin/true"
>>  
>>  source $TESTDIR/utils/tap/tap.sh
>>  
>> +if [ -z $LTTNG_TEST_TEARDOWN_TIMEOUT ]; then
>> +	LTTNG_TEST_TEARDOWN_TIMEOUT=60
>> +fi
>> +
>>  function full_cleanup ()
>>  {
>> -	if [ -n "${SESSIOND_PIDS}" ] || [ -n "${RELAYD_PIDS}" ]; then
>> -		kill -9 ${SESSIOND_PIDS} ${RELAYD_PIDS} > /dev/null 2>&1
>> -	fi
>> +	# Try to kill daemons gracefully
>> +	stop_lttng_relayd_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
>> +	stop_lttng_sessiond_notap SIGTERM $LTTNG_TEST_TEARDOWN_TIMEOUT
>> +
>> +	# If daemons are still present, forcibly kill them
>> +	stop_lttng_relayd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
>> +	stop_lttng_sessiond_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
>> +	stop_lttng_consumerd_notap SIGKILL $LTTNG_TEST_TEARDOWN_TIMEOUT
>>  
>>  	# Disable trap for SIGTERM since the following kill to the
>>  	# pidgroup will be SIGTERM. Otherwise it loops.
>> @@ -397,8 +404,6 @@ function start_lttng_relayd_opt()
>>  	else
>>  		pass "Start lttng-relayd (opt: $opt)"
>>  	fi
>> -
>> -	RELAYD_PIDS=$(pgrep $RELAYD_MATCH)
>>  }
>>  
>>  function start_lttng_relayd()
>> @@ -414,29 +419,58 @@ function start_lttng_relayd_notap()
>>  function stop_lttng_relayd_opt()
>>  {
>>  	local withtap=$1
>> +	local signal=$2
>> +	local timeout=$3
> 
> What is timeout expected unit? seconds?

Yes, will rename to "timeout_s".

> 
> If so make it explicit.
> 
>> +	local dtimeleft=
>> +	local fail=0
>> +	local pids=$(pgrep $RELAYD_MATCH)
>>  
>> -	if [ $withtap -eq "1" ]; then
>> -		diag "Killing lttng-relayd (pid: $RELAYD_PIDS)"
>> +	if [ -n "$timeout" ]; then
> 
> Add a comment on why you are doing the multiplication here (easier arithmetic
> down the line).

OK

> 
>> +		dtimeleft=$(($timeout * 2))
>> +	fi
>> +
>> +	if [ -z "$signal" ]; then
>> +		signal="SIGTERM"
>>  	fi
>> -	kill $RELAYD_PIDS 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>> +
>> +	if [ -z "$pids" ]; then
>> +		if [ $withtap -eq "1" ]; then
>> +			pass "No relay daemon to kill"
>> +		fi
>> +		return 0
>> +	fi
>> +
>> +	diag "Killing (signal $signal) lttng-relayd (pid: $pids)"
>> +
>> +	kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>>  	retval=$?
>>  
>>  	if [ $? -eq 1 ]; then
>> +		fail=1
> 
> "fail" is set here but never reused, is there a check on "fail" missing down the
> road?

Will change the functions to return "$retval", and rename fail to retval,
and remove the retval=$? which becomes redundant.

> 
>>  		if [ $withtap -eq "1" ]; then
>>  			fail "Kill relay daemon"
>>  		fi
>> -		return 1
>>  	else
>>  		out=1
>>  		while [ -n "$out" ]; do
>>  			out=$(pgrep $RELAYD_MATCH)
>> +			if [ -n "$dtimeleft" ]; then
>> +				if [ $dtimeleft -lt 0 ]; then
>> +					out=
>> +					fail=1
>> +				fi
>> +				dtimeleft=$(($dtimeleft - 1))
>> +			fi
>>  			sleep 0.5
> 
> We could also consider using 1 here and remove the * 2 found earlier.
> 
> We aren't that time sensitive. If we want to go that route, let's use 0.1 here
> and * 10 as the base multiplier.

The intent of this patchset is not to tweak the delay wait increments.
Feel free to propose that change later on. I'm keeping the existing
delays for now.

> 
>>  		done
>>  		if [ $withtap -eq "1" ]; then
>> -			pass "Kill relay daemon"
>> +			if [ $fail -eq "0" ]; then
>> +				pass "Wait after kill relay daemon"
>> +			else
>> +				fail "Wait after kill relay daemon"
>> +			fi
>>  		fi
>>  	fi
>> -	RELAYD_PIDS=""
> 
> Should retval be 1 if we failed due to timeout?

Yes. I'm correcting this as well.

> 
> The matter of "do we need retval here?" will be for another time.

indeed.

> 
>>  	return $retval
>>  }
>>  
>> @@ -508,7 +542,6 @@ function start_lttng_sessiond_opt()
>>  			ok $status "Start session daemon"
>>  		fi
>>  	fi
>> -	SESSIOND_PIDS=$(pgrep $SESSIOND_MATCH)
>>  }
>>  
>>  function start_lttng_sessiond()
>> @@ -525,24 +558,43 @@ function stop_lttng_sessiond_opt()
>>  {
>>  	local withtap=$1
>>  	local signal=$2
>> -	local kill_opt=""
>> +	local timeout=$3
>> +	local dtimeleft=
>> +	local fail=0
>>  
>> -	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
>> +	if [ -n "$timeout" ]; then
>> +		dtimeleft=$(($timeout * 2))
>> +	fi
>> +
>> +	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
>>  		# Env variable requested no session daemon
>>  		return
>>  	fi
>>  
>> -	local pids="${SESSIOND_PIDS} $(pgrep $RUNAS_MATCH)"
>> +	local runas_pids=$(pgrep $RUNAS_MATCH)
>> +	local pids=$(pgrep $SESSIOND_MATCH)
>>  
>> -	if [ -n "$2" ]; then
>> -		kill_opt="$kill_opt -s $signal"
>> +	if [ -n "$runas_pids" ]; then
>> +		pids="$pids $runas_pids"
>>  	fi
>> -	if [ $withtap -eq "1" ]; then
>> -		diag "Killing $SESSIOND_BIN and lt-$SESSIOND_BIN pids: $(echo $pids | tr '\n'
>> ' ')"
>> +
>> +	if [ -z "$pids" ]; then
>> +		if [ $withtap -eq "1" ]; then
>> +			pass "No session daemon to kill"
>> +		fi
>> +		return
>>  	fi
>> -	kill $kill_opt $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>> +
>> +	if [ -z "$signal" ]; then
>> +		signal=SIGTERM
>> +	fi
> 
> Move this after variable declaration at the top.

ok

> 
>> +
>> +	diag "Killing (signal $signal) $SESSIOND_BIN and lt-$SESSIOND_BIN pids: $(echo
>> $pids | tr '\n' ' ')"
>> +
>> +	kill -s $signal $pids 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>>  
>>  	if [ $? -eq 1 ]; then
>> +		fail=1
> 
> "fail" is set but never used. Is it intentional?

fixing.

Thanks,

Mathieu

> 
>>  		if [ $withtap -eq "1" ]; then
>>  			fail "Kill sessions daemon"
>>  		fi
>> @@ -550,17 +602,44 @@ function stop_lttng_sessiond_opt()
>>  		out=1
>>  		while [ -n "$out" ]; do
>>  			out=$(pgrep ${SESSIOND_MATCH})
>> +			if [ -n "$dtimeleft" ]; then
>> +				if [ $dtimeleft -lt 0 ]; then
>> +					out=
>> +					fail=1
>> +				fi
>> +				dtimeleft=$(($dtimeleft - 1))
>> +			fi
>>  			sleep 0.5
>>  		done
>>  		out=1
>>  		while [ -n "$out" ]; do
>>  			out=$(pgrep $CONSUMERD_MATCH)
>> +			if [ -n "$dtimeleft" ]; then
>> +				if [ $dtimeleft -lt 0 ]; then
>> +					out=
>> +					fail=1
>> +				fi
>> +				dtimeleft=$(($dtimeleft - 1))
>> +			fi
>>  			sleep 0.5
>>  		done
>>  
>> -		SESSIOND_PIDS=""
>>  		if [ $withtap -eq "1" ]; then
>> -			pass "Kill session daemon"
>> +			if [ $fail -eq "0" ]; then
>> +				pass "Wait after kill session daemon"
>> +			else
>> +				fail "Wait after kill session daemon"
>> +			fi
>> +		fi
>> +	fi
>> +	if [ "$signal" = "SIGKILL" ]; then
>> +		if [ "$(id -u)" -eq "0" ]; then
>> +			local modules="$(lsmod | grep ^lttng | awk '{print $1}')"
>> +
>> +			if [ -n "$modules" ]; then
>> +				diag "Unloading all LTTng modules"
>> +				modprobe -r $modules
>> +			fi
>>  		fi
>>  	fi
>>  }
>> @@ -579,21 +658,18 @@ function sigstop_lttng_sessiond_opt()
>>  {
>>  	local withtap=$1
>>  	local signal=SIGSTOP
>> -	local kill_opt=""
>>  
>> -	if [ -n $TEST_NO_SESSIOND ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
>> +	if [ -n "$TEST_NO_SESSIOND" ] && [ "$TEST_NO_SESSIOND" == "1" ]; then
>>  		# Env variable requested no session daemon
>>  		return
>>  	fi
>>  
>>  	PID_SESSIOND="$(pgrep ${SESSIOND_MATCH}) $(pgrep $RUNAS_MATCH)"
>>  
>> -	kill_opt="$kill_opt -s $signal"
>> -
>>  	if [ $withtap -eq "1" ]; then
>>  		diag "Sending SIGSTOP to lt-$SESSIOND_BIN and $SESSIOND_BIN pids: $(echo
>>  		$PID_SESSIOND | tr '\n' ' ')"
>>  	fi
>> -	kill $kill_opt $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>> +	kill -s $signal $PID_SESSIOND 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>>  
>>  	if [ $? -eq 1 ]; then
>>  		if [ $withtap -eq "1" ]; then
>> @@ -635,26 +711,37 @@ function stop_lttng_consumerd_opt()
>>  {
>>  	local withtap=$1
>>  	local signal=$2
>> -	local kill_opt=""
>> +	local timeout=$3
>> +	local dtimeleft=
>> +	local fail=0
>>  
>>  	PID_CONSUMERD=$(pgrep $CONSUMERD_MATCH)
>>  
>> -	if [ -n "$2" ]; then
>> -		kill_opt="$kill_opt -s $signal"
>> +	if [ -n "$timeout" ]; then
>> +		dtimeleft=$(($timeout * 2))
>>  	fi
>>  
>> -	if [ $withtap -eq "1" ]; then
>> -		diag "Killing $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n' ' ')"
>> +	if [ -z "$signal" ]; then
>> +		signal=SIGTERM
>>  	fi
>>  
>> -	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>> +	if [ -z "$PID_CONSUMERD" ]; then
>> +		if [ $withtap -eq "1" ]; then
>> +			pass "No consumer daemon to kill"
>> +		fi
>> +		return
>> +	fi
>> +
>> +	diag "Killing (signal $signal) $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr
>> '\n' ' ')"
>> +
>> +	kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>>  	retval=$?
>>  
>>  	if [ $? -eq 1 ]; then
>> +		fail=1
>>  		if [ $withtap -eq "1" ]; then
>>  			fail "Kill consumer daemon"
>>  		fi
>> -		return 1
>>  	else
>>  		out=1
>>  		while [ $out -ne 0 ]; do
>> @@ -669,10 +756,21 @@ function stop_lttng_consumerd_opt()
>>  					out=1
>>  				fi
>>  			done
>> +			if [ -n "$dtimeleft" ]; then
>> +				if [ $dtimeleft -lt 0 ]; then
>> +					out=0
>> +					fail=1
>> +				fi
>> +				dtimeleft=$(($dtimeleft - 1))
>> +			fi
>>  			sleep 0.5
>>  		done
>>  		if [ $withtap -eq "1" ]; then
>> -			pass "Kill consumer daemon"
>> +			if [ $fail -eq "0" ]; then
>> +				pass "Wait after kill consumer daemon"
>> +			else
>> +				fail "Wait after kill consumer daemon"
>> +			fi
>>  		fi
>>  	fi
>>  	return $retval
>> @@ -692,16 +790,12 @@ function sigstop_lttng_consumerd_opt()
>>  {
>>  	local withtap=$1
>>  	local signal=SIGSTOP
>> -	local kill_opt=""
>>  
>>  	PID_CONSUMERD=$(pgrep $CONSUMERD_MATCH)
>>  
>> -	kill_opt="$kill_opt -s $signal"
>> +	diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n'
>> ' ')"
>>  
>> -	if [ $withtap -eq "1" ]; then
>> -		diag "Sending SIGSTOP to $CONSUMERD_BIN pids: $(echo $PID_CONSUMERD | tr '\n'
>> ' ')"
>> -	fi
>> -	kill $kill_opt $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>> +	kill -s $signal $PID_CONSUMERD 1> $OUTPUT_DEST 2> $ERROR_OUTPUT_DEST
>>  	retval=$?
>>  
>>  	if [ $? -eq 1 ]; then
>> --
>> 2.11.0
>> 
> 
> --
> Jonathan Rajotte-Julien
> EfficiOS

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
