Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C15C761AF
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679337373;
	bh=4GdNvD0IUZrgwb5PI1nBjj1MR4ixpNVWqHGGdr6Y1rc=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IehT1Ny7DSH2ufLDGwoyQVA1dUSlk8YWAWFKR1Vv3e8F3uQOvkznHicJ+DCopbWeT
	 EtCOKEWtDXUvrfpdx1Tqa6HgmP3fpwiVks6JsNH/EVc5w+59mQq1twZj+0jha5Cd8T
	 fatycO3nLZPH8tBEzsBMCfvSpJskKiQb3ICSNGHoZR3r7CEcK+UmhwMhHggsO62fL0
	 d9kO0po97bfcZNbeWuHzVdhQQwpumRWaT+pZA7ZRX6AGsAXamWMulT7Y4RsqFRvW0u
	 q9elTwcVgBFcqFfSQuSjQHOdYP+CBzD/jHeexDsd2Czwxoae6Qm/Chc4ZybkuoUVev
	 O2YnzH8FcjGtQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNjS6gJsz2Db7;
	Mon, 20 Mar 2023 14:36:12 -0400 (EDT)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNjR2nsbz2Db3
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:36:11 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 3B09032008FC;
 Mon, 20 Mar 2023 14:28:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 20 Mar 2023 14:28:29 -0400
X-ME-Sender: <xms:zKUYZP5JOCp4fqEcYG--K73ymvZtefVZf_Clj6TTNXMUme4ue6GVAg>
 <xme:zKUYZE7Rj05nve3h4NGp3KQXpQY5UpCoDGnXtbFxlo4QVWijc_TTUuEsGO4iW0vd7
 x9jGdiDmlE3jvuvDgE>
X-ME-Received: <xmr:zKUYZGeKkDjXrSAigdOTl7su8ZK4ZHgaEmcwg_WHLKsl_paSWhY45eMFudWzgbkuWlyy0-Je8usY5MDSLTZe-fszAP6YAQTPmZEt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepqfhn
 ughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhihrdhorhhgqeenucggtffrrghtth
 gvrhhnpefhieffgeeuffduheetkeeltdethefgtdehvdeuhfeuteduudegudejteelkefg
 keenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:zKUYZALkuh_-3VzYYIMoVbgs-fIhUowlxS1LFSCv-vUKKhhGEFBlQQ>
 <xmx:zKUYZDKliJVxgVALC_2CxWAPfIzN8iGHr9mKIHAzgJxo1p2-uyFnqg>
 <xmx:zKUYZJzel5YnnJi81DJ8lLFTVhmN_XXMlteR3H6pU1gLrKUMl3E-ZA>
 <xmx:zKUYZJitVXg2iYtMWDjwZjX6NK4Y8z-Wxm2MMN784gDpTmsNXcH9eQ>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 14:28:27 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
Date: Mon, 20 Mar 2023 19:28:16 +0100
Cc: lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Message-Id: <5C9355A4-AE1B-45B5-915E-D41C45A488BE@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: Re: [lttng-dev] [PATCH 2/7] Use gcc __atomic builtis for
 <urcu/uatomic.h> implementation
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

