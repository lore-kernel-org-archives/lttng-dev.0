From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 5/5] Add builtin modules
	support to kmod modprobe
Date: Thu, 17 Mar 2016 16:14:53 -0400
Message-ID: <CA+jJMxsZ1QsRYLLFZVG_DxHh3EyfF84L7i08032prWFmKCBP4Q__30607.8073489063$1458245715$gmane$org@mail.gmail.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
 <1455312708-462-5-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f193.google.com (mail-ig0-f193.google.com
 [209.85.213.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D51E5A2CAF
 for <lttng-dev@lists.lttng.org>; Thu, 17 Mar 2016 20:14:54 +0000 (UTC)
Received: by mail-ig0-f193.google.com with SMTP id av4so935604igc.1
 for <lttng-dev@lists.lttng.org>; Thu, 17 Mar 2016 13:14:54 -0700 (PDT)
In-Reply-To: <1455312708-462-5-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

QWxsIG1lcmdlZCBpbiBtYXN0ZXIuIEkgaGF2ZSBmaXhlZCB0aGUgdHlwbyBNYXRoaWV1IGNvbW1l
bnRlZCBvbiBhbmQgYQpjb3VwbGUgb2Ygb3RoZXJzLgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIEZy
aSwgRmViIDEyLCAyMDE2IGF0IDQ6MzEgUE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZm
aWNpb3MuY29tPiB3cm90ZToKPiBSZXBvcnQgc3VjY2VzcyB3aGVuIGxvYWRpbmcgYSBtb2R1bGUg
dGhhdCBpcyBidWlsdGluIHRoZSBrZXJuZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEpl
YW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9tb2Rwcm9iZS5jIHwgNyArKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9tb2Rwcm9iZS5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5jCj4gaW5k
ZXggM2U0MWY1Yy4uY2EwNDY3ZSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25k
L21vZHByb2JlLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMKPiBA
QCAtMTgwLDkgKzE4MCwxMiBAQCBzdGF0aWMgaW50IG1vZHByb2JlX2x0dG5nKHN0cnVjdCBrZXJu
X21vZHVsZXNfcGFyYW0gKm1vZHVsZXMsCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnJvcjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gLSAgICAgICAgICAgICAgIHJldCA9IGttb2Rf
bW9kdWxlX3Byb2JlX2luc2VydF9tb2R1bGUobW9kLCBLTU9EX1BST0JFX0lHTk9SRV9MT0FERUQs
Cj4gKyAgICAgICAgICAgICAgIHJldCA9IGttb2RfbW9kdWxlX3Byb2JlX2luc2VydF9tb2R1bGUo
bW9kLCAwLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCwgTlVM
TCwgTlVMTCk7Cj4gLSAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7Cj4gKyAgICAgICAgICAg
ICAgIGlmIChyZXQgPT0gLUVFWElTVCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIERCRygi
TW9kdWxlICVzIGlzIGFscmVhZHkgbG9hZGVkIiwgbW9kdWxlc1tpXS5uYW1lKTsKPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAwOwo+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHJl
dCA8IDApIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmVxdWlyZWQpIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVSUigiVW5hYmxlIHRvIGxvYWQgcmVxdWlyZWQg
bW9kdWxlICVzIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtb2R1bGVzW2ldLm5hbWUpOwo+IC0tCj4gMi43LjAKPgoKCgotLSAKSsOpcsOpbWllIEdh
bGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
