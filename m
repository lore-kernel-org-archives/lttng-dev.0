Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB452C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679409843;
	bh=M7WnIWALq0tlTjELn9HhTwndS1RhiW8vNe2X7z/JwrE=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bT1TY2IecDK4QUvLYGQD7n1dDq6vKPQ1R6VwtUER2vuxaoV8c+eHz3HX+7yWYUQCC
	 RUnkM9kQ8oRD5QunNzQ1sf0u9EiCH9rGE9VLz5QTnq2JhotFObNnCtPfLfuKHx0C4R
	 qpree8PZBFFBF7UdTb9PBAoQoeVjPkRNW/UrMnUWeFeJUadcCj1Z1sd4pgJQvQudTR
	 4/vGxJS4HEz9arG4nLVYiBAI7BObzosew7HHZc0MVA50QEEiN4Lhnw44+5AjtE950o
	 5kWd4od99OKJp2nz16/rxIQxQovOy1EcD214OgbRQHzGap8IQ/zHO3tHiGzBig/XYp
	 o/RU6nEwSZO7w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgvW6706pz2HKC;
	Tue, 21 Mar 2023 10:44:02 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgvW51DFyz2H78
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:44:01 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgvW44MTYzqrq;
 Tue, 21 Mar 2023 10:44:00 -0400 (EDT)
Message-ID: <b4b783ec-6d57-e658-7ac9-84e5a996b8b3@efficios.com>
Date: Tue, 21 Mar 2023 10:44:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-7-ondrej@sury.org>
 <9aad8537-6053-7d30-6575-8986c46ce607@efficios.com>
 <25F238AC-69EB-47BB-BEAF-B513C44B652E@sury.org>
