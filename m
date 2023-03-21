Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A5C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679405494;
	bh=LlJ+bpCkToLLXame/axoGpKnmaJE2W7nctkPUUdk7IU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=COXhx0zOt+QuAjfOK0fzPMXQpx08SAzAuEEJLnO5lUcgm1/0Z10SNhxt682f+SBi+
	 AGGmjNn5objL+xs/CdS4qsNA1TsRPT1amwvOCe+t6Z8+5P+ZkP6W2AvgDkIu5Ki/wD
	 +wYjlQKsgw4rsw3tTyoGgQ+ik17v91CepKG5D7xgjeH/1YbZ5NrPPUSG3gQNiyI0tS
	 k+UK1H2TSCgw7hAtYqizYX8GwWI07gXHDM7OAzlf1cSAp8zLgmThp/4iAXh1bwBuyG
	 Dy/KaW/qp5luvbMFoJozmyomsYV77Z9fADmn2VRmIzmuAIAKk9/PQjRFamjMcNB9Nk
	 Dpz1D36Fj1YBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgsvV2F7wz2H4w;
	Tue, 21 Mar 2023 09:31:34 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgsvR3XHtz2HGs
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:31 -0400 (EDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 80C533200933;
 Tue, 21 Mar 2023 09:31:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 21 Mar 2023 09:31:24 -0400
X-ME-Sender: <xms:q7EZZJpgN1btRrBu4zfmS0w0598gaMUxyOhJJTnkQXdTeo4GFYAIeQ>
 <xme:q7EZZLqZTFid50Pb9fWMWv4DEYeVkgWAqsyYBpIg7Xt6MTJ49VMju74Ex2I_M7fW7
 PXOHj0EuLBXitBNJaQ>
X-ME-Received: <xmr:q7EZZGPokmUkpd_UWZqBplHHudqT7lsBhH0EnK_2Rj9U2zEidurTiLcTAiPWUAnKLoDpQ10g8-h5A6MOMzLqiZIJzusuy6v84fOO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
 ekredtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhu
 rhihrdhorhhgqeenucggtffrrghtthgvrhhnpeelfffhkeehffdttdffudefudelgeettd
 dtvdetvdehuefhgefgjedvuddviedtffenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:rLEZZE5QfZauGbviYftWlMVkDTF5NBbD9i5WltYifEzqWwZOBbajYw>
 <xmx:rLEZZI4JrZGsrQtXC6mpaf78r7LXgY9MTjoQzvooPJjOKjXEY8x6IA>
 <xmx:rLEZZMhBEfGVmjEVbsHtNR0TdY9lcJf8KhVQg1ZK7Q6Nh4ByOn8FDw>
 <xmx:rLEZZNiO4ZEygbM4ng3Xd190sGOfQjk-gP04buwpDtyyKHhsnkCWQw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 09:31:23 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 21 Mar 2023 14:30:58 +0100
Message-Id: <20230321133102.1054238-4-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321133102.1054238-1-ondrej@sury.org>
References: <20230321133102.1054238-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 3/7] Use __atomic_signal_fence() for
 cmm_barrier()
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

VXNlIF9fYXRvbWljX3NpZ25hbF9mZW5jZShfX0FUT01JQ19TRVFfQ1NUKSBmb3IgY21tX2JhcnJp
ZXIoKSwgc28KVGhyZWFkU2FuaXRpemVyIGNhbiB1bmRlcnN0YW5kIHRoZSBtZW1vcnkgc3luY2hy
b25pemF0aW9uLgoKU2lnbmVkLW9mZi1ieTogT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3Jn
PgotLS0KIGluY2x1ZGUvdXJjdS9jb21waWxlci5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91cmN1L2Nv
bXBpbGVyLmggYi9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAppbmRleCAyZjMyYjM4Li41NzYzMzc4
IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VyY3UvY29tcGlsZXIuaAorKysgYi9pbmNsdWRlL3VyY3Uv
Y29tcGlsZXIuaApAQCAtMjgsNyArMjgsNyBAQAogI2RlZmluZSBjYWFfbGlrZWx5KHgpCV9fYnVp
bHRpbl9leHBlY3QoISEoeCksIDEpCiAjZGVmaW5lIGNhYV91bmxpa2VseSh4KQlfX2J1aWx0aW5f
ZXhwZWN0KCEhKHgpLCAwKQogCi0jZGVmaW5lCWNtbV9iYXJyaWVyKCkJX19hc21fXyBfX3ZvbGF0
aWxlX18gKCIiIDogOiA6ICJtZW1vcnkiKQorI2RlZmluZQljbW1fYmFycmllcigpCV9fYXRvbWlj
X3NpZ25hbF9mZW5jZShfX0FUT01JQ19TRVFfQ1NUKQogCiAvKgogICogSW5zdHJ1Y3QgdGhlIGNv
bXBpbGVyIHRvIHBlcmZvcm0gb25seSBhIHNpbmdsZSBhY2Nlc3MgdG8gYSB2YXJpYWJsZQotLSAK
Mi4zOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
