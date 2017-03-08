From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v3] Fix: atomic_add_unless()
 returns true/false rather than prior value
Date: Wed, 8 Mar 2017 16:56:32 +0000 (UTC)
Message-ID: <2138894487.714.1488992192301.JavaMail.zimbra__29898.2193031863$1488992199$gmane$org@efficios.com>
References: <1488991131-9828-1-git-send-email-francis.deslauriers@efficios.com>
 <1488991838-13807-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdfmr2YfSzw60
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 16:56:11 +0000 (UTC)
In-Reply-To: <1488991838-13807-1-git-send-email-francis.deslauriers@efficios.com>
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

bWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0tLS0gT24g
TWFyIDgsIDIwMTcsIGF0IDExOjUwIEFNLCBGcmFuY2lzIERlc2xhdXJpZXJzIGZyYW5jaXMuZGVz
bGF1cmllcnNAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUaGUgcHJldmlvdXMgaW1wbGVtZW50YXRp
b24gYXNzdW1lZCB0aGF0IGBhdG9taWNfYWRkX3VubGVzc2AgcmV0dXJuZWQKPiB0aGUgcHJpb3Ig
dmFsdWUgb2YgdGhlIGF0b21pYyBjb3VudGVyIHdoZW4gaW4gZmFjdCBpdCByZXR1cm5lZCBpZiB0
aGUKPiBhZGRpdGlvbiB3YXMgcGVyZm9ybWVkICh0cnVlKSBvciBub3QgcGVyZm9ybWVkIChmYWxz
ZSkuCj4gU2luY2UgYGF0b21pY19hZGRfdW5sZXNzYCBjYW4gbm90IHJldHVybiBJTlRfTUFYLCB0
aGUgYGx0dG5nX2tyZWZfZ2V0YAo+IGFsd2F5cyByZXR1cm5lZCB0aGF0IHRoZSBjYWxsIHdhcyBz
dWNjZXNzZnVsLgo+IAo+IFRoaXMgaXNzdWUgaGFkIGEgbG93IGxpa2VsaWhvb2Qgb2YgYmVpbmcg
dHJpZ2dlcmVkIHNpbmNlIHRoZSB0d28gcmVmY291bnRzCj4gb2YgdGhlIGNvdW50ZXJzIHVzZWQg
d2l0aCB0aGlzIGNhbGwgYXJlIGJvdGggYm91bmRlZCBieSB0aGUgbWF4aW11bQo+IG51bWJlciBv
ZiBmaWxlIGRlc2NyaXB0b3JzIG9uIHRoZSBzeXN0ZW0uCj4gCj4gU2lnbmVkLW9mZi1ieTogRnJh
bmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0t
Cj4gd3JhcHBlci9rcmVmLmggfCA2ICstLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvd3JhcHBlci9rcmVmLmggYi93
cmFwcGVyL2tyZWYuaAo+IGluZGV4IGVlZGVmYmYuLmYzMGE5YWUgMTAwNjQ0Cj4gLS0tIGEvd3Jh
cHBlci9rcmVmLmgKPiArKysgYi93cmFwcGVyL2tyZWYuaAo+IEBAIC0zNiwxMSArMzYsNyBAQAo+
ICAqLwo+IHN0YXRpYyBpbmxpbmUgaW50IGx0dG5nX2tyZWZfZ2V0KHN0cnVjdCBrcmVmICprcmVm
KQo+IHsKPiAtCWlmIChhdG9taWNfYWRkX3VubGVzcygma3JlZi0+cmVmY291bnQsIDEsIElOVF9N
QVgpICE9IElOVF9NQVgpIHsKPiAtCQlyZXR1cm4gMTsKPiAtCX0gZWxzZSB7Cj4gLQkJcmV0dXJu
IDA7Cj4gLQl9Cj4gKwlyZXR1cm4gYXRvbWljX2FkZF91bmxlc3MoJmtyZWYtPnJlZmNvdW50LCAx
LCBJTlRfTUFYKTsKPiB9Cj4gCj4gI2VuZGlmIC8qIF9MVFROR19XUkFQUEVSX0tSRUZfSCAqLwo+
IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93
d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
