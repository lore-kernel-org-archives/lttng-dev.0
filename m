Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D48C7EE23
	for <lttng-dev@archiver.kernel.org>; Fri, 26 May 2023 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1685096152;
	bh=8wR93JvOIlGshN9RzvZxhN9dmhel7mXWBAxXNr9Khsw=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rE7o9UC95/FPOT8VI9AkdfFBT/JLYm1M3KWu9EnOqJNDhcJsY2v5QzTW4qjywg+SN
	 WrbMWRP8wag0c98BseuTQELa0wyMW8J91KmAyGio+VTJwvaAdK7e8nw4KJWPa3kCvM
	 UoKMDDWUqAEEW9gu+WSV/pxjUOgRUG9rEjwMGFhrAzBizwsZKgxtk9+tTNmG0TyH9Z
	 r/hW8yPVkYLSEoXLyulobhVNRLGFJ5+/4x3lmIZvDqWLTuzqxJ/bK0DD1aQPS2Fepm
	 Inw5ptk041yhGr52jCDKAnc87WdFmkFxvQJnCqSL1vnKE2Bh8YKnbddey3DtNT5DTV
	 EA6cBWZ8FvOng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QSLRC42NBz1T9b;
	Fri, 26 May 2023 06:15:51 -0400 (EDT)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by lists.lttng.org (Postfix) with ESMTPS id 4QSLRB13nZz1T9Y
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2023 06:15:49 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id D863F5C0107;
 Fri, 26 May 2023 06:06:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 26 May 2023 06:06:14 -0400
X-ME-Sender: <xms:loRwZG1JYMb1IK6aL3l3O8GZEaE1WV95d2nHsQMdjNsqthBxBGRz5w>
 <xme:loRwZJFNaXekb4vncR7NTXdIRaSiDCVv8wXkdLk_xyPuOCFBiddZKBkVao7zCvwW8
 h56lKgXrQ-WrDMtyG8>
X-ME-Received: <xmr:loRwZO6kkqrJDJvrhXtfebJxUOxLLH8c1x0sZRnucM7f8DfQYGDVT8MLHkVegStVHl9--tF_FB8opmFXDIzRZoB1TJ2BLyqyAp4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepffdtgfdvgeeuheelheetjedvhefhheegleetgfdvheehtdeileeijefgteeukeef
 necuffhomhgrihhnpehlthhtnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:loRwZH156RSnHfLRq_HAH0HJMLg-5gkeqwIaaFvEQ1Q99j5xv2mKjA>
 <xmx:loRwZJHMDkwQZuHII9U8MB1yve7zVxwVDdl7LnWa6lwYleSVz4Ghyg>
 <xmx:loRwZA_8qYIBCgOZuDWZDtrZES_LB4Mq2UmXofKRiTHpGN0uk5zz3A>
 <xmx:loRwZNhgJciG1W2N-tYouVSwxRBbGtF6CKJHj7Rzlh9BWl8toEAZjw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 06:06:12 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.1\))
In-Reply-To: <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
Date: Fri, 26 May 2023 12:06:00 +0200
Cc: Olivier Dion <odion@efficios.com>, tsan-users <tsan-users@google.com>,
 lttng-dev <lttng-dev@lists.lttng.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Tony Finch <fanf@isc.org>
Message-Id: <2D55847D-F6DC-48F2-BF12-44736D0AC1EF@sury.org>
References: <CACT4Y+a22N7gvcePvBazN_=AyeigVaeH-nFX-ZqZbq49mftMPg@mail.gmail.com>
 <EFA4F8F7-0767-4FEF-8EA5-DDEA05F3296C@sury.org>
 <CACT4Y+bwGm1h5A0qsjCQrLzwt+uAbNZ-D+6zSr6PiXDGq2LgYw@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
