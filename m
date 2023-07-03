Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2290C001B3
	for <lttng-dev@archiver.kernel.org>; Mon,  3 Jul 2023 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688409275;
	bh=5BIR03C30PwfJJKOceTtBo+5gO9HTsiwdJBiQsOcVQU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=IIp96eGsnI3CevQhYeao6jwjL59fsBcKZ2XUFKFnhVsoK2ORrZ5I1P4uKTO1C4p4s
	 fcqmHLNVFiE28lVqxVhoswP5bz0RZ4X7YQtbE9QqoZYNnRXgirUW1fRpqRxDlK+yCD
	 86vNhDmXJn5jaPv6BEnDlwUJ0CQZRiXz1Cf6MSG4kv8OQbDeO1R9UJecsp+uEIFORv
	 11d0xNvGcdnfeE102MnC5DPj1EwqdSvktD6/+JzixXMZ1Jg7Cp0S1G2imb2CY5PilG
	 FQacyhoz7JfKlvwoJlfzdBpOkPYKMofdgBMtqCUJnymRXtQBTin/fHZ0HZtbF3kfJb
	 zPzdTKoiFLR+g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qvvj65vNfz23H0;
	Mon,  3 Jul 2023 14:34:34 -0400 (EDT)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qvvj53MZQz23f2
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jul 2023 14:34:33 -0400 (EDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C03A63F19A
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jul 2023 18:29:01 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6ae3cb20cso45795011fa.3
 for <lttng-dev@lists.lttng.org>; Mon, 03 Jul 2023 11:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688408941; x=1691000941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eluq46cuaMuybQAFs+XMiZK8Wxm5We+JfO72npgOz5E=;
 b=BN+HJ/Kzu9PeVQx/jg62ilybVi5I2tqT76dOndSmb9CR4rmydM0NbGfO0YjlPmP79Q
 4N9CuxgTWKsABbmlCbWbiixSYe8JBr+Se+kOaeZYDh6U9hV9vpC5GWhOtpU+nScJ+fU1
 LnZc2TfH8uFtl0FLcqytbKdE1kBKvPLsPuHwubvpKNYrn4bzHWW9rIMvWTjdzlbN7Hyb
 wg0ZCfXLUxWiNzKmcfMXhaMTiPy/5bzUIuRS2iVQk2T06W6BkDp8uwQE8qn+7f0WrH9y
 KOMNDAD2K8TfkDOi/3mrDUnssghcaRl9qm0gls9gLSSq/NZxh2g3koWZH+S6q85PlQPu
 aHgw==
X-Gm-Message-State: ABy/qLbYnwOtGP3ZLAQ/+7xTFEHSCar6PW+pzcBVhqp87DkubjfBH8nw
 Hg7SWe8+3oSkNAXlgrh2oKlS61utxSp3MhhFigOyn8+Vv4BY+E51V3/5PPO00IXqgOQJGqDAk2b
 btEG1mk2lIUw27Gr6s9UJSuhhLqyzyerCK7xvWoFiN1Bf++KVsjs=
X-Received: by 2002:a2e:9dd0:0:b0:2b6:b367:e86e with SMTP id
 x16-20020a2e9dd0000000b002b6b367e86emr7503204ljj.24.1688408941145; 
 Mon, 03 Jul 2023 11:29:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGylbwtPZvNL7lXKHzVgq0In7nSqlCDduViBLSSv+yw9RLIQr89gEPdkNniG4ePOw8ycSFyRg==
X-Received: by 2002:a2e:9dd0:0:b0:2b6:b367:e86e with SMTP id
 x16-20020a2e9dd0000000b002b6b367e86emr7503182ljj.24.1688408940813; 
 Mon, 03 Jul 2023 11:29:00 -0700 (PDT)
Received: from ThinkPad.lan (77-169-125-32.fixed.kpn.net. [77.169.125.32])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b009875a6d28b0sm2460462eji.51.2023.07.03.11.29.00
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 11:29:00 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Mon,  3 Jul 2023 20:28:59 +0200
Message-Id: <20230703182859.49731-2-roxana.nicolescu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
References: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-modules 1/1] Introduce configure script to
 describe changes in linux kernel interface
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Roxana Nicolescu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This script is intented to be used for checking the changes in linux
kernel headers and keep the lttng module up-to-date.

