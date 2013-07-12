From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Unchecked asprintf/vasprintf
	return values
Date: Fri, 12 Jul 2013 12:38:56 -0400
Message-ID: <1373647136-5708-1-git-send-email-jeremie.galarneau__3466.19221750206$1373647175$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UxgN6-00032c-FA
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 12:39:04 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so445396qab.15
	for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2013 09:38:59 -0700 (PDT)
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

c3RycMK3bWF5wrdiZcK3bW9kaWZpZWTCt2V2ZW7Ct2luwrdjYXNlwrdvZsK3ZmFpbHVyZcK3YWNj
b3JkaW5nwrd0b8K3dGhlIEFTUFJJTlRGKDMpIG1hbgpwYWdlLgoKU2lnbmVkLW9mZi1ieTogSsOp
csOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIHRl
c3RzL3V0aWxzL3RhcC90YXAuYyB8IDEyICsrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy91dGlscy90
YXAvdGFwLmMgYi90ZXN0cy91dGlscy90YXAvdGFwLmMKaW5kZXggYTQzMDk1MS4uNWQ2NGQ4NCAx
MDA2NDQKLS0tIGEvdGVzdHMvdXRpbHMvdGFwL3RhcC5jCisrKyBiL3Rlc3RzL3V0aWxzL3RhcC90
YXAuYwpAQCAtODMsNyArODMsOSBAQCBfZ2VuX3Jlc3VsdChpbnQgb2ssIGNvbnN0IGNoYXIgKmZ1
bmMsIGNoYXIgKmZpbGUsIHVuc2lnbmVkIGludCBsaW5lLAogCSAgIGV4cGFuc2lvbnMgb24gaXQg
Ki8KIAlpZih0ZXN0X25hbWUgIT0gTlVMTCkgewogCQl2YV9zdGFydChhcCwgdGVzdF9uYW1lKTsK
LQkJdmFzcHJpbnRmKCZsb2NhbF90ZXN0X25hbWUsIHRlc3RfbmFtZSwgYXApOworCQlpZiAodmFz
cHJpbnRmKCZsb2NhbF90ZXN0X25hbWUsIHRlc3RfbmFtZSwgYXApID09IC0xKSB7CisJCQlsb2Nh
bF90ZXN0X25hbWUgPSBOVUxMOworCQl9CiAJCXZhX2VuZChhcCk7CiAKIAkJLyogTWFrZSBzdXJl
IHRoZSB0ZXN0IG5hbWUgY29udGFpbnMgbW9yZSB0aGFuIGRpZ2l0cwpAQCAtMjk5LDcgKzMwMSw5
IEBAIHNraXAodW5zaWduZWQgaW50IG4sIGNoYXIgKmZtdCwgLi4uKQogCUxPQ0s7CiAKIAl2YV9z
dGFydChhcCwgZm10KTsKLQlhc3ByaW50Zigmc2tpcF9tc2csIGZtdCwgYXApOworCWlmIChhc3By
aW50Zigmc2tpcF9tc2csIGZtdCwgYXApID09IC0xKSB7CisJCXNraXBfbXNnID0gTlVMTDsKKwl9
CiAJdmFfZW5kKGFwKTsKIAogCXdoaWxlKG4tLSA+IDApIHsKQEAgLTMyNCw3ICszMjgsOSBAQCB0
b2RvX3N0YXJ0KGNoYXIgKmZtdCwgLi4uKQogCUxPQ0s7CiAKIAl2YV9zdGFydChhcCwgZm10KTsK
LQl2YXNwcmludGYoJnRvZG9fbXNnLCBmbXQsIGFwKTsKKwlpZiAodmFzcHJpbnRmKCZ0b2RvX21z
ZywgZm10LCBhcCkgPT0gLTEpIHsKKwkJdG9kb19tc2cgPSBOVUxMOworCX0KIAl2YV9lbmQoYXAp
OwogCiAJdG9kbyA9IDE7Ci0tIAoxLjguMy4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
