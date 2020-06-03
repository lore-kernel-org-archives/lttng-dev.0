Return-Path: <SRS0=Vgf5=7Q=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4671C433E0
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:30:13 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CE520679
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="VHlf6V76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CE520679
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49cWXM3T5Nz1M6G;
	Wed,  3 Jun 2020 10:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1591194612;
	bh=AQnB+2+YGSwANrCiptnQ4ohv+oHkKx9DG5PO7A/zE98=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VHlf6V76ccfSjoKEjE7oF2m1B3Oh9XbSUDBP7+OMNRFYHO/yrHXxT6WXzmEd5wOof
	 ZzrBLwTVY3V1mmAgjndI5L4zwFtbR5gvvDVI9+rRDJn4C3KdMBfY0tz+VoREF0zk+T
	 e7NQ41PSenNyYbRJKJ8fvNWR/h0N1KhGyaBfnsN84AmUt5wBne2u506LisMSF5ZWOh
	 AWjEh+dcvXVCiAwNMjom3klLs8mAsR0uKZ0w5B3FXBqnnbDGgFgMkfzVO4zJJgAPv2
	 +HhQeNCDP0ElxSyUH1F+FZm81GiUu34nTM5CnjHcAVMDVnKYSCZGjYCvfL2WjNv0Ry
	 H52vtdFlvZAFQ==
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
 by lists.lttng.org (Postfix) with ESMTPS id 49cT142dMDz1MP7
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 08:36:24 -0400 (EDT)
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
 by forward106p.mail.yandex.net (Yandex) with ESMTP id C42621C831EC
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 15:36:13 +0300 (MSK)
Received: from myt4-ee976ce519ac.qloud-c.yandex.net
 (myt4-ee976ce519ac.qloud-c.yandex.net [2a02:6b8:c00:1da4:0:640:ee97:6ce5])
 by mxback15g.mail.yandex.net (mxback/Yandex) with ESMTP id G6aHI8fudZ-aDgG2Q1e;
 Wed, 03 Jun 2020 15:36:13 +0300
Received: by myt4-ee976ce519ac.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id Zncrba71bW-aDjavXrg; Wed, 03 Jun 2020 15:36:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
To: lttng-dev@lists.lttng.org
Message-ID: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
Date: Wed, 3 Jun 2020 15:36:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E91DBDDFA8A509741168F3D8"
Content-Language: en-US
X-Mailman-Approved-At: Wed, 03 Jun 2020 10:30:09 -0400
Subject: [lttng-dev] Userspace RCU data alignment
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
From: Dmitry Antipov via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dmitry Antipov <dmantipov@yandex.ru>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200603123613.FlY9tFF_kOaE6vtl8bmzZbjEJYJ4b5hesxrqMrdxwO0@z>

This is a multi-part message in MIME format.
--------------E91DBDDFA8A509741168F3D8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I've compiled userspace-rcu with:

CC=gcc CFLAGS='-O0 -g3 -fsanitize=undefined' LIBS='-lubsan' ./configure [xxx]

and see a lot of 'misaligned address' runtime errors like:

  ./doc/examples/urcu-flavors/bp ==>

../include/urcu/static/urcu-bp.h:185:6: runtime error: member access within misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which requires 128 byte alignment
0x7fcac376a020: note: pointer points here
  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
               ^
     #0 0x7fcac372a880 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:185
     #1 0x7fcac372b0d9 in urcu_bp_read_unlock /home/antipov/userspace-rcu/src/urcu-bp.c:363
     #2 0x4017d5 in main /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
     #4 0x40111d in _start (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)

../include/urcu/static/urcu-bp.h:189:2: runtime error: member access within misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which requires 128 byte alignment
0x7fcac376a020: note: pointer points here
  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
               ^
     #0 0x7fcac372a8c1 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:189
     #1 0x7fcac372b0d9 in urcu_bp_read_unlock /home/antipov/userspace-rcu/src/urcu-bp.c:363
     #2 0x4017d5 in main /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
     #4 0x40111d in _start (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)

Is it critical for correctness, or speed, or whatever else?

To whom it may be interesting, some of (probably not all) alignment issues may be fixed
with attached patch.

Dmitry

--------------E91DBDDFA8A509741168F3D8
Content-Type: text/x-patch; charset=UTF-8;
 name="urcu_bp_reader_alignment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="urcu_bp_reader_alignment.patch"

diff --git a/include/urcu/list.h b/include/urcu/list.h
index 4aaf869..d5f28fe 100644
--- a/include/urcu/list.h
+++ b/include/urcu/list.h
@@ -40,6 +40,11 @@ struct cds_list_head {
 #define CDS_LIST_HEAD(name) \
 	struct cds_list_head name = { &(name), &(name) }
 
+/* Likewise but aligned to ALIGN bytes. */
+#define CDS_LIST_HEAD_ALIGNED(name, align) \
+	struct cds_list_head name __attribute__((aligned (align))) \
+	= { &(name), &(name) }
+
 /* Initialize a new list head. */
 #define CDS_INIT_LIST_HEAD(ptr) \
 	(ptr)->next = (ptr)->prev = (ptr)
diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 05efd97..4e31147 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -154,12 +154,15 @@ URCU_ATTR_ALIAS("urcu_bp_gp") extern struct urcu_bp_gp rcu_gp_bp;
 DEFINE_URCU_TLS(struct urcu_bp_reader *, urcu_bp_reader);
 DEFINE_URCU_TLS_ALIAS(struct urcu_bp_reader *, urcu_bp_reader, rcu_reader_bp);
 
-static CDS_LIST_HEAD(registry);
+static CDS_LIST_HEAD_ALIGNED(registry, CAA_CACHE_LINE_SIZE);
 
 struct registry_chunk {
 	size_t data_len;		/* data length */
 	size_t used;			/* amount of data used */
 	struct cds_list_head node;	/* chunk_list node */
+	char pad[CAA_CACHE_LINE_SIZE -  /* pad to ensure expected alignment */
+		 sizeof(size_t) * 2 -
+		 sizeof(struct cds_list_head)];
 	char data[];
 };
 
@@ -270,8 +273,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
 
 void urcu_bp_synchronize_rcu(void)
 {
-	CDS_LIST_HEAD(cur_snap_readers);
-	CDS_LIST_HEAD(qsreaders);
+	CDS_LIST_HEAD_ALIGNED(cur_snap_readers, CAA_CACHE_LINE_SIZE);
+	CDS_LIST_HEAD_ALIGNED(qsreaders, CAA_CACHE_LINE_SIZE);
 	sigset_t newmask, oldmask;
 	int ret;
 

--------------E91DBDDFA8A509741168F3D8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------E91DBDDFA8A509741168F3D8--