Cj4gT24gMjAuIDMuIDIwMjMsIGF0IDE5OjAzLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiAKPiBJbiBkb2MvdWF0b21pYy1hcGkubWQs
IHdlIGRvY3VtZW50Ogo+IAo+ICJgYGBjCj4gdHlwZSB1YXRvbWljX2NtcHhjaGcodHlwZSAqYWRk
ciwgdHlwZSBvbGQsIHR5cGUgbmV3KTsKPiBgYGAKPiAKPiBBbiBhdG9taWMgcmVhZC1tb2RpZnkt
d3JpdGUgb3BlcmF0aW9uIHRoYXQgcGVyZm9ybXMgdGhpcwo+IHNlcXVlbmNlIG9mIG9wZXJhdGlv
bnMgYXRvbWljYWxseTogY2hlY2sgaWYgYGFkZHJgIGNvbnRhaW5zIGBvbGRgLgo+IElmIHRydWUs
IHRoZW4gcmVwbGFjZSB0aGUgY29udGVudCBvZiBgYWRkcmAgYnkgYG5ld2AuIFJldHVybiB0aGUK
PiB2YWx1ZSBwcmV2aW91c2x5IGNvbnRhaW5lZCBieSBgYWRkcmAuIFRoaXMgZnVuY3Rpb24gaW1w
bGllcyBhIGZ1bGwKPiBtZW1vcnkgYmFycmllciBiZWZvcmUgYW5kIGFmdGVyIHRoZSBhdG9taWMg
b3BlcmF0aW9uLiIKPiAKPiBUaGlzIHdvdWxkIG1hcCB0byBhICJfX0FUT01JQ19BQ1FfUkVMIiBz
ZW1hbnRpYyBvbiBjbXB4Y2hnIGZhaWx1cmUKPiByYXRoZXIgdGhhbiBfX0FUT01JQ19DT05TVU1F
Ii4KCgpGcm9tOiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL18wMDVmXzAwNWZh
dG9taWMtQnVpbHRpbnMuaHRtbAoKPiBJZiBkZXNpcmVkIGlzIHdyaXR0ZW4gaW50byAqcHRyIHRo
ZW4gdHJ1ZSBpcyByZXR1cm5lZCBhbmQgbWVtb3J5IGlzIGFmZmVjdGVkIGFjY29yZGluZyB0byB0
aGUgbWVtb3J5IG9yZGVyIHNwZWNpZmllZCBieSBzdWNjZXNzX21lbW9yZGVyLiBUaGVyZSBhcmUg
bm8gcmVzdHJpY3Rpb25zIG9uIHdoYXQgbWVtb3J5IG9yZGVyIGNhbiBiZSB1c2VkIGhlcmUuCj4g
Cj4gT3RoZXJ3aXNlLCBmYWxzZSBpcyByZXR1cm5lZCBhbmQgbWVtb3J5IGlzIGFmZmVjdGVkIGFj
Y29yZGluZyB0byBmYWlsdXJlX21lbW9yZGVyLiBUaGlzIG1lbW9yeSBvcmRlciBjYW5ub3QgYmUg
X19BVE9NSUNfUkVMRUFTRSBub3IgX19BVE9NSUNfQUNRX1JFTC4gSXQgYWxzbyBjYW5ub3QgYmUg
YSBzdHJvbmdlciBvcmRlciB0aGFuIHRoYXQgc3BlY2lmaWVkIGJ5IHN1Y2Nlc3NfbWVtb3JkZXIu
CgpJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRoYXQgdGhlIGZhaWx1cmVfbWVtb3JkZXIgaGFzIHRo
ZSBzYW1lIG1lbW9yZGVyIGFzIHVhdG9taWNfcmVhZCgpLCBidXQgaXQgZGVmaW5pdGVsbHkgY2Fu
bm90IGJlIF9fQVRPTUlDX0FDUV9SRUwgLSBpdCdzIHNhbWUgYXMgd2l0aCBfX2F0b21pY19sb2Fk
X24sIG9ubHkgZm9sbG93aW5nIGFyZSBwZXJtaXR0ZWQ6Cgo+IFRoZSB2YWxpZCBtZW1vcnkgb3Jk
ZXIgdmFyaWFudHMgYXJlIF9fQVRPTUlDX1JFTEFYRUQsIF9fQVRPTUlDX1NFUV9DU1QsIF9fQVRP
TUlDX0FDUVVJUkUsIGFuZCBfX0FUT01JQ19DT05TVU1FLgoKT25kcmVqCi0tCk9uZMWZZWogU3Vy
w70gKEhlL0hpbSkKb25kcmVqQHN1cnkub3JnCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
