Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FEBEE57DF
	for <lttng-dev@archiver.kernel.org>; Mon, 11 Sep 2023 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1694449559;
	bh=4NHhkaTIgbmRW2cTxbI16bt0BJhLbG+emikrFzUtBmo=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GsYlxkAl93DEzds4eAAzZC39NUarPs/IbsGmuwFljK9/902+s68jPlRu17N7d5mVe
	 ndPVeiHhKYF7Hu8xigJlr+6TOL3ShV+a2gasFDVb7vq8cW5n7mv5J+GgHgzTCEdZUP
	 EaGxA2s/H+MT6oKY/GcZ5ZjHSHlrnTmN0sPP6ktg8BQQYvSNRC3prkmM+TSJLfCUYk
	 FcQ7qDqfyoeKVgmKxEZoVmQ9YzR7fEl3uDCXTi643BhrEhExHZ2y23AF94Rh2Td0ki
	 Cb6/13bv1/JPwKxwhf/VAdXqT3b/2d/JL+UGtaZOPv/OIk5FH+Q6vnvoA38kn+7+Pw
	 KCKzrD/BRccFQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RksXR1CHWz2Xqs;
	Mon, 11 Sep 2023 12:25:59 -0400 (EDT)
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4RksXP6Wydz2Xqr
 for <lttng-dev@lists.lttng.org>; Mon, 11 Sep 2023 12:25:57 -0400 (EDT)
Received: from zimbra-s1.polymtl.ca (zimbra-s1.polymtl.ca [132.207.23.203])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 38BGKr6h025244;
 Mon, 11 Sep 2023 12:20:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 38BGKr6h025244
Date: Mon, 11 Sep 2023 12:20:53 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <454808411.14773142.1694449253211.JavaMail.zimbra@polymtl.ca>
In-Reply-To: <9fad646e-46bf-9229-81cb-93a237db2922@efficios.com>
References: <6e06b605ec9f446da5dc8948c8621518@amazon.com>
 <63288a1f-59b4-80f9-2a26-bc252ce9cd1f@efficios.com>
 <900fe19a-5642-9124-4d83-0716e0d11a22@efficios.com>
 <bb2ccac8e296450c96d0863937fc8db8@amazon.com>
 <fb397173-040c-9370-c6c7-3c7b1535becb@efficios.com>
 <618d035e059840d3a32b75633aa378f5@amazon.com>
 <e658fc7033fd4a268dc9890093de6807@amazon.com>
 <9fad646e-46bf-9229-81cb-93a237db2922@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [132.207.169.244]
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC115
 (Linux)/8.8.15_GA_4562)
Thread-Topic: Profiling LTTng tracepoint latency on different arm platforms
Thread-Index: 9uxwVQWriXUMPx1MG89xleJ6BZ2QVQ==
X-Poly-FromMTA: (zimbra-s1.polymtl.ca [132.207.23.203]) at Mon,
 11 Sep 2023 16:20:53 +0000
Subject: Re: [lttng-dev] Profiling LTTng tracepoint latency on different arm
 platforms
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
From: Michel Dagenais via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