In-Reply-To: <25F238AC-69EB-47BB-BEAF-B513C44B652E@sury.org>
Subject: Re: [lttng-dev] [PATCH 6/7] Fix: uatomic_or() need retyping to
 uintptr_t in rculfhash.c
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wMy0yMSAwNjoxNSwgT25kxZllaiBTdXLDvSB3cm90ZToKPiAKPj4gT24gMjAuIDMu
IDIwMjMsIGF0IDE5OjMxLCBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZm
aWNpb3MuY29tPiB3cm90ZToKPj4KPj4gT24gMjAyMy0wMy0xNyAxNzozNywgT25kxZllaiBTdXLD
vSB2aWEgbHR0bmctZGV2IHdyb3RlOgo+Pj4gV2hlbiBhZGRpbmcgUkVNT1ZFRF9GTEFHIHRvIHRo
ZSBwb2ludGVycyBpbiB0aGUgcmN1bGZoYXNoCj4+PiBpbXBsZW1lbnRhdGlvbiwgcmV0eXBlIHRo
ZSBnZW5lcmljIHBvaW50ZXIgdG8gdWludHB0cl90IHRvIGZpeCB0aGUKPj4+IGNvbXBpbGVyIGVy
cm9yLgo+Pgo+PiBXaGF0IGlzIHRoZSBjb21waWxlciBlcnJvciA/IEknbSB3b25kZXJpbmcgd2hl
dGhlciB0aGUgZXhwZWN0ZWQgY2hvaWNlCj4+IHRvIG1hdGNoIHRoZSByZXN0IG9mIHRoaXMgZmls
ZSdzIGNvbnRlbnQgd291bGQgYmUgdG8gdXNlICJ1aW50cHRyX3QgKiIgb3IgInVuc2lnbmVkIGxv
bmcgKiIgPwo+IAo+IFRoaXMgaXMgdGhlIGVycm9yOgo+IAo+IHJjdWxmaGFzaC5jOjEyMDE6Mjog
ZXJyb3I6IGFkZHJlc3MgYXJndW1lbnQgdG8gYXRvbWljIG9wZXJhdGlvbiBtdXN0IGJlIGEgcG9p
bnRlciB0byBpbnRlZ2VyICgnc3RydWN0IGNkc19sZmh0X25vZGUgKionIGludmFsaWQpCj4gICAg
ICAgICAgdWF0b21pY19vcigmbm9kZS0+bmV4dCwgUkVNT1ZFRF9GTEFHKTsKPiAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gLi4vaW5jbHVkZS91cmN1L3Vh
dG9taWMuaDo2MDo4OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICd1YXRvbWljX29yJwo+ICAg
ICAgICAgICh2b2lkKV9fYXRvbWljX29yX2ZldGNoKChhZGRyKSwgKG1hc2spLCBfX0FUT01JQ19S
RUxBWEVEKQo+ICAgICAgICAgICAgICAgIF4gICAgICAgICAgICAgICAgIH5+fn5+fgo+IHJjdWxm
aGFzaC5jOjE0NDQ6MzogZXJyb3I6IGFkZHJlc3MgYXJndW1lbnQgdG8gYXRvbWljIG9wZXJhdGlv
biBtdXN0IGJlIGEgcG9pbnRlciB0byBpbnRlZ2VyICgnc3RydWN0IGNkc19sZmh0X25vZGUgKion
IGludmFsaWQpCj4gICAgICAgICAgICAgICAgICB1YXRvbWljX29yKCZmaW5pX2J1Y2tldC0+bmV4
dCwgUkVNT1ZFRF9GTEFHKTsKPiAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gLi4vaW5jbHVkZS91cmN1L3VhdG9taWMuaDo2MDo4
OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICd1YXRvbWljX29yJwo+ICAgICAgICAgICh2b2lk
KV9fYXRvbWljX29yX2ZldGNoKChhZGRyKSwgKG1hc2spLCBfX0FUT01JQ19SRUxBWEVEKQo+ICAg
ICAgICAgICAgICAgIF4gICAgICAgICAgICAgICAgIH5+fn5+fgo+IAo+IHVpbnRwdHJfdCBpcyBk
ZWZpbmVkIGFzICJ1bnNpZ25lZCBpbnRlZ2VyIHR5cGUgY2FwYWJsZSBvZiBob2xkaW5nIGEgcG9p
bnRlciB0byB2b2lkIiB3aGlsZSB1bnNpZ25lZCBsb25nIGlzIGF0IGxlYXN0IDMyLWJpdDsKPiAK
PiBJIGd1ZXNzIHRoYXQgd29ya3MgaW4gYSBwcmFjdGlzZSwgYnV0IHVzaW5nIHVuc2lnbmVkIGxv
bmcgdG8gcmV0eXBlIHRoZSBwb2ludGVycyBtaWdodCBibG93IHVwICh0aGlua2luZyBvZiB4MzIg
d2hpY2ggSSBrbm93Cj4gbGl0dGxlIGFib3V0LCBidXQgaXQncyBraW5kIG9mIGh5YnJpZCBhcmNo
aXRlY3R1cmUsIGlzbid0IGl0PykKCngzMiB1c2VzIDQgYnl0ZXMgZm9yIHVuc2lnbmVkIGxvbmcs
IHVpbnRwdHJfdCwgYW5kIHZvaWQgKiBzaXplLiBTbyBldmVuIAp0aGF0IGFyY2hpdGVjdHVyZSBp
cyBPSyB3aXRoIGNhc3RpbmcgcG9pbnRlciB0byB1bnNpZ25lZCBsb25nLgoKSSBhZ3JlZSB3aXRo
IHlvdSB0aGF0IHVpbnRwdHJfdCBpcyB0aGUgc2VtYW50aWNhbGx5IGNvcnJlY3QgdHlwZSwgYnV0
IGl0IApzaG91bGQgY29tZSBhcyBhIHNlcGFyYXRlIGNoYW5nZSBhY3Jvc3MgdGhlIHVyY3UgY29k
ZSBiYXNlOiBjdXJyZW50bHkgCnRoZXJlIGFyZSBtYW55IHBsYWNlcyB3aGVyZSB2b2lkICogaXMg
Y2FzdCB0byB1bnNpZ25lZCBsb25nIHRvIGRvIApiaXR3aXNlIG9wZXJhdGlvbnMuCgpJIHRoZXJl
Zm9yZSByZWNvbW1lbmQgdG8gdXNlIHVuc2lnbmVkIGxvbmcgaGVyZSB0byBzdGF5IHNpbWlsYXIg
dG8gdGhlIApyZXN0IG9mIHRoZSBjb2RlIGJhc2UsIGFuZCBrZWVwIHRoZSB0cmFuc2l0aW9uIGZy
b20gdW5zaWduZWQgbG9uZyB0byAKdWludHB0cl90IGZvciB0aGUgZnV0dXJlLCBhcyBpdCBpcyBu
b3QgYW4gaW1tZWRpYXRlIGlzc3VlIHdlIGhhdmUgdG8gCmFkZHJlc3MuCgpUaGFua3MsCgpNYXRo
aWV1CgoKPiAKPiBPbmRyZWoKPiAtLQo+IE9uZMWZZWogU3Vyw70gKEhlL0hpbSkKPiBvbmRyZWpA
c3VyeS5vcmcKPiAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHBzOi8v
d3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
