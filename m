From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: add missing UST perf counter
	support check
Date: Mon, 12 Jan 2015 17:14:52 -0500
Message-ID: <1421100892-7029-1-git-send-email-mathieu.desnoyers__32583.4042895169$1421100982$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YAnGJ-0005tL-M3
 for lttng-dev@lists.lttng.org; Mon, 12 Jan 2015 17:15:08 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Report whether performance counters are supported by UST on the
architecture as soon as the user try to enable a perf counter context.

Fixes #851

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/trace-ust.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index a3e25aa..4f06f1b 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -470,7 +470,12 @@ int trace_ust_context_type_event_to_ust(enum lttng_event_context_type type)
 		utype = LTTNG_UST_CONTEXT_IP;
 		break;
 	case LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER:
-		utype = LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER;
+		if (!ustctl_has_perf_counters()) {
+			utype = -1;
+			WARN("Perf counters not implemented in UST");
+		} else {
+			utype = LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER;
+		}
 		break;
 	default:
 		ERR("Invalid UST context");
-- 
2.1.1
