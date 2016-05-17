From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 14/24] Fix: illegal memory
 access in syscall_init_table
Date: Tue, 17 May 2016 11:55:14 -0400
Message-ID: <CA+jJMxsE2Sb=c4+vYYeYizkAKEHcf=Hnwm_-BDT=7v+cLVg85A__44652.8223030784$1463500525$gmane$org@mail.gmail.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463449383-6553-15-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 695EEA353E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 15:55:15 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id l68so1823996qkf.3
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 08:55:15 -0700 (PDT)
In-Reply-To: <1463449383-6553-15-git-send-email-mathieu.desnoyers@efficios.com>
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

T24gTW9uLCBNYXkgMTYsIDIwMTYgYXQgOTo0MiBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gRm91bmQgYnkgQ292ZXJpdHk6Cj4g
Q0lEIDEyNDMwMjEgKCMxIG9mIDEpOiBCdWZmZXIgbm90IG51bGwgdGVybWluYXRlZAo+IChCVUZG
RVJfU0laRV9XQVJOSU5HKTI1LiBidWZmZXJfc2l6ZV93YXJuaW5nOiBDYWxsaW5nIHN0cm5jcHkg
d2l0aCBhCj4gbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDI1NSBieXRlcyBvbiBkZXN0aW5hdGlv
biBhcnJheSAoc3lzY2FsbF90YWJsZSArCj4gaW5kZXgpLm5hbWUgb2Ygc2l6ZSAyNTUgYnl0ZXMg
bWlnaHQgbGVhdmUgdGhlIGRlc3RpbmF0aW9uIHN0cmluZwo+IHVudGVybWluYXRlZC4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5jIHwgNyArKysr
Ky0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxsLmMgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYwo+IGluZGV4IDdhZTY2ODIuLjAyZmVjMTUgMTAwNjQ0
Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxsLmMKPiArKysgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYwo+IEBAIC0xMDgsOCArMTA4LDExIEBAIGludCBzeXNj
YWxsX2luaXRfdGFibGUodm9pZCkKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAg
ICBzeXNjYWxsX3RhYmxlW2luZGV4XS5pbmRleCA9IGluZGV4Owo+ICAgICAgICAgICAgICAgICBz
eXNjYWxsX3RhYmxlW2luZGV4XS5iaXRuZXNzID0gYml0bmVzczsKPiAtICAgICAgICAgICAgICAg
c3RybmNweShzeXNjYWxsX3RhYmxlW2luZGV4XS5uYW1lLCBuYW1lLAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN5c2NhbGxfdGFibGVbaW5kZXhdLm5hbWUpKTsKPiAr
ICAgICAgICAgICAgICAgaWYgKGx0dG5nX3N0cm5jcHkoc3lzY2FsbF90YWJsZVtpbmRleF0ubmFt
ZSwgbmFtZSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzeXNjYWxs
X3RhYmxlW2luZGV4XS5uYW1lKSkpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAt
RUlOVkFMOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7CgpUaGlzIHdpbGwg
bGVhayBzeXNjYWxsX3RhYmxlLiBJIGhhdmUgbWFkZSB0aGUgY2hhbmdlIGluIHRoZSBtZXJnZWQK
dmVyc2lvbiAoZnJlZSgpIGFuZCBzZXQgdG8gTlVMTCkuCgpKw6lyw6ltaWUKCj4gKyAgICAgICAg
ICAgICAgIH0KPiAgICAgICAgICAgICAgICAgLyoKPiAgICAgICAgICAgICAgICAgREJHKCJTeXNj
YWxsIG5hbWUgJyVzJyBhdCBpbmRleCAlIiBQUkl1MzIgIiBvZiBiaXRuZXNzICV1IiwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5c2NhbGxfdGFibGVbaW5kZXhdLm5hbWUsCj4g
LS0KPiAyLjEuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
Zwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYKCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3
LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
