Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF67C433F5
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Mar 2022 17:37:59 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KC5Jk2RRPz8yC;
	Mon,  7 Mar 2022 12:37:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646674678;
	bh=OtdJBUhxcmy5e+ZxhOFFPxtUUhvN7zWPTXfi2lH8j24=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VASuvXqtr78DAclPp+S2PRpyq+LGZ7IMa1WwFiSlK/T/RXypDKZsahoIrqXiGo4Lq
	 gj3P+ZytCt/jKaZKutPFYEiLJPtyZjXr9n3HetQ02MNMCixwUPmkoz1w2eFSFj02HO
	 EVkR3/XvPqy0amc1lfO+wp/V8C4GI/BhBRoXWbknRWV4OVRaqbZ0tQyfvU1JKJv+tX
	 qjxfVSoQ/17nJHmWVyOr/HC3Hwq0CMhgTe1/THWktdDQwfNuTFES63Zn/WvEomc75u
	 I/0VyVeQ+qdtNesC2Pi/I+6k+oTBqeAfKgNpvHmpDuQJZGZ4qble/R4gyV0f2/tR3/
	 iHxN1K/B90glw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KC5Jh4VCzz8sr
 for <lttng-dev@lists.lttng.org>; Mon,  7 Mar 2022 12:37:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C499D34CB02
 for <lttng-dev@lists.lttng.org>; Mon,  7 Mar 2022 12:37:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 50VHtlFvIkNo; Mon,  7 Mar 2022 12:37:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2B5E634C93B;
 Mon,  7 Mar 2022 12:37:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2B5E634C93B
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 7KN-4J0jbY99; Mon,  7 Mar 2022 12:37:49 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2152F34C99E;
 Mon,  7 Mar 2022 12:37:49 -0500 (EST)
Date: Mon, 7 Mar 2022 12:37:49 -0500 (EST)
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, kernel <kernel@axis.com>
Message-ID: <921962800.125936.1646674669086.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220302092730.GA26479@axis.com>
References: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
 <1019241870.115039.1646155163638.JavaMail.zimbra@efficios.com>
 <20220302092730.GA26479@axis.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC98 (Linux)/8.8.15_GA_4232)
Thread-Topic: consumer-stream: use-after-free of metadata bucket
Thread-Index: dUEzES0ToSOltfgjDzF+CaxCrzUQPQ==
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

