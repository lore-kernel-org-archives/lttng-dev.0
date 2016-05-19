From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 05/10] Fix: bogus mask on
	error.h PRINT types
Date: Thu, 19 May 2016 00:12:35 -0400
Message-ID: <CA+jJMxsohycKjxm8FaWXgevKto6YoHWiRrhDpx1YMSAjH2JG+w__48772.670797962$1463631160$gmane$org@mail.gmail.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463594659-10964-6-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f67.google.com (mail-qg0-f67.google.com
 [209.85.192.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C38FBA35E1
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 04:12:36 +0000 (UTC)
Received: by mail-qg0-f67.google.com with SMTP id 90so5951049qgz.0
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 21:12:36 -0700 (PDT)
In-Reply-To: <1463594659-10964-6-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

R29vZCBjYXRjaCwgbWVyZ2VkIQoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIFdlZCwgTWF5IDE4LCAy
MDE2IGF0IDI6MDQgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+IFBSSU5UX0VSUiBtYXBzIHRvIDB4MSwgUFJJTlRfV0FSTiBtYXBz
IHRvIDB4Miwgd2hpY2ggaXMgZmluZSBzbyBmYXIgdG8KPiB1c2UgYXMgbWFza3MsIGJ1dCBQUklO
VF9CVUcgbWFwcyB0byAweDMsIHdoaWNoIGlzIHRoZSBzYW1lIGFzIGJvdGgKPiBQUklOVF9FUlIg
YW5kIFBSSU5UX1dBUk4sIGFuZCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIHVzZSBpbiBtYXNrcyB3
aXRoCj4gX19sdHRuZ19wcmludDoKPgo+ICAgKHR5cGUgJiAoUFJJTlRfV0FSTiB8IFBSSU5UX0VS
UiB8IFBSSU5UX0JVRykpCj4KPiBGaXggdGhpcyBieSBlbnN1cmluZyBQUklOVF9CVUcgaGFzIGl0
cyBvd24gbWFzaywgYW5kIGV4cHJlc3MgYWxsCj4gY29uc3RhbnRzIGFzIHNoaWZ0cyB0byBlbGlt
aW5hdGUgdGhlIHJpc2sgb2YgcmUtaW50cm9kdWNpbmcgYSBzaW1pbGFyCj4gYnVnIGluIHRoZSBm
dXR1cmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvY29tbW9uL2Vycm9yLmggfCAxNCArKysr
KysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vZXJyb3IuaCBiL3NyYy9jb21tb24vZXJy
b3IuaAo+IGluZGV4IGYyYTMxZGYuLjNhYjFkNDYgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi9l
cnJvci5oCj4gKysrIGIvc3JjL2NvbW1vbi9lcnJvci5oCj4gQEAgLTU3LDEzICs1NywxMyBAQCBl
eHRlcm4gaW50IGx0dG5nX29wdF92ZXJib3NlOwo+ICBleHRlcm4gaW50IGx0dG5nX29wdF9taTsK
Pgo+ICAvKiBFcnJvciB0eXBlLiAqLwo+IC0jZGVmaW5lIFBSSU5UX0VSUiAgIDB4MQo+IC0jZGVm
aW5lIFBSSU5UX1dBUk4gIDB4Mgo+IC0jZGVmaW5lIFBSSU5UX0JVRyAgIDB4Mwo+IC0jZGVmaW5l
IFBSSU5UX01TRyAgIDB4NAo+IC0jZGVmaW5lIFBSSU5UX0RCRyAgIDB4MTAKPiAtI2RlZmluZSBQ
UklOVF9EQkcyICAweDIwCj4gLSNkZWZpbmUgUFJJTlRfREJHMyAgMHgzMAo+ICsjZGVmaW5lIFBS
SU5UX0VSUiAgICgxIDw8IDApCj4gKyNkZWZpbmUgUFJJTlRfV0FSTiAgKDEgPDwgMSkKPiArI2Rl
ZmluZSBQUklOVF9CVUcgICAoMSA8PCAyKQo+ICsjZGVmaW5lIFBSSU5UX01TRyAgICgxIDw8IDMp
Cj4gKyNkZWZpbmUgUFJJTlRfREJHICAgKDEgPDwgNCkKPiArI2RlZmluZSBQUklOVF9EQkcyICAo
MSA8PCA1KQo+ICsjZGVmaW5lIFBSSU5UX0RCRzMgICgxIDw8IDYpCj4KPiAgLyoKPiAgICogTWFj
cm8gZm9yIHByaW50aW5nIG1lc3NhZ2UgZGVwZW5kaW5nIG9uIGNvbW1hbmQgbGluZSBvcHRpb24g
YW5kIHZlcmJvc2l0eS4KPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
