Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3895FC76195
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679405492;
	bh=lxvag8wpMrjueb+9lx0NpwQvvd0oLAnzHLaCp57ZaWQ=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TTCXsnKL8T+g5mZppwwpB3pO3nk/qAG28RLm2yvpvqhzTvrn1Am+5E+OdpxYLultE
	 kdISS9PlV0+qG2B8aJWMuakC1F7dJMnyxroFquIyPET6KWdPQhuKbHUup8aFwOlcEK
	 52W00HmW0vTBnBiUYfERJWbPo72xCT99cSJmBHUm+Abpusy+y0FJ2f5RsN+CLo0GQ5
	 EZLArXVZ28QqFrtLz2NTLTGjAUj31epaDZF0TXXsy0ir3xpOjpzfZWXZo0s65DZuf2
	 6zcssBzdI7Hu3lEEemYSd2o2xWmF6G/nMWsdZR6lBzVt/5b+jo+M2k52d2gZkZ8tk2
	 T8LG00XHTNlBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgsvS6SGkz2GwL;
	Tue, 21 Mar 2023 09:31:32 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgsvQ3mpKz2H9d
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:30 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 77963320085B;
 Tue, 21 Mar 2023 09:31:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 21 Mar 2023 09:31:29 -0400
X-ME-Sender: <xms:sbEZZL8zQcOboMHOPTImqaAkUi5bzauG4z0ftTKOHP87CvuxHC_hGw>
 <xme:sbEZZHu-SlV2Am9dSyMgUL_7nd0ZhLOu2zyRux6_sxIJN9l0u2ptKo_2yXFR2ihsl
 tKqU6U92ORza8qSpx8>
X-ME-Received: <xmr:sbEZZJD0ubKilV1mQL6O-KvLHedxLI_7CbGKBaxtCDka_4P3ytAtbxvwVOEBk5WmtjfujXEAeIQ6BLFTnRMyT1ZgjzP1RBJjO7Zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
 ekredtredtjeenucfhrhhomhepqfhnughrvghjucfuuhhrupcuoehonhgurhgvjhesshhu
 rhihrdhorhhgqeenucggtffrrghtthgvrhhnpeelfffhkeehffdttdffudefudelgeettd
 dtvdetvdehuefhgefgjedvuddviedtffenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjhesshhurhihrdhorhhg
X-ME-Proxy: <xmx:sbEZZHfticRr5S_Ui74DZT1WvC6QbeCIbc7upmjvh-fKBgT4kA-4cQ>
 <xmx:sbEZZAPKCvLx11GGhzmyPTxL7e86Mchj9wBrfngXvIHbkqQdjkYzcg>
 <xmx:sbEZZJlRwRV71yXRY1ShuaGfCwdhGaLIqsd31V-j3rev4MJBk1M4Fg>
 <xmx:sbEZZKUT-3laPW17RJTU6p1y0-eeZdfv1FzZWG35D_BrB7XCKCrdBA>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 09:31:28 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 21 Mar 2023 14:31:01 +0100
Message-Id: <20230321133102.1054238-7-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321133102.1054238-1-ondrej@sury.org>
References: <20230321133102.1054238-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 6/7] Use __atomic builtins to implement
 CMM_{LOAD, STORE}_SHARED
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

SW5zdGVhZCBvZiB1c2luZyBDTU1fQUNDRVNTX09OQ0UoKSB3aXRoIG1lbW9yeSBiYXJyaWVycywg
dXNlIF9fYXRvbWljCmJ1aWx0aW5zIHdpdGggcmVsYXhlZCBtZW1vcnkgb3JkZXJpbmcgdG8gaW1w
bGVtZW50IENNTV9MT0FEX1NIQVJFRCgpIGFuZApDTU1fU1RPUkVfU0hBUkVEKCkuCgpTaWduZWQt
b2ZmLWJ5OiBPbmTFmWVqIFN1csO9IDxvbmRyZWpAc3VyeS5vcmc+Ci0tLQogaW5jbHVkZS91cmN1
L3N5c3RlbS5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdXJjdS9zeXN0ZW0uaCBiL2luY2x1ZGUv
dXJjdS9zeXN0ZW0uaAppbmRleCBmYWFlMzkwLi40MzAyMjUzIDEwMDY0NAotLS0gYS9pbmNsdWRl
L3VyY3Uvc3lzdGVtLmgKKysrIGIvaW5jbHVkZS91cmN1L3N5c3RlbS5oCkBAIC0yNiw3ICsyNiw3
IEBACiAgKiBJZGVudGlmeSBhIHNoYXJlZCBsb2FkLiBBIGNtbV9zbXBfcm1jKCkgb3IgY21tX3Nt
cF9tYygpIHNob3VsZCBjb21lCiAgKiBiZWZvcmUgdGhlIGxvYWQuCiAgKi8KLSNkZWZpbmUgX0NN
TV9MT0FEX1NIQVJFRChwKQkgICAgICAgQ01NX0FDQ0VTU19PTkNFKHApCisjZGVmaW5lIF9DTU1f
TE9BRF9TSEFSRUQocCkJICAgICAgIF9fYXRvbWljX2xvYWRfbigmKHApLCBfX0FUT01JQ19SRUxB
WEVEKQogCiAvKgogICogTG9hZCBhIGRhdGEgZnJvbSBzaGFyZWQgbWVtb3J5LCBkb2luZyBhIGNh
Y2hlIGZsdXNoIGlmIHJlcXVpcmVkLgpAQCAtNDIsNyArNDIsNyBAQAogICogSWRlbnRpZnkgYSBz
aGFyZWQgc3RvcmUuIEEgY21tX3NtcF93bWMoKSBvciBjbW1fc21wX21jKCkgc2hvdWxkCiAgKiBm
b2xsb3cgdGhlIHN0b3JlLgogICovCi0jZGVmaW5lIF9DTU1fU1RPUkVfU0hBUkVEKHgsIHYpCV9f
ZXh0ZW5zaW9uX18gKHsgQ01NX0FDQ0VTU19PTkNFKHgpID0gKHYpOyB9KQorI2RlZmluZSBfQ01N
X1NUT1JFX1NIQVJFRCh4LCB2KQlfX2V4dGVuc2lvbl9fICh7IF9fYXRvbWljX3N0b3JlX24oJih4
KSwgdiwgX19BVE9NSUNfUkVMQVhFRCk7IHY7IH0pCiAKIC8qCiAgKiBTdG9yZSB2IGludG8geCwg
d2hlcmUgeCBpcyBsb2NhdGVkIGluIHNoYXJlZCBtZW1vcnkuIFBlcmZvcm1zIHRoZQotLSAKMi4z
OS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
