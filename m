From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust 1/2] Add ust_baddr_statedump start and
	end events
Date: Tue, 19 May 2015 18:17:35 -0400
Message-ID: <1432073856-458-1-git-send-email-abusque__20613.9964204796$1432074008$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1YuppY-00031y-Va
 for lttng-dev@lists.lttng.org; Tue, 19 May 2015 18:17:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DD5983402AA
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2015 22:17:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6BYKCi_-ILna for <lttng-dev@lists.lttng.org>;
 Tue, 19 May 2015 22:17:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F45334020B
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2015 22:17:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TkaYeovuXeIs for <lttng-dev@lists.lttng.org>;
 Tue, 19 May 2015 22:17:50 +0000 (UTC)
Received: from colossus.internal.efficios.com
 (cable-192.222.194.238.electronicbox.net [192.222.194.238])
 by mail.efficios.com (Postfix) with ESMTPSA id DA0E5340056
 for <lttng-dev@lists.lttng.org>; Tue, 19 May 2015 22:17:49 +0000 (UTC)
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

These events mark the beginning and end of base addresses state dump,
which happens once per traced application. Note that there is no
guarantee concerning the relative order of multiple start/end events
in the case of overlapping statedumps.  That is to say. if there are
two start events, and two end events, the first end event does not
necessarily correspond to the first start event, and similarly with
the second events.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 liblttng-ust/lttng-ust-baddr.c     | 50 ++++++++++++++++++++++++++++++++++++++
 liblttng-ust/ust_baddr_statedump.h | 10 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
index 922899b..5ec3d40 100644
--- a/liblttng-ust/lttng-ust-baddr.c
+++ b/liblttng-ust/lttng-ust-baddr.c
@@ -89,6 +89,54 @@ int trace_baddr(void *base_addr_ptr,
 }
 
 static
+int trace_statedump_start(void *owner)
+{
+	struct cds_list_head *sessionsp;
+	struct lttng_session *session;
+
+	if (ust_lock()) {
+		ust_unlock();
+		return 1;
+	}
+
+	sessionsp = _lttng_get_sessions();
+	cds_list_for_each_entry(session, sessionsp, node) {
+		if (session->owner != owner)
+			continue;
+		if (!session->statedump_pending)
+			continue;
+		tracepoint(ust_baddr_statedump, start,
+				session);
+	}
+	ust_unlock();
+	return 0;
+}
+
+static
+int trace_statedump_end(void *owner)
+{
+	struct cds_list_head *sessionsp;
+	struct lttng_session *session;
+
+	if (ust_lock()) {
+		ust_unlock();
+		return 1;
+	}
+
+	sessionsp = _lttng_get_sessions();
+	cds_list_for_each_entry(session, sessionsp, node) {
+		if (session->owner != owner)
+			continue;
+		if (!session->statedump_pending)
+			continue;
+		tracepoint(ust_baddr_statedump, end,
+				session);
+	}
+	ust_unlock();
+	return 0;
+}
+
+static
 int extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *_data)
 {
 	int j;
@@ -179,6 +227,7 @@ int lttng_ust_baddr_statedump(void *owner)
 	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
 		return 0;
 
+	trace_statedump_start(owner);
 	data.owner = owner;
 	data.exec_baddr = NULL;
 	/*
@@ -194,6 +243,7 @@ int lttng_ust_baddr_statedump(void *owner)
 	 * iteration.
 	 */
 	dump_exec_baddr(&data);
+	trace_statedump_end(owner);
 	return 0;
 }
 
diff --git a/liblttng-ust/ust_baddr_statedump.h b/liblttng-ust/ust_baddr_statedump.h
index 77a9af4..99fb849 100644
--- a/liblttng-ust/ust_baddr_statedump.h
+++ b/liblttng-ust/ust_baddr_statedump.h
@@ -37,6 +37,11 @@ extern "C" {
 #define LTTNG_UST_BADDR_STATEDUMP_PROVIDER
 #include <lttng/tracepoint.h>
 
+TRACEPOINT_EVENT(ust_baddr_statedump, start,
+	TP_ARGS(struct lttng_session *, session),
+	TP_FIELDS()
+)
+
 TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
 	TP_ARGS(struct lttng_session *, session, void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
 	TP_FIELDS(
@@ -47,6 +52,11 @@ TRACEPOINT_EVENT(ust_baddr_statedump, soinfo,
 	)
 )
 
+TRACEPOINT_EVENT(ust_baddr_statedump, end,
+	TP_ARGS(struct lttng_session *, session),
+	TP_FIELDS()
+)
+
 #endif /* _TRACEPOINT_UST_BADDR_STATEDUMP_H */
 
 #undef TRACEPOINT_INCLUDE
-- 
2.4.1
