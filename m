Return-Path: <SRS0=tJ4l=6I=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B5C54FD0
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Apr 2020 14:05:49 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5DB2075A
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Apr 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="jvb7bFpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5DB2075A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 497wtf5xpTz1k04;
	Fri, 24 Apr 2020 10:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1587737147;
	bh=fYJ+kDdEbKZMl8NR+n/PSXgo6mMnei47N/gosWoLl8w=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jvb7bFpQkoIrTHlMgj7gjVbWFKgXtQA7JRxtb3EofzzD8/i/1ljB4QPK2WmJoN8bp
	 awAkfel3D391JqlWgR56DSVWsoRwyiau6QJN5lVi3EcF+H9gwfx6LmVF5T5DyMdyfz
	 4jBrhFTtCU+GbGaJpv426MyZv4iy2Oqk6+AIpNeW8uJH7lxCEdLSK56j8hN8qgnNry
	 2vPTHVq9zcd9iQm+F71mWqIR23eHu2tPfuR47SHB2b/l8+dWKrdERPiPy0asDSyD+l
	 2ApPY93ckzuBO7UPxDEM0Y8I7eWFlMMW7on+oeAEYaYCXg4ptiy50VPVm+5/HdCa2m
	 ZFaYivHObhbSQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497wtf0JY9z1jlR
 for <lttng-dev@lists.lttng.org>; Fri, 24 Apr 2020 10:05:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 234C329163F;
 Fri, 24 Apr 2020 10:05:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id B8Ybb9Q44qjM; Fri, 24 Apr 2020 10:05:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B84892915A8;
 Fri, 24 Apr 2020 10:05:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B84892915A8
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Z06koQ1IqsCz; Fri, 24 Apr 2020 10:05:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A8D9C29163E;
 Fri, 24 Apr 2020 10:05:38 -0400 (EDT)
Date: Fri, 24 Apr 2020 10:05:38 -0400 (EDT)
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Message-ID: <1018622507.68153.1587737138598.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+jJMxvqe5sYq3f7kDMthTfiC7oNR1Awok-R2CdKJgRHowuXTA@mail.gmail.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
 <CA+jJMxvqe5sYq3f7kDMthTfiC7oNR1Awok-R2CdKJgRHowuXTA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: Clarify that unlisted enum values are implementation-defined
