From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: double put on error path
Date: Wed, 19 Sep 2018 11:52:05 -0400
Message-ID: <20180919155203.GA2836__12343.7952403494$1537372213$gmane$org@gmail.com>
References: <20180911000915.29177-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by lists.lttng.org (Postfix) with ESMTPS id 42FkrV2jQdzxPD
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 11:52:10 -0400 (EDT)
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so5583313qth.1
 for <lttng-dev@lists.lttng.org>; Wed, 19 Sep 2018 08:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180911000915.29177-1-jonathan.rajotte-julien@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwLCBhbmQgc3RhYmxlLTIu
OS4KClRoYW5rcyEKSsOpcsOpbWllCgoKT24gTW9uLCBTZXAgMTAsIDIwMTggYXQgMDg6MDk6MTFQ
TSAtMDQwMCwgSm9uYXRoYW4gUmFqb3R0ZSB3cm90ZToKPiBMZXQgcmVsYXlfaW5kZXhfdHJ5X2Zs
dXNoIGJlIHJlc3BvbnNpYmxlIGZvciB0aGUgc2VsZi1yZWZlcmVuY2UgcHV0IG9uCj4gZXJyb3Ig
cGF0aC4KPiAKPiBDb2RlIGZsb3cgb2YgcmVsYXlfaW5kZXhfdHJ5X2ZsdXNoIGlzIGEgYml0IHRy
aWNreSBidXQgdGhlIG9ubHkgZXJyb3IKPiBmbG93ICh2aWEgcmVsYXlfaW5kZXhfZmlsZV93cml0
ZSkgd2lsbCBhbHdheXMgbWFyayB0aGUgaW5kZXggYXMgZmx1c2hlZAo+IGFuZCBwZXJmb3JtIHRo
ZSBzZWxmLXJlZmVyZW5jZSBwdXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0
ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmlu
L2x0dG5nLXJlbGF5ZC9tYWluLmMgfCAxMyArKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9i
aW4vbHR0bmctcmVsYXlkL21haW4uYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYwo+IGlu
ZGV4IDVhM2JjYjQzZi4uMmUyZjU4MzlmIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctcmVs
YXlkL21haW4uYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYwo+IEBAIC0yMzE4
LDggKzIzMTgsMTEgQEAgc3RhdGljIGludCByZWxheV9yZWN2X2luZGV4KGNvbnN0IHN0cnVjdCBs
dHRjb21tX3JlbGF5ZF9oZHIgKnJlY3ZfaGRyLAo+ICAJCS8qIG5vIGZsdXNoLiAqLwo+ICAJCXJl
dCA9IDA7Cj4gIAl9IGVsc2Ugewo+ICsJCS8qCj4gKwkJICogcmVsYXlfaW5kZXhfdHJ5X2ZsdXNo
IGlzIHJlc3BvbnNpYmxlIGZvciB0aGUgc2VsZi1yZWZlcmVuY2UKPiArCQkgKiBwdXQgb2YgdGhl
IGluZGV4IG9iamVjdCBvbiBlcnJvci4KPiArCQkgKi8KPiAgCQlFUlIoInJlbGF5X2luZGV4X3Ry
eV9mbHVzaCBlcnJvciAlZCIsIHJldCk7Cj4gLQkJcmVsYXlfaW5kZXhfcHV0KGluZGV4KTsKPiAg
CQlyZXQgPSAtMTsKPiAgCX0KPiAgCj4gQEAgLTMyMTcsOSArMzIyMCwxMSBAQCBzdGF0aWMgaW50
IGhhbmRsZV9pbmRleF9kYXRhKHN0cnVjdCByZWxheV9zdHJlYW0gKnN0cmVhbSwgdWludDY0X3Qg
bmV0X3NlcV9udW0sCj4gIAkJLyogTm8gZmx1c2guICovCj4gIAkJcmV0ID0gMDsKPiAgCX0gZWxz
ZSB7Cj4gLQkJLyogUHV0IHNlbGYtcmVmIGZvciB0aGlzIGluZGV4IGR1ZSB0byBlcnJvci4gKi8K
PiAtCQlyZWxheV9pbmRleF9wdXQoaW5kZXgpOwo+IC0JCWluZGV4ID0gTlVMTDsKPiArCQkvKgo+
ICsJCSAqIHJlbGF5X2luZGV4X3RyeV9mbHVzaCBpcyByZXNwb25zaWJsZSBmb3IgdGhlIHNlbGYt
cmVmZXJlbmNlCj4gKwkJICogcHV0IG9mIHRoZSBpbmRleCBvYmplY3Qgb24gZXJyb3IuCj4gKwkJ
ICovCj4gKwkJRVJSKCJyZWxheV9pbmRleF90cnlfZmx1c2ggZXJyb3IgJWQiLCByZXQpOwo+ICAJ
CXJldCA9IC0xOwo+ICAJfQo+ICBlbmQ6Cj4gLS0gCj4gMi4xNy4xCj4gCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
