From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace stable-1.5] Fix: python bindings
 when building with PIE hardening
Date: Mon, 13 Nov 2017 18:43:14 -0500
Message-ID: <CA+jJMxsQ0BFD6tS0jQo5MY87H8zouza8CG=Kn7rcnQp3zK7Z9w__3002.57057319886$1510616612$gmane$org@mail.gmail.com>
References: <1508963431-14553-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybRzG1tVLz160v
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 23:43:21 +0000 (UTC)
Received: by mail-wr0-x243.google.com with SMTP id y42so15960091wrd.3
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 15:43:21 -0800 (PST)
In-Reply-To: <1508963431-14553-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDI1IE9jdG9iZXIgMjAxNyBhdCAxNjozMCwg
TWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFdvcmsgYXJv
dW5kIGEgYnVnL2xpbWl0YXRpb24gaW4gcHl0aG9uIGRpc3R1dGlscyB3aGVyZSBvYmplY3QgZmls
ZXMgYXJlCj4gYnVpbHQgd2l0aCAtZlBJQyBhcHBlbmRlZCBhZnRlciB0aGUgQ0ZMQUdTIGJ1dCB0
aGUgZmluYWwgc2hhcmVkIG9iamVjdAo+IGlzIGxpbmtlZCB3aXRoIC1zaGFyZWQgYmVmb3JlIHRo
ZSBMREZMQUdTIHdoaWNoIGNhbiB0aGVuIGJlIG92ZXJyaWRlbiBieQo+IGhhcmRlbmluZyBmbGFn
cyBhbmQgcmVzdWx0IGluIGFuIGludmFsaWQgYnVpbGQuCj4KPiBUaGUgd29yayBhcm91bmQgaXMg
dG8gYXBwZW5kIC1zaGFyZWQgdG8gdGhlIExERkxBR1MgbWFraW5nIHN1cmUgaXQncyBub3QKPiBv
dmVycmlkZW4uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVm
ZmljaW9zLmNvbT4KPiAtLS0KPiAgYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtIHwgMiArLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9iaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gYi9iaW5kaW5ncy9weXRob24vTWFr
ZWZpbGUuYW0KPiBpbmRleCAyY2VhYjAzLi41ZTRkZGU4IDEwMDY0NAo+IC0tLSBhL2JpbmRpbmdz
L3B5dGhvbi9NYWtlZmlsZS5hbQo+ICsrKyBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbQo+
IEBAIC0yNSw3ICsyNSw3IEBAIEJJTkRJTkdTX0RFUFM9c2V0dXAucHkgXAo+ICBCVUlMRF9GTEFH
Uz1DQz0iJChDQykiIFwKPiAgICAgICAgICAgICAgICAgQ0ZMQUdTPSIkKEdMSUJfQ0ZMQUdTKSAk
KEFNX0NGTEFHUykgJChDRkxBR1MpIiBcCj4gICAgICAgICAgICAgICAgIENQUEZMQUdTPSIkKERF
RlMpICQoREVGQVVMVF9JTkNMVURFUykgJChBTV9DUFBGTEFHUykgJChDUFBGTEFHUykiIFwKPiAt
ICAgICAgICAgICAgICAgTERGTEFHUz0iJChBTV9MREZMQUdTKSAkKExERkxBR1MpICQoR0xJQl9M
SUJTKSAkKExJQlMpIgo+ICsgICAgICAgICAgICAgICBMREZMQUdTPSIkKEFNX0xERkxBR1MpICQo
TERGTEFHUykgJChHTElCX0xJQlMpIC1zaGFyZWQgJChMSUJTKSIKPgo+ICBidWlsZC1weXRob24t
YmluZGluZ3Muc3RhbXA6ICQoQklORElOR1NfREVQUykKPiAgICAgICAgICQoQlVJTERfRkxBR1Mp
ICQoUFlUSE9OKSAkKGJ1aWxkZGlyKS9zZXR1cC5weSBidWlsZF9leHQKPiAtLQo+IDIuNy40Cj4K
CgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmlj
aW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
