From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] configure.ac: fix static build
Date: Tue, 1 Dec 2015 09:50:09 -0500
Message-ID: <CA+jJMxsz6+erSA2joBgH2+PrYZrnaA-89m54=Gg3HeHyCXOxoQ__9557.00659328631$1448981480$gmane$org@mail.gmail.com>
References: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
 <CAHXCMMK10==xWormWDQ972=XoymwdCzGZaouRct88nh6nVbABg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1a3mFy-0005QT-Ls
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 09:50:17 -0500
Received: by ykdr82 with SMTP id r82so9269826ykd.3
 for <lttng-dev@lists.lttng.org>; Tue, 01 Dec 2015 06:50:09 -0800 (PST)
In-Reply-To: <CAHXCMMK10==xWormWDQ972=XoymwdCzGZaouRct88nh6nVbABg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Samuel Martin <s.martin49@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuNyBhbmQgc3RhYmxlLTIuNiwgdGhhbmtzIQoKSsOp
csOpbWllCgpPbiBGcmksIE5vdiAyNywgMjAxNSBhdCA0OjIwIFBNLCBTYW11ZWwgTWFydGluIDxz
Lm1hcnRpbjQ5QGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGkgYWxsLAo+Cj4gT24gU3VuLCBOb3YgMjIs
IDIwMTUgYXQgMTE6MzggUE0sIFNhbXVlbCBNYXJ0aW4gPHMubWFydGluNDlAZ21haWwuY29tPiB3
cm90ZToKPj4gRm9yIHN0YXRpYyBidWlsZCwgc29tZSBleHRyYSBMREZMQUdTIG1heSBiZSBuZWVk
ZWQuCj4+Cj4+IFVzaW5nIFBLR19DSEVDS19NT0RVTEVTIGluc3RlYWQgb2YgQUNfQ0hFQ0tfTElC
IGZvciBsaWJyYWlyeSBkZXRlY3Rpb24KPj4gYWxsb3dzIHRvIGdldCBhbGwgdGhlc2UgZmxhZ3Mu
IFRoZW4sIHRoZSBMSUJTIHZhcmlhYmxlIGNhbiBiZSBleHRlbmRlZAo+PiB3aXRoIGV2ZXJ5dGhp
bmcgdGhhdCBpcyBuZWVkZWQuCj4+Cj4+IFNvLCB1c2UgUEtHX0NIRUNLX01PRFVMRVMgZm9yIHBv
cHQgYW5kIHV1aWQgZGV0ZWN0aW9uOyB3aGljaCBib3RoIGRlcGVuZAo+PiBvbiBsaWJpbnRsLgo+
Pgo+PiBUaGlzIGNoYW5nZXMgZml4ZXMgYnVpbGQgZmFpbHVyZXMgdHJpZ2dlcmVkIHdpdGggQnVp
bGRyb290LCBlLmcuOgo+PiAgIGh0dHA6Ly9hdXRvYnVpbGQuYnVpbGRyb290Lm5ldC9yZXN1bHRz
LzBmMS8wZjFlMDE1YTBjNWE1YWMyYmVlYjUwMTFkMzFhMWUwMDU4YTMyYTBkL2J1aWxkLWVuZC5s
b2cKPgo+IEZvciB0aGUgcmVjb3JkLCBJIGp1c3QgZmlsZSBhIGJ1ZyByZXBvcnQgYWJvdXQgaXQ6
Cj4gaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy9pc3N1ZXMvOTc5Cj4KPiBDaGVlcnMsCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKCi0tIApKw6lyw6lt
aWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
