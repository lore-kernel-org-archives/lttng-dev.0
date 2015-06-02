From: Andrei Burov <aburov@orc-group.com>
Subject: Unable to use stalled-cycles-frontend perf counter
Date: Tue, 2 Jun 2015 17:32:44 +0300
Message-ID: <556DBE8C.7030306__37952.9610895135$1433299643$gmane$org@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx02.orcsoftware.com ([89.202.167.90]
 helo=ungol.ad.orcsoftware.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Andrei.Burov@orc-group.com>) id 1YznFI-0007Ib-Kw
 for lttng-dev@lists.lttng.org; Tue, 02 Jun 2015 10:32:56 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello!

I've encountered a problem with lttng (LTTng Trace Control) 2.5.0 -
Fumisterie. When I am trying to access stalled-cycles-frontend perf
counter, it somehow corrupts the tracefile. Below is a simple test which
is using code of hello program from lttng doc.

$ls
hello  hello.c  hello-tp.c  hello-tp.h  hello-tp.o  hello-tp.tp
$lttng create
Session auto-20150602-160131 created.
Traces will be written in /home/user/lttng-traces/auto-20150602-160131
$lttng enable-event -u hello_world:my_first_tracepoint
UST event hello_world:my_first_tracepoint created in channel channel0
$lttng add-context -u -t perf:thread:stalled-cycles-frontend
UST context perf:thread:stalled-cycles-frontend added to all channels
$lttng start
Tracing started for session auto-20150602-160131
$./hello
Hello, World!
Press Enter to continue...

Quitting now!
lttng stop
Waiting for data availability.
Tracing stopped for session auto-20150602-160131
$lttng view
Trace directory: /home/user/lttng-traces/auto-20150602-160131
[error] Cannot open any trace for reading.
[error] opening trace "/home/user/lttng-traces/auto-20150602-160131" for
reading.
[error] none of the specified trace paths could be opened.
$lttng destroy && lttng create
Session auto-20150602-160131 destroyed
Session auto-20150602-160224 created.
Traces will be written in /home/user/lttng-traces/auto-20150602-160224
$lttng enable-event -u hello_world:my_first_tracepoint
UST event hello_world:my_first_tracepoint created in channel channel0
$lttng add-context -u -t perf:thread:cycles
UST context perf:thread:cycles added to all channels
$lttng start
Tracing started for session auto-20150602-160224
$./hello
Hello, World!
Press Enter to continue...

Quitting now!
$lttng stop
Waiting for data availability.
Tracing stopped for session auto-20150602-160224
$lttng view
Trace directory: /home/user/lttng-traces/auto-20150602-160224

[16:03:14.431724221] (+?.?????????) krypton.com
hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
281474976715686 }, { my_string_field = "hi there!", my_integer_field = 23 }
[16:03:14.432296656] (+0.000572435) krypton.com
hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
281474976722947 }, { my_string_field = "./hello", my_integer_field = 0 }
[16:03:14.432300284] (+0.000003628) krypton.com
hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles =
281474976726469 }, { my_string_field = "x^2", my_integer_field = 1 }

Thanks for your help!
Andrei

________________________________

This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
