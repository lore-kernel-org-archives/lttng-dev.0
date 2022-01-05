Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE3C433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jan 2022 17:06:01 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JTbTz4dQxz81R;
	Wed,  5 Jan 2022 12:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641402360;
	bh=dKX6S9+8F/VBLedbSEoLAY4k3Fcb1Ym7Cl7jikbJq6A=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fshQtWP2PIM7vMB1SQBFMhgL5IXka4zu08ePddJQed1oll+foPp0dwZ0EPj+V+xZK
	 Q46tDVOpNPRsF+zkLWz1GTP7v0wFY2Bqic0/WxHsR8sz2eQxxmWvKV6/wc5jPe6pdd
	 utIFRw/1Q3gVj/zYR4EdVS10kwBM9KSI8D6h1nTHZDmk2L5E5t7N/j2RNIDW5tw2ZF
	 JCSUWhVPjPXXvdLmIsOD0YM4c//M8ydDkypk8W4zdAP5sQwUySp0CgAFk88iqIjP0C
	 ACZFqEYBrv7fZ8GllKACom7joyVyywt8CW3a3xQLeaVOD8B/BhQLxSdFPtt+HM5eEW
	 HYSNBIunewN2g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JTbTy1vkDz8tD
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 12:05:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D2E0A3C7FD3
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 12:05:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id M6q7IG2J8gZY; Wed,  5 Jan 2022 12:05:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56D033C7FD1;
 Wed,  5 Jan 2022 12:05:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56D033C7FD1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BptpLPl9qQgr; Wed,  5 Jan 2022 12:05:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4D1C03C7FD0;
 Wed,  5 Jan 2022 12:05:52 -0500 (EST)
