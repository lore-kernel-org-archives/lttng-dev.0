Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01932C74A5B
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679089103;
	bh=iByOoRx2wTyX852LSJVvDjCAA27aLW/tfMz6RZfhKtU=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RA6xo/usZRAgNMoojp2U0Q5/+wSTOblIQDYidOH+vTe648VlIzIiiJ12tXPz5KHlr
	 IwN3ozaF+ubebx1v3ppO9v5FdiB7TwZqSVlqjlWv+1NZRiOFxOgYTyr65bA2UZYp8f
	 H28KNny/pcHwQV6Zrn54Md8JffZJCq7zp181186Vaw0z/c87j5+GAUtMCOrHOfSele
	 0r3IJGvOepjos5NhMdzfppuLrp7+ZaQ8SmIV6DVmEa8lwRuvnrAQAMoQ2sUeaCLJ04
	 vqS+CDzn6PqVj5k3jkY2mxBqiTLF52WTYM5rDAOSUGmCifwRPZ/7xYVMpW+cyekEdH
	 ZU19RydNZ9Tag==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pdcv33Fhyz2Cbj;
	Fri, 17 Mar 2023 17:38:23 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pdcv21jDpz2CnY
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:38:22 -0400 (EDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 50DDF3200912;
 Fri, 17 Mar 2023 17:38:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 17 Mar 2023 17:38:21 -0400
X-ME-Sender: <xms:zN0UZD2hDvmj2KsHm4gd4FgfG9uGadl4kwM8f-3f71EsP9-HGsC9Xg>
 <xme:zN0UZCGRSQKPcbMT2_eoWsQP9AKdoj8ItuxnkFEYRXwkrjbHxI822dvLPv-k2qV78
 SCnTaKqwdZMZfCvQG8>
X-ME-Received: <xmr:zN0UZD7JgnEWQm_9b5P6EfLxdOT6XAWhjaxQJS61ulStGooaaG94S6V9pmIQ-aWIOGR3OfX7jMySfcX329cRsSfSahgDpusO7GbG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
 htkeertdertdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehs
 uhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepleffhfekhefftddtffdufeduleegte
 dttddvtedvheeuhfeggfejvdduvdeitdffnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:zN0UZI3PiGM8xEBTv4f4JW5QhpJIxsDPYHHYMlxKDA2v5hp0zG0ymw>
 <xmx:zN0UZGHR-CPJRzET7luX4ZNxGVrIJQVLWeLLbVWqFSwmgAowSnb1VA>
 <xmx:zN0UZJ_oYIH9xm1N2I8TC_TDqb0dNZecn3Q2ZNmB-Zml2YkElbN4VA>
 <xmx:zN0UZBOQHJ1MkkrUSxIszhWN9n7s6rCq0Kb8aqycomyHVAjWkpKnCw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 17:38:20 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Fri, 17 Mar 2023 22:37:55 +0100
Message-Id: <20230317213755.455957-8-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213755.455957-1-ondrej@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier in
 free_completion()
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

RklYTUU6IFRoaXMgaXMgZXhwZXJpbWVudCB0aGF0IGFkZHMgZXhwbGljaXQgbWVtb3J5IGJhcnJp
ZXIgaW4gdGhlCmZyZWVfY29tcGxldGlvbiBpbiB0aGUgd29ya3F1ZXVlLmMsIHNvIFRocmVhZFNh
bml0aXplciBrbm93cyBpdCdzIG9rIHRvCmZyZWUgdGhlIHJlc291cmNlcy4KClNpZ25lZC1vZmYt
Ynk6IE9uZMWZZWogU3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4KLS0tCiBzcmMvd29ya3F1ZXVlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy93
b3JrcXVldWUuYyBiL3NyYy93b3JrcXVldWUuYwppbmRleCAxMDM5ZDcyLi5mMjE5MDdmIDEwMDY0
NAotLS0gYS9zcmMvd29ya3F1ZXVlLmMKKysrIGIvc3JjL3dvcmtxdWV1ZS5jCkBAIC0zNzcsNiAr
Mzc3LDcgQEAgdm9pZCBmcmVlX2NvbXBsZXRpb24oc3RydWN0IHVyY3VfcmVmICpyZWYpCiAJc3Ry
dWN0IHVyY3Vfd29ya3F1ZXVlX2NvbXBsZXRpb24gKmNvbXBsZXRpb247CiAKIAljb21wbGV0aW9u
ID0gY2FhX2NvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCB1cmN1X3dvcmtxdWV1ZV9jb21wbGV0aW9u
LCByZWYpOworCWFzc2VydCghdXJjdV9yZWZfZ2V0X3VubGVzc196ZXJvKCZjb21wbGV0aW9uLT5y
ZWYpKTsKIAlmcmVlKGNvbXBsZXRpb24pOwogfQogCi0tIAoyLjM5LjIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
