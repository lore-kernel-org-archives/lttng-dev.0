Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31863C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679410372;
	bh=zcS9KZKbLM0yFJwwwLaPQO7iXAHofNTPukhNz2PkJfA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=X2nAPj7bVNAjcVeysk0/fpt4MZnNAdcdtnOlOZybjAIdPKOo1K2tss2Joq4eZklgd
	 TsUidKE3tTJDQAKAwpeZQDR2a8YD2hlGvWNxUKbT3eVZe9EfYyVfgAbrORvVbRtXpm
	 i1wCh64n+badyD4El9RGhdLFJZ7deYU2za5QvAARJ85CGJ02fY+TJv0VSQzBCdk7ZQ
	 VFX5w98fBCg+Nb84ZzPSD0OVjehBMHveYPu0CUSOX5cBCDeX+GfRGap6FnKCrvkZmA
	 VC9MSUK9qo5DtlDsPylT6Ak0179MCL/2ei4CXBboR1vCscUHsjH6OnPOqapAHuRjq1
	 w9W88DP41KjnA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgvjJ09Czz2H5B;
	Tue, 21 Mar 2023 10:52:52 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgvjF5y0Xz2HKF
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:52:49 -0400 (EDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 5150D320051E;
 Tue, 21 Mar 2023 10:52:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 21 Mar 2023 10:52:48 -0400
X-ME-Sender: <xms:v8QZZLuJHZIAmz-rh0mzHKDJu86mwxbhAVlROU3HmTEELr4FrX6l6A>
 <xme:v8QZZMfCqyopGCfnb3Bhqh6ndfh62LW2xgCzJtqdAXydxbeUgJMshblph1rxqCoYP
 --e2_7v5TfFCkqDQ4s>
X-ME-Received: <xmr:v8QZZOwQ9ZSJ735jKzx_gFOhbMpONoCWwFichQxUwH4mn0-nrBqEwd71xldh10U4Yc39PG7UadNfHEStwZhoTOoMbBu57sntLU9y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
 dtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhih
 rdhorhhgqeenucggtffrrghtthgvrhhnpefhueetleffveevvefgkeevjedtkeeigfefud
 etffefhedukeeuleeufeeggeffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:v8QZZKOo_x_rIF-tLbu-vVvrSYxtZhT7G6RNLOVwv77IjIGfhQ4FVg>
 <xmx:v8QZZL8D5V2DACHhsc202lnWwY-Vlj3tU9ihBY7Ar5KSkxyEtmDp4g>
 <xmx:v8QZZKXO2lLZArloqOe3eEk8E1dmKpJePZJRH-qSZ8RLgdIIyhA_xA>
 <xmx:v8QZZIHfgpca8MMMNS-CyzQIOVqilK_ViiO_LK7Sx6ddGwuP1vZTiA>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 10:52:47 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 21 Mar 2023 15:51:47 +0100
Message-Id: <20230321145146.1095875-1-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
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
CmltcGxlbWVudGF0aW9uLCByZXR5cGUgdGhlIGdlbmVyaWMgcG9pbnRlciB0byB1bnNpZ25lZCBs
b25nIHRvIGZpeCB0aGUKZm9sbG93aW5nIGNvbXBpbGVyIGVycm9yOgoKcmN1bGZoYXNoLmM6MTIw
MToyOiBlcnJvcjogYWRkcmVzcyBhcmd1bWVudCB0byBhdG9taWMgb3BlcmF0aW9uIG11c3QgYmUg
YSBwb2ludGVyIHRvIGludGVnZXIgKCdzdHJ1Y3QgY2RzX2xmaHRfbm9kZSAqKicgaW52YWxpZCkK
ICAgICAgIHVhdG9taWNfb3IoJm5vZGUtPm5leHQsIFJFTU9WRURfRkxBRyk7CiAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci4uL2luY2x1ZGUvdXJjdS91YXRvbWlj
Lmg6NjA6ODogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAndWF0b21pY19vcicKICAgICAgICh2
b2lkKV9fYXRvbWljX29yX2ZldGNoKChhZGRyKSwgKG1hc2spLCBfX0FUT01JQ19SRUxBWEVEKQog
ICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+CnJjdWxmaGFzaC5jOjE0NDQ6Mzog
ZXJyb3I6IGFkZHJlc3MgYXJndW1lbnQgdG8gYXRvbWljIG9wZXJhdGlvbiBtdXN0IGJlIGEgcG9p
bnRlciB0byBpbnRlZ2VyICgnc3RydWN0IGNkc19sZmh0X25vZGUgKionIGludmFsaWQpCiAgICAg
ICAgICAgICAgIHVhdG9taWNfb3IoJmZpbmlfYnVja2V0LT5uZXh0LCBSRU1PVkVEX0ZMQUcpOwog
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgouLi9pbmNsdWRlL3VyY3UvdWF0b21pYy5oOjYwOjg6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFj
cm8gJ3VhdG9taWNfb3InCiAgICAgICAodm9pZClfX2F0b21pY19vcl9mZXRjaCgoYWRkciksICht
YXNrKSwgX19BVE9NSUNfUkVMQVhFRCkKICAgICAgICAgICAgIF4gICAgICAgICAgICAgICAgIH5+
fn5+fgoKVGhpcyB3YXMgbm90IGEgcHJvYmxlbSBiZWZvcmUgYmVjYXVzZSB0aGUgd2F5IHRoZSB1
YXRvbWljX29yIHdhcwppbXBsZW1lbnRlZCwgYnV0IG5vdyB3ZSBkaXJlY3RseSBwYXNzIHRoZSBh
ZGRyIHRvIF9fYXRvbWljX29yX2ZldGNoKCkKYW5kIHRoZSBjb21waWxlciBkb2Vzbid0IGxpa2Ug
dGhlIGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSBwb2ludGVyIHRvCnBvaW50ZXIgdG8gaW50ZWdl
ci4KClNpZ25lZC1vZmYtYnk6IE9uZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KLS0tCiBz
cmMvcmN1bGZoYXNoLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3JjdWxmaGFzaC5jIGIvc3JjL3JjdWxm
aGFzaC5jCmluZGV4IGI0NTY0MTUuLjUyOTI3MjUgMTAwNjQ0Ci0tLSBhL3NyYy9yY3VsZmhhc2gu
YworKysgYi9zcmMvcmN1bGZoYXNoLmMKQEAgLTExOTgsNyArMTE5OCw3IEBAIGludCBfY2RzX2xm
aHRfZGVsKHN0cnVjdCBjZHNfbGZodCAqaHQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKIAkgKiBLbm93
aW5nIHdoaWNoIHdpbnMgdGhlIHJhY2Ugd2lsbCBiZSBrbm93biBhZnRlciB0aGUgZ2FyYmFnZQog
CSAqIGNvbGxlY3Rpb24gcGhhc2UsIHN0YXkgdHVuZWQhCiAJICovCi0JdWF0b21pY19vcigmbm9k
ZS0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKKwl1YXRvbWljX29yKCh1bnNpZ25lZCBsb25nICopJm5v
ZGUtPm5leHQsIFJFTU9WRURfRkxBRyk7CiAJLyogV2UgcGVyZm9ybWVkIHRoZSAobG9naWNhbCkg
ZGVsZXRpb24uICovCiAKIAkvKgpAQCAtMTQ0MSw3ICsxNDQxLDcgQEAgdm9pZCByZW1vdmVfdGFi
bGVfcGFydGl0aW9uKHN0cnVjdCBjZHNfbGZodCAqaHQsIHVuc2lnbmVkIGxvbmcgaSwKIAkJZGJn
X3ByaW50ZigicmVtb3ZlIGVudHJ5OiBvcmRlciAlbHUgaW5kZXggJWx1IGhhc2ggJWx1XG4iLAog
CQkJICAgaSwgaiwgaik7CiAJCS8qIFNldCB0aGUgUkVNT1ZFRF9GTEFHIHRvIGZyZWV6ZSB0aGUg
LT5uZXh0IGZvciBnYyAqLwotCQl1YXRvbWljX29yKCZmaW5pX2J1Y2tldC0+bmV4dCwgUkVNT1ZF
RF9GTEFHKTsKKwkJdWF0b21pY19vcigodW5zaWduZWQgbG9uZyAqKSZmaW5pX2J1Y2tldC0+bmV4
dCwgUkVNT1ZFRF9GTEFHKTsKIAkJX2Nkc19sZmh0X2djX2J1Y2tldChwYXJlbnRfYnVja2V0LCBm
aW5pX2J1Y2tldCk7CiAJfQogCWh0LT5mbGF2b3ItPnJlYWRfdW5sb2NrKCk7Ci0tIAoyLjM5LjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
