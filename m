Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0C9C433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Mar 2022 17:19:34 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4K7PBD3WP2z5jV;
	Tue,  1 Mar 2022 12:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646155173;
	bh=77XsKcpbq7oZXUpFVXrcGB3ZwQkfQM7GTrukraZxZak=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Rq8/+1RkvE+PhcU7HoMgfYfwA2Ch0zRlLRASOc+5lMSC9XGRh0q2wgu1017hX3rL1
	 8TkVHgtt1xEk7uOrcWljlx/eS/j8R+Z6Nd6/zyP3sEcxwsVdkV7QuJeZDElR3VkfmP
	 045qvR6d9CTP489hQ+VBeWrnftSiedZjihdWffR1g3okx3GCwumMf++bsl/waLVTJL
	 ikAkAQ8eterq0F/T3gAGXD0WwGx908ykN/tkJmLPks6bYjDfsaJOpzu28T6t0ysgaC
	 8qGWw/oSYjQ1hL/IiQKLy/5IDT19NzrcAcmXF09dHWevMhQXeY3qxdrl35EgRaQpDF
	 tbA59yAVrUlGA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4K7PBB5Nrgz5fr
 for <lttng-dev@lists.lttng.org>; Tue,  1 Mar 2022 12:19:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56457372232
 for <lttng-dev@lists.lttng.org>; Tue,  1 Mar 2022 12:19:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id i5e_kGx04EVc; Tue,  1 Mar 2022 12:19:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B3CAB372384;
 Tue,  1 Mar 2022 12:19:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B3CAB372384
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id QHQ7XH7wI9nz; Tue,  1 Mar 2022 12:19:23 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id A792F371ECA;
 Tue,  1 Mar 2022 12:19:23 -0500 (EST)
