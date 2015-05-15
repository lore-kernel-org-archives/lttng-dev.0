From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Python agent: update
 after	Python agent refactoring
Date: Fri, 15 May 2015 16:15:55 +0000 (UTC)
Message-ID: <1881548327.2133.1431706555404.JavaMail.zimbra__16514.5495477647$1431706696$gmane$org@efficios.com>
References: <1427847007-29752-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YtIHJ-0006k0-0n
 for lttng-dev@lists.lttng.org; Fri, 15 May 2015 12:16:03 -0400
In-Reply-To: <1427847007-29752-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jeremie,

I just merged the UST refactor needed for this tools
patch. Can you look into merging it ?

Thanks!

Mathieu

----- Original Message -----
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
>  ----------------------
>  tests/regression/ust/python-logging/test.py        | 71 ++++++++++++++++++++
>  .../ust/python-logging/test_python_logging         | 76
>  ++++++++++++----------
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
> -# This library is free software; you can redistribute it and/or modify it
> under
> -# the terms of the GNU Lesser General Public License as published by the
> Free
> -# Software Foundation; version 2.1 of the License.
> -#
> -# This library is distributed in the hope that it will be useful, but
> WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> -# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> -# details.
> -#
> -# You should have received a copy of the GNU Lesser General Public License
> -# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> -# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> -
> -import sys
> -import logging
> -import errno
> -
> -from time import sleep
> -
> -def cleanup(code, agent = None):
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
> -    agent = lttng_agent.LTTngAgent()
> -    ev1 = logging.getLogger("python-ev-test1");
> -    ev2 = logging.getLogger("python-ev-test2");
> -
> -    try:
> -        nr_iter = int(sys.argv[1])
> -        wait_time = int(sys.argv[2])
> -        fire_debug_ev = 0
> -        fire_second_ev = 0
> -    except IndexError as e:
> -        print("Missing arguments. Aborting")
> -        cleanup(errno.EINVAL, agent)
> -    except ValueError as e:
> -        print("Invalid arguments. Aborting")
> -        cleanup(errno.EINVAL, agent)
> -
> -    if len(sys.argv) > 3:
> -        fire_debug_ev = int(sys.argv[3])
> -    if len(sys.argv) > 4:
> -        fire_second_ev = int(sys.argv[4])
> -
> -    for i in range(0, nr_iter):
> -        ev1.info("%s fired" % ev1.name)
> -        if fire_debug_ev != 0:
> -            ev1.debug("%s DEBUG fired" % ev1.name)
> -        sleep(wait_time)
> -
> -    if fire_second_ev != 0:
> -        ev2.info("%s fired" % ev2.name)
> -
> -if __name__ == "__main__":
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
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
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
> +    print(msg, file=sys.stderr)
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
> +    ev1 = logging.getLogger('python-ev-test1');
> +    ev2 = logging.getLogger('python-ev-test2');
> +
> +    logging.basicConfig()
> +
> +    try:
> +        nr_iter = int(sys.argv[1])
> +        wait_time = float(sys.argv[2])
> +        fire_debug_ev = False
> +        fire_second_ev = False
> +    except (IndexError) as e:
> +        _perror('missing arguments: {}'.format(e))
> +    except (ValueError) as e:
> +        _perror('invalid arguments: {}'.format(e))
> +
> +    try:
> +        if len(sys.argv) > 3:
> +            fire_debug_ev = int(sys.argv[3])
> +        if len(sys.argv) > 4:
> +            fire_second_ev = int(sys.argv[4])
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
> +if __name__ == '__main__':
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
>  # This program is free software; you can redistribute it and/or modify it
>  under
> @@ -15,13 +16,13 @@
>  # this program; if not, write to the Free Software Foundation, Inc., 51
>  # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  
> -TEST_DESC="Java Python support"
> +TEST_DESC="Python support"
>  
>  CURDIR=$(dirname $0)/
>  TESTDIR=$CURDIR/../../..
>  NR_ITER=5
>  NR_SEC_WAIT=1
> -TESTAPP_NAME="LTTngTest"
> +TESTAPP_NAME="test"
>  TESTAPP_BIN="$TESTAPP_NAME.py"
>  TESTAPP_PATH="$CURDIR"
>  SESSION_NAME="python-test"
> @@ -29,16 +30,17 @@ EVENT_NAME="python-ev-test1"
>  EVENT_NAME2="python-ev-test2"
>  OUTPUT_DEST="/dev/null"
>  
> -NUM_TESTS=156
> +NUM_TESTS=310
>  
>  source $TESTDIR/utils/utils.sh
>  
>  function run_app
>  {
> -	local debug_tp=$1
> -	local fire_second_tp=$2
> +	local python=$1
> +	local debug_tp=$2
> +	local fire_second_tp=$3
>  
> -	python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_tp
> $fire_second_tp
> +	$python $TESTAPP_PATH/$TESTAPP_BIN $NR_ITER $NR_SEC_WAIT $debug_tp
> $fire_second_tp
>  }
>  
>  function run_app_background
> @@ -94,7 +96,7 @@ function test_python_before_start ()
>  	enable_python_lttng_event $SESSION_NAME $EVENT_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app_background
> +	run_app_background $1
>  
>  	start_lttng_tracing $SESSION_NAME
>  
> @@ -120,7 +122,7 @@ function test_python_after_start ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app
> +	run_app $1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -141,7 +143,7 @@ function test_python_loglevel ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app
> +	run_app $1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -159,7 +161,7 @@ function test_python_loglevel ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app
> +	run_app $1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -177,7 +179,7 @@ function test_python_loglevel ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app
> +	run_app $1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -197,7 +199,7 @@ function test_python_loglevel_multiple ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire two TP.
> -	run_app 1
> +	run_app $1 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -214,7 +216,7 @@ function test_python_loglevel_multiple ()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire two TP.
> -	run_app 1
> +	run_app $1 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -239,7 +241,7 @@ function test_python_multi_session_loglevel()
>  	start_lttng_tracing $SESSION_NAME-2
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 1 1
> +	run_app $1 1 1
>  
>  	stop_lttng_tracing $SESSION_NAME-1
>  	stop_lttng_tracing $SESSION_NAME-2
> @@ -278,7 +280,7 @@ function test_python_multi_session_disable()
>  	start_lttng_tracing $SESSION_NAME-2
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME-1
>  	stop_lttng_tracing $SESSION_NAME-2
> @@ -313,7 +315,7 @@ function test_python_multi_session_disable_wildcard()
>  	start_lttng_tracing $SESSION_NAME-1
>  	start_lttng_tracing $SESSION_NAME-2
>  
> -	run_app
> +	run_app $1
>  
>  	stop_lttng_tracing $SESSION_NAME-1
>  	stop_lttng_tracing $SESSION_NAME-2
> @@ -346,7 +348,7 @@ function test_python_disable_all()
>  
>  	start_lttng_tracing $SESSION_NAME
>  
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -372,7 +374,7 @@ function test_python_multi_session()
>  	start_lttng_tracing $SESSION_NAME-2
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME-1
>  	stop_lttng_tracing $SESSION_NAME-2
> @@ -401,7 +403,7 @@ function test_python_destroy_session()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app_background 0 1
> +	run_app_background $1 0 1
>  
>  	# Wait for the applications started in background
>  	wait
> @@ -420,7 +422,7 @@ function test_python_destroy_session()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay
> -	run_app_background 0 1
> +	run_app_background $1 0 1
>  
>  	# Wait for the applications started in background
>  	wait
> @@ -441,11 +443,11 @@ function test_python_filtering()
>  
>  	create_lttng_session $SESSION_NAME $TRACE_PATH/$SESSION_NAME
>  	# Enable all event with a filter.
> -	enable_python_filter $SESSION_NAME '*' 'msg == "python-ev-test2 fired"'
> +	enable_python_filter $SESSION_NAME '*' 'msg == "python-ev-test2 fired
> [INFO]"'
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -459,11 +461,11 @@ function test_python_filtering()
>  	create_lttng_session $SESSION_NAME $TRACE_PATH/$SESSION_NAME
>  	# Enable first Logger but filter msg payload for the INFO one while
>  	# triggering the debug and second TP.
> -	enable_python_filter $SESSION_NAME $EVENT_NAME 'msg == "python-ev-test1
> fired"'
> +	enable_python_filter $SESSION_NAME $EVENT_NAME 'msg == "python-ev-test1
> fired [INFO]"'
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay, fire debug and second TP.
> -	run_app 1 1
> +	run_app $1 1 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -487,7 +489,7 @@ function test_python_disable()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -511,7 +513,7 @@ function test_python_disable_enable()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -539,7 +541,7 @@ function test_python_filter_loglevel()
>  	start_lttng_tracing $SESSION_NAME
>  
>  	# Run 5 times with a 1 second delay and fire second TP.
> -	run_app 0 1
> +	run_app $1 0 1
>  
>  	stop_lttng_tracing $SESSION_NAME
>  	destroy_lttng_session $SESSION_NAME
> @@ -582,15 +584,19 @@ skip $withapp "Python support is needed. Skipping all
> tests." $NUM_TESTS ||
>  		test_python_filter_loglevel
>  	)
>  
> -	for fct_test in ${tests[@]};
> +	for python_version in 2 3;
>  	do
> -		TRACE_PATH=$(mktemp -d)
> -
> -		${fct_test}
> -		if [ $? -ne 0 ]; then
> -			break;
> -		fi
> -		rm -rf $TRACE_PATH
> +		for fct_test in ${tests[@]};
> +		do
> +			TRACE_PATH=$(mktemp -d)
> +
> +			diag "(Python $python_version)"
> +			${fct_test} python$python_version
> +			if [ $? -ne 0 ]; then
> +				break;
> +			fi
> +			rm -rf $TRACE_PATH
> +		done
>  	done
>  
>  	stop_lttng_sessiond
> --
> 2.3.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
