From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Don't include the binary in
	the live test's EXTRA_DIST
Date: Mon,  5 May 2014 15:21:18 -0400
Message-ID: <1399317678-28752-1-git-send-email-jeremie.galarneau__12743.8550153331$1399395280$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WhOS7-0003V5-7m
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 15:21:32 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so2493896qgz.30
 for <lttng-dev@lists.lttng.org>; Mon, 05 May 2014 12:21:21 -0700 (PDT)
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

QWRkaW5nIHRoZSBiaW5hcnkgaW4gRVhUUkFfRElTVCBjYXVzZXMgdGhlICJkaXN0IiB0YXJnZXQg
dG8gZmFpbAp3aXRoIGEgIk5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgbGlidGFwLmxhIiBlcnJvci4K
ClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVm
ZmljaW9zLmNvbT4KLS0tCiB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2xpdmUvTWFrZWZpbGUuYW0g
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2xpdmUvTWFrZWZpbGUuYW0gYi90ZXN0
cy9yZWdyZXNzaW9uL3Rvb2xzL2xpdmUvTWFrZWZpbGUuYW0KaW5kZXggZmRmOWQzYS4uMTY3Yjll
NiAxMDA2NDQKLS0tIGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9saXZlL01ha2VmaWxlLmFtCisr
KyBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbGl2ZS9NYWtlZmlsZS5hbQpAQCAtMjIsNyArMjIs
NyBAQCBMSVZFPSQodG9wX2J1aWxkZGlyKS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3Nlc3Npb24u
byBcCiAJICQodG9wX2J1aWxkZGlyKS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3NuYXBzaG90Lm8K
IAogbm9pbnN0X1BST0dSQU1TID0gbGl2ZV90ZXN0Ci1FWFRSQV9ESVNUID0gbGl2ZV90ZXN0IHRl
c3Rfa2VybmVsCitFWFRSQV9ESVNUID0gdGVzdF9rZXJuZWwKIAogaWYgSEFWRV9MSUJMVFROR19V
U1RfQ1RMCiBFWFRSQV9ESVNUICs9IHRlc3RfdXN0IHRlc3RfdXN0X3RyYWNlZmlsZV9jb3VudAot
LSAKMS45LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
