From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: function prototype in
 wrapper/mm.h
Date: Tue, 17 Dec 2019 12:11:10 -0500
Message-ID: <20191217171111.6782-1-mjeanson__6566.86621239118$1576602696$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47cl6H46lsz1BhR
 for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2019 12:11:19 -0500 (EST)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 wrapper/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper/mm.h b/wrapper/mm.h
index 672855b..405248a 100644
--- a/wrapper/mm.h
+++ b/wrapper/mm.h
@@ -62,7 +62,7 @@ void wrapper_set_current_oom_origin(void)
 }
 
 static inline
-void wrapper_clear_current_oom_origin()
+void wrapper_clear_current_oom_origin(void)
 {
 	return;
 }
-- 
2.17.1
