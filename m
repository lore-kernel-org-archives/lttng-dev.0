Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB8C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679394087;
	bh=WVMd8MaG9tBf9RfjykbeQyO4n6lwNioJ9hP7r3SYg70=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YDkkOi+yVGbH/CcAZHl0eu4uRY19V2Rd5bS7LD28L4THSNataMwQ23ABnfJgJe7yV
	 0cfRdrBMBD4qwdmP0tjBTlvrplIUcJlR3/qJNtSsEbiDvOS4LTGkL7qVG43g1tlqW5
	 lRe7SXp9YmPDn9eBQ7Ye9gTyxjpyw8a3ERQ7iWehQZ0V5/eZcnutsHbHRxo0HnqIQq
	 SrUk4+axCiJyLCITXP7HzIeW85r+aM+RzFw3QR7/CrkmsNdEuL9YEL7sTwcynfMft/
	 oYCs+ncnnaxzq9CBLN+pvdJ0V+aZQwoF8AclKkY2TyJxDwn2gZN614gZA5/ljNFou0
	 cxvaQCv2Q781g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pgnh63k3Rz2H1m;
	Tue, 21 Mar 2023 06:21:26 -0400 (EDT)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pgnh55Dhzz2H6g
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 06:21:25 -0400 (EDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 21C21320092D;
 Tue, 21 Mar 2023 06:21:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 21 Mar 2023 06:21:24 -0400
X-ME-Sender: <xms:I4UZZGwWknmUsezT6yW1Psx0YxhMKOQjcqb73xIRkZS0aiHCcfJKsg>
 <xme:I4UZZCSw3p4UHHtHla_3TnN1-nzskUBwF_29DL1qHhlanABZ3P-DwSWwMk-XXJZqu
 kr8EAw3Y08UjmixGxE>
X-ME-Received: <xmr:I4UZZIWvoUcOSfm_L7WGPnzv9J0ZU7Z7aGOuVEqBr2MZjoH0o_8nPmHFLc6uJr76261fL43unILbxouXhG0CPf-3OagKtpvJmGZP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepjedvtddvledufeetueevjeeuheeukeduudfhkeethfeitdefudffkeeffeevkeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhnug
 hrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:I4UZZMilCC1m00kCx7fpPKf6KZ3VXAu5pg_vxgjI4ghQpYgT9tafCA>
 <xmx:I4UZZIAKRHIg9rfcpid42P8Ag05ABK0bPIji-YEYFDY67gC0hEH0Bg>
 <xmx:I4UZZNIUTvev-NlO2IL9-w_Awe5DBLfGY3GTSjsStMBiH-cUNf6Ptw>
 <xmx:I4UZZB6iU3bKOqf5atSXPPXJkhY-EuYQNoagV0tz-s1-DPOBckWGsg>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 06:21:22 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
Date: Tue, 21 Mar 2023 11:21:10 +0100
Cc: lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Message-Id: <A012AAA8-7E40-40A3-A272-1703EFA26314@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-8-ondrej@sury.org>
 <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: Re: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier
 in free_completion()
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
Reply-To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

PiBPbiAyMC4gMy4gMjAyMywgYXQgMTk6MzcsIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IAo+IE9uIDIwMjMtMDMtMTcgMTc6MzcsIE9u
ZMWZZWogU3Vyw70gdmlhIGx0dG5nLWRldiB3cm90ZToKPj4gRklYTUU6IFRoaXMgaXMgZXhwZXJp
bWVudCB0aGF0IGFkZHMgZXhwbGljaXQgbWVtb3J5IGJhcnJpZXIgaW4gdGhlCj4+IGZyZWVfY29t
cGxldGlvbiBpbiB0aGUgd29ya3F1ZXVlLmMsIHNvIFRocmVhZFNhbml0aXplciBrbm93cyBpdCdz
IG9rIHRvCj4+IGZyZWUgdGhlIHJlc291cmNlcy4KPj4gU2lnbmVkLW9mZi1ieTogT25kxZllaiBT
dXLDvSA8b25kcmVqQHN1cnkub3JnPgo+PiAtLS0KPj4gIHNyYy93b3JrcXVldWUuYyB8IDEgKwo+
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+IGRpZmYgLS1naXQgYS9zcmMvd29y
a3F1ZXVlLmMgYi9zcmMvd29ya3F1ZXVlLmMKPj4gaW5kZXggMTAzOWQ3Mi4uZjIxOTA3ZiAxMDA2
NDQKPj4gLS0tIGEvc3JjL3dvcmtxdWV1ZS5jCj4+ICsrKyBiL3NyYy93b3JrcXVldWUuYwo+PiBA
QCAtMzc3LDYgKzM3Nyw3IEBAIHZvaWQgZnJlZV9jb21wbGV0aW9uKHN0cnVjdCB1cmN1X3JlZiAq
cmVmKQo+PiAgIHN0cnVjdCB1cmN1X3dvcmtxdWV1ZV9jb21wbGV0aW9uICpjb21wbGV0aW9uOwo+
PiAgICAgY29tcGxldGlvbiA9IGNhYV9jb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgdXJjdV93b3Jr
cXVldWVfY29tcGxldGlvbiwgcmVmKTsKPj4gKyBhc3NlcnQoIXVyY3VfcmVmX2dldF91bmxlc3Nf
emVybygmY29tcGxldGlvbi0+cmVmKSk7Cj4gCj4gUGVyaGFwcyB3aGF0IHdlIHJlYWxseSB3YW50
IGhlcmUgaXMgYW4gQU5OT1RBVEVfVU5QVUJMSVNIX01FTU9SWV9SQU5HRSgpIG9mIHNvbWUgc29y
dCA/CgpJIGd1ZXNzPwoKTXkgZXhwZXJpZW5jZSB3aXRoIFRTQU4gdGVsbHMgbWUsIHRoYXQgeW91
IG5lZWQgc29tZSBraW5kIG9mIG1lbW9yeSBiYXJyaWVyIHdoZW4gdXNpbmcgYWNxdWlyZS1yZWxl
YXNlCnNlbWFudGljcyBhbmQgeW91IGRvOgoKaWYgKF9fYXRvbWljX3N1Yl9mZXRjaChvYmotPnJl
ZiwgX19BVE9NSUNfUkVMRUFTRSkgPT0gMCkgewogIC8qIF9fQVRPTUlDX0FDUVVJUkUgbmVlZGVk
IGhlcmUgKi8KICAgZnJlZShvYmopOwp9Cgp3ZSBlbmQgdXAgdXNpbmcgZm9sbG93aW5nIGNvZGUg
aW4gQklORCA5OgoKaWYgKF9fYXRvbWljX3N1Yl9mZXRjaChvYmotPnJlZiwgX19BVE9NSUNfQUNR
X1JFTCkgPT0gMCkgewogICBmcmVlKG9iaik7Cn0KClNvLCBJIGFtIGd1ZXNzaW5nIGFmdGVyIHRo
ZSBjaGFuZ2Ugb2YgdWF0b21pY19zdWJfcmV0dXJuKCkgdG8gX19BVE9NSUNfQUNRX1JFTCwKdGhp
cyBwYXRjaCBzaG91bGQgbm8gbG9uZ2VyIGJlIG5lZWRlZC4KCk9uZHJlagotLQpPbmTFmWVqIFN1
csO9IChIZS9IaW0pCm9uZHJlakBzdXJ5Lm9yZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
