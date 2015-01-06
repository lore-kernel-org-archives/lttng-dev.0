From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 11/13] Refactor sessiond
	main/cleanup/ht-cleanup
Date: Tue, 6 Jan 2015 18:31:41 -0500
Message-ID: <CA+jJMxtRGncWEC+t1z8F15dSuvBUa6EMsseDE+Ci+bPDY-+ukA__14422.8652622134$1420587204$gmane$org@mail.gmail.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1418867124-17343-12-git-send-email-mathieu.desnoyers@efficios.com>
 <CA+jJMxvjRY0E0v2=PK9ZDurKB3Yjob=LCaB1yo6PpezX-E40Xg@mail.gmail.com>
 <1325833094.35434.1420585765681.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Y8dbH-00055H-3I
 for lttng-dev@lists.lttng.org; Tue, 06 Jan 2015 18:31:48 -0500
Received: by mail-qg0-f43.google.com with SMTP id z107so197194qgd.30
 for <lttng-dev@lists.lttng.org>; Tue, 06 Jan 2015 15:31:41 -0800 (PST)
In-Reply-To: <1325833094.35434.1420585765681.JavaMail.zimbra@efficios.com>
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

T24gVHVlLCBKYW4gNiwgMjAxNSBhdCA2OjA5IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdl
IC0tLS0tCj4+IEZyb206ICJKw6lyw6ltaWUgR2FsYXJuZWF1IiA8amVyZW1pZS5nYWxhcm5lYXVA
ZWZmaWNpb3MuY29tPgo+PiBUbzogIk1hdGhpZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3ll
cnNAZWZmaWNpb3MuY29tPgo+PiBDYzogIkplcmVtaWUgR2FsYXJuZWF1IiA8amdhbGFyQGVmZmlj
aW9zLmNvbT4sIGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPj4gU2VudDogVHVlc2RheSwgSmFu
dWFyeSA2LCAyMDE1IDM6NTk6NTMgUE0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCBsdHRuZy10b29s
cyAxMS8xM10gUmVmYWN0b3Igc2Vzc2lvbmQgbWFpbi9jbGVhbnVwL2h0LWNsZWFudXAKPj4KPj4g
PiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9odC1jbGVhbnVwLmMKPj4gPiBi
L3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvaHQtY2xlYW51cC5jCj4+ID4gaW5kZXggMDQ2OWY5Mi4u
NzlmYjljZCAxMDA2NDQKPj4gPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2h0LWNsZWFu
dXAuYwo+PiA+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvaHQtY2xlYW51cC5jCj4+ID4g
QEAgLTQ3LDcgKzQ3LDcgQEAgdm9pZCAqdGhyZWFkX2h0X2NsZWFudXAodm9pZCAqZGF0YSkKPj4g
Pgo+PiA+ICAgICAgICAgaGVhbHRoX2NvZGVfdXBkYXRlKCk7Cj4+ID4KPj4gPiAtICAgICAgIHJl
dCA9IHNlc3Npb25kX3NldF90aHJlYWRfcG9sbHNldCgmZXZlbnRzLCAyKTsKPj4gPiArICAgICAg
IHJldCA9IHNlc3Npb25kX3NldF9odF9jbGVhbnVwX3RocmVhZF9wb2xsc2V0KCZldmVudHMsIDIp
Owo+Pgo+PiBXb24ndCB0aGlzIHJlc3VsdCBpbiBhZGRpbmcgdGhlIGh0X2NsZWFudXBfcXVpdF9w
aXBlIHR3aWNlIHRvIHRoZQo+PiBwb2xsc2V0PyAoc2VlIGxpbmUgNTYgaW4KPj4gbHR0bmctdG9v
bHMvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9odC1jbGVhbnVwLmMpCj4KPiBOby4gaHRfY2xlYW51
cF9xdWl0X3BpcGUgYW5kIGh0X2NsZWFudXBfcGlwZSBhcmUgdHdvIGRpZmZlcmVudAo+IHBpcGVz
Lgo+CgpSaWdodCEgVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KCkrDqXLDqW1pZQoKPiBb
Li4uXQo+Cj4+ID4KPj4gPiAtICAgICAgIERCRygiQ2xlYW5pbmcgdXAiKTsKPj4gPiArICAgICAg
IERCRygiQ2xlYW51cCB1cCBzZXNzaW9uZCIpOwo+Pgo+PiBTbGlnaHQgdHlwbyBoZXJlLiBJJ2xs
IGZpeCBpdCBvbiBteSBlbmQuCj4KPiBvawo+Cj4gVGhhbmtzIQo+Cj4gTWF0aGlldQo+Cj4gLS0K
PiBNYXRoaWV1IERlc25veWVycwo+IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
