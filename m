Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6EDECAAA1
	for <lttng-dev@archiver.kernel.org>; Thu, 27 Oct 2022 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666880355;
	bh=N9CKQbZKYlXATUTqf+UTw3CNjIRbV/4+b8i9GNxlsy8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ih0NCOsMLZqx5WChWpzUiRfcRUoMXn+Gk350ZVGJG61rbZS7iMEEY0E85meldhPm2
	 B1UAj5R0G/zCGGCu38GmXTZ9ryp+DhIlwF58V7udqHj8o7DXG7jT7aCuSqQlxaLPit
	 I4k8Dei37Djztl1q8sdQ6xV+G5Dby3xIGBGwsy/LUT5j02SWl0F1s3XTuukkVwAbg9
	 ZUC2MdZQg4q8pF37c9woHegH8ngahlQDAam1JKPwLaKCFNxqq2nXPN22d3ITljPgyc
	 PJuONEuyhG6Ks4G6CF4ECqxNUx75xgYzKnELOxe4TfCEQ8iCxLkRcFPxgIrCpDsT0O
	 02YAVtxY02Y6w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MynqQ28XSzG0H;
	Thu, 27 Oct 2022 10:19:14 -0400 (EDT)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4MyZfg2yWFzFyK
 for <lttng-dev@lists.lttng.org>; Thu, 27 Oct 2022 01:55:55 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; d="scan'208";a="213144348"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 13:54:44 +0800
IronPort-SDR: tf+PGyYNJ/QXHNy31wGapbUunoi8a1or4AYR1SSMw/ntMO5FYdl5Vnb1GvKCe9kp1uRqWEPviS
 qiT2sGL3WML/rKBBylge+FL9njQueHisvMvfVgiHcuDTRnoU0CJlrJqs4BwQFAKE3EbX6bSJoS
 DJ/jkvv/e/De58l1ALR3vigbN7kUgGMeZxxhSH3VggJu+9LMWU4zxfBE9xy60RFAqitW6+ft0h
 1BXWKGrMQ5IjWgaL5vB//XbqRR/mm5W0z8f66CYE1Xr2LhCZiueP+cxMiAVhbgLBMqZNdBNiMM
 gcxQGUR94zsCCuHH9de10nnV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2022 22:08:22 -0700
IronPort-SDR: FpCcqmMAWS9CRV4v0c4Hezi1qFUy5Y5/zrrgpN7W1qtkoXoxQXlz97pjZUr9zFch7MEq0byGqd
 mqtwdiYfmxqhYq3VtJAy95and/5eImDeYza59p2GBcOsEv40bgyuZVl9bDC/7XsogR/Y9lhJdJ
 fVDcKcLjHTl3g9pculRxASx60+R3H6NowI1fwxOZ3hO32TlJQ3cOPpPm1MyPUpc/m82e0Jj4YW
 U/EBs76x7XggddIAIz7a4MjCHc027MDu6GwcOYyuJUNmDF691stt2uXP3qmpIrwQYKayDAAfFP
 hD8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2022 22:54:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MyZdH1Y7Jz1RvTr
 for <lttng-dev@lists.lttng.org>; Wed, 26 Oct 2022 22:54:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id NtvtQT-QHu-p for <lttng-dev@lists.lttng.org>;
 Wed, 26 Oct 2022 22:54:42 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.45])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MyZdB6WPYz1RvLy;
 Wed, 26 Oct 2022 22:54:38 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu, 27 Oct 2022 15:54:28 +1000
Message-Id: <20221027055428.406908-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 27 Oct 2022 10:19:12 -0400
Subject: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support for
 _time64
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
From: Alistair Francis via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alistair Francis <alistair.francis@opensource.wdc.com>
Cc: alistair23@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add support for the  64-bit time_t syscalls SYS_ppoll_time64
and SYS_pselect6_time64.

These are the syscalls that exist 32-bit platforms since the 5.1 kernel.
32-bit platforms with a 64-bit time_t only have these and don't have the
original syscalls (such as 32-bit RISC-V).

Fixes: https://github.com/lttng/lttng-tools/pull/162
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
To keep the test_cases[] array clean I have implemented the functions
for all builds, but the functions are a no-op if the syscall is missing.

v2:
 - Split out a seperate _time64 test

 tests/regression/kernel/select_poll_epoll.cpp | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/tests/regression/kernel/select_poll_epoll.cpp b/tests/regression/kernel/select_poll_epoll.cpp
index c0b688217..dfaab52c8 100644
--- a/tests/regression/kernel/select_poll_epoll.cpp
+++ b/tests/regression/kernel/select_poll_epoll.cpp
@@ -5,6 +5,7 @@
  *
  */
 
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <poll.h>
@@ -48,10 +49,14 @@ int lttng_opt_quiet, lttng_opt_verbose, lttng_opt_mi;
 
 static void run_working_cases(FILE *validation_output_file);
 static void pselect_invalid_fd(FILE *validation_output_file);
