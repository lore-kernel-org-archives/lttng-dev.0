From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: Don't dispatch
	uninitialized hash tables to the ht_cleanup thread
Date: Mon, 11 Nov 2013 15:30:08 -0500
Message-ID: <1384201808-29812-1-git-send-email-jeremie.galarneau__28358.2550743178$1384201876$gmane$org@efficios.com>
References: <1384198996-29028-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Vfy7l-00033H-2O
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 15:30:23 -0500
Received: by mail-qa0-f49.google.com with SMTP id cm18so2308528qab.1
	for <lttng-dev@lists.lttng.org>; Mon, 11 Nov 2013 12:30:11 -0800 (PST)
In-Reply-To: <1384198996-29028-1-git-send-email-jeremie.galarneau@efficios.com>
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

U29tZSBlcnJvci1oYW5kbGluZyBjb2RlIHBhdGhzIG1heSBjYWxsIGh0X2NsZWFudXBfcHVzaCgp
IHdpdGggTlVMTCBoYXNoCnRhYmxlcyB3aGljaCB3aWxsIGNyYXNoIHRoZSBjbGVhbi11cCB0aHJl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVh
dUBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91dGlscy5jIHwgMyAr
KysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL3V0aWxzLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3V0aWxzLmMK
aW5kZXggMmZmNTdjZC4uYzljNTFlZCAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC91dGlscy5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXRpbHMuYwpAQCAtNTIsNiAr
NTIsOSBAQCB2b2lkIGh0X2NsZWFudXBfcHVzaChzdHJ1Y3QgbHR0bmdfaHQgKmh0KQogCXNzaXpl
X3QgcmV0OwogCWludCBmZCA9IGh0X2NsZWFudXBfcGlwZVsxXTsKIAorCWlmICghaHQpIHsKKwkJ
cmV0dXJuOworCX0KIAlpZiAoZmQgPCAwKQogCQlyZXR1cm47CiAJcmV0ID0gbHR0bmdfd3JpdGUo
ZmQsICZodCwgc2l6ZW9mKGh0KSk7Ci0tIAoxLjguNC4yCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
