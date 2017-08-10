From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Port: Add glib checks for cross compilation
Date: Thu, 10 Aug 2017 15:21:39 -0400
Message-ID: <CA+jJMxuzUfTEAC7rzEpO77hHg9WS_vmR5VL0mcekrzj1mQxu=A__31419.1500693143$1502392918$gmane$org@mail.gmail.com>
References: <1502219952-17302-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3xSyg92QqGztM3
 for <lttng-dev@lists.lttng.org>; Thu, 10 Aug 2017 19:21:40 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id s143so1017295ywg.4
 for <lttng-dev@lists.lttng.org>; Thu, 10 Aug 2017 12:21:40 -0700 (PDT)
In-Reply-To: <1502219952-17302-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDggQXVndXN0IDIwMTcgYXQgMTU6MTksIE1p
Y2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgY29u
ZmlndXJlLmFjIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmln
dXJlLmFjCj4gaW5kZXggYjliYjZiNC4uNjYyNWI1OCAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUu
YWMKPiArKysgYi9jb25maWd1cmUuYWMKPiBAQCAtNjI2LDYgKzYyNiwzMCBAQCBBQ19TVUJTVChB
TV9DUFBGTEFHUykKPiAgIyBBZGQgZ2xpYiB0byBnbG9iYWwgbGluayBsaWJzCj4gIExJQlM9IiRM
SUJTICRHTElCX0xJQlMiCj4KPiArIyBDaGVjayB0aGF0IHRoZSBjdXJyZW50IHNpemVfdCBtYXRj
aGVzIHRoZSBzaXplIHRoYXQgZ2xpYiB0aGlua3MgaXQgc2hvdWxkCj4gKyMgYmUuIFRoaXMgY2F0
Y2hlcyBwcm9ibGVtcyBvbiBtdWx0aS1hcmNoIHdoZXJlIHBlb3BsZSB0cnkgdG8gZG8gYSAzMi1i
aXQKPiArIyBidWlsZCB3aGlsZSBwb2ludGluZyBhdCA2NC1iaXQgZ2xpYiBoZWFkZXJzLiBUaGlz
IGlzIGEgY29tbW9uIGVycm9yIGJlY2F1c2UKPiArIyBnbGliLmggaXMgbm90IHBsYXRmb3JtIHNw
ZWNpZmljIGJ1dCBpdCBpbmNsdWRlcyBnbGliY29uZmlnLmggd2hpY2ggaXMgYW5kCj4gKyMgaXMg
dXN1YWxseSBpbnN0YWxsZWQgaW4gYSBub24tc3RhbmRhcmQgcGF0aC4KPiArCj4gK3NhdmVfQ0ZM
QUdTPSR7Q0ZMQUdTfQo+ICtDRkxBR1M9IiR7Q0ZMQUdTfSAke0FNX0NGTEFHU30iCj4gK0FDX0NP
TVBJTEVfSUZFTFNFKFsKPiArICBBQ19MQU5HX1BST0dSQU0oW2RubAo+ICsjaW5jbHVkZSA8Z2xp
Yi5oPgo+ICsjaW5jbHVkZSA8dW5pc3RkLmg+Cj4gKyAgXSwgW2RubAo+ICtHX1NUQVRJQ19BU1NF
UlQoc2l6ZW9mKHNpemVfdCkgPT0gR0xJQl9TSVpFT0ZfU0laRV9UKTsKPiArICBdKQo+ICtdLFs6
XSxbCj4gKyAgQUNfTVNHX0VSUk9SKFtkbmwKPiArc2l6ZW9mKHNpemVfdCkgZG9lc24ndCBtYXRj
aCBHTElCX1NJWkVPRl9TSVpFX1QuIFlvdSBwcm9iYWJseSBuZWVkIHRvIHNldAo+ICtQS0dfQ09O
RklHX0xJQkRJUiB0byBwb2ludCB0byB0aGUgcmlnaHQgcGtnLWNvbmZpZyBmaWxlcyBmb3IgeW91
ciBidWlsZAo+ICt0YXJnZXQuCj4gKyAgXSkKPiArXSkKPiArQ0ZMQUdTPSR7c2F2ZV9DRkxBR1N9
Cj4gKwo+ICAjIEFidXNlIGF1dG9jb25mJ3MgQUNfQVJHX1BST0dSQU0gb3V0cHV0IHZhcmlhYmxl
ICdwcm9ncmFtX3RyYW5zZm9ybV9uYW1lJwo+ICAjIHRvIHJlbmFtZSBiYWJlbHRyYWNlLmJpbiB0
byBiYWJlbHRyYWNlIGF0IGluc3RhbGwgdGltZS4KPiAgcHJvZ3JhbV90cmFuc2Zvcm1fbmFtZT0i
cyZiYWJlbHRyYWNlXC5iaW4mYmFiZWx0cmFjZSY7cyZiYWJlbHRyYWNlLWxvZ1wuYmluJmJhYmVs
dHJhY2UtbG9nJjskcHJvZ3JhbV90cmFuc2Zvcm1fbmFtZSIKPiAtLQo+IDIuNy40Cj4KCgoKLS0g
CkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
