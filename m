Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4114EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687430907;
	bh=m3jOo7C37kYQ7VVGEqoFm7ld0eX6JaoBm4BC/AhDqrU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YLnIddnD24adY7gX0ECZnJ/1BZa6X/LQ2NLJR8Jh4rRuk+Oa2cLfpD7r53+/DqeZK
	 pogpAotRHUj/6v0UMv2ApfrQO0p6C39dRhUl7eju8x8YJllgMjKwQNJW83ujuHlrQN
	 tzby7PN+j9ojT+1FuD99IKb023f7itnm7jA+USJ9A1kf2ddkFOsy4o56OAOOcvEfXP
	 vwRXg8PANIn2njKIGYE/bRzdYjC+FojbStdo8uDqBf5HY2QKueZ65i2/jnsQtt+Zyd
	 CIg53o+4EExei14yx03bcFgUwx547wHOALk59t//WiP8Vu4Y4g6EObxXy/M2AZPw5y
	 jQyrHUMZ9p6rA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QmxtL6X7Rz2052;
	Thu, 22 Jun 2023 06:48:26 -0400 (EDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by lists.lttng.org (Postfix) with ESMTPS id 4QmxtK4rvnz2050
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 06:48:25 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id EF6D85C0126;
 Thu, 22 Jun 2023 06:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 22 Jun 2023 06:48:24 -0400
X-ME-Sender: <xms:-CaUZCwV6txmYxP10NM-7VZzfWupqNQG-mNhedQZGSVYkLzmUVi3Vw>
 <xme:-CaUZOSnNlPluRvGtrzjJhbWKci9TBxQX27xjh2P8pX_xKGSRv3_itEDO9URw2L97
 hYtikl9AyxLFb507dg>
X-ME-Received: <xmr:-CaUZEWsrP7lAnj4b08QEUTeCyrrYS-L7LXQnzM5WKDAODQ8gWsYu0354zrddg9Kta_hsAc_0_VcoSngYKOvRSiuzOZUXdOqwyIv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
 ekredtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhu
 rhihrdhorhhgqeenucggtffrrghtthgvrhhnpeelfffhkeehffdttdffudefudelgeettd
 dtvdetvdehuefhgefgjedvuddviedtffenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:-CaUZIjDynw95CVZrRCUdHNtk_Zzo4tvlVRj93RbH6IQe-Q9qArnJA>
 <xmx:-CaUZEA1pbs92TReBqri1dW5-2KznGQtM-EReCetmIyrYJSsemKxpw>
 <xmx:-CaUZJLIFWshxet0rM9Nzb3cJVxqoyKgN88_bVeIX-SXJcAZUubUrQ>
 <xmx:-CaUZPosh_xzi-lCIHfhL0fv6oSSXL2tjqKKzMM0ATrfxmnukXpHNw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 06:48:24 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Thu, 22 Jun 2023 12:45:32 +0200
Message-Id: <20230622104531.1132312-1-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622102626.569224-1-ondrej@sury.org>
References: <20230622102626.569224-1-ondrej@sury.org>
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

KFNvcnJ5LCBJIG1pc3NlZCBjbG9zaW5nIGJyYWNrZXRzIGluIGJvdGggbWFjcm9zLCBzbyByZXNl
bmRpbmcgZml4ZWQgcGF0Y2guLi4pCgpUaGUgY2RzX2xmaHRfZm9yX2VhY2hfZW50cnkgYW5kIGNk
c19sZmh0X2Zvcl9lYWNoX2VudHJ5X2R1cGxpY2F0ZSBtYWNyb3MKd291bGQgY2FsbCBjYWFfY29u
dGFpbmVyX29mKCkgbWFjcm8gb24gTlVMTCBwb2ludGVyLiAgVGhpcyBpcyBub3QgYQpwcm9ibGVt
IHVuZGVyIG5vcm1hbCBjaXJjdW1zdGFuY2VzIGFzIHRoZSBjaGVjayBpbiB0aGUgZm9yIGxvb3Ag
ZmFpbHMKYW5kIHRoZSBsb29wLXN0YXRlbWVudCBpcyBub3QgY2FsbGVkIHdpdGggaW52YWxpZCAo
cG9zKSB2YWx1ZS4KCkhvd2V2ZXIgQWRkcmVzc1Nhbml0aXplciBkb2Vzbid0IGxpa2UgdGhhdCBh
bmQgY29tcGxhaW5zIGFib3V0IHRoaXM6CgogICAgcnVudGltZSBlcnJvcjogYXBwbHlpbmcgbm9u
LXplcm8gb2Zmc2V0IDE4NDQ2NzQ0MDczNzA5NTUxMDU2IHRvIG51bGwgcG9pbnRlcgoKTW92ZSB0
aGUgY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMIGZyb20gdGhlIGNvbmQtZXhw
cmVzc2lvbgpvZiB0aGUgZm9yIGxvb3AgaW50byBib3RoIGluaXQtY2xhdXNlIGFuZCBpdGVyYXRp
b24tZXhwcmVzc2lvbiBhcwpjb25kaXRpb25hbCBvcGVyYXRvciBhbmQgY2hlY2sgZm9yIChwb3Mp
IHZhbHVlIGluIHRoZSBjb25kLWV4cHJlc3Npb24KaW5zdGVhZC4KClNpZ25lZC1vZmYtYnk6IE9u
ZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KLS0tCiBpbmNsdWRlL3VyY3UvcmN1bGZoYXNo
LmggfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdXJjdS9yY3VsZmhh
c2guaCBiL2luY2x1ZGUvdXJjdS9yY3VsZmhhc2guaAppbmRleCBmYmQzM2NjLi42NGNjMThmIDEw
MDY0NAotLS0gYS9pbmNsdWRlL3VyY3UvcmN1bGZoYXNoLmgKKysrIGIvaW5jbHVkZS91cmN1L3Jj
dWxmaGFzaC5oCkBAIC01NDYsMjIgKzU0NiwyMiBAQCB2b2lkIGNkc19sZmh0X3Jlc2l6ZShzdHJ1
Y3QgY2RzX2xmaHQgKmh0LCB1bnNpZ25lZCBsb25nIG5ld19zaXplKTsKIAogI2RlZmluZSBjZHNf
bGZodF9mb3JfZWFjaF9lbnRyeShodCwgaXRlciwgcG9zLCBtZW1iZXIpCQkJXAogCWZvciAoY2Rz
X2xmaHRfZmlyc3QoaHQsIGl0ZXIpLAkJCQkJXAotCQkJcG9zID0gY2FhX2NvbnRhaW5lcl9vZihj
ZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpLCBcCi0JCQkJCV9fdHlwZW9mX18oKihwb3MpKSwg
bWVtYmVyKTsJXAotCQljZHNfbGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpICE9IE5VTEw7CQkJXAor
CQkJcG9zID0gKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlcikgIT0gTlVMTCA/IGNhYV9jb250
YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAorCQkJCQlfX3R5cGVvZl9f
KCoocG9zKSksIG1lbWJlcikgOiBOVUxMKTsJXAorCQlwb3MgIT0gTlVMTDsJCQlcCiAJCWNkc19s
Zmh0X25leHQoaHQsIGl0ZXIpLAkJCQlcCi0JCQlwb3MgPSBjYWFfY29udGFpbmVyX29mKGNkc19s
Zmh0X2l0ZXJfZ2V0X25vZGUoaXRlciksIFwKLQkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1i
ZXIpKQorCQkJcG9zID0gKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlcikgIT0gTlVMTCA/IGNh
YV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAorCQkJCQlfX3R5
cGVvZl9fKCoocG9zKSksIG1lbWJlcikgOiBOVUxMKSkKIAogI2RlZmluZSBjZHNfbGZodF9mb3Jf
ZWFjaF9lbnRyeV9kdXBsaWNhdGUoaHQsIGhhc2gsIG1hdGNoLCBrZXksCQlcCiAJCQkJaXRlciwg
cG9zLCBtZW1iZXIpCQkJXAogCWZvciAoY2RzX2xmaHRfbG9va3VwKGh0LCBoYXNoLCBtYXRjaCwg
a2V5LCBpdGVyKSwJCVwKLQkJCXBvcyA9IGNhYV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9n
ZXRfbm9kZShpdGVyKSwgXAotCQkJCQlfX3R5cGVvZl9fKCoocG9zKSksIG1lbWJlcik7CVwKLQkJ
Y2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSAhPSBOVUxMOwkJCVwKKwkJCXBvcyA9IChjZHNf
bGZodF9pdGVyX2dldF9ub2RlKGl0ZXIpICE9IE5VTEwgPyBjYWFfY29udGFpbmVyX29mKGNkc19s
Zmh0X2l0ZXJfZ2V0X25vZGUoaXRlciksIFwKKwkJCQkJX190eXBlb2ZfXygqKHBvcykpLCBtZW1i
ZXIpIDogTlVMTCk7CVwKKwkJcG9zICE9IE5VTEw7CQkJXAogCQljZHNfbGZodF9uZXh0X2R1cGxp
Y2F0ZShodCwgbWF0Y2gsIGtleSwgaXRlciksCQlcCi0JCQlwb3MgPSBjYWFfY29udGFpbmVyX29m
KGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlciksIFwKLQkJCQkJX190eXBlb2ZfXygqKHBvcykp
LCBtZW1iZXIpKQorCQkJcG9zID0gKGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUoaXRlcikgIT0gTlVM
TCA/IGNhYV9jb250YWluZXJfb2YoY2RzX2xmaHRfaXRlcl9nZXRfbm9kZShpdGVyKSwgXAorCQkJ
CQlfX3R5cGVvZl9fKCoocG9zKSksIG1lbWJlcikgOiBOVUxMKSkKIAogI2lmZGVmIF9fY3BsdXNw
bHVzCiB9Ci0tIAoyLjM5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
