From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 26/30] Drop support for
 kernels < 3.0 from scsi instrumentation
Date: Thu,  8 Nov 2018 16:45:31 -0500
Message-ID: <20181108214535.12081-26-mjeanson__35819.0179606483$1541713789$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKp2DKSzqJC
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:06 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0763824AF1B
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:06 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
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
 instrumentation/events/lttng-module/scsi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/instrumentation/events/lttng-module/scsi.h b/instrumentation/events/lttng-module/scsi.h
index 97ee050..7882def 100644
--- a/instrumentation/events/lttng-module/scsi.h
+++ b/instrumentation/events/lttng-module/scsi.h
@@ -388,7 +388,6 @@
 		scsi_statusbyte_name(SAM_STAT_ACA_ACTIVE),	\
 		scsi_statusbyte_name(SAM_STAT_TASK_ABORTED))
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 #define scsi_prot_op_name(result)	{ result, #result }
 #define show_prot_op_name(val)					\
 	__print_symbolic(val,					\
@@ -399,7 +398,6 @@
 		scsi_prot_op_name(SCSI_PROT_WRITE_INSERT),	\
 		scsi_prot_op_name(SCSI_PROT_READ_PASS),		\
 		scsi_prot_op_name(SCSI_PROT_WRITE_PASS))
-#endif
 
 const char *scsi_trace_parse_cdb(struct trace_seq*, unsigned char*, int);
 #define __parse_cdb(cdb, len) scsi_trace_parse_cdb(p, cdb, len)
@@ -420,9 +418,7 @@ LTTNG_TRACEPOINT_EVENT(scsi_dispatch_cmd_start,
 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
-#endif
 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
 	)
 )
@@ -443,9 +439,7 @@ LTTNG_TRACEPOINT_EVENT(scsi_dispatch_cmd_error,
 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
-#endif
 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
 	)
 )
@@ -466,9 +460,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(scsi_cmd_done_timeout_template,
 		ctf_integer(unsigned int, cmd_len, cmd->cmd_len)
 		ctf_integer(unsigned int, data_sglen, scsi_sg_count(cmd))
 		ctf_integer(unsigned int, prot_sglen, scsi_prot_sg_count(cmd))
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(unsigned char, prot_op, scsi_get_prot_op(cmd))
-#endif
 		ctf_sequence_hex(unsigned char, cmnd, cmd->cmnd, u32, cmd->cmd_len)
 	)
 )
-- 
2.17.1
