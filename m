From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: uninitialized return
	value
Date: Mon, 26 Jan 2015 11:03:09 -0500
Message-ID: <CA+jJMxtbFsBuHrPCrEK-F=zzoFDNctKFVNtpmHVLDXYEHCKHYg__2832.9691071578$1422288260$gmane$org@mail.gmail.com>
References: <1422030540-3544-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YFm8B-0005C9-AT
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 11:03:19 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so7559093qcz.6
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 08:03:09 -0800 (PST)
In-Reply-To: <1422030540-3544-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Qm90aCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGFsbCB0aGUgd2F5IGJhY2sgdG8gMi40LgoKVGhhbmtz
IQpKw6lyw6ltaWUKCk9uIEZyaSwgSmFuIDIzLCAyMDE1IGF0IDExOjI4IEFNLCBNYXRoaWV1IERl
c25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQt
b2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
Pgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYyB8IDQgKystLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5jIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC91c3QtYXBwLmMKPiBpbmRleCA0MWE2ZDM5Li5iZGVlOGU2IDEwMDY0NAo+IC0tLSBh
L3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC91c3QtYXBwLmMKPiBAQCAtNDEzMiw3ICs0MTMyLDcgQEAgc3RhdGljCj4gIGludCB1
c3RfYXBwX2ZsdXNoX3Nlc3Npb24oc3RydWN0IGx0dF91c3Rfc2Vzc2lvbiAqdXNlc3MpCj4KPiAg
ewo+IC0gICAgICAgaW50IHJldDsKPiArICAgICAgIGludCByZXQgPSAwOwo+Cj4gICAgICAgICBE
QkcoIkZsdXNoaW5nIHNlc3Npb24gYnVmZmVycyBmb3IgYWxsIHVzdCBhcHBzIik7Cj4KPiBAQCAt
NDE3Myw3ICs0MTczLDYgQEAgaW50IHVzdF9hcHBfZmx1c2hfc2Vzc2lvbihzdHJ1Y3QgbHR0X3Vz
dF9zZXNzaW9uICp1c2VzcykKPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBQdXNoIG1ldGFk
YXRhLiAqLwo+ICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lkKSBwdXNoX21ldGFkYXRhKHVz
dF9zZXNzaW9uX3JlZywgdXNlc3MtPmNvbnN1bWVyKTsKPiAgICAgICAgICAgICAgICAgfQo+IC0g
ICAgICAgICAgICAgICByZXQgPSAwOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAg
IH0KPiAgICAgICAgIGNhc2UgTFRUTkdfQlVGRkVSX1BFUl9QSUQ6Cj4gQEAgLTQxOTIsNiArNDE5
MSw3IEBAIGludCB1c3RfYXBwX2ZsdXNoX3Nlc3Npb24oc3RydWN0IGx0dF91c3Rfc2Vzc2lvbiAq
dXNlc3MpCj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgfQo+ICAgICAgICAgZGVm
YXVsdDoKPiArICAgICAgICAgICAgICAgcmV0ID0gLTE7Cj4gICAgICAgICAgICAgICAgIGFzc2Vy
dCgwKTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICB9Cj4gLS0KPiAyLjEuMQo+
CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZp
Y2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
