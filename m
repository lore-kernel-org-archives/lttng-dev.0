Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B48C77B7C
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 05:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685079217;
	bh=xrg5Q8PpZeMnYfsPmfYIQPf8ieETVaq2rC9YqhKQVtI=;
	h=Date:References:Cc:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DI9DVfVHK7tlKn2k4Sf+xeHL9SjrS7Vx4z0/3CskZYExN7Hi++fTn+0GF9zGLkNc5
	 rBTbnqUTdQcvIgAxMs0GWBhjSvld+qxRQDev+2nHkCR/pm5W26Tpjb6PgpCoqVBm7e
	 8aqkWFJvpCX5u3kif0UWPDWf642YmgxKYuJ2Qcb1jKNc8mm5W5C+j/90Em6G6DPinw
	 VzrWHk075RjHMfJpWbLXCM2+aom8UehVCuGOMQygV3SQDnfsWAOY4HU+4J/7yaTRT8
	 MCpvx/nVTN+zsUzErOuHQW474GBToTqiXhSfvFlBEcF+i06DrCvJQvw3a7bFzoYMe3
	 xi0ksoI65qc0Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSD9X3Pj2z1T3J;
	Fri, 26 May 2023 01:33:36 -0400 (EDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSD9W0JdFz1T3B
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 01:33:34 -0400 (EDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id E530B5C0093;
 Fri, 26 May 2023 01:33:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 26 May 2023 01:33:33 -0400
X-ME-Sender: <xms:rURwZEp6LBtDfTzULomqKu2f5Axgw1CC9lTFZMK1kls-snzBtjewLQ>
 <xme:rURwZKqp_LchFSj8QGfri73YprHBDqG5jXtj3613dCT8dp0CKGTTYoZ_F2BEHWdbr
 zVP1gzoebe6Ly6Hhp4>
X-ME-Received: <xmr:rURwZJNRGyMgOw1NTOZFAc-bDBf3IXHNomBG0lparug0ZXqhfuIXuOGo81Q0YOyKVAUuzNNKEgVa9oQVSia9x0Mnl1JnEaVJHzZB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejkedgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepgfehhfduhfduieefjeethffhveduudeffffhfeeitddvtdfhhfehvdekgeehieev
 necuffhomhgrihhnpehlthhtnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:rURwZL45U3BIW7wflVRqj4v7zDPlt4kukPZFhoyOt7AOUv_jUMVCgQ>
 <xmx:rURwZD4OvNQpDj0GyyEMxbh68JxcoCRiRYGTUk7h7P6ukST6u87Z2w>
 <xmx:rURwZLhg7O4GgkMQgueZ_kC0ZjFiiWVKoFNQzQeO05Thsla-KauAng>
 <xmx:rURwZG18rMJUdUjeHJmso5J3vf2r7y-xRI6m56s6s43cH2luQmb0cQ>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 01:33:33 -0400 (EDT)
Mime-Version: 1.0 (1.0)
Date: Fri, 26 May 2023 07:33:20 +0200
Message-Id: <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
Cc: Olivier Dion <odion@efficios.com>, tsan-users <tsan-users@google.com>,
 lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Tony Finch <fanf@isc.org>
In-Reply-To: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (20G5026e)
Subject: Re: [lttng-dev] [PATCH 00/11] Add support for TSAN to liburcu
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

QSBsaXR0bGUgYml0IHJlbGF0ZWQgcXVlc3Rpb24vcHJvYmxlbSAtIHNvbWUgb2Ygb3VyIHN5c3Rl
bSB0ZXN0IGpvYnMgZ290IHNpZ25pZmljYW50bHkgc2xvd2VyICgzeC01eCkgd2l0aCAqKmNsYW5n
LTE2KiogVFNBTiBhZnRlciB3ZSBpbnRlZ3JhdGVkIGxpYnVyY3UgdG8gQklORCA5LiBUaGUgR0ND
ICgxMy4xLjEpIFRTQU4gZG9lc27igJl0IGV4aGliaXQgdGhpcyBiZWhhdmlvci4KClRoZSBsaWJ1
cmN1IGludGVncmF0aW9uIGluIEJJTkQgOSBpcyB2ZXJ5IGxpZ2h0IGF0IHRoZSBtb21lbnQgLSB3
ZSB1c2UgbGlidXJjdSBmb3IgcXB0cmllIGFuZCB0aGVyZeKAmXMgc29tZSB1c2FnZSBvZiB3ZmNx
dWV1ZSBmb3IgcXVldWluZyBqb2JzKGNhbGxiYWNrcykgYmV0d2VlbiB0aHJlYWRzLgoKV2Ugd2Vy
ZSBub3QgYWJsZSB0byBwdXQgYSBmaW5nZXIgb24gaXQgeWV0LCBidXQgc2F5aW5nIHRoaXMgYWxv
dWQgbWlnaHQgaGVscCBkaWFnbm9zZSB0aGlzLgoKT25kcmVqCi0tCk9uZMWZZWogU3Vyw70gPG9u
ZHJlakBzdXJ5Lm9yZz4gKEhlL0hpbSkKCj4gT24gMjQuIDUuIDIwMjMsIGF0IDEwOjE1LCBEbWl0
cnkgVnl1a292IHZpYSBsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IHdyb3Rl
Ogo+IAo+IO+7v09uIFR1ZSwgMjMgTWF5IDIwMjMgYXQgMTg6MDUsIE9saXZpZXIgRGlvbiA8b2Rp
b25AZWZmaWNpb3MuY29tPiB3cm90ZToKPj4gCj4+IEhpIERtaXRyeSwKPj4gCj4+IFdlIGRvIGhh
dmUgYSBuZXcgaXNzdWUgYW5kIHdlIHRoaW5rIGl0IG1pZ2h0IGJlIGEgbGltaXRhdGlvbiBmcm9t
IFRTQU4uCj4+IAo+PiBGaW5kIGF0dGFjaGVkIGEgdGVzdCBwcm9ncmFtIHRoYXQgd2UgYmVsaWV2
ZSBpcyBjb3JyZWN0LiAgWW91IGNhbgo+PiBjb21waWxlIGl0IHdpdGggYGdjYyAtZnNhbml0aXpl
PXRocmVhZCB0ZXN0LmMgLXB0aHJlYWQnLgo+PiAKPj4gCj4+IFRTQU4gZmxhZ3MgYSByYWNlIGNv
bmRpdGlvbiBiZXR3ZWVuIHRoZSBhdG9taWMgc3RvcmUgcmVsYXhlZCBhdCBsaW5lIDM2Cj4+IGFu
ZCB0aGUgZnJlZSBhdCBsaW5lIDgxLgo+PiAKPj4gV2UgY2FuIHNvbHZlIHRoZSBpc3N1ZSBieSBy
ZXBsYWNpbmcgdGhlIGF0b21pYyBzdG9yZSByZWxheGVkIHdpdGggYQo+PiBhdG9taWMgc3RvcmUg
cmVsZWFzZS4gIEhvd2V2ZXIsIHRoZSBwcmVjZWRpbmcgYXRvbWljIGV4Y2hhbmdlIHdpdGgKPj4g
c2VxdWVudGlhbCBjb25zaXN0ZW5jeSBhbHJlYWR5IGFjdHMgYXMgYW4gaW1wbGljaXQgcmVsZWFz
ZSAoaW4gdGVybSBvZgo+PiBtZW1vcnkgYmFycmllcikgZm9yIHRoZSBmb2xsb3dpbmcgc3RvcmUs
IG1ha2luZyB0aGUgcmVsZWFzZSBzZW1hbnRpYwo+PiByZWR1bmRhbnQuCj4+IAo+PiBXZSd2ZSBm
b3VuZCBhbiBhbHRlcm5hdGl2ZSB0byBmaXggdGhpcyBieSBpZ25vcmluZyB0aGUgdGhyZWFkIGR1
cmluZyB0aGUKPj4gcmVsYXhlZCBzdG9yZSAobGluZSAzOSkuICBIb3dldmVyLCB3aGF0IHdlIHdv
dWxkIGxpa2UgaXMgdG8gYW5ub3RhdGUgdGhlCj4+IG1lbW9yeSBzdG9yZWQgKGxpbmUgNDUpLgo+
PiAKPj4gTXkgdGhlb3J5IChJIGRvbid0IGtub3cgdGhlIGludGVybmFsIG9mIFRTQU4gbXVjaCkg
aXMgdGhhdCBUU0FOIHRoaW5rcwo+PiBmb3Igc29tZSByZWFzb24gdGhhdCB0aGUgYXRvbWljIHN0
b3JlIHJlbGF4ZWQgaGFwcGVuIGF0IHRoZSBzYW1lIGVwb2NoCj4+IGFzIHRoZSBmcmVlLCByZXN1
bHRpbmcgaW4gYSBmYWxzZSBwb3NpdGl2ZS4gIElmIHNvLCBtCj4gCj4gCj4gSSBkb24ndCB0aGlz
IHRoaXMgaXMgdHJ1ZSBpbiB0aGUgQy9DKysgbWVtb3J5IG1vZGVsOgo+ICJ0aGUgcHJlY2VkaW5n
IGF0b21pYyBleGNoYW5nZSB3aXRoIHNlcXVlbnRpYWwgY29uc2lzdGVuY3kgYWxyZWFkeQo+IGFj
dHMgYXMgYW4gaW1wbGljaXQgcmVsZWFzZSAoaW4gdGVybSBvZiBtZW1vcnkgYmFycmllcikgZm9y
IHRoZQo+IGZvbGxvd2luZyBzdG9yZSIuCj4gCj4gc3RkOjphdG9taWNfdGhyZWFkX2ZlbmNlIGRv
ZXMgYWZmZWN0IGFsbCBwcmVjZWRpbmcvc3Vic2VxdWVudAo+IG9wZXJhdGlvbnMsIGJ1dCBhbiBh
dG9taWMgbWVtb3J5IG9wZXJhdGlvbiBvbmx5IGFmZmVjdHMgb3JkZXJpbmcgb24KPiB0aGF0IHZh
cmlhYmxlLCBpdCBkb2Vzbid0IGFsc28gc2VydmUgYXMgYSBzdGFuZGFsb25lIG1lbW9yeSBmZW5j
ZS4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
