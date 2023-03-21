Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEEAC761A6
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679405494;
	bh=mQr2899HzHP5uPbJ1WanGRSrg2bo0by+Cipg03DJd/4=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JW6/v619KQnJo4uk4k/YUxZps9VskUqomC8pA/nVR3kppqkD7DlEavVIO0PFwJ9wn
	 G8CSjVNYx0pY2GMPnSLo8yy9jB6WaT2NYB3Lnbabx+r/81diDR8xYmaKUjlW5Aiadp
	 NyhFqfbyIDys+QeEWCAWEPj22MB/8zfdVfHtoAGToAxth9dS3MkpvawzUbiIQr+iIr
	 8daj1efpuW6Law3jFCgPfeOCfeIKHkglARG65QzmdsXB+kvsORHquq1oMVr3e7e1eN
	 sxEqY4XL7AiaFTqwg8GoRxJ39WP97ymzuFDN1gaE2pc2As+FB29nkYX9LVtOJOWt6m
	 qLsT4iuZFMvTA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgsvV5XYrz2HCg;
	Tue, 21 Mar 2023 09:31:34 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgsvT1ZRxz2HGy
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:32 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 23BE4320070D;
 Tue, 21 Mar 2023 09:31:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 21 Mar 2023 09:31:31 -0400
X-ME-Sender: <xms:srEZZMwHwa7Sh6FTKS-MeS7LuNoDv7TXDW1UHUdKUzsXVh0FXcnoqg>
 <xme:srEZZAS2NzW30WO9vqTylIeX-8Xk_S0IAHJA3MeAsVnhoQP2HaXRCkm4UbtqN64yo
 lleg0mFPnP0u9Sm8_M>
X-ME-Received: <xmr:srEZZOVvUPEysGQ3g53qBpGj5hwPyaQabDLQv6WHq8BR_o5ZUY5nvacBDJoAbBlucvm0Cz5Iru86y5pGa_oaiisILpjOTP-o7yOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddghedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
 ekredtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhu
 rhihrdhorhhgqeenucggtffrrghtthgvrhhnpeelfffhkeehffdttdffudefudelgeettd
 dtvdetvdehuefhgefgjedvuddviedtffenucevlhhushhtvghrufhiiigvpedunecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:srEZZKjOxgXiB4ashAQsREe6O06KsJW5PlrB0gA8hTjbnz62kZzEYg>
 <xmx:srEZZOCxdIKTYh2uqIAKSQn7_s_Yud6h30vtb3kWctXozPX6XZeRPA>
 <xmx:srEZZLKY5R4WGwCEJo3FcAkX4x0-5VhjmmnlmZraWvCNLitRu43yMA>
 <xmx:srEZZJrEQ6ANjuIDItdWcBj6ycbt9WNQn75DHLOEuqvISL9cXJRlOA>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 09:31:29 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 21 Mar 2023 14:31:02 +0100
Message-Id: <20230321133102.1054238-8-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321133102.1054238-1-ondrej@sury.org>
References: <20230321133102.1054238-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 7/7] Fix: uatomic_or() need retyping to
 uintptr_t in rculfhash.c
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
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?q?Ond=C5=99ej=20Sur=C3=BD?= <ondrej@sury.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

V2hlbiBhZGRpbmcgUkVNT1ZFRF9GTEFHIHRvIHRoZSBwb2ludGVycyBpbiB0aGUgcmN1bGZoYXNo
CmltcGxlbWVudGF0aW9uLCByZXR5cGUgdGhlIGdlbmVyaWMgcG9pbnRlciB0byB1aW50cHRyX3Qg
dG8gZml4IHRoZQpjb21waWxlciBlcnJvci4KClNpZ25lZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70g
PG9uZHJlakBzdXJ5Lm9yZz4KLS0tCiBzcmMvcmN1bGZoYXNoLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L3JjdWxmaGFzaC5jIGIvc3JjL3JjdWxmaGFzaC5jCmluZGV4IGI0NTY0MTUuLjg2MzM4N2UgMTAw
NjQ0Ci0tLSBhL3NyYy9yY3VsZmhhc2guYworKysgYi9zcmMvcmN1bGZoYXNoLmMKQEAgLTExOTgs
NyArMTE5OCw3IEBAIGludCBfY2RzX2xmaHRfZGVsKHN0cnVjdCBjZHNfbGZodCAqaHQsIHVuc2ln
bmVkIGxvbmcgc2l6ZSwKIAkgKiBLbm93aW5nIHdoaWNoIHdpbnMgdGhlIHJhY2Ugd2lsbCBiZSBr
bm93biBhZnRlciB0aGUgZ2FyYmFnZQogCSAqIGNvbGxlY3Rpb24gcGhhc2UsIHN0YXkgdHVuZWQh
CiAJICovCi0JdWF0b21pY19vcigmbm9kZS0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKKwl1YXRvbWlj
X29yKCh1aW50cHRyX3QgKikmbm9kZS0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKIAkvKiBXZSBwZXJm
b3JtZWQgdGhlIChsb2dpY2FsKSBkZWxldGlvbi4gKi8KIAogCS8qCkBAIC0xNDQxLDcgKzE0NDEs
NyBAQCB2b2lkIHJlbW92ZV90YWJsZV9wYXJ0aXRpb24oc3RydWN0IGNkc19sZmh0ICpodCwgdW5z
aWduZWQgbG9uZyBpLAogCQlkYmdfcHJpbnRmKCJyZW1vdmUgZW50cnk6IG9yZGVyICVsdSBpbmRl
eCAlbHUgaGFzaCAlbHVcbiIsCiAJCQkgICBpLCBqLCBqKTsKIAkJLyogU2V0IHRoZSBSRU1PVkVE
X0ZMQUcgdG8gZnJlZXplIHRoZSAtPm5leHQgZm9yIGdjICovCi0JCXVhdG9taWNfb3IoJmZpbmlf
YnVja2V0LT5uZXh0LCBSRU1PVkVEX0ZMQUcpOworCQl1YXRvbWljX29yKCh1aW50cHRyX3QgKikm
ZmluaV9idWNrZXQtPm5leHQsIFJFTU9WRURfRkxBRyk7CiAJCV9jZHNfbGZodF9nY19idWNrZXQo
cGFyZW50X2J1Y2tldCwgZmluaV9idWNrZXQpOwogCX0KIAlodC0+Zmxhdm9yLT5yZWFkX3VubG9j
aygpOwotLSAKMi4zOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
