Return-Path: <SRS0=1TmG=JM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757EC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 13:04:24 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873EF610CE
	for <lttng-dev@archiver.kernel.org>; Thu, 15 Apr 2021 13:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873EF610CE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FLfgT4WvTz1BLl;
	Thu, 15 Apr 2021 09:04:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618491862;
	bh=rzYNvQD/vihfMVkXn4v/RQYiXanEdOveUhz3Z9OYoB4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RLoaYfXa4t18VgkMCvVCmKHV99jXxvo9PU8GDGuu8whKf27gtO9Y5uUflrx/IGjKm
	 lL/iAO1nWqsnZQHMy50VFiIBL901wCxVcFOpo4f8JWpiEynBrs4g3vG8ALiR0l7rw2
	 ZRSEVwyXK77J+PAf+hfCLG6PxkYp+nmKkfjhRawHyGQVHHCGaDSI88CiL2hTZ1CeMB
	 84u1/gWF7bponwtf0lh2lhidly3IvLoqu1S13t52Su9sfwn/+ilZAWkS6OJgsEHfNB
	 Vnn5SCDzDGr+n5SbuLpVNEMT9uEtJpswHFZsnalXSCynTzM3hYVUXZm5SYKk9sBMVw
	 BEfTEWzeEaTFg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FLfgS4Yn6z1B6V
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 09:04:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B37332C44D
 for <lttng-dev@lists.lttng.org>; Thu, 15 Apr 2021 09:04:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mIba8ZgsO3Dv; Thu, 15 Apr 2021 09:04:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3821532C44B;
 Thu, 15 Apr 2021 09:04:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3821532C44B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BM0S7ut9ogJ4; Thu, 15 Apr 2021 09:04:13 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2F24332C44A;
 Thu, 15 Apr 2021 09:04:13 -0400 (EDT)
Date: Thu, 15 Apr 2021 09:04:13 -0400 (EDT)
To: lbj <lbj137@yahoo.com>
Cc: paulmck <paulmck@kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <412098958.77686.1618491853089.JavaMail.zimbra@efficios.com>
In-Reply-To: <EDFC028D-682A-433F-9FBD-59617058829D@yahoo.com>
References: <1791312961.77601.1618489242390.JavaMail.zimbra@efficios.com>
 <EDFC028D-682A-433F-9FBD-59617058829D@yahoo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: QSBR urcu read lock question