It is introduced for a specific usecase where commit
d87a7b4c77a9: "jbd2: use the correct print format"
broke the interface between the kernel and lttng-module. 3 variables
changed their type to tid_t (transaction, head and tid) in multiple
function declarations. The lttng module was updated properly to ensure
backwards compatibility by using the version of the kernel.
But this change took into account only long term supported versions.
As an example, ubuntu 5.19 kernels picked the linux kernel change from
5.15 without actually changing the linux kernel upstream version. This
means the current tooling does not allow to fix the module for newer
ubuntu 5.19 kernels.

Configure script is supposed to make this change easier to integrate.
We check the linux kernel header (include/trace/events/jbd2.h) if
the type of tid, transaction and head variable has changes to tid_t
and define these 3 variables in 'include/generated/config.h':
TID_IS_TID_T 1
TRANSACTION_IS_TID_T 1
HEAD_IS_TID_T 1

In 'include/instrumentation/events/jbd2.h' we then check these to define
the proper type of transaction, head and tid variables that will be
later used in the function declarations that need them.

This change is meant to remove the dependency on linux kernel version
and the outcome is a bit cleaner that before.
As with the previous implementation, this may need changes in the future
if the kernel interface changes again.

Signed-off-by: Roxana Nicolescu <roxana.nicolescu@canonical.com>
---
 README.md                             |   3 +-
 configure                             |  36 +++++++++
 include/instrumentation/events/jbd2.h | 110 ++++++--------------------
 3 files changed, 61 insertions(+), 88 deletions(-)
 create mode 100755 configure

diff --git a/README.md b/README.md
index 06480d3b..231ba956 100644
--- a/README.md
+++ b/README.md
@@ -29,6 +29,7 @@ Building
 To build and install LTTng-modules, you will need to have your kernel
 headers available (or access to your full kernel source tree), and do:
 
+    ./configure
     make
     sudo make modules_install
     sudo depmod -a
@@ -36,7 +37,7 @@ headers available (or access to your full kernel source tree), and do:
 The above commands will build LTTng-modules against your
 current kernel. If you need to build LTTng-modules against a custom
 kernel, do:
-
+    KERNELDIR=/path/to/custom/kernel ./configure
     make KERNELDIR=/path/to/custom/kernel
     sudo make KERNELDIR=/path/to/custom/kernel modules_install
     sudo depmod -a kernel_version
diff --git a/configure b/configure
new file mode 100755
index 00000000..a9fcd422
--- /dev/null
+++ b/configure
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+if [ -z "${KERNELDIR}" ]; then
+    KERNELDIR=/lib/modules/$(uname -r)/build
+fi
+
+INCLUDE_DIR="include/generated"
+if test ! -d "${INCLUDE_DIR}"; then
+	mkdir "${INCLUDE_DIR}"
+fi
+
+LINUX_HEADER_FILE="${KERNELDIR}/include/trace/events/jbd2.h"
+
+CONFIG_H_OUTPUT_FILE="${INCLUDE_DIR}/config.h"
+# cleanup old config file
+> ${CONFIG_H_OUTPUT_FILE}
+
+if test -f "${LINUX_HEADER_FILE}"; then
+    grep -q "tid_t tid" ${LINUX_HEADER_FILE}
+    status=$?
+    if [ $status -eq 0 ]; then
+        echo "#define TID_IS_TID_T 1" >> ${CONFIG_H_OUTPUT_FILE}
+    fi
+
+    grep -q "[[:blank:]]\+__field([[:blank:]]\+tid_t,[[:blank:]]\+transaction" ${LINUX_HEADER_FILE}
+    status=$?
+    if [ $status -eq 0 ]; then
+        echo "#define TRANSACTION_IS_TID_T 1" >> ${CONFIG_H_OUTPUT_FILE}
+    fi
+
+    grep -q "[[:blank:]]\+__field([[:blank:]]\+tid_t,[[:blank:]]\+head" ${LINUX_HEADER_FILE}
+    status=$?
+    if [ $status -eq 0 ]; then
+        echo "#define HEAD_IS_TID_T 1" >> ${CONFIG_H_OUTPUT_FILE}
+    fi
+fi
diff --git a/include/instrumentation/events/jbd2.h b/include/instrumentation/events/jbd2.h
index be217ffa..6f9bd013 100644
--- a/include/instrumentation/events/jbd2.h
+++ b/include/instrumentation/events/jbd2.h
@@ -8,6 +8,7 @@
 #include <lttng/tracepoint-event.h>
 #include <linux/jbd2.h>
 #include <lttng/kernel-version.h>
