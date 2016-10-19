From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: save: close fd of
	configuration file
Date: Wed, 19 Oct 2016 15:49:06 -0400
Message-ID: <CA+jJMxt2s-U_bmGyHWEzsGjSznFOoSL+u-3k_j3ifbJq-djrtw__32006.5670916394$1476906570$gmane$org@mail.gmail.com>
References: <1476828593-8761-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 58480A43AC
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 19:51:09 +0000 (UTC)
Received: by mail-vk0-f65.google.com with SMTP id b186so1666695vkb.3
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 12:49:07 -0700 (PDT)
In-Reply-To: <1476828593-8761-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciwgMi45LCAyLjggYW5kIDIuNy4KClRoYW5rcyEKSsOpcsOpbWllCgpP
biAxOCBPY3RvYmVyIDIwMTYgYXQgMTg6MDksIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJh
am90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRo
YW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+
ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYyAgICAgIHwgNyArKysrKysrCj4gIHNyYy9j
b21tb24vY29uZmlnL3Nlc3Npb24tY29uZmlnLmggfCA0ICsrLS0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC9zYXZlLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYwo+
IGluZGV4IDlhYzc3MTIuLjFhODc5YjIgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9zYXZlLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYwo+IEBAIC0y
MDUzLDYgKzIwNTMsMTMgQEAgZW5kOgo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4K
PiArICAgICAgIGlmIChmaWxlX29wZW5lZCkgewo+ICsgICAgICAgICAgICAgICByZXQgPSBjbG9z
ZShmZCk7Cj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpIHsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBQRVJST1IoIkNsb3NpbmcgWE1MIHNlc3Npb24gY29uZmlndXJhdGlvbiIpOwo+ICsgICAg
ICAgICAgICAgICB9Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgcmV0dXJuIHJldDsKPiAgfQo+
Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29uZmlnL3Nlc3Npb24tY29uZmlnLmggYi9zcmMv
Y29tbW9uL2NvbmZpZy9zZXNzaW9uLWNvbmZpZy5oCj4gaW5kZXggYzY0MzlmNy4uZjQ4ZmY3NCAx
MDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL2NvbmZpZy9zZXNzaW9uLWNvbmZpZy5oCj4gKysrIGIv
c3JjL2NvbW1vbi9jb25maWcvc2Vzc2lvbi1jb25maWcuaAo+IEBAIC04NSw4ICs4NSw4IEBAIGlu
dCBjb25maWdfcGFyc2VfdmFsdWUoY29uc3QgY2hhciAqdmFsdWUpOwo+ICAvKgo+ICAgKiBDcmVh
dGUgYW4gaW5zdGFuY2Ugb2YgYSBjb25maWd1cmF0aW9uIHdyaXRlci4KPiAgICoKPiAtICogZmRf
b3V0cHV0IEZpbGUgdG8gd2hpY2ggdGhlIFhNTCBjb250ZW50IG11c3QgYmUgd3JpdHRlbi4gVGhl
IGZpbGUgd2lsbCBiZQo+IC0gKiBjbG9zZWQgb25jZSB0aGUgY29uZmlnX3dyaXRlciBoYXMgYmVl
biBkZXN0cm95ZWQuCj4gKyAqIGZkX291dHB1dCBGaWxlIHRvIHdoaWNoIHRoZSBYTUwgY29udGVu
dCBtdXN0IGJlIHdyaXR0ZW4uIGZkX291dHB1dCBpcwo+ICsgKiBvd25lZCBieSB0aGUgY2FsbGVy
Lgo+ICAgKgo+ICAgKiBpbmRlbnQgSWYgb3RoZXIgdGhhbiAwIHRoZSBYTUwgd2lsbCBiZSBwcmV0
dHkgcHJpbnRlZAo+ICAgKiB3aXRoIGluZGVudGF0aW9uIGFuZCBuZXdsaW5lLgo+IC0tCj4gMi43
LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
