From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: question about  rcu_bp_exit()
Date: Thu, 19 May 2016 12:53:08 -0700
Message-ID: <20160519195308.GX3528__29544.8604076684$1463687618$gmane$org@linux.vnet.ibm.com>
References: <6db07fb4.c6e5.154c340296f.Coremail.songxin_1980@126.com>
 <971830834.12745.1463596803434.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 62BBDA35E3
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 19:53:09 +0000 (UTC)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:53:07 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C3CFA19D805C
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 13:52:45 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4JJr3Bw42074334
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 19:53:03 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4JJr2MR004043
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 15:53:02 -0400
Content-Disposition: inline
In-Reply-To: <971830834.12745.1463596803434.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBNYXkgMTgsIDIwMTYgYXQgMDY6NDA6MDNQTSArMDAwMCwgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4gLS0tLS0gT24gTWF5IDE4LCAyMDE2LCBhdCA1OjQ0IEFNLCBzb25neGluIDxz
b25neGluXzE5ODBAMTI2LmNvbT4gd3JvdGU6IAo+IAo+ID4gSGksCj4gPiBOb3cgSSBnZXQgYSBj
cmFzaCBiZWNhdXNlIHJlY2VpdmluZyBzaWduYWwgU0lHU0VHViBhcyBiZWxvdy4KPiAKPiA+ICMw
IGFyZW5hX2FsbG9jIChhcmVuYT08b3B0aW1pemVkIG91dD4pIGF0Cj4gPiAvdXNyL3NyYy9kZWJ1
Zy9saWJ1cmN1LzAuOS4xK2dpdDVmZDMzYjFlNTAwM2NhMzE2YmQzMTRlYzNmZDE0NDdmNjE5OWEy
ODItcjAvZ2l0L3VyY3UtYnAuYzo0MzIKPiA+ICMxIGFkZF90aHJlYWQgKCkgYXQKPiA+IC91c3Iv
c3JjL2RlYnVnL2xpYnVyY3UvMC45LjErZ2l0NWZkMzNiMWU1MDAzY2EzMTZiZDMxNGVjM2ZkMTQ0
N2Y2MTk5YTI4Mi1yMC9naXQvdXJjdS1icC5jOjQ2Mgo+ID4gIzIgcmN1X2JwX3JlZ2lzdGVyICgp
IGF0Cj4gPiAvdXNyL3NyYy9kZWJ1Zy9saWJ1cmN1LzAuOS4xK2dpdDVmZDMzYjFlNTAwM2NhMzE2
YmQzMTRlYzNmZDE0NDdmNjE5OWEyODItcjAvZ2l0L3VyY3UtYnAuYzo1NDEKPiAKPiA+IEkgcmVh
ZCB0aGUgY29kZSBvZiB1cmN1LWJwLmMgYW5kIGZvdW5kIHRoYXQgImlmIChjaHVuay0+ZGF0YV9s
ZW4gLSBjaHVuay0+dXNlZCA8Cj4gPiBsZW4pIiBpcyBpbiA0MzIgbGluZS4gU28gSSBndWVzcyB0
aGF0IHRoZSBjaHVuayBpcyBhIGlsbGVnYWwgcG9pbnRlci4KPiA+IEJlbG93IGlzIHRoZSBmdW5j
dGlvbiByY3VfYnBfZXhpdCgpLgo+IAo+ID4gc3RhdGljCj4gPiB2b2lkIHJjdV9icF9leGl0KHZv
aWQpCj4gPiB7Cj4gPiBtdXRleF9sb2NrKCZpbml0X2xvY2spOwo+ID4gaWYgKCEtLXJjdV9icF9y
ZWZjb3VudCkgewo+ID4gc3RydWN0IHJlZ2lzdHJ5X2NodW5rICpjaHVuaywgKnRtcDsKPiA+IGlu
dCByZXQ7Cj4gCj4gPiBjZHNfbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGNodW5rLCB0bXAsCj4g
PiAmcmVnaXN0cnlfYXJlbmEuY2h1bmtfbGlzdCwgbm9kZSkgewo+ID4gbXVubWFwKGNodW5rLCBj
aHVuay0+ZGF0YV9sZW4KPiA+ICsgc2l6ZW9mKHN0cnVjdCByZWdpc3RyeV9jaHVuaykpOwo+ID4g
fQo+ID4gcmV0ID0gcHRocmVhZF9rZXlfZGVsZXRlKHVyY3VfYnBfa2V5KTsKPiA+IGlmIChyZXQp
Cj4gPiBhYm9ydCgpOwo+ID4gfQo+ID4gbXV0ZXhfdW5sb2NrKCZpbml0X2xvY2spOwo+ID4gfQo+
IAo+ID4gTXkgcXVlc3Rpb24gaXMgYmVsb3cuCj4gPiBXaHkgZGlkIG5vdCBkZWxldGUgdGhlIGNo
dW5rIGZyb20gcmVnaXN0cnlfYXJlbmEuY2h1bmtfbGlzdCBiZWZvcmUgbXVubWFwIGEKPiA+IGNo
dW5rPwo+IAo+IEl0IGlzIG5vdCBleHBlY3RlZCB0aGF0IGFueSB0aHJlYWQgd291bGQgYmUgY3Jl
YXRlZCBhZnRlciB0aGUgZXhlY3V0aW9uIG9mIAo+IHJjdV9icF9leGl0KCkgYXMgYSBsaWJyYXJ5
IGRlc3RydWN0b3IuIERvZXMgcmUtaW5pdGlhbGl6aW5nIHRoZSBjaHVua19saXN0IGFmdGVyIAo+
IGl0ZXJhdGluZyBvbiBpdCB3aXRoaW4gcmN1X2JwX2V4aXQoKSBmaXggeW91ciBpc3N1ZSA/IAo+
IAo+IEknbSBjdXJpb3VzIGFib3V0IHlvdXIgdXNlLWNhc2UgZm9yIGNyZWF0aW5nIHRocmVhZHMg
YWZ0ZXIgdGhlIGxpYnJhcnkgZGVzdHJ1Y3RvciAKPiBoYXMgcnVuLiAKCkkgYW0gd2l0aCBNYXRo
aWV1IG9uIHRoaXMgLS0gbm90IG11Y2ggZ29vZCBjYW4gYmUgZXhwZWN0ZWQgdXNpbmcgdGhpbmdz
CmFmdGVyIHRoZWlyIGNsZWFudXAuICBUaG91Z2ggSSBzdXBwb3NlIHRoYXQsIGdpdmVuIGEgc3Vm
ZmljaWVudCB1c2UgY2FzZSwKdGhlcmUgY291bGQgYXQgbGVhc3QgaW4gdGhlb3J5IGJlIGFuIG9w
dGlvbiBmb3IgbWFudWFsIGNvbnRyb2wgb2YgY2xlYW51cC4KCgkJCQkJCQlUaGFueCwgUGF1bAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
