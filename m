Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A2C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679393765;
	bh=Zwyr61o8+wXGOFUwcVf5Rb6ZIg4LAEkDB0f66F59bQQ=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=B5Tk+sVNGU3VMHzz8cfALfh+93yCDqJ8zah9eXFN7Xqd/FvfyfElOxim+XJDmrDnG
	 IeP94/iDhYO4Arz+w41i9FrOOK61hSnwR+fLsxT2R6xQC2OfFsgRKjS6QFAfIvNMJU
	 k2jo9f4dm8ioD/WhZkw81txf0PGRtwI/07/zqRMfqO5BxRRH0FW496VPz8G/Qan+NB
	 Ij7kuAxkXMWwQ9r5OT9OPZPGZCQPxrT/3E6Kq7jtoz+7QZoMHtapD+/pyGdUncVxgf
	 PWtG8Wx9S18vEl63I2AAGsRTyIQ9RbZSTonrhFqLr49swhrDWxbIOkf6q2H1JG3wUS
	 /iNc8fJmq81tA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgnYx16CCz2Gmh;
	Tue, 21 Mar 2023 06:16:05 -0400 (EDT)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgnYv5z3Fz2H45
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 06:16:03 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 2AB4F3200BC9;
 Tue, 21 Mar 2023 06:16:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 21 Mar 2023 06:16:02 -0400
X-ME-Sender: <xms:4YMZZJ6WGWcXLup4Ybe8ME0Nv_DifU9gAErUZq2HGhUqB-FWrpAXOQ>
 <xme:4YMZZG4x1Qj9pDe5vLYD66I5_Ukli5nYc-xTenvMDYrhEwQ4XP0Sc2mnRJOE2hAMW
 UhvtE4yOgX7unnmN1U>
X-ME-Received: <xmr:4YMZZAc49zmda-kdsT3pVuw_342eDQFrht2qti-HoPRYjHaz1dkYsgjhwEXtWF8cJI7iqTLgSs9twt8WPHo6xzZhtiTN3oFimmDN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepjedvtddvledufeetueevjeeuheeukeduudfhkeethfeitdefudffkeeffeevkeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhnug
 hrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:4YMZZCKR8MfcLaJRMRHR31LlCj-3ky5ui166se1x8SE-rcG0boixpw>
 <xmx:4YMZZNIbbsfgMRMNkxd50AeZAUK0DQsRJACEOWc8QvVISh5NI70RfA>
 <xmx:4YMZZLwgXxnCkMpEWFXH12wl0uRvkSVWmUWPqAmoQMgKcoRvPOflWA>
 <xmx:4YMZZPyu-p6sLeq9gWuZ-yCtwD1gDkwbsPsee75YBKzzBuHcFCBdPg>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 06:16:00 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <9aad8537-6053-7d30-6575-8986c46ce607@efficios.com>
Date: Tue, 21 Mar 2023 11:15:48 +0100
Cc: lttng-dev@lists.lttng.org
Message-Id: <25F238AC-69EB-47BB-BEAF-B513C44B652E@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-7-ondrej@sury.org>
 <9aad8537-6053-7d30-6575-8986c46ce607@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: Re: [lttng-dev] [PATCH 6/7] Fix: uatomic_or() need retyping to
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
Reply-To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Cj4gT24gMjAuIDMuIDIwMjMsIGF0IDE5OjMxLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiAKPiBPbiAyMDIzLTAzLTE3IDE3OjM3LCBP
bmTFmWVqIFN1csO9IHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4+IFdoZW4gYWRkaW5nIFJFTU9WRURf
RkxBRyB0byB0aGUgcG9pbnRlcnMgaW4gdGhlIHJjdWxmaGFzaAo+PiBpbXBsZW1lbnRhdGlvbiwg
cmV0eXBlIHRoZSBnZW5lcmljIHBvaW50ZXIgdG8gdWludHB0cl90IHRvIGZpeCB0aGUKPj4gY29t
cGlsZXIgZXJyb3IuCj4gCj4gV2hhdCBpcyB0aGUgY29tcGlsZXIgZXJyb3IgPyBJJ20gd29uZGVy
aW5nIHdoZXRoZXIgdGhlIGV4cGVjdGVkIGNob2ljZQo+IHRvIG1hdGNoIHRoZSByZXN0IG9mIHRo
aXMgZmlsZSdzIGNvbnRlbnQgd291bGQgYmUgdG8gdXNlICJ1aW50cHRyX3QgKiIgb3IgInVuc2ln
bmVkIGxvbmcgKiIgPwoKVGhpcyBpcyB0aGUgZXJyb3I6CgpyY3VsZmhhc2guYzoxMjAxOjI6IGVy
cm9yOiBhZGRyZXNzIGFyZ3VtZW50IHRvIGF0b21pYyBvcGVyYXRpb24gbXVzdCBiZSBhIHBvaW50
ZXIgdG8gaW50ZWdlciAoJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJyBpbnZhbGlkKQogICAgICAg
IHVhdG9taWNfb3IoJm5vZGUtPm5leHQsIFJFTU9WRURfRkxBRyk7CiAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgouLi9pbmNsdWRlL3VyY3UvdWF0b21pYy5oOjYw
Ojg6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3VhdG9taWNfb3InCiAgICAgICAgKHZvaWQp
X19hdG9taWNfb3JfZmV0Y2goKGFkZHIpLCAobWFzayksIF9fQVRPTUlDX1JFTEFYRUQpCiAgICAg
ICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+CnJjdWxmaGFzaC5jOjE0NDQ6MzogZXJy
b3I6IGFkZHJlc3MgYXJndW1lbnQgdG8gYXRvbWljIG9wZXJhdGlvbiBtdXN0IGJlIGEgcG9pbnRl
ciB0byBpbnRlZ2VyICgnc3RydWN0IGNkc19sZmh0X25vZGUgKionIGludmFsaWQpCiAgICAgICAg
ICAgICAgICB1YXRvbWljX29yKCZmaW5pX2J1Y2tldC0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
Ci4uL2luY2x1ZGUvdXJjdS91YXRvbWljLmg6NjA6ODogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNy
byAndWF0b21pY19vcicKICAgICAgICAodm9pZClfX2F0b21pY19vcl9mZXRjaCgoYWRkciksICht
YXNrKSwgX19BVE9NSUNfUkVMQVhFRCkKICAgICAgICAgICAgICBeICAgICAgICAgICAgICAgICB+
fn5+fn4KCnVpbnRwdHJfdCBpcyBkZWZpbmVkIGFzICJ1bnNpZ25lZCBpbnRlZ2VyIHR5cGUgY2Fw
YWJsZSBvZiBob2xkaW5nIGEgcG9pbnRlciB0byB2b2lkIiB3aGlsZSB1bnNpZ25lZCBsb25nIGlz
IGF0IGxlYXN0IDMyLWJpdDsKCkkgZ3Vlc3MgdGhhdCB3b3JrcyBpbiBhIHByYWN0aXNlLCBidXQg
dXNpbmcgdW5zaWduZWQgbG9uZyB0byByZXR5cGUgdGhlIHBvaW50ZXJzIG1pZ2h0IGJsb3cgdXAg
KHRoaW5raW5nIG9mIHgzMiB3aGljaCBJIGtub3cKbGl0dGxlIGFib3V0LCBidXQgaXQncyBraW5k
IG9mIGh5YnJpZCBhcmNoaXRlY3R1cmUsIGlzbid0IGl0PykKCk9uZHJlagotLQpPbmTFmWVqIFN1
csO9IChIZS9IaW0pCm9uZHJlakBzdXJ5Lm9yZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
