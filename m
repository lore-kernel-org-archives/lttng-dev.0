Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640FAC6FD1C
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Mar 2023 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679483333;
	bh=/Xrle5TQ069q+ZlfCAxmicf1fulV5TX4Ss3pamiENRw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=o+95MLcNDH/3IR4NWIeYbFleNltD1W+6wo6Bj+yMhuen330cN/HCLBp6Bq5mgqKR0
	 Xx4ZLYNYSgvujYEVGEfJB4f2xGhukGJLbiuEN67ZhNxHrsZ4g5zvmBlc52YGGou9Ll
	 CiURfevRKmOtwmpR/MDGDwn9WFM9PBbpJFErgmDX3R9K6NLqJIsflGhI+U4bIiBMtu
	 f0q+JIWNRphuy/Xr7MbiVHlBzlaW+sJR/7xUQn4Zirxfy2tvSG0kic734njp4tQIIY
	 U0Q5/vYf85wlJbDIAcqysDrb6/ECtnLfwD5MaE3F4DvWuM26K66jLrac/+eQajtuBT
	 xIXcfzKpVNT4g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PhQhN4ssRz2Hbq;
	Wed, 22 Mar 2023 07:08:52 -0400 (EDT)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by lists.lttng.org (Postfix) with ESMTPS id 4PhQhL51mMz2Hbn
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 07:08:50 -0400 (EDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 2CD0D32009D2
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 07:08:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 22 Mar 2023 07:08:48 -0400
X-ME-Sender: <xms:v-EaZJx9sXfEwYVAsirN4sdVoi5cTXdBjD1C6Iq56NiF1jMXndtOwQ>
 <xme:v-EaZJS_MsnL2CY3i7Z4tLzA0qf_S9UzTRXPU2FxBMxrp6x3tAkTp6chD9cSo8SPt
 noiM3KBE2J0I50j23s>
X-ME-Received: <xmr:v-EaZDXiii5sGnHspiYf64ZeLPDBxDCMfge_53q8u3uD7y0ePUUxLcIyJhRIaJ_v9uBmbO_rv5T2C0vfG-gwbwaxZHPNxOlkURQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
 hhtdejnecuhfhrohhmpefqnhgurhgvjhcuufhurhpuuceoohhnughrvghjsehsuhhrhidr
 ohhrgheqnecuggftrfgrthhtvghrnhepkeeikefghfehvdetleeffeelieeihfdthfdtue
 elfffftdevueejteeuvdekveejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepohhnughrvghjsehsuhhrhidrohhrgh
X-ME-Proxy: <xmx:v-EaZLhaHVyxXJIzPFCck4Mj5AqAdhdwF_8YNhFLt53PfmisD1AXVA>
 <xmx:v-EaZLC05AVlqjRj_dJu0VP7l4VOZouxx1gdh6WNblPIrsL5R9MaJQ>
 <xmx:v-EaZEKr3a-M5-XQvMqoMYylgExFJxSDoLqO4exgjNRcWbOIE8qoZA>
 <xmx:v-EaZO_Qr4Co7DY6MuqFpdbhEqmKlFre4biBMfPjXL2etR1ANTcNZw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 07:08:47 -0400 (EDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Message-Id: <D3F46FB3-2D4B-442D-99A3-F9DEB3918731@sury.org>
Date: Wed, 22 Mar 2023 12:08:33 +0100
To: lttng-dev@lists.lttng.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Subject: [lttng-dev] RCU API usage from call_rcu callbacks?
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

SGksCgp0aGUgZG9jdW1lbnRhdGlvbiBpcyBwcmV0dHkgc2lsZW50IG9uIHRoaXMsIGFuZCBhc2tp
bmcgaGVyZSBpcyBwcm9iYWJseSBnb2luZyB0byBiZSBmYXN0ZXIKdGhhbiBtZSB0cnlpbmcgdG8g
dXNlIHRoZSBzb3VyY2UgdG8gZmlndXJlIHRoaXMgb3V0LgoKSXMgaXQgbGVnYWwgdG8gY2FsbF9y
Y3UoKSBmcm9tIHdpdGhpbiB0aGUgY2FsbF9yY3UoKSBjYWxsYmFjaz8KCldoYXQgYWJvdXQgdGhl
IG90aGVyIFJDVSAoYW5kIENEUykgQVBJIGNhbGxzPwoKSG93IGRvZXMgdGhhdCBpbnRlcmFjdCB3
aXRoIGNyZWF0ZV9jYWxsX3JjdV9kYXRhKCk/ICBJIGhhdmUgPG4+IGV2ZW50IGxvb3BzIGFuZCBJ
IGFtCmluaXRpYWxpemluZyA8bj4gMToxIGNhbGxfcmN1IGhlbHBlciB0aHJlYWRzIGFzIEkgbmVl
ZCB0byBkbyBzb21lIHBlci10aHJlYWQgaW5pdGlhbGl6YXRpb24KYXMgc29tZSBvZiB0aGUgZGVz
dHJveS1saWtlIGZ1bmN0aW9ucyB1c2UgcmFuZG9tIG51bWJlcnMgKGRvbid0IGFzaykuCgpJZiBp
dCdzIGxlZ2FsIHRvIGNhbGxfcmN1KCkgZnJvbSBjYWxsX3JjdSB0aHJlYWQsIHdoaWNoIHRocmVh
ZCBpcyBnb2luZyB0byBiZSB1c2VkPwoKVGhhbmsgeW91LApPbmRyZWoKLS0KT25kxZllaiBTdXLD
vSAoSGUvSGltKQpvbmRyZWpAc3VyeS5vcmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
