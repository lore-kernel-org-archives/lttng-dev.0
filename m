From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Duplicate lttng-sessiond
	thread creation comments
Date: Mon, 11 Nov 2013 15:53:24 -0500
Message-ID: <1384203204-30368-1-git-send-email-jeremie.galarneau__20863.9406286695$1384203279$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VfyUN-0000gf-O8
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 15:53:45 -0500
Received: by mail-qe0-f49.google.com with SMTP id i11so522447qej.22
	for <lttng-dev@lists.lttng.org>; Mon, 11 Nov 2013 12:53:34 -0800 (PST)
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
aWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC9tYWluLmMKaW5kZXggM2JmOTFiMC4uNzEyOTFmNyAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9tYWluLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKQEAg
LTQ3ODcsNyArNDc4Nyw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJZ290
byBleGl0X2hlYWx0aF9zZXNzaW9uZF9jbGVhbnVwOwogCX0KIAotCS8qIENyZWF0ZSB0aHJlYWQg
dG8gbWFuYWdlIHRoZSBjbGllbnQgc29ja2V0ICovCisJLyogQ3JlYXRlIHRocmVhZCB0byBjbGVh
biB1cCBSQ1UgaGFzaCB0YWJsZXMgKi8KIAlyZXQgPSBwdGhyZWFkX2NyZWF0ZSgmaHRfY2xlYW51
cF90aHJlYWQsIE5VTEwsCiAJCQl0aHJlYWRfaHRfY2xlYW51cCwgKHZvaWQgKikgTlVMTCk7CiAJ
aWYgKHJldCAhPSAwKSB7CkBAIC00Nzk1LDcgKzQ3OTUsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCiAJCWdvdG8gZXhpdF9odF9jbGVhbnVwOwogCX0KIAotCS8qIENyZWF0ZSB0
aHJlYWQgdG8gbWFuYWdlIHRoZSBjbGllbnQgc29ja2V0ICovCisJLyogQ3JlYXRlIGhlYWx0aC1j
aGVjayB0aHJlYWQgKi8KIAlyZXQgPSBwdGhyZWFkX2NyZWF0ZSgmaGVhbHRoX3RocmVhZCwgTlVM
TCwKIAkJCXRocmVhZF9tYW5hZ2VfaGVhbHRoLCAodm9pZCAqKSBOVUxMKTsKIAlpZiAocmV0ICE9
IDApIHsKLS0gCjEuOC40LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
