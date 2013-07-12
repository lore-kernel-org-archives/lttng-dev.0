From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Fix: Unchecked asprintf/vasprintf
	return values
Date: Fri, 12 Jul 2013 12:37:28 -0400
Message-ID: <1373647048-5640-1-git-send-email-jeremie.galarneau__11424.5157143616$1373647093$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UxgLh-000314-4Q
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 12:37:37 -0400
Received: by mail-qc0-f173.google.com with SMTP id l10so5112362qcy.18
	for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2013 09:37:31 -0700 (PDT)
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
c3RzL3RhcC5jIHwgMTIgKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RhcC5jIGIvdGVzdHMvdGFw
LmMKaW5kZXggODZjODlhMi4uOGJmNzJmNiAxMDA2NDQKLS0tIGEvdGVzdHMvdGFwLmMKKysrIGIv
dGVzdHMvdGFwLmMKQEAgLTgzLDcgKzgzLDkgQEAgX2dlbl9yZXN1bHQoaW50IG9rLCBjb25zdCBj
aGFyICpmdW5jLCBjaGFyICpmaWxlLCB1bnNpZ25lZCBpbnQgbGluZSwKIAkgICBleHBhbnNpb25z
IG9uIGl0ICovCiAJaWYodGVzdF9uYW1lICE9IE5VTEwpIHsKIAkJdmFfc3RhcnQoYXAsIHRlc3Rf
bmFtZSk7Ci0JCXZhc3ByaW50ZigmbG9jYWxfdGVzdF9uYW1lLCB0ZXN0X25hbWUsIGFwKTsKKwkJ
aWYgKHZhc3ByaW50ZigmbG9jYWxfdGVzdF9uYW1lLCB0ZXN0X25hbWUsIGFwKSA9PSAtMSkgewor
CQkJbG9jYWxfdGVzdF9uYW1lID0gTlVMTDsKKwkJfQogCQl2YV9lbmQoYXApOwogCiAJCS8qIE1h
a2Ugc3VyZSB0aGUgdGVzdCBuYW1lIGNvbnRhaW5zIG1vcmUgdGhhbiBkaWdpdHMKQEAgLTI5OSw3
ICszMDEsOSBAQCBza2lwKHVuc2lnbmVkIGludCBuLCBjaGFyICpmbXQsIC4uLikKIAlMT0NLOwog
CiAJdmFfc3RhcnQoYXAsIGZtdCk7Ci0JYXNwcmludGYoJnNraXBfbXNnLCBmbXQsIGFwKTsKKwlp
ZiAoYXNwcmludGYoJnNraXBfbXNnLCBmbXQsIGFwKSA9PSAtMSkgeworCQlza2lwX21zZyA9IE5V
TEw7CisJfQogCXZhX2VuZChhcCk7CiAKIAl3aGlsZShuLS0gPiAwKSB7CkBAIC0zMjQsNyArMzI4
LDkgQEAgdG9kb19zdGFydChjaGFyICpmbXQsIC4uLikKIAlMT0NLOwogCiAJdmFfc3RhcnQoYXAs
IGZtdCk7Ci0JdmFzcHJpbnRmKCZ0b2RvX21zZywgZm10LCBhcCk7CisJaWYgKHZhc3ByaW50Zigm
dG9kb19tc2csIGZtdCwgYXApID09IC0xKSB7CisJCXRvZG9fbXNnID0gTlVMTDsKKwl9CiAJdmFf
ZW5kKGFwKTsKIAogCXRvZG8gPSAxOwotLSAKMS44LjMuMgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
