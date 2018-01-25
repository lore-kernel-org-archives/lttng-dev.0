From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: do not flag consumer as
	disabled on relayd comm failure
Date: Thu, 25 Jan 2018 18:57:27 -0500
Message-ID: <1516924647-22584-1-git-send-email-jonathan.rajotte-julien__27058.4944206805$1516924588$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zSJrP267Fzvk0
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jan 2018 23:57:56 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgfCAxMCArKysr
Ky0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgYi9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NtZC5jCmluZGV4IGEyOTUwNTkuLjFlZGNmZmUgMTAwNjQ0Ci0tLSBhL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQu
YwpAQCAtOTIwLDcgKzkyMCw3IEBAIHN0YXRpYyBpbnQgc2VuZF9jb25zdW1lcl9yZWxheWRfc29j
a2V0KGVudW0gbHR0bmdfZG9tYWluX3R5cGUgZG9tYWluLAogCS8qIENvbm5lY3QgdG8gcmVsYXlk
IGFuZCBtYWtlIHZlcnNpb24gY2hlY2sgaWYgdXJpIGlzIHRoZSBjb250cm9sLiAqLwogCXJldCA9
IGNyZWF0ZV9jb25uZWN0X3JlbGF5ZChyZWxheWRfdXJpLCAmcnNvY2ssIGNvbnN1bWVyKTsKIAlp
ZiAocmV0ICE9IExUVE5HX09LKSB7Ci0JCWdvdG8gZXJyb3I7CisJCWdvdG8gcmVsYXlkX2NvbW1f
ZXJyb3I7CiAJfQogCWFzc2VydChyc29jayk7CiAKQEAgLTk2MCwxMCArOTYwLDYgQEAgc3RhdGlj
IGludCBzZW5kX2NvbnN1bWVyX3JlbGF5ZF9zb2NrZXQoZW51bSBsdHRuZ19kb21haW5fdHlwZSBk
b21haW4sCiAJICovCiAKIGNsb3NlX3NvY2s6Ci0JKHZvaWQpIHJlbGF5ZF9jbG9zZShyc29jayk7
Ci0JZnJlZShyc29jayk7Ci0KLWVycm9yOgogCWlmIChyZXQgIT0gTFRUTkdfT0spIHsKIAkJLyoK
IAkJICogVGhlIGNvbnN1bWVyIG91dHB1dCBmb3IgdGhpcyBzZXNzaW9uIHNob3VsZCBub3QgYmUg
dXNlZCBhbnltb3JlCkBAIC05NzIsNiArOTY4LDEwIEBAIGVycm9yOgogCQkgKi8KIAkJY29uc3Vt
ZXItPmVuYWJsZWQgPSAwOwogCX0KKwkodm9pZCkgcmVsYXlkX2Nsb3NlKHJzb2NrKTsKKwlmcmVl
KHJzb2NrKTsKKworcmVsYXlkX2NvbW1fZXJyb3I6CiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
