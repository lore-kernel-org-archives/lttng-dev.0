Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBD9EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 10:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687430150;
	bh=cu+xgVOztp4+dVSH1ho9PFpZPvTUuO2WS/Hc6H9X9Ic=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=zL5uVEv8TEE9zhp3BLskjFmq6oS+21Raz3j3WVZwHva1kfy7waQH1pLjbtZ5/5phY
	 eaR3/Kgka1qpQs5ZyboPZos2XF5VBYmEa+NwpANX6Pku7kbw3bk+8srlFpZN9Gz+zJ
	 cjh3q8rdA25f2QF2rtjgcBJHudGw2a1R3Bw/5R4mvlVk9dSg4j1hEKK8xobYgavimF
	 tFAJpRJiAlTdyds+Gov07hDCpZaS8JFyX82KGdH7dBIF3J2HC5BiawbVv+no23O3ob
	 4cD8A70NJfHufR+4bQbGLA0bWf4li4wI77fNCPSZV9bMfpR2LxOqokE2Q+Nxm/1AYk
	 5Y2RcbeQG9Yzg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qmxbp204mz209H;
	Thu, 22 Jun 2023 06:35:50 -0400 (EDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qmxbm5H89z202R
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 06:35:48 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id BE81A5C011C;
 Thu, 22 Jun 2023 06:27:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 22 Jun 2023 06:27:57 -0400
X-ME-Sender: <xms:LSKUZOqemQIZHq1BTd9TEnsdmsKIhN6weFJ8qnw_ZdPK8UasesqCiQ>
 <xme:LSKUZMoB3dOFSCz43Hbai8OzETQYhrZpyM6mKBHE_c2GdgAWrh5VThzq7nngi86K_
 wVgIOL6NWAMrAQJLU8>
X-ME-Received: <xmr:LSKUZDOXTY7J9BuzEwVE5F6AlCsQMq5VnMW_7DYuDadEMSoZJlIas9wdCXiC_85NQZnMZJ-0pgBRIRsxsZBuLxXHyiMmA-Hqvs26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
 dtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhih
 rdhorhhgqeenucggtffrrghtthgvrhhnpefhueetleffveevvefgkeevjedtkeeigfefud
 etffefhedukeeuleeufeeggeffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:LSKUZN6eyC5AyU70Te6k-6EGKe1Pvc3zX2qT0ZFZl_uCfokseFQFQQ>
 <xmx:LSKUZN7cEl8F-IM1Ipv7vl9deWn_C-Jr-RoH73h79wpIeDvcBwLcFA>
 <xmx:LSKUZNgaBg8jtJWe_orM5-h7zPv2YwOg2VG4BQrkDFvNvekH5za4ng>
 <xmx:LSKUZKhHlTjMkfb0VHjmEGVP3XL0657XvDUHWhs3tqh_tRzJGCOG9A>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 06:27:56 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Date: Thu, 22 Jun 2023 12:26:27 +0200
Message-Id: <20230622102626.569224-1-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] Avoid calling caa_container_of on NULL pointer
 in cds_lfhash macros
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

