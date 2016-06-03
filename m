From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [PATCH userspace-rcu 1/2] Port: fix compatibility
 header for Cygwin
Date: Fri, 3 Jun 2016 08:55:12 -0400
Message-ID: <57517E30.8040905__39864.005908794$1464958477$gmane$org@gydle.com>
References: <574FA191.8030609@gydle.com>
 <278023320.26578.1464935321566.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A608BA3781
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 12:54:14 +0000 (UTC)
In-Reply-To: <278023320.26578.1464935321566.JavaMail.zimbra@efficios.com>
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

VGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoZXMuCgpJIG5vdGljZWQgdGhhdCBJIHNo
b3VsZCBoYXZlIHNlbmQgYW4gZW1haWwgd2l0aCAiW1BBVENIIHVzZXJzcGFjZS1yY3UgMC8yXSIg
aW4gdGhlIHN1YmplY3QKYmVmb3JlIHNlbmRpbmcgdGhlIDIgb3RoZXJzLgoKTXkgbmV4dCBzdG9w
IGlzIGJ1aWxkaW5nIExUVG5nLVVTVCBpbiBDeWd3aW4uIEkgYW0gbm90IHNheWluZyB0aGF0IGl0
IHdpbGwgd29yaywgYnV0IGl0IHdpbGwgYmUgZnVuLgoKT24gMDYvMDMvMjAxNiAwMjoyOCBBTSwg
TWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gQm90aCBwYXRjaGVzIG1lcmdlZCBpbnRvIG1hc3Rl
ciBhbmQgc3RhYmxlLTAuOSwgdGhhbmtzIQo+IAo+IE1hdGhpZXUKPiAKPiAtLS0tLSBPbiBKdW4g
MiwgMjAxNiwgYXQgNTowMSBBTSwgU2ViYXN0aWVuIEJvaXN2ZXJ0IHNib2lzdmVydEBneWRsZS5j
b20gd3JvdGU6Cj4gCj4+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGllbiBCb2lzdmVydCA8c2JvaXN2
ZXJ0QGd5ZGxlLmNvbT4KPj4gLS0tCj4+IHVyY3Uvc3lzY2FsbC1jb21wYXQuaCB8IDQgKysrKwo+
PiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS91cmN1
L3N5c2NhbGwtY29tcGF0LmggYi91cmN1L3N5c2NhbGwtY29tcGF0LmgKPj4gaW5kZXggOWI5YWZl
Yy4uZDYwM2RiMiAxMDA2NDQKPj4gLS0tIGEvdXJjdS9zeXNjYWxsLWNvbXBhdC5oCj4+ICsrKyBi
L3VyY3Uvc3lzY2FsbC1jb21wYXQuaAo+PiBAQCAtMzEsNiArMzEsMTAgQEAKPj4gI2luY2x1ZGUg
PHN5cy9zeXNjYWxsLmg+Cj4+ICNlbGlmIGRlZmluZWQoX19saW51eF9fKSB8fCBkZWZpbmVkKF9f
R0xJQkNfXykKPj4gI2luY2x1ZGUgPHN5c2NhbGwuaD4KPj4gKwo+PiArI2VsaWYgZGVmaW5lZChf
X0NZR1dJTl9fKQo+PiArLyogRG9uJ3QgaW5jbHVkZSBhbnl0aGluZyBvbiBDeWd3aW4uICovCj4+
ICsKPj4gI2Vsc2UKPj4gI2Vycm9yICJBZGQgcGxhdGZvcm0gc3VwcG9ydCB0byB1cmN1L3N5c2Nh
bGwtY29tcGF0LmgiCj4+ICNlbmRpZgo+PiAtLQo+PiAyLjguMwo+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cj4+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
