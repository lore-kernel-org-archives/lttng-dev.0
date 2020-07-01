Return-Path: <SRS0=qFiG=AM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FCC433DF
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 03:44:06 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A5F20748
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 03:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="qEjqGM6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5F20748
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49xRsw3Ndkz18H6;
	Tue, 30 Jun 2020 23:44:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593575045;
	bh=c2kz6UZ0w3nyUK8xHsf/3uQVxsMVaUWBifI/NPTbaAw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=qEjqGM6/kRVCfOTQ2fOHc9NthQwcrlQk+tNe6Zl+g+7e+gfpTI0GRjwz9ueirSpuj
	 +ONbfOweBNhptYYUI3osxSoXmQYzSvnd8lw+od5MKxWwW1kbka/4U48BM97rENAy2v
	 uijxLFTHVcYICMRmW0Upzv0mYWoBV0Lg0KXvcsHTTY8+76V1oM78XAVCj0KW4K9Tlq
	 qexGJIo6/mEJKrtEjkAzrFtN/6kxto2CMjEBlxf/vfgyotZZQxDeKKdqrztopx5xpX
	 0VAdxWWmf6E5g2S1T5pt5x6Htl6P2gsaPkW/PRWDN3akT9YJ/56SAd82H6uCAUfEVs
	 Jak8b+P0PCXxw==
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by lists.lttng.org (Postfix) with ESMTPS id 49xRst0kZ4z18cv
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2020 23:44:01 -0400 (EDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08283699|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0112035-0.00300384-0.985793;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e07425; MF=zhenyu.ren@aliyun.com; NM=1; PH=DW;
 RN=2; RT=2; SR=0; TI=W4_5899425_DEFAULT_0AC264AF_1593575011550_o7001c43o; 
Received: from WS-web
 (zhenyu.ren@aliyun.com[W4_5899425_DEFAULT_0AC264AF_1593575011550_o7001c43o])
 by e01f04446.eu6 at Wed, 01 Jul 2020 11:43:31 +0800
Date: Wed, 01 Jul 2020 11:43:31 +0800
To: "lttng-dev" <lttng-dev@lists.lttng.org>,
 "mathieu.desnoyers" <mathieu.desnoyers@efficios.com>
Message-ID: <49dab706-ab7e-4156-9163-b8d9105b173d.zhenyu.ren@aliyun.com>
X-Mailer: [Alimail-Mailagent][W4_5899425][DEFAULT][Chrome]
MIME-Version: 1.0
References: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
x-aliyun-mail-creator: W4_5899425_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTRfNCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgzLjAuNDEwMy4xMTYgU2FmYXJpLzUzNy4zNg==vN
In-Reply-To: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
Subject: [lttng-dev] =?utf-8?b?5Zue5aSN77yaIHNvbWUgdHJhY2Vwb2ludHMgbm90?=
 =?utf-8?q?_exist_in_metadata=3F?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "zhenyu.ren via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Content-Type: multipart/mixed; boundary="===============4214650225344960069=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200701034331.LXbH9rrIsPe6NCQEks89ic62spqd9rOZwc3Qe3UCSZ8@z>

--===============4214650225344960069==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_12084_7fa2cd77b940_5efc0663_6f881"

------=ALIBOUNDARY_12084_7fa2cd77b940_5efc0663_6f881
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SSdkIGxpa2UgdG8gYWRkIHRoYXQgYm90aCAibHR0bmcgbGlzdCAtdSIgYW5kICJsdHRuZyBsaXN0
ICRzZXNzaW9uX25hbWUiIGNhbiBnZXQgdGhvc2UgdHJhY2Vwb2ludHMnIG5hbWVzLi4uIAotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0K5Y+R5Lu25Lq677yaemhlbnl1LnJlbiB2aWEgbHR0bmctZGV2IDxsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnPgrlj5HpgIHml7bpl7TvvJoyMDIw5bm0N+aciDHml6Uo5pif5pyf5LiJKSAx
MTowNQrmlLbku7bkurrvvJpsdHRuZy1kZXYgPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+OyBt
YXRoaWV1LmRlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgrkuLvjgIDp
opjvvJpbbHR0bmctZGV2XSBzb21lIHRyYWNlcG9pbnRzIG5vdCBleGlzdCBpbiBtZXRhZGF0YT8K
CkhpLAogICBJIGZpbmQgc29tZXRpbWVzIHRoZXJlIGFyZSBzb21lIHRyYWNlcG9pbnRzIG5vdCBl
eGlzdCBpbiBtZXRhZGF0YSBmaWxlKGJ1dCB0aGV5IGFyZSBpbiB0aGUgbGlzdCBvZiBsdHRuZyBs
aXN0IC11KSBhbmQgdGhlIGVuZCByZXN1bHQgaXMgIHRoZXkgY2FuIE5PVCBiZSBsb2dnZWQuIEkg
Y2FuIG5vdCBhbHdheXMgcmVwcm9kdWNlIGl0LiBJdCBib3RoZXJlZCBtZSBmb3IgMiBkYXlzLiAK
ICAgVGhlIGx0dG5nIHZlcnNpb24gaXMgMi43LCBJIGtub3cgaXQgaXMgbm90IHRoZSBsYXRlc3Qg
dmVyc2lvbiBidXQgdGhlcmUgYXJlIHNvbWUgcmVhc29ucyBJIGNhbid0IHVwZGF0ZSBpdC4gU28s
IGlzIHRoaXMgYSBrbm93biBidWc/ICBJZiB5ZXMsIEl0IHdpbGwgYmUgdmVyeSBhcHByZWNpYXRl
ZCBpZiB5b3UgY2FuIGdpdmUgbWUgYW55IGFkdmljZSBhYm91dCB0aGUgYnVnIGluZm8oSSBjYW4g
Y2hlcnJ5IHBpY2sgdGhlIGNvcnJlc3BvbmQgZml4KS4gT3RoZXJ3aXNlLCBtYXliZSBJIGhhdmUg
dG8gZ2l2ZSB1cCBteSBmYXZvcmlhdGUgTHR0bmcuLi4uCgpUaGFuayB5b3UgaW4gYWR2YW5jZSEK
emhlbnl1LnJlbg==
------=ALIBOUNDARY_12084_7fa2cd77b940_5efc0663_6f881
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iX19hbGl5dW5fZW1haWxfYm9keV9ibG9jayI+PGRpdiAgc3R5bGU9ImNsZWFy
OmJvdGg7Ij48Zm9udCAgY29sb3I9IiMwMDAwMDAiIGZhY2U9IlRhaG9tYSwgQXJpYWwsIFNUSGVp
dGksIFNpbVN1biI+SSdkIGxpa2UgdG8gYWRkIHRoYXQmbmJzcDs8L2ZvbnQ+PHNwYW4gIHN0eWxl
PSJjb2xvcjojMDAwMDAwO2ZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxTVEhlaXRpLFNpbVN1bjsi
PmJvdGggImx0dG5nIGxpc3QgLXUiIGFuZCAibHR0bmcgbGlzdCAkc2Vzc2lvbl9uYW1lIiBjYW4g
Z2V0IHRob3NlIHRyYWNlcG9pbnRzJyBuYW1lcy4uLiZuYnNwOzwvc3Bhbj48L2Rpdj48YmxvY2tx
dW90ZSAgc3R5bGU9Im1hcmdpbi1yaWdodDowO21hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjA7
Ij48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBzdHlsZT0iZm9udC1mYW1pbHk6VGFo
b21hLEFyaWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZToxNC4wcHg7Y29sb3I6IzAwMDAwMDsi
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTwvc3Bhbj48L2Rpdj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBz
dHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFyaWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZTox
NC4wcHg7Y29sb3I6IzAwMDAwMDsiPuWPkeS7tuS6uu+8mnpoZW55dS5yZW4gdmlhIGx0dG5nLWRl
diAmbHQ7bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyZndDs8L3NwYW4+PC9kaXY+PGRpdiAgc3R5
bGU9ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxT
VEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij7lj5HpgIHml7bp
l7TvvJoyMDIw5bm0N+aciDHml6Uo5pif5pyf5LiJKSAxMTowNTwvc3Bhbj48L2Rpdj48ZGl2ICBz
dHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBzdHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFyaWFs
LFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZToxNC4wcHg7Y29sb3I6IzAwMDAwMDsiPuaUtuS7tuS6
uu+8mmx0dG5nLWRldiAmbHQ7bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyZndDs7IG1hdGhpZXUu
ZGVzbm95ZXJzICZsdDttYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20mZ3Q7PC9zcGFuPjwv
ZGl2PjxkaXYgIHN0eWxlPSJjbGVhcjpib3RoOyI+PHNwYW4gIHN0eWxlPSJmb250LWZhbWlseTpU
YWhvbWEsQXJpYWwsU1RIZWl0aSxTaW1TdW47Zm9udC1zaXplOjE0LjBweDtjb2xvcjojMDAwMDAw
OyI+5Li744CA6aKY77yaW2x0dG5nLWRldl0gc29tZSB0cmFjZXBvaW50cyBub3QgZXhpc3QgaW4g
bWV0YWRhdGE/PC9zcGFuPjwvZGl2PjxkaXYgIHN0eWxlPSJjbGVhcjpib3RoOyI+PHNwYW4gIHN0
eWxlPSJmb250LWZhbWlseTpUYWhvbWEsQXJpYWwsU1RIZWl0aSxTaW1TdW47Zm9udC1zaXplOjE0
LjBweDtjb2xvcjojMDAwMDAwOyI+PGJyIC8+PC9zcGFuPjwvZGl2PjxkaXYgIHN0eWxlPSJjbGVh
cjpib3RoOyI+PHNwYW4gIGNsYXNzPSIgX19hbGl5dW5fbm9kZV9oYXNfY29sb3IiIHN0eWxlPSJm
b250LWZhbWlseTpUYWhvbWEsQXJpYWwsU1RIZWl0aSxTaW1TdW47Zm9udC1zaXplOjE0LjBweDtj
b2xvcjojMDAwMDAwOyI+SGksPC9zcGFuPjwvZGl2PjxkaXYgIHN0eWxlPSJjbGVhcjpib3RoOyI+
PHNwYW4gIGNsYXNzPSIgX19hbGl5dW5fbm9kZV9oYXNfY29sb3IiIHN0eWxlPSJmb250LWZhbWls
eTpUYWhvbWEsQXJpYWwsU1RIZWl0aSxTaW1TdW47Zm9udC1zaXplOjE0LjBweDtjb2xvcjojMDAw
MDAwOyI+Jm5ic3A7ICZuYnNwO0kgZmluZCBzb21ldGltZXMgdGhlcmUgYXJlIHNvbWUgdHJhY2Vw
b2ludHMgbm90IGV4aXN0IGluIG1ldGFkYXRhIGZpbGUoYnV0IHRoZXkgYXJlIGluIHRoZSBsaXN0
IG9mIGx0dG5nIGxpc3QgLXUpIGFuZCB0aGUgZW5kIHJlc3VsdCBpcyZuYnNwOyB0aGV5IGNhbiBO
T1QgYmUgbG9nZ2VkLiBJIGNhbiBub3QgYWx3YXlzIHJlcHJvZHVjZSBpdC4gSXQgYm90aGVyZWQg
bWUgZm9yIDIgZGF5cy4mbmJzcDs8L3NwYW4+PC9kaXY+PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7
Ij48c3BhbiAgY2xhc3M9IiBfX2FsaXl1bl9ub2RlX2hhc19jb2xvciIgc3R5bGU9ImZvbnQtZmFt
aWx5OlRhaG9tYSxBcmlhbCxTVEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMw
MDAwMDA7Ij48L3NwYW4+Jm5ic3A7ICZuYnNwO1RoZSBsdHRuZyB2ZXJzaW9uIGlzIDIuNywgSSBr
bm93IGl0IGlzIG5vdCB0aGUgbGF0ZXN0IHZlcnNpb24gYnV0IHRoZXJlIGFyZSBzb21lIHJlYXNv
bnMgSSBjYW4ndCB1cGRhdGUgaXQuIFNvLCBpcyB0aGlzIGEga25vd24gYnVnPyZuYnNwOyBJZiB5
ZXMsIEl0IHdpbGwgYmUgdmVyeSBhcHByZWNpYXRlZCBpZiB5b3UgY2FuIGdpdmUgbWUgYW55IGFk
dmljZSBhYm91dCB0aGUgYnVnIGluZm8oSSBjYW4gY2hlcnJ5IHBpY2sgdGhlIGNvcnJlc3BvbmQg
Zml4KS4gT3RoZXJ3aXNlLCBtYXliZSBJIGhhdmUgdG8gZ2l2ZSB1cCBteSBmYXZvcmlhdGUgTHR0
bmcuLi4uPC9kaXY+PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7Ij48YnIgPjwvZGl2PjxkaXYgIHN0
eWxlPSJjbGVhcjpib3RoOyI+VGhhbmsgeW91IGluIGFkdmFuY2UhPC9kaXY+PGRpdiAgc3R5bGU9
ImNsZWFyOmJvdGg7Ij56aGVueXUucmVuPC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pg==
------=ALIBOUNDARY_12084_7fa2cd77b940_5efc0663_6f881--


--===============4214650225344960069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4214650225344960069==--

