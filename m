From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH v2 13/13] Fix: quit early if instructed
	to
Date: Wed, 13 Dec 2017 20:58:01 -0500
Message-ID: <CA+jJMxuG9tc=tKf6uton5N6FBE71h9_-PaVthSXmzuwxw=yeoQ__20080.8838395917$1513216705$gmane$org@mail.gmail.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
 <20170918225206.17725-14-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x229.google.com (mail-yb0-x229.google.com
 [IPv6:2607:f8b0:4002:c09::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3yxxYB1jpnzhml
 for <lttng-dev@lists.lttng.org>; Thu, 14 Dec 2017 01:58:22 +0000 (UTC)
Received: by mail-yb0-x229.google.com with SMTP id z11so2381080ybm.1
 for <lttng-dev@lists.lttng.org>; Wed, 13 Dec 2017 17:58:21 -0800 (PST)
In-Reply-To: <20170918225206.17725-14-jonathan.rajotte-julien@efficios.com>
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

TEdUTS4KCkrDqXLDqW1pZQoKT24gMTggU2VwdGVtYmVyIDIwMTcgYXQgMTg6NTIsIEpvbmF0aGFu
IFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4g
SWYgdGhlIHdhaXRfcXVldWUgc2l6ZSBpcyBjb25zaWRlcmFibGUsIG5vdCBjaGVja2luZyBpZiB0
aGUgdGhyZWFkIHNob3VsZAo+IHF1aXQgZGVsYXlzIHRoZSB0ZXJtaW5hdGlvbiAoMysgc2Vjb25k
cyBkdXJpbmcgc3RyZXNzIHRlc3RpbmcpLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFq
b3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMv
YmluL2x0dG5nLXNlc3Npb25kL21haW4uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tYWluLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+IGluZGV4IGZi
NThhYjRiLi4wNDc1YzVhMyAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21h
aW4uYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCj4gQEAgLTIyNDQsNyAr
MjI0NCw3IEBAIHN0YXRpYyB2b2lkICp0aHJlYWRfZGlzcGF0Y2hfdXN0X3JlZ2lzdHJhdGlvbih2
b2lkICpkYXRhKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5s
b2NrKCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXNzaW9uX3VubG9ja19s
aXN0KCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICB9IHdo
aWxlIChub2RlICE9IE5VTEwpOwo+ICsgICAgICAgICAgICAgICB9IHdoaWxlIChub2RlICE9IE5V
TEwgJiYgIUNNTV9MT0FEX1NIQVJFRChkaXNwYXRjaF90aHJlYWRfZXhpdCkpOwo+Cj4gICAgICAg
ICAgICAgICAgIGhlYWx0aF9wb2xsX2VudHJ5KCk7Cj4gICAgICAgICAgICAgICAgIC8qIEZ1dGV4
IHdhaXQgb24gcXVldWUuIEJsb2NraW5nIGNhbGwgb24gZnV0ZXgoKSAqLwo+IC0tCj4gMi4xMS4w
Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
