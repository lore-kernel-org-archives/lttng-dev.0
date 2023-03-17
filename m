Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316CCC76196
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 21:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679089102;
	bh=mQr2899HzHP5uPbJ1WanGRSrg2bo0by+Cipg03DJd/4=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nbolEUeUhc9v+Aggf1TBlNSCu1iAGpDum2xgNt20PZ/W7Ywc1pta3g7Gkgb0zz3S+
	 EvMKr90rgdyVo3yWE9eAfcn/LRVtDPAoxKs7efBcAzZ0cjGT6QTvfZk7GkHjdU2MYM
	 s/KzKGhfvcGdkfWcDxgNpcaUXr5NtykCJcWF+yz8ctHhdEcoMqe7d4Evp+NFyVgD+x
	 FQOR3GaBU4T/pdMp4pKy3uInp9a46e9wn8BlhcKp9MF4O7S5WoML49WdfBUKqqUrdg
	 xsHvLcO3icJQHdftav5lKmYZrabOH+O3Y1PTJ9+v/mHIo143xqgCVm5oHQSvhrFlkG
	 bdlycASU8GVqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pdcv1737fz2ChB;
	Fri, 17 Mar 2023 17:38:21 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pdcv05192z2Ckw
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:20 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id AB9A03200912;
 Fri, 17 Mar 2023 17:38:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 17 Mar 2023 17:38:19 -0400
X-ME-Sender: <xms:y90UZLKwF5IfeClp4sj86BonSZn5__YylxPyM251mM6qOqjvDGBZOg>
 <xme:y90UZPJD5ARxIEASHN9n0IcIERin4Aal6Pp0t4iZ113uJLpdlt6hOVj7GbI-VjGA-
 XHAKftT9q27Q0K2q68>
X-ME-Received: <xmr:y90UZDuytKDd3gm3qoKnH8UJVqthvYQQhAxRpydZqkWRLe9Kc5w0wEz-lCrV4-lnVgYABxzh4exyR9PshNU05yFOMk5sPLBeSaj7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudehtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
 htkeertdertdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehs
 uhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepleffhfekhefftddtffdufeduleegte
 dttddvtedvheeuhfeggfejvdduvdeitdffnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:y90UZEZRWIL6m32Pmh1zkttTfupwJ3jumsNux8jrJzNMO0wnn7YM_A>
 <xmx:y90UZCZDa7UINOa9kkivl4WJugArYTzLQKVcjKImmK33EDUufRtalw>
 <xmx:y90UZIBX7vhY3JRRsUE1wsNGkPcAPP-BD8E3DzeT4Qx12mYJxBRnKg>
 <xmx:y90UZLC70YFW4WxkgSJnUpHfLEcYSizc8T4vkyYWLKO8VBJ0i_qY2A>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 17:38:18 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 17 Mar 2023 22:37:54 +0100
Message-Id: <20230317213755.455957-7-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213755.455957-1-ondrej@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 6/7] Fix: uatomic_or() need retyping to
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
