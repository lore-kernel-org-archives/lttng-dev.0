From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Tests fix: Missing waitpid in fork
	test
Date: Wed, 26 Feb 2014 10:56:57 -0500
Message-ID: <1393430217-12953-1-git-send-email-jeremie.galarneau__33247.4257950254$1393430298$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WIgr3-0004HJ-Rk
	for lttng-dev@lists.lttng.org; Wed, 26 Feb 2014 10:57:11 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so2504579qaq.39
	for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2014 07:57:00 -0800 (PST)
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

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHRlc3RzL3JlZ3Jlc3Npb24vdXN0L2ZvcmsvZm9yay5jIHwgMTQgKysr
KysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L2ZvcmsvZm9yay5jIGIvdGVz
dHMvcmVncmVzc2lvbi91c3QvZm9yay9mb3JrLmMKaW5kZXggNzQ0ZTkyMC4uN2RmOTgyYiAxMDA2
NDQKLS0tIGEvdGVzdHMvcmVncmVzc2lvbi91c3QvZm9yay9mb3JrLmMKKysrIGIvdGVzdHMvcmVn
cmVzc2lvbi91c3QvZm9yay9mb3JrLmMKQEAgLTIwLDYgKzIwLDcgQEAKICNpbmNsdWRlIDxzdGRp
by5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1
ZGUgPHN5cy93YWl0Lmg+CiAjaW5jbHVkZSA8c3RkbGliLmg+CiAKICNkZWZpbmUgVFJBQ0VQT0lO
VF9ERUZJTkUKQEAgLTUxLDEyICs1MiwxOSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YsIGNoYXIgKmVudltdKQogCQlyZXN1bHQgPSBleGVjdmUoYXJndlsxXSwgYXJncywgZW52KTsK
IAkJaWYgKHJlc3VsdCA9PSAtMSkgewogCQkJcGVycm9yKCJleGVjdmUiKTsKLQkJCXJldHVybiAx
OworCQkJcmVzdWx0ID0gMTsKKwkJCWdvdG8gZW5kOwogCQl9CiAJfSBlbHNlIHsKIAkJcHJpbnRm
KCJjaGlsZF9waWQgJWRcbiIsIHJlc3VsdCk7CiAJCXRyYWNlcG9pbnQodXN0X3Rlc3RzX2Zvcmss
IGFmdGVyX2ZvcmtfcGFyZW50LCBnZXRwaWQoKSk7CisJCWlmICh3YWl0cGlkKHJlc3VsdCwgTlVM
TCwgMCkgPCAwKSB7CisJCQlwZXJyb3IoIndhaXRwaWQiKTsKKwkJCXJlc3VsdCA9IDE7CisJCQln
b3RvIGVuZDsKKwkJfQogCX0KLQotCXJldHVybiAwOworCXJlc3VsdCA9IDA7CitlbmQ6CisJcmV0
dXJuIHJlc3VsdDsKIH0KLS0gCjEuOS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
