Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE5C74A5B
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679409926;
	bh=olCsjNKhUeN2i4d5pi6OGqVdqFF8mDkpWLQmif84VdQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JF42i8NtnFyRccYqbEtFrzC++8unMRlJQqrhmiLrjSmBOUm0Z0JP10hU1zP+Jf7Z9
	 5m0G0qxpKmoIBxTYN7JM6fNMj4n/molJe3ReeOXCPmEFrmBxKzAIdkWLVmpfxNKZgH
	 tQbW+eVtfjxHVJYHJTFuzGCIyczhAVjjT1xBPV4ONkiwJs34JF6tqCv5yrHORooDvX
	 rucS5yw+bEUez52pY9h4D+SmBswDKJbh6Js2Rrnb/RwgpyDFJk9d60osi6uoVlIgh0
	 D1JlUXWdMAJyaXlJ8NTNcodhojW9YKfylp/me4ICafBf7d8+My7yulLpKkor44/XIQ
	 yrzCe0NIqEkvA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgvXj3v8Pz2H2Y;
	Tue, 21 Mar 2023 10:45:25 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgvXh1Pplz2H9l
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 10:45:24 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgvXf6VLFzr5B;
 Tue, 21 Mar 2023 10:45:22 -0400 (EDT)
Message-ID: <023403bf-baac-c0a0-30b2-0f020ee17fba@efficios.com>
Date: Tue, 21 Mar 2023 10:45:34 -0400
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
 <b4b783ec-6d57-e658-7ac9-84e5a996b8b3@efficios.com>
In-Reply-To: <b4b783ec-6d57-e658-7ac9-84e5a996b8b3@efficios.com>
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

