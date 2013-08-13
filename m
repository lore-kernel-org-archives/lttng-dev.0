From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix ctf_clock_declaration_visit
	returning an error when reading a boolean
Date: Mon, 12 Aug 2013 21:59:56 -0400
Message-ID: <1376359196-25062-1-git-send-email-jeremie.galarneau__16864.1706499786$1376359267$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V93u1-00040F-3F
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 22:00:10 -0400
Received: by mail-qa0-f51.google.com with SMTP id f11so52048qae.3
	for <lttng-dev@lists.lttng.org>; Mon, 12 Aug 2013 18:59:59 -0700 (PDT)
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

VGhlIHJldCB2YXJpYWJsZSBpcyB1c2VkIHRvIHJlYWQgdGhlICJhYnNvbHV0ZSIgZmllbGQncyB2
YWx1ZSBhbmQgd2FzIG5vdCByZXNldAp0byB6ZXJvLCB0aHVzIHJldHVybmluZyBhbiBlcnJvciB3
aGVuZXZlciB0aGF0IHZhbHVlIHdhcyBUUlVFLgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdh
bGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgotLS0KIGZvcm1hdHMvY3Rm
L21ldGFkYXRhL2N0Zi12aXNpdG9yLWdlbmVyYXRlLWlvLXN0cnVjdC5jIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9tZXRhZGF0
YS9jdGYtdmlzaXRvci1nZW5lcmF0ZS1pby1zdHJ1Y3QuYyBiL2Zvcm1hdHMvY3RmL21ldGFkYXRh
L2N0Zi12aXNpdG9yLWdlbmVyYXRlLWlvLXN0cnVjdC5jCmluZGV4IDY2NGQwYWYuLmM3ZGU5MmUg
MTAwNjQ0Ci0tLSBhL2Zvcm1hdHMvY3RmL21ldGFkYXRhL2N0Zi12aXNpdG9yLWdlbmVyYXRlLWlv
LXN0cnVjdC5jCisrKyBiL2Zvcm1hdHMvY3RmL21ldGFkYXRhL2N0Zi12aXNpdG9yLWdlbmVyYXRl
LWlvLXN0cnVjdC5jCkBAIC0yMzk5LDYgKzIzOTksNyBAQCBpbnQgY3RmX2Nsb2NrX2RlY2xhcmF0
aW9uX3Zpc2l0KEZJTEUgKmZkLCBpbnQgZGVwdGgsIHN0cnVjdCBjdGZfbm9kZSAqbm9kZSwKIAkJ
CQlnb3RvIGVycm9yOwogCQkJfQogCQkJY2xvY2stPmFic29sdXRlID0gcmV0OworCQkJcmV0ID0g
MDsKIAkJfSBlbHNlIHsKIAkJCWZwcmludGYoZmQsICJbd2FybmluZ10gJXM6IGF0dHJpYnV0ZSBc
IiVzXCIgaXMgdW5rbm93biBpbiBjbG9jayBkZWNsYXJhdGlvbi5cbiIsIF9fZnVuY19fLCBsZWZ0
KTsKIAkJfQotLSAKMS44LjMuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
