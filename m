From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: lttng-live use g_free rather than free
Date: Mon, 18 Apr 2016 22:26:40 -0400
Message-ID: <1461032800-19065-1-git-send-email-mathieu.desnoyers__11082.2120834657$1461032836$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0295DA04A1
 for <lttng-dev@lists.lttng.org>; Tue, 19 Apr 2016 02:26:54 +0000 (UTC)
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

Z19uZXcwIHNob3VsZCBiZSBwYWlyZWQgd2l0aCBnX2ZyZWUuCgpTaWduZWQtb2ZmLWJ5OiBNYXRo
aWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0KIGZvcm1h
dHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLXBsdWdpbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZm9ybWF0cy9sdHRu
Zy1saXZlL2x0dG5nLWxpdmUtcGx1Z2luLmMgYi9mb3JtYXRzL2x0dG5nLWxpdmUvbHR0bmctbGl2
ZS1wbHVnaW4uYwppbmRleCBhZGI3MjQ5Li5iZjcxYjJiIDEwMDY0NAotLS0gYS9mb3JtYXRzL2x0
dG5nLWxpdmUvbHR0bmctbGl2ZS1wbHVnaW4uYworKysgYi9mb3JtYXRzL2x0dG5nLWxpdmUvbHR0
bmctbGl2ZS1wbHVnaW4uYwpAQCAtMzA3LDcgKzMwNyw3IEBAIGludCBsdHRuZ19saXZlX2Nsb3Nl
X3RyYWNlKHN0cnVjdCBidF90cmFjZV9kZXNjcmlwdG9yICp0ZCkKIAlzdHJ1Y3QgY3RmX3RleHRf
c3RyZWFtX3BvcyAqcG9zID0KIAkJY29udGFpbmVyX29mKHRkLCBzdHJ1Y3QgY3RmX3RleHRfc3Ry
ZWFtX3BvcywKIAkJCXRyYWNlX2Rlc2NyaXB0b3IpOwotCWZyZWUocG9zKTsKKwlnX2ZyZWUocG9z
KTsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
