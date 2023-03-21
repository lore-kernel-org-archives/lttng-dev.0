Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF86C6FD1D
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679410109;
	bh=yRL6nxja4OQQOx/cm+69WI6Vx2+Ypn6pwOZMwoHBlbo=;
	h=In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zg9k7wjrG80r6atswdJlI1voY6smhHBzjbAPDew/gusVBCGbtxa5xOjkbhJ0GGsvm
	 y+sMG5tEShaer357wOmN42qJ2e2ELGLb9dzXClsJVr4rdNFNkFjBzO81/2FwM3/J5b
	 hGU807zxRqyN+8iOpJySjRuCTY5T3QPpF8IxPibbFHcCDCqh8gO6Hcblti3dgWOd9o
	 uv/VuwBBt1PtpirFy9pOBYXTL1mL9oCB5uS1xTDwcULFlYWtZexnjrp6HzUHuSu3TI
	 DAYSbb2aaTM4aXQDJ4bc7Vfg1gw4ja1smIJ8HoQB1hvfqP6FvtQauP8D5xR3dcWwVk
	 62i0/TQqauJYA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgvcF43KNz2HHF;
	Tue, 21 Mar 2023 10:48:29 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgvcC4vWjz2HHC
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:48:27 -0400 (EDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id C34E53200CA2;
 Tue, 21 Mar 2023 10:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 21 Mar 2023 10:48:25 -0400
X-ME-Sender: <xms:uMMZZAAtv8qgQHYSCeizn9d5IN4QPDNBIiys7o6LexPpOeNC5I5vww>
 <xme:uMMZZChFytnPEl23oIQUe172GftMnzMO0-hJfmXgcF0am-PgAHwo7JnchoIi3nHpY
 7Rwc2_dzuFACjcTUbI>
X-ME-Received: <xmr:uMMZZDm6gd1D5sSGo3X7P_Mjm0S3yD_FYASpUrYk33a_OfiNaE8W5MVMpxATkJL8pbYLBJDwLgGZqw_TvdkwD7ayhofTPr4moA2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefqnhgu
 rhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvg
 hrnhepjedvtddvledufeetueevjeeuheeukeduudfhkeethfeitdefudffkeeffeevkeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhnug
 hrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:uMMZZGzs-jxG2cT_AqizBZNMtejk1TQjBucJtik14UQq7UQp7OvlCw>
 <xmx:uMMZZFR2Ez_zBC8Gi37loyvHid9jtf6KccPzHcRCMYo7oNF6PIG84w>
 <xmx:uMMZZBZ278VnGsTRmDQaz2z4xQMSpoplhhEb6zDb3gEvJvN5xDKh0Q>
 <xmx:uMMZZEKZIhCYpLnE5mE9zkaLGFWDHAwS0RZWvHrT4RgxPXIeNLJw1Q>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 10:48:23 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
In-Reply-To: <66635c75-b869-9704-edac-21026cce2b99@efficios.com>
Date: Tue, 21 Mar 2023 15:48:10 +0100
Cc: lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Message-Id: <1B64F3D0-EB5C-4023-BA15-37D0DBCBB1B3@sury.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-8-ondrej@sury.org>
 <e7384cff-06a6-6e1e-9abc-ce7932760964@efficios.com>
 <A012AAA8-7E40-40A3-A272-1703EFA26314@sury.org>
 <66635c75-b869-9704-edac-21026cce2b99@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: Re: [lttng-dev] [PATCH 7/7] Experiment: Add explicit memory barrier
 in free_completion()
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

PiBPbiAyMS4gMy4gMjAyMywgYXQgMTU6NDYsIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IAo+IE9uIDIwMjMtMDMtMjEgMDY6MjEsIE9u
ZMWZZWogU3Vyw70gd3JvdGU6Cj4+PiBPbiAyMC4gMy4gMjAyMywgYXQgMTk6MzcsIE1hdGhpZXUg
RGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Pj4gCj4+
PiBPbiAyMDIzLTAzLTE3IDE3OjM3LCBPbmTFmWVqIFN1csO9IHZpYSBsdHRuZy1kZXYgd3JvdGU6
Cj4+Pj4gRklYTUU6IFRoaXMgaXMgZXhwZXJpbWVudCB0aGF0IGFkZHMgZXhwbGljaXQgbWVtb3J5
IGJhcnJpZXIgaW4gdGhlCj4+Pj4gZnJlZV9jb21wbGV0aW9uIGluIHRoZSB3b3JrcXVldWUuYywg
c28gVGhyZWFkU2FuaXRpemVyIGtub3dzIGl0J3Mgb2sgdG8KPj4+PiBmcmVlIHRoZSByZXNvdXJj
ZXMuCj4+Pj4gU2lnbmVkLW9mZi1ieTogT25kxZllaiBTdXLDvSA8b25kcmVqQHN1cnkub3JnPgo+
Pj4+IC0tLQo+Pj4+ICBzcmMvd29ya3F1ZXVlLmMgfCAxICsKPj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4+Pj4gZGlmZiAtLWdpdCBhL3NyYy93b3JrcXVldWUuYyBiL3NyYy93
b3JrcXVldWUuYwo+Pj4+IGluZGV4IDEwMzlkNzIuLmYyMTkwN2YgMTAwNjQ0Cj4+Pj4gLS0tIGEv
c3JjL3dvcmtxdWV1ZS5jCj4+Pj4gKysrIGIvc3JjL3dvcmtxdWV1ZS5jCj4+Pj4gQEAgLTM3Nyw2
ICszNzcsNyBAQCB2b2lkIGZyZWVfY29tcGxldGlvbihzdHJ1Y3QgdXJjdV9yZWYgKnJlZikKPj4+
PiAgIHN0cnVjdCB1cmN1X3dvcmtxdWV1ZV9jb21wbGV0aW9uICpjb21wbGV0aW9uOwo+Pj4+ICAg
ICBjb21wbGV0aW9uID0gY2FhX2NvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCB1cmN1X3dvcmtxdWV1
ZV9jb21wbGV0aW9uLCByZWYpOwo+Pj4+ICsgYXNzZXJ0KCF1cmN1X3JlZl9nZXRfdW5sZXNzX3pl
cm8oJmNvbXBsZXRpb24tPnJlZikpOwo+Pj4gCj4+PiBQZXJoYXBzIHdoYXQgd2UgcmVhbGx5IHdh
bnQgaGVyZSBpcyBhbiBBTk5PVEFURV9VTlBVQkxJU0hfTUVNT1JZX1JBTkdFKCkgb2Ygc29tZSBz
b3J0ID8KPj4gSSBndWVzcz8KPj4gTXkgZXhwZXJpZW5jZSB3aXRoIFRTQU4gdGVsbHMgbWUsIHRo
YXQgeW91IG5lZWQgc29tZSBraW5kIG9mIG1lbW9yeSBiYXJyaWVyIHdoZW4gdXNpbmcgYWNxdWly
ZS1yZWxlYXNlCj4+IHNlbWFudGljcyBhbmQgeW91IGRvOgo+PiBpZiAoX19hdG9taWNfc3ViX2Zl
dGNoKG9iai0+cmVmLCBfX0FUT01JQ19SRUxFQVNFKSA9PSAwKSB7Cj4+ICAgLyogX19BVE9NSUNf
QUNRVUlSRSBuZWVkZWQgaGVyZSAqLwo+PiAgICBmcmVlKG9iaik7Cj4+IH0KPj4gd2UgZW5kIHVw
IHVzaW5nIGZvbGxvd2luZyBjb2RlIGluIEJJTkQgOToKPj4gaWYgKF9fYXRvbWljX3N1Yl9mZXRj
aChvYmotPnJlZiwgX19BVE9NSUNfQUNRX1JFTCkgPT0gMCkgewo+PiAgICBmcmVlKG9iaik7Cj4+
IH0KPj4gU28sIEkgYW0gZ3Vlc3NpbmcgYWZ0ZXIgdGhlIGNoYW5nZSBvZiB1YXRvbWljX3N1Yl9y
ZXR1cm4oKSB0byBfX0FUT01JQ19BQ1FfUkVMLAo+PiB0aGlzIHBhdGNoIHNob3VsZCBubyBsb25n
ZXIgYmUgbmVlZGVkLgo+IAo+IEFjdHVhbGx5IHdlIHdhbnQgX19BVE9NSUNfU0VRX0NTVCwgd2hp
Y2ggaXMgZXZlbiBzdHJvbmdlciB0aGFuIEFDUV9SRUwuCgpZZWFoLCBJIHRoaW5rIEkgYWxyZWFk
eSBkaWQgdGhhdCwgYnV0IHdyb3RlIHRoZSBlbWFpbCBiZWZvcmUgdGhhdC4gTmV2ZXJ0aGVsZXNz
LCBteSBtYWluCnBvaW50IHdhcyB0aGF0IGl0IHNob3VsZCBub3QgYmUgbmVlZGVkIGFueW1vcmUu
CgpPbmRyZWoKLS0KT25kxZllaiBTdXLDvSAoSGUvSGltKQpvbmRyZWpAc3VyeS5vcmcKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
