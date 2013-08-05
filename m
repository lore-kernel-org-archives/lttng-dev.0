From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.3 PATCH 2/2] Test: enable kernel
	events after	start
Date: Mon, 5 Aug 2013 15:07:04 -0400
Message-ID: <20130805190704.GB18891__16797.9142898277$1375729774$gmane$org@Krystal>
References: <1375716439-24407-1-git-send-email-jdesfossez@efficios.com>
	<1375716439-24407-2-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6Q7V-0003mx-Vo
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:07:14 -0400
Content-Disposition: inline
In-Reply-To: <1375716439-24407-2-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> This test detects if we actually append new metadata when enabling a
> kernel event after a start.

merged, thanks!

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  tests/regression/kernel/test_event_basic |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
> index 5c19744..a182f9f 100755
> --- a/tests/regression/kernel/test_event_basic
> +++ b/tests/regression/kernel/test_event_basic
> @@ -19,7 +19,7 @@ TEST_DESC="Kernel tracer - Basic event"
>  
>  CURDIR=$(dirname $0)/
>  TESTDIR=$CURDIR/../..
> -NUM_TESTS=12
> +NUM_TESTS=20
>  
>  source $TESTDIR/utils/utils.sh
>  
> @@ -46,6 +46,27 @@ function test_event_basic()
>  	rm -rf $TRACE_PATH
>  }
>  
> +function test_enable_after_start()
> +{
> +	TRACE_PATH=$(mktemp -d)
> +	SESSION_NAME="kernel_enable_after_start"
> +
> +	create_lttng_session $SESSION_NAME $TRACE_PATH
> +
> +	lttng_enable_kernel_event $SESSION_NAME "sched_switch"
> +
> +	start_lttng_tracing
> +	lttng_enable_kernel_event $SESSION_NAME "sched_process_exit"
> +	stop_lttng_tracing
> +
> +	validate_trace "sched_switch" $TRACE_PATH
> +	validate_trace "sched_process_exit" $TRACE_PATH
> +
> +	destroy_lttng_session $SESSION_NAME
> +
> +	rm -rf $TRACE_PATH
> +}
> +
>  # MUST set TESTDIR before calling those functions
>  plan_tests $NUM_TESTS
>  
> @@ -62,6 +83,7 @@ skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
>  	start_lttng_sessiond
>  
>  	test_event_basic
> +	test_enable_after_start
>  
>  	stop_lttng_sessiond
>  }
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
