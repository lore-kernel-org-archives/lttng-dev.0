From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Skip lttng-gen-tp example build
	if Python is missing
Date: Thu, 27 Feb 2014 12:30:41 -0500
Message-ID: <1393522241-24017-1-git-send-email-jeremie.galarneau__4890.27061635188$1393522323$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WJ4nI-0008Oe-Vm
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 12:30:55 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so4355926qap.16
	for <lttng-dev@lists.lttng.org>; Thu, 27 Feb 2014 09:30:43 -0800 (PST)
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

Rml4ZXMgIzY2NQoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5n
YWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICB8IDMg
KysrCiBkb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0gfCA2ICsrKysrLQogMiBmaWxlcyBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9jb25maWd1cmUu
YWMgYi9jb25maWd1cmUuYWMKaW5kZXggYzg0MjFiNy4uM2M5MmRhMSAxMDA2NDQKLS0tIGEvY29u
ZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtMjc2LDYgKzI3Niw5IEBAIEFDX0RFRklO
RV9VTlFVT1RFRChbTFRUTkdfU1lTVEVNX1JVTkRJUl0sIFsiJGx0dG5nX3N5c3RlbV9ydW5kaXIi
XSwKIGx0dG5nbGliamF2YWRpcj0iJHtsaWJkaXJ9L2x0dG5nL2phdmEiCiBBQ19TVUJTVChsdHRu
Z2xpYmphdmFkaXIpCiAKK0FNX1BBVEhfUFlUSE9OKFsyLjddLEJVSUxEX0dFTl9UUF9FWEFNUExF
Uz0xKQorQU1fQ09ORElUSU9OQUwoW0JVSUxEX0dFTl9UUF9FWEFNUExFU10sIFt0ZXN0ICRCVUlM
RF9HRU5fVFBfRVhBTVBMRVNdLCBbQnVpbGQgZXhhbXBsZXMgcmVxdWlyaW5nIGx0dG5nLWdlbi10
cF0pCisKIEFDX0NPTkZJR19GSUxFUyhbCiAJTWFrZWZpbGUKIAlkb2MvTWFrZWZpbGUKZGlmZiAt
LWdpdCBhL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbSBiL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5h
bQppbmRleCA5NzFlZWMzLi4wZDM0MWM4IDEwMDY0NAotLS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZp
bGUuYW0KKysrIGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCkBAIC00Myw3ICs0MywxMSBAQCBp
ZiBOT19TSEFSRUQKICMgZGlzYWJsZWQuCiBlbHNlCiAjIENvcGllcyBhcmUgZm9yIFZQQVRIIGJ1
aWxkIHN1cHBvcnQKLVNVQkRJUlNfUFJPWFkgPSBlYXN5LXVzdCBkZW1vIGdlbi10cCBoZWxsby1z
dGF0aWMtbGliCitTVUJESVJTX1BST1hZID0gZWFzeS11c3QgZGVtbyBoZWxsby1zdGF0aWMtbGli
CisKK2lmIEJVSUxEX0dFTl9UUF9FWEFNUExFUworU1VCRElSU19QUk9YWSArPSBnZW4tdHAKK2Vu
ZGlmCiAKIGFsbC1sb2NhbDoKIAlAaWYgWyB4IiQoc3JjZGlyKSIgIT0geCIkKGJ1aWxkZGlyKSIg
XTsgdGhlbiBcCi0tIAoxLjkuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
