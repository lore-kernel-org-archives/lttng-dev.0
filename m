From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH lttng-tools] Fix: mi test: possible race
 between listing UST events and testapp start
Date: Mon, 27 Oct 2014 15:48:15 -0500
Message-ID: <544EAF8F.7070904__25990.007867995$1414442953$gmane$org@mentor.com>
References: <1414372906-22433-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1XirDE-0007ls-7S
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:48:27 -0400
In-Reply-To: <1414372906-22433-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 10/26/2014 08:21 PM, Jonathan Rajotte wrote:
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>

More description of the change is needed IMO.

> ---
>  tests/regression/tools/mi/test_mi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
> index fa46b51..7acec18 100755
> --- a/tests/regression/tools/mi/test_mi
> +++ b/tests/regression/tools/mi/test_mi
> @@ -507,6 +507,11 @@ function test_list_ust_event ()
>  
>  	#Begin testing
>  	$TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
> +	pid=$!
> +
> +	#Wait for TESTAPP to run
> +	while ! kill -0 $pid 2> /dev/null; do :; done
> +
>  	list_lttng_with_opts "-u -f"

Is this an attempt to give the test program enough time to register
tracepoints?

If so, I agree there is a race, but I don't think this is the right way
to address it.  I would not expect the while ! kill loop to repeat at
all; if you remove the stderr redirection do you see any output, ever?

The exit status from kill $! is not a reliable indication that the shell
has execve'd the program in the background, and even if it were, it
would not be a reliable indication of how far the program has progressed
(e.g. whether it has got far enough along to register tracepoints).

If a test program needs to run in the background, yet needs to reach a
certain state before the rest of the test should proceed, then it should
have a way to indicate to the test harness that it has reached the
desired state.  The shell's rudimentary facilities for managing
concurrency are not sufficient.
