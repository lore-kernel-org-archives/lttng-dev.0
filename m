From: Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH] Fix: do not use CONFIG_HOTPLUG_CPU for the
 new hotplug API
Date: Tue, 13 Mar 2018 11:20:54 +0100
Message-ID: <b01f8309-513b-2369-4911-8848276afac2__18542.7130586051$1520936352$gmane$org@axis.com>
References: <20180311140243.4539-1-larper@axis.com>
 <1417917769.8200.1520868093286.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by lists.lttng.org (Postfix) with ESMTPS id 400rV82S3Nz1QF
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 06:21:03 -0400 (EDT)
In-Reply-To: <1417917769.8200.1520868093286.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lars Persson <larper@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgpPbiAwMy8xMi8yMDE4IDA0OjIxIFBNLCBNYXRoaWV1IERlc25veWVycyB3cm90ZToKPiAtLS0t
LSBPbiBNYXIgMTEsIDIwMTgsIGF0IDEwOjAyIEFNLCBMYXJzIFBlcnNzb24gbGFycy5wZXJzc29u
QGF4aXMuY29tIHdyb3RlOgo+IAo+PiBLZXJuZWwgY29uZmlndXJhdGlvbnMgd2l0aG91dCBDT05G
SUdfSE9UUExVR19DUFUgdGhyb3cgYW4gdW5rbm93bgo+PiBzeW1ib2wgZXJyb3Igd2hlbiBhdHRl
bXB0aW5nIHRvIGluc2VydCB0aGUgbHR0bmctdHJhY2UgbW9kdWxlOgo+PiBsdHRuZ190cmFjZXI6
IFVua25vd24gc3ltYm9sIGx0dG5nX2hwX3ByZXBhcmUgKGVyciAwKQo+PiBsdHRuZ190cmFjZXI6
IFVua25vd24gc3ltYm9sIGx0dG5nX2hwX29ubGluZSAoZXJyIDApCj4+Cj4+IFRoaXMgd2FzIGNh
dXNlZCBieSBsdHRuZy1ldmVudHMgYW5kIGx0dG5nLWNvbnRleHQtcGVyZi1jb3VudGVyIG5vdAo+
PiBhZ3JlZWluZyBvbiB3aGljaCBwcmVwcm9jZXNzb3IgY29uZGl0aW9uIHRoYXQgc2hvdWxkIGd1
YXJkIHRoZSB1c2Ugb2YKPj4gdGhlIGhvdHBsdWcgQVBJLiBJbiBmYWN0IHRoZSBBUEkgaXMgYXZh
aWxhYmxlIGFsc28gb24ga2VybmVscyBidWlsdAo+PiB3aXRob3V0IENPTkZJR19IT1RQTFVHX0FQ
SS4KPiAKPiBEbyB5b3UgbWVhbiBDT05GSUdfSE9UUExVR19DUFUgYWJvdmUgPwoKWWVzLCB0aGFu
a3MgZm9yIHNwb3R0aW5nIHRoZSBtaXN0YWtlLiBGZWVsIGZyZWUgdG8gZWRpdCBteSBjb21taXQg
bWVzc2FnZS4KCi0gTGFycwoKPiAKPiBUaGFua3MsCj4gCj4gTWF0aGlldQo+IAo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMYXJzIFBlcnNzb24gPGxhcnBlckBheGlzLmNvbT4KPj4gLS0tCj4+IGx0dG5n
LWV2ZW50cy5jIHwgMiArLQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2x0dG5nLWV2ZW50cy5jIGIvbHR0bmctZXZlbnRz
LmMKPj4gaW5kZXggNmYxMjJkZC4uMmNkNjUwZiAxMDA2NDQKPj4gLS0tIGEvbHR0bmctZXZlbnRz
LmMKPj4gKysrIGIvbHR0bmctZXZlbnRzLmMKPj4gQEAgLTI2NDQsNyArMjY0NCw3IEBAIHZvaWQg
bHR0bmdfdHJhbnNwb3J0X3VucmVnaXN0ZXIoc3RydWN0IGx0dG5nX3RyYW5zcG9ydAo+PiAqdHJh
bnNwb3J0KQo+PiB9Cj4+IEVYUE9SVF9TWU1CT0xfR1BMKGx0dG5nX3RyYW5zcG9ydF91bnJlZ2lz
dGVyKTsKPj4KPj4gLSNpZiAoZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpICYmIChMSU5VWF9W
RVJTSU9OX0NPREUgPj0KPj4gS0VSTkVMX1ZFUlNJT04oNCwxMCwwKSkpCj4+ICsjaWYgKExJTlVY
X1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKQo+Pgo+PiBlbnVtIGNwdWhw
X3N0YXRlIGx0dG5nX2hwX3ByZXBhcmU7Cj4+IGVudW0gY3B1aHBfc3RhdGUgbHR0bmdfaHBfb25s
aW5lOwo+PiAtLQo+PiAyLjExLjAKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+PiBsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