+static void pselect_time64_invalid_fd(FILE *validation_output_file);
 static void test_ppoll_big(FILE *validation_output_file);
 static void ppoll_fds_buffer_overflow(FILE *validation_output_file);
+static void ppoll_time64_fds_buffer_overflow(FILE *validation_output_file);
 static void pselect_invalid_pointer(FILE *validation_output_file);
+static void pselect_time64_invalid_pointer(FILE *validation_output_file);
 static void ppoll_fds_ulong_max(FILE *validation_output_file);
+static void ppoll_time64_fds_ulong_max(FILE *validation_output_file);
 static void epoll_pwait_invalid_pointer(FILE *validation_output_file);
 static void epoll_pwait_int_max(FILE *validation_output_file);
 static void ppoll_concurrent_write(FILE *validation_output_file);
@@ -69,10 +74,14 @@ const struct test_case {
 	{ .run = run_working_cases, .produces_validation_info = true, .timeout = -1 },
 	{ .run = run_working_cases, .produces_validation_info = true, .timeout = 1 },
 	{ .run = pselect_invalid_fd, .produces_validation_info = false, .timeout = 0 },
+	{ .run = pselect_time64_invalid_fd, .produces_validation_info = false, .timeout = 0 },
 	{ .run = test_ppoll_big, .produces_validation_info = false, .timeout = 0 },
 	{ .run = ppoll_fds_buffer_overflow, .produces_validation_info = false, .timeout = 0 },
+	{ .run = ppoll_time64_fds_buffer_overflow, .produces_validation_info = false, .timeout = 0 },
 	{ .run = pselect_invalid_pointer, .produces_validation_info = false, .timeout = 0 },
+	{ .run = pselect_time64_invalid_pointer, .produces_validation_info = false, .timeout = 0 },
 	{ .run = ppoll_fds_ulong_max, .produces_validation_info = false, .timeout = 0 },
+	{ .run = ppoll_time64_fds_ulong_max, .produces_validation_info = false, .timeout = 0 },
 	{ .run = epoll_pwait_invalid_pointer, .produces_validation_info = true, .timeout = 0 },
 	{ .run = epoll_pwait_int_max, .produces_validation_info = true, .timeout = 0 },
 	{ .run = ppoll_concurrent_write, .produces_validation_info = false, .timeout = 0 },
@@ -440,6 +449,44 @@ end:
 	return;
 }
 
