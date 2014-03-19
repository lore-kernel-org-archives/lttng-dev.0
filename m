From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Pass session name to
	config_load_session when no path is provided
Date: Wed, 19 Mar 2014 11:28:52 -0400
Message-ID: <1395242932-32014-1-git-send-email-jeremie.galarneau__36424.0034287379$1395242974$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WQIQP-00065H-2J
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 11:29:01 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so9846820qcx.38
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 08:28:55 -0700 (PDT)
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

Rml4ZXMgIzc1NgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5n
YWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uZmlnL2NvbmZpZy5jIHwg
NiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMgYi9zcmMvY29tbW9uL2Nv
bmZpZy9jb25maWcuYwppbmRleCAxM2FmMmYxLi43YzZjNDliIDEwMDY0NAotLS0gYS9zcmMvY29t
bW9uL2NvbmZpZy9jb25maWcuYworKysgYi9zcmMvY29tbW9uL2NvbmZpZy9jb25maWcuYwpAQCAt
MjQ1Niw3ICsyNDU2LDcgQEAgaW50IGNvbmZpZ19sb2FkX3Nlc3Npb24oY29uc3QgY2hhciAqcGF0
aCwgY29uc3QgY2hhciAqc2Vzc2lvbl9uYW1lLAogCQkJCWdvdG8gZW5kOwogCQkJfQogCi0JCQly
ZXQgPSBsb2FkX3Nlc3Npb25fZnJvbV9wYXRoKHBhdGgsIE5VTEwsCisJCQlyZXQgPSBsb2FkX3Nl
c3Npb25fZnJvbV9wYXRoKHBhdGgsIHNlc3Npb25fbmFtZSwKIAkJCQkmdmFsaWRhdGlvbl9jdHgs
IDApOwogCQkJaWYgKHJldCAmJiByZXQgIT0gLUxUVE5HX0VSUl9MT0FEX1NFU1NJT05fTk9FTlQp
IHsKIAkJCQlmcmVlKHBhdGgpOwpAQCAtMjQ2Nyw4ICsyNDY3LDggQEAgaW50IGNvbmZpZ19sb2Fk
X3Nlc3Npb24oY29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqc2Vzc2lvbl9uYW1lLAogCQl9
CiAKIAkJLyogVHJ5IHN5c3RlbSBzZXNzaW9uIGNvbmZpZ3VyYXRpb24gcGF0aCAqLwotCQlyZXQg
PSBsb2FkX3Nlc3Npb25fZnJvbV9wYXRoKERFRkFVTFRfU0VTU0lPTl9TWVNURU1fQ09ORklHUEFU
SCwgTlVMTCwKLQkJCQkmdmFsaWRhdGlvbl9jdHgsIDApOworCQlyZXQgPSBsb2FkX3Nlc3Npb25f
ZnJvbV9wYXRoKERFRkFVTFRfU0VTU0lPTl9TWVNURU1fQ09ORklHUEFUSCwKKwkJCXNlc3Npb25f
bmFtZSwgJnZhbGlkYXRpb25fY3R4LCAwKTsKIAkJaWYgKHJldCAmJiByZXQgIT0gLUxUVE5HX0VS
Ul9MT0FEX1NFU1NJT05fTk9FTlQpIHsKIAkJCWdvdG8gZW5kOwogCQl9Ci0tIAoxLjkuMAoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
