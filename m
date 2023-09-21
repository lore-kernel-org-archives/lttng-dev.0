Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B7E7D0A4
	for <lttng-dev@archiver.kernel.org>; Thu, 21 Sep 2023 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1695321306;
	bh=jhGqSNneZWrmyr5sH14fSlmcNCXZfFLgrR6enR2gRpQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QGxIfphGX9E4W+ZchRDn6iwif9fbGIxmkVrOfloryh5ZVZLV0iTB2OzEAw2yRUqe9
	 tgxzTqE2c+GXALcClWB9YmyZZNkneGP06bp1jl+gETCNnzQItL1DNJ+9icbD1r56P+
	 b82Ng9XljV8By73KduszD5YcVK6dmZj/9sUpkVvFlKjBcJEbpJ1jrgcl777uMVvNbm
	 xmSY2g8/G/g3ZJbiDfVDjftoLYOHNHCEjmMC0Gv2LaNkcwDPzpK886UG1EzeL8TEY6
	 7HRPVqZLJIpj1lwY6PudFRK96CI8ZySTGfCW06b/GwsvfoLIUg1bNAwajChNNFO7eO
	 /bxblMOsjPROQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Rs3wn5mc7z2bMB;
	Thu, 21 Sep 2023 14:35:05 -0400 (EDT)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rs3wm2cFzz2Zr2
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2023 14:35:04 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 1EF6132003AC
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2023 14:35:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Sep 2023 14:35:02 -0400
X-ME-Sender: <xms:1YwMZaYkLEFsKEm4yh_O6IUkqZh06e5_2CjsMT_MzZzC5HrY2UzM-g>
 <xme:1YwMZdbatm0FmAV4sHAK7IyX5j3USfmsFk1IPDc34eRnVfbF_VSxnZ6qvqUidELFo
 F-Gs7oWrWMyck5zcAk>
X-ME-Received: <xmr:1YwMZU_JH0il2YaRyrxjwEzaLwajTgZgNsS0iVcukahfXKaIjExCzW1npGRvdlc9Ij2Lml75THQwEKoQQkpsVgoU6q6fm-Qx4Ox7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmh
 dthhdtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhurhih
 rdhorhhgqeenucggtffrrghtthgvrhhnpeekieekgffhhedvteelfeefleeiiefhtdfhtd
 euleffffdtveeujeetuedvkeevjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:1YwMZcocHaBlKgINkjJNPNi0cyNArSaCeDSoNBbdY7lEjJC-788rpA>
 <xmx:1YwMZVqCvkb6FKwUwsptDIpgbXHLI2NNHOesi1S-BtJhZpjHV9G4_A>
 <xmx:1YwMZaT4GAC0HmwsqOoQuWphr6Mue1QPDKujjRV_1luXF14XfbXvQQ>
 <xmx:1YwMZXFSL7FMq-PnBvW6f0pPaL6l6Ce2nABdRRMyQXmYE6CDNUAf1A>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2023 14:35:00 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Message-Id: <FA4E40F7-C16C-4872-9829-0643AA974B30@sury.org>
Date: Thu, 21 Sep 2023 20:34:48 +0200
To: lttng-dev <lttng-dev@lists.lttng.org>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
Subject: [lttng-dev] TSAN build broken on master branch
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

SGksCgpJJ3ZlIHVwZGF0ZWQgdG8gdGhlIGxhdGVzdCBIRUFEIGFuZCBjb21waWxhdGlvbiB3aXRo
IGNsYW5nLTE2IGFuZCBjbGFuZy0xNyBhbmQKCi4vY29uZmlndXJlIC0tZW5hYmxlLWNvbXBpbGVy
LWF0b21pYy1idWlsdGlucyAtLWRpc2FibGUtbGVnYWN5LW1iCgpJdCBmYWlscyB3aXRoOgoKcmN1
bGZoYXNoLmM6MTE4OToyOiBlcnJvcjogYWRkcmVzcyBhcmd1bWVudCB0byBhdG9taWMgb3BlcmF0
aW9uIG11c3QgYmUgYSBwb2ludGVyIHRvIGludGVnZXIgKCd0eXBlb2YgKG5vZGVfbmV4dCknIChh
a2EgJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJykgaW52YWxpZCkKICAgICAgICB1YXRvbWljX29y
X21vKG5vZGVfbmV4dCwgUkVNT1ZFRF9GTEFHLCBDTU1fUkVMRUFTRSk7CiAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci4uL2luY2x1ZGUv
dXJjdS91YXRvbWljL2J1aWx0aW5zLWdlbmVyaWMuaDoxMjM6MTA6IG5vdGU6IGV4cGFuZGVkIGZy
b20gbWFjcm8gJ3VhdG9taWNfb3JfbW8nCiAgICAgICAgICAgICAgICAodm9pZCkgX19hdG9taWNf
b3JfZmV0Y2goY21tX2Nhc3Rfdm9sYXRpbGUoYWRkciksIG1hc2ssIFwKICAgICAgICAgICAgICAg
ICAgICAgICBeICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpyY3VsZmhh
c2guYzoxNDQwOjM6IGVycm9yOiBhZGRyZXNzIGFyZ3VtZW50IHRvIGF0b21pYyBvcGVyYXRpb24g
bXVzdCBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3R5cGVvZiAoZmluaV9idWNrZXRfbmV4dCkn
IChha2EgJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoqJykgaW52YWxpZCkKICAgICAgICAgICAgICAg
IHVhdG9taWNfb3IoZmluaV9idWNrZXRfbmV4dCwgUkVNT1ZFRF9GTEFHKTsKICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgouLi9pbmNsdWRl
L3VyY3UvdWF0b21pYy9idWlsdGlucy1nZW5lcmljLmg6MTMwOjI6IG5vdGU6IGV4cGFuZGVkIGZy
b20gbWFjcm8gJ3VhdG9taWNfb3InCiAgICAgICAgdWF0b21pY19vcl9tbyhhZGRyLCBtYXNrLCBD
TU1fUkVMQVhFRCkKICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgouLi9pbmNsdWRlL3VyY3UvdWF0b21pYy9idWlsdGlucy1nZW5lcmljLmg6MTIzOjEwOiBub3Rl
OiBleHBhbmRlZCBmcm9tIG1hY3JvICd1YXRvbWljX29yX21vJwogICAgICAgICAgICAgICAgKHZv
aWQpIF9fYXRvbWljX29yX2ZldGNoKGNtbV9jYXN0X3ZvbGF0aWxlKGFkZHIpLCBtYXNrLCBcCiAg
ICAgICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4KMiBlcnJvcnMgZ2VuZXJhdGVkLgoKSXQgd29ya3Mgd2l0aCBnY2MtMTIsIHNvIGl0IHNl
ZW1zIHRoYXQgY2xhbmcgaGFzIHN0cmljdGVyIHJ1bGVzIGhlcmUuCgpPbmTFmWVqCi0tCk9uZMWZ
ZWogU3Vyw70gKEhlL0hpbSkKb25kcmVqQHN1cnkub3JnCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
