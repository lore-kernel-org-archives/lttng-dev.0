From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Unchecked asprintf/vasprintf
	return values
Date: Fri, 12 Jul 2013 12:36:36 -0400
Message-ID: <1373646996-5578-1-git-send-email-jeremie.galarneau__13731.8929577761$1373647040$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UxgKt-000304-5h
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 12:36:47 -0400
Received: by mail-qc0-f169.google.com with SMTP id c10so5157487qcz.28
	for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2013 09:36:41 -0700 (PDT)
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
c3RzL2xpYi90YXAuYyB8IDEyICsrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9saWIvdGFwLmMgYi90
ZXN0cy9saWIvdGFwLmMKaW5kZXggODZjODlhMi4uOGJmNzJmNiAxMDA2NDQKLS0tIGEvdGVzdHMv
bGliL3RhcC5jCisrKyBiL3Rlc3RzL2xpYi90YXAuYwpAQCAtODMsNyArODMsOSBAQCBfZ2VuX3Jl
c3VsdChpbnQgb2ssIGNvbnN0IGNoYXIgKmZ1bmMsIGNoYXIgKmZpbGUsIHVuc2lnbmVkIGludCBs
aW5lLAogCSAgIGV4cGFuc2lvbnMgb24gaXQgKi8KIAlpZih0ZXN0X25hbWUgIT0gTlVMTCkgewog
CQl2YV9zdGFydChhcCwgdGVzdF9uYW1lKTsKLQkJdmFzcHJpbnRmKCZsb2NhbF90ZXN0X25hbWUs
IHRlc3RfbmFtZSwgYXApOworCQlpZiAodmFzcHJpbnRmKCZsb2NhbF90ZXN0X25hbWUsIHRlc3Rf
bmFtZSwgYXApID09IC0xKSB7CisJCQlsb2NhbF90ZXN0X25hbWUgPSBOVUxMOworCQl9CiAJCXZh
X2VuZChhcCk7CiAKIAkJLyogTWFrZSBzdXJlIHRoZSB0ZXN0IG5hbWUgY29udGFpbnMgbW9yZSB0
aGFuIGRpZ2l0cwpAQCAtMjk5LDcgKzMwMSw5IEBAIHNraXAodW5zaWduZWQgaW50IG4sIGNoYXIg
KmZtdCwgLi4uKQogCUxPQ0s7CiAKIAl2YV9zdGFydChhcCwgZm10KTsKLQlhc3ByaW50Zigmc2tp
cF9tc2csIGZtdCwgYXApOworCWlmIChhc3ByaW50Zigmc2tpcF9tc2csIGZtdCwgYXApID09IC0x
KSB7CisJCXNraXBfbXNnID0gTlVMTDsKKwl9CiAJdmFfZW5kKGFwKTsKIAogCXdoaWxlKG4tLSA+
IDApIHsKQEAgLTMyNCw3ICszMjgsOSBAQCB0b2RvX3N0YXJ0KGNoYXIgKmZtdCwgLi4uKQogCUxP
Q0s7CiAKIAl2YV9zdGFydChhcCwgZm10KTsKLQl2YXNwcmludGYoJnRvZG9fbXNnLCBmbXQsIGFw
KTsKKwlpZiAodmFzcHJpbnRmKCZ0b2RvX21zZywgZm10LCBhcCkgPT0gLTEpIHsKKwkJdG9kb19t
c2cgPSBOVUxMOworCX0KIAl2YV9lbmQoYXApOwogCiAJdG9kbyA9IDE7Ci0tIAoxLjguMy4yCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