T24gMjAyMy0wMy0yMSAxMDo0NCwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gT24gMjAyMy0w
My0yMSAwNjoxNSwgT25kxZllaiBTdXLDvSB3cm90ZToKPj4KPj4+IE9uIDIwLiAzLiAyMDIzLCBh
dCAxOTozMSwgTWF0aGlldSBEZXNub3llcnMgCj4+PiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4+Cj4+PiBPbiAyMDIzLTAzLTE3IDE3OjM3LCBPbmTFmWVqIFN1csO9
IHZpYSBsdHRuZy1kZXYgd3JvdGU6Cj4+Pj4gV2hlbiBhZGRpbmcgUkVNT1ZFRF9GTEFHIHRvIHRo
ZSBwb2ludGVycyBpbiB0aGUgcmN1bGZoYXNoCj4+Pj4gaW1wbGVtZW50YXRpb24sIHJldHlwZSB0
aGUgZ2VuZXJpYyBwb2ludGVyIHRvIHVpbnRwdHJfdCB0byBmaXggdGhlCj4+Pj4gY29tcGlsZXIg
ZXJyb3IuCj4+Pgo+Pj4gV2hhdCBpcyB0aGUgY29tcGlsZXIgZXJyb3IgPyBJJ20gd29uZGVyaW5n
IHdoZXRoZXIgdGhlIGV4cGVjdGVkIGNob2ljZQo+Pj4gdG8gbWF0Y2ggdGhlIHJlc3Qgb2YgdGhp
cyBmaWxlJ3MgY29udGVudCB3b3VsZCBiZSB0byB1c2UgInVpbnRwdHJfdCAKPj4+ICoiIG9yICJ1
bnNpZ25lZCBsb25nICoiID8KPj4KPj4gVGhpcyBpcyB0aGUgZXJyb3I6Cj4+Cj4+IHJjdWxmaGFz
aC5jOjEyMDE6MjogZXJyb3I6IGFkZHJlc3MgYXJndW1lbnQgdG8gYXRvbWljIG9wZXJhdGlvbiBt
dXN0IAo+PiBiZSBhIHBvaW50ZXIgdG8gaW50ZWdlciAoJ3N0cnVjdCBjZHNfbGZodF9ub2RlICoq
JyBpbnZhbGlkKQo+PiDCoMKgwqDCoMKgwqDCoMKgIHVhdG9taWNfb3IoJm5vZGUtPm5leHQsIFJF
TU9WRURfRkxBRyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgo+PiAuLi9pbmNsdWRlL3VyY3UvdWF0b21pYy5oOjYwOjg6IG5vdGU6IGV4
cGFuZGVkIGZyb20gbWFjcm8gJ3VhdG9taWNfb3InCj4+IMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQp
X19hdG9taWNfb3JfZmV0Y2goKGFkZHIpLCAobWFzayksIF9fQVRPTUlDX1JFTEFYRUQpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH5+fn5+fgo+PiByY3VsZmhhc2guYzoxNDQ0OjM6IGVycm9yOiBhZGRyZXNzIGFyZ3VtZW50
IHRvIGF0b21pYyBvcGVyYXRpb24gbXVzdCAKPj4gYmUgYSBwb2ludGVyIHRvIGludGVnZXIgKCdz
dHJ1Y3QgY2RzX2xmaHRfbm9kZSAqKicgaW52YWxpZCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWF0b21pY19vcigmZmluaV9idWNrZXQtPm5leHQsIFJFTU9WRURfRkxBRyk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4+IC4uL2luY2x1ZGUvdXJjdS91YXRvbWljLmg6NjA6
ODogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAndWF0b21pY19vcicKPj4gwqDCoMKgwqDCoMKg
wqDCoCAodm9pZClfX2F0b21pY19vcl9mZXRjaCgoYWRkciksIChtYXNrKSwgX19BVE9NSUNfUkVM
QVhFRCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBewqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfn5+fn5+Cj4+Cj4+IHVpbnRwdHJfdCBpcyBkZWZpbmVkIGFzICJ1bnNp
Z25lZCBpbnRlZ2VyIHR5cGUgY2FwYWJsZSBvZiBob2xkaW5nIGEgCj4+IHBvaW50ZXIgdG8gdm9p
ZCIgd2hpbGUgdW5zaWduZWQgbG9uZyBpcyBhdCBsZWFzdCAzMi1iaXQ7Cj4+Cj4+IEkgZ3Vlc3Mg
dGhhdCB3b3JrcyBpbiBhIHByYWN0aXNlLCBidXQgdXNpbmcgdW5zaWduZWQgbG9uZyB0byByZXR5
cGUgCj4+IHRoZSBwb2ludGVycyBtaWdodCBibG93IHVwICh0aGlua2luZyBvZiB4MzIgd2hpY2gg
SSBrbm93Cj4+IGxpdHRsZSBhYm91dCwgYnV0IGl0J3Mga2luZCBvZiBoeWJyaWQgYXJjaGl0ZWN0
dXJlLCBpc24ndCBpdD8pCj4gCj4geDMyIHVzZXMgNCBieXRlcyBmb3IgdW5zaWduZWQgbG9uZywg
dWludHB0cl90LCBhbmQgdm9pZCAqIHNpemUuIFNvIGV2ZW4gCj4gdGhhdCBhcmNoaXRlY3R1cmUg
aXMgT0sgd2l0aCBjYXN0aW5nIHBvaW50ZXIgdG8gdW5zaWduZWQgbG9uZy4KPiAKPiBJIGFncmVl
IHdpdGggeW91IHRoYXQgdWludHB0cl90IGlzIHRoZSBzZW1hbnRpY2FsbHkgY29ycmVjdCB0eXBl
LCBidXQgaXQgCj4gc2hvdWxkIGNvbWUgYXMgYSBzZXBhcmF0ZSBjaGFuZ2UgYWNyb3NzIHRoZSB1
cmN1IGNvZGUgYmFzZTogY3VycmVudGx5IAo+IHRoZXJlIGFyZSBtYW55IHBsYWNlcyB3aGVyZSB2
b2lkICogaXMgY2FzdCB0byB1bnNpZ25lZCBsb25nIHRvIGRvIAo+IGJpdHdpc2Ugb3BlcmF0aW9u
cy4KPiAKPiBJIHRoZXJlZm9yZSByZWNvbW1lbmQgdG8gdXNlIHVuc2lnbmVkIGxvbmcgaGVyZSB0
byBzdGF5IHNpbWlsYXIgdG8gdGhlIAo+IHJlc3Qgb2YgdGhlIGNvZGUgYmFzZSwgYW5kIGtlZXAg
dGhlIHRyYW5zaXRpb24gZnJvbSB1bnNpZ25lZCBsb25nIHRvIAo+IHVpbnRwdHJfdCBmb3IgdGhl
IGZ1dHVyZSwgYXMgaXQgaXMgbm90IGFuIGltbWVkaWF0ZSBpc3N1ZSB3ZSBoYXZlIHRvIAo+IGFk
ZHJlc3MuCgpJIGZvcmdvdCB0byBtZW50aW9uOiB5b3Ugc2hvdWxkIGFkZCB0aGUgY29tcGlsZXIg
ZXJyb3IgdG8gdGhlIGNvbW1pdCAKbWVzc2FnZS4KCllvdSBzaG91bGQgYWxzbyBleHBsYWluIHdo
eSB0aGlzIHdhcyBub3QgYW4gaXNzdWUgdW50aWwgbm93LiBJdCdzIApwcm9iYWJseSByZWxhdGVk
IHRvIHRoZSBpbnRyb2R1Y2VkIHVzZSBvZiBfX2F0b21pYyBidWlsdGlucy4KClRoYW5rcywKCk1h
dGhpZXUKCj4gCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiAKPj4KPj4gT25kcmVqCj4+IC0t
IAo+PiBPbmTFmWVqIFN1csO9IChIZS9IaW0pCj4+IG9uZHJlakBzdXJ5Lm9yZwo+Pgo+IAoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29t
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
