From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 1/2] Fix: redefinition of
	DEFINE_WRITEBACK_EVENT
Date: Tue, 30 Sep 2014 16:49:32 -0400
Message-ID: <1412110173-3343-1-git-send-email-jdesfossez__48139.6489929923$1412110332$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XZ4Mj-0004Zb-Rx
 for lttng-dev@lists.lttng.org; Tue, 30 Sep 2014 16:49:51 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 instrumentation/events/lttng-module/writeback.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/instrumentation/events/lttng-module/writeback.h b/instrumentation/events/lttng-module/writeback.h
index 2dca4e4..5525fed 100644
--- a/instrumentation/events/lttng-module/writeback.h
+++ b/instrumentation/events/lttng-module/writeback.h
@@ -99,6 +99,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(writeback_class,
 		  __entry->name
 	)
 )
+#undef DEFINE_WRITEBACK_EVENT
 #define DEFINE_WRITEBACK_EVENT(name) \
 LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_class, name, \
 	TP_PROTO(struct backing_dev_info *bdi), \
-- 
1.9.1
