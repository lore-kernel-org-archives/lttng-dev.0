From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Unable to use stalled-cycles-frontend perf counter
Date: Wed, 3 Jun 2015 05:15:31 +0000 (UTC)
Message-ID: <1493169627.2550.1433308531176.JavaMail.zimbra__4720.88862811706$1433308609$gmane$org@efficios.com>
References: <556DBE8C.7030306@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z011n-00038l-9B
 for lttng-dev@lists.lttng.org; Wed, 03 Jun 2015 01:15:49 -0400
In-Reply-To: <556DBE8C.7030306@orc-group.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrei Burov <aburov@orc-group.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 2, 2015, at 4:32 PM, Andrei Burov aburov@orc-group.com wrote:

> Hello!
> 
> I've encountered a problem with lttng (LTTng Trace Control) 2.5.0 -
> Fumisterie. When I am trying to access stalled-cycles-frontend perf
> counter, it somehow corrupts the tracefile. Below is a simple test which
> is using code of hello program from lttng doc.

See https://lists.lttng.org/pipermail/lttng-dev/2015-June/024573.html

Short story: this looks like a known fixed issue. Try upgrading your
lttng-ust and lttng-tools versions.

Thanks,

Mathieu

> 
> $ls
> hello  hello.c  hello-tp.c  hello-tp.h  hello-tp.o  hello-tp.tp
> $lttng create
> Session auto-20150602-160131 created.
> Traces will be written in /home/user/lttng-traces/auto-20150602-160131
> $lttng enable-event -u hello_world:my_first_tracepoint
> UST event hello_world:my_first_tracepoint created in channel channel0
> $lttng add-context -u -t perf:thread:stalled-cycles-frontend
> UST context perf:thread:stalled-cycles-frontend added to all channels
> $lttng start
> Tracing started for session auto-20150602-160131
> $./hello
> Hello, World!
> Press Enter to continue...
> 
> Quitting now!
> lttng stop
> Waiting for data availability.
> Tracing stopped for session auto-20150602-160131
> $lttng view
> Trace directory: /home/user/lttng-traces/auto-20150602-160131
> [error] Cannot open any trace for reading.
> [error] opening trace "/home/user/lttng-traces/auto-20150602-160131" for
> reading.
> [error] none of the specified trace paths could be opened.
> $lttng destroy && lttng create
> Session auto-20150602-160131 destroyed
> Session auto-20150602-160224 created.
> Traces will be written in /home/user/lttng-traces/auto-20150602-160224
> $lttng enable-event -u hello_world:my_first_tracepoint
> UST event hello_world:my_first_tracepoint created in channel channel0
> $lttng add-context -u -t perf:thread:cycles
> UST context perf:thread:cycles added to all channels
> $lttng start
> Tracing started for session auto-20150602-160224
> $./hello
> Hello, World!
> Press Enter to continue...
> 
> Quitting now!
> $lttng stop
> Waiting for data availability.
> Tracing stopped for session auto-20150602-160224
> $lttng view
> Trace directory: /home/user/lttng-traces/auto-20150602-160224
> 
> [16:03:14.431724221] (+?.?????????) krypton.com
> hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
> 281474976715686 }, { my_string_field = "hi there!", my_integer_field = 23 }
> [16:03:14.432296656] (+0.000572435) krypton.com
> hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
> 281474976722947 }, { my_string_field = "./hello", my_integer_field = 0 }
> [16:03:14.432300284] (+0.000003628) krypton.com
> hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
> 281474976726469 }, { my_string_field = "x^2", my_integer_field = 1 }
> 
> Thanks for your help!
> Andrei
> 
> ________________________________
> 
> This e-mail is confidential and may contain legally privileged information. It
> is intended only for the addressees. If you have received this e-mail in error,
> kindly notify us immediately by telephone or e-mail and delete the message from
> your system.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
