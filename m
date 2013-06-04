From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Missing read locks on access
	to consumerd's channel hash table
Date: Mon,  3 Jun 2013 23:19:59 -0400
Message-ID: <1370315999-8598-1-git-send-email-jeremie.galarneau__39795.5151078806$1370316062$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UjhnB-0004D0-4r
	for lttng-dev@lists.lttng.org; Mon, 03 Jun 2013 23:20:13 -0400
Received: by mail-qa0-f52.google.com with SMTP id cr7so114931qab.11
	for <lttng-dev@lists.lttng.org>; Mon, 03 Jun 2013 20:20:07 -0700 (PDT)
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
aWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uc3VtZXIuYyB8IDYgKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb25zdW1l
ci5jIGIvc3JjL2NvbW1vbi9jb25zdW1lci5jCmluZGV4IDM3MDkwOTIuLjVmMzgzNzUgMTAwNjQ0
Ci0tLSBhL3NyYy9jb21tb24vY29uc3VtZXIuYworKysgYi9zcmMvY29tbW9uL2NvbnN1bWVyLmMK
QEAgLTI3MTYsMTYgKzI3MTYsMjEgQEAgcmVzdGFydDoKIAogCQkJCQkJbHR0bmdfaHRfbm9kZV9p
bml0X3U2NCgmY2hhbi0+d2FpdF9mZF9ub2RlLAogCQkJCQkJCWNoYW4tPndhaXRfZmQpOworCQkJ
CQkJcmN1X3JlYWRfbG9jaygpOwogCQkJCQkJbHR0bmdfaHRfYWRkX3VuaXF1ZV91NjQoY2hhbm5l
bF9odCwKIAkJCQkJCQkJJmNoYW4tPndhaXRfZmRfbm9kZSk7CisJCQkJCQlyY3VfcmVhZF91bmxv
Y2soKTsKIAkJCQkJCS8qIEFkZCBjaGFubmVsIHRvIHRoZSBnbG9iYWwgcG9sbCBldmVudHMgbGlz
dCAqLwogCQkJCQkJbHR0bmdfcG9sbF9hZGQoJmV2ZW50cywgY2hhbi0+d2FpdF9mZCwKIAkJCQkJ
CQkJTFBPTExJTiB8IExQT0xMUFJJKTsKIAkJCQkJCWJyZWFrOwogCQkJCQljYXNlIENPTlNVTUVS
X0NIQU5ORUxfREVMOgogCQkJCQl7CisJCQkJCQlyY3VfcmVhZF9sb2NrKCk7CiAJCQkJCQljaGFu
ID0gY29uc3VtZXJfZmluZF9jaGFubmVsKGtleSk7CisKIAkJCQkJCWlmICghY2hhbikgeworCQkJ
CQkJCXJjdV9yZWFkX3VubG9jaygpOwogCQkJCQkJCUVSUigiVVNUIGNvbnN1bWVyIGdldCBjaGFu
bmVsIGtleSAlIiBQUkl1NjQgIiBub3QgZm91bmQgZm9yIGRlbCBjaGFubmVsIiwga2V5KTsKIAkJ
CQkJCQlicmVhazsKIAkJCQkJCX0KQEAgLTI3NDEsNiArMjc0Niw3IEBAIHJlc3RhcnQ6CiAJCQkJ
CQlpZiAoIXVhdG9taWNfc3ViX3JldHVybigmY2hhbi0+cmVmY291bnQsIDEpKSB7CiAJCQkJCQkJ
Y29uc3VtZXJfZGVsX2NoYW5uZWwoY2hhbik7CiAJCQkJCQl9CisJCQkJCQlyY3VfcmVhZF91bmxv
Y2soKTsKIAkJCQkJCWdvdG8gcmVzdGFydDsKIAkJCQkJfQogCQkJCQljYXNlIENPTlNVTUVSX0NI
QU5ORUxfUVVJVDoKLS0gCjEuOC4yLjMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
