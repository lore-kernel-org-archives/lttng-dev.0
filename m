From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 11/13] Refactor sessiond
 main/cleanup/ht-cleanup
Date: Tue, 6 Jan 2015 23:09:25 +0000 (UTC)
Message-ID: <1325833094.35434.1420585765681.JavaMail.zimbra__24064.2225057401$1420585852$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1418867124-17343-12-git-send-email-mathieu.desnoyers@efficios.com>
 <CA+jJMxvjRY0E0v2=PK9ZDurKB3Yjob=LCaB1yo6PpezX-E40Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Y8dFe-0004xu-P0
 for lttng-dev@lists.lttng.org; Tue, 06 Jan 2015 18:09:30 -0500
In-Reply-To: <CA+jJMxvjRY0E0v2=PK9ZDurKB3Yjob=LCaB1yo6PpezX-E40Xg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJKw6lyw6ltaWUgR2FsYXJuZWF1
IiA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgo+IFRvOiAiTWF0aGlldSBEZXNub3ll
cnMiIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gQ2M6ICJKZXJlbWllIEdhbGFy
bmVhdSIgPGpnYWxhckBlZmZpY2lvcy5jb20+LCBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
U2VudDogVHVlc2RheSwgSmFudWFyeSA2LCAyMDE1IDM6NTk6NTMgUE0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIGx0dG5nLXRvb2xzIDExLzEzXSBSZWZhY3RvciBzZXNzaW9uZCBtYWluL2NsZWFudXAv
aHQtY2xlYW51cAo+IAo+ID4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvaHQt
Y2xlYW51cC5jCj4gPiBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvaHQtY2xlYW51cC5jCj4gPiBp
bmRleCAwNDY5ZjkyLi43OWZiOWNkIDEwMDY0NAo+ID4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC9odC1jbGVhbnVwLmMKPiA+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvaHQtY2xl
YW51cC5jCj4gPiBAQCAtNDcsNyArNDcsNyBAQCB2b2lkICp0aHJlYWRfaHRfY2xlYW51cCh2b2lk
ICpkYXRhKQo+ID4KPiA+ICAgICAgICAgaGVhbHRoX2NvZGVfdXBkYXRlKCk7Cj4gPgo+ID4gLSAg
ICAgICByZXQgPSBzZXNzaW9uZF9zZXRfdGhyZWFkX3BvbGxzZXQoJmV2ZW50cywgMik7Cj4gPiAr
ICAgICAgIHJldCA9IHNlc3Npb25kX3NldF9odF9jbGVhbnVwX3RocmVhZF9wb2xsc2V0KCZldmVu
dHMsIDIpOwo+IAo+IFdvbid0IHRoaXMgcmVzdWx0IGluIGFkZGluZyB0aGUgaHRfY2xlYW51cF9x
dWl0X3BpcGUgdHdpY2UgdG8gdGhlCj4gcG9sbHNldD8gKHNlZSBsaW5lIDU2IGluCj4gbHR0bmct
dG9vbHMvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9odC1jbGVhbnVwLmMpCgpOby4gaHRfY2xlYW51
cF9xdWl0X3BpcGUgYW5kIGh0X2NsZWFudXBfcGlwZSBhcmUgdHdvIGRpZmZlcmVudApwaXBlcy4K
ClsuLi5dCgo+ID4KPiA+IC0gICAgICAgREJHKCJDbGVhbmluZyB1cCIpOwo+ID4gKyAgICAgICBE
QkcoIkNsZWFudXAgdXAgc2Vzc2lvbmQiKTsKPiAKPiBTbGlnaHQgdHlwbyBoZXJlLiBJJ2xsIGZp
eCBpdCBvbiBteSBlbmQuCgpvawoKVGhhbmtzIQoKTWF0aGlldQoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
