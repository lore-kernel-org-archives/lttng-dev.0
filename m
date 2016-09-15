From: David Aldrich <David.Aldrich@EMEA.NEC.COM>
Subject: Re: Beginner question: how to inspect scheduling of
 multi-threaded user application?
Date: Thu, 15 Sep 2016 16:17:55 +0000
Message-ID: <8281eb71ce434a57a206182955d6be52__40900.7655726329$1473956300$gmane$org@EUX13SRV1.EU.NEC.COM>
References: <35de22c3d2034f3abb75596477b23e3a@EUX13SRV1.EU.NEC.COM>
 <CADcCL0hqkvEPZEu85GzJnJKi9nOi0wntpOYoVz37QhcRVpb+=g@mail.gmail.com>
 <CAF4oYfHJCGnmmDfNokV2029Kp_8k7n1rCt4CX=OaLrLKEc_5wg@mail.gmail.com>
 <CAF4oYfHyRe1KmbAgy4eKk6oDVWvZp+TP3SRXZ+BuJf5iWwEQwQ@mail.gmail.com>
 <022bc22a602e4631903ee12b6dd1be6c@EUX13SRV1.EU.NEC.COM>
 <02c06e3a-06ad-0c77-c3b2-bb9ab1dc3995@efficios.com>
 <bf4d2ea2d4844db0bf0511d48cade46d@EUX13SRV1.EU.NEC.COM>
 <646123a6-aed5-0b8e-bafa-ca9dfed6d802@efficios.com>
 <af8ddfb9c34443618a768264ee4f059f@EUX13SRV1.EU.NEC.COM>
 <5f03ae09-bc3a-8e14-0611-bb06b614d981@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cluster-e.mailcontrol.com (cluster-e.mailcontrol.com
 [85.115.58.190])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0F518A313D
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 16:18:58 +0000 (UTC)
In-Reply-To: <5f03ae09-bc3a-8e14-0611-bb06b614d981@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

VGhhbmsgeW91LCB0aGluZ3MgYXJlIGxvb2tpbmcgbXVjaCBiZXR0ZXIgbm93Lg0KDQpEYXZpZA0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvbmF0aGFuIFJham90dGUg
SnVsaWVuIFttYWlsdG86Sm9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tXQ0KPiBT
ZW50OiAxNSBTZXB0ZW1iZXIgMjAxNiAxNjo1MA0KPiBUbzogRGF2aWQgQWxkcmljaCA8RGF2aWQu
QWxkcmljaEBFTUVBLk5FQy5DT00+OyBsdHRuZy0NCj4gZGV2QGxpc3RzLmx0dG5nLm9yZw0KPiBT
dWJqZWN0OiBSZTogW2x0dG5nLWRldl0gQmVnaW5uZXIgcXVlc3Rpb246IGhvdyB0byBpbnNwZWN0
IHNjaGVkdWxpbmcgb2YNCj4gbXVsdGktdGhyZWFkZWQgdXNlciBhcHBsaWNhdGlvbj8NCj4gDQo+
IEhpLA0KPiANCj4gT24gMjAxNi0wOS0xNSAxMTo0MSBBTSwgRGF2aWQgQWxkcmljaCB3cm90ZToN
Cj4gPiBIaSBKb25hdGhhbg0KPiA+DQo+ID4gVGhhbmtzLCBJIGhhZCBub3QgbG9nZ2VkIG91dC9p
biBhZnRlciBqb2luaW5nIHRoZSB0cmFjaW5nIGdyb3VwLg0KPiA+DQo+ID4gSSBub3cgc2VlOg0K
PiA+DQo+ID4gJCBsdHRuZyBjcmVhdGUgZGVtb19zZXNzaW9uDQo+ID4gU2Vzc2lvbiBkZW1vX3Nl
c3Npb24gY3JlYXRlZC4NCj4gPiAkIHN1ZG8gbHR0bmcgZW5hYmxlLWV2ZW50IC1rIHNjaGVkX3N3
aXRjaCAtcyBkZW1vX3Nlc3Npb24NCj4gPiBFcnJvcjogRXZlbnQgc2NoZWRfc3dpdGNoOiBLZXJu
ZWwgdHJhY2VyIG5vdCBhdmFpbGFibGUgKGNoYW5uZWwNCj4gPiBjaGFubmVsMCwgc2Vzc2lvbiBk
ZW1vX3Nlc3Npb24pDQo+ID4gV2FybmluZzogU29tZSBjb21tYW5kKHMpIHdlbnQgd3JvbmcNCj4g
Pg0KPiA+IFdoYXQgZG8gSSBuZWVkIHRvIGluc3RhbGw/DQo+IA0KPiBEaWQgeW91IGhhdmUgYSBs
b29rIGF0IGh0dHA6Ly9sdHRuZy5vcmcvZG93bmxvYWQvI3VidW50dSA/DQo+IA0KPiBJIHJlY29t
bWVuZCB0aGUgdXNlIG9mIHRoZSBwcGEgaWYgcG9zc2libGUuIEZvciBrZXJuZWwgdHJhY2luZyBt
YWtlIHN1cmUgdG8NCj4gaW5zdGFsbCB0aGUgbHR0bmctbW9kdWxlcy1ka21zLg0KPiANCj4gTWFr
ZSBzdXJlIHRoZXJlIGlzIG5vdCBlcnJvciBkdXJpbmcgdGhlIGluc3RhbGxhdGlvbi4gSXQgbWln
aHQgaGFwcGVuIGJ1dA0KPiBzaG91bGQgbm90IDopIC4NCj4gDQo+IElmIGl0J3Mgbm90IGRvbmUg
YWxyZWFkeSBtYWtlIHN1cmUgdG8gZHJvcCBieSBodHRwOi8vbHR0bmcub3JnL2RvY3MvI2RvYy0N
Cj4gZ2V0dGluZy1zdGFydGVkIGZvciBtb3JlIGluZm9ybWF0aW9ucy4NCj4gDQo+IENoZWVycw0K
PiANCj4gPg0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+DQo+ID4gRGF2aWQNCj4gDQo+IC0tDQo+IEpv
bmF0aGFuIFIuIEp1bGllbg0KPiBFZmZpY2lvcw0KPiANCj4gDQo+IA0KPiAgQ2xpY2sNCj4gaHR0
cHM6Ly93d3cubWFpbGNvbnRyb2wuY29tL3NyLytQWkNFY3BqeTVuR1gyUFFQT212VXNhSFRUSEUy
V0hMbEkNCj4gZ044VEtVeVB2WSswOVVuR2phSUNMVVErUmJhb1psMHRpMXlzM3RBaHVKUmNFTk9w
YVA3QT09ICB0byByZXBvcnQNCj4gdGhpcyBlbWFpbCBhcyBzcGFtLg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
