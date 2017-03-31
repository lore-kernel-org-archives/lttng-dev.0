From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-modules 07/10] Fix callstack context:
	write empty sequence if no stack trace
Date: Fri, 31 Mar 2017 09:17:16 -0400
Message-ID: <1490966239-21284-8-git-send-email-mathieu.desnoyers__7577.36894670433$1490966658$gmane$org@efficios.com>
References: <1490966239-21284-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vvhyJ4kwMzw6n
 for <lttng-dev@lists.lttng.org>; Fri, 31 Mar 2017 13:23:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E9BBB3402E2
 for <lttng-dev@lists.lttng.org>; Fri, 31 Mar 2017 13:18:30 +0000 (UTC)
In-Reply-To: <1490966239-21284-1-git-send-email-mathieu.desnoyers@efficios.com>
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
List-Id: lttng-dev@lists.lttng.org

VGhlIHRyYWNlIGNvbnRlbnQgbmVlZHMgdG8gbWF0Y2ggdGhlIG1ldGFkYXRhLCBlbHNlIHRoZSB0
cmFjZSB3aWxsIGJlCmNvcnJ1cHRlZC4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJz
IDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogbHR0bmctY29udGV4dC1jYWxs
c3RhY2suYyB8IDE1ICsrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbHR0bmctY29udGV4dC1jYWxsc3Rh
Y2suYyBiL2x0dG5nLWNvbnRleHQtY2FsbHN0YWNrLmMKaW5kZXggM2I3ODU5ZS4uNTc3MzhiZSAx
MDA2NDQKLS0tIGEvbHR0bmctY29udGV4dC1jYWxsc3RhY2suYworKysgYi9sdHRuZy1jb250ZXh0
LWNhbGxzdGFjay5jCkBAIC0xNTYsOCArMTU2LDEyIEBAIHNpemVfdCBsdHRuZ19jYWxsc3RhY2tf
Z2V0X3NpemUoc2l6ZV90IG9mZnNldCwgc3RydWN0IGx0dG5nX2N0eF9maWVsZCAqZmllbGQsCiAK
IAkvKiBkbyBub3Qgd3JpdGUgZGF0YSBpZiBubyBzcGFjZSBpcyBhdmFpbGFibGUgKi8KIAl0cmFj
ZSA9IHN0YWNrX3RyYWNlX2NvbnRleHQoZmllbGQsIGN0eCk7Ci0JaWYgKCF0cmFjZSkKLQkJcmV0
dXJuIDA7CisJaWYgKHVubGlrZWx5KCF0cmFjZSkpIHsKKwkJc2l6ZSArPSBsaWJfcmluZ19idWZm
ZXJfYWxpZ24ob2Zmc2V0LCBsdHRuZ19hbGlnbm9mKHVuc2lnbmVkIGludCkpOworCQlzaXplICs9
IHNpemVvZih1bnNpZ25lZCBpbnQpOworCQlzaXplICs9IGxpYl9yaW5nX2J1ZmZlcl9hbGlnbihv
ZmZzZXQsIGx0dG5nX2FsaWdub2YodW5zaWduZWQgbG9uZykpOworCQlyZXR1cm4gc2l6ZTsKKwl9
CiAKIAkvKiByZXNldCBzdGFjayB0cmFjZSwgbm8gbmVlZCB0byBjbGVhciBtZW1vcnkgKi8KIAl0
cmFjZS0+bnJfZW50cmllcyA9IDA7CkBAIC0xOTEsOCArMTk1LDEzIEBAIHZvaWQgbHR0bmdfY2Fs
bHN0YWNrX3JlY29yZChzdHJ1Y3QgbHR0bmdfY3R4X2ZpZWxkICpmaWVsZCwKIAlzdHJ1Y3Qgc3Rh
Y2tfdHJhY2UgKnRyYWNlID0gc3RhY2tfdHJhY2VfY29udGV4dChmaWVsZCwgY3R4KTsKIAl1bnNp
Z25lZCBpbnQgbnJfc2VxX2VudHJpZXM7CiAKLQlpZiAoIXRyYWNlKQorCWlmICh1bmxpa2VseSgh
dHJhY2UpKSB7CisJCW5yX3NlcV9lbnRyaWVzID0gMDsKKwkJbGliX3JpbmdfYnVmZmVyX2FsaWdu
X2N0eChjdHgsIGx0dG5nX2FsaWdub2YodW5zaWduZWQgaW50KSk7CisJCWNoYW4tPm9wcy0+ZXZl
bnRfd3JpdGUoY3R4LCAmbnJfc2VxX2VudHJpZXMsIHNpemVvZih1bnNpZ25lZCBpbnQpKTsKKwkJ
bGliX3JpbmdfYnVmZmVyX2FsaWduX2N0eChjdHgsIGx0dG5nX2FsaWdub2YodW5zaWduZWQgbG9u
ZykpOwogCQlyZXR1cm47CisJfQogCWxpYl9yaW5nX2J1ZmZlcl9hbGlnbl9jdHgoY3R4LCBsdHRu
Z19hbGlnbm9mKHVuc2lnbmVkIGludCkpOwogCW5yX3NlcV9lbnRyaWVzID0gdHJhY2UtPm5yX2Vu
dHJpZXM7CiAJaWYgKHRyYWNlLT5ucl9lbnRyaWVzID09IHRyYWNlLT5tYXhfZW50cmllcykKLS0g
CjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
