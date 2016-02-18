From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Use ipv6 loopback adress
	in test_uri
Date: Thu, 18 Feb 2016 17:45:20 -0500
Message-ID: <CA+jJMxv=oxN0KgJjacVxgOH_AXjfqLDj7q5YWGt5aVeaAfmkNg__10385.5862435468$1455835587$gmane$org@mail.gmail.com>
References: <1455817513-432-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aWXKA-0000o7-Dv
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 17:45:27 -0500
Received: by mail-ig0-f179.google.com with SMTP id g6so25533212igt.1
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2016 14:45:26 -0800 (PST)
In-Reply-To: <1455817513-432-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgRmViIDE4LCAyMDE2IGF0IDEyOjQ1
IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU29t
ZSBvbGRlciB2ZXJzaW9uIG9mIERlYmlhbi9VYnVudHUgYW5kIG1heWJlIG90aGVyIGRpc3Ryb3Mg
d29uJ3Qgc2V0Cj4gbG9jYWxob3N0IHRvIHBvaW50IG9uIDo6MSBpbiB0aGUgc3lzdGVtIGhvc3Rz
IGZpbGUgYW5kIHVzZSBpbnN0ZWFkIGEKPiBjdXN0b20gbmFtZSBsaWtlIGlwNi1sb2NhbGhvc3Qg
b3IgaXB2Ni1sb2NhaG9zdCB3aGljaCBpcyBub3QKPiBzdGFuZGFyZGl6ZWQgYWNyb3NzIGRpc3Ry
b3MuCj4KPiBUbyB3b3JrIGFyb3VuZCB0aGlzLCB1c2UgdGhlIGlwdjYgbG9vcGJhY2sgYWRkcmVz
cyBpbnN0ZWFkIG9mIGxvY2FsaG9zdC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNv
biA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy91bml0L3Rlc3RfdXJpLmMg
fCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy91bml0L3Rlc3RfdXJpLmMgYi90ZXN0cy91bml0L3Rl
c3RfdXJpLmMKPiBpbmRleCA0MzJlMmIzLi5jZDk1NzUzIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL3Vu
aXQvdGVzdF91cmkuYwo+ICsrKyBiL3Rlc3RzL3VuaXQvdGVzdF91cmkuYwo+IEBAIC0xMDgsNyAr
MTA4LDcgQEAgdm9pZCB0ZXN0X3VyaV9wYXJzaW5nKHZvaWQpCj4gICAgICAgICAgICAgICAgIHVy
aSA9IE5VTEw7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHNfdXJpMSA9ICJuZXQ2Oi8vbG9jYWxo
b3N0Ojg5ODkiOwo+ICsgICAgICAgc191cmkxID0gIm5ldDY6Ly9bOjoxXTo4OTg5IjsKPgo+ICAg
ICAgICAgc2l6ZSA9IHVyaV9wYXJzZShzX3VyaTEsICZ1cmkpOwo+Cj4gQEAgLTEyNSw3ICsxMjUs
NyBAQCB2b2lkIHRlc3RfdXJpX3BhcnNpbmcodm9pZCkKPiAgICAgICAgICAgIHVyaVsxXS5wb3J0
ID09IDAgJiYKPiAgICAgICAgICAgIHN0cmxlbih1cmlbMV0uc3ViZGlyKSA9PSAwICYmCj4gICAg
ICAgICAgICBzdHJjbXAodXJpWzBdLmRzdC5pcHY2LCAiOjoxIikgPT0gMCwKPiAtICAgICAgICAg
ICJVUkkgc2V0IHRvIG5ldDY6Ly9sb2NhbGhvc3Q6ODk4OSIpOwo+ICsgICAgICAgICAgIlVSSSBz
ZXQgdG8gbmV0NjovL1s6OjFdOjg5ODkiKTsKPgo+ICAgICAgICAgaWYgKHVyaSkgewo+ICAgICAg
ICAgICAgICAgICB1cmlfZnJlZSh1cmkpOwo+IC0tCj4gMi43LjAKPgoKCgotLSAKSsOpcsOpbWll
IEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
