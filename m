From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Don't report an error if no
	sessions are found with default options
Date: Thu,  8 May 2014 12:12:28 -0400
Message-ID: <1399565548-25453-1-git-send-email-jeremie.galarneau__45588.3104390979$1399565598$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WiQvz-0006rW-Gx
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 12:12:36 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so3013344qgf.17
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 09:12:30 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uZmlnL2NvbmZpZy5jIHwgNyArKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9j
b25maWcvY29uZmlnLmMgYi9zcmMvY29tbW9uL2NvbmZpZy9jb25maWcuYwppbmRleCA4YjM0ZDAy
Li5kZjZmNmEzIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL2NvbmZpZy9jb25maWcuYworKysgYi9z
cmMvY29tbW9uL2NvbmZpZy9jb25maWcuYwpAQCAtMjU0NCw1ICsyNTQ0LDEyIEBAIGludCBjb25m
aWdfbG9hZF9zZXNzaW9uKGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnNlc3Npb25fbmFt
ZSwKIAl9CiBlbmQ6CiAJZmluaV9zZXNzaW9uX2NvbmZpZ192YWxpZGF0aW9uX2N0eCgmdmFsaWRh
dGlvbl9jdHgpOworCWlmIChyZXQgPT0gLUxUVE5HX0VSUl9MT0FEX1NFU1NJT05fTk9FTlQgJiYg
IXNlc3Npb25fbmFtZSAmJiAhcGF0aCkgeworCQkvKgorCQkgKiBEb24ndCByZXBvcnQgYW4gZXJy
b3IgaWYgbm8gc2Vzc2lvbnMgYXJlIGZvdW5kIHdoZW4gY2FsbGVkCisJCSAqIHdpdGhvdXQgYSBz
ZXNzaW9uX25hbWUgb3IgYSBzZWFyY2ggcGF0aC4KKwkJICovCisJCXJldCA9IDA7CisJfQogCXJl
dHVybiByZXQ7CiB9Ci0tIAoxLjkuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
