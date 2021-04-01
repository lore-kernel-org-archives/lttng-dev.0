Return-Path: <SRS0=VMqU=I6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B166C433ED
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:21:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ABC6137F
	for <lttng-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ABC6137F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FB7jN13pgzT1r;
	Thu,  1 Apr 2021 12:21:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617294088;
	bh=ijs8Q4swjfEfYZ57P8+KsbXOm5IztDV3/du7Tn9PwR0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MTPdygrtn28GI2pKdnNJ/PgAtQcXgAsUq9b33a8Vsp6mqksyxP/Xrw1xuZ8L3ylJF
	 ievIKRKboFaEYo+fGGuwDnGxdkOqPwtA2BaghqRpt1nF7z8ng7Vd74Hu+vWj5rmTXg
	 t8tiTzqasrGcpe2ep8/90RvfNzxxtxc8yK4nRk6FPCBxEdh6jcT5rkPSoalcj7J22f
	 q/tiKDFtOvfbCnf9H9mnIWxRIlDNT9WmK+VaDnII0qxfd4SMV67seMeq879XTpTxG7
	 C7/DWT5B5mm2XS6Oz2XPpPwNQvpj73FoGmsVHdzR4moraY3xTzNpo5Kvb51pY3AO7G
	 0jST+NF0SlQPw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FB7jL4vF7zT7s
 for <lttng-dev@lists.lttng.org>; Thu,  1 Apr 2021 12:21:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 767D42B2D9B;
 Thu,  1 Apr 2021 12:21:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id pGm3esk2qH80; Thu,  1 Apr 2021 12:21:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1960C2B2BE1;
 Thu,  1 Apr 2021 12:21:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1960C2B2BE1
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id k5Fyy0adE5EM; Thu,  1 Apr 2021 12:21:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0D3F52B285F;
 Thu,  1 Apr 2021 12:21:20 -0400 (EDT)
Date: Thu, 1 Apr 2021 12:21:20 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anders Wallin <wallinux@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>, 
 Jeremie Galarneau <jgalar@efficios.com>
Message-ID: <1789853155.51246.1617294080020.JavaMail.zimbra@efficios.com>
In-Reply-To: <1708925974.51224.1617293982339.JavaMail.zimbra@efficios.com>
References: <20210331185624.406960-1-wallinux@gmail.com>
 <1708925974.51224.1617293982339.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: test code assumes that child process is schedule to run before
 parent
Thread-Index: Y+O+t91Nkj6egFP+44Ih2zZDUXt4n7662Yfb
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes that
 child process is schedule to run before parent
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

