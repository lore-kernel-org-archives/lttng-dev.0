From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v3 2/2] man: document dead-peer
	detection for relayd
Date: Thu, 23 Nov 2017 14:03:13 -0500
Message-ID: <CA+jJMxsm8WhcZkXNz3MQMhnE0ohXMLSektOJQRD5dtOZrMi-fQ__8673.74544400281$1511463810$gmane$org@mail.gmail.com>
References: <20171006182247.6874-1-jonathan.rajotte-julien@efficios.com>
 <20171006182247.6874-2-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3yjTHR1zNXzjYX
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2017 19:03:15 +0000 (UTC)
Received: by mail-wm0-x242.google.com with SMTP id b189so18437372wmd.5
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2017 11:03:15 -0800 (PST)
In-Reply-To: <20171006182247.6874-2-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

UGhpbCwgYW55IGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2g/CgpKw6lyw6ltaWUKCk9uIDYgT2N0b2Jl
ciAyMDE3IGF0IDE0OjIyLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpvdHRlLWp1bGll
bkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUg
PGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgZG9jL21hbi9s
dHRuZy1yZWxheWQuOC50eHQgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZG9jL21hbi9sdHRuZy1yZWxh
eWQuOC50eHQgYi9kb2MvbWFuL2x0dG5nLXJlbGF5ZC44LnR4dAo+IGluZGV4IDIxODUyNmExLi5l
MzdjZTg0NSAxMDA2NDQKPiAtLS0gYS9kb2MvbWFuL2x0dG5nLXJlbGF5ZC44LnR4dAo+ICsrKyBi
L2RvYy9tYW4vbHR0bmctcmVsYXlkLjgudHh0Cj4gQEAgLTE2Miw2ICsxNjIsMjUgQEAgRU5WSVJP
Tk1FTlQgVkFSSUFCTEVTCj4gIGBMVFROR19SRUxBWURfSEVBTFRIYDo6Cj4gICAgICBQYXRoIHRv
IHJlbGF5IGRhZW1vbiBoZWFsdGgncyBzb2NrZXQuCj4KPiArYExUVE5HX1JFTEFZRF9UQ1BfS0VF
UF9BTElWRV9FTkFCTEVgOjoKPiArICAgIFNldCB0byAxIHRvIGVuYWJsZSB0aGUgdXNlIG9mIHRj
cCBrZWVwLWFsaXZlIGFsbG93aW5nIHRoZSBkZXRlY3Rpb24gb2YgZGVhZAo+ICsgICAgcGVlcnMu
Cj4gKwo+ICtgTFRUTkdfUkVMQVlEX1RDUF9LRUVQX0FMSVZFX1RJTUVgOjoKPiArICAgIFNlZSB0
Y3AoNykgdGNwX2tlZXBhbGl2ZV90aW1lIG9yIHRjcF9rZWVwYWxpdmVfaW50ZXJ2YWwgb24gU29s
YXJpcyAxMS4KPiArICAgIEEgdmFsdWUgb2YgLTEgbGV0cyB0aGUgb3BlcmF0aW5nIHN5c3RlbSBt
YW5hZ2UgdGhpcyBwYXJhbWV0ZXIgKGRlZmF1bHQpLgo+ICsKPiArYExUVE5HX1JFTEFZRF9UQ1Bf
S0VFUF9BTElWRV9QUk9CRVNgOjoKPiArICAgIFNlZSB0Y3AoNykgdGNwX2tlZXBhbGl2ZV9wcm9i
ZXMuCj4gKyAgICBBIHZhbHVlIG9mIC0xIGxldHMgdGhlIG9wZXJhdGluZyBzeXN0ZW0gbWFuYWdl
IHRoaXMgcGFyYW1ldGVyIChkZWZhdWx0KS4KPiArCj4gK05PVEU6IE5vdCBzdXBwb3J0ZWQgb24g
U29sYXJpcy4KPiArCj4gK2BMVFROR19SRUxBWURfVENQX0tFRVBfQUxJVkVfSU5UVkxgOjoKPiAr
ICAgIFNlZSB0Y3AoNykgdGNwX2tlZXBhbGl2ZV9pbnR2bC4KPiArICAgIEEgdmFsdWUgb2YgLTEg
bGV0cyB0aGUgb3BlcmF0aW5nIHN5c3RlbSBtYW5hZ2UgdGhpcyBwYXJhbWV0ZXIgKGRlZmF1bHQp
Lgo+ICsKPiArTk9URTogTm90IHN1cHBvcnRlZCBvbiBTb2xhcmlzLgo+Cj4gIEZJTEVTCj4gIC0t
LS0tCj4gLS0KPiAyLjExLjAKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
