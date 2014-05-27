From: Jon Bernard <jbernard@debian.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Tue, 27 May 2014 16:42:50 -0400
Message-ID: <20140527204250.GA31395__43308.7996360429$1401223440$gmane$org@helmut>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <20140523222124.GA25594@helmut>
 <97D83BC6-DF7B-4A23-A0DA-22EBEF7E7A62@sury.org>
 <400506412.22279.1400936702676.JavaMail.zimbra@efficios.com>
 <20140524145555.GA1466@helmut>
 <1851915699.22366.1400979572920.JavaMail.zimbra@efficios.com>
 <1401182846.16183.121907449.6882165F@webmail.messagingengine.com>
 <20140527201848.GA27628@helmut>
 <1220472134.23571.1401222994845.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WpOD2-0003nk-O4
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 16:43:02 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9142821861
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 16:42:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1220472134.23571.1401222994845.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, lttng-dev <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

KiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90
ZToKPiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gPiBGcm9tOiAiSm9uIEJlcm5hcmQi
IDxqYmVybmFyZEBkZWJpYW4ub3JnPgo+ID4gVG86ICJPbmTFmWVqIFN1csO9IiA8b25kcmVqQHN1
cnkub3JnPgo+ID4gQ2M6ICJNYXRoaWV1IERlc25veWVycyIgPG1hdGhpZXUuZGVzbm95ZXJzQGVm
ZmljaW9zLmNvbT4sICJNaWNoYWVsIEplYW5zb24iIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+LCAi
bHR0bmctZGV2Igo+ID4gPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+Cj4gPiBTZW50OiBUdWVz
ZGF5LCBNYXkgMjcsIDIwMTQgNDoxODo0OCBQTQo+ID4gU3ViamVjdDogUmU6IERlYmlhbiBzcGVj
aWZpYyB1c2Vyc3BhY2UgUkNVIGNvbmZpZ3VyZSBvdmVycmlkZQo+ID4gCj4gPiAqIE9uZMWZZWog
U3Vyw70gPG9uZHJlakBzdXJ5Lm9yZz4gd3JvdGU6Cj4gPiA+IE9uIFN1biwgTWF5IDI1LCAyMDE0
LCBhdCAyOjU5LCBNYXRoaWV1IERlc25veWVycyB3cm90ZToKPiA+ID4gPiBXaHkgYXJlIGVhY2gg
cGFja2FnZSBjb21waWxlZCBhZ2FpbnN0IGNvbXBsZXRlbHkgZGlmZmVyZW50IHRhcmdldHMgPwo+
ID4gPiAKPiA+ID4gdXJjdSBpbnZva2VzIC4vY29uZmlndXJlIG1hbnVhbGx5IHdoaWxlIGx0dC1j
b250cm9sIHVzZXMKPiA+ID4gZGhfYXV0b19jb25maWd1cmUgd3JhcHBlciBhbmQgdGhhdCBtYWtl
cyB0aGUgZGlmZmVyZW5jZQo+ID4gCj4gPiBUaGlzIGlzIGNvcnJlY3QuICBXaGVuIEkgZmlyc3Qg
c2F3IHRoZSBkaWZmZXJlbmNlLCBJIGFzc3VtZWQgdGhleSB3b3VsZAo+ID4gYm90aCBpbnZva2Ug
Y29uZmlndXJlIGluIGEgd2F5IHRoYXQgd291bGRuJ3QgZWZmZWN0IHRoZSB0YXJnZXQuICBCdXQg
bm93Cj4gPiBJIHJlbWVtYmVyIGhhdmluZyBhIHNpbWlsYXIgcHJvYmxlbSBvbiBzcGFyYyAod2hp
Y2ggaXMgd2h5IHVyY3UgaW5jbHVkZXMKPiA+IHRoaXMgb3ZlcnJpZGUpIHdoZXJlIHRoZSB0YXJn
ZXQgZGlzY292ZXJ5IHdhcyBub3QgY29ycmVjdC4KPiA+IAo+ID4gSXQgbG9va3MgdG8gbWUgbGlr
ZSBhIGJ1ZyByZWxhdGVkIHRvIGRlYmhlbHBlciAod2hpY2ggcHJvdmlkZXMKPiA+IGRoX2F1dG9f
Y29uZmlndXJlKS4gIEZvciBub3csIEkgdGhpbmsgdGhpcyBvdmVycmlkZSBhcHBsaWVkIHRvCj4g
PiBsdHRuZy10b29scyB3aWxsIGNvcnJlY3RseSBmaXggdGhlIGJ1aWxkIHdpdGhvdXQgZGlzYWJs
aW5nIGRtYi4gIEkgd2lsbAo+ID4gbGV0IHRoZSBleGlzdGluZyB0cmFuc2l0aW9uIGludG8gdGVz
dGluZyBjb21wbGV0ZSBhbmQgdGhlbiBzdWJtaXQgbmV3Cj4gPiBwYWNrYWdlcy4KPiAKPiBUaGUg
YmlnIHF1ZXN0aW9uIGhlcmU6IGlzIGl0IE9LIHRvIGdlbmVyYXRlICJkbWIiIGluc3RydWN0aW9u
ID8gSWYgdGhlCj4gaW50ZW50IG9mIHRoaXMgYXJjaGl0ZWN0dXJlIHN1cHBvcnQgaXMgdG8gY292
ZXIgZWFybGllci10aGFuLWFybXY3IEFSTQo+IHByb2Nlc3NvcnMsIHRoZW4gImRtYiIgc2hvdWxk
IG5vdCBiZSBleHBsaWNpdGx5IGdlbmVyYXRlZCwgYW5kIHRoZXJlZm9yZQo+IFVSQ1UgY29uZmln
dXJhdGlvbiB3b3VsZCBuZWVkIGZpeGluZy4gSWYgdGhlIGludGVudCBvZiB0aGlzIERlYmlhbiBh
cmNoCj4gaXMgdG8gY292ZXIgb25seSBBUk12NyBhbmQgYmV0dGVyLCB0aGVuIGl0J3MgbHR0bmct
dG9vbHMgdGhhdCBuZWVkcwo+IGZpeGluZy4KCkkgd2FzIGFzc3VtaW5nIHRoZSBsYXR0ZXIsIHRo
YXQgb25seSBBUk12NyBhbmQgYmV0dGVyIHdvdWxkIGJlIGNvdmVyZWQsCmJ1dCB0aGlzIGlzIGEg
dmVyeSBnb29kIHBvaW50IGFuZCBJIHdpbGwgc2VlayBjbGFyaWZpY2F0aW9uIGJlZm9yZQpJIG1h
a2UgYW55IGNoYW5nZXMuICBJIHdpbGwgbGV0IHlvdSBrbm93IHdoYXQgSSBmaW5kIG91dC4KCi0t
IApKb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
