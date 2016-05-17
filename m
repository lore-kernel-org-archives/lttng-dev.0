From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unchecked return value
Date: Tue, 17 May 2016 12:17:05 -0400
Message-ID: <1463501825-9240-1-git-send-email-mathieu.desnoyers__4584.515564102$1463501857$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A6343A3525
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 16:17:09 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTAxOTk3MSAoIzEgb2YgMSk6IFVuY2hlY2tlZCByZXR1
cm4gdmFsdWUgZnJvbSBsaWJyYXJ5CihDSEVDS0VEX1JFVFVSTikyLiBjaGVja19yZXR1cm46IENh
bGxpbmcgcG9zaXhfZmFkdmlzZShvdXRmZCwKb3JpZ19vZmZzZXQgLSBzdHJlYW0tPm1heF9zYl9z
aXplLCBzdHJlYW0tPm1heF9zYl9zaXplLCA0KSB3aXRob3V0CmNoZWNraW5nIHJldHVybiB2YWx1
ZS4gVGhpcyBsaWJyYXJ5IGZ1bmN0aW9uIG1heSBmYWlsIGFuZCByZXR1cm4gYW4KZXJyb3IgY29k
ZS4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi9jb25zdW1lci9jb25zdW1lci5jIHwgNiArKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc3JjL2NvbW1vbi9jb25zdW1lci9jb25zdW1lci5jIGIvc3JjL2NvbW1vbi9jb25z
dW1lci9jb25zdW1lci5jCmluZGV4IGNiMDVhMWUuLmUyMmRlNGQgMTAwNjQ0Ci0tLSBhL3NyYy9j
b21tb24vY29uc3VtZXIvY29uc3VtZXIuYworKysgYi9zcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1
bWVyLmMKQEAgLTEyNjIsOCArMTI2MiwxMCBAQCB2b2lkIGx0dG5nX2NvbnN1bWVyX3N5bmNfdHJh
Y2VfZmlsZShzdHJ1Y3QgbHR0bmdfY29uc3VtZXJfc3RyZWFtICpzdHJlYW0sCiAJICogZGVmaW5l
ZC4gU28gaXQgY2FuIGJlIGV4cGVjdGVkIHRvIGxlYWQgdG8gbG93ZXIgdGhyb3VnaHB1dCBpbgog
CSAqIHN0cmVhbWluZy4KIAkgKi8KLQlwb3NpeF9mYWR2aXNlKG91dGZkLCBvcmlnX29mZnNldCAt
IHN0cmVhbS0+bWF4X3NiX3NpemUsCi0JCQlzdHJlYW0tPm1heF9zYl9zaXplLCBQT1NJWF9GQURW
X0RPTlRORUVEKTsKKwlpZiAocG9zaXhfZmFkdmlzZShvdXRmZCwgb3JpZ19vZmZzZXQgLSBzdHJl
YW0tPm1heF9zYl9zaXplLAorCQkJc3RyZWFtLT5tYXhfc2Jfc2l6ZSwgUE9TSVhfRkFEVl9ET05U
TkVFRCkpIHsKKwkJREJHKCJJZ25vcmluZyBwb3NpeF9mYWR2aXNlKCkgZXJyb3I6ICVzLiIsIHN0
cmVycm9yKGVycm5vKSk7CisJfQogfQogCiAvKgotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