X-Mailer: Apple Mail (2.3731.700.1)
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
Reply-To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Cj4gT24gMjYuIDUuIDIwMjMsIGF0IDg6MDgsIERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xl
LmNvbT4gd3JvdGU6Cj4gCj4gT24gRnJpLCAyNiBNYXkgMjAyMyBhdCAwNzozMywgT25kxZllaiBT
dXLDvSA8b25kcmVqQHN1cnkub3JnPiB3cm90ZToKPj4gCj4+IEEgbGl0dGxlIGJpdCByZWxhdGVk
IHF1ZXN0aW9uL3Byb2JsZW0gLSBzb21lIG9mIG91ciBzeXN0ZW0gdGVzdCBqb2JzIGdvdCBzaWdu
aWZpY2FudGx5IHNsb3dlciAoM3gtNXgpIHdpdGggKipjbGFuZy0xNioqIFRTQU4gYWZ0ZXIgd2Ug
aW50ZWdyYXRlZCBsaWJ1cmN1IHRvIEJJTkQgOS4gVGhlIEdDQyAoMTMuMS4xKSBUU0FOIGRvZXNu
4oCZdCBleGhpYml0IHRoaXMgYmVoYXZpb3IuCj4+IAo+PiBUaGUgbGlidXJjdSBpbnRlZ3JhdGlv
biBpbiBCSU5EIDkgaXMgdmVyeSBsaWdodCBhdCB0aGUgbW9tZW50IC0gd2UgdXNlIGxpYnVyY3Ug
Zm9yIHFwdHJpZSBhbmQgdGhlcmXigJlzIHNvbWUgdXNhZ2Ugb2Ygd2ZjcXVldWUgZm9yIHF1ZXVp
bmcgam9icyhjYWxsYmFja3MpIGJldHdlZW4gdGhyZWFkcy4KPj4gCj4+IFdlIHdlcmUgbm90IGFi
bGUgdG8gcHV0IGEgZmluZ2VyIG9uIGl0IHlldCwgYnV0IHNheWluZyB0aGlzIGFsb3VkIG1pZ2h0
IGhlbHAgZGlhZ25vc2UgdGhpcy4KPiAKPiBJbnRlcmVzdGluZy4gQ2xhbmcgMTYgZ290IGEgY29t
cGxldGVseSBuZXcgdHNhbiBydW50aW1lCj4gaW1wbGVtZW50YXRpb24sIHdoaWNoIGlzIGdlbmVy
YWxseSB+MnggZmFzdGVyIGFuZCBjb25zdW1lcyBsZXNzCj4gbWVtb3J5Lgo+IEhvd2V2ZXIsIG9m
IGNvdXJzZSwgaXQncyBub3QgcG9zc2libGUgdG8gb3B0aW1pemUgZm9yIGFsbCBnYXppbGxpb24g
b2YKPiBwcm9ncmFtcyBpbiB0aGUgd29ybGQuIEkgc3VzcGVjdCBsaWJyY3UgdGVzdHMgYXJlIHF1
aXRlIGV4dHJlbWUgaW4KPiB0ZXJtcyBvZiBzeW5jaHJvbml6YXRpb24uCj4gCj4gSWYgeW91IGNv
bGxlY3QgcGVyZiBwcm9maWxlcyBmb3IgYm90aCwgSSBjYW4gbG9vayBmb3Igc29tZSBsb3cgaGFu
Z2luZyBmcnVpdC4KPiBPciBpcyB0aGVyZSBhIHJlYXNvbmFibGUgd2F5IGZvciBtZSB0byByZXBy
b2R1Y2U/CgpMb29rcyBsaWtlIGl0IGdvdCBhbGwgcmVzb2x2ZWQgYnkgdXNpbmcgdGhlIGxhdGVz
dCBsaWJ1cmN1IHBhdGNoIHNldCB3aXRoIGZ1bGwKVFNBTiBzdXBwb3J0LiBJIGhhdmVuJ3QgcmVh
bGl6ZWQgdGhhdCBvdXIgQ0kgc3RpbGwgcnVucyB3aXRoIHdoYXRldmVyIGxpYnVyY3UKRGViaWFu
IGJ1bGxzZXllIGhhdmUuIFNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgoKQW5kIEkgY2FuIG5vIGxv
bmdlciByZXByb2R1Y2UgdGhpcyBsb2NhbGx5LgoKRlRSIGhlcmUgYXJlIHNvbWUgbnVtYmVycyBm
cm9tIG15IGxvY2FsIHN5c3RlbSAoMTN0aCBHZW4gSW50ZWwoUikgQ29yZShUTSkgaTktMTM5MDBL
KQpydW5uaW5nIFRTQU4tZW5hYmxlZCBwYXRjaGVkIHVzZXJzcGFjZS1yY3VbMV0sIGxpYnV2IDEu
NDUuMCBhbmQgT3BlblNTTCAzLjAuODoKCmdjYy0xMyBiYXNlbGluZQoKcnB6OiAgICAgICAgICAg
IHBhc3NlZCBpbiAxOTguNzFzICgwOjAzOjE4KQpycHpyZWN1cnNlOiAgICAgcGFzc2VkIGluIDMx
MC42MnMgKDA6MDU6MTApCnJyc2V0b3JkZXI6ICAgICBwYXNzZWQgaW4gMjAwLjQwcyAoMDowMzoy
MCkKCmdjYy0xMyBUU0FOCgpycHo6ICAgICAgICAgICAgcGFzc2VkIGluIDMwNS42NHMgKDA6MDU6
MDUpCnJwenJlY3Vyc2U6ICAgICBwYXNzZWQgaW4gNDI3LjczcyAoMDowNzowNykKcnJzZXRvcmRl
cjogICAgIHBhc3NlZCBpbiAyNjAuNjVzICgwOjA0OjIwKQoKY2xhbmctMTYgVFNBTgoKcnB6OiAg
ICAgICAgICAgIHBhc3NlZCBpbiAyOTAuMDVzICgwOjA0OjUwKQpycHpyZWN1cnNlOiAgICAgcGFz
c2VkIGluIDQ2OC41M3MgKDA6MDc6NDgpCnJyc2V0b3JkZXI6ICAgICBwYXNzZWQgaW4gMjU4Ljk3
cyAoMDowNDoxOCkKClRoaXMgbG9va3MgcXVpdGUgcmVhc29uYWJsZSB0byBtZS4KCjEuIGdpdCBm
ZXRjaCBodHRwczovL3Jldmlldy5sdHRuZy5vcmcvdXNlcnNwYWNlLXJjdSByZWZzL2NoYW5nZXMv
NTgvMTAwNTgvMSAmJiBnaXQgY2hlY2tvdXQgRkVUQ0hfSEVBRAoKT25kcmVqCi0tCk9uZMWZZWog
U3Vyw70gKEhlL0hpbSkKb25kcmVqQHN1cnkub3JnCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