Date: Tue, 1 Mar 2022 12:19:23 -0500 (EST)
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, kernel@axis.com
Message-ID: <1019241870.115039.1646155163638.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
References: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC98 (Linux)/8.8.15_GA_4232)
Thread-Topic: consumer-stream: use-after-free of metadata bucket
Thread-Index: L5pP6fYhiyavrL060Y2Dbx0wUuEFPQ==
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: consumer-stream:
 use-after-free of metadata bucket
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgotLS0tLSBNZXNzYWdlIG9yaWdpbmFsIC0tLS0tCj4gRGU6ICJsdHRuZy1kZXYiIDxsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnPgo+IMOAOiAibHR0bmctZGV2IiA8bHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZz4KPiBDYzoga2VybmVsQGF4aXMuY29tCj4gRW52b3nDqTogVmVuZHJlZGkgMjUgRsOp
dnJpZXIgMjAyMiAxMDoxMjowMgo+IE9iamV0OiBbbHR0bmctZGV2XSBbUEFUQ0ggbHR0bmctdG9v
bHNdIEZpeDogY29uc3VtZXItc3RyZWFtOiB1c2UtYWZ0ZXItZnJlZSBvZiBtZXRhZGF0YSBidWNr
ZXQKCj4gV2hlbiBjb25zdW1lcl9zdHJlYW1fZGVzdHJveSgpIGlzIGNhbGxlZCBmcm9tLCBmb3Ig
ZXhhbXBsZSwgdGhlIGVycm9yCj4gcGF0aCBpbiBzZXR1cF9tZXRhZGF0YSgpLCBjb25zdW1lcl9z
dHJlYW1fZnJlZSgpIGNhbiBlbmQgdXAgYmVpbmcgY2FsbGVkCj4gdHdpY2Ugb24gdGhlIHNhbWUg
c3RyZWFtLiAgU2luY2UgdGhlIHN0cmVhbS0+bWV0YWRhdGFfYnVja2V0IGlzIG5vdCBzZXQKPiB0
byBOVUxMIGFmdGVyIGJlaW5nIGRlc3Ryb3llZCwgaXQgbGVhZHMgdG8gYSB1c2UtYWZ0ZXItZnJl
ZToKPiAKPiBFUlJPUjogQWRkcmVzc1Nhbml0aXplcjogaGVhcC11c2UtYWZ0ZXItZnJlZSBvbiBh
ZGRyZXNzIDB4NjA0MDAwMDAwMzE4Cj4gUkVBRCBvZiBzaXplIDggYXQgMHg2MDQwMDAwMDAzMTgg
dGhyZWFkIFQ3Cj4gICAgICMwIGluIG1ldGFkYXRhX2J1Y2tldF9kZXN0cm95Cj4gICAgICMxIGlu
IGNvbnN1bWVyX3N0cmVhbV9mcmVlCj4gICAgICMyIGluIGNvbnN1bWVyX3N0cmVhbV9kZXN0cm95
Cj4gICAgICMzIGluIHNldHVwX21ldGFkYXRhCj4gICAgICM0IGluIGx0dG5nX3VzdGNvbnN1bWVy
X3JlY3ZfY21kCj4gICAgICM1IGluIGx0dG5nX2NvbnN1bWVyX3JlY3ZfY21kCj4gICAgICM2IGlu
IGNvbnN1bWVyX3RocmVhZF9zZXNzaW9uZF9wb2xsCj4gICAgICM3IGluIHN0YXJ0X3RocmVhZCBu
cHRsL3B0aHJlYWRfY3JlYXRlLmM6NDgxCj4gICAgICM4IGluIGNsb25lICgvbGliL3g4Nl82NC1s
aW51eC1nbnUvbGliYy5zby42KzB4ZmNiZGUpCj4gCj4gMHg2MDQwMDAwMDAzMTggaXMgbG9jYXRl
ZCA4IGJ5dGVzIGluc2lkZSBvZiA0OC1ieXRlIHJlZ2lvbgo+IFsweDYwNDAwMDAwMDMxMCwweDYw
NDAwMDAwMDM0MCkKPiBmcmVlZCBieSB0aHJlYWQgVDcgaGVyZToKPiAgICAgIzAgaW4gX19pbnRl
cmNlcHRvcl9mcmVlCj4gICAgICMxIGluIG1ldGFkYXRhX2J1Y2tldF9kZXN0cm95Cj4gICAgICMy
IGluIGNvbnN1bWVyX3N0cmVhbV9mcmVlCj4gICAgICMzIGluIGNvbnN1bWVyX3N0cmVhbV9kZXN0
cm95Cj4gICAgICM0IGluIGNsZWFuX2NoYW5uZWxfc3RyZWFtX2xpc3QKPiAgICAgIzUgaW4gY29u
c3VtZXJfZGVsX2NoYW5uZWwKPiAgICAgIzYgaW4gY29uc3VtZXJfc3RyZWFtX2Rlc3Ryb3kKPiAg
ICAgIzcgaW4gc2V0dXBfbWV0YWRhdGEKPiAgICAgIzggaW4gbHR0bmdfdXN0Y29uc3VtZXJfcmVj
dl9jbWQKPiAgICAgIzkgaW4gbHR0bmdfY29uc3VtZXJfcmVjdl9jbWQKPiAgICAgIzEwIGluIGNv
bnN1bWVyX3RocmVhZF9zZXNzaW9uZF9wb2xsCj4gICAgICMxMSBpbiBzdGFydF90aHJlYWQgbnB0
bC9wdGhyZWFkX2NyZWF0ZS5jOjQ4MQo+IAo+IHByZXZpb3VzbHkgYWxsb2NhdGVkIGJ5IHRocmVh
ZCBUNyBoZXJlOgo+ICAgICAjMCBpbiBfX2ludGVyY2VwdG9yX2NhbGxvYwo+ICAgICAjMSBpbiB6
bWFsbG9jCj4gICAgICMyIGluIG1ldGFkYXRhX2J1Y2tldF9jcmVhdGUKPiAgICAgIzMgaW4gY29u
c3VtZXJfc3RyZWFtX2VuYWJsZV9tZXRhZGF0YV9idWNrZXRpemF0aW9uCj4gICAgICM0IGluIGx0
dG5nX3VzdGNvbnN1bWVyX3NldF9zdHJlYW1fb3BzCj4gICAgICM1IGluIGx0dG5nX3VzdGNvbnN1
bWVyX29uX3JlY3Zfc3RyZWFtCj4gICAgICM2IGluIGx0dG5nX2NvbnN1bWVyX29uX3JlY3Zfc3Ry
ZWFtCj4gICAgICM3IGluIGNyZWF0ZV91c3Rfc3RyZWFtcwo+ICAgICAjOCBpbiBhc2tfY2hhbm5l
bAo+ICAgICAjOSBpbiBsdHRuZ191c3Rjb25zdW1lcl9yZWN2X2NtZAo+ICAgICAjMTAgaW4gbHR0
bmdfY29uc3VtZXJfcmVjdl9jbWQKPiAgICAgIzExIGluIGNvbnN1bWVyX3RocmVhZF9zZXNzaW9u
ZF9wb2xsCj4gICAgICMxMiBpbiBzdGFydF90aHJlYWQgbnB0bC9wdGhyZWFkX2NyZWF0ZS5jOjQ4
MQo+IAo+IFRocmVhZCBUNyBjcmVhdGVkIGJ5IFQwIGhlcmU6Cj4gICAgICMwIGluIF9faW50ZXJj
ZXB0b3JfcHRocmVhZF9jcmVhdGUKPiAgICAgIzEgaW4gbWFpbgo+ICAgICAjMiBpbiBfX2xpYmNf
c3RhcnRfbWFpbiAuLi9jc3UvbGliYy1zdGFydC5jOjMzMgo+IAo+IFNVTU1BUlk6IEFkZHJlc3NT
YW5pdGl6ZXI6IGhlYXAtdXNlLWFmdGVyLWZyZWUgaW4gbWV0YWRhdGFfYnVja2V0X2Rlc3Ryb3kK
PiAKPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IFdoaXRjaHVyY2ggPHZpbmNlbnQud2hpdGNodXJj
aEBheGlzLmNvbT4KPiAtLS0KPiBzcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1bWVyLXN0cmVhbS5j
cHAgfCAxICsKPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0
IGEvc3JjL2NvbW1vbi9jb25zdW1lci9jb25zdW1lci1zdHJlYW0uY3BwCj4gYi9zcmMvY29tbW9u
L2NvbnN1bWVyL2NvbnN1bWVyLXN0cmVhbS5jcHAKPiBpbmRleCAyZGMzZjAwMmIuLjQ4MTYxMWMz
ZSAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1bWVyLXN0cmVhbS5jcHAK
PiArKysgYi9zcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1bWVyLXN0cmVhbS5jcHAKPiBAQCAtOTg4
LDYgKzk4OCw3IEBAIHZvaWQgY29uc3VtZXJfc3RyZWFtX2ZyZWUoc3RydWN0IGx0dG5nX2NvbnN1
bWVyX3N0cmVhbQo+ICpzdHJlYW0pCj4gCUxUVE5HX0FTU0VSVChzdHJlYW0pOwo+IAo+IAltZXRh
ZGF0YV9idWNrZXRfZGVzdHJveShzdHJlYW0tPm1ldGFkYXRhX2J1Y2tldCk7Cj4gKwlzdHJlYW0t
Pm1ldGFkYXRhX2J1Y2tldCA9IE5VTEw7CgpIaSBWaW5jZW50LAoKVGhhbmtzIGEgbG90IGZvciBy
ZXBvcnRpbmcgdGhlIHByb2JsZW0uIElmIEkgdW5kZXJzdGFuZCB0aGUgQVNBTgpyZXBvcnQgY29y
cmVjdGx5LCB0aGUgc3RyZWFtIGl0c2VsZiB3aWxsIGFsc28gYmUgZG91YmxlIGZyZWUnZCwgc28K
SSBkb24ndCB0aGluayB0aGlzIGlzIHRoZSBjb21wbGV0ZSBmaXguCgpUaGVyZSBkZWZpbml0ZWx5
IHNlZW1zIHRvIGJlIGEgcHJvYmxlbSB3aXRoIHJlZ2FyZHMgdG8gdGhlIG93bmVyc2hpcApvZiB0
aGUgbWV0YWRhdGEgY2hhbm5lbCB2cyBzdHJlYW0uIExldCBtZSBsb29rIGludG8gaXQuCgpJIHNl
ZSB0aGF0IHlvdSBmYWxsIGludG8gYSBjYXNlIHdoZXJlIHRoZSBtZXRhZGF0YSBzZXR1cCBmYWls
cywKY2FuIHlvdSBzaGFyZSBtb3JlIGluZm8gYWJvdXQgaG93IHRoaXMgY2FuIGJlIHJlcHJvZHVj
ZWQ/CgpUaGFua3MhCkrDqXLDqW1pZQoKPiAJY2FsbF9yY3UoJnN0cmVhbS0+bm9kZS5oZWFkLCBm
cmVlX3N0cmVhbV9yY3UpOwo+IH0KPiAKPiAtLQo+IDIuMzQuMQo+IAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlz
dAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
