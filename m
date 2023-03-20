Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E5CC6FD1D
	for <lttng-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679337664;
	bh=aOKZRxBMrLBx97XGi65ClpZOUvw/jiCuLf5viwUslsQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DHlBz839sNRfDKgY78Q46fhBImagQ27TedY9E8FEqzYd4a51Mv1JPWhyKTSrTjj5Z
	 PsAyXutCVajcjc9zQOigRR5qJ9o321SF6ATp5Bw9qUZaQOXqzaIQjAHNfANlEPFMyR
	 tRXTi9lK7cTYUPotT+Q98oXMiqgLqh8lkfBLuCrvtoKrSQN0Gt69NK7FIwY23b6V6q
	 nxVFl1dZR4DB8d+XcqyVKf2kWmbnFmASQ8n4aCZcYrCZzGtgjuKEU7ssF3p59i9CRa
	 /0ztuJmnK52Ld5kOsb75BkIApDTiU361Wvbkt01+HchZKkcpKbtRX8UOduNmTJN1el
	 CY9yM1iUyNJxA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgNq41NWtz2FVq;
	Mon, 20 Mar 2023 14:41:04 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgNq173wCz2Gbm
 for <lttng-dev@lists.lttng.org>; Mon, 20 Mar 2023 14:41:01 -0400 (EDT)
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PgNq12CCNzqxT;
 Mon, 20 Mar 2023 14:41:01 -0400 (EDT)
Message-ID: <bc2fd0fc-f6e3-def9-1cff-e6d86a79f644@efficios.com>
Date: Mon, 20 Mar 2023 14:41:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org, paulmck <paulmck@kernel.org>
References: <20230317213755.455957-1-ondrej@sury.org>
 <20230317213755.455957-3-ondrej@sury.org>
 <6d73ed33-f3fc-2459-a7e9-142b8908ad4f@efficios.com>
 <5C9355A4-AE1B-45B5-915E-D41C45A488BE@sury.org>
 <912a8dd5-0451-1d11-7ffa-dd1094658c44@efficios.com>
In-Reply-To: <912a8dd5-0451-1d11-7ffa-dd1094658c44@efficios.com>
Subject: Re: [lttng-dev] [PATCH 2/7] Use gcc __atomic builtis for
 <urcu/uatomic.h> implementation
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

