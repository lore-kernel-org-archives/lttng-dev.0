Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B0C77B7F
	for <lttng-dev@archiver.kernel.org>; Tue, 16 May 2023 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684243271;
	bh=eRml/jbTIjk6enV0efoVgZnrkAEu8V58IgsX0spKozo=;
	h=Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SMaxfghkFew0WVCBcf8lDv8BUJgVhYhOLty+RX33/KpekNHA6wnw5rD7YFHF4KUbI
	 feIVSVYqhjD0tB0OlWWQ2zUM2uFjmit4LJKc/M1qLFIL/ctdnuDHxijrcOeWv/W++M
	 BYc9cdgwPv5qh8ibcSk/szz51Owf3d5atK43qzICr/GmAlVAfyiVjKhyoN8aFA4qk7
	 bf2jW/xAQmmd65ZCVGUav2dzFwOivx4sCMz2l8DlbPFy1HK9Sp43a1uj/gcMl4kD9a
	 paW4XWOoAgbAW2kPvLCqMb6CuZmR5VP/oEoZv+5i2KWPVRjDVG5SBM7LiGRZxFnBFa
	 Cb/HtbwKB5Aqg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLH1g0wdmz1F5c;
	Tue, 16 May 2023 09:21:11 -0400 (EDT)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLH1d1DZDz1FVL
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 09:21:09 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id EE71E320095A;
 Tue, 16 May 2023 09:11:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 16 May 2023 09:11:56 -0400
X-ME-Sender: <xms:G4FjZJ4MK6iJWPrfdMe9J3geE06bRAYMgIf4y6Q4WypN8qwZjR2E-w>
 <xme:G4FjZG5vSDUFOAl8cUQ-w_-9wTZ8PuyhJhx4Khq7k-ptrJhVqlz_ZdNBvyPJqAFd6
 QfcmrUkCdabsYgx6tY>
X-ME-Received: <xmr:G4FjZAeevNjlVo1oQgdRC8uGfFD-kGMpcU6wtVY-eQQjxKB2FYsqUdp5EZvLaWfeSy7bQl4FTQkcC7MDdVcqtCKVji82qbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgieduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepkeelveevgefhjedtjeevfffgjeejgfeuheelgeevkefhjedtueehhfefvedvgedu
 necuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhdplhhtthhnghdrohhrghenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhes
 shhurhihrdhorhhg
X-ME-Proxy: <xmx:G4FjZCL_oMMEeah8pEy5OATOBMN5KHZIDGfYFsU0XJwFZ_LeL3rVug>
 <xmx:G4FjZNLxYNxffnY6fKeSUL2C-KK6jOBqhWS7h7ePHGqRFxkq8k7epg>
 <xmx:G4FjZLw-CHlxZNPbtODXJC5zzCjhxKXbWxO0iTfJRon8fUOKvD4HJA>
 <xmx:G4FjZLgMeE8z9L0IKG2O1x_gqMT6m8CMo4aDcJN0zje4drDQDy2wtw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 09:11:54 -0400 (EDT)
Mime-Version: 1.0 (1.0)
Date: Tue, 16 May 2023 15:11:41 +0200
Message-Id: <BB27C4AF-9908-4B67-976D-88515D8AB563@sury.org>
References: <87v8gzuc3g.fsf@laura>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <87v8gzuc3g.fsf@laura>
To: Olivier Dion <odion@efficios.com>
X-Mailer: iPhone Mail (20F5059a)
Subject: Re: [lttng-dev] [RFC] Deprecating RCU signal flavor
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

SGksCgp3ZSAoSVNDKSBoYXZlIG5vIGludGVudGlvbiBvZiB1c2luZyBzaWduYWwgYmFzZWQgVVJD
VSBpbiBCSU5EIDkuIE91ciBwbGFuIHJlbGllcyBvbiB1c2luZyB0aGUgUVNCUiBmbGF2b3IgYXMg
QklORCA5IGlzIGludGVybmFsbHkgZXZlbnQtbG9vcCBiYXNlZCB3aXRoIG5hdHVyYWwgcXVpZXNj
ZW50IHN0YXRlcy4KCk9uZHJlaiAKLS0KT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPiAo
SGUvSGltKQoKPiBPbiAxMC4gNS4gMjAyMywgYXQgMjM6MTAsIE9saXZpZXIgRGlvbiB2aWEgbHR0
bmctZGV2IDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToKPiAKPiDvu79IaSBhbGws
Cj4gCj4gV2UgaGF2ZSB0aGUgaW50ZW50aW9uIG9mIGRlcHJlY2F0aW5nIHRoZSB1cmN1LXNpZ25h
bCBmbGF2b3IgaW4gdGhlCj4gZnV0dXJlLiAgV2UgYXJlIGFza2luZyB1c2VycyBvZiBVUkNVIGZv
ciBfZmVlZGJhY2tfIG9uIHRoaXMgYmVmb3JlCj4gZ29pbmcgYW55IGZ1cnRoZXIuCj4gCj4gUGFy
dCBvZiB0aGlzIGRlY2lzaW9uIGlzIHRoYXQgd2UgYXJlIGFkZGluZyBzdXBwb3J0IGZvciBUU0FO
IGluIFVSQ1UgYW5kCj4gdGhlIHNpZ25hbCBmbGF2b3IgZGVhZGxvY2tzIHdpdGggVFNBTi4gIEl0
IGlzIGFsc28gbXkgdW5kZXJzdGFuZGluZyB0aGF0Cj4gdGhlIHVyY3Utc2lnbmFsIGZsYXZvciB3
YXMgaGlzdG9yaWNhbGx5IG1hZGUgYXMgYSBmYWxsYmFjayBmb3Igc3lzdGVtCj4gbGFja2luZyB0
aGUgbWVtYmFycmllcigyKSBzeXN0ZW0gY2FsbC4gIE5vd2FkYXlzLCBtb3N0IHN5c3RlbXMgaGF2
ZQo+IHN1cHBvcnQgZm9yIHRoYXQgc3lzdGVtIGNhbGwsIG1ha2luZyB0aGUgdXJjdS1zaWduYWwg
YW4gYXJ0aWZhY3Qgb2YgdGhlCj4gcGFzdC4KPiAKPiBUaGUgZm9sbG93aW5nIGlzIGEgcHJvcG9z
ZWQgdGltZWxpbmUgb2YgZXZlbnRzOgo+IAo+ICAxLiBBc2tpbmcgZm9yIGZlZWRiYWNrIGZyb20g
dXNlcnMgb2YgVVJDVSAodGhpcyBtZXNzYWdlKQo+ICAyLiBEaXNhYmxpbmcgdGhlIHNpZ25hbCBm
bGF2b3IgYnkgZGVmYXVsdCBhbmQgYWRkaW5nIC0tZW5hYmxlLWZsYXZvci1zaWduYWwKPiAgMy4g
UmVtb3ZpbmcgdGhlIHNpZ25hbCBmbGF2b3IKPiAKPiAtLSAKPiBPbGl2aWVyIERpb24KPiBFZmZp
Y2lPUyBJbmMuCj4gaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tCj4gCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