SGkgVmluY2VudCwKCkkgaGFkIGEgY2hhbmNlIHRvIGxvb2sgaW50byB0aGlzIGFuZCBjYW1lIHVw
IHdpdGggdGhlIGZvbGxvd2luZyBmaXg6Cmh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL2x0dG5n
LXRvb2xzLysvNzQ3OC80CgpXb3VsZCB5b3UgaGF2ZSBhIGNoYW5jZSB0byB0cnkgaXQgb24geW91
ciBlbmQgYmVmb3JlIEkgbWVyZ2UgaXQ/CgpUaGFua3MgZm9yIHRoZSBncmVhdCBidWcgcmVwb3J0
IQpKw6lyw6ltaWUKCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPiBGcm9tOiAiVmluY2Vu
dCBXaGl0Y2h1cmNoIiA8dmluY2VudC53aGl0Y2h1cmNoQGF4aXMuY29tPgo+IFRvOiAiSmVyZW1p
ZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gQ2M6ICJsdHRu
Zy1kZXYiIDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiwgImtlcm5lbCIgPGtlcm5lbEBheGlz
LmNvbT4KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIsIDIwMjIgNDoyNzozMCBBTQo+IFN1Ympl
Y3Q6IFJlOiBbbHR0bmctZGV2XSBbUEFUQ0ggbHR0bmctdG9vbHNdIEZpeDogY29uc3VtZXItc3Ry
ZWFtOiB1c2UtYWZ0ZXItZnJlZSBvZiBtZXRhZGF0YSBidWNrZXQKCj4gT24gVHVlLCBNYXIgMDEs
IDIwMjIgYXQgMDY6MTk6MjNQTSArMDEwMCwgSsOpcsOpbWllIEdhbGFybmVhdSB3cm90ZToKPj4g
VGhhbmtzIGEgbG90IGZvciByZXBvcnRpbmcgdGhlIHByb2JsZW0uIElmIEkgdW5kZXJzdGFuZCB0
aGUgQVNBTgo+PiByZXBvcnQgY29ycmVjdGx5LCB0aGUgc3RyZWFtIGl0c2VsZiB3aWxsIGFsc28g
YmUgZG91YmxlIGZyZWUnZCwgc28KPj4gSSBkb24ndCB0aGluayB0aGlzIGlzIHRoZSBjb21wbGV0
ZSBmaXguCj4gCj4gWWVhaCwgaXQgbG9va2VkIG9kZCB0aGF0IGNvbnN1bWVyX3N0cmVhbV9kZXN0
cm95KCkgaXMgY2FsbGVkIHJlY3Vyc2l2ZWx5Cj4gb24gdGhlIHNhbWUgc3RyZWFtIGJ1dCBBRkFJ
Q1MgdGhlIGNvZGUncyBiZWVuIGxpa2UgdGhpcyBmb3IgYSB3aGlsZSBzbyBJCj4gYXNzdW1lZCBp
dCB3YXMgb24gcHVycG9zZSwgYW5kIG9ubHkgdGhlIG1ldGFkYXRhIGJ1Y2tldCBzdHVmZiB3YXMK
PiByZWxhdGl2ZWx5IG5ldy4gIEFTQU4gZG9lc24ndCBkZXRlY3QgYW55IGRvdWJsZSBmcmVlcyBv
ZiB0aGUgc3RyZWFtCj4gaXRzZWxmLCBidXQgSSBndWVzcyBjYWxsaW5nIGNhbGxfcmN1KC4uLiwg
ZnJlZV9zdHJlYW1fcmN1KSB0d2ljZSBvbiB0aGUKPiBzYW1lIHN0cmVhbSBpcyBub3QgZXhwZWN0
ZWQgYmVoYXZpb3VyIGFuZCBjb3VsZCBsZWFkIHRvIG90aGVyIHByb2JsZW1zLgo+IAo+PiBUaGVy
ZSBkZWZpbml0ZWx5IHNlZW1zIHRvIGJlIGEgcHJvYmxlbSB3aXRoIHJlZ2FyZHMgdG8gdGhlIG93
bmVyc2hpcAo+PiBvZiB0aGUgbWV0YWRhdGEgY2hhbm5lbCB2cyBzdHJlYW0uIExldCBtZSBsb29r
IGludG8gaXQuCj4gCj4gR3JlYXQsIHRoYW5rIHlvdSEKPiAKPj4gSSBzZWUgdGhhdCB5b3UgZmFs
bCBpbnRvIGEgY2FzZSB3aGVyZSB0aGUgbWV0YWRhdGEgc2V0dXAgZmFpbHMsCj4+IGNhbiB5b3Ug
c2hhcmUgbW9yZSBpbmZvIGFib3V0IGhvdyB0aGlzIGNhbiBiZSByZXByb2R1Y2VkPwo+IAo+IElu
IHRoZSBjb3JlIGR1bXAgSSByZWNlaXZlZCAob24gdjIuMTIuNCksIGNvbnN1bWVyX3N0cmVhbV9k
ZXN0cm95KCkgd2FzCj4gY2FsbGVkIGZyb20gdGhlIGVycm9yIGxhYmVsIGluIHNldHVwX21ldGFk
YXRhIGFuZCByZXQgd2FzIHNldCB0bwo+IExUVENPTU1fQ09OU1VNRVJEX0VSUk9SX01FVEFEQVRB
LiAgU28gY29uc3VtZXJfc2VuZF9yZWxheWRfc3RyZWFtKCkgaGFkCj4gcmV0dXJuZWQgYW4gZXJy
b3IuICBJIG9ubHkgaGFkIHRoZSBjb3JlIGR1bXAgYW5kIG5vIG90aGVyIGxvZ3MsIHNvIEkgZGlk
Cj4gbm90IGtub3cgd2hpY2ggb2YgdGhlIHBhdGhzIGluc2lkZSBjb25zdW1lcl9zZW5kX3JlbGF5
ZF9zdHJlYW0oKSBoYWQKPiBmYWlsZWQsIGJ1dCBzaW5jZSBJIHdhcyBwcmltYXJpbHkgaW50ZXJl
c3RlZCBpbiBmaXhpbmcgdGhlIGNyYXNoIGl0c2VsZgo+IEkgc2ltcGx5IGZvcmNlZCB0aGlzIGNv
ZGUgcGF0aCB0byBiZSB0YWtlbjoKPiAKPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi91c3QtY29u
c3VtZXIvdXN0LWNvbnN1bWVyLmMKPiBiL3NyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1jb25z
dW1lci5jCj4gaW5kZXggZmExYzcxMjk5Li45N2VkNTk2MzIgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Nv
bW1vbi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMKPiArKysgYi9zcmMvY29tbW9uL3VzdC1j
b25zdW1lci91c3QtY29uc3VtZXIuYwo+IEBAIC05MDgsOCArOTA4LDcgQEAgc3RhdGljIGludCBz
ZXR1cF9tZXRhZGF0YShzdHJ1Y3QgbHR0bmdfY29uc3VtZXJfbG9jYWxfZGF0YQo+ICpjdHgsIHVp
bnQ2NF90IGtleSkKPiAKPiAJLyogU2VuZCBtZXRhZGF0YSBzdHJlYW0gdG8gcmVsYXlkIGlmIG5l
ZWRlZC4gKi8KPiAJaWYgKG1ldGFkYXRhLT5tZXRhZGF0YV9zdHJlYW0tPm5ldF9zZXFfaWR4ICE9
ICh1aW50NjRfdCkgLTFVTEwpIHsKPiAtCQlyZXQgPSBjb25zdW1lcl9zZW5kX3JlbGF5ZF9zdHJl
YW0obWV0YWRhdGEtPm1ldGFkYXRhX3N0cmVhbSwKPiAtCQkJCW1ldGFkYXRhLT5wYXRobmFtZSk7
Cj4gKwkJcmV0ID0gLTE7Cj4gCQlpZiAocmV0IDwgMCkgewo+IAkJCXJldCA9IExUVENPTU1fQ09O
U1VNRVJEX0VSUk9SX01FVEFEQVRBOwo+IAkJCWdvdG8gZXJyb3I7Cj4gCj4gV2l0aCB0aGUgYWJv
dmUgcGF0Y2gsIEkgY291bGQgZWFzaWx5IHJlcHJvZHVjZSB0aGUgdXNlLWFmdGVyLWZyZWUgdXNp
bmcKPiB0aGUgZm9sbG93aW5nIHN0ZXBzIG9uIHRoZSBsYXRlc3QgcmVsZWFzZSB2Mi4xMy40LCBh
bmQgaXQgd2FzIGNsZWFyIHRoYXQKPiB0aGlzIHVzZS1hZnRlci1mcmVlIHdhcyB0aGUgY2F1c2Ug
b2YgdGhlIG9yaWdpbmFsIGNvcmUgZHVtcCBvbiB0aGUgb2xkZXIKPiByZWxlYXNlIHRvby4KPiAK
PiBCdWlsZCB3aXRoIEFTQU46Cj4gCj4gbHR0bmctdG9vbHMkIExERkxBR1M9LWZzYW5pdGl6ZT1h
ZGRyZXNzIENGTEFHUz0tZnNhbml0aXplPWFkZHJlc3MgLi9jb25maWd1cmUKPiAKPiBTaGVsbCAj
MToKPiAKPiBsdHRuZy11c3QkIHRlc3RzL2NvbXBpbGUvYXBpMC9oZWxsby9oZWxsbyAxMDAwMAo+
IAo+IFNoZWxsICMyOgo+IAo+IGx0dG5nLXRvb2xzJCBBU0FOX09QVElPTlM9ZGV0ZWN0X29kcl92
aW9sYXRpb249MAo+IC4vc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9sdHRuZy1zZXNzaW9uZAo+IAo+
IFNoZWxsICMzOgo+IAo+IGx0dG5nLXRvb2xzJCBleHBvcnQgQVNBTl9PUFRJT05TPWRldGVjdF9v
ZHJfdmlvbGF0aW9uPTAKPiBsdHRuZy10b29scyQgLi9zcmMvYmluL2x0dG5nL2x0dG5nIGNyZWF0
ZSAtLWxpdmUgJiYgLi9zcmMvYmluL2x0dG5nL2x0dG5nCj4gZW5hYmxlLWV2ZW50IC0tdXNlcnNw
YWNlIDEgJiYgLi9zcmMvYmluL2x0dG5nL2x0dG5nIHN0YXJ0ICYmIHNsZWVwIDEgJiYKPiAuL3Ny
Yy9iaW4vbHR0bmcvbHR0bmcgc3RvcAo+IAo+IFRoZSBBU0FOIHNwbGF0IHNob3VsZCBiZSBzZWVu
IGluIHNoZWxsICMyLiAgTm90ZSB0aGF0IHlvdSBtYXkgaGF2ZSB0bwo+IHJ1biB0aGUgY29tbWFu
ZCBpbiBzaGVsbCAjMyBhIGNvdXBsZSBvZiB0aW1lcyBzaW5jZQo+IExUVE5HX0NPTlNVTUVSX1NF
VFVQX01FVEFEQVRBIGRvZXNuJ3Qgc2VlbSB0byBiZSBzZW50IGV2ZXJ5IHRpbWUuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
