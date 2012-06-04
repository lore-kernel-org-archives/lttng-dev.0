From: John Steele Scott <toojays@toojays.net>
Subject: UST "Tracepoint signature mismatch" with C99 bool.
Date: Tue, 05 Jun 2012 08:49:53 +0930
Message-ID: <jqjfqp$juc$1__42157.3619278663$1338852333$gmane$org@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from plane.gmane.org ([80.91.229.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1Sbge6-00026d-S8
	for lttng-dev@lists.lttng.org; Mon, 04 Jun 2012 19:25:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1Sbgdz-0004g5-Tc
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 01:25:06 +0200
Received: from 146.174.200.100 ([146.174.200.100])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Tue, 05 Jun 2012 01:25:03 +0200
Received: from toojays by 146.174.200.100 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Tue, 05 Jun 2012 01:25:03 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I originally sent this on the 22nd of May, but it looks like it got stuck in moderation since I'm not subscribed. Reposting via gmane.comp.sysutils.lttng.devel . . .

I'm just getting started wiring my up to lttng-ust, and unfortunately
ran into an issue with the first probe I tried, which used a C99 bool
argument.

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
-	TP_ARGS(int, value),
+	TP_ARGS(bool, value),
 	TP_FIELDS(
-		ctf_integer(int, value, value)
+		ctf_integer(bool, value, value)
 	)
 )

Then when the demo is run with LTTNG_UST_DEBUG=1, a warning is shown,
like:

liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint signature mismatch, not enabling one or more tracepoints. Ensure that the tracepoint probes prototypes match the application. (in set_tracepoint() at tracepoint.c:310)
liblttng_ust_tracepoint[3315/3315]: Warning: Tracepoint "ust_tests_demo3:done" signatures: call: "_Bool, value" vs probe: "bool, value". (in set_tracepoint() at tracepoint.c:312)

It seems that TP_ARGS does not perform preprocessor expansion on the
"bool" type spec, while something underneath TP_FIELDS does. And since
(at least on this Centos 6.2 box) stdbool.h uses a #define rather than a
typedef to make bool equivalent to _Bool, liblttng detects a mismatch.

So in my tracepoint specifications, I need to remember to use the less
attractive _Bool instead of bool.

Perhaps it's worth having a special case for this where the trace/probe
signatures are compared? On the other hand, I guess nobody complained
until now? 

cheers,

John
