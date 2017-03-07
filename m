From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: changes to the vm_op fault
	cb prototype in libringbuffer
Date: Tue,  7 Mar 2017 09:59:25 -0500
Message-ID: <1488898765-29680-1-git-send-email-francis.deslauriers__29345.084881834$1488898792$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vd0FP1XyFzlHg
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 15:00:08 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogbGliL3JpbmdidWZmZXIvcmluZ19idWZmZXJfbW1hcC5jIHwgNiAr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9saWIv
cmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9tbWFwLmMgYi9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZl
cl9tbWFwLmMKaW5kZXggMzVkMzBlNy4uMWNhNDVhNyAxMDA2NDQKLS0tIGEvbGliL3JpbmdidWZm
ZXIvcmluZ19idWZmZXJfbW1hcC5jCisrKyBiL2xpYi9yaW5nYnVmZmVyL3JpbmdfYnVmZmVyX21t
YXAuYwpAQCAtMzIsOCArMzIsMTQgQEAKIC8qCiAgKiBmYXVsdCgpIHZtX29wIGltcGxlbWVudGF0
aW9uIGZvciByaW5nIGJ1ZmZlciBmaWxlIG1hcHBpbmcuCiAgKi8KKyNpZiAoTElOVVhfVkVSU0lP
Tl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTEsMCkpCitzdGF0aWMgaW50IGxpYl9yaW5nX2J1
ZmZlcl9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKK3sKKwlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSA9IHZtZi0+dm1hOworI2Vsc2UgLyogI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0g
S0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkgKi8KIHN0YXRpYyBpbnQgbGliX3JpbmdfYnVmZmVyX2Zh
dWx0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIHsK
KyNlbmRpZiAvKiAjZWxzZSAjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lP
Tig0LDExLDApKSAqLwogCXN0cnVjdCBsaWJfcmluZ19idWZmZXIgKmJ1ZiA9IHZtYS0+dm1fcHJp
dmF0ZV9kYXRhOwogCXN0cnVjdCBjaGFubmVsICpjaGFuID0gYnVmLT5iYWNrZW5kLmNoYW47CiAJ
Y29uc3Qgc3RydWN0IGxpYl9yaW5nX2J1ZmZlcl9jb25maWcgKmNvbmZpZyA9ICZjaGFuLT5iYWNr
ZW5kLmNvbmZpZzsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