WW91IGFyZSBwcm9iYWJseSByZWZlcnJpbmcgdG8gdGhlIHdvcmsgb2YgTW9oYW1tYWQgR2ViYWk6
CgpTdXJ2ZXkgYW5kIEFuYWx5c2lzIG9mIEtlcm5lbCBhbmQgVXNlcnNwYWNlIFRyYWNlcnMgb24g
TGludXg6IERlc2lnbiwgSW1wbGVtZW50YXRpb24sIGFuZCBPdmVyaGVhZAoKaHR0cHM6Ly9kbC5h
Y20ub3JnL2RvaS9hYnMvMTAuMTE0NS8zMTU4NjQ0IAoKLS0tLS0gTGUgMTEgU2VwIDIzLCDDoCAx
MTo1MiwgTWF0aGlldSBEZXNub3llcnMgbWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tIGEg
w6ljcml0IDoKCj4gT24gOS8xMC8yMyAxMDoxOCwgTW91c2EsIEFuYXMgd3JvdGU6Cj4+IEhleSBN
YXRoaWV1LAo+IAo+IEhpIEFuYXMsCj4gCj4+IAo+PiBXZSBzZWUgdGhhdCB1cG9uIHJlY29yZGlu
ZyBhIHRyYWNlcG9pbnQsIHRoZXJlIGFyZSBtdWx0aXBsZSBzdGFnZXMgb2YKPj4gcmVzZXJ2ZS1j
b21taXQtd3JpdGUsIHdoZXJlIGF0b21pY3MgYW5kIHNoYXJlZCBtZW1vcnkgYWNjZXNzZXMgdGFr
ZSB1cCBhIGJpZwo+PiBwYXJ0IG9mIHRoZQo+PiByZWNvcmRpbmcgdGltZSwKPj4gCj4+IHdlJ3Jl
IHdvbmRlcmluZywgaXMgdGhlcmUgYSAibGlnaHQtbW9kZSIgb2YgcmVjb3JkaW5nIGEgdHJhY2Vw
b2ludAo+PiBpbnZvbHZpbmcgbGVzcyBsb2dpYyBvcgo+PiAKPj4gYSBtb2RlIHdoaWNoIGNhbiBw
b3RlbnRpYWxseSBoYXZlIGxvd2VyIGxhdGVuY3k/Cj4gCj4gSSd2ZSBiZWVuIHdvcmtpbmcgb24g
dGhlIHJzZXEoMikgc3lzdGVtIGNhbGwgZm9yIGEgZmV3IHllYXJzIG5vdywgYW5kCj4gdGhpcyBp
cyBpbnRlbmRlZCB0byBoZWxwIHJlZHVjZSB0aGUgY29zdCBvZiBsdHRuZy11c3QncyByaW5nIGJ1
ZmZlcgo+IGF0b21pY3Mgb24gdGhlIHRyYWNpbmcgZmFzdC1wYXRoLiBUaGUgcm9hZCBhaGVhZCB0
aGVyZSBpcyBpbnRlZ3JhdGlvbiBvZgo+IHJzZXEgd2l0aCBsdHRuZy11c3QsIHdoaWNoIGRpZCBu
b3Qgc2hvdyB1cCBvbiBvdXIgY3VzdG9tZXIgZmVhdHVyZQo+IHJlcXVpcmVtZW50cyByYWRhciB5
ZXQuCj4gCj4gSW4gdGVybXMgb2YgbG9naWMgaW52b2x2ZWQgaW4gdGhlIGx0dG5nLXVzdCB0cmFj
ZXBvaW50cywgSSBob3BlIHRoYXQgbXkKPiBjdXJyZW50IHdvcmsgb24gImxpYnNpZGUiIHdpbGwg
aGVscCBzdGVlciBhd2F5IGZyb20gdHJhY2Vwb2ludCBwcm92aWRlcnMKPiBiYXNlZCBvbiBtYWNy
b3MgYW5kIGdlbmVyYXRlZCBjb2RlLCByZXBsYWNpbmcgdGhpcyBieSBhbiBlZmZpY2llbnQKPiBi
eXRlY29kZSBpbnRlcnByZXRlci4gVGhpcyBzaG91bGQgYWxsb3cgbWUgdG8gaW5saW5lIG1hbnkg
b2YgdGhlIGNhbGxzCj4gdGhhdCBhcmUgY3VycmVudGx5IG5lZWRlZCBiZXR3ZWVuIHRoZSB0cmFj
ZXBvaW50IHByb2JlIHByb3ZpZGVyIGFuZCB0aGUKPiBsdHRuZy11c3QgcmluZyBidWZmZXIuIEFn
YWluLCB0aGlzIGlzIGFuIGFyZWEgd2hlcmUgSSB0aGluayB3ZSBjYW4gaGF2ZQo+IGdyZWF0IHNw
ZWVkIGltcHJvdmVtZW50cywgYnV0IGl0IGRpZCBub3Qgc2hvdyB1cCBvbiBvdXIgY3VzdG9tZXIn
cwo+IGZlYXR1cmUgcmVxdWlyZW1lbnQgcmFkYXIgeWV0Lgo+IAo+PiBBbHNvLCBhcmUgdGhlcmUg
YW55IHJlY2VudMKgZG9jcyB0byBzaGFyZSByZWdhcmRpbmfCoHRyYWNlcG9pbnQgbGF0ZW5jeT8K
PiAKPiBUaGVyZSBpcyBhIFBvbHl0ZWNobmlxdWUgc3R1ZGVudCB3aG8gZXh0ZW5zaXZlbHkgYW5h
bHl6ZWQgdGhpcyByZWNlbnRseS4KPiBNaWNoZWwsIGRvIHlvdSBoYXZlIGEgcG9pbnRlciB0byBo
aXMgd29yayA/Cj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiAtLQo+IE1hdGhpZXUgRGVz
bm95ZXJzCj4gRWZmaWNpT1MgSW5jLgo+IGh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
