Return-Path: <SRS0=Bs2I=EF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C048C00A89
	for <lttng-dev@archiver.kernel.org>; Fri, 30 Oct 2020 19:40:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD7206CB
	for <lttng-dev@archiver.kernel.org>; Fri, 30 Oct 2020 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="L8RQRao7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD7206CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CNCMD6tYyz19mK;
	Fri, 30 Oct 2020 15:40:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1604086809;
	bh=btOGstQXmzqbcEIeEwstTkxt+sLSYMJf6hzd+OF2LS4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=L8RQRao7F9c/mrBnJkTKJ5ZObIl9ik/RhkVnrJi0Ha+Dbd+ai5RF+svQn52aQFEkx
	 oMTZMDAtyH+7TrPQCEIqFtqTlT7n3sDL4rKrejTHuemCpUM0znNKmvWKx82qkaX1yl
	 QAQh4akSNKB/5tRnDnoPGXYXvng+oDyZfx9AO9z4PhuMKzwVRL7B13eLCSI9/r/bui
	 kTU1cww+pVauPbtrnVyT7K0kcpVnZ5GimwZeSCuvLmGrMfkufgApjCQsrhQJPJvUhN
	 Fa4PRECG5jOmY81Geaqzda+zctz5BoQcYbB2gkbHiEC4xmYVonWD1zUSWnIiX7EUUu
	 8NjHT8y1J3U8g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CNCMB4ypJz19mJ
 for <lttng-dev@lists.lttng.org>; Fri, 30 Oct 2020 15:40:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 38CE9270618;
 Fri, 30 Oct 2020 15:40:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yIrSfBpkhTUa; Fri, 30 Oct 2020 15:40:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 68CC4270617;
 Fri, 30 Oct 2020 15:40:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 68CC4270617
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id OOu-bj_eCyTp; Fri, 30 Oct 2020 15:40:05 -0400 (EDT)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 4EB432704E9;
 Fri, 30 Oct 2020 15:40:05 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 30 Oct 2020 15:39:56 -0400
Message-Id: <20201030193956.292208-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu] fix: add -lurcu-common to pkg-config libs
 for each flavor
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The urcu-common library contains common code like the write-free queue
and compat code, each urcu flavor library is dynamicly linked with it.

Most but not all toolchains will automatically link an executable with a
transitive depency of an explicitly linked library if said binary uses a
symbol from the transitive dependency.

Since this behavior is not present in all toolchains, add
'-lurcu-common' to the 'Libs' field of each flavors pkg-config file so
that executables using symbols from urcu-common can be reliably linked
using pkg-config.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/liburcu-bp.pc.in     | 2 +-
 src/liburcu-cds.pc.in    | 2 +-
 src/liburcu-mb.pc.in     | 2 +-
 src/liburcu-qsbr.pc.in   | 2 +-
 src/liburcu-signal.pc.in | 2 +-
 src/liburcu.pc.in        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/liburcu-bp.pc.in b/src/liburcu-bp.pc.in
index c5f2355..7cba58a 100644
--- a/src/liburcu-bp.pc.in
+++ b/src/liburcu-bp.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU BulletProof
 Description: A userspace RCU (read-copy-update) library, bulletproof version
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu-bp
+Libs: -L${libdir} -lurcu-common -lurcu-bp
 Cflags: -I${includedir} 
diff --git a/src/liburcu-cds.pc.in b/src/liburcu-cds.pc.in
index e3d13af..1cb19b6 100644
--- a/src/liburcu-cds.pc.in
+++ b/src/liburcu-cds.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU Concurrent Data Structures
 Description: Data structures leveraging RCU and atomic operations to provide efficient concurrency-aware storage
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu-cds
+Libs: -L${libdir} -lurcu-common -lurcu-cds
 Cflags: -I${includedir} 
diff --git a/src/liburcu-mb.pc.in b/src/liburcu-mb.pc.in
index cd669ef..1684701 100644
--- a/src/liburcu-mb.pc.in
+++ b/src/liburcu-mb.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU Memory barriers
 Description: A userspace RCU (read-copy-update) library, memory barriers version
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu-mb
+Libs: -L${libdir} -lurcu-common -lurcu-mb
 Cflags: -I${includedir} 
diff --git a/src/liburcu-qsbr.pc.in b/src/liburcu-qsbr.pc.in
index 0732602..d123a10 100644
--- a/src/liburcu-qsbr.pc.in
+++ b/src/liburcu-qsbr.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU QSBR
 Description: A userspace RCU (read-copy-update) library, quiescent state version
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu-qsbr
+Libs: -L${libdir} -lurcu-common -lurcu-qsbr
 Cflags: -I${includedir} 
diff --git a/src/liburcu-signal.pc.in b/src/liburcu-signal.pc.in
index f9bc3a3..844c449 100644
--- a/src/liburcu-signal.pc.in
+++ b/src/liburcu-signal.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU signal
 Description: A userspace RCU (read-copy-update) library, signal version
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu-signal
+Libs: -L${libdir} -lurcu-common -lurcu-signal
 Cflags: -I${includedir} 
diff --git a/src/liburcu.pc.in b/src/liburcu.pc.in
index 22bf2c8..b9f812b 100644
--- a/src/liburcu.pc.in
+++ b/src/liburcu.pc.in
@@ -7,5 +7,5 @@ Name: Userspace RCU
 Description: A userspace RCU (read-copy-update) library, standard version
 Version: @PACKAGE_VERSION@
 Requires:
-Libs: -L${libdir} -lurcu
+Libs: -L${libdir} -lurcu-common -lurcu
 Cflags: -I${includedir} 
-- 
2.28.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
