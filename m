Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0EBC74A5B
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679089093;
	bh=adP2J5TG4acO6vi6WnLoi83JPf4iwRLAhxAxe4hnJnE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=fvfXD9TxoKtQGzqXnriOHFgFRYfIBRxF7NkS8sda0gDFNCVJvTNG2VCAToN5r8cIH
	 U4xYl/deyHb0xJH46P0EZXLeTrNB3ahvTF0VEsDMiVF0m655c6ajpKFpoBA4A720px
	 vCnqnavHIqlyTdkanWmQZyZNdoWcHJcWwwcGcLXA7fdrkQVlqbY5Dq2r31XDIKYq+w
	 ZW48d+9j4qkBGh2D0kO1SAOBsa91NKnP1AyORm8XB5HOiWHXd2+0lnWaeotB7yqLRW
	 VJtDKAMlhBimag2h884hDOI88hOqLrC9PjaixOWAo6uyJZ0IwvGUVr/sEtMQhECFTy
	 ncuNy3UF4jQ2g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pdcts0yBTz2Cvt;
	Fri, 17 Mar 2023 17:38:13 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pdctq3cKQz2Cvq
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:11 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id C19D83200916
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 17 Mar 2023 17:38:09 -0400
X-ME-Sender: <xms:wd0UZEL8sZNNjQSSg8d6wNfn4cRSakSMDalC5XhBeJaGNy2dEdQKAA>
 <xme:wd0UZELQOdwf3lT073uequEsTV2VSNz5SEXy4Pl6mDYVtkOfqgN9i31TtBPyHzzxg
 lL5saHMQF50om1NCfo>
X-ME-Received: <xmr:wd0UZEtQ8eXm02k2BTJ_IKmySs77OUytIQYoURlv1EFfff2mL_MFAAKbQoYLXdWtLw6XXuWmaGZc-hZo2iXkqrpv1Kccge5AAWQt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekre
 dtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhih
 rdhorhhgqeenucggtffrrghtthgvrhhnpeeiveeiueejveelfffgkefhkeehkeevieelud
 dvvefhleeggeeujedvteekleefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:wd0UZBb-6QmlWH6boc66NHZFkamGA8ffiAmss7_nfP7uGy4UJ_w1aQ>
 <xmx:wd0UZLa3dP8-FN0ht9sfRTCcCINtT_MleHJXaCC6Co8soBZISahVsQ>
 <xmx:wd0UZNBYblJSRI1bblwEYY3Po_rQrZScM8VjQxRTfPu9dkOaBSydew>
 <xmx:wd0UZF0JG9MfzDwmZVG9F-3w-SzN940AqgZf-ktotx_MLWIgShEw0w>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:08 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 17 Mar 2023 22:37:48 +0100
Message-Id: <20230317213755.455957-1-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 0/7] Replace the custom code with gcc/clang
 __atomic builtins
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

SGksCgoodGhpcyBpcyBteSBmaXJzdCB0aW1lIHVzaW5nIGdpdCBzZW5kLWVtYWlsLCBzbyBJIGFw
b2xvZ2lzZSBpbiBhZHZhbmNlIGlmCmFueXRoaW5nIGJyZWFrcykuCgpIZXJlJ3MgbXkgYXR0ZW1w
dCB0byBjb252ZXJ0IHRoZSBVc2Vyc3BhY2UgUkNVIHRvIHVzZSBfX2F0b21pYyBidWlsdGlucyB3
aGVuZXZlcgpwb3NzaWJsZSBpbnN0ZWFkIG9mIGN1c3RvbSBhc3NlbWJseS4KClRoZSBfX2F0b21p
YyBidWlsdGlucyB3ZXJlIGZpcnN0IGludHJvZHVjZWQgaW4gZ2NjIDQuNy4wIGFuZCBjbGFuZyAz
LjEuMC4KCkFwYXJ0IGZyb20gc2ltcGxpZnlpbmcgdGhlIGNvZGUsIHRoaXMgc2hvdWxkIGFsc28g
aGVscCBUaHJlYWRTYW5pdGl6ZXIgdG8KdW5kZXJzdGFuZCB0aGUgbWVtb3J5IHN5bmNocm9uaXph
dGlvbiBhbmQgcmVwb3J0IGxlc3MgKG9yIG5vKSB3YXJuaW5ncy4KClRoZSBjb2RlIGNvbXBpbGVz
IGFuZCB0aGUgdGVzdHMgcGFzc2VkIChvbiBhbWQ2NCkuCgpUaGlzIGlzIGJ5IG5vIG1lYW5zIGNv
bXBsZXRlLCBhbmQgbW9zdCBwcm9iYWJseSBJIG1pc3NlZCBvciBtaXN1bmRlcnN0b29kCnNvbWV0
aGluZywgYnV0IGl0J3MgYSBzb2xpZCBzdGFydCwgc28gSSBhbSBzdWJtaXR0aW5nIHRoZSBwYXRj
aCBzZXQgZm9yCmRpc2N1c3Npb24gYW5kIHJldmlldy4KClRoYW5rcywKLS0KT25kxZllaiBTdXLD
vSA8b25kcmVqQHN1cnkub3JnPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