VGhlIGNkc19sZmh0X2Zvcl9lYWNoX2VudHJ5IGFuZCBjZHNfbGZodF9mb3JfZWFjaF9lbnRyeV9k
dXBsaWNhdGUgbWFjcm9zCndvdWxkIGNhbGwgY2FhX2NvbnRhaW5lcl9vZigpIG1hY3JvIG9uIE5V
TEwgcG9pbnRlci4gIFRoaXMgaXMgbm90IGEKcHJvYmxlbSB1bmRlciBub3JtYWwgY2lyY3Vtc3Rh
bmNlcyBhcyB0aGUgY2hlY2sgaW4gdGhlIGZvciBsb29wIGZhaWxzCmFuZCB0aGUgbG9vcC1zdGF0
ZW1lbnQgaXMgbm90IGNhbGxlZCB3aXRoIGludmFsaWQgKHBvcykgdmFsdWUuCgpIb3dldmVyIEFk
ZHJlc3NTYW5pdGl6ZXIgZG9lc24ndCBsaWtlIHRoYXQgYW5kIGNvbXBsYWlucyBhYm91dCB0aGlz
OgoKICAgIHJ1bnRpbWUgZXJyb3I6IGFwcGx5aW5nIG5vbi16ZXJvIG9mZnNldCAxODQ0Njc0NDA3
MzcwOTU1MTA1NiB0byBudWxsIHBvaW50ZXIKCk1vdmUgdGhlIGNkc19sZmh0X2l0ZXJfZ2V0X25v
ZGUoaXRlcikgIT0gTlVMTCBmcm9tIHRoZSBjb25kLWV4cHJlc3Npb24Kb2YgdGhlIGZvciBsb29w
IGludG8gYm90aCBpbml0LWNsYXVzZSBhbmQgaXRlcmF0aW9uLWV4cHJlc3Npb24gYXMKY29uZGl0
aW9uYWwgb3BlcmF0b3IgYW5kIGNoZWNrIGZvciAocG9zKSB2YWx1ZSBpbiB0aGUgY29uZC1leHBy
ZXNzaW9uCmluc3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3Vy
eS5vcmc+Ci0tLQogaW5jbHVkZS91cmN1L3JjdWxmaGFzaC5oIHwgMjAgKysrKysrKysrKy0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VyY3UvcmN1bGZoYXNoLmggYi9pbmNsdWRlL3VyY3UvcmN1
bGZoYXNoLmgKaW5kZXggZmJkMzNjYy4uYWFmYzQ1NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91cmN1
L3JjdWxmaGFzaC5oCisrKyBiL2luY2x1ZGUvdXJjdS9yY3VsZmhhc2guaApAQCAtNTQ2LDIyICs1
NDYsMjIgQEAgdm9pZCBjZHNfbGZodF9yZXNpemUoc3RydWN0IGNkc19sZmh0ICpodCwgdW5zaWdu
ZWQgbG9uZyBuZXdfc2l6ZSk7CiAKICNkZWZpbmUgY2RzX2xmaHRfZm9yX2VhY2hfZW50cnkoaHQs
IGl0ZXIsIHBvcywgbWVtYmVyKQkJCVwKIAlmb3IgKGNkc19sZmh0X2ZpcnN0KGh0LCBpdGVyKSwJ
CQkJCVwKLQkJCXBvcyA9IGNhYV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShp
dGVyKSwgXAotCQkJCQlfX3R5cGVvZl9fKCoocG9zKSksIG1lbWJlcik7CVwKLQkJY2RzX2xmaHRf
aXRlcl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMOwkJCVwKKwkJCXBvcyA9IChjZHNfbGZodF9pdGVy
X2dldF9ub2RlKGl0ZXIpICE9IE5VTEwgPyBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0X2l0ZXJf
Z2V0X25vZGUoaXRlciksIFwKKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIpIDogTlVM
TCk7CVwKKwkJcG9zICE9IE5VTEw7CQkJXAogCQljZHNfbGZodF9uZXh0KGh0LCBpdGVyKSwJCQkJ
XAotCQkJcG9zID0gY2FhX2NvbnRhaW5lcl9vZihjZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIp
LCBcCi0JCQkJCV9fdHlwZW9mX18oKihwb3MpKSwgbWVtYmVyKSkKKwkJCXBvcyA9IChjZHNfbGZo
dF9pdGVyX2dldF9ub2RlKGl0ZXIpICE9IE5VTEwgPyBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0
X2l0ZXJfZ2V0X25vZGUoaXRlciksIFwKKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIp
IDogTlVMTCkKIAogI2RlZmluZSBjZHNfbGZodF9mb3JfZWFjaF9lbnRyeV9kdXBsaWNhdGUoaHQs
IGhhc2gsIG1hdGNoLCBrZXksCQlcCiAJCQkJaXRlciwgcG9zLCBtZW1iZXIpCQkJXAogCWZvciAo
Y2RzX2xmaHRfbG9va3VwKGh0LCBoYXNoLCBtYXRjaCwga2V5LCBpdGVyKSwJCVwKLQkJCXBvcyA9
IGNhYV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAotCQkJCQlf
X3R5cGVvZl9fKCoocG9zKSksIG1lbWJlcik7CVwKLQkJY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShp
dGVyKSAhPSBOVUxMOwkJCVwKKwkJCXBvcyA9IChjZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIp
ICE9IE5VTEwgPyBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlciks
IFwKKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIpIDogTlVMTCk7CVwKKwkJcG9zICE9
IE5VTEw7CQkJXAogCQljZHNfbGZodF9uZXh0X2R1cGxpY2F0ZShodCwgbWF0Y2gsIGtleSwgaXRl
ciksCQlcCi0JCQlwb3MgPSBjYWFfY29udGFpbmVyX29mKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUo
aXRlciksIFwKLQkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1iZXIpKQorCQkJcG9zID0gKGNk
c19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlcikgIT0gTlVMTCA/IGNhYV9jb250YWluZXJfb2YoY2Rz
X2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAorCQkJCQlfX3R5cGVvZl9fKCoocG9zKSksIG1l
bWJlcikgOiBOVUxMKQogCiAjaWZkZWYgX19jcGx1c3BsdXMKIH0KLS0gCjIuMzkuMgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
