From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-modules 2/3] Add metadata env fields
Date: Tue, 13 Aug 2019 14:14:24 -0400
Message-ID: <20190813181425.9536-2-jonathan.rajotte-julien__36299.5787801751$1565720133$gmane$org@efficios.com>
References: <20190813181425.9536-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 467LTl4y1SzsV2
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 14:14:51 -0400 (EDT)
In-Reply-To: <20190813181425.9536-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add the following fields:

  - tracer_buffering_scheme
      The buffering scheme used by the tracer. lttng-modules sole
      buffering scheme is "global".
  - trace_name
      The name of the trace. Use the session name.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

This should also be backported to 2.11 allowing Babeltrace 2 to merge
traces from archived data (rotation) and output a trace with similar
lttng tree hierarchy.

---
 lttng-events.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/lttng-events.c b/lttng-events.c
index a4570b7..2e7670b 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -2478,6 +2478,60 @@ int64_t measure_clock_offset(void)
 	return offset;
 }
 
+static
+int print_escaped_ctf_string(struct lttng_session *session, const char *string)
+{
+	int ret;
+	size_t i;
+	char cur;
+
+	i = 0;
+	cur = string[i];
+	while (cur != '\0') {
+		switch (cur) {
+		case '\n':
+			ret = lttng_metadata_printf(session, "%s", "\\n");
+			break;
+		case '\\':
+		case '"':
+			ret = lttng_metadata_printf(session, "%c", '\\');
+			if (ret)
+				goto error;
+			/* We still print the current char */
+			/* Fallthrough */
+		default:
+			ret = lttng_metadata_printf(session, "%c", cur);
+			break;
+		}
+
+		if (ret)
+			goto error;
+
+		cur = string[++i];
+	}
+error:
+	return ret;
+}
+
+static
+int print_metadata_session_name(struct lttng_session *session)
+{
+	int ret;
+
+	ret = lttng_metadata_printf(session, "	trace_name = \"");
+	if (ret)
+		goto error;
+
+	ret = print_escaped_ctf_string(session, session->name);
+	if (ret)
+		goto error;
+
+	ret = lttng_metadata_printf(session, "\";\n");
+
+error:
+	return ret;
+}
+
 /*
  * Output metadata into this session's metadata buffers.
  * Must be called with sessions_mutex held.
@@ -2553,7 +2607,7 @@ int _lttng_session_metadata_statedump(struct lttng_session *session)
 		"	tracer_major = %d;\n"
 		"	tracer_minor = %d;\n"
 		"	tracer_patchlevel = %d;\n"
-		"};\n\n",
+		"	trace_buffering_scheme = \"global\";\n",
 		current->nsproxy->uts_ns->name.nodename,
 		utsname()->sysname,
 		utsname()->release,
@@ -2565,6 +2619,15 @@ int _lttng_session_metadata_statedump(struct lttng_session *session)
 	if (ret)
 		goto end;
 
+	ret = print_metadata_session_name(session);
+	if (ret)
+		goto end;
+
+	/* Close env */
+	ret = lttng_metadata_printf(session, "};\n\n");
+	if (ret)
+		goto end;
+
 	ret = lttng_metadata_printf(session,
 		"clock {\n"
 		"	name = \"%s\";\n",
-- 
2.17.1