+/*
+ * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
+ * segfault (eventually with a "*** stack smashing detected ***" message).
+ * The event should contain an array of 100 FDs filled with garbage.
+ */
+static
+void ppoll_time64_fds_buffer_overflow(
+		FILE *validation_output_file __attribute__((unused)))
+{
+#ifdef SYS_ppoll_time64
+	struct pollfd ufds[NB_FD];
+	char buf[BUF_SIZE];
+	int ret;
+
+	ufds[0].fd = wait_fd;
+	ufds[0].events = POLLIN|POLLPRI;
+
+	/*
+	 * As there is no timeout value, we don't convert to/from
+	 * 64/32-bit time_t.
+	 */
+	ret = syscall(SYS_ppoll_time64, ufds, 100, NULL, NULL);
+	/*
+	 * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
+	 * to work and if it doesn't we fail.
+	 */
+
+	if (ret < 0) {
+		PERROR("ppoll_time64");
+	} else if (ret > 0) {
+		ret = read(wait_fd, buf, BUF_SIZE);
+		if (ret < 0) {
+			PERROR("[ppoll_time64] read");
+		}
+	}
+#endif
+}
+
 /*
  * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
  * segfault (eventually with a "*** stack smashing detected ***" message).
@@ -449,6 +496,7 @@ static
 void ppoll_fds_buffer_overflow(
 		FILE *validation_output_file __attribute__((unused)))
 {
+#ifdef SYS_ppoll
 	struct pollfd ufds[NB_FD];
 	char buf[BUF_SIZE];
 	int ret;
@@ -466,6 +514,46 @@ void ppoll_fds_buffer_overflow(
 			PERROR("[ppoll] read");
 		}
 	}
+#endif
+}
+
+/*
+ * Ask for ULONG_MAX FDs in a buffer for allocated for only 1 FD, should
+ * cleanly fail with a "Invalid argument".
+ * The event should contain an empty array of FDs and overflow = 1.
+ */
+static
+void ppoll_time64_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
+{
+#ifdef SYS_ppoll_time64
+	struct pollfd ufds[NB_FD];
+	char buf[BUF_SIZE];
+	int ret;
+
+	ufds[0].fd = wait_fd;
+	ufds[0].events = POLLIN|POLLPRI;
+
+	/*
+	 * As there is no timeout value, we don't convert to/from
+	 * 64/32-bit time_t.
+	 */
+	ret = syscall(SYS_ppoll_time64, ufds, ULONG_MAX, NULL, NULL);
+	/*
+	 * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
+	 * to work and if it doesn't we fail.
+	 */
+
+	if (ret < 0 && errno != ENOSYS) {
+		/* Expected error. */
+	} else if (errno == ENOSYS) {
+		PERROR("[ppoll_time64] missing syscall");
+	} else if (ret > 0) {
+		ret = read(wait_fd, buf, BUF_SIZE);
+		if (ret < 0) {
+			PERROR("[ppoll_time64] read");
+		}
+	}
+#endif
 }
 
 /*
@@ -476,6 +564,7 @@ void ppoll_fds_buffer_overflow(
 static
 void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
 {
+#ifdef SYS_ppoll
 	struct pollfd ufds[NB_FD];
 	char buf[BUF_SIZE];
 	int ret;
@@ -492,6 +581,59 @@ void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
 			PERROR("[ppoll] read");
 		}
 	}
+#endif
+}
+
+/*
+ * Pass an invalid file descriptor to pselect6(). The syscall should return
+ * -EBADF. The recorded event should contain a "ret = -EBADF (-9)".
+ */
+static
+void pselect_time64_invalid_fd(FILE *validation_output_file __attribute__((unused)))
+{
+#ifdef SYS_pselect6_time64
+	fd_set rfds;
+	int ret;
+	int fd;
+	char buf[BUF_SIZE];
+
+	/*
+	 * Open a file, close it and use the closed FD in the pselect6 call.
+	 */
+	fd = open("/dev/null", O_RDONLY);
+	if (fd == -1) {
+		PERROR("open");
+		goto error;
+	}
+
+	ret = close(fd);
+	if (ret == -1) {
+		PERROR("close");
+		goto error;
+	}
+
+	FD_ZERO(&rfds);
+	FD_SET(fd, &rfds);
+
+	ret = syscall(SYS_pselect6_time64, fd + 1, &rfds, NULL, NULL, NULL, NULL);
+	/*
+	 * There is no fallback to SYS_pselect6, we expect SYS_pselect6_time64
+	 * to work and if it doesn't we fail.
+	 */
+
+	if (ret == -1 && errno != ENOSYS) {
+		/* Expected error. */
+	} else if (errno == ENOSYS) {
+		PERROR("[pselect_time64] missing syscall");
+	} else if (ret) {
+		ret = read(wait_fd, buf, BUF_SIZE);
+		if (ret < 0) {
+			PERROR("[pselect_time64] read");
+		}
+	}
+error:
+	return;
+#endif
 }
 
 /*
@@ -501,6 +643,7 @@ void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
 static
 void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
 {
+#ifdef SYS_pselect6
 	fd_set rfds;
 	int ret;
 	int fd;
@@ -525,6 +668,7 @@ void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
 	FD_SET(fd, &rfds);
 
 	ret = syscall(SYS_pselect6, fd + 1, &rfds, NULL, NULL, NULL, NULL);
+
 	if (ret == -1) {
 		/* Expected error. */
 	} else if (ret) {
@@ -535,6 +679,44 @@ void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
 	}
 error:
 	return;
+#endif
+}
+
+/*
+ * Invalid pointer as writefds, should output a ppoll event
+ * with 0 FDs.
+ */
+static
+void pselect_time64_invalid_pointer(
+		FILE *validation_output_file __attribute__((unused)))
+{
+#ifdef SYS_pselect6_time64
+	fd_set rfds;
+	int ret;
+	char buf[BUF_SIZE];
+	void *invalid = (void *) 0x42;
+
+	FD_ZERO(&rfds);
+	FD_SET(wait_fd, &rfds);
+
+	ret = syscall(SYS_pselect6_time64, 1, &rfds, (fd_set *) invalid, NULL, NULL,
+			NULL);
+	/*
+	 * There is no fallback to SYS_pselect6, we expect SYS_pselect6_time64
+	 * to work and if it doesn't we fail.
+	 */
+
+	if (ret == -1 && errno != ENOSYS) {
+		/* Expected error. */
+	} else if (errno == ENOSYS) {
+		PERROR("[pselect_time64] missing syscall");
+	} else if (ret) {
+		ret = read(wait_fd, buf, BUF_SIZE);
+		if (ret < 0) {
+			PERROR("[pselect_time64] read");
+		}
+	}
+#endif
 }
 
 /*
@@ -545,6 +727,7 @@ static
 void pselect_invalid_pointer(
 		FILE *validation_output_file __attribute__((unused)))
 {
+#ifdef SYS_pselect6
 	fd_set rfds;
 	int ret;
 	char buf[BUF_SIZE];
@@ -563,6 +746,7 @@ void pselect_invalid_pointer(
 			PERROR("[pselect] read");
 		}
 	}
+#endif
 }
 
 /*
-- 
2.37.3

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
