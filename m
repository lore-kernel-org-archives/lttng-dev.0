From: <rongqing.li@windriver.com>
Subject: [PATCH v2] Fix: Align buffers from objstack_alloc on
	sizeof(void *)
Date: Fri, 16 May 2014 10:10:38 +0800
Message-ID: <1400206238-11343-1-git-send-email-rongqing.li__10508.1047899604$1400248227$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Rongqing.Li@windriver.com>) id 1Wl7bi-0006OZ-JS
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 22:10:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jeremie.galarneau@efficios.com, lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, simon.marchi@polymtl.ca
List-Id: lttng-dev@lists.lttng.org

RnJvbTogRnJlZHJpayBNYXJrc3Ryw7ZtIDxmcmVkcmlrLm1hcmtzdHJvbUBnbWFpbC5jb20+CgpU
aGUgYnVmZmVycyBmcm9tIG9ianN0YWNrX2FsbG9jIHdpbGwgc3RvcmUgdGhlIHBvaW50ZXIsIHNv
IGl0IG11c3QKYmUgYWxpZ25lZCBvbiBwb2ludGVyLCBvciBlbHNlIGl0IHdpbGwgY2F1c2UgaXNz
dWUgb24gdGhlIGNwdQp3aGljaCBkb2VzIG5vdCBzdXBwb3J0IHVuYWxpZ25lZCBhZGRyZXNzZXMg
YWNjZXNzCgpTaWduZWQtb2ZmLWJ5OiBGcmVkcmlrIE1hcmtzdHJvbSA8ZnJlZHJpay5tYXJrc3Ry
b21AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBSb3kgTGkgPHJvbmdxaW5nLmxpQHdpbmRyaXZl
ci5jb20+Ci0tLQogZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYyB8ICAgIDQgKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMgYi9mb3JtYXRzL2N0Zi9tZXRhZGF0
YS9vYmpzdGFjay5jCmluZGV4IDllMjY0YTQuLjBlN2QwNGUgMTAwNjQ0Ci0tLSBhL2Zvcm1hdHMv
Y3RmL21ldGFkYXRhL29ianN0YWNrLmMKKysrIGIvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3Rh
Y2suYwpAQCAtMzksNyArMzksNyBAQCBzdHJ1Y3Qgb2Jqc3RhY2tfbm9kZSB7CiAJc3RydWN0IGJ0
X2xpc3RfaGVhZCBub2RlOwogCXNpemVfdCBsZW47CiAJc2l6ZV90IHVzZWRfbGVuOwotCWNoYXIg
ZGF0YVtdOworCWNoYXIgX19hdHRyaWJ1dGVfXyAoKGFsaWduZWQgKHNpemVvZih2b2lkICopKSkp
IGRhdGFbXTsKIH07CiAKIEJUX0hJRERFTgpAQCAtMTE4LDYgKzExOCw4IEBAIHZvaWQgKm9ianN0
YWNrX2FsbG9jKHN0cnVjdCBvYmpzdGFjayAqb2Jqc3RhY2ssIHNpemVfdCBsZW4pCiAJc3RydWN0
IG9ianN0YWNrX25vZGUgKmxhc3Rfbm9kZTsKIAl2b2lkICpwOwogCisJbGVuID0gQUxJR04obGVu
LCBzaXplb2Yodm9pZCAqKSk7CisKIAkvKiBHZXQgbGFzdCBub2RlICovCiAJbGFzdF9ub2RlID0g
YnRfbGlzdF9lbnRyeShvYmpzdGFjay0+aGVhZC5wcmV2LAogCQkJc3RydWN0IG9ianN0YWNrX25v
ZGUsIG5vZGUpOwotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
