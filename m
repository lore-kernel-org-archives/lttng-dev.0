From: Anders Wallin <wallinux@gmail.com>
Subject: Re: It should be possible to build lttng w/o the test
 clock plugin.
Date: Fri, 22 Jul 2016 09:27:17 +0200
Message-ID: <CAF2baFfRNjHdMoL1jKnJQVx1q2+f+tTzAGrxXER1=0Fsu=pRwA__2287.54937784306$1469172456$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8D646A2BA6
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 07:27:18 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id l69so6971644lfg.1
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 00:27:18 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

PiBNZXNzYWdlOiAzCj4gRGF0ZTogVHVlLCAxOSBKdWwgMjAxNiAxNTozMTowMCAtMDQwMAo+IEZy
b206IEpvbmF0aGFuIFJham90dGUgSnVsaWVuIDxKb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZp
Y2lvcy5jb20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTdWJqZWN0OiBSZTog
W2x0dG5nLWRldl0gSXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIGJ1aWxkIGx0dG5nIHcvbyB0aGUK
PiAgICAgICAgIHRlc3QgY2xvY2sgcGx1Z2luLgo+IE1lc3NhZ2UtSUQ6IDw1NTM5NjdlMS04NTVh
LTk1NGItNWEwNi01ZmQ3ZTJhYjMwOWVAZWZmaWNpb3MuY29tPgo+IENvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD11dGYtODsgZm9ybWF0PWZsb3dlZAo+Cj4gSGkgQW5kZXJzLAo+Cj4g
VGhhbmtzIGZvciB5b3VyIGNvbnRyaWJ1dGlvbi4gTWFrZSBzdXJlIHRvIGxvb2sgYXQgdGhlIGNv
bnRyaWJ1dG9yJ3MKPiBndWlkZSBbMV0uCj4KPiBbMV0gaHR0cDovL2x0dG5nLm9yZy9jb21tdW5p
dHkvI2NvbnRyaWJ1dG9ycy1ndWlkZQpXaWxsIGRvCgo+Cj4KPiBPbiAyMDE2LTA3LTE5IDAzOjE4
IFBNLCBBbmRlcnMgV2FsbGluIHdyb3RlOgo+PiBIaSwKPj4KPj4gb25seSBvbmUgY2xvY2sgcGx1
Z2luIGNhbiBiZSB1c2VkIHdoZW4gYnVpbGRpbmcgbHR0bmcgaW5zaWRlIHRoZSBrZXJuZWwuCj4+
IFRvIGJlIGFibGUgdG8gd3JpdGUgYSBjdXN0b20gY2xvY2sgcGx1Z2luIGl0IHNob3VsZCBiZSBw
b3NzaWJsZSB0byBub3QKPj4gYnVpbGQgdGhlIHRlc3QgY2xvY2sgcGx1Z2luLgo+Pgo+PiBUaGlz
IGFwcGVuZGVkIHBhdGNoIGlzIG9uZSB3YXkgdG8gbWFrZSB0aGlzIHBvc3NpYmxlLgo+Cj4gV2hh
dCB3b3VsZCBiZSB0aGUgYWx0ZXJuYXRpdmUgPwoKQSAiZGlydHkiIGFsdGVybmF0aXZlIHdvdWxk
IGJlIHRvIHJlcGxhY2UgdGhlIG1vZHVsZV9pbml0L3Jvb3Rmc19pbml0Y2FsbAppbiB0aGUgY3Vz
dG9tIGNsb2NrIHBsdWdpbiB3aXRoIHNvbWV0aGluZyB0aGF0IGlzIGNhbGxlZCBlYXJsaWVyIGxp
a2UKZnNfaW5pdGNhbGwuCgo+Cj4gQ2hlZXJzCj4KPj4KPj4gUmVnYXJkcwo+PiBBbmRlcnMgV2Fs
bGluCj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
Zwo+PiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cj4KPiAtLQo+IEpvbmF0aGFuIFIuIEp1bGllbgo+IEVmZmljaW9zCj4KPgo+Cj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