LS0tLS0gT24gQXByIDEsIDIwMjEsIGF0IDEyOjE5IFBNLCBsdHRuZy1kZXYgbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZyB3cm90ZToKCj4gLS0tLS0gT24gTWFyIDMxLCAyMDIxLCBhdCAyOjU2IFBN
LCBsdHRuZy1kZXYgbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyB3cm90ZToKPiAKPj4gdGhlIGZv
bGxvd2luZyB0ZXN0cyBmYWlscyBvbiBhcm02NAo+PiAtIHRlc3RfZXZlbnRfdnBpZF90cmFja2Vy
IHVzdCAwICIke0VWRU5UX05BTUV9Igo+PiAtIHRlc3RfZXZlbnRfdnBpZF90cmFja191bnRyYWNr
IHVzdCAwICIke0VWRU5UX05BTUV9Igo+PiAtIHRlc3RfZXZlbnRfcGlkX3RyYWNrZXIgdXN0IDAg
IiR7RVZFTlRfTkFNRX0iCj4+IC0gdGVzdF9ldmVudF9waWRfdHJhY2tfdW50cmFjayB1c3QgMCAi
JHtFVkVOVF9OQU1FfSIKPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBXYWxsaW4gPHdhbGxp
bnV4QGdtYWlsLmNvbT4KPj4gLS0tCj4+IHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvdHJhY2tlci90
ZXN0X2V2ZW50X3RyYWNrZXIgfCA0ICsrKy0KPj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24v
dG9vbHMvdHJhY2tlci90ZXN0X2V2ZW50X3RyYWNrZXIKPj4gYi90ZXN0cy9yZWdyZXNzaW9uL3Rv
b2xzL3RyYWNrZXIvdGVzdF9ldmVudF90cmFja2VyCj4+IGluZGV4IDcxMTY5MGFmLi42NDljN2U2
MSAxMDA3NTUKPj4gLS0tIGEvdGVzdHMvcmVncmVzc2lvbi90b29scy90cmFja2VyL3Rlc3RfZXZl
bnRfdHJhY2tlcgo+PiArKysgYi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNrZXIvdGVzdF9l
dmVudF90cmFja2VyCj4+IEBAIC01LDcgKzUsNyBAQAo+PiAjCj4+ICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seQo+PiAKPj4gLVRFU1RfREVTQz0iTFRUbmcgLSBFdmVudCB0
cmFrZXIgdGVzdCIKPj4gK1RFU1RfREVTQz0iTFRUbmcgLSBFdmVudCB0cmFja2VyIHRlc3QiCj4+
IAo+PiBDVVJESVI9JChkaXJuYW1lICIkMCIpLwo+PiBURVNURElSPSIkQ1VSRElSLy4uLy4uLy4u
Igo+PiBAQCAtNDIsNiArNDIsOCBAQCBmdW5jdGlvbiBwcmVwYXJlX3VzdF9hcHAKPj4gCj4+IAkk
VEVTVEFQUF9CSU4gLWkgJE5SX0lURVIgLXcgJE5SX1VTRUNfV0FJVCAtYSAiJEFGVEVSX0ZJUlNU
X1BBVEgiIC1iCj4+IAkiJEJFRk9SRV9MQVNUX1BBVEgiICYKPj4gCUNISUxEX1BJRD0kIQo+PiAr
CSMgdm9sdW50YXJ5IGNvbnRleHQgc3dpdGNoIHRvIHN0YXJ0ICRURVNUQVBQX0JJTgo+PiArCXNs
ZWVwIDAuMQo+IAo+IE5vLCB3ZSBoYXZlIGJlZW4gYml0dGVuIGFnYWluIGFuZCBhZ2FpbiBieSB0
ZXN0IGlzc3VlcyBoaWRkZW4gYnkgc2xlZXBzIGluIHRoZQo+IHRlc3QgY29kZS4gVXNpbmcgc2xl
ZXBzIGZvciBzeW5jaHJvbml6YXRpb24gaXMgZmxha3kuCj4gCj4gSSBkb24ndCBrbm93IGlmIHdl
IGRvY3VtZW50ZWQgaXQsIGJ1dCB3ZSBhcyBtYWludGFpbmVycyBhcmUgc3Ryb25nbHkgYWdhaW5z
dAo+IGFueXRoaW5nIHRoYXQgbG9va3MgbGlrZSBhIGRlbGF5LWJhc2VkIGFwcHJvYWNoIHRvIGZp
eGluZyBhIHJhY2UgaW4gdGhlIHRlc3RzLgo+IFRoaXMgdHlwaWNhbGx5IGp1c3QgYnVyeSB0aGUg
cmFjZSB1bmRlciB0aGUgY2FycGV0IGFuZCBpdCBzaG93cyB1cCBvbmx5IGluCj4gc3BlY2lmaWMg
Y29uZGl0aW9ucyBvbiB0aGUgQ0kgd29ya2Vycy4KPiAKPiBXZSBuZWVkIHRvIGFkZCBwcm9wZXIg
cmVuZGV6LXZvdXMgYmFzZWQgc3luY2hyb25pemF0aW9uIHRvIHRoZSB0ZXN0IGlmIHNvbWUKPiBp
cyBtaXNzaW5nLgo+IAo+IEFkZGluZyBKw6lyw6ltaWUgaW4gQ0MuCgpBbmQgdGhlbiBJIHJlYWQg
b24gdGhlIHJlc3Qgb2YgdGhlIGVtYWlsIHRocmVhZC4uLiBzbyBpdCdzIGJlaW5nIHRha2VuIGNh
cmUgb2YsIGdvb2QhIDopCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IFRoYW5rcywKPiAKPiBNYXRo
aWV1Cj4gCj4gCj4+IH0KPj4gCj4+IGZ1bmN0aW9uIHRyYWNlX3VzdF9hcHAKPj4gLS0KPj4gMi4z
MS4xCj4+IAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
Pj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo+IAo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4gaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