Thread-Index: NeL369EeTe9nBBxHnsXTI/oEJPPZ/w==
Subject: Re: [lttng-dev] QSBR urcu read lock question
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gQXByIDE1LCAyMDIxLCBhdCA4OjQxIEFNLCBsYmogbGJqMTM3QHlhaG9vLmNvbSB3
cm90ZToKCj4gSGkgTWF0aGlldSwKPiBXaGVuIEkgc2F5IOKAnHJlY2xhbWF0aW9uIHRocmVhZOKA
nSBJIGRvIG1lYW4gdGhlIHRocmVhZCBsYXVuY2hlZCBieSBjYWxsX3JjdSB0aGF0Cj4gaXMgdHlw
aWNhbGx5IHJlc3BvbnNpYmxlIGZvciBtZW1vcnkgZGVhbGxvY2F0aW9ucy4gSXMgaXMgcG9zc2li
bGUvcmVjb21tZW5kZWQKPiB0byByZWdpc3RlciBmb3IgcmN1IGFuZCB0aGVuIHRha2UgYW4gcmN1
LXJlYWRlciBsb2NrIGluIHN1Y2ggYSB0aHJlYWQ/IFRoYXQgaXMKPiBteSBtYWluIHF1ZXN0aW9u
Lgo+IAo+IEFzIGZvciByZWFkZXIgbG9ja3MgYmVpbmcgbm8tb3BzIGluIFFTQlIsIEkgcmVhZCB0
aGF0IGJ1dCBkb250IHF1aXRlIHVuZGVyc3RhbmQKPiBpdC4gU29tZXRoaW5nIG11c3QgYmUgcHJl
dmVudGluZyBtZW1vcnkgcmVjbGFtYXRpb24gb2YgcmN1IHByb3RlY3RlZCBlbGVtZW50cwo+IHdo
ZW4gSSB0YWtlIHRoYXQgbG9jay4KCk5vdGUgdGhhdCBhIFJDVSByZWFkLXNpZGUgImxvY2siIGlz
IHJlYWxseSBqdXN0IGEgbWFya2VyIGFib3V0IHRoZSBiZWdpbm5pbmcvZW5kCm9mIGEgdHJhbnNh
Y3Rpb24gd2hpY2ggZGVsYXlzIGdyYWNlIHBlcmlvZHMuIFdlIHVzZSB0aGUgbmFtZSAibG9jayIg
dG8gbWF0Y2gKdGhlIGtlcm5lbCBSQ1UgQVBJcywgYnV0IGl0IHNob3VsZCBub3QgYmUgY29uc2lk
ZXJlZCBhcyBkb2luZyBhbnkga2luZCBvZiBtdXR1YWwKZXhjbHVzaW9uLgoKPiAKPiBNeSBzcGVj
aWZpYyBzaXR1YXRpb24gaXM6IEkgaGF2ZSBhIFFTQlIgcmN1IHByb3RlY3RlZCDigJxwb2xpY3ni
gJ0gb2JqZWN0IChqdXN0IGEKPiByZWd1bGFyIG9sZCBDKysgb2JqZWN0IHRoYXQgcGVyaW9kaWNh
bGx5IGdldHMgcmVmcmVzaGVkIGFuZCBtdXN0IGJlIGF0b21pY2FsbHkKPiB1cGRhdGVkIGJlY2F1
c2Ugd29ya2VyIGNvcmVzIGFyZSByZWFkaW5nIGl0IHdoaWxlIHNwaW5uaW5nLCBhbmQgdGhleSBj
YW50IHNsb3cKPiBkb3duKS4gV2hlbiBhIG5ldyBwb2xpY3kgaXMgcmVjZWl2ZWQgd2UgaW52b2tl
IGNhbGxfcmN1IG9uIHRoZSBvbGQgcG9saWN5Lgo+IGNhbGxfcmN1IHdpbGwgZXZlbnR1YWxseSBs
YXVuY2ggYSB0aHJlYWQgaW4gd2hpY2ggdGhlIG9sZCBwb2xpY3nigJlzIHJlc291cmNlcwo+IGFy
ZSByZWNsYWltZWQuIEluIHRoaXMgdGhyZWFkIEkgd291bGQgbGlrZSB0byBpdGVyYXRlIHRocm91
Z2ggYW5vdGhlciwgc2VwYXJhdGUKPiBzdHJ1Y3R1cmUsIHdoaWNoIGlzIGFsc28gUVNCUiByY3Ug
cHJvdGVjdGVkIChhIHVyY3UgaGFzaHRhYmxlKS4gVG8gZG8gc28KPiBzYWZlbHksIHByZXN1bWFi
bHkgSSBtdXN0IHVzZSBhbiByY3UgcmVhZGxvY2suIEkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSBz
dWNoIGEKPiBzY2VuYXJpbyBpcyByZWFzb25hYmxlIGFuZCBhdCB2ZXJ5IGxlYXN0IG5vdCBjb250
cmEtaW5kaWNhdGVkLiBUaGFua3MhCgpJZiB5b3UgbG9vayBhdCB1cmN1LWNhbGwtcmN1LWltcGwu
aCwgeW91IHdpbGwgbm90aWNlIHRoYXQgY2FsbF9yY3VfdGhyZWFkKCkKaW5kZWVkIHJlZ2lzdGVy
cyBpdHNlbGYgYXMgYSByZWFkZXIgdGhyZWFkLgoKU28gdGhlIGNhbGwtcmN1IGNhbGxiYWNrcyBj
YW4gaW5kZWVkIHRha2UgYSBSQ1UgcmVhZC1zaWRlIGxvY2ssIGJ1dCBmb3IgUVNCUgp0aGUgc3Rv
cnkgZG9lcyBub3QgZW5kIHRoZXJlLCBiZWNhdXNlIGR1ZSB0byB0aGUgbmF0dXJlIG9mIFFTQlIs
IHRoZSByZWFkLXNpZGUKbG9jayBpcyBpbmRlZWQgYSBuby1vcCwgYW5kIGl0IHJlbGllcyBpbnN0
ZWFkIG9uIGFsbCByZWdpc3RlcmVkIFFTQlIgcmVhZGVyCnRocmVhZHMgdG8gcGVyaW9kaWNhbGx5
IGludm9rZSB1cmN1X3FzYnJfcXVpZXNjZW50X3N0YXRlKCkgdG8gcmVwb3J0IHRoYXQgdGhleQph
cmUgaW4gYSBxdWllc2NlbnQgc3RhdGUsIG9yIGludm9rZSB1cmN1X3FzYnJfdGhyZWFkX29mZmxp
bmUoKSBpZiB0aGV5IGV4cGVjdCB0byBiZQppbiBhIHF1aWVzY2VudCBzdGF0ZSBmb3IgYSBsb25n
IHBlcmlvZCBvZiB0aW1lIChlLmcuIGJsb2NraW5nKSwgZm9sbG93ZWQgYnkKdXJjdV9xc2JyX3Ro
cmVhZF9vbmxpbmUoKS4KCkFuZCBpbmRlZWQsIHRoZSBjYWxsX3JjdV90aHJlYWQgcHV0cyBpdHNl
bGYgaW4gIm9mZmxpbmUiIG1vZGUgd2hpbGUgYXdhaXRpbmcgZm9yCmdyYWNlIHBlcmlvZHMgKHRo
aXMgaXMgaW1wbGljaXRseSBkb25lIHdpdGhpbiB0aGUgcXNiciBzeW5jaHJvbml6ZV9yY3UoKSBp
bXBsZW1lbnRhdGlvbikKYW5kIHdoZW4gc2xlZXBpbmcuCgpTbyB5ZXMsIHlvdSBzaG91bGQgYmUg
YWJsZSB0byBoYXZlIGEgUkNVIHJlYWQtc2lkZSBmcm9tIHdpdGhpbiBhIGNhbGwtcmN1IHdvcmtl
cgp0aHJlYWQsIGFuZCBpdCdzIE9LIHRvIGFzc3VtZSB5b3UgY2FuIGRvIGEgUkNVIHRyYXZlcnNh
bCB3aXRoIHRoZSBRU0JSIHVyY3UgZmxhdm9yCmZyb20gYSBjYWxsLXJjdSB3b3JrZXIgdGhyZWFk
IGFzIHdlbGwuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IEplZmYKPiAKPiAKPiAKPiBTZW50IGZy
b20gbXkgaVBob25lCj4gCj4+IE9uIEFwciAxNSwgMjAyMSwgYXQgODoyMCBBTSwgTWF0aGlldSBE
ZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPj4gd3JvdGU6Cj4+IAo+
PiDvu78tLS0tLSBPbiBBcHIgMTMsIDIwMjEsIGF0IDExOjE5IFBNLCBsdHRuZy1kZXYgbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZyB3cm90ZToKPj4gCj4+PiBIZWxsbyBhbGwsCj4+PiAKPj4+IEkg
aGF2ZSB0d28gZGlmZmVyZW50IGVudGl0aWVzIHRoYXQgYXJlIGJvdGggcHJvdGVjdGVkIGJ5IFFT
QlIgcmN1OiBhIHBvbGljeSBhbmQKPj4+IGEgaGFzaHRhYmxlLiBJbiB0aGUgcmVjbGFtYXRpb24g
dGhyZWFkIGZvciB0aGUgcG9saWN5IEkgd291bGQgbGlrZSB0byB0YWtlIGEKPj4+IHJlYWQgbG9j
ayBzbyB0aGF0IEkgY2FuIHNhZmVseSBpdGVyYXRlIHRocm91Z2ggdGhlIGhhc2h0YWJsZS4gSSBk
b250IHNlZQo+Pj4gYW55dGhpbmcgd3Jvbmcgd2l0aCB0aGlzLCBidXQgSSBqdXN0IHdhbnRlZCB0
byBtYWtlIHN1cmUgaXQgd2FzIG9rIHNpbmNlIHRha2luZwo+Pj4gYW4gcmN1IHJlYWQgbG9jayBp
biBhbiByY3UgcmVjbGFtYXRpb24gdGhyZWFkIHNlZW1zIGxpa2UgaXQgbWF5IGJlIGEgYml0Cj4+
PiBzdXNwZWN0LiBUaGFua3MgZm9yIGFueSBpbnNpZ2h0cywgbGV0IG1lIGtub3cgaWYgY2xhcmlm
aWNhdGlvbiBpcyBuZWVkZWQhCj4+IAo+PiBXaGVuIHlvdSBzYXkgInRoZSByZWNsYW1hdGlvbiB0
aHJlYWQgZm9yIHRoZSBwb2xpY3kiLCBkbyB5b3UgcmVmZXIgdG8gYSBjYWxsLXJjdQo+PiB3b3Jr
ZXIgdGhyZWFkID8KPj4gCj4+IEFsc28sIHlvdSBhcmUgYXdhcmUgdGhhdCBSQ1UgcmVhZC1zaWRl
IGxvY2svdW5sb2NrIGFyZSBlZmZlY3RpdmVseSBuby1vcHMgZm9yCj4+IFFTQlIgcmN1LCByaWdo
dCA/Cj4+IAo+PiBUaGFua3MsCj4+IAo+PiBNYXRoaWV1Cj4+IAo+PiAtLQo+PiBNYXRoaWV1IERl
c25veWVycwo+PiBFZmZpY2lPUyBJbmMuCj4gPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
