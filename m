From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Remove unused headers
Date: Tue, 14 Feb 2017 15:56:45 -0500
Message-ID: <CA+jJMxvJav6kXZ5KPiDzf0E_4bGLv+WiSXkW5GJxTw4rOL5h7Q__37537.0748145089$1487105841$gmane$org@mail.gmail.com>
References: <1485460546-22938-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3vNFFT1Kckzl4y
 for <lttng-dev@lists.lttng.org>; Tue, 14 Feb 2017 21:01:00 +0000 (UTC)
Received: by mail-ua0-x241.google.com with SMTP id 96so12105734uaq.2
 for <lttng-dev@lists.lttng.org>; Tue, 14 Feb 2017 12:56:46 -0800 (PST)
In-Reply-To: <1485460546-22938-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuOS4KClRoYW5rcywKSsOpcsOpbWllCgpPbiAy
NiBKYW51YXJ5IDIwMTcgYXQgMTQ6NTUsIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNp
b3MuY29tPiB3cm90ZToKPiBUaGlzIGlzIGEgcG9ydGFiaWxpdHkgZml4LCB0aGVzZSBoZWFkZXJz
IGFyZSB1bnVzZWQgYW5kIG5vdCBhdmFpbGFibGUgb24KPiBzb21lIHBsYXRmb3Jtcy4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0t
LQo+ICBzcmMvYmluL2x0dG5nLXJlbGF5ZC9oZWFsdGgtcmVsYXlkLmMgfCAxIC0KPiAgc3JjL2Nv
bW1vbi9mdXRleC5jICAgICAgICAgICAgICAgICAgIHwgMSAtCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9oZWFs
dGgtcmVsYXlkLmMgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9oZWFsdGgtcmVsYXlkLmMKPiBpbmRl
eCBjZmY2YzZlLi5iMTRiODI3IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2hl
YWx0aC1yZWxheWQuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2hlYWx0aC1yZWxheWQu
Ywo+IEBAIC0zNyw3ICszNyw2IEBACj4gICNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+ICAjaW5jbHVk
ZSA8YXNzZXJ0Lmg+Cj4gICNpbmNsdWRlIDx1cmN1L2NvbXBpbGVyLmg+Cj4gLSNpbmNsdWRlIDx1
bGltaXQuaD4KPiAgI2luY2x1ZGUgPGludHR5cGVzLmg+Cj4KPiAgI2luY2x1ZGUgPGNvbW1vbi9k
ZWZhdWx0cy5oPgo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2Z1dGV4LmMgYi9zcmMvY29tbW9u
L2Z1dGV4LmMKPiBpbmRleCAyYWUwM2IyLi4zODRlOTU3IDEwMDY0NAo+IC0tLSBhL3NyYy9jb21t
b24vZnV0ZXguYwo+ICsrKyBiL3NyYy9jb21tb24vZnV0ZXguYwo+IEBAIC0xOCw3ICsxOCw2IEBA
Cj4KPiAgI2RlZmluZSBfTEdQTF9TT1VSQ0UKPiAgI2luY2x1ZGUgPGxpbWl0cy5oPgo+IC0jaW5j
bHVkZSA8c3lzL3N5c2NhbGwuaD4KPiAgI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICAjaW5jbHVkZSA8
dXJjdS5oPgo+ICAjaW5jbHVkZSA8dXJjdS9mdXRleC5oPgo+IC0tCj4gMi43LjQKPgoKCgotLSAK
SsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
