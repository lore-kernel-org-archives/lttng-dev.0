From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] Fix: missing context type string in
	save for ust context
Date: Mon, 9 Jun 2014 15:45:39 -0400
Message-ID: <1402343139-32428-1-git-send-email-jonathan.r.julien__32310.273909434$1402343217$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1Wu5Vw-0002Td-OR
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 15:45:58 -0400
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

Return string for LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER was missing and
caused an error on save when a context of PERF_THREAD_COUNTER type was
present (Error: Invalid parameter).

Fixes #804

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/bin/lttng-sessiond/save.c          | 4 ++++
 src/common/config/config-session-abi.h | 1 +
 src/common/config/config.c             | 1 +
 3 files changed, 6 insertions(+)

diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index 18d303c..8afdbb5 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -258,8 +258,12 @@ const char *get_ust_context_type_string(
 	case LTTNG_UST_CONTEXT_PTHREAD_ID:
 		context_type_string = config_event_context_pthread_id;
 		break;
+	case LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER:
+		context_type_string = config_event_context_perf_thread_counter;
+		break;
 	default:
 		context_type_string = NULL;
+		break;
 	}
 
 	return context_type_string;
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index 3c51883..0efd391 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -106,5 +106,6 @@ const char * const config_event_context_vppid;
 const char * const config_event_context_pthread_id;
 const char * const config_event_context_hostname;
 const char * const config_event_context_ip;
+const char * const config_event_context_perf_thread_counter;
 
 #endif /* CONFIG_SESSION_INTERNAL_H */
diff --git a/src/common/config/config.c b/src/common/config/config.c
index cdc044d..4d855bf 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -154,6 +154,7 @@ const char * const config_event_context_vppid = "VPPID";
 const char * const config_event_context_pthread_id = "PTHREAD_ID";
 const char * const config_event_context_hostname = "HOSTNAME";
 const char * const config_event_context_ip = "IP";
+const char * const config_event_context_perf_thread_counter = "PERF_THREAD_COUNTER";
 
 struct consumer_output {
 	int enabled;
-- 
2.0.0
