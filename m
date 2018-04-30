From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Initialize ret to zero
Date: Mon, 30 Apr 2018 14:27:35 -0400
Message-ID: <20180430182735.12118-1-jonathan.rajotte-julien__36543.6699627482$1525112755$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40ZY1h3CCgz17pg
 for <lttng-dev@lists.lttng.org>; Mon, 30 Apr 2018 14:27:52 -0400 (EDT)
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

c2FtcGxlX2NoYW5uZWxfcG9zaXRpb25zIHJldHVybiBnYXJiYWdlIGlmIGNkc19sZmh0X2lzX25v
ZGVfZGVsZXRlZCgmc3RyZWFtLT5ub2RlLm5vZGUpCm9uIGZpcnN0IGFuZCAicG9zc2libHkiIG9u
bHkgaXRlcmF0aW9uIG9mIHRoZSBjb25zdW1lcl9kYXRhLnN0cmVhbV9wZXJfY2hhbl9pZF9odApo
YXNoIHRhYmxlLgoKRm91bmQgYnkgc2Nhbi1idWlsZAoKU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
UmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgotLS0KIHNyYy9j
b21tb24vY29uc3VtZXIvY29uc3VtZXItdGltZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29u
c3VtZXIvY29uc3VtZXItdGltZXIuYyBiL3NyYy9jb21tb24vY29uc3VtZXIvY29uc3VtZXItdGlt
ZXIuYwppbmRleCA3MjFmMTQ2ZS4uMzhiOGIzMGQgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24vY29u
c3VtZXIvY29uc3VtZXItdGltZXIuYworKysgYi9zcmMvY29tbW9uL2NvbnN1bWVyL2NvbnN1bWVy
LXRpbWVyLmMKQEAgLTYzNyw3ICs2MzcsNyBAQCBpbnQgc2FtcGxlX2NoYW5uZWxfcG9zaXRpb25z
KHN0cnVjdCBsdHRuZ19jb25zdW1lcl9jaGFubmVsICpjaGFubmVsLAogCQlzYW1wbGVfcG9zaXRp
b25zX2NiIHNhbXBsZSwgZ2V0X2NvbnN1bWVkX2NiIGdldF9jb25zdW1lZCwKIAkJZ2V0X3Byb2R1
Y2VkX2NiIGdldF9wcm9kdWNlZCkKIHsKLQlpbnQgcmV0OworCWludCByZXQgPSAwOwogCXN0cnVj
dCBsdHRuZ19odF9pdGVyIGl0ZXI7CiAJc3RydWN0IGx0dG5nX2NvbnN1bWVyX3N0cmVhbSAqc3Ry
ZWFtOwogCWJvb2wgZW1wdHlfY2hhbm5lbCA9IHRydWU7Ci0tIAoyLjE3LjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