T24gMjAyMy0wMy0yMCAxNDozOCwgTWF0aGlldSBEZXNub3llcnMgdmlhIGx0dG5nLWRldiB3cm90
ZToKPiBPbiAyMDIzLTAzLTIwIDE0OjI4LCBPbmTFmWVqIFN1csO9IHdyb3RlOgo+Pgo+Pj4gT24g
MjAuIDMuIDIwMjMsIGF0IDE5OjAzLCBNYXRoaWV1IERlc25veWVycyAKPj4+IDxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Pj4KPj4+IEluIGRvYy91YXRvbWljLWFwaS5t
ZCwgd2UgZG9jdW1lbnQ6Cj4+Pgo+Pj4gImBgYGMKPj4+IHR5cGUgdWF0b21pY19jbXB4Y2hnKHR5
cGUgKmFkZHIsIHR5cGUgb2xkLCB0eXBlIG5ldyk7Cj4+PiBgYGAKPj4+Cj4+PiBBbiBhdG9taWMg
cmVhZC1tb2RpZnktd3JpdGUgb3BlcmF0aW9uIHRoYXQgcGVyZm9ybXMgdGhpcwo+Pj4gc2VxdWVu
Y2Ugb2Ygb3BlcmF0aW9ucyBhdG9taWNhbGx5OiBjaGVjayBpZiBgYWRkcmAgY29udGFpbnMgYG9s
ZGAuCj4+PiBJZiB0cnVlLCB0aGVuIHJlcGxhY2UgdGhlIGNvbnRlbnQgb2YgYGFkZHJgIGJ5IGBu
ZXdgLiBSZXR1cm4gdGhlCj4+PiB2YWx1ZSBwcmV2aW91c2x5IGNvbnRhaW5lZCBieSBgYWRkcmAu
IFRoaXMgZnVuY3Rpb24gaW1wbGllcyBhIGZ1bGwKPj4+IG1lbW9yeSBiYXJyaWVyIGJlZm9yZSBh
bmQgYWZ0ZXIgdGhlIGF0b21pYyBvcGVyYXRpb24uIgo+Pj4KPj4+IFRoaXMgd291bGQgbWFwIHRv
IGEgIl9fQVRPTUlDX0FDUV9SRUwiIHNlbWFudGljIG9uIGNtcHhjaGcgZmFpbHVyZQo+Pj4gcmF0
aGVyIHRoYW4gX19BVE9NSUNfQ09OU1VNRSIuCj4+Cj4+Cj4+IEZyb206IGh0dHBzOi8vZ2NjLmdu
dS5vcmcvb25saW5lZG9jcy9nY2MvXzAwNWZfMDA1ZmF0b21pYy1CdWlsdGlucy5odG1sCj4+Cj4+
PiBJZiBkZXNpcmVkIGlzIHdyaXR0ZW4gaW50byAqcHRyIHRoZW4gdHJ1ZSBpcyByZXR1cm5lZCBh
bmQgbWVtb3J5IGlzIAo+Pj4gYWZmZWN0ZWQgYWNjb3JkaW5nIHRvIHRoZSBtZW1vcnkgb3JkZXIg
c3BlY2lmaWVkIGJ5IHN1Y2Nlc3NfbWVtb3JkZXIuIAo+Pj4gVGhlcmUgYXJlIG5vIHJlc3RyaWN0
aW9ucyBvbiB3aGF0IG1lbW9yeSBvcmRlciBjYW4gYmUgdXNlZCBoZXJlLgo+Pj4KPj4+IE90aGVy
d2lzZSwgZmFsc2UgaXMgcmV0dXJuZWQgYW5kIG1lbW9yeSBpcyBhZmZlY3RlZCBhY2NvcmRpbmcg
dG8gCj4+PiBmYWlsdXJlX21lbW9yZGVyLiBUaGlzIG1lbW9yeSBvcmRlciBjYW5ub3QgYmUgX19B
VE9NSUNfUkVMRUFTRSBub3IgCj4+PiBfX0FUT01JQ19BQ1FfUkVMLiBJdCBhbHNvIGNhbm5vdCBi
ZSBhIHN0cm9uZ2VyIG9yZGVyIHRoYW4gdGhhdCAKPj4+IHNwZWNpZmllZCBieSBzdWNjZXNzX21l
bW9yZGVyLgo+Pgo+PiBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRoYXQgdGhlIGZhaWx1cmVfbWVt
b3JkZXIgaGFzIHRoZSBzYW1lIG1lbW9yZGVyIAo+PiBhcyB1YXRvbWljX3JlYWQoKSwgYnV0IGl0
IGRlZmluaXRlbGx5IGNhbm5vdCBiZSBfX0FUT01JQ19BQ1FfUkVMIC0gCj4+IGl0J3Mgc2FtZSBh
cyB3aXRoIF9fYXRvbWljX2xvYWRfbiwgb25seSBmb2xsb3dpbmcgYXJlIHBlcm1pdHRlZDoKPj4K
Pj4+IFRoZSB2YWxpZCBtZW1vcnkgb3JkZXIgdmFyaWFudHMgYXJlIF9fQVRPTUlDX1JFTEFYRUQs
IAo+Pj4gX19BVE9NSUNfU0VRX0NTVCwgX19BVE9NSUNfQUNRVUlSRSwgYW5kIF9fQVRPTUlDX0NP
TlNVTUUuCj4gCj4gQmFzZWQgb24gbXkgb3RoZXIgcmVwbHksIHdlIHdhbnQgIlNFUV9DU1QiIHJh
dGhlciB0aGFuIEFDUV9SRUwgZXZlcnl3aGVyZS4KCkFuZCBpdCBfd291bGRfIG1ha2Ugc2Vuc2Ug
dG8gdXNlIHRoZSBzYW1lIG1lbW9yZGVyIG9uIGNtcHhjaGcgZmFpbHVyZSBhcyAKdWF0b21pY19y
ZWFkIGlmIHdlIHdlcmUgZXhwb3NpbmcgYSBuZXcgQVBJLCBidXQgd2UgYXJlIG1vZGlmeWluZyBh
biAKYWxyZWFkeSBleHBvc2VkIGRvY3VtZW50ZWQgQVBJLCBzbyBJIHdvdWxkIHN0aWNrIHRvIFNF
UV9DU1QgZm9yIGJvdGggCmNtcHhjaGcgc3VjY2Vzcy9mYWlsdXJlLgoKSWYgd2Ugd2FudCB0byBl
eHBvc2UgYSBuZXcgY21weGNoZ19yZWxheGVkX2ZhaWx1cmUgd2l0aCBhIHJlbGF4ZWQgCm1lbW9y
ZGVyIG9uIGZhaWx1cmUgdGhhdCB3b3VsZCBiZSBmaW5lLCBidXQgd2UgY2Fubm90IGNoYW5nZSB0
aGUgCnNlbWFudGljIHRoYXQgaXMgYWxyZWFkeSBkb2N1bWVudGVkLgoKVGhhbmtzLAoKTWF0aGll
dQoKPiAKPiBUaGFua3MsCj4gCj4gTWF0aGlldQo+IAo+Pgo+PiBPbmRyZWoKPj4gLS0gCj4+IE9u
ZMWZZWogU3Vyw70gKEhlL0hpbSkKPj4gb25kcmVqQHN1cnkub3JnCj4+Cj4gCgotLSAKTWF0aGll
dSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwczovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
