From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: atomic_add_unless()
 returns true/false rather than prior value
Date: Wed, 8 Mar 2017 16:43:09 +0000 (UTC)
Message-ID: <517373936.695.1488991389142.JavaMail.zimbra__47374.2587994367$1488991380$gmane$org@efficios.com>
References: <1488947760-25045-1-git-send-email-francis.deslauriers@efficios.com>
 <1488991131-9828-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdfTT0dG4zw3w
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 16:42:52 +0000 (UTC)
In-Reply-To: <1488991131-9828-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWFyIDgsIDIwMTcsIGF0IDExOjM4IEFNLCBGcmFuY2lzIERlc2xhdXJpZXJzIGZy
YW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUaGUgcHJldmlvdXMgaW1w
bGVtZW50YXRpb24gYXNzdW1lZCB0aGF0IGBhdG9taWNfYWRkX3VubGVzc2AgcmV0dXJuZWQgdGhl
Cj4gcHJpb3IgdmFsdWUgb2YgdGhlIGF0b21pYyBjb3VudGVyIHdoZW4gaW4gZmFjdCBpdCByZXR1
cm5lZCBpZiBhZGRpdGlvbiB3YXMKPiBzdWNjZXNzZnVsKHRydWUpIG9yIG92ZXJmbG93ZWQoZmFs
c2UpLgoKSSB0aGluayB5b3UgbWVhbiAiaWYgYWRkaXRpb24gd2FzIHBlcmZvcm1lZCAodHJ1ZSkg
b3Igbm90IHBlcmZvcm1lZCAoZmFsc2UpIiA/CgpUaGFua3MsCgpNYXRoaWV1Cgo+IFNpbmNlIGBh
dG9taWNfYWRkX3VubGVzc2AgY2FuIG5vdCByZXR1cm4gSU5UX01BWCwgdGhlIGBsdHRuZ19rcmVm
X2dldGAKPiBhbHdheXMgcmV0dXJuZWQgdGhhdCB0aGUgY2FsbCB3YXMgc3VjY2Vzc2Z1bC4KPiAK
PiBUaGlzIGlzc3VlIGhhZCBhIGxvdyBsaWtlbGlob29kIG9mIGJlaW5nIHRyaWdnZXJlZCBzaW5j
ZSB0aGUgdHdvIHJlZmNvdW50cwo+IG9mIHRoZSBjb3VudGVycyB1c2VkIHdpdGggdGhpcyBjYWxs
IGFyZSBib3RoIGJvdW5kZWQgYnkgdGhlIG1heGltdW0KPiBudW1iZXIgb2YgZmlsZSBkZXNjcmlw
dG9ycyBvbiB0aGUgc3lzdGVtLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jaXMgRGVzbGF1cmll
cnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+IHdyYXBwZXIva3Jl
Zi5oIHwgNiArLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3dyYXBwZXIva3JlZi5oIGIvd3JhcHBlci9rcmVmLmgK
PiBpbmRleCBlZWRlZmJmLi5mMzBhOWFlIDEwMDY0NAo+IC0tLSBhL3dyYXBwZXIva3JlZi5oCj4g
KysrIGIvd3JhcHBlci9rcmVmLmgKPiBAQCAtMzYsMTEgKzM2LDcgQEAKPiAgKi8KPiBzdGF0aWMg
aW5saW5lIGludCBsdHRuZ19rcmVmX2dldChzdHJ1Y3Qga3JlZiAqa3JlZikKPiB7Cj4gLQlpZiAo
YXRvbWljX2FkZF91bmxlc3MoJmtyZWYtPnJlZmNvdW50LCAxLCBJTlRfTUFYKSAhPSBJTlRfTUFY
KSB7Cj4gLQkJcmV0dXJuIDE7Cj4gLQl9IGVsc2Ugewo+IC0JCXJldHVybiAwOwo+IC0JfQo+ICsJ
cmV0dXJuIGF0b21pY19hZGRfdW5sZXNzKCZrcmVmLT5yZWZjb3VudCwgMSwgSU5UX01BWCk7Cj4g
fQo+IAo+ICNlbmRpZiAvKiBfTFRUTkdfV1JBUFBFUl9LUkVGX0ggKi8KPiAtLQo+IDIuNy40Cgot
LSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
