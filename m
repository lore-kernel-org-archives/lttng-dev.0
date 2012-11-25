From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] Remove remaining semicolons in TP_fast_assign
	blocks
Date: Sun, 25 Nov 2012 13:27:10 -0600
Message-ID: <1353871630-19756-1-git-send-email-andrew_gabbasov__42955.933957319$1353871688$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TchrO-00052E-Dh
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 14:27:22 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TchrH-0007Zf-Bb from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 11:27:15 -0800
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

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 instrumentation/events/lttng-module/jbd2.h |   22 +++++++++++-----------
 instrumentation/events/lttng-module/sock.h |    2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/instrumentation/events/lttng-module/jbd2.h b/instrumentation/events/lttng-module/jbd2.h
index 91e2e6c..c7992c0 100644
--- a/instrumentation/events/lttng-module/jbd2.h
+++ b/instrumentation/events/lttng-module/jbd2.h
@@ -25,8 +25,8 @@ TRACE_EVENT(jbd2_checkpoint,
 	),
 
 	TP_fast_assign(
-		tp_assign(dev, journal->j_fs_dev->bd_dev);
-		tp_assign(result, result);
+		tp_assign(dev, journal->j_fs_dev->bd_dev)
+		tp_assign(result, result)
 	),
 
 	TP_printk("dev %d,%d result %d",
@@ -46,9 +46,9 @@ DECLARE_EVENT_CLASS(jbd2_commit,
 	),
 
 	TP_fast_assign(
-		tp_assign(dev, journal->j_fs_dev->bd_dev);
-		tp_assign(sync_commit, commit_transaction->t_synchronous_commit);
-		tp_assign(transaction, commit_transaction->t_tid);
+		tp_assign(dev, journal->j_fs_dev->bd_dev)
+		tp_assign(sync_commit, commit_transaction->t_synchronous_commit)
+		tp_assign(transaction, commit_transaction->t_tid)
 	),
 
 	TP_printk("dev %d,%d transaction %d sync %d",
@@ -97,10 +97,10 @@ TRACE_EVENT(jbd2_end_commit,
 	),
 
 	TP_fast_assign(
-		tp_assign(dev, journal->j_fs_dev->bd_dev);
-		tp_assign(sync_commit, commit_transaction->t_synchronous_commit);
-		tp_assign(transaction, commit_transaction->t_tid);
-		tp_assign(head, journal->j_tail_sequence);
+		tp_assign(dev, journal->j_fs_dev->bd_dev)
+		tp_assign(sync_commit, commit_transaction->t_synchronous_commit)
+		tp_assign(transaction, commit_transaction->t_tid)
+		tp_assign(head, journal->j_tail_sequence)
 	),
 
 	TP_printk("dev %d,%d transaction %d sync %d head %d",
@@ -119,8 +119,8 @@ TRACE_EVENT(jbd2_submit_inode_data,
 	),
 
 	TP_fast_assign(
-		tp_assign(dev, inode->i_sb->s_dev);
-		tp_assign(ino, inode->i_ino);
+		tp_assign(dev, inode->i_sb->s_dev)
+		tp_assign(ino, inode->i_ino)
 	),
 
 	TP_printk("dev %d,%d ino %lu",
diff --git a/instrumentation/events/lttng-module/sock.h b/instrumentation/events/lttng-module/sock.h
index c4e689a..b0c7411 100644
--- a/instrumentation/events/lttng-module/sock.h
+++ b/instrumentation/events/lttng-module/sock.h
@@ -48,7 +48,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
 		tp_assign(sysctl_mem, prot->sysctl_mem)
 		tp_assign(allocated, allocated)
 		tp_assign(sysctl_rmem, prot->sysctl_rmem[0])
-		tp_assign(rmem_alloc, atomic_read(&sk->sk_rmem_alloc));
+		tp_assign(rmem_alloc, atomic_read(&sk->sk_rmem_alloc))
 	),
 
 	TP_printk("proto:%s sysctl_mem=%ld,%ld,%ld allocated=%ld "
-- 
1.7.10.4
