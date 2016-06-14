From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu AC_FUNC_MALLOC fails for cross-compile
Date: Tue, 14 Jun 2016 16:33:19 +0000 (UTC)
Message-ID: <389089988.35928.1465921999056.JavaMail.zimbra__646.484390790825$1465923095$gmane$org@efficios.com>
References: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54@indiana.edu>
 <418211441.35787.1465921264498.JavaMail.zimbra@efficios.com>
 <AB895F8E-7C42-43C6-AA36-CAE3B353E86A@indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 378F5A3887
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 16:33:20 +0000 (UTC)
In-Reply-To: <AB895F8E-7C42-43C6-AA36-CAE3B353E86A@indiana.edu>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Luke K D'Alessandro <ldalessa@indiana.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gSnVuIDE0LCAyMDE2LCBhdCAxMjoyNiBQTSwgTHVrZSBLIEQnQWxlc3NhbmRybyBs
ZGFsZXNzYUBpbmRpYW5hLmVkdSB3cm90ZToKCj4+IE9uIEp1biAxNCwgMjAxNiwgYXQgMTI6MjEg
UE0sIE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4+
IHdyb3RlOgo+PiAKPj4gLS0tLS0gT24gSnVuIDE0LCAyMDE2LCBhdCAxMjoxMiBQTSwgTHVrZSBL
IEQnQWxlc3NhbmRybyBsZGFsZXNzYUBpbmRpYW5hLmVkdQo+PiB3cm90ZToKPj4gCj4+PiBUaGUg
QUNfRlVOQ19NQUxMT0MgZGVwZW5kcyBvbiBzb21lIHJ1bnRpbWUgcmVzdWx0cyB3aGljaCBkb2Vz
bid0IHdvcmsgd2hlbiBjcm9zcwo+Pj4gY29tcGlsaW5nLiBHb29nbGUgaGFzIGEgYml0IHRvIHNh
eSBhYm91dCB0aGlzIGFuZCBiYXNpY2FsbHkgdGhlIGZpeCBpcyB0byBzdG9wCj4+PiB1c2luZyB0
aGUgbWFjcm8uIElzIHRoZXJlIGEgc3BlY2lmaWMgcHVycG9zZSBmb3IgdGhpcyBjaGVjaywgb3Ig
Y291bGQgaXQganVzdAo+Pj4gYmUgZWxpbWluYXRlZCBmcm9tIGNvbmZpZ3VyZS5hYz8KPj4gCj4+
IElmIHdlIHJlbW92ZSB0aGlzIGNoZWNrLCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IFVSQ1UgZG9l
cyBub3QgZGVwZW5kCj4+IG9uIG1hbGxvYygwKSByZXR1cm5pbmcgbm9uLU5VTEwgYW55d2hlcmUu
Cj4gCj4gT2theSwgSeKAmW0gbm90IHN1cmUgd2hhdCB0aGUgaW1wbGljYXRpb25zIGFyZSB0aGlz
IGZvciB5b3UuIFdlIGhhdmUgYSB0ZXN0Cj4gaW5mcmFzdHJ1Y3R1cmUgdGhhdCB0cmllcyB0byBk
b3dubG9hZCwgYnVpbGQsIGFuZCBsaW5rIGxpYnVyY3UgdXNpbmcgYSBjcm9zcwo+IGNvbXBpbGVy
IGZvciAzMi1iaXQgYXJtIHBsYXRmb3JtcywgYnV0IGl0IGZhaWxzIGJlY2F1c2Ugb2YgdGhpcyBj
aGVjay4gSSB3aWxsCj4gdHJ5IGFuZCBmaWd1cmUgb3V0IGhvdyB0byBnZXQgYSBiaW5hcnkgdmVy
c2lvbiBvZiBsaWJ1cmN1IGluc3RhbGxlZCBwZXJtYW5lbnRseQo+IHNvbWV3aGVyZSB0aGF0IHRo
ZSBjcm9zcyBjb21waWxlciB0b29sY2hhaW4gY2FuIGZpbmQuCgpDYW4geW91IGdpdmUgdXMgc29t
ZSBkZXRhaWxzIG9uIGhvdyBpdCBmYWlscyA/Cgpjb25maWd1cmUgb3V0cHV0IGFuZCBjb25maWcu
bG9nCgpUaGFua3MsCgpNYXRoaWV1CgoKPiAKPiBUaGFua3MsCj4gTHVrZQo+IAo+PiAKPj4gVGhh
bmtzLAo+PiAKPj4gTWF0aGlldQo+PiAKPj4+IAo+Pj4gVGhhbmtzLAo+Pj4gTHVrZQo+Pj4gCj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+Pj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+Pj4gaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+
PiAKPj4gLS0KPj4gTWF0aGlldSBEZXNub3llcnMKPj4gRWZmaWNpT1MgSW5jLgo+ID4gaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