+#include <generated/config.h>
 
 #ifndef _TRACE_JBD2_DEF
 #define _TRACE_JBD2_DEF
@@ -27,25 +28,18 @@ LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint,
 	)
 )
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,2,0) \
-	|| LTTNG_KERNEL_RANGE(5,4,229, 5,5,0) \
-	|| LTTNG_KERNEL_RANGE(5,10,163, 5,11,0) \
-	|| LTTNG_KERNEL_RANGE(5,15,87, 5,16,0) \
-	|| LTTNG_KERNEL_RANGE(6,0,18, 6,1,0) \
-	|| LTTNG_KERNEL_RANGE(6,1,4, 6,2,0))
-LTTNG_TRACEPOINT_EVENT_CLASS(jbd2_commit,
-
-	TP_PROTO(journal_t *journal, transaction_t *commit_transaction),
-
-	TP_ARGS(journal, commit_transaction),
+#ifdef TRANSACTION_IS_TID_T
+#define transaction_type tid_t
+#else
+#define transaction_type int
+#endif
 
-	TP_FIELDS(
-		ctf_integer(dev_t, dev, journal->j_fs_dev->bd_dev)
-		ctf_integer(char, sync_commit, commit_transaction->t_synchronous_commit)
-		ctf_integer(tid_t, transaction, commit_transaction->t_tid)
-	)
-)
+#ifdef HEAD_IS_TID_T
+#define head_type tid_t
 #else
+#define head_type int
+#endif
+
 LTTNG_TRACEPOINT_EVENT_CLASS(jbd2_commit,
 
 	TP_PROTO(journal_t *journal, transaction_t *commit_transaction),
@@ -55,10 +49,9 @@ LTTNG_TRACEPOINT_EVENT_CLASS(jbd2_commit,
 	TP_FIELDS(
 		ctf_integer(dev_t, dev, journal->j_fs_dev->bd_dev)
 		ctf_integer(char, sync_commit, commit_transaction->t_synchronous_commit)
-		ctf_integer(int, transaction, commit_transaction->t_tid)
+		ctf_integer(transaction_type, transaction, commit_transaction->t_tid)
 	)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(jbd2_commit, jbd2_start_commit,
 
@@ -97,12 +90,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(jbd2_commit, jbd2_drop_transaction,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,2,0) \
-	|| LTTNG_KERNEL_RANGE(5,4,229, 5,5,0) \
-	|| LTTNG_KERNEL_RANGE(5,10,163, 5,11,0) \
-	|| LTTNG_KERNEL_RANGE(5,15,87, 5,16,0) \
-	|| LTTNG_KERNEL_RANGE(6,0,18, 6,1,0) \
-	|| LTTNG_KERNEL_RANGE(6,1,4, 6,2,0))
 LTTNG_TRACEPOINT_EVENT(jbd2_end_commit,
 	TP_PROTO(journal_t *journal, transaction_t *commit_transaction),
 
@@ -111,24 +98,10 @@ LTTNG_TRACEPOINT_EVENT(jbd2_end_commit,
 	TP_FIELDS(
 		ctf_integer(dev_t, dev, journal->j_fs_dev->bd_dev)
 		ctf_integer(char, sync_commit, commit_transaction->t_synchronous_commit)
-		ctf_integer(tid_t, transaction, commit_transaction->t_tid)
-		ctf_integer(tid_t, head, journal->j_tail_sequence)
+		ctf_integer(transaction_type, transaction, commit_transaction->t_tid)
+		ctf_integer(head_type, head, journal->j_tail_sequence)
 	)
 )
-#else
-LTTNG_TRACEPOINT_EVENT(jbd2_end_commit,
-	TP_PROTO(journal_t *journal, transaction_t *commit_transaction),
-
-	TP_ARGS(journal, commit_transaction),
-
-	TP_FIELDS(
-		ctf_integer(dev_t, dev, journal->j_fs_dev->bd_dev)
-		ctf_integer(char, sync_commit, commit_transaction->t_synchronous_commit)
-		ctf_integer(int, transaction, commit_transaction->t_tid)
-		ctf_integer(int, head, journal->j_tail_sequence)
-	)
-)
-#endif
 
 LTTNG_TRACEPOINT_EVENT(jbd2_submit_inode_data,
 	TP_PROTO(struct inode *inode),
@@ -141,57 +114,21 @@ LTTNG_TRACEPOINT_EVENT(jbd2_submit_inode_data,
 	)
 )
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,2,0) \
-	|| LTTNG_KERNEL_RANGE(5,4,229, 5,5,0) \
-	|| LTTNG_KERNEL_RANGE(5,10,163, 5,11,0) \
-	|| LTTNG_KERNEL_RANGE(5,15,87, 5,16,0) \
-	|| LTTNG_KERNEL_RANGE(6,0,18, 6,1,0) \
-	|| LTTNG_KERNEL_RANGE(6,1,4, 6,2,0))
-LTTNG_TRACEPOINT_EVENT(jbd2_run_stats,
-	TP_PROTO(dev_t dev, tid_t tid,
-		 struct transaction_run_stats_s *stats),
-
-	TP_ARGS(dev, tid, stats),
-
-	TP_FIELDS(
-		ctf_integer(dev_t, dev, dev)
-		ctf_integer(tid_t, tid, tid)
-		ctf_integer(unsigned long, wait, stats->rs_wait)
-		ctf_integer(unsigned long, running, stats->rs_running)
-		ctf_integer(unsigned long, locked, stats->rs_locked)
-		ctf_integer(unsigned long, flushing, stats->rs_flushing)
-		ctf_integer(unsigned long, logging, stats->rs_logging)
-		ctf_integer(__u32, handle_count, stats->rs_handle_count)
-		ctf_integer(__u32, blocks, stats->rs_blocks)
-		ctf_integer(__u32, blocks_logged, stats->rs_blocks_logged)
-	)
-)
-
-LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint_stats,
-	TP_PROTO(dev_t dev, tid_t tid,
-		 struct transaction_chp_stats_s *stats),
-
-	TP_ARGS(dev, tid, stats),
-
-	TP_FIELDS(
-		ctf_integer(dev_t, dev, dev)
-		ctf_integer(tid_t, tid, tid)
-		ctf_integer(unsigned long, chp_time, stats->cs_chp_time)
-		ctf_integer(__u32, forced_to_close, stats->cs_forced_to_close)
-		ctf_integer(__u32, written, stats->cs_written)
-		ctf_integer(__u32, dropped, stats->cs_dropped)
-	)
-)
+#ifdef TID_IS_TID_T
+#define tid_type tid_t
 #else