Date: Wed, 5 Jan 2022 12:05:52 -0500 (EST)
To: Subrata Paul <subrata.turs@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <2050940547.2707.1641402352283.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABAcCUNcS1yaP7-mLijXmecOczr9vQkOukhW4Q-YgKc6Vz-bZw@mail.gmail.com>
References: <CABAcCUNcS1yaP7-mLijXmecOczr9vQkOukhW4Q-YgKc6Vz-bZw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - GC96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Running trace-rotate and session-rotate together
Thread-Index: fsULSbPvgi+fHxraSZpDI6IfHUNZ1g==
Subject: Re: [lttng-dev] Running trace-rotate and session-rotate together
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgotLS0tLSBNZXNzYWdlIG9yaWdpbmFsIC0tLS0tCj4gRGU6ICJsdHRuZy1kZXYiIDxsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnPgo+IMOAOiAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZz4KPiBFbnZvecOpOiBNYXJkaSAyMSBEw6ljZW1icmUgMjAyMSAwMTo0NzoxMgo+IE9i
amV0OiBbbHR0bmctZGV2XSBSdW5uaW5nIHRyYWNlLXJvdGF0ZSBhbmQgc2Vzc2lvbi1yb3RhdGUg
dG9nZXRoZXIKCj4gSGksCj4gMS4gSW4gdGhlIGx0dG5nLWVuYWJsZS1yb3RhdGlvbiBtYW5wYWdl
IGl0IGlzIG1lbnRpb25lZCB0aGF0IHdlIHNob3VsZCBub3QgdXNlCj4gdHJhY2Ugcm90YXRlIHdo
ZW4gYXV0b21hdGljIHNlc3Npb24gcm90YXRlIGlzIGVuYWJsZWQuIENhbiB5b3UgcGxlYXNlIHRl
bGwgbWUKPiB3aHk/Cj4gYGBgCj4gSW1wb3J0YW50Cj4gWW91IG1heSBvbmx5IHVzZSB0aGUgZW5h
YmxlLXJvdGF0aW9uIGNvbW1hbmQgd2hlbjoKPiAqIFRoZSBzZWxlY3RlZCByZWNvcmRpbmcgc2Vz
c2lvbiB3YXMgY3JlYXRlZCBpbiBub3JtYWwgbW9kZSBvciBpbiBuZXR3b3JrCj4gc3RyZWFtaW5n
IG1vZGUKPiAoc2VlIGx0dG5nLWNyZWF0ZSgxKSkuCj4gKiBObyBjaGFubmVsIHdhcyBjcmVhdGVk
IHdpdGggYSBjb25maWd1cmVkIHRyYWNlIGZpbGUgY291bnQgb3Igc2l6ZSBsaW1pdCAoc2VlCj4g
dGhlCj4gLS10cmFjZWZpbGUtc2l6ZSBhbmQgLS10cmFjZWZpbGUtY291bnQgb3B0aW9ucyBvZiB0
aGUgbHR0bmctZW5hYmxlLWNoYW5uZWwoMSkKPiBjb21tYW5kKS4KPiBgYGAKCkhpLCAKClRoZSBy
ZWFzb24gbW9zdGx5IGJvaWxzIGRvd24gdG8gdGhlIGZhY3QgdGhhdCB3ZSBkaWRuJ3Qgc2VlIGEg
dXNlIGNhc2UgZm9yIHRoaXMuIEhlbmNlLCBpdCdzIG5vdCBpbXBsZW1lbnRlZCBub3IgdGVzdGVk
LiAKCkxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGEgdXNlIGNhc2UgZm9yIGNvbWJpbmluZyBib3Ro
IGZlYXR1cmVzLCB0aG91Z2guCgo+IDIuIFdoZW4gYXV0b21hdGljIHNlc3Npb24gcm90YXRlIGlz
IHJ1bm5pbmcsIGlzIHRoZXJlIGFueSByYWNlIGNvbmRpdGlvbiBpbgo+IHdyaXRpbmcgdGhlIGN1
cnJlbnQgcmluZyBidWZmZXJzIGFuZCBhcmNoaXZpbmcgdGhlIGN1cnJlbnQgdHJhY2UgY2h1bms/
CgpJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uLCBidXQgSSB0aGluayB5
b3UncmUgYXNraW5nIGlmIHNlc3Npb24gcm90YXRpb25zIGFyZSAiYXRvbWljIiB3aXRoIHJlc3Bl
Y3QgdG8gdGhlIHN3aXRjaG92ZXIgb2YgYWxsIHBlci1DUFUgc3RyZWFtcyBmcm9tIG9uZSB0cmFj
ZSBhcmNoaXZlIHRvIHRoZSBuZXh0PwoKVGhlIHN3aXRjaG92ZXIgaXMgbm90IGluc3RhbnRhbmVv
dXMuIFRoZSBmaWxlIG91dHB1dCBvZiBlYWNoIHBlci1DUFUgc3RyZWFtIGlzIHN3aXRjaGVkIHRv
IHRoZSBuZXcgdHJhY2UgYXJjaGl2ZSBzZXF1ZW50aWFsbHkuIFRoYXQgbGVhdmVzIHlvdSB3aXRo
IGEgd2luZG93IG9mIHRpbWUgZHVyaW5nIHdoaWNoIGluZm9ybWF0aW9uLCBmb3IgYSBnaXZlbiBz
dHJlYW0sIG1heSBiZSBmb3VuZCBpbiBlaXRoZXIgdGhlIG9sZCB0cmFjZSBhcmNoaXZlIG9yIHRo
ZSBuZXcgb25lLiBUbyBiZSBjbGVhciwgbm8gaW5mb3JtYXRpb24gaXMgZXZlciBkdXBsaWNhdGVk
IG9yIGxvc3QgZHVyaW5nIHRoaXMgb3BlcmF0aW9uLiAKCkkgYnJpZWZseSB0b3VjaGVkIG9uIHRo
aXMgdG9waWMgaW4gYSBwcmVzZW50YXRpb24gYXQgdGhlIE9wZW4gU291cmNlIFN1bW1pdCAyMDE4
LCBzZWUgc2xpZGUgMzIrWzFdCgpUaGUgdmFyaW91cyBjb2xvdXJzIHJlcHJlc2VudCBzdWNjZXNz
aXZlIHRyYWNlIGFyY2hpdmVzIHByb2R1Y2VkIGJ5IHNlc3Npb24gcm90YXRpb25zLgoKVGhpcyB0
cmFuc2l0aW9uIHdpbmRvdyBtYWtlcyB3cml0aW5nIGFuYWx5c2VzIGEgYml0IGhhcmRlciBzaW5j
ZSB0aGUgYmVnaW5uaW5nIGFuZCBlbmQgb2YgdHJhY2UgYXJjaGl2ZXMgbWF5IG5vdCBoYXZlIGFs
bCBvZiB0aGUgaW5mb3JtYXRpb24gZm9yIGFsbCBwZXItQ1BVIHN0cmVhbXMgZHVyaW5nIGEgc2hv
cnQgd2luZG93IG9mIHRpbWUuIFRoYXQgd2luZG93IGlzIGNvbnRhaW5lZCBiZXR3ZWVuIGlzc3Vp
bmcgdGhlIHJvdGF0aW9uIGFuZCByZWNlaXZpbmcgYSBjb25maXJtYXRpb24gdGhhdCBpdCBoYXMg
YmVlbiBjb21wbGV0ZWQgKHVzaW5nIHRoZSBDTEkgb3IgdGhlIGxpYmx0dG5nLWN0bCBBUEkpLiAK
CllvdSBjYW4gc2VlIHRoYXQgaW4gdGhhdCBjb250ZXh0LCBJIGNob3NlIHRvIHByb2Nlc3MgdHJh
Y2UgYXJjaGl2ZXMgaW4gcGFpcnMgdG8gY29uc3RpdHV0ZSBhbiAiZWZmZWN0aXZlIHRyYWNlIGFy
Y2hpdmUiIChzbGlkZSAzNCkgZHVyaW5nIHdoaWNoIEkgY2FuIGJlIHN1cmUgSSBhbHdheXMgaGF2
ZSBhY2Nlc3MgdG8gYWxsIGV2ZW50cyBmcm9tIGFsbCBwZXItQ1BVIHN0cmVhbXMuCgpUaGFua3Ms
CkrDqXLDqW1pZQoKWzFdIGh0dHBzOi8vZXZlbnRzMTkubGludXhmb3VuZGF0aW9uLm9yZy93cC1j
b250ZW50L3VwbG9hZHMvMjAxNy8xMi9GaW5lLWdyYWluZWQtRGlzdHJpYnV0ZWQtQXBwbGljYXRp
b24tTW9uaXRvcmluZy1Vc2luZy1MVFRuZy1KJUMzJUE5ciVDMyVBOW1pZS1HYWxhcm5lYXUtRWZm
aWNpT1MucGRmCgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gUmVnYXJkcywKPiBTdWJyYXRhIFBhdWwKCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
