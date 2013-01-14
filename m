From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools 3/4] Extras: Redefined
	PyInt_AsSsize_T to PyLong_AsSsize_t.
Date: Mon, 14 Jan 2013 16:45:48 +0000
Message-ID: <1358181949-23456-3-git-send-email-jeremie.galarneau__44568.4234182865$1358200076$gmane$org@efficios.com>
References: <1358181949-23456-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TursE-0002QA-Lv
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 16:47:18 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so2781858qcm.39
	for <lttng-dev@lists.lttng.org>; Mon, 14 Jan 2013 13:47:13 -0800 (PST)
In-Reply-To: <1358181949-23456-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

UHl0aG9uIDMgbWVyZ2VzIFB5SW50IGFuZCBQeUxvbmcgdHlwZXMuIFRoaXMgZml4ZXMgdGhlCnVu
ZGVmaW5lZCBzeW1ib2wgZXJyb3IgZW5jb3VudGVyZWQgd2hlbiB1c2luZyB0aGUgYmluZGluZ3MK
d2l0aCBQeXRob24gMy4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVt
aWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBleHRyYXMvYmluZGluZ3Mvc3dpZy9weXRo
b24vbHR0bmcuaS5pbiB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9leHRyYXMvYmluZGluZ3Mvc3dpZy9weXRob24vbHR0bmcuaS5pbiBi
L2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9sdHRuZy5pLmluCmluZGV4IDBkNmQxZTkuLjI0
NGJjMjIgMTAwNjQ0Ci0tLSBhL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9sdHRuZy5pLmlu
CisrKyBiL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9sdHRuZy5pLmluCkBAIC0xNSw2ICsx
NSwxNCBAQCBtdWx0aXBsZSBjb25jdXJyZW50IHByb2Nlc3NlcyBhbmQgdGhyZWFkcy4gVHJhY2lu
ZyBhY3Jvc3MgbXVsdGlwbGUgc3lzdGVtcyBpcyBhbAogI2luY2x1ZGUgPGx0dG5nL2x0dG5nLmg+
CiAlfQogCisleworI2lmIFBZX01BSk9SX1ZFUlNJT04gPj0gMworLy8gVGhlIFB5SW50IGFuZCBQ
eUxvbmcgdHlwZXMgd2VyZSB1bmlmaWVkIGFzIG9mIFB5dGhvbiAzCisvLyBUaGlzIG1ha2VzIHRo
ZSB0eXBlbWFwIGNvZGUgdXNlYWJsZSB3aXRoIGJvdGggUHl0aG9uIDIgYW5kIDMuCisjZGVmaW5l
IFB5SW50X0FzU3NpemVfdCBQeUxvbmdfQXNTc2l6ZV90CisjZW5kaWYKKyV9CisKIHR5cGVkZWYg
dW5zaWduZWQgaW50IHVpbnQzMl90OwogdHlwZWRlZiBpbnQgaW50MzJfdDsKIHR5cGVkZWYgdW5z
aWduZWQgbG9uZyBsb25nIHVpbnQ2NF90OwotLSAKMS44LjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
