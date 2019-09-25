From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Test pid_ns in local build
Date: Wed, 25 Sep 2019 14:03:50 -0400
Message-ID: <CA+jJMxtPN3NdSPKTzoFa0hW37sG-pSwDmVXf4g3mxzR+ixQrqg__8206.28076778434$1569434693$gmane$org@mail.gmail.com>
References: <5a49b436d1cd4659b96dfcaffe63b38e@SVR-IES-MBX-04.mgc.mentorg.com>
 <e01b5c8b-9534-e726-e5cd-eb499ef3bc43@efficios.com>
 <8132a2ff30f649c49c50246545302804@SVR-IES-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46dmD40Mglzqbf
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 14:04:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 72E3B335DF6
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 14:04:29 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id IASh6yl6F7PK for <lttng-dev@lists.lttng.org>;
 Wed, 25 Sep 2019 14:04:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D692F335DD7
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 14:04:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id sonQWSxkX_WZ for <lttng-dev@lists.lttng.org>;
 Wed, 25 Sep 2019 14:04:28 -0400 (EDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by mail.efficios.com (Postfix) with ESMTPSA id 84E4D335DC3
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 14:04:28 -0400 (EDT)
Received: by mail-lf1-f43.google.com with SMTP id t8so4888950lfc.13
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 11:04:28 -0700 (PDT)
In-Reply-To: <8132a2ff30f649c49c50246545302804@SVR-IES-MBX-04.mgc.mentorg.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Polzer, Franz" <Franz_Polzer@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCAxOSBTZXAgMjAxOSBhdCAwMjoxMiwgUG9semVyLCBGcmFueiA8RnJhbnpfUG9semVy
QG1lbnRvci5jb20+IHdyb3RlOgo+Cj4gSGkgTWljaGFlbCwKPgo+IE1hbnkgdGhhbmtzIGZvciB5
b3VyIGhlbHAhCj4KPiBJcyB0aGVyZSBhbnkgc2NoZWR1bGUgYnJpbmdpbmcgdGhhdCBmZWF0dXJl
IGludG8gTFRUbmcgbWFzdGVyPwoKSGksCgpJIGNhbid0IGdpdmUgeW91IGFuIGV4YWN0IHRpbWUg
bGluZSwgYnV0IHdpdGhpbiB0aGUgbmV4dCAzLTQgd2Vla3MuCgpKw6lyw6ltaWUKCj4KPiBUaGFu
a3MgYW5kIGJyLAo+IEZyYW56Cj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206
IGx0dG5nLWRldiBbbWFpbHRvOmx0dG5nLWRldi1ib3VuY2VzQGxpc3RzLmx0dG5nLm9yZ10gT24g
QmVoYWxmIE9mIE1pY2hhZWwgSmVhbnNvbgo+IFNlbnQ6IERpZW5zdGFnLCAxNy4gU2VwdGVtYmVy
IDIwMTkgMTY6MDYKPiBUbzogbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IFN1YmplY3Q6IFJl
OiBbbHR0bmctZGV2XSBUZXN0IHBpZF9ucyBpbiBsb2NhbCBidWlsZAo+Cj4gT24gMjAxOS0wOS0x
NyA0OjAzIGEubS4sIFBvbHplciwgRnJhbnogd3JvdGU6Cj4gPiBIZWxsbywKPiA+Cj4gPiBJIHdh
bnRlZCB0byBnaXZlIHRoZSBwaWRfbnMgY29udGV4dCB0cmFjaW5nIGEgdHJ5IGFuZCBidWlsdCBM
VFRuZyBmcm9tCj4gPiBtYXN0ZXIsIGJ1dCBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4g
YXBwbHlpbmcgdGhpcyBjb21tYW5kOgo+ID4KPiA+IGx0dG5nIGFkZC1jb250ZXh0IC1rIC10IHBy
b2NuYW1lIC10IHBpZCAtdCB2cGlkIC10IHRpZCAtdCB2dGlkIC10Cj4gPiBwaWRfbnMKPiA+Cj4g
PiBFcnJvcjogVW5rbm93biBjb250ZXh0IHR5cGUgcGlkX25zCj4gPgo+ID4gTWF5YmUgSSBuZWVk
IGFub3RoZXIgYnJhbmNoIHRvIGJ1aWxkIGZyb20gdG8gZ2V0IHRoYXQgZmVhdHVyZSBpbiBvcgo+
ID4gZm9yZ290IHRvIGVuYWJsZSB0aGUgZmVhdHVyZSBkdXJpbmcgYnVpbGRpbmc/Cj4gPgo+ID4g
V2hlcmUgY2FuIEkgZmluZCBkb2N1bWVudGF0aW9uIGFib3V0IHRoZSBwaWRfbnMgdHJhY2luZyBh
bmQgaG93IHRvCj4gPiB0ZXN0IHRoZSBjdXJyZW50IHZlcnNpb24gb2YgdGhhdCBpbXBsZW1lbnRh
dGlvbj8KPiA+Cj4gPiBUaGFua3MgZm9yIHlvdXIgaGVscCBhbmQgYmVzdCByZWdhcmRzLAo+ID4K
PiA+IEZyYW56Cj4KPgo+IEhpLAo+Cj4gVGhlIG5hbWVzcGFjZSBzdGF0ZWR1bXAgYW5kIGNvbnRl
eHRzIGZlYXR1cmUgaGFzIG5vdCBiZWVuIG1lcmdlZCBpbiBtYXN0ZXIgeWV0LiBZb3UgY2FuIGdl
dCBpdCBmcm9tIG15IGdpdGh1YiBpbiB0aGUgIm5zIiBmZWF0dXJlIGJyYW5jaGVzLgo+Cj4gaHR0
cHM6Ly9naXRodWIuY29tL21qZWFuc29uL2x0dG5nLW1vZHVsZXMvdHJlZS9ucwo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9tamVhbnNvbi9sdHRuZy11c3QvdHJlZS9ucwo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9tamVhbnNvbi9sdHRuZy10b29scy90cmVlL25zCj4KPiBJdCdzIGEgYml0IG91dCBvZiBkYXRl
IGJ1dCBzaG91bGQgd29yayBhcy1pcywgb3IgaXQgY2FuIGJlIGVhc2lseSByZWJhc2VkIG9uIGN1
cnJlbnQgbWFzdGVyIGJyYW5jaGVzLgo+Cj4KPiBDaGVlcnMsCj4KPiBNaWNoYWVsCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKCgotLSAKSsOpcsOpbWllIEdhbGFy
bmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
