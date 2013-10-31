From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Use the packet's final
	size	when mmap-ing the next packet
Date: Thu, 31 Oct 2013 13:18:08 +0000 (UTC)
Message-ID: <1025075624.54352.1383225488188.JavaMail.zimbra__11659.176022704$1383225841$gmane$org@efficios.com>
References: <1381857798-6859-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vbs8Z-0007Gx-Lv
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 09:18:13 -0400
In-Reply-To: <1381857798-6859-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTZW50OiBUdWVzZGF5LCBPY3Rv
YmVyIDE1LCAyMDEzIDE6MjM6MTggUE0KPiBTdWJqZWN0OiBbbHR0bmctZGV2XSBbUEFUQ0ggYmFi
ZWx0cmFjZV0gRml4OiBVc2UgdGhlIHBhY2tldCdzIGZpbmFsIHNpemUJd2hlbiBtbWFwLWluZyB0
aGUgbmV4dCBwYWNrZXQKPiAKPiBjdGZfcGFja2V0X3NlZWsoKSBhc3N1bWVkIHRoYXQgYSBwYWNr
ZXQgd291bGQgYmUgb2YgZml4ZWQgc2l6ZQo+ICJXUklURV9QQUNLRVRfTEVOIiB3aGVuIHNlZWtp
bmcgdG8gdGhlIG5leHQgcGFja2V0IGluIHdyaXRlIG1vZGUuCj4gVGhpcyBlbnN1cmVzIHRoYXQg
dGhlIHJlYWwgc2l6ZSB1c2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5l
YXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KPiBSZXZpZXdlZC1ieTogTWF0aGll
dSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgZm9y
bWF0cy9jdGYvY3RmLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9jdGYuYyBiL2Zvcm1h
dHMvY3RmL2N0Zi5jCj4gaW5kZXggOTQ3YjQzOS4uNjBkOWM5ZiAxMDA2NDQKPiAtLS0gYS9mb3Jt
YXRzL2N0Zi9jdGYuYwo+ICsrKyBiL2Zvcm1hdHMvY3RmL2N0Zi5jCj4gQEAgLTcxMiw3ICs3MTIs
NyBAQCB2b2lkIGN0Zl9wYWNrZXRfc2VlayhzdHJ1Y3QgYnRfc3RyZWFtX3BvcyAqc3RyZWFtX3Bv
cywKPiBzaXplX3QgaW5kZXgsIGludCB3aGVuY2UpCj4gIAkJc3dpdGNoICh3aGVuY2UpIHsKPiAg
CQljYXNlIFNFRUtfQ1VSOgo+ICAJCQkvKiBUaGUgd3JpdGVyIHdpbGwgYWRkIHBhZGRpbmcgKi8K
PiAtCQkJcG9zLT5tbWFwX29mZnNldCArPSBXUklURV9QQUNLRVRfTEVOIC8gQ0hBUl9CSVQ7Cj4g
KwkJCXBvcy0+bW1hcF9vZmZzZXQgKz0gcG9zLT5wYWNrZXRfc2l6ZSAvIENIQVJfQklUOwo+ICAJ
CQlicmVhazsKPiAgCQljYXNlIFNFRUtfU0VUOgo+ICAJCQlhc3NlcnQoaW5kZXggPT0gMCk7CS8q
IG9ubHkgc2VlayBzdXBwb3J0ZWQgZm9yIG5vdyAqLwo+IC0tCj4gMS44LjQKPiAKPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4gCgotLSAKTWF0aGll
dSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
