From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: java-jul/Makefile should not
 be	marked as a binary
Date: Wed, 19 Feb 2014 19:33:23 +0000 (UTC)
Message-ID: <156021063.27636.1392838403029.JavaMail.zimbra__33542.6401267343$1392838465$gmane$org@efficios.com>
References: <1392749975-25136-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WGCta-0002gx-7F
	for lttng-dev@lists.lttng.org; Wed, 19 Feb 2014 14:33:31 -0500
In-Reply-To: <1392749975-25136-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTZW50OiBUdWVzZGF5LCBGZWJy
dWFyeSAxOCwgMjAxNCAxOjU5OjM1IFBNCj4gU3ViamVjdDogW2x0dG5nLWRldl0gW1BBVENIIGx0
dG5nLXVzdF0gRml4OiBqYXZhLWp1bC9NYWtlZmlsZSBzaG91bGQgbm90IGJlCW1hcmtlZCBhcyBh
IGJpbmFyeQo+IAo+IGphdmEtanVsL01ha2VmaWxlIGlzIHBhcnQgb2YgYmluX1NDUklQVFMgd2hp
Y2ggY2F1c2VzIGl0IHRvIGJlCj4gaW5zdGFsbGVkIHVuZGVyIC91c3IvbG9jYWwvYmluLgo+IAo+
IEl0IGlzIGFscmVhZHkgaW5zdGFsbGVkIGFzIGFuIGV4YW1wbGUuCj4gCj4gU2lnbmVkLW9mZi1i
eTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgo+
IC0tLQo+ICBkb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0gfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFt
IGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCj4gaW5kZXggZTE5YWYzOC4uOTcxZWVjMyAxMDA2
NDQKPiAtLS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KPiArKysgYi9kb2MvZXhhbXBsZXMv
TWFrZWZpbGUuYW0KPiBAQCAtMTAsNyArMTAsNiBAQCBkaXN0X2RvY19leGFtcGxlc19qYXZhX2p1
bF9EQVRBID0gamF2YS1qdWwvTWFrZWZpbGUgXAo+ICAJCQkJCQkJCSAgamF2YS1qdWwvSGVsbG8u
amF2YSBcCj4gIAkJCQkJCQkJICBqYXZhLWp1bC9ydW4KPiAgU1VCRElSU19KVUwgPSBqYXZhLWp1
bAo+IC1iaW5fU0NSSVBUUyA9IGphdmEtanVsL01ha2VmaWxlCj4gIGVuZGlmCj4gIAo+ICBkaXN0
X2RvY19leGFtcGxlc19EQVRBID0gUkVBRE1FCj4gLS0KPiAxLjkuMAo+IAo+IAo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxp
bmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKCi0tIApNYXRoaWV1IERl
c25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
