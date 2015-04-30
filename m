From: Jeff Layton <jlayton@poochiereds.net>
Subject: [PATCH urcu] urcu: add
	cds_list_for_each_entry_safe_from macro
Date: Thu, 30 Apr 2015 07:50:05 -0400
Message-ID: <1430394605-27519-1-git-send-email-jeff.layton__48798.217069316$1430394673$gmane$org@primarydata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jlayton@poochiereds.net>) id 1Ynmyu-0007Qb-E6
 for lttng-dev@lists.lttng.org; Thu, 30 Apr 2015 07:50:20 -0400
Received: by qku63 with SMTP id 63so31069891qku.3
 for <lttng-dev@lists.lttng.org>; Thu, 30 Apr 2015 04:50:11 -0700 (PDT)
Received: from tlielax.poochiereds.net
 ([2606:a000:1105:8e:3a60:77ff:fe93:a95d])
 by mx.google.com with ESMTPSA id q34sm1060759qkq.4.2015.04.30.04.50.09
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2015 04:50:09 -0700 (PDT)
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

Same as cds_list_for_each_entry_safe, but starts at an arbitrary point
within the list instead of at the head.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
---
 urcu/list.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/urcu/list.h b/urcu/list.h
index b4962b445dfb..4aaf869351fe 100644
--- a/urcu/list.h
+++ b/urcu/list.h
@@ -171,6 +171,15 @@ void cds_list_splice(struct cds_list_head *add, struct cds_list_head *head)
 		&pos->member != (head); \
 		pos = p, p = cds_list_entry(pos->member.next, __typeof__(*pos), member))
 
+/*
+ * Same as cds_list_for_each_entry_safe, but starts from "pos" which should
+ * point to an entry within the list.
+ */
+#define cds_list_for_each_entry_safe_from(pos, p, head, member) \
+        for (p = cds_list_entry(pos->member.next, __typeof__(*pos), member); \
+                &pos->member != (head); \
+                pos = p, p = cds_list_entry(pos->member.next, __typeof__(*pos), member))
+
 static inline
 int cds_list_empty(struct cds_list_head *head)
 {
-- 
2.1.0
