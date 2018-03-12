From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: do not use CONFIG_HOTPLUG_CPU for the
 new	hotplug API
Date: Mon, 12 Mar 2018 11:21:33 -0400 (EDT)
Message-ID: <1417917769.8200.1520868093286.JavaMail.zimbra__49528.978256467$1520867991$gmane$org@efficios.com>
References: <20180311140243.4539-1-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 400MCT0qr0zTB
 for <lttng-dev@lists.lttng.org>; Mon, 12 Mar 2018 11:21:40 -0400 (EDT)
In-Reply-To: <20180311140243.4539-1-larper@axis.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWFyIDExLCAyMDE4LCBhdCAxMDowMiBBTSwgTGFycyBQZXJzc29uIGxhcnMucGVy
c3NvbkBheGlzLmNvbSB3cm90ZToKCj4gS2VybmVsIGNvbmZpZ3VyYXRpb25zIHdpdGhvdXQgQ09O
RklHX0hPVFBMVUdfQ1BVIHRocm93IGFuIHVua25vd24KPiBzeW1ib2wgZXJyb3Igd2hlbiBhdHRl
bXB0aW5nIHRvIGluc2VydCB0aGUgbHR0bmctdHJhY2UgbW9kdWxlOgo+IGx0dG5nX3RyYWNlcjog
VW5rbm93biBzeW1ib2wgbHR0bmdfaHBfcHJlcGFyZSAoZXJyIDApCj4gbHR0bmdfdHJhY2VyOiBV
bmtub3duIHN5bWJvbCBsdHRuZ19ocF9vbmxpbmUgKGVyciAwKQo+IAo+IFRoaXMgd2FzIGNhdXNl
ZCBieSBsdHRuZy1ldmVudHMgYW5kIGx0dG5nLWNvbnRleHQtcGVyZi1jb3VudGVyIG5vdAo+IGFn
cmVlaW5nIG9uIHdoaWNoIHByZXByb2Nlc3NvciBjb25kaXRpb24gdGhhdCBzaG91bGQgZ3VhcmQg
dGhlIHVzZSBvZgo+IHRoZSBob3RwbHVnIEFQSS4gSW4gZmFjdCB0aGUgQVBJIGlzIGF2YWlsYWJs
ZSBhbHNvIG9uIGtlcm5lbHMgYnVpbHQKPiB3aXRob3V0IENPTkZJR19IT1RQTFVHX0FQSS4KCkRv
IHlvdSBtZWFuIENPTkZJR19IT1RQTFVHX0NQVSBhYm92ZSA/CgpUaGFua3MsCgpNYXRoaWV1Cgo+
IAo+IFNpZ25lZC1vZmYtYnk6IExhcnMgUGVyc3NvbiA8bGFycGVyQGF4aXMuY29tPgo+IC0tLQo+
IGx0dG5nLWV2ZW50cy5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9sdHRuZy1ldmVudHMuYyBiL2x0dG5nLWV2
ZW50cy5jCj4gaW5kZXggNmYxMjJkZC4uMmNkNjUwZiAxMDA2NDQKPiAtLS0gYS9sdHRuZy1ldmVu
dHMuYwo+ICsrKyBiL2x0dG5nLWV2ZW50cy5jCj4gQEAgLTI2NDQsNyArMjY0NCw3IEBAIHZvaWQg
bHR0bmdfdHJhbnNwb3J0X3VucmVnaXN0ZXIoc3RydWN0IGx0dG5nX3RyYW5zcG9ydAo+ICp0cmFu
c3BvcnQpCj4gfQo+IEVYUE9SVF9TWU1CT0xfR1BMKGx0dG5nX3RyYW5zcG9ydF91bnJlZ2lzdGVy
KTsKPiAKPiAtI2lmIChkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgJiYgKExJTlVYX1ZFUlNJ
T05fQ09ERSA+PQo+IEtFUk5FTF9WRVJTSU9OKDQsMTAsMCkpKQo+ICsjaWYgKExJTlVYX1ZFUlNJ
T05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKQo+IAo+IGVudW0gY3B1aHBfc3RhdGUg
bHR0bmdfaHBfcHJlcGFyZTsKPiBlbnVtIGNwdWhwX3N0YXRlIGx0dG5nX2hwX29ubGluZTsKPiAt
LQo+IDIuMTEuMAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
