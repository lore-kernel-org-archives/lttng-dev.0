From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH v2 lttng-tools master,
 2.10-rc] Introduce "--blocking-timeout" channel parameter
Date: Mon, 12 Jun 2017 18:14:17 -0400
Message-ID: <CA+jJMxv+ePiAsJ-W=6cVU3JrOCqDCMAfZB4cecgkfo7JvFDkKg__25362.5056976036$1497305666$gmane$org@mail.gmail.com>
References: <1495865859-25810-1-git-send-email-mathieu.desnoyers@efficios.com>
 <CA+jJMxs4K7XVqqdUk4CpB8=SDFh7pBAGTtNjHm6z2j0st3uxmg@mail.gmail.com>
 <397708306.11278.1497304660434.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wmnKq0gJKz11XD
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jun 2017 22:16:14 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id w143so6977548yww.1
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jun 2017 15:14:19 -0700 (PDT)
In-Reply-To: <397708306.11278.1497304660434.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAgd2l0aCB0aGUgc3VwcGxlbWVudGFyeSBj
aGVja3MuCgpUaGFua3MhCkrDqXLDqW1pZQoKT24gMTIgSnVuZSAyMDE3IGF0IDE3OjU3LCBNYXRo
aWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+
Cj4gLS0tLS0gT24gSnVuIDEyLCAyMDE3LCBhdCA1OjI4IFBNLCBKZXJlbWllIEdhbGFybmVhdSBq
ZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20gd3JvdGU6Cj4KPgo+Pj4KPj4+ICsgICAgICAg
LyogUmV0cnkgdGltZW91dCBpbiB1c2VjICovCj4+Cj4+IFRoZSB1bml0IGNvbnZlcnNpb24gaXMg
Y29uZnVzaW5nIGluIHRoaXMgcGF0Y2guCj4+Cj4+IFRoZSB1c2VyLXByb3ZpZGVkIChDTEkpIGFy
Z3VtZW50IGlzIGluIHVzZWMgYW5kIGlzIHRoZW4gY29udmVydGVkIHRvCj4+IG1zZWMgYnkgdGhl
IGNsaWVudCwgYmVmb3JlIGJlaW5nIHVzZWQgYXMgbXNlYyB3aXRoIGxpYmx0dG5nLWN0bAo+PiBm
dW5jdGlvbnMuIFRoZW4sIGl0IGlzIHJldHJpZXZlZCBhbmQgb3V0cHV0IGFzLWlzIChpbiBtc2Vj
KSBoZXJlIGFuZAo+PiBpbiB0aGUgaHVtYW4tcmVhZGFibGUgbGlzdGluZy4KPj4KPj4gSSdsbCBt
b3ZlIHRoZSB1bml0IGNvbnZlcnNpb24gdG8gYSBzaW5nbGUgcGxhY2UgKGJlZm9yZSB3ZSBoYW5k
LW9mZgo+PiB0aGUgZGVsYXkgdG8gbHR0bmctdXN0KSBzaW5jZSB0aGUgY3VycmVudCBjb252ZW50
aW9uIGlzIHRvIHN0b3JlIGFuZAo+PiBleHBvc2UgYWxsIHRpbWVycyBpbiB1c2VjLgo+Pgo+Cj4g
QXMgZGlzY3Vzc2VkLCB0aGUgQ0xJIG9ubHkgZG9lcyBhbiBvdmVyZmxvdyBjaGVjaywgbm90IGEg
Y29udmVyc2lvbi4KPiBMZXQncyBzaW1wbHkgYWRkIHRoaXMgb3ZlcmZsb3cgY2hlY2sgaW4gdGhl
IGxpYiB0b28sIHNvIHdlIGNhbgo+IHJldHVybiAiaW52YWxpZCBwYXJhbWV0ZXIiIHRvIHRoZSBj
YWxsZXIuCj4KPj4gSSdsbCBhbHNvIG9wZW4gYW4gaXNzdWUgdG8gYWRkIHRoaXMgcHJvcGVydHkg
YXMgcGFydCBvZiB0aGUKPj4gInNhdmUvbG9hZCIgZnVuY3Rpb25hbGl0eSBiZWZvcmUgdGhlIHJl
YWxlYXNlLgo+Cj4gT0ssCj4KPiBUaGFua3MhCj4KPiBNYXRoaWV1Cj4KPiAtLQo+IE1hdGhpZXUg
RGVzbm95ZXJzCj4gRWZmaWNpT1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgoKCi0t
IApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
