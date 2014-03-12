From: Zifei Tong <zifeitong@gmail.com>
Subject: [PATCH lttng-tools] Remove unused tracepoint in
	high-throughput test
Date: Wed, 12 Mar 2014 17:44:10 +0800
Message-ID: <1394617450-7418-1-git-send-email-zifeitong__28801.4671220028$1394617551$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zifeitong@gmail.com>) id 1WNfiG-0005Vt-3T
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 05:44:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so858283pbb.33
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 02:44:30 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Zifei Tong <zifeitong@gmail.com>
---
 tests/regression/ust/high-throughput/tp.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/regression/ust/high-throughput/tp.h b/tests/regression/ust/high-throughput/tp.h
index b43cb4e..4c0edf7 100644
--- a/tests/regression/ust/high-throughput/tp.h
+++ b/tests/regression/ust/high-throughput/tp.h
@@ -39,11 +39,6 @@ TRACEPOINT_EVENT(tp, tptest,
 	)
 )
 
-TRACEPOINT_EVENT(tp, tptest_sighandler,
-	TP_ARGS(),
-	TP_FIELDS()
-)
-
 #endif /* _TRACEPOINT_TP_H */
 
 #undef TRACEPOINT_INCLUDE_FILE
-- 
1.9.0
