Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870EC6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679068272;
	bh=3E2XaYxT76WrRYFHz8Li8w1F9aa2fMjVhHEjo7fA58M=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zZ7yf82j179eR8TpEizlpaKi62HbeK/vdvgOOouJllqf1LZaS2xZRucFpKE752nO3
	 1fp4Yr/v1bFT1jh/LSE7UBRE4tWp3ybe5qZL4fAQZOqlyBsG+hE3xyq0WnUvSDC3BU
	 KQvWOz18jT0eGysV1N8uW/aZQ4FNWNkPMTEYir5R9wIXdqIUDP/9TD2no7FjhMiObA
	 x66VWhPhgKXthxvRKGtlIBertwg7T/O5gXtwrutYvOa/CFYaRdiKzANw6RvRRyTGEq
	 1Xdt1tINveZm3awIz/fQchsihi7uD68PpQVeiJ3fo3rTcc5pNu3ktrFsINmknXk2WB
	 pRZlgSBTn5RNA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PdTBR4C9Mz2Cgn;
	Fri, 17 Mar 2023 11:51:11 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PdTBQ133Jz2Ck2
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 11:51:10 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 757D932002D8;
 Fri, 17 Mar 2023 11:51:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 17 Mar 2023 11:51:08 -0400
X-ME-Sender: <xms:a4wUZAojv4_M8SzAfBukQGym-j_C8dXaBGIlWZXCK8BqJrWx1JNKUQ>
 <xme:a4wUZGoDCy87wMjiiRyXZutvTE2bSMQ4hslxZnTNZZ4eLBdU-w_jdV_56GQbsg9SG
 XMkVSR2xUBQWiZ9rpM>
X-ME-Received: <xmr:a4wUZFMI2vVKHc_-Up3N_IlTmJMJGO1cdKayJZ3hHaYsAbZAeecJn2DlT5CNQsC9vtrP0Af8I9zaK45tbDoXIlvwRrYbvQ_i-Iaa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepiefgfeetgfehfeduueevheeigeefjeehveevhfffueetgfffgfefkefhudeitdel
 necuffhomhgrihhnpehishgtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:a4wUZH6Jt3yH6QPPUNcLQeWvujPY94waqQ9ZMIGgDY5ZvdlsT7CXKQ>
 <xmx:a4wUZP6CGEBZcS3qsAXvqNuIvQIO05tVleIuTvICdviE5-lRUIsDug>
 <xmx:a4wUZHiWLtcf9Y2VwqD2a3EVf-9SaqAKGxdEPEWEKfsKH1xjR5dyqQ>
 <xmx:bIwUZJQGm04M3PEl1A8n3Zpw6P6AOK1hSyX71l_gKobXDY8RWTzmmw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 11:51:06 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <3b41f7b2-401f-6455-e6e2-a9bfeeabe93d@efficios.com>
Date: Fri, 17 Mar 2023 16:50:53 +0100
Cc: lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Message-Id: <3778B038-5A99-4498-9BDE-D205BC1281DF@sury.org>
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
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IAo+IFN1cmUsIGNhbiB5b3UgcGxlYXNlIHN1
Ym1pdCB0aGUgcGF0Y2ggYXMgYSBzZXBhcmF0ZSBlbWFpbCB3aXRoIHN1YmplY3QvY29tbWl0IG1l
c3NhZ2Uvc2lnbmVkLW9mZi1ieSB0YWcgPwoKCmh0dHBzOi8vZ2l0bGFiLmlzYy5vcmcvaXNjLXBy
b2plY3RzL3VzZXJzcGFjZS1yY3UvLS9tZXJnZV9yZXF1ZXN0cy8xLnBhdGNoCgpXb3VsZCB0aGlz
IHdvcmsgZm9yIHlvdT8KCk9yIGRvIHlvdSBuZWVkIHRvIGhhdmUgdGhlIHBhdGNoIGF0dGFjaGVk
PwoKT25kcmVqCi0tCk9uZMWZZWogU3Vyw70gKEhlL0hpbSkKb25kcmVqQHN1cnkub3JnCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
