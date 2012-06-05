From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST "Tracepoint signature mismatch" with C99 bool.
Date: Tue, 5 Jun 2012 13:14:18 -0400
Message-ID: <20120605171418.GA22608__18407.2764277973$1338916488$gmane$org@Krystal>
References: <jqjfqp$juc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SbxKl-0002PZ-U2
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 13:14:19 -0400
Content-Disposition: inline
In-Reply-To: <jqjfqp$juc$1@dough.gmane.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: John Steele Scott <toojays@toojays.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* John Steele Scott (toojays@toojays.net) wrote:
> I originally sent this on the 22nd of May, but it looks like it got stuck in moderation since I'm not subscribed. Reposting via gmane.comp.sysutils.lttng.devel . . .
> 
> I'm just getting started wiring my up to lttng-ust, and unfortunately
> ran into an issue with the first probe I tried, which used a C99 bool
> argument.

Fixed by commit:

commit 9eb061825ad8ebdf8c22d812eff0232d97d72cd2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Jun 5 13:08:54 2012 -0400

    Fix: perform macro expansion on tracepoint signatures
    
    The problem can be seen by patching the demo test from lttng-ust as
    follows:
    
    --- a/tests/demo/ust_tests_demo3.h
    +++ b/tests/demo/ust_tests_demo3.h
    @@ -22,12 +22,14 @@ extern "C" {
      * all copies or substantial portions of the Software.
      */
    
    +#include <stdbool.h>
    +
     #include <lttng/tracepoint.h>
    
     TRACEPOINT_EVENT(ust_tests_demo3, done,
    -       TP_ARGS(int, value),
    +       TP_ARGS(bool, value),
            TP_FIELDS(
    -               ctf_integer(int, value, value)
    +               ctf_integer(bool, value, value)
            )
     )
    
    Then when the demo is run with LTTNG_UST_DEBUG=1, a warning is shown,
    like:
    
    liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint signature mismatch, 
    enabling one or more tracepoints. Ensure that the tracepoint probes prototyp
    match the application. (in set_tracepoint() at tracepoint.c:310)
    liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint "ust_tests_demo3:don
    signatures: call: "_Bool, value" vs probe: "bool, value". (in set_tracepoint
    at tracepoint.c:312)

    It seems that TP_ARGS does not perform preprocessor expansion on the
    "bool" type spec, while something underneath TP_FIELDS does. And since
    (at least on this Centos 6.2 box) stdbool.h uses a #define rather than a
    typedef to make bool equivalent to _Bool, liblttng detects a mismatch.
    
    Reported-by: John Steele Scott <toojays@toojays.net>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


And tested by commit f121009f677db0f9444e0683e24315eed9c5973d

(master branch commits).

I'll immediately merge these into stable-2.0.

Thanks!

Mathieu


> 
> The problem can be seen by patching the demo test from lttng-ust as
> follows:
> 
> --- a/tests/demo/ust_tests_demo3.h
> +++ b/tests/demo/ust_tests_demo3.h
> @@ -22,12 +22,14 @@ extern "C" {
>   * all copies or substantial portions of the Software.
>   */
>  
> +#include <stdbool.h>
> +
>  #include <lttng/tracepoint.h>
>  
>  TRACEPOINT_EVENT(ust_tests_demo3, done,
> -	TP_ARGS(int, value),
> +	TP_ARGS(bool, value),
>  	TP_FIELDS(
> -		ctf_integer(int, value, value)
> +		ctf_integer(bool, value, value)
>  	)
>  )
> 
> Then when the demo is run with LTTNG_UST_DEBUG=1, a warning is shown,
> like:
> 
> liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint signature mismatch, not enabling one or more tracepoints. Ensure that the tracepoint probes prototypes match the application. (in set_tracepoint() at tracepoint.c:310)
> liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint "ust_tests_demo3:done" signatures: call: "_Bool, value" vs probe: "bool, value". (in set_tracepoint() at tracepoint.c:312)
> 
> It seems that TP_ARGS does not perform preprocessor expansion on the
> "bool" type spec, while something underneath TP_FIELDS does. And since
> (at least on this Centos 6.2 box) stdbool.h uses a #define rather than a
> typedef to make bool equivalent to _Bool, liblttng detects a mismatch.
> 
> So in my tracepoint specifications, I need to remember to use the less
> attractive _Bool instead of bool.
> 
> Perhaps it's worth having a special case for this where the trace/probe
> signatures are compared? On the other hand, I guess nobody complained
> until now? 
> 
> cheers,
> 
> John
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
