From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix: per-pid ust buffers flush race with
	application unregister
Date: Wed, 24 Feb 2016 11:47:49 -0500
Message-ID: <CA+jJMxvCgYk=tCdjwpPZ8KPgr3oZeo=fwHS8+K+1aBAmyCrdEg__42717.5524332144$1456332539$gmane$org@mail.gmail.com>
References: <1456274500-9781-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f172.google.com ([209.85.223.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aYcbT-0007ML-EK
 for lttng-dev@lists.lttng.org; Wed, 24 Feb 2016 11:47:56 -0500
Received: by mail-io0-f172.google.com with SMTP id g203so51107005iof.2
 for <lttng-dev@lists.lttng.org>; Wed, 24 Feb 2016 08:47:55 -0800 (PST)
In-Reply-To: <1456274500-9781-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNywgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBU
dWUsIEZlYiAyMywgMjAxNiBhdCA3OjQxIFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBJZiBhbiBhcHBsaWNhdGlvbiBleGl0cyBi
ZXR3ZWVuIHRoZSBtb21lbnQgd2UgY3JlYXRlIHRoZSB1c3QgYXBwIHNlc3Npb24KPiAoc2hhZG93
IGNvcHkpIGFuZCB0aGUgbW9tZW50IHdlIHNlbmQgY2hhbm5lbHMgdG8gdGhlIGFwcGxpY2F0aW9u
LAo+IHNlbmRpbmcgY2hhbm5lbHMgbWF5IGZhaWwuIElmIHRoZSBhcHBsaWNhdGlvbiB1bnJlZ2lz
dGVycyBiZXR3ZWVuIHRoZQo+IHRoZSBlbmQgb2YgdXN0IGFwcCBzZXNzaW9uIGNyZWF0aW9uIGFu
ZCB0aGUgZGVzdHJveSB0aGF0IGZvbGxvd3MgKHVzdAo+IGFwcCBzZXNzaW9uIGxvY2sgaXMgcmVs
ZWFzZWQgaW4gYmV0d2VlbiksIHdlIG1heSBzZWUgaXNfc2VudCBiZWluZwo+IGZhbHNlLgo+Cj4g
VGhpcyBhc3NlcnQgd2FzIGluaXRpYWxseSB0aGVyZSBpbiB0aGUgZWFybHkgZGF5cyBvZiBsdHRu
Zy10b29scyB3aGVuCj4gdGhlIGFwcGxpY2F0aW9uIHdhcyByZXNwb25zaWJsZSBmb3IgZG9pbmcg
dGhlIGZsdXNoLiBOb3cgdGhhdCB0aGUgZmx1c2gKPiBoYXMgYmVlbiBtb3ZlZCB0byB0aGUgY29u
c3VtZXIgZGFlbW9uLCB3ZSBkb24ndCBuZWVkIHRoaXMgYXNzZXJ0aW9uCj4gYW55bW9yZS4KPgo+
IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5jIHwgMSAt
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC91c3QtYXBwLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1h
cHAuYwo+IGluZGV4IDhjNDVhODkuLjE2MGExNTYgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC91c3QtYXBwLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1h
cHAuYwo+IEBAIC00NDY5LDcgKzQ0NjksNiBAQCBpbnQgdXN0X2FwcF9mbHVzaF9hcHBfc2Vzc2lv
bihzdHJ1Y3QgdXN0X2FwcCAqYXBwLAo+ICAgICAgICAgICAgICAgICBjZHNfbGZodF9mb3JfZWFj
aF9lbnRyeSh1YV9zZXNzLT5jaGFubmVscy0+aHQsICZpdGVyLml0ZXIsIHVhX2NoYW4sCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBub2RlLm5vZGUpIHsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBoZWFsdGhfY29kZV91cGRhdGUoKTsKPiAtICAgICAgICAgICAgICAgICAgICAg
ICBhc3NlcnQodWFfY2hhbi0+aXNfc2VudCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gY29uc3VtZXJfZmx1c2hfY2hhbm5lbChzb2NrZXQsIHVhX2NoYW4tPmtleSk7Cj4gICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHJldCkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRVJSKCJFcnJvciBmbHVzaGluZyBjb25zdW1lciBjaGFubmVsIik7Cj4gLS0KPiAyLjEu
NAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
