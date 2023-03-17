Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010B2C6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 21:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679089100;
	bh=s35pxYGbfi7kWMHN9mQY2nesbv/2a+kE5s6rtlkfORs=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EPJIP64L9/yjdsYceqR8Q6ppb+zPPk8X3uETtRN8JbvntfQMDURjl3LjNi1dLspCt
	 MYmgW3Stz6W4ebhGSBjZodIHySRocPQBYZ9JRdY7wZkU81uKO1zN69OYHt0wWRfup/
	 QGWUj4CQLr41ic+fyE/bxyHSy2WGxVkRtslcNUsAG//VYgwxqVqod8ylz7s1vzocIR
	 rtSnxvxVGOklyxR1ovNQqQffjz8OGew9Da3KS/iiWu9E6UCPO3RCPQT+oS9/mkym6n
	 9Gcy64aUq4qmMKJfUoLwmubkA7WYQbVwcgP/2jqWftqetwqy2meWMOLOjsY7aQuLPv
	 OWrQX86y8f4iw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pdcv045RFz2D1J;
	Fri, 17 Mar 2023 17:38:20 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pdctv6lkKz2Cpm
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:15 -0400 (EDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id E84CD320031A;
 Fri, 17 Mar 2023 17:38:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 17 Mar 2023 17:38:15 -0400
X-ME-Sender: <xms:xt0UZOTEaDKVFxvtbyx9tBjdQgHqzu7irIZV9JfXoKlEG4YjuNolCA>
 <xme:xt0UZDzJphnFhSVUU6phFYw2QVWLEE5d135nLbH8F1bededI45KCSoQMgYbyVvefX
 M4CpKtZ4vbTKj0MsGg>
X-ME-Received: <xmr:xt0UZL3uf0fU_j-HqX90zWnSz_yZeYXhYhCf0RPJisXc1wcL9pEIjLbMjpMwZb1-YiXLQnguMjvTKDDggpJBiKcO5timfsmCPn7C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
 htkeertdertdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehs
 uhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepleffhfekhefftddtffdufeduleegte
 dttddvtedvheeuhfeggfejvdduvdeitdffnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:xt0UZKDgFaOhS8bN2ELrRullkwkWvx1PuJWSRaANO_gizcyraRtlPA>
 <xmx:xt0UZHgo5Cdxq0TMa7yVlgWw1QCOuClueybqNYetcZXdE9YXbw8C8g>
 <xmx:xt0UZGqnB9iV7FXRg_ZcquLHPHqYh-78LeonmIszAjXyRs0jcYS3Ug>
 <xmx:xt0UZHJGY7l1mqPTCzhaoUH2UWxLIs2pATM5LUjXY-vZlIUbzfRZbQ>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 17:38:13 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 17 Mar 2023 22:37:51 +0100
Message-Id: <20230317213755.455957-4-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213755.455957-1-ondrej@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 3/7] Use __atomic_thread_fence() for
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

VXNlIF9fYXRvbWljX3RocmVhZF9mZW5jZShfX0FUT01JQ19BQ1FfUkVMKSBmb3IgY21tX2JhcnJp
ZXIoKSwgc28KVGhyZWFkU2FuaXRpemVyIGNhbiB1bmRlcnN0YW5kIHRoZSBtZW1vcnkgc3luY2hy
b25pemF0aW9uLgoKRklYTUU6IFdoYXQgc2hvdWxkIGJlIHRoZSBjb3JyZWN0IG1lbW9yeSBvcmRl
cmluZyBoZXJlPwoKU2lnbmVkLW9mZi1ieTogT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3Jn
PgotLS0KIGluY2x1ZGUvdXJjdS9jb21waWxlci5oIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VyY3Uv
Y29tcGlsZXIuaCBiL2luY2x1ZGUvdXJjdS9jb21waWxlci5oCmluZGV4IDJmMzJiMzguLmVkZTkw
OWYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdXJjdS9jb21waWxlci5oCisrKyBiL2luY2x1ZGUvdXJj
dS9jb21waWxlci5oCkBAIC0yOCw3ICsyOCw4IEBACiAjZGVmaW5lIGNhYV9saWtlbHkoeCkJX19i
dWlsdGluX2V4cGVjdCghISh4KSwgMSkKICNkZWZpbmUgY2FhX3VubGlrZWx5KHgpCV9fYnVpbHRp
bl9leHBlY3QoISEoeCksIDApCiAKLSNkZWZpbmUJY21tX2JhcnJpZXIoKQlfX2FzbV9fIF9fdm9s
YXRpbGVfXyAoIiIgOiA6IDogIm1lbW9yeSIpCisvKiBGSVhNRTogV2hhdCB3b3VsZCBiZSBhIGNv
cnJlY3QgbWVtb3J5IG9yZGVyaW5nIGhlcmU/ICovCisjZGVmaW5lCWNtbV9iYXJyaWVyKCkJX19h
dG9taWNfc2lnbmFsX2ZlbmNlKF9fQVRPTUlDX0FDUV9SRUwpCiAKIC8qCiAgKiBJbnN0cnVjdCB0
aGUgY29tcGlsZXIgdG8gcGVyZm9ybSBvbmx5IGEgc2luZ2xlIGFjY2VzcyB0byBhIHZhcmlhYmxl
Ci0tIAoyLjM5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
