From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH v2 08/13] Fix: perform lookup then test
	for condition
Date: Wed, 13 Dec 2017 20:56:59 -0500
Message-ID: <CA+jJMxvTSNEf+B5MgdDr+uOTW0k92AW77p4_KWfY-8BLDPZPmQ__30653.9651043297$1513216645$gmane$org@mail.gmail.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
 <20170918225206.17725-9-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x22d.google.com (mail-yb0-x22d.google.com
 [IPv6:2607:f8b0:4002:c09::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3yxxX04NbSzhhL
 for <lttng-dev@lists.lttng.org>; Thu, 14 Dec 2017 01:57:20 +0000 (UTC)
Received: by mail-yb0-x22d.google.com with SMTP id j7so2378519ybl.3
 for <lttng-dev@lists.lttng.org>; Wed, 13 Dec 2017 17:57:20 -0800 (PST)
In-Reply-To: <20170918225206.17725-9-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

UGxlYXNlIGFkZCBhIGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhpcyBmaXhlcywgbm90IGp1c3QgaG93
IGl0IGZpeGVzIGl0LgoKSW4gdGhpcyBjYXNlLCBJIHNlZSB0aGF0IHRoZSBlcnJvciBwYXRoIGlz
IHRyaWdnZXJlZCBhbnl0aW1lCnRoZSBwb2xsZmQgZG9lcyBub3QgbWF0Y2ggdGhlIGZpcnN0IGFw
cCBzb2NrZXQgaW4gdGhlIHdhaXQKcXVldWUuCgpPbiAxOCBTZXB0ZW1iZXIgMjAxNyBhdCAxODo1
MiwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29t
PiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpv
dHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
bWFpbi5jIHwgNyArKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWlu
LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+IGluZGV4IDM1OTZkN2UzLi44Y2Zm
YTZmNiAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+ICsrKyBi
L3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCj4gQEAgLTE4OTksOCArMTg5OSwxMSBAQCBz
dGF0aWMgdm9pZCBzYW5pdGl6ZV93YWl0X3F1ZXVlKHN0cnVjdCB1c3RfcmVnX3dhaXRfcXVldWUg
KndhaXRfcXVldWUpCj4KPiAgICAgICAgICAgICAgICAgY2RzX2xpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZSh3YWl0X25vZGUsIHRtcF93YWl0X25vZGUsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmd2FpdF9xdWV1ZS0+aGVhZCwgaGVhZCkgewo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGlmIChwb2xsZmQgPT0gd2FpdF9ub2RlLT5hcHAtPnNvY2sgJiYKPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHJldmVudHMgJiAoTFBPTExIVVAgfCBMUE9MTEVS
UikpKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBvbGxmZCAhPSB3YWl0X25vZGUt
PmFwcC0+c29jaykgewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsKPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAocmV2ZW50cyAmIChMUE9MTEhVUCB8IExQT0xMRVJSKSkgewoKVGhlIGZpeCBpcyBjb3Jy
ZWN0LCBidXQgdGhpcyBjaGVjayBjYW4gYmUgcGVyZm9ybWVkIGJlZm9yZSB0aGlzIGxvb3AuCgpT
aW5jZSAoTFBPTExIVVAgfCBMUE9MTEVSUikgYXJlIHRoZSBvbmx5IGV4cGVjdGVkIHBvbGwgZXZl
bnRzCmF0IHRoaXMgcG9pbnQsIHdlIGNhbiBsb2cgdGhlICJVbmV4cGVjdGVkIHBvbGwgZXZlbnRz
IiBtZXNzYWdlCmFuZCBnb3RvIGVycm9yIGJlZm9yZSBlbnRlcmluZyB0aGUgd2FpdCBxdWV1ZSBs
b29wLCB3aGljaAp3aWxsIHNpbXBsaWZ5IGl0cyBib2R5LgoKSsOpcsOpbWllCgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY2RzX2xpc3RfZGVsKCZ3YWl0X25vZGUtPmhlYWQpOwo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2FpdF9xdWV1ZS0+Y291bnQtLTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzdF9hcHBfZGVzdHJveSh3YWl0X25vZGUt
PmFwcCk7Cj4gLS0KPiAyLjExLjAKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
