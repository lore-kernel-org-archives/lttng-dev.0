Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EECC74A5B
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 21:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679089101;
	bh=7IfWwXCHel9kqs9xActTxMJkqwk+hezxyrWvFfw0/WA=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=v9H4FZ2pAfkQ9BKpLBURXFlpZ67zabWmpid7RrKvYVYYNf7eNuOho6izsaev9aYG0
	 N7Hjjia/0Pgybj5dvP8WTdZT2lDmBC89BnQDTAYYbb37SQZfbOUGqVj9r6W0OPowB7
	 nqbfkwsY5+HrXc8zaG3ZAbwVJq1cfG0HnMN846SF2I4fvUMQcmOof/d18jgPYo+y+g
	 RR5z8PijTHHSjae4cU4sxZj8sOQoqZxj8SLsQBJ213b1U1R81EVE1nx4+STqd+F1UM
	 fT+TzmCZ4SGQVxCL3DnJUSR7zrKgC1jAwJaKsjDts5iE6rXogU/Itd55vEonx5XUt9
	 J7QA8puyj8+xw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pdcv13tlRz2CbY;
	Fri, 17 Mar 2023 17:38:21 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pdctz0sKMz2Cks
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:19 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 1DFA93200931;
 Fri, 17 Mar 2023 17:38:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 17 Mar 2023 17:38:18 -0400
X-ME-Sender: <xms:yd0UZO_OTUlKpie6kNKL6cplSeq6F3eU3IBTiyyQ0zHLmFo8wA73aQ>
 <xme:yd0UZOvxVWzdNONbcexVHNvUHKtdg86565LPnkZxpUKCmcspiN0f3-oN7ZGmP8jCw
 2IGIwCp68qXqMZb9pI>
X-ME-Received: <xmr:yd0UZEB79R3g-GwE5TZAV_MojcqXHGVOA4hBGCS-5KmRyrFbFlSskTJK2aimcACq4asGlA8mZgTslmAsneKyA1kJ7cbRs5lUzRWn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudehtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
 htkeertdertdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehs
 uhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepleffhfekhefftddtffdufeduleegte
 dttddvtedvheeuhfeggfejvdduvdeitdffnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:yd0UZGdmJLLXdzrA_1UP98byRrVZ8OemlfdkFMOMOHp_93TwhZ8LLQ>
 <xmx:yd0UZDPot4JNZht7_E9tQhykLlVqjz2r721Bn5b1JcIwQesrfh_ICA>
 <xmx:yd0UZAlM1qyz_bpeYsvanYHZ8-AwX0_bDBMI6mE6-JHOy2eZt31Bbg>
 <xmx:yd0UZFXAvgyRx3y6llGkevmOSA68v_HlxC1lLtILA-LvzSZ2qf-zag>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 17:38:16 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 17 Mar 2023 22:37:53 +0100
Message-Id: <20230317213755.455957-6-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213755.455957-1-ondrej@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 5/7] Use __atomic builtins to implement
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
L3N5c3RlbS5oIHwgNyArKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdXJjdS9zeXN0ZW0uaCBiL2luY2x1
ZGUvdXJjdS9zeXN0ZW0uaAppbmRleCBmYWFlMzkwLi45OWU3NDQzIDEwMDY0NAotLS0gYS9pbmNs
dWRlL3VyY3Uvc3lzdGVtLmgKKysrIGIvaW5jbHVkZS91cmN1L3N5c3RlbS5oCkBAIC0yNiw3ICsy
Niw3IEBACiAgKiBJZGVudGlmeSBhIHNoYXJlZCBsb2FkLiBBIGNtbV9zbXBfcm1jKCkgb3IgY21t
X3NtcF9tYygpIHNob3VsZCBjb21lCiAgKiBiZWZvcmUgdGhlIGxvYWQuCiAgKi8KLSNkZWZpbmUg
X0NNTV9MT0FEX1NIQVJFRChwKQkgICAgICAgQ01NX0FDQ0VTU19PTkNFKHApCisjZGVmaW5lIF9D
TU1fTE9BRF9TSEFSRUQocCkJICAgICAgIF9fYXRvbWljX2xvYWRfbigmKHApLCBfX0FUT01JQ19S
RUxBWEVEKQogCiAvKgogICogTG9hZCBhIGRhdGEgZnJvbSBzaGFyZWQgbWVtb3J5LCBkb2luZyBh
IGNhY2hlIGZsdXNoIGlmIHJlcXVpcmVkLgpAQCAtNDIsNyArNDIsNyBAQAogICogSWRlbnRpZnkg
YSBzaGFyZWQgc3RvcmUuIEEgY21tX3NtcF93bWMoKSBvciBjbW1fc21wX21jKCkgc2hvdWxkCiAg
KiBmb2xsb3cgdGhlIHN0b3JlLgogICovCi0jZGVmaW5lIF9DTU1fU1RPUkVfU0hBUkVEKHgsIHYp
CV9fZXh0ZW5zaW9uX18gKHsgQ01NX0FDQ0VTU19PTkNFKHgpID0gKHYpOyB9KQorI2RlZmluZSBf
Q01NX1NUT1JFX1NIQVJFRCh4LCB2KQlfX2F0b21pY19zdG9yZV9uKCYoeCksICh2KSwgX19BVE9N
SUNfUkVMQVhFRCkKIAogLyoKICAqIFN0b3JlIHYgaW50byB4LCB3aGVyZSB4IGlzIGxvY2F0ZWQg
aW4gc2hhcmVkIG1lbW9yeS4gUGVyZm9ybXMgdGhlCkBAIC01MSw5ICs1MSw4IEBACiAjZGVmaW5l
IENNTV9TVE9SRV9TSEFSRUQoeCwgdikJCQkJCQlcCiAJX19leHRlbnNpb25fXwkJCQkJCQlcCiAJ
KHsJCQkJCQkJCVwKLQkJX190eXBlb2ZfXyh4KSBfdiA9IF9DTU1fU1RPUkVfU0hBUkVEKHgsIHYp
OwkJXAorCQlfQ01NX1NUT1JFX1NIQVJFRCh4LCB2KTsJCQkJXAogCQljbW1fc21wX3dtYygpOwkJ
CQkJCVwKLQkJX3YgPSBfdjsJLyogV29yayBhcm91bmQgY2xhbmcgInVudXNlZCByZXN1bHQiICov
CVwKIAl9KQogCiAjZW5kaWYgLyogX1VSQ1VfU1lTVEVNX0ggKi8KLS0gCjIuMzkuMgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