+#define tid_type unsigned long
+#endif
+
 LTTNG_TRACEPOINT_EVENT(jbd2_run_stats,
-	TP_PROTO(dev_t dev, unsigned long tid,
+	TP_PROTO(dev_t dev, tid_type tid,
 		 struct transaction_run_stats_s *stats),
 
 	TP_ARGS(dev, tid, stats),
 
 	TP_FIELDS(
 		ctf_integer(dev_t, dev, dev)
-		ctf_integer(unsigned long, tid, tid)
+		ctf_integer(tid_type, tid, tid)
 		ctf_integer(unsigned long, wait, stats->rs_wait)
 		ctf_integer(unsigned long, running, stats->rs_running)
 		ctf_integer(unsigned long, locked, stats->rs_locked)
@@ -204,21 +141,20 @@ LTTNG_TRACEPOINT_EVENT(jbd2_run_stats,
 )
 
 LTTNG_TRACEPOINT_EVENT(jbd2_checkpoint_stats,
-	TP_PROTO(dev_t dev, unsigned long tid,
+	TP_PROTO(dev_t dev, tid_type tid,
 		 struct transaction_chp_stats_s *stats),
 
 	TP_ARGS(dev, tid, stats),
 
 	TP_FIELDS(
 		ctf_integer(dev_t, dev, dev)
-		ctf_integer(unsigned long, tid, tid)
+		ctf_integer(tid_type, tid, tid)
 		ctf_integer(unsigned long, chp_time, stats->cs_chp_time)
 		ctf_integer(__u32, forced_to_close, stats->cs_forced_to_close)
 		ctf_integer(__u32, written, stats->cs_written)
 		ctf_integer(__u32, dropped, stats->cs_dropped)
 	)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT(jbd2_update_log_tail,
 	TP_PROTO(journal_t *journal, tid_t first_tid,
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
