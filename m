From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: ctf writer tests were moved
	to test_python_babeltrace
Date: Mon, 18 Sep 2017 17:54:04 -0400
Message-ID: <CA+jJMxusAXi3rejdaVXyPoJ9_rfzXHRWxKjDPdJkKQ9xK_xEgg__46781.4070675105$1505771653$gmane$org@mail.gmail.com>
References: <1505769937-22584-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx0C143VrzDSr
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:54:05 +0000 (UTC)
Received: by mail-qt0-x243.google.com with SMTP id b1so1239814qtc.0
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 14:54:05 -0700 (PDT)
In-Reply-To: <1505769937-22584-1-git-send-email-mjeanson@efficios.com>
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

Rml4ZWQgYnk6Cgpjb21taXQgZTllMzZhMzg4OWNkMzBkMmJjMWExOTNmZDg3ZmJjMDUzNTEwOTk3
MgpBdXRob3I6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9z
LmNvbT4KRGF0ZTogICBNb24gU2VwIDE4IDE3OjE1OjQ5IDIwMTcgLTA0MDAKCiAgICBUZXN0czog
bW92ZWQgZmlsZXMgcG9pbnRlZC10byBpbiBNYWtlZmlsZQoKICAgIFNpZ25lZC1vZmYtYnk6IErD
qXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KClRoYW5r
cyEKSsOpcsOpbWllCgpPbiAxOCBTZXB0ZW1iZXIgMjAxNyBhdCAxNzoyNSwgTWljaGFlbCBKZWFu
c29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy9NYWtlZmls
ZS5hbSB8IDYgLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL01ha2VmaWxlLmFtIGIvdGVzdHMvTWFrZWZpbGUuYW0KPiBpbmRleCBm
OWMyMDdmLi5lZTBkNzA2IDEwMDY0NAo+IC0tLSBhL3Rlc3RzL01ha2VmaWxlLmFtCj4gKysrIGIv
dGVzdHMvTWFrZWZpbGUuYW0KPiBAQCAtMzgsMTIgKzM4LDYgQEAgVEVTVFNfTElCID0gXAo+ICAg
ICAgICAgbGliL3Rlc3RfY2NfcHJpb19tYXAgXAo+ICAgICAgICAgbGliL3Rlc3RfYnRfbm90aWZp
Y2F0aW9uX2l0ZXJhdG9yCj4KPiAtaWYgRU5BQkxFX1BZVEhPTl9CSU5ESU5HUwo+IC1URVNUU19M
SUIgKz0gXAo+IC0gICAgICAgbGliL3dyaXRlci90ZXN0X2N0Zl93cml0ZXJfbm9fcGFja2V0X2Nv
bnRleHQucHkgXAo+IC0gICAgICAgbGliL3dyaXRlci90ZXN0X2N0Zl93cml0ZXJfZW1wdHlfcGFj
a2V0LnB5Cj4gLWVuZGlmCj4gLQo+ICBpZiAhRU5BQkxFX0JVSUxUX0lOX1BMVUdJTlMKPiAgVEVT
VFNfTElCICs9IGxpYi90ZXN0X3BsdWdpbl9jb21wbGV0ZQo+ICBlbmRpZgo+IC0tCj4gMi43LjQK
PgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
