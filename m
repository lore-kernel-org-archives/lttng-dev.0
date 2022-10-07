Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6BBC4332F
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Oct 2022 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665124013;
	bh=y5rD2oYPge09fKzJCljhl0tCeNiB5+oPJ798X0xaJ74=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BCDfxxKTdCm2ZTHSEUTaUG8MQCOvp+/uJqZV/AUIjOSwvHJyCYOX0KsySHS4WzRRB
	 xOj9nCJFS1APivOSkQCRzL71urFW4C/g4O0gZHIuohgQJXZ7rp6mKny1nLtz5IsVAo
	 dg/wEPJOTs/XTtusDfEDG1gAbf4RWlYt9Ddoq5tkbM8WJDKB/sv9c4CYXem7hrt3Rf
	 XSLv9HZmTiE/bUXu86fAs2MqhQOnkGTfb8SPqCZX7IWdwJsZwlR/AoM7yoogOrrRtE
	 f819OUfnKyFefR8OPxf4k/4i1F+gY25JUj1we0ZiYwDvJr428BS5k9ssGRrcJYRy1a
	 YCb4n1JMh6+fw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MkJHd2Ds2z29Nq;
	Fri,  7 Oct 2022 02:26:53 -0400 (EDT)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mk8c35fVZz29WL
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2022 20:40:35 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; d="scan'208";a="211532204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 08:39:26 +0800
IronPort-SDR: epaKoUhGtJ1+xFwisljEKhvMO3YTvlVdo7iNUarHF0CzWJ13tzTfHZk5B/amdorAlOyK5RpBBX
 t+hJQlBSHuBKDfFQvjK3PwEwEmRssaY4kms6CGjOW08FXYVV6SNW470UFsWKYFUUPhw0H4VRdD
 tLzELysm0U20GFYbnX0tJ88D0whcVmd5r8Vgv+FyYKx077CRFLp52jIxMiAr6NxyI1/X86Myj/
 7RQ/Cr8Fkkrdryj2vYCylKJV5JlChPp7vcVDUSKhm5knbVH8Pa5PpHs+BxG8qpfS6eA3bhoc2E
 Jj4aMBvIFk6Urc6DtkdGr8Ma
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Oct 2022 16:59:11 -0700
IronPort-SDR: HVlrtQ1v6gXk5U3kznyj4RcJdm8LRhwz3BiOmlFj2ptjpczpnkLrux8agOi5mBN3bwdCr5xLS4
 k6LAlAFutm+xVEqCQt1mXOLX7S1U97sO0wPoNUyZOJBJioOUbhdgqgWYI+/8tY6n6g8UK1jVdh
 0ItAJMjT41igTtgIPurY9DQpIQTPBt+NUUbSzGIRqPR5BZSQ9r5GHPHvhNtm+C1Ll6L5JB+mYX
 MpNux5AZ+XmOUhQVuJhgwhbFvAlsnL/XzTVKEJE2+VtANUKqL4zmFDkmi9xkSkMuOXw/00qoDl
 4Zc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Oct 2022 17:39:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk8Zj6X1jz1RvLy
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2022 17:39:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id MOPWP6Ij_Xy3 for <lttng-dev@lists.lttng.org>;
 Thu,  6 Oct 2022 17:39:25 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.167.15])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk8Zh2Y2kz1RvTp;
 Thu,  6 Oct 2022 17:39:24 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Fri,  7 Oct 2022 10:39:18 +1000
Message-Id: <20221007003918.344922-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
References: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 07 Oct 2022 02:26:46 -0400
Subject: [lttng-dev] [PATCH lttng-tools 2/2] Tests: select_poll_epoll: Add
 support for _time64
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
 tests/regression/kernel/select_poll_epoll.cpp | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tests/regression/kernel/select_poll_epoll.cpp b/tests/regression/kernel/select_poll_epoll.cpp
index c0b688217..4a6d394f4 100644
--- a/tests/regression/kernel/select_poll_epoll.cpp
+++ b/tests/regression/kernel/select_poll_epoll.cpp
@@ -5,6 +5,7 @@
  *
  */
 
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <poll.h>
@@ -456,8 +457,22 @@ void ppoll_fds_buffer_overflow(
 	ufds[0].fd = wait_fd;
 	ufds[0].events = POLLIN|POLLPRI;
 
+#ifdef SYS_ppoll_time64
+	/*
+	 * As there is no timeout value, we don't convert to/from
+	 * 64/32-bit time_t.
+	 */
+	ret = syscall(SYS_ppoll_time64, ufds, 100, NULL, NULL);
+	if (ret == 0 || errno != ENOSYS) {
+		goto ppoll_fds_buffer_overflow_done;
+	}
+#endif
+
+#ifdef SYS_ppoll
 	ret = syscall(SYS_ppoll, ufds, 100, NULL, NULL);
+#endif
 
+ppoll_fds_buffer_overflow_done:
 	if (ret < 0) {
 		PERROR("ppoll");
 	} else if (ret > 0) {
@@ -483,7 +498,22 @@ void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unused)))
 	ufds[0].fd = wait_fd;
 	ufds[0].events = POLLIN|POLLPRI;
 
+#ifdef SYS_ppoll_time64
+	/*
+	 * As there is no timeout value, we don't convert to/from
+	 * 64/32-bit time_t.
+	 */
+	ret = syscall(SYS_ppoll_time64, ufds, ULONG_MAX, NULL, NULL);
+	if (ret == 0 || errno != ENOSYS) {
+		goto ppoll_fds_ulong_max_done;
+	}
+#endif
+
+#ifdef SYS_ppoll
 	ret = syscall(SYS_ppoll, ufds, ULONG_MAX, NULL, NULL);
+#endif
+
+ppoll_fds_ulong_max_done:
 	if (ret < 0) {
 		/* Expected error. */
 	} else if (ret > 0) {
@@ -524,7 +554,18 @@ void pselect_invalid_fd(FILE *validation_output_file __attribute__((unused)))
 	FD_ZERO(&rfds);
 	FD_SET(fd, &rfds);
 
+#ifdef SYS_pselect6_time64
+	ret = syscall(SYS_pselect6_time64, fd + 1, &rfds, NULL, NULL, NULL, NULL);
+	if (ret == 0 || errno != ENOSYS) {
+		goto pselect_invalid_fd_done;
+	}
+#endif
+
+#ifdef SYS_pselect6
 	ret = syscall(SYS_pselect6, fd + 1, &rfds, NULL, NULL, NULL, NULL);
+#endif
+
+pselect_invalid_fd_done:
 	if (ret == -1) {
 		/* Expected error. */
 	} else if (ret) {
@@ -553,8 +594,20 @@ void pselect_invalid_pointer(
 	FD_ZERO(&rfds);
 	FD_SET(wait_fd, &rfds);
 
+#ifdef SYS_pselect6_time64
+	ret = syscall(SYS_pselect6_time64, 1, &rfds, (fd_set *) invalid, NULL, NULL,
+			NULL);
+	if (ret == 0 || errno != ENOSYS) {
+		goto pselect_invalid_pointer_done;
+	}
+#endif
+
+#ifdef SYS_pselect6
 	ret = syscall(SYS_pselect6, 1, &rfds, (fd_set *) invalid, NULL, NULL,
 			NULL);
+#endif
+
+pselect_invalid_pointer_done:
 	if (ret == -1) {
 		/* Expected error. */
 	} else if (ret) {
-- 
2.37.3

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
