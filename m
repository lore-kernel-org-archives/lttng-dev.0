From: David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] Update compaction instrumentation for 3.12.x
	stable kernels
Date: Wed, 17 Dec 2014 09:01:17 +0100
Message-ID: <5491384D.3070608__16392.3400607475$1418844758$gmane$org@sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020803090306080109080801"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.sysgo.com ([176.9.53.133])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <david.engraf@sysgo.com>) id 1Y19Xx-0000jH-SD
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 03:01:26 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, simon.marchi@polymtl.ca, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------020803090306080109080801
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------020803090306080109080801
Content-Type: text/x-diff;
 name="0001-Conditional-compilation-introduced-by-lttng-modules-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Conditional-compilation-introduced-by-lttng-modules-.pa";
 filename*1="tch"

Conditional compilation introduced by lttng-modules commit

  0007344741ef65259bc52dea72259173dfbf96c0

needs to be applied to kernels 3.12.30 and up in the 3.12.x branch.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 instrumentation/events/lttng-module/compaction.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/instrumentation/events/lttng-module/compaction.h b/instrumentation/events/lttng-module/compaction.h
index 773a6ad..a05f207 100644
--- a/instrumentation/events/lttng-module/compaction.h
+++ b/instrumentation/events/lttng-module/compaction.h
@@ -47,6 +47,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(mm_compaction_isolate_template, mm_compaction_is
 )
 
 #if LTTNG_KERNEL_RANGE(3,14,25, 3,15,0) || \
+	LTTNG_KERNEL_RANGE(3,12,30, 3,13,0) || \
 	(LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
 LTTNG_TRACEPOINT_EVENT(mm_compaction_migratepages,
 
-- 
1.9.1


--------------020803090306080109080801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------020803090306080109080801--
