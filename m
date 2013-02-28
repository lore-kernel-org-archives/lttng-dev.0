From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Ensure the specified input
	format is CTF
Date: Thu, 28 Feb 2013 18:30:12 -0500
Message-ID: <1362094212-27792-1-git-send-email-jeremie.galarneau__31644.900100264$1362094272$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UBCvl-0003Be-7x
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 18:30:29 -0500
Received: by mail-qa0-f44.google.com with SMTP id bv4so4643636qab.3
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 15:30:23 -0800 (PST)
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

QWRkIGEgY2hlY2sgdG8gbWFrZSBzdXJlIHRoZSBpbnB1dCB0cmFjZSBmb3JtYXQgYXJndW1lbnQg
cGFzc2VkIHRvIHRoZQpiYWJlbHRyYWNlIGNvbnZlcnRlciBpcyAiY3RmIiBhcyBpdCBpcyBjdXJy
ZW50bHkgdGhlIG9ubHkgb25lIHN1cHBvcnRlZC4KCkFkZCBhIG5vdGUgdG8gdGhpcyBlZmZlY3Qg
aW4gdGhlIG1hbiBwYWdlLgoKRml4ZXMgIzQ2MgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdh
bGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGNvbnZlcnRlci9i
YWJlbHRyYWNlLmMgfCAyICstCiBkb2MvYmFiZWx0cmFjZS4xICAgICAgIHwgMiArLQogMiBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
Y29udmVydGVyL2JhYmVsdHJhY2UuYyBiL2NvbnZlcnRlci9iYWJlbHRyYWNlLmMKaW5kZXggMjBk
ZWQwMC4uNjg0NzI0OCAxMDA2NDQKLS0tIGEvY29udmVydGVyL2JhYmVsdHJhY2UuYworKysgYi9j
b252ZXJ0ZXIvYmFiZWx0cmFjZS5jCkBAIC02MDcsNyArNjA3LDcgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQogCQl9CiAJfQogCWZtdF9yZWFkID0gYnRfbG9va3VwX2Zvcm1hdChn
X3F1YXJrX2Zyb21fc3RhdGljX3N0cmluZyhvcHRfaW5wdXRfZm9ybWF0KSk7Ci0JaWYgKCFmbXRf
cmVhZCkgeworCWlmICghZm10X3JlYWQgfHwgZm10X3JlYWQtPm5hbWUgIT0gZ19xdWFya19mcm9t
X3N0YXRpY19zdHJpbmcoImN0ZiIpKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiW2Vycm9yXSBGb3Jt
YXQgXCIlc1wiIGlzIG5vdCBzdXBwb3J0ZWQuXG5cbiIsCiAJCQlvcHRfaW5wdXRfZm9ybWF0KTsK
IAkJcGFydGlhbF9lcnJvciA9IDE7CmRpZmYgLS1naXQgYS9kb2MvYmFiZWx0cmFjZS4xIGIvZG9j
L2JhYmVsdHJhY2UuMQppbmRleCAzMTk2Mjk5Li43OGU5MDU1IDEwMDY0NAotLS0gYS9kb2MvYmFi
ZWx0cmFjZS4xCisrKyBiL2RvYy9iYWJlbHRyYWNlLjEKQEAgLTI5LDcgKzI5LDcgQEAgSW5wdXQg
dHJhY2UgRklMRShzKSBvciBkaXJlY3RvcnkoaWVzKQogT3V0cHV0IHRyYWNlIHBhdGggKGRlZmF1
bHQ6IHN0ZG91dCkKIC5UUAogLkJSICItaSwgLS1pbnB1dC1mb3JtYXQgRk9STUFUIgotSW5wdXQg
dHJhY2UgZm9ybWF0IChkZWZhdWx0OiBjdGYpCitJbnB1dCB0cmFjZSBmb3JtYXQgKGRlZmF1bHQ6
IGN0ZikuIENURiBpcyBjdXJyZW50bHkgdGhlIG9ubHkgc3VwcG9ydGVkIGlucHV0IGZvcm1hdC4K
IC5UUAogLkJSICItbywgLS1vdXRwdXQtZm9ybWF0IEZPUk1BVCIKIE91dHB1dCB0cmFjZSBmb3Jt
YXQgKGRlZmF1bHQ6IHRleHQpCi0tIAoxLjguMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