Thread-Index: xL5JumekEdcXBBiHkYu7XS8USK+Yig==
Subject: Re: [lttng-dev] [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.29
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
Cc: diamon-discuss <diamon-discuss@linuxfoundation.org>,
 Jeremie Galarneau <jgalar@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>,
 Philippe Proulx <pproulx@efficios.com>,
 Genevieve Bastien <gbastien+lttng@versatic.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200424140538.fJBiiwrjs2g3aPX1wUlKfmbNAZ-CiitHYRYSTuaMrok@z>

LS0tLS0gT24gQXByIDIzLCAyMDIwLCBhdCA2OjUxIFBNLCBKZXJlbWllIEdhbGFybmVhdSBqZXJl
bWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IE9uIFRodSwgMjMgQXByIDIwMjAg
YXQgMTY6NTIsIE1hdGhpZXUgRGVzbm95ZXJzCj4gPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4gd3JvdGU6Cj4+Cj4+IEZyb206IEdlbmV2acOodmUgQmFzdGllbiA8Z2Jhc3RpZW4rbHR0
bmdAdmVyc2F0aWMubmV0Pgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4g
PGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4KPj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBE
ZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPj4gLS0tCj4+ICBjb21t
b24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvY29tbW9uLXRyYWNlLWZvcm1h
dC1zcGVjaWZpY2F0aW9uLm1kCj4+IGIvY29tbW9uLXRyYWNlLWZvcm1hdC1zcGVjaWZpY2F0aW9u
Lm1kCj4+IGluZGV4IGZkNDllNTkuLmY1ZmVhNTEgMTAwNjQ0Cj4+IC0tLSBhL2NvbW1vbi10cmFj
ZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZAo+PiArKysgYi9jb21tb24tdHJhY2UtZm9ybWF0LXNw
ZWNpZmljYXRpb24ubWQKPj4gQEAgLTQ2NCw2ICs0NjQsOSBAQCBlbnVtIHsKPj4gIH0KPj4gIH5+
fgo+Pgo+PiArVGhlIG1hcHBpbmdzIGluIHRoZSBlbnVtZXJhdGlvbiB0eXBlIGRvIG5vdCBoYXZl
IHRvIGJlIGV4aGF1c3RpdmUuCj4+ICtVbmxpc3RlZCB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9u
IGRlZmluZWQuCj4+ICsKPiAKPiBUaGlzIGlzIHRvbyB2YWd1ZSB0byBiZSB1c2VmdWwga25vd2lu
ZyB0aGF0IHRoZSBtYWluIHJhdGlvbmFsZSBmb3IgdGhpcwo+IGNoYW5nZSBpcyB0byBhbGxvdyBl
bnVtcyB0byBleHByZXNzIHNvbWUgdHlwZSBvZiBiaXRmaWVsZCBvZiBmbGFncwo+IGluIHRoZSB0
cmFjZXIgYW5kIHJlYWRlcnMgWzFdLgo+IAo+IFdoYXQgaXMgdGhlIG1lYW5pbmcgb2YgYW4gdW5t
YXBwZWQgdmFsdWU/IFRoaXMgc2VjdGlvbiBzaG91bGQgYXQKPiBsZWFzdCBkZXNjcmliZSB0aGUg
Y29ycmVjdCBpbnRlcnByZXRhdGlvbiBvZiB1bm1hcHBlZCB2YWx1ZXMgYXMgZmxhZ3MKPiBhbmQg
d2hlbiBpdCBpcyBhcHByb3ByaWF0ZSB0byBkbyBzby4KCkNvbnNpZGVyaW5nIHRoYXQgdGhpcyBp
cyBhIHBhdGNobGV2ZWwgdXBkYXRlIHRvIENURiwgSSB3b3VsZCBub3QgZXhwZWN0CnRoYXQgd2Ug
aW50cm9kdWNlIG5ldyBmZWF0dXJlcyBpbiB0aGUgc3BlY2lmaWNhdGlvbi4gT25seSBjbGFyaWZp
Y2F0aW9ucwp0byBwYXJ0cyBvZiB0aGUgc3BlY2lmaWNhdGlvbiB0aGF0IHdlcmUgdW5jbGVhci4K
ClNwZWNpZnlpbmcgYSBuZXcgYmVoYXZpb3IgcmVsYXRlZCB0byB1bm1hcHBlZCB2YWx1ZXMgd291
bGQgZmFsbCBJTU8gaW50byB0aGUKcmVhbG0gb2YgIm5ldyBmZWF0dXJlIiwgYW5kIHdvdWxkIGJl
bG9uZyB0byBhIENURiAxLjkgb3IgQ1RGIDIuMC4gQXMgd2UKYWxsIGtub3csIHRoZXJlIGlzIGEg
Q1RGIDIuMCBpbiB0aGUgbWFraW5nLCBidXQgaXQgZG9lcyBub3Qgc29sdmUgdGhlCmltbWVkaWF0
ZSBwcm9ibGVtIG9mIExUVG5nIDIuMTIgd2hpY2ggcHJvZHVjZXMgdGhvc2UgdW5tYXBwZWQgZW51
bSB2YWx1ZXMKd2l0aGluIHRyYWNlcyBpZGVudGlmaWVkIGFzIENURiAxLjguCgpNb3Jlb3Zlciwg
dG8gYWRkIHRvIHRoZSBwcm9ibGVtLCBCYWJlbHRyYWNlIDIgaGFzIGEgc3RyaWN0IG1hdGNoIG9u
IENURiAxLjgKaW4gdGhlIENURiBzb3VyY2UgcGx1Z2luLCBhbmQgd29uJ3QgYWNjZXB0IGEgQ1RG
IDEuOSB0cmFjZSAodW5saWtlIEJhYmVsdHJhY2UgMQp3aGljaCB3b3VsZCBlbWl0IGEgd2Fybmlu
ZyBhYm91dCBwb3NzaWJseSB1bnN1cHBvcnRlZCBmZWF0dXJlcywgYnV0IHdvdWxkIGFjY2VwdAph
IDEuOSBDVEYgdHJhY2UgbmV2ZXJ0aGVsZXNzKS4KClNvIHRoaXMgaXMgd2h5IEkgYW0gcHJvcG9z
aW5nIHRoaXMgbWluaW1hbCBjbGFyaWZpY2F0aW9uIHRvIHRoZSBDVEYgMS44CnNwZWNpZmljYXRp
b246IHRoYXQgdW5tYXBwZWQgZW51bSB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9uIGRlZmluZWQg
KHJhdGhlcgp0aGFuIHNheWluZyBub3RoaW5nIGFib3V0IHRoZW0pLiBDb25zaWRlcmluZyB0aGF0
IHRyYWNlcnMgY2FuIGdlbmVyYXRlIHRoaXMKa2luZCBvZiB0cmFjZSBkYXRhIGFueXdheSwgaXQn
cyByZWFsbHkgYSBjb25zaWRlcmF0aW9uIHRoYXQgc2hvdWxkIGhhdmUgYmVlbgpleHBsaWNpdGx5
IGV4cHJlc3NlZCBpbiB0aGUgc3BlY2lmaWNhdGlvbiBmcm9tIHRoZSBzdGFydCBhbmQgd2FzIGFu
Cmludm9sdW50YXJ5IG9taXNzaW9uLgoKU28gcGVyaGFwcyB3ZSBuZWVkIHRvIHN0YXRlIHNvbWV0
aGluZyBtb3JlIHRoYW4ganVzdCAiaW1wbGVtZW50YXRpb24gZGVmaW5lZCIsCmJ1dCBpdCdzIHVu
Y2xlYXIgd2hhdCB3aXRob3V0IGVuZGluZyB1cCBhZGRpbmcgZmVhdHVyZXMgaW50byBhIHBhdGNo
bGV2ZWwKdXBkYXRlLgoKVGhhbmtzLAoKTWF0aGlldQoKCj4gVGhhbmtzLAo+IErDqXLDqW1pZQo+
IAo+IFsxXSBodHRwczovL3Jldmlldy5sdHRuZy5vcmcvYy9iYWJlbHRyYWNlLysvMzA0NQo+IAo+
PiAgIyMjIDQuMiBDb21wb3VuZCB0eXBlcwo+Pgo+PiAgQ29tcG91bmQgYXJlIGFnZ3JlZ2F0aW9u
IG9mIHR5cGUgZGVjbGFyYXRpb25zLiBDb21wb3VuZCB0eXBlcyBpbmNsdWRlCj4+IC0tCj4+IDIu
MTEuMAo+Pgo+IAo+IAo+IC0tCj4gSsOpcsOpbWllIEdhbGFybmVhdQo+IEVmZmljaU9TIEluYy4K
PiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
