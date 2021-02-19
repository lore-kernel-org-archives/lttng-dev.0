Return-Path: <SRS0=UQx0=HV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A9C433E0
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 19:20:15 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A8264E15
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Feb 2021 19:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A8264E15
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Dj1cY1rH2z2gc;
	Fri, 19 Feb 2021 14:20:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613762413;
	bh=HWe+RZD3Ipl8bc1Ge8nn7smvmMDukLXxSXKIW9y7NXE=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EUCnZYMR3nnKxy+JoZuM8DHCtSySItOUeA+waDxlYulGhcTgNbTHWiqN9Zc8DbRsK
	 Gh9BTWLQ4apAj57d6aGZ5sXUEVmNuyAYoD3roVaRpPrw+vSYYIpwlZRztHuqArA55n
	 3rUUi12xcKzZHbYS1RGyyXWh0wNuJoB0kLAVxNL1Fc8aUWn82cLDwqbE6UQvsgOad1
	 RYqXwwrLAKr4spnbt8RePMBt5qQjE8ldHJb1j+e2b4H2TXNZl91QWcS7awR1itER9A
	 goQdzlHyCVCc4t4BdT58flpxmLLp1aTgVtFvOQoSH975DS/Iwkqv+jUTii/dn2IRQn
	 nG7sKJDJK/gMQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dj1cX229Xz35R
 for <lttng-dev@lists.lttng.org>; Fri, 19 Feb 2021 14:20:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 922952FF499;
 Fri, 19 Feb 2021 14:20:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id j6bsnMIiYsqb; Fri, 19 Feb 2021 14:20:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 581EB2FF1D1;
 Fri, 19 Feb 2021 14:20:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 581EB2FF1D1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5XvI9O1_NmbS; Fri, 19 Feb 2021 14:20:11 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4B3432FF378;
 Fri, 19 Feb 2021 14:20:11 -0500 (EST)
Date: Fri, 19 Feb 2021 14:20:11 -0500 (EST)
To: Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Message-ID: <1530611207.28274.1613762411148.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABB28Cy=1q3nEkW_zZheovzX5Lfa6f3HMO940mEHTE4QY7RYZw@mail.gmail.com>
References: <CABB28Cy1yzw7DGMO2Hoi83pQbEPr521YTWszO7LbgkQ8OXFAOQ@mail.gmail.com>
 <CABB28Cxfnmj7FyRTRJdgOJJ6UdSmf8Nd7ZeDt2CF_7FQMQhsVA@mail.gmail.com>
 <846525289.26662.1613658859303.JavaMail.zimbra@efficios.com>
 <CABB28Cy=1q3nEkW_zZheovzX5Lfa6f3HMO940mEHTE4QY7RYZw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: userspace-rcu 0.12.2: build fails
Thread-Index: Gcbf+hy0BzxUzP9VDp7yQT5XeK5Egw==
Subject: Re: [lttng-dev] userspace-rcu 0.12.2: build fails
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgotLS0tLSBPbiBGZWIgMTksIDIwMjEsIGF0IDE6MzkgUE0sIFRvbWFzeiBLxYJvY3prbyBrbG9j
emtvLnRvbWFzekBnbWFpbC5jb20gd3JvdGU6Cgo+IE9uIFRodSwgMTggRmViIDIwMjEgYXQgMTQ6
MzQsIE1hdGhpZXUgRGVzbm95ZXJzIDwgWwo+IG1haWx0bzptYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20gfCBtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gXSA+Cj4gd3JvdGU6Cgo+
PiAtLS0tLSBPbiBGZWIgMTcsIDIwMjEsIGF0IDg6NDEgUE0sIFRvbWFzeiBLxYJvY3prbyBbCj4+
IG1haWx0bzprbG9jemtvLnRvbWFzekBnbWFpbC5jb20gfCBrbG9jemtvLnRvbWFzekBnbWFpbC5j
b20gXSB3cm90ZToKCj4+ID4gSGksCgo+PiA+IEp1c3QgdGVzdGVkIDAuMTIuMiBhbmQgbG9vayBz
IGxpa2UgYnVpbGQgZmFpbHMgb24gY29tcGlsZSB0ZXN0IHByb2dyYW1zOgoKPj4gSGksCgo+PiBB
ZGRpbmcgTWljaGFlbCBhbmQgdGhlIGx0dG5nLWRldiBtYWlsaW5nIGxpc3QgaW4gQ0MuCgo+PiBD
YW4geW91IHByb3ZpZGUgaW5mb3JtYXRpb24gYWJvdXQgeW91ciBidWlsZCBlbnZpcm9ubWVudCA/
IFdoaWNoIGRpc3RyaWJ1dGlvbgo+PiBhcmUgeW91Cj4+IGJ1aWxkaW5nIG9uID8KCj4+IElzIGl0
IGEgcHJpc3RpbmUgdHJlZSBvbiB3aGljaCBib290c3RyYXAgYW5kIGNvbmZpZ3VyZSBoYXZlIGJl
ZW4gZXhlY3V0ZWQKPj4gbG9jYWxseSA/Cgo+PiBDYW4geW91IHJlcHJvZHVjZSB0aGlzIGlzc3Vl
IHdpdGggMC4xMi4xID8KCj4gSnVzdCBkb25lIHRoYXQgdGVzdCBhbmQgaW4gZXhhY3RseSB0aGUg
c2FtZSBidWlsZCBlbnYgMC4xMi4xIGJ1aWxkcyB3aXRob3V0IGFueQo+IHByb2JsZW1zLgoKR29v
ZCB0byBrbm93LiBUaGlzIGRvZXMgbm90IHByb3ZpZGUgYW55IGNsYXJpZmljYXRpb24gb24geW91
ciBidWlsZCBlbnZpcm9ubWVudAp0aG91Z2ggKHNlZSBteSByZXF1ZXN0IGFib3ZlKS4gVGhlcmVm
b3JlIHdlIGNhbm5vdCBhdHRlbXB0IHRvIHJlcHJvZHVjZSBvbiBvdXIgc2lkZSB5ZXQuCgpUaGFu
a3MsCgpNYXRoaWV1CgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
