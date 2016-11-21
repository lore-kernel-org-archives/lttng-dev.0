From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-tools] Fix: add missing refcount of loaded
	modules
Date: Mon, 21 Nov 2016 12:36:00 -0500
Message-ID: <1479749760-20017-1-git-send-email-francis.deslauriers__19750.9339931004$1479749812$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tMwmQ5qZTzlxq
 for <lttng-dev@lists.lttng.org>; Mon, 21 Nov 2016 17:37:58 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5jIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tb2Rwcm9iZS5jCmluZGV4IDA1MDI3NDAuLjAzNTQ1ZWYgMTAwNjQ0Ci0tLSBhL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Np
b25kL21vZHByb2JlLmMKQEAgLTM0Myw3ICszNDMsNyBAQCBzdGF0aWMgaW50IG1vZHByb2JlX2x0
dG5nKHN0cnVjdCBrZXJuX21vZHVsZXNfcGFyYW0gKm1vZHVsZXMsCiAJCQl9CiAJCX0gZWxzZSB7
CiAJCQlEQkcoIk1vZHByb2JlIHN1Y2Nlc3NmdWxseSAlcyIsIG1vZHVsZXNbaV0ubmFtZSk7Ci0J
CQltb2R1bGVzW2ldLmxvYWRlZDsKKwkJCW1vZHVsZXNbaV0ubG9hZGVkID0gdHJ1ZTsKIAkJfQog
CX0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
