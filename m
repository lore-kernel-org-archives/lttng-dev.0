From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [Patch LTTng-ust 6/7] Add the macros to generate
 the data structures for CTF named enumerations
Date: Thu, 30 Jan 2014 20:55:19 -0500
Message-ID: <52EB0287.4000105__25095.2946990312$1391133377$gmane$org@mentor.com>
References: <1390593885-7463-1-git-send-email-gbastien+lttng@versatic.net>	<1390593885-7463-7-git-send-email-gbastien+lttng@versatic.net>
	<1490865069.16181.1391132259063.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1W93KJ-0005tE-Eu
	for lttng-dev@lists.lttng.org; Thu, 30 Jan 2014 20:55:31 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1W93KD-0001PP-2Y from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 30 Jan 2014 17:55:21 -0800
In-Reply-To: <1490865069.16181.1391132259063.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMDEvMzAvMjAxNCAwODozNyBQTSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gLS0tLS0g
T3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+PiBGcm9tOiAiR2VuZXZpw6h2ZSBCYXN0aWVuIiA8Z2Jh
c3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0Pgo+PiBUbzogbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
Zwo+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjQsIDIwMTQgMzowNDo0NCBQTQo+PiBTdWJqZWN0
OiBbbHR0bmctZGV2XSBbUGF0Y2ggTFRUbmctdXN0IDYvN10gQWRkIHRoZSBtYWNyb3MgdG8gZ2Vu
ZXJhdGUgdGhlCWRhdGEgc3RydWN0dXJlcyBmb3IgQ1RGIG5hbWVkIGVudW1lcmF0aW9ucwo+Pgo+
PiBGaWxscyB0aGUgbWFjcm9zIHRvIGluaXRpYWxpemUgdGhlIG1ldGFkYXRhIGZvciBhIHRyYWNl
cG9pbnQuCj4+Cj4+IEZyb20gdGhpcyBwYXRjaCBvbiwgdGhlIG5hbWVkIG1ldGFkYXRhIGFyZSBl
bmFibGVkLgo+IE5vdyB0aGF0IEkgdGhpbmsgYWJvdXQgaXQsICJuYW1lZCBtZXRhZGF0YSIgZG9l
cyBub3Qgc2VlbSB0byBiZSBzZW1hbnRpY2FsbHkgY2xlYXIuCj4gUGVyaGFwcyB3ZSBjb3VsZCBj
aGFuZ2UgdGhpcyB0byAiZ2xvYmFsIHR5cGUgZGVjbGFyYXRpb25zIiA/IEJlY2F1c2UgdGhpcyBp
cyByZWFsbHkKPiB3aGF0IGl0IGlzOiB0eXBlIGRlY2xhcmF0aW9ucyB0aGF0IGFyZSBpbiB0aGUg
Z2xvYmFsIHNjb3BlIG9mIHRoZSBtZXRhZGF0YS4gVGhpcyBhcHBsaWVzCj4gdG8gYWxsIG90aGVy
IHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMuCgpNYXRoaWV1LAoKSSBtYXkgYmUgbWlzdW5kZXJzdGFu
ZGluZyB3aGF0IHlvdSBpbnRlbmQgdG8gcmVsYWJlbCBhcyAiZ2xvYmFsIHR5cGUKZGVjbGFyYXRp
b25zIiwgYnV0IEkgYmVsaWV2ZSB0aGUgdGVybSBpcyB0b28gcmVzdHJpY3RpdmUuCkknbSBmb2xs
b3dpbmcgdGhpcyBkaXNjdXNzaW9uIHdpdGggaW50ZXJlc3QsIGFzIEkgaGF2ZSBhbm90aGVyIHVz
ZS1jYXNlCmZvciBtZXRhLWRhdGEgd2hpY2ggbWlnaHQgYmUgaW1wbGVtZW50YWJsZSB2ZXJ5IG11
Y2ggbGlrZSB0aGUgbmFtZWQKZW51bXM6IGNvbnN0YW50IG9yICJldmVudC1zdGF0aWMiIGZpZWxk
cy4gRm9yIGV4YW1wbGUsIHdlIG1heSB3YW50IHRvCnN0b3JlIG51bWVyaWMgdmFsdWVzIGluIGV2
ZW50cyB0aGF0IG5lZWQgYSAoY29uc3RhbnQpIHNjYWxlIGZhY3RvciAoYQp1bml0IG9mIG1lYXN1
cmVtZW50KSwgd2hpY2ggd291bGQgYmUgd2VsbCByZXByZXNlbnRlZCBpbiBtZXRhLWRhdGEsIGFz
Cm9wcG9zZWQgdG8gcmVkdW5kYW50bHkgaW5zaWRlIGV2ZW50cy4KQW5kIHNvLCB3aGlsZSBJIGFn
cmVlIHRvIHlvdXIgY2hhcmFjdGVyaXphdGlvbiBvZiBuYW1lZCBlbnVtZXJhdGlvbnMgYXMKdHlw
ZSBkZWNsYXJhdGlvbnMsIEknbSBzdGlsbCBsb29raW5nIGF0IHRoZSBtZWNoYW5pc20gYXMgZW5h
YmxpbmcgdGhlCnN0b3JhZ2Ugb2YgbmFtZWQgbWV0YS1kYXRhLgoKClRoYW5rcywKICAgICAgICBT
dGVmYW4KCi0tIApTdGVmYW4gU2VlZmVsZApDb2RlU291cmNlcnkgLyBNZW50b3IgR3JhcGhpY3MK
aHR0cDovL3d3dy5tZW50b3IuY29tL2VtYmVkZGVkLXNvZnR3YXJlLwoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
