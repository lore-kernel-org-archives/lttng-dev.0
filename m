From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: add missing
	sys/types.h header
Date: Fri, 18 Mar 2016 16:34:06 -0400
Message-ID: <CA+jJMxv29T488FDQUnE7EbtLudmqma5CQMC+EzrB7MPO1csnzw__7549.38529939881$1458333268$gmane$org@mail.gmail.com>
References: <17f5fc70d86b42e09f71fc46f6dfbd85b9ee3eaf.1457441705.git.baruch@tkos.co.il>
 <97a27dbdf6ed5397497eb4d76302be2a0b11a993.1457441705.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
 [209.85.213.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5C876A2D58
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2016 20:34:07 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id kc10so4175421igb.3
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2016 13:34:07 -0700 (PDT)
In-Reply-To: <97a27dbdf6ed5397497eb4d76302be2a0b11a993.1457441705.git.baruch@tkos.co.il>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIGFyZSBtZXJnZWQgaW4gbWFzdGVyLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9u
IFR1ZSwgTWFyIDgsIDIwMTYgYXQgNzo1NSBBTSwgQmFydWNoIFNpYWNoIDxiYXJ1Y2hAdGtvcy5j
by5pbD4gd3JvdGU6Cj4gVGhlIG11c2wgQyBsaWJyYXJ5IHJlcXVpcmVzIGluY2x1c2lvbiBvZiBz
eXMvdHlwZXMuaCBmb3IgbW9kZV90Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQmFydWNoIFNpYWNoIDxi
YXJ1Y2hAdGtvcy5jby5pbD4KPiAtLS0KPiAgc3JjL2NvbW1vbi9ydW5hcy5oIHwgMSArCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24v
cnVuYXMuaCBiL3NyYy9jb21tb24vcnVuYXMuaAo+IGluZGV4IDJjNTU2NWFmMzY0Ni4uYWMxMTQz
ZWVjZjg0IDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vcnVuYXMuaAo+ICsrKyBiL3NyYy9jb21t
b24vcnVuYXMuaAo+IEBAIC0xOSw2ICsxOSw3IEBACj4gICAqIDUxIEZyYW5rbGluIFN0cmVldCwg
RmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCj4gICAqLwo+Cj4gKyNpbmNs
dWRlIDxzeXMvdHlwZXMuaD4KPiAgI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICAjaW5jbHVkZSA8cHRo
cmVhZC5oPgo+Cj4gLS0KPiAyLjcuMAo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIElu
Yy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
