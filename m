From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Bug#751337: [PATCH] tests: test_ctf_writer: replace
	HOST_NAME_MAX
Date: Thu, 7 Aug 2014 15:07:08 -0400
Message-ID: <CA+jJMxv2baZmUL=jG1UOXoCm6jHVVzQt6bO_=jDmny+-UX_8xQ__29042.1721096665$1407438496$gmane$org@mail.gmail.com>
References: <20140805200251.GA17716@breakpoint.cc>
 <20140805201412.GA11272@helmut>
 <20140806070324.GA2888@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f178.google.com ([74.125.82.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1XFT1u-0002Hd-Nb
 for lttng-dev@lists.lttng.org; Thu, 07 Aug 2014 15:07:20 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so4734562wes.9
 for <lttng-dev@lists.lttng.org>; Thu, 07 Aug 2014 12:07:08 -0700 (PDT)
In-Reply-To: <20140806070324.GA2888@breakpoint.cc>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: 751337@bugs.debian.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Rml4ZWQgaW4gYm90aCBtYXN0ZXIgKGFzIG9mIDIyODQzYjYpIGFuZCBzdGFibGUgMS4yIChhcyBv
ZiAwOTU0NjcwKSBicmFuY2hlcy4KCk9uIFdlZCwgQXVnIDYsIDIwMTQgYXQgMzowMyBBTSwgU2Vi
YXN0aWFuIEFuZHJ6ZWogU2lld2lvcgo8c2ViYXN0aWFuQGJyZWFrcG9pbnQuY2M+IHdyb3RlOgo+
IE9uIDIwMTQtMDgtMDUgMTY6MTQ6MTIgWy0wNDAwXSwgSm9uIEJlcm5hcmQgd3JvdGU6Cj4+IFRo
aXMgbWF5IGFsc28gd29yayBhcyB3ZWxsOgo+Pgo+PiAgICAgZGlmZiAtLWdpdCBhL2NvbmZpZ3Vy
ZS5hYyBiL2NvbmZpZ3VyZS5hYwo+PiAgICAgaW5kZXggODBlYmEzMy4uMjQ4MDQ0ZSAxMDA2NDQK
Pj4gICAgIC0tLSBhL2NvbmZpZ3VyZS5hYwo+PiAgICAgKysrIGIvY29uZmlndXJlLmFjCj4+ICAg
ICBAQCAtNTAsNiArNTAsMTcgQEAgQUNfQ19JTkxJTkUKPj4gICAgICBBQ19UWVBFX1BJRF9UCj4+
ICAgICAgQUNfVFlQRV9TSVpFX1QKPj4KPj4gICAgICsjIEZyZWVCU0QgZG9lcyBub3QgZGVmaW5l
IEhPU1RfTkFNRV9NQVgKPj4gICAgICtBQ19DSEVDS19ERUNMKEhPU1RfTkFNRV9NQVgsLAo+PiAg
ICAgKyAgICAgICBbCj4+ICAgICArICAgICAgICBBQ19DSEVDS19ERUNMKF9QT1NJWF9IT1NUX05B
TUVfTUFYLAo+PiAgICAgKyAgICAgICAgICAgICAgICAgICAgICBBQ19ERUZJTkUoSE9TVF9OQU1F
X01BWCwgX1BPU0lYX0hPU1RfTkFNRV9NQVgsIFtdKSwKPj4gICAgICsgICAgICAgICAgICAgICAg
ICAgICAgQUNfREVGSU5FKEhPU1RfTkFNRV9NQVgsIDI1NiwgW0RlZmluZSB0byAyNTYgaWYgbmVp
dGhlciBoYXZlIEhPU1RfTkFNRV9NQVggbm9yIF9QT1NJWF9IT1NUX05BTUVfTUFYXSksCj4+ICAg
ICArICAgICAgICAgICAgICAgICAgICAgIFtbI2luY2x1ZGUgPGxpbWl0cy5oPl1dKQo+PiAgICAg
KyAgICAgICBdLAo+PiAgICAgKyAgICAgICBbWyNpbmNsdWRlIDxsaW1pdHMuaD5dXQo+PiAgICAg
KykKPgo+IFN1cmUgaXQgd2lsbC4gSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uIG9uIGhvdyBpdCBn
ZXRzIGZpeGVkIDopCj4KPj4gICAgICsKPj4gICAgICAjIENoZWNrcyBmb3IgbGlicmFyeSBmdW5j
dGlvbnMuCj4+ICAgICAgQUNfRlVOQ19NQUxMT0MKPj4gICAgICBBQ19GVU5DX01NQVAKPj4KPgo+
IFNlYmFzdGlhbgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
