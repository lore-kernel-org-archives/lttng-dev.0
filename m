From: John Steele Scott <toojays@toojays.net>
Subject: UST "Tracepoint signature mismatch" with C99 bool.
Date: Tue, 22 May 2012 17:05:19 +0930
Message-ID: <8762bo7jns.fsf__30078.2510232695$1338865803$gmane$org@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pz0-f48.google.com ([209.85.210.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <toojays@toojays.net>) id 1SWjdF-00071s-FA
	for lttng-dev@lists.lttng.org; Tue, 22 May 2012 03:35:49 -0400
Received: by dadz8 with SMTP id z8so10314972dad.35
	for <lttng-dev@lists.lttng.org>; Tue, 22 May 2012 00:35:43 -0700 (PDT)
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
until now? :)

cheers,

John
