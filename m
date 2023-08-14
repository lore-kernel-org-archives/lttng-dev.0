Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE4C001DB
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Aug 2023 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692027445;
	bh=69g8PlfAkFeOHU06DJXrEHzsayN/7EVs8epbszBbfeU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Bk3+yHrv4K25zejZqxT2vgtzEQqpszUMeQkEmvjgNeTxdvu8AG0zTst0azmGPgXFB
	 R2Cl3Cin4Oqew7qBEr8vHbzYtCcWxOVe406Yq4PrAZ133lZGEnefBonxcVt2eYhRWX
	 7sQa1IHIZPsyPSQjgDXK9QsMdXdccum1JWvTivCQi0fXYqFdPAF6GfoKUA9CwW4YKg
	 LrxEMOiUrFriaamKzlYv8/QrK9Ttieie78LqkfIkYGUIXeYtsn6XEGtpUzzjB4vv8F
	 uQO4dkEeXcaMN8s7na4r3BoZeEiL8uxwmhT7w7tu8jxxH0Rf10N1EkzvT2NUz6xuwI
	 kj4PkErei1HCQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RPdnJ5hB8z2Lvg;
	Mon, 14 Aug 2023 11:37:24 -0400 (EDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by lists.lttng.org (Postfix) with ESMTPS id 4RPdnH4jV8z2Lmx
 for <lttng-dev@lists.lttng.org>; Mon, 14 Aug 2023 11:37:23 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id DBABC5C006A
 for <lttng-dev@lists.lttng.org>; Mon, 14 Aug 2023 11:37:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 14 Aug 2023 11:37:22 -0400
X-ME-Sender: <xms:MkraZIgwNsr-ujurI2n8d9yrdq4fzy4gmK1vkhq1yg-g7RVXxY2NZA>
 <xme:MkraZBD2Ar6u0qTBJ3HvJQOJerdE16E7jCiPy0dW6c9AyJX054jFYgu3BEng3Fwsq
 RYJ9m_zJmbj32U4scY>
X-ME-Received: <xmr:MkraZAF9dT7_ObbBdNjiIzr2ev07saUPPqtCGQ9bQRUXWhcXjyGgITfGioLaqctumNaiNKDLzjBi8yv1K7arRO_djQKtYMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpegtgffhggffuffkvffosehtqhhmtd
 hhtdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidr
 ohhrgheqnecuggftrfgrthhtvghrnhepheffvdeuveehfffhuedufeekveelvdevgfelte
 efjeetfffhieehvdelieelvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:MkraZJSLJIYURLMDgNDEW5GHIMGvRYmpyYeMu5KNIil3m7rKDKTbRw>
 <xmx:MkraZFwqqjO4KPy9ISRV5xgVG_FuqCUdoVonv_tXHY3x35DmFNtI0w>
 <xmx:MkraZH5NOTdEL_NQwbu86HURffmXDB5LCYJdd7hnKgP1FqJHypiLvA>
 <xmx:MkraZOvaSUWpmn2dvp9mFOZtvy1xnR2gDGoAEdmTcI5bb7_tFbn5NQ>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Mon, 14 Aug 2023 11:37:22 -0400 (EDT)
Mime-Version: 1.0 (1.0)
Date: Mon, 14 Aug 2023 17:37:08 +0200
Message-Id: <6F359DD7-0AEE-4102-A14A-C07D03DB6B22@sury.org>
To: lttng-dev@lists.lttng.org
X-Mailer: iPhone Mail (21A5303d)
Subject: [lttng-dev] LTTng-UST and SystemTap/DTrace
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
Reply-To: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@sury.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksCgp3ZSBhcmUgaW4gcHJvY2VzcyBvZiBhZGRpbmcgVVNEVCBwcm9iZXMgdG8gdGhlIEJJTkQg
OSBwcm9iZXMgYW5kIHRoZSBvYnZpb3VzIHF1ZXN0aW9uIGlzIHdoZXRoZXIgaXTigJlzIHBvc3Np
YmxlIHRvIHVzZSB0aGUgcHJvYmVzIHdpdGggdGhlIExUVG5nIHRvb2xzLgoKQWx0ZXJuYXRpdmVs
eSwgaWYgdGhlcmXigJlzIGFuIGVhc3kgd2F5IGhvdyB0byB1c2Ugb25lIG9yIGFub3RoZXIuIFRo
ZSBVU0RUIHByb2JlcyBhcmUgcHJvdmlkZWQgYnkgU3lzdGVtVGFwIG9uIExpbnV4IGFuZCBieSBE
VHJhY2Ugb24gQlNEcyBhbmQgU29sYXJpcywgc28gdGhleSBhcmUgbW9yZSB1bml2ZXJzYWwgZm9y
IG91ciB1c2UsIGJ1dCB1c2luZyBwZXJmIHJlY29yZCBmZWVscyBtb3JlIGNvbXBsaWNhdGVkIGZv
ciB1cy4KCklkZWFsbHksIHdlIHdvdWxkIGxpa2UgdG8gZ2l2ZSB1c2VycyBhIGNob2ljZSBvciBh
dCBsZWFzdCBoYXZlIGEgYmFja3VwIHBsYW4gdG8gc3dpdGNoIGlmIHdlIHBpY2sgdGhlIHdyb25n
IHRlY2hub2xvZ3kgYW5kIGl0IGRvZXNu4oCZdCB3b3JrIGZvciB1cyBvciBvdXIgdXNlcnMuCgpB
bnkgdGhvdWdodHMgb3IgZXhwZXJpZW5jZXM/CgpPbmRyZWoKLS0KT25kxZllaiBTdXLDvSA8b25k
cmVqQHN1cnkub3JnPiAoSGUvSGltKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
