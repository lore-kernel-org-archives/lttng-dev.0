From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Don't dispatch uninitialized
	hash tables to the ht_cleanup thread
Date: Mon, 11 Nov 2013 14:43:16 -0500
Message-ID: <1384198996-29028-1-git-send-email-jeremie.galarneau__13250.1472523019$1384199068$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VfxOO-0007kF-Lf
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 14:43:30 -0500
Received: by mail-qc0-f171.google.com with SMTP id s13so817669qcv.16
	for <lttng-dev@lists.lttng.org>; Mon, 11 Nov 2013 11:43:19 -0800 (PST)
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
aW5kZXggODVhMWYwMi4uNWVmYTFkNCAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC91dGlscy5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXRpbHMuYwpAQCAtNTQsNiAr
NTQsOSBAQCB2b2lkIGh0X2NsZWFudXBfcHVzaChzdHJ1Y3QgbHR0bmdfaHQgKmh0KQogCWludCBy
ZXQ7CiAJaW50IGZkID0gaHRfY2xlYW51cF9waXBlWzFdOwogCisJaWYgKCFodCkgeworCQlyZXR1
cm47CisJfQogCWlmIChmZCA8IDApCiAJCXJldHVybjsKIAlkbyB7Ci0tIAoxLjguNC4yCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
