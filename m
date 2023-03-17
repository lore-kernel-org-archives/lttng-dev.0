Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054BC6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679072566;
	bh=lPyPbrSfNWAk5lAXnPYiYW43av1JLl+mc7oglxSPEzY=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SaBt0QedRFrTZ0Uvz2/ubPs7R3P4ZFcoXon5KWELDwRdYukRmtBOVbnVIcbVXXCd7
	 N+FvzQbqm8cKqkUiJagRS9a5o7/+iAq/cKEIihwH7eoXNgRcR7YhSpEEej33WSMEI5
	 yhdy3NPa/BVA3fok61sA6XAqj9kGlTEEpTCgJqFWjpLq3G+mQW8lFIGoqLeX6s0aja
	 J8a8Kp5+/t29vAdvh2dPV0M7oxFW3hCdp6azDLKp8FcfQ4oBtMhCkaqdQDJg4gDd+2
	 z4uzikdcS9LO8+RMKPvoqc6KH76PVdUxs+SCaUb5nEvv4UJE2YP4Oc/+7cioPrL4ap
	 zdQHuJJY/wD2Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PdVn16LWSz2CY6;
	Fri, 17 Mar 2023 13:02:45 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PdVn05tqqz2CvM
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 13:02:44 -0400 (EDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 3EB61320090B;
 Fri, 17 Mar 2023 13:02:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 17 Mar 2023 13:02:42 -0400
X-ME-Sender: <xms:MZ0UZEB1wvIrDeRuiusC7yfOqTLY3ii5C_bc9BOojH_7rg9hbaVjpQ>
 <xme:MZ0UZGiIGfG7XYbycimql4F9cw02z_7nwS-LjOtkWtOfuu3E5PItZQoas-dspEkCW
 ZHpvby3sMWJbig4X5o>
X-ME-Received: <xmr:MZ0UZHncrH_7jWW-JHzqpC0vAAWkUxpybu7LCPQ8EpSrO3XWFvPc6bJ-gqQgUYFYotJCM8HdREi6mM9Hd_6h9S9Ugs0UVcT2hRH_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgleegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepiefgfeetgfehfeduueevheeigeefjeehveevhfffueetgfffgfefkefhudeitdel
 necuffhomhgrihhnpehishgtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:MZ0UZKwBHh1ApySZ-usQ51FgmZnXKNY84hZkLo80opkWHU4ZuhpmWw>
 <xmx:MZ0UZJQCG0qdA3Qc0qe07qP7OQyRc2Vz2_f6M0F8CLy3GW-llRdwlw>
 <xmx:MZ0UZFatJwv3X_GUvpuK8MUiyJK4wCtFxszC_qOlMW25mo5EjHeKPw>
 <xmx:MZ0UZIIWG5F-pfwaGaO804O0SvmrWxQ7EXO76Qrx3xrclz7DDp9YEg>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 13:02:40 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <3b41f7b2-401f-6455-e6e2-a9bfeeabe93d@efficios.com>
Date: Fri, 17 Mar 2023 18:02:28 +0100
Cc: lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Message-Id: <F524C7BA-80C2-42C0-A5EA-697833761DA3@sury.org>
References: <9C7806BF-FD55-45EE-B234-A8274145E19F@sury.org>
 <3b41f7b2-401f-6455-e6e2-a9bfeeabe93d@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: Re: [lttng-dev] userspace-rcu and ThreadSanitizer
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

PiBPbiAxNy4gMy4gMjAyMywgYXQgMTQ6NDQsIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IAo+IEkgd291bGQgaW5kZWVkIGxpa2UgdG8g
cmVtb3ZlIGFsbCB0aGUgY3VzdG9tIGF0b21pY3MgYXNzZW1ibHkgY29kZSBmcm9tIGxpYnVyY3Ug
bm93IHRoYXQgdGhlcmUgYXJlIGdvb2QgYXRvbWljcyBzdXBwb3J0IGluIHRoZSBtYWpvciBjb21w
aWxlcnMgKGdjYyBhbmQgY2xhbmcpLiAKCkhlcmUncyB2ZXJ5IHByZWxpbWluYXJ5IGltcGxlbWVu
dGF0aW9uOgoKaHR0cHM6Ly9naXRsYWIuaXNjLm9yZy9pc2MtcHJvamVjdHMvdXNlcnNwYWNlLXJj
dS8tL21lcmdlX3JlcXVlc3RzLzIKCkkganVzdCBkaWQgc29tZXRoaW5nIHdyb25nIHNvbWV3aGVy
ZSBhbG9uZyB0aGUgcGF0aCBhbmQgaXQgZG9lc24ndCBjb21waWxlIG5vdywKYnV0IGl0IGRpZCBm
b3IgbWUgbG9jYWxseS4KCkkgYW0gc3VibWl0dGluZyB0aGlzIG5vdyBhcyBpdCdzIDE4OjAwIEZy
aWRheSBldmVuaW5nIGFuZCBteSBraWRzIGFyZSBzdGFydGluZyB0bwpiZSBhbmdyeSBhdCBtZSA6
KS4KClRoaXMgd2lsbCBuZWVkIHNvbWUgbW9yZSB3b3JrIC0gSSB0aGluayBzb21lIG9mIHRoZSBj
bW1fIG1hY3JvcyBtaWdodCBiZSBkcm9wcGVkCm5vdywgYW5kIHNvbWVib2R5IHdobyBkb2VzIHRo
YXQgbW9yZSBvZnRlbiB0aGFuIEkgc2hvdWxkIHRha2UgYSBsb29rIGF0IHRoZSBtZW1vcnkKb3Jk
ZXJpbmdzLgoKT25kcmVqCi0tCk9uZMWZZWogU3Vyw70gKEhlL0hpbSkKb25kcmVqQHN1cnkub3Jn
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
