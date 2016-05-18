From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Integer overflowed argument
Date: Wed, 18 May 2016 14:24:18 -0400
Message-ID: <CA+jJMxtZtABgTxLm=nfF5oisskwZT2cfZh3DES2wY1s_rjFC_w__43299.7160511606$1463595880$gmane$org@mail.gmail.com>
References: <1463490699-18390-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D9B47A3588
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:24:19 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id z70so8362qge.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 11:24:19 -0700 (PDT)
In-Reply-To: <1463490699-18390-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDk6MTEg
QU0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IEZvdW5kIGJ5IENvdmVyaXR5Ogo+Cj4gQ0lEIDEyNDIzMTcgKCMxIG9mIDIpOiBJbnRl
Z2VyIG92ZXJmbG93ZWQgYXJndW1lbnQgKElOVEVHRVJfT1ZFUkZMT1cpMjUuCj4gb3ZlcmZsb3df
c2luazogT3ZlcmZsb3dlZCBvciB0cnVuY2F0ZWQgdmFsdWUgKG9yIGEgdmFsdWUgY29tcHV0ZWQg
ZnJvbQo+IGFuIG92ZXJmbG93ZWQgb3IgdHJ1bmNhdGVkIHZhbHVlKSBuZXdfbmJtZW0gKiAzMDRV
TCB1c2VkIGFzIGNyaXRpY2FsCj4gYXJndW1lbnQgdG8gZnVuY3Rpb24uCj4KPiBDSUQgMTI0MjMx
NyAoIzIgb2YgMik6IEludGVnZXIgb3ZlcmZsb3dlZCBhcmd1bWVudCAoSU5URUdFUl9PVkVSRkxP
VykyNy4KPiBvdmVyZmxvd19zaW5rOiBPdmVyZmxvd2VkIG9yIHRydW5jYXRlZCB2YWx1ZSAob3Ig
YSB2YWx1ZSBjb21wdXRlZCBmcm9tCj4gYW4gb3ZlcmZsb3dlZCBvciB0cnVuY2F0ZWQgdmFsdWUp
IChuZXdfbmJtZW0gLSBuYm1lbSkgKiAzMDRVTCB1c2VkIGFzCj4gY3JpdGljYWwgYXJndW1lbnQg
dG8gZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25k
L3N5c2NhbGwuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxs
LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYwo+IGluZGV4IDAyZmVjMTUuLmNi
YzhjZGYgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxsLmMKPiAr
KysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYwo+IEBAIC04Miw3ICs4Miw3IEBA
IGludCBzeXNjYWxsX2luaXRfdGFibGUodm9pZCkKPgo+ICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIERvdWJsZSBtZW1vcnkgc2l6ZS4gKi8KPiAgICAgICAgICAgICAgICAgICAgICAgICBuZXdf
bmJtZW0gPSBtYXgoaW5kZXgsIG5ibWVtIDw8IDEpOwo+IC0gICAgICAgICAgICAgICAgICAgICAg
IGlmIChuZXdfbmJtZW0gPCBuYm1lbSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChu
ZXdfbmJtZW0gPiBTSVpFX01BWCAvIHNpemVvZigqbmV3X2xpc3QpKSB7Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBPdmVyZmxvdywgc3RvcCBldmVyeXRoaW5nLCBzb21ldGhp
bmcgd2VudCByZWFsbHkgd3JvbmcuICovCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBFUlIoIlN5c2NhbGwgbGlzdGluZyBtZW1vcnkgc2l6ZSBvdmVyZmxvdy4gU3RvcHBpbmciKTsK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUoc3lzY2FsbF90YWJsZSk7Cj4g
LS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0
cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
