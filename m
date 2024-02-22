Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9385C48BF8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Feb 2024 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1708617651;
	bh=wBk4PEl4Kl+tB53Ccvl6MKimyemCWeuq9CrZ/hnyxj0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cP4uHliV6D1uhKxeD6Z7kGfmOMwpK8bA2y77whn/BKXADUgFoEWFS3uK0/HbpeqGz
	 mSPSZ7YdTEBSu+2xuYtkApt17OSpsoODq96hnP+luFNt76MjdYVRPzP9zLnsmTxNWb
	 rKY4KS+41bWJWJf+6nrfmuorpRkPGqb1mkO6RUxO4Sj3R23Dbp9/tM+voVx2btIZu/
	 GPaSmj6saUakOumWiA4EastMUcpjVkA2u7pQJ8m0xfOkc6VaBD1I0LCOi3RdInHtGW
	 hTwtf7MXGsJL1fZ/si7sHiZ8BAv16O64ViK8SuHbzE60AylZUJ9cpQ8Kl2av7+Kgsr
	 A9D47c/2dTjvA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TgdCj096vz28MV;
	Thu, 22 Feb 2024 11:00:48 -0500 (EST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4TgdCg1QwRz28KL
 for <lttng-dev@lists.lttng.org>; Thu, 22 Feb 2024 11:00:46 -0500 (EST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 4408E5C0064
 for <lttng-dev@lists.lttng.org>; Thu, 22 Feb 2024 11:00:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 22 Feb 2024 11:00:46 -0500
X-ME-Sender: <xms:rW_XZXg_KdrOgU8eMXYPUOE5I9_AROEbkYj1kZ4wmpnwVwUjNPV_mA>
 <xme:rW_XZUDyK82GwIBfeiDE2uskQSZ39MQE-KBRCJ04IC1br0GYUtIVVyNTPC0PRK3gQ
 C_ihCvQZOLbwKzwjOQ>
X-ME-Received: <xmr:rW_XZXH9u6Hr882APLP-jfRxIZLNcPFz60tvpn_lCGCQ60-bZrWx6oAYTH14u5b6Zm_ODVcvP8CculT4Y3R05yVnHBgM6PT7XRAC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
 dtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhihrdho
 rhhgqeenucggtffrrghtthgvrhhnpeekieekgffhhedvteelfeefleeiiefhtdfhtdeule
 ffffdtveeujeetuedvkeevjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:rW_XZUTbzakKp1R8ATiOsNd0YqDrcJvP4tZatYbfJ8eHB60KXeT-eA>
 <xmx:rW_XZUw4mZbjKZjgMh84a6dwbDP2-Hegp8Khszm3CfF5z4JTrMmElQ>
 <xmx:rW_XZa7cxxYlmg_dJVeQA-mhEFN5mNRJS1XH01bPEpzdp6rJyNYmhA>
 <xmx:rm_XZab3RpS5NYJgQOkXVggYLUgWmmAz5SLH3tfGVifp3Kzb6Yo4Jw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Thu, 22 Feb 2024 11:00:45 -0500 (EST)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Message-Id: <98C490B1-BC85-45BA-B7D6-25305465D337@sury.org>
Date: Thu, 22 Feb 2024 17:00:31 +0100
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Subject: [lttng-dev] (Userspace-)RCU based HEAP (priority queue)
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

SGksCgp3ZSBhcmUganVzdCBleHBsb3JpbmcgdGhlIGZpZWxkLCBzbyBhc2tpbmcgaGVyZSBpcyBw
cm9iYWJseSBnb29kIGlkZWEuCgpXZSBhcmUgY3VycmVudGx5IHVzaW5nIGJ1Y2tldGVkIGhlYXBz
IGZvciBUVEwtYmFzZWQgZXhwaXJhdGlvbiBvZgpETlMgcmVjb3JkcyBpbiBCSU5EIDkuICBUaGlz
IGRvZXNuJ3Qgc2NhbGUgdGhhdCB3ZWxsIGFuZCBoYXMgb3RoZXIKcHJvYmxlbXMsIHNvIEkgd2Fz
IHRoaW5raW5nIHRoYXQgd2UgbWlnaHQgYmUgYWJsZSB0byByZXBsYWNlIHRoaXMgd2l0aApzb21l
dGhpbmcgYmV0dGVyLgoKQW55b25lIGhlYXJkIG9yIHJlYWQgYWJvdXQgZ29vZCBsb2NrLWZyZWUg
LyB3YWl0LWZyZWUgcHJpb3JpdHkgcXVldWVzCnByZWZlcmFibHkgYmFzZWQgb24gVVJDVT8gOikK
CkNoZWVycywKLS0KT25kxZllaiBTdXLDvSAoSGUvSGltKQpvbmRyZWpAc3VyeS5vcmcKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
