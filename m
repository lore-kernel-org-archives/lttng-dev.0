Return-Path: <SRS0=qFiG=AM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E05C433E1
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 03:05:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF0420724
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Jul 2020 03:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="F4bR2s/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF0420724
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49xR1g0Yrnz18Dh;
	Tue, 30 Jun 2020 23:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593572743;
	bh=XbDtYz5NlTCgArHXWvBDFn2JfunCJF6ZOeOvixJIfEo=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=F4bR2s/YN4U5WFH/MRjPaCN1i/TxNJO6YhB5BRqDq5eOoRT3bcWMy/x27lftO3z8z
	 bk61E7KzA5vodqOB3xS38UnABInyZghVKaS1Wu6U3Mf3ZWMHx7q0kSqk4xC6/Nb9UG
	 uAulaPS2WFCOBhl4jyGolzS++f0CIP1jQXC1kPCicYMmy7sgRVV3/YtPirFsjPwejG
	 z8O5jkEMan04xl83TLhrif0f3hKTFPa0cTkaKNpEsKALvvC5oTfztFH4IAeDBGrJQ8
	 wrjjbiXYB4j3nW2B0/9x2MJAVd9js9j6FYaJ6u+XcTffTrNBYVgSmUrnKl63aJHkEI
	 e2VAVuuPNGBwQ==
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by lists.lttng.org (Postfix) with ESMTPS id 49xR1c4GzTz1857
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2020 23:05:40 -0400 (EDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1263495|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.229138-0.00459047-0.766271; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04407; MF=zhenyu.ren@aliyun.com; NM=1; PH=DW; RN=2; RT=2; SR=0;
 TI=W4_5899425_DEFAULT_0AC264CD_1593570969777_o7001c2136; 
Received: from WS-web
 (zhenyu.ren@aliyun.com[W4_5899425_DEFAULT_0AC264CD_1593570969777_o7001c2136])
 by e01f04428.eu6 at Wed, 01 Jul 2020 10:48:37 +0800
Date: Wed, 01 Jul 2020 10:48:37 +0800
To: "lttng-dev" <lttng-dev@lists.lttng.org>,
 "mathieu.desnoyers" <mathieu.desnoyers@efficios.com>
Message-ID: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
X-Mailer: [Alimail-Mailagent][W4_5899425][DEFAULT][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_5899425_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTRfNCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgzLjAuNDEwMy4xMTYgU2FmYXJpLzUzNy4zNg==vN
Subject: [lttng-dev] =?utf-8?q?some_tracepoints_not_exist_in_metadata=3F?=
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
Content-Type: multipart/mixed; boundary="===============0525527763999544910=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200701024837.AKpOcHobXNVxxNfgIRmny54Vpx3MjvijafqTxHiBON8@z>

--===============0525527763999544910==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_30223_6dc31940_5efbf985_6eaff"

------=ALIBOUNDARY_30223_6dc31940_5efbf985_6eaff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGksCiAgIEkgZmluZCBzb21ldGltZXMgdGhlcmUgYXJlIHNvbWUgdHJhY2Vwb2ludHMgbm90IGV4
aXN0IGluIG1ldGFkYXRhIGZpbGUoYnV0IHRoZXkgYXJlIGluIHRoZSBsaXN0IG9mIGx0dG5nIGxp
c3QgLXUpIGFuZCB0aGUgZW5kIHJlc3VsdCBpcyAgdGhleSBjYW4gTk9UIGJlIGxvZ2dlZC4gSSBj
YW4gbm90IGFsd2F5cyByZXByb2R1Y2UgaXQuIEl0IGJvdGhlcmVkIG1lIGZvciAyIGRheXMuIAog
ICBUaGUgbHR0bmcgdmVyc2lvbiBpcyAyLjcsIEkga25vdyBpdCBpcyBub3QgdGhlIGxhdGVzdCB2
ZXJzaW9uIGJ1dCB0aGVyZSBhcmUgc29tZSByZWFzb25zIEkgY2FuJ3QgdXBkYXRlIGl0LiBTbywg
aXMgdGhpcyBhIGtub3duIGJ1Zz8gIElmIHllcywgSXQgd2lsbCBiZSB2ZXJ5IGFwcHJlY2lhdGVk
IGlmIHlvdSBjYW4gZ2l2ZSBtZSBhbnkgYWR2aWNlIGFib3V0IHRoZSBidWcgaW5mbyhJIGNhbiBj
aGVycnkgcGljayB0aGUgY29ycmVzcG9uZCBmaXgpLiBPdGhlcndpc2UsIG1heWJlIEkgaGF2ZSB0
byBnaXZlIHVwIG15IGZhdm9yaWF0ZSBMdHRuZy4uLi4KClRoYW5rIHlvdSBpbiBhZHZhbmNlIQp6
aGVueXUucmVu
------=ALIBOUNDARY_30223_6dc31940_5efbf985_6eaff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iX19hbGl5dW5fZW1haWxfYm9keV9ibG9jayI+PGRpdiAgc3R5bGU9ImNsZWFy
OmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxBcmlhbCxTVEhlaXRpLFNp
bVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij5IaSw8L3NwYW4+PC9kaXY+PGRp
diAgc3R5bGU9ImNsZWFyOmJvdGg7Ij48c3BhbiAgc3R5bGU9ImZvbnQtZmFtaWx5OlRhaG9tYSxB
cmlhbCxTVEhlaXRpLFNpbVN1bjtmb250LXNpemU6MTQuMHB4O2NvbG9yOiMwMDAwMDA7Ij4mbmJz
cDsgJm5ic3A7SSBmaW5kIHNvbWV0aW1lcyB0aGVyZSBhcmUgc29tZSB0cmFjZXBvaW50cyBub3Qg
ZXhpc3QgaW4gbWV0YWRhdGEgZmlsZShidXQgdGhleSBhcmUgaW4gdGhlIGxpc3Qgb2YgbHR0bmcg
bGlzdCAtdSkgYW5kIHRoZSBlbmQgcmVzdWx0IGlzJm5ic3A7IHRoZXkgY2FuIE5PVCBiZSBsb2dn
ZWQuIEkgY2FuIG5vdCBhbHdheXMgcmVwcm9kdWNlIGl0LiBJdCBib3RoZXJlZCBtZSBmb3IgMiBk
YXlzLiZuYnNwOzwvc3Bhbj48L2Rpdj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxzcGFuICBz
dHlsZT0iZm9udC1mYW1pbHk6VGFob21hLEFyaWFsLFNUSGVpdGksU2ltU3VuO2ZvbnQtc2l6ZTox
NC4wcHg7Y29sb3I6IzAwMDAwMDsiPjwvc3Bhbj4mbmJzcDsgJm5ic3A7VGhlIGx0dG5nIHZlcnNp
b24gaXMgMi43LCBJIGtub3cgaXQgaXMgbm90IHRoZSBsYXRlc3QgdmVyc2lvbiBidXQgdGhlcmUg
YXJlIHNvbWUgcmVhc29ucyBJIGNhbid0IHVwZGF0ZSBpdC4gU28sIGlzIHRoaXMgYSBrbm93biBi
dWc/Jm5ic3A7IElmIHllcywgSXQgd2lsbCBiZSB2ZXJ5IGFwcHJlY2lhdGVkIGlmIHlvdSBjYW4g
Z2l2ZSBtZSBhbnkgYWR2aWNlIGFib3V0IHRoZSBidWcgaW5mbyhJIGNhbiBjaGVycnkgcGljayB0
aGUgY29ycmVzcG9uZCBmaXgpLiBPdGhlcndpc2UsIG1heWJlIEkgaGF2ZSB0byBnaXZlIHVwIG15
IGZhdm9yaWF0ZSBMdHRuZy4uLi48L2Rpdj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPjxiciA+
PC9kaXY+PGRpdiAgc3R5bGU9ImNsZWFyOmJvdGg7Ij5UaGFuayB5b3UgaW4gYWR2YW5jZSE8L2Rp
dj48ZGl2ICBzdHlsZT0iY2xlYXI6Ym90aDsiPnpoZW55dS5yZW48L2Rpdj48L2Rpdj4=
------=ALIBOUNDARY_30223_6dc31940_5efbf985_6eaff--


--===============0525527763999544910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0525527763999544910==--

