From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: changes to the vm_op
 fault cb prototype in libringbuffer
Date: Tue, 7 Mar 2017 15:01:17 +0000 (UTC)
Message-ID: <241049318.31543.1488898877185.JavaMail.zimbra__23491.9923627333$1488898885$gmane$org@efficios.com>
References: <1488898765-29680-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vd0Gw4LDCzlJq
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 15:01:28 +0000 (UTC)
In-Reply-To: <1488898765-29680-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgotLS0tLSBPbiBNYXIgNywgMjAxNywgYXQgOTo1OSBBTSwgRnJhbmNpcyBEZXNsYXVyaWVycyBm
cmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTog
RnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20+Cj4g
LS0tCj4gbGliL3JpbmdidWZmZXIvcmluZ19idWZmZXJfbW1hcC5jIHwgNiArKysrKysKPiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi9yaW5nYnVm
ZmVyL3JpbmdfYnVmZmVyX21tYXAuYwo+IGIvbGliL3JpbmdidWZmZXIvcmluZ19idWZmZXJfbW1h
cC5jCj4gaW5kZXggMzVkMzBlNy4uMWNhNDVhNyAxMDA2NDQKPiAtLS0gYS9saWIvcmluZ2J1ZmZl
ci9yaW5nX2J1ZmZlcl9tbWFwLmMKPiArKysgYi9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9t
bWFwLmMKPiBAQCAtMzIsOCArMzIsMTQgQEAKPiAvKgo+ICAqIGZhdWx0KCkgdm1fb3AgaW1wbGVt
ZW50YXRpb24gZm9yIHJpbmcgYnVmZmVyIGZpbGUgbWFwcGluZy4KPiAgKi8KPiArI2lmIChMSU5V
WF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkKPiArc3RhdGljIGludCBs
aWJfcmluZ19idWZmZXJfZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4gK3sKPiArCXN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1mLT52bWE7Cj4gKyNlbHNlIC8qICNpZiAoTElOVVhf
VkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTEsMCkpICovCj4gc3RhdGljIGludCBs
aWJfcmluZ19idWZmZXJfZmF1bHQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCB2
bV9mYXVsdAo+ICp2bWYpCj4gewo+ICsjZW5kaWYgLyogI2Vsc2UgI2lmIChMSU5VWF9WRVJTSU9O
X0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkgKi8KClNhbWUgaGVyZSwgaWZkZWZzIHNo
b3VsZCBjb250YWluIGVudGlyZSBmdW5jdGlvbnMuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAlzdHJ1
Y3QgbGliX3JpbmdfYnVmZmVyICpidWYgPSB2bWEtPnZtX3ByaXZhdGVfZGF0YTsKPiAJc3RydWN0
IGNoYW5uZWwgKmNoYW4gPSBidWYtPmJhY2tlbmQuY2hhbjsKPiAJY29uc3Qgc3RydWN0IGxpYl9y
aW5nX2J1ZmZlcl9jb25maWcgKmNvbmZpZyA9ICZjaGFuLT5iYWNrZW5kLmNvbmZpZzsKPiAtLQo+
IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
