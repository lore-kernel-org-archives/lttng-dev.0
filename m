From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Test: xsd validation of
 long path (length > 255)
Date: Mon, 4 Apr 2016 12:50:27 -0400
Message-ID: <CA+jJMxucDoYJ=Wvh_5xzcc-HutF7s_4Yp79MRbLs+fYGJgM_YQ__45955.5064364851$1459788651$gmane$org@mail.gmail.com>
References: <1459291596-12311-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f194.google.com (mail-ig0-f194.google.com
 [209.85.213.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0C7BDA2F4B
 for <lttng-dev@lists.lttng.org>; Mon,  4 Apr 2016 16:50:29 +0000 (UTC)
Received: by mail-ig0-f194.google.com with SMTP id qu10so9472302igc.1
 for <lttng-dev@lists.lttng.org>; Mon, 04 Apr 2016 09:50:28 -0700 (PDT)
In-Reply-To: <1459291596-12311-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGFsb25nIHdpdGggdGhlIHNlY29uZCBwYXRjaCdzICJ2MiIsIHRoYW5rcyEKCkrDqXLD
qW1pZQoKT24gVHVlLCBNYXIgMjksIDIwMTYgYXQgNjo0NiBQTSwgSm9uYXRoYW4gUmFqb3R0ZQo8
am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2Zm
LWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5j
b20+Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVzdF9taSB8IDI1ICsrKysr
KysrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL21p
L3Rlc3RfbWkgYi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL21pL3Rlc3RfbWkKPiBpbmRleCBlOGMw
MzJjLi5mM2QyYzMzIDEwMDc1NQo+IC0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVz
dF9taQo+ICsrKyBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVzdF9taQo+IEBAIC01OSw3
ICs1OSw3IEBAIERFVk5VTEw9L2Rldi9udWxsIDI+JjEKPgo+ICBESVI9JChyZWFkbGluayAtZiAk
VEVTVERJUikKPgo+IC1OVU1fVEVTVFM9MjI0Cj4gK05VTV9URVNUUz0yMjgKPgo+ICBzb3VyY2Ug
JFRFU1RESVIvdXRpbHMvdXRpbHMuc2gKPgo+IEBAIC0yNDYsNiArMjQ2LDI4IEBAIGZ1bmN0aW9u
IHRlc3RfbGlzdF9zZXNzaW9ucyAoKQo+ICAgICAgICAgZGVzdHJveV9sdHRuZ19zZXNzaW9ucwo+
ICB9Cj4KPiArZnVuY3Rpb24gdGVzdF9saXN0X3Nlc3Npb25fbG9uZ19wYXRoICgpCj4gK3sKPiAr
ICAgICAgIGxvY2FsIHNlc3Npb25fbmFtZT0ic2Vzc2lvbl9sb25nX3BhdGgiCj4gKwo+ICsgICAg
ICAgb3V0cHV0X2Jhc2VkaXI9JE9VVFBVVF9ESVIvJChyYW5kc3RyaW5nIDI1NCAwKQo+ICsgICAg
ICAgbWtkaXIgLXAgJHtvdXRwdXRfYmFzZWRpcn0KPiArCj4gKyAgICAgICBPVVRQVVRfRklMRT0i
bGlzdF9zZXNzaW9ucy54bWwiCj4gKwo+ICsgICAgICAgI1Rlc3QgYnVpbGQgdXAKPiArICAgICAg
IE9VVFBVVF9ERVNUPSRERVZOVUxMCj4gKyAgICAgICBjcmVhdGVfbHR0bmdfc2Vzc2lvbl9vayAk
c2Vzc2lvbl9uYW1lICR7b3V0cHV0X2Jhc2VkaXJ9Cj4gKwo+ICsgICAgICAgT1VUUFVUX0RFU1Q9
JHtvdXRwdXRfYmFzZWRpcn0vJE9VVFBVVF9GSUxFCj4gKyAgICAgICBsaXN0X2x0dG5nX3dpdGhf
b3B0cwo+ICsgICAgICAgJFhNTF9WQUxJREFURSAkT1VUUFVUX0RFU1QKPiArICAgICAgIG9rICQ/
ICJNaSB0ZXN0OiBsaXN0IHNlc3Npb24gd2l0aCBsb25nIHBhdGggeHNkIHZhbGlkYXRpb24iCj4g
Kwo+ICsgICAgICAgI1RlYXJkb3duCj4gKyAgICAgICBPVVRQVVRfREVTVD0kREVWTlVMTAo+ICsg
ICAgICAgZGVzdHJveV9sdHRuZ19zZXNzaW9ucwo+ICt9Cj4gIGZ1bmN0aW9uIHRlc3RfdXN0X2No
YW5uZWwgKCkKPiAgewo+ICAgICAgICAgbG9jYWwgc2Vzc2lvbl9uYW1lPSJ0ZXN0c2Vzc2lvbiIK
PiBAQCAtODcxLDYgKzg5Myw3IEBAIFRFU1RTPSgKPiAgICAgICAgIHRlc3Rfc3RhcnRfc3RvcAo+
ICAgICAgICAgdGVzdF9zbmFwc2hvdAo+ICAgICAgICAgdGVzdF90cmFja191bnRyYWNrCj4gKyAg
ICAgICB0ZXN0X2xpc3Rfc2Vzc2lvbl9sb25nX3BhdGgKPiAgKQo+Cj4KPiAtLQo+IDIuNy4wCj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKCgotLSAK
SsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
