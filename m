From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-tools v2 4/5] Tests: add function to
	validate the number of an event name in metadata
Date: Fri,  9 Feb 2018 16:56:51 -0500
Message-ID: <1518213412-16593-5-git-send-email-francis.deslauriers__29000.2939793796$1518213333$gmane$org@efficios.com>
References: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
 <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zdTRv2HfPzpSt
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 21:56:59 +0000 (UTC)
In-Reply-To: <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvdXRpbHMvdXRpbHMuc2ggfCAyMyArKysrKysrKysrKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS90ZXN0cy91dGlscy91dGlscy5zaCBiL3Rlc3RzL3V0aWxzL3V0aWxzLnNoCmluZGV4IDliZjFm
Y2MuLjYwZGYzNzYgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3V0aWxzL3V0aWxzLnNoCisrKyBiL3Rlc3Rz
L3V0aWxzL3V0aWxzLnNoCkBAIC0xMzQzLDYgKzEzNDMsMjkgQEAgZnVuY3Rpb24gYWRkX2NvbnRl
eHRfa2VybmVsX2ZhaWwoKQogCWFkZF9jb250ZXh0X2x0dG5nIDEgLWsgIiRAIgogfQogCitmdW5j
dGlvbiB2YWxpZGF0ZV9tZXRhZGF0YV9ldmVudCAoKQoreworCWxvY2FsIGV2ZW50X25hbWU9JDEK
Kwlsb2NhbCBucl9ldmVudF9pZD0kMgorCWxvY2FsIHRyYWNlX3BhdGg9JDMKKworCWxvY2FsIG1l
dGFkYXRhX2ZpbGU9JChmaW5kICR0cmFjZV9wYXRoIHwgZ3JlcCBtZXRhZGF0YSkKKwlsb2NhbCBt
ZXRhZGF0YV9wYXRoPSQoZGlybmFtZSAkbWV0YWRhdGFfZmlsZSkKKworCXdoaWNoICRCQUJFTFRS
QUNFX0JJTiA+L2Rldi9udWxsCisJc2tpcCAkPyAtbmUgMCAiQmFiZWx0cmFjZSBiaW5hcnkgbm90
IGZvdW5kLiBTa2lwcGluZyB0cmFjZSBtYXRjaGVzIgorCisJbG9jYWwgY291bnQ9JCgkQkFCRUxU
UkFDRV9CSU4gLS1vdXRwdXQtZm9ybWF0PWN0Zi1tZXRhZGF0YSAkbWV0YWRhdGFfcGF0aCB8IGdy
ZXAgJGV2ZW50X25hbWUgfCB3YyAtbCkKKworCWlmIFsgIiRjb3VudCIgLW5lICIkbnJfZXZlbnRf
aWQiIF07IHRoZW4KKwkJZmFpbCAiTWV0YWRhdGEgbWF0Y2ggd2l0aCB0aGUgbWV0YWRhdGEgb2Yg
JGNvdW50IGV2ZW50KHMpIG5hbWVkICRldmVudF9uYW1lIgorCQlkaWFnICIkY291bnQgbWF0Y2hp
bmcgZXZlbnQgaWQgZm91bmQgaW4gbWV0YWRhdGEiCisJZWxzZQorCQlwYXNzICJNZXRhZGF0YSBt
YXRjaCB3aXRoIHRoZSBtZXRhZGF0YSBvZiAkY291bnQgZXZlbnQocykgbmFtZWQgJGV2ZW50X25h
bWUiCisJZmkKKworfQorCiBmdW5jdGlvbiB0cmFjZV9tYXRjaGVzICgpCiB7CiAJbG9jYWwgZXZl
bnRfbmFtZT0kMQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
