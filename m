From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: build lib before
	python-plugin-provider
Date: Mon, 28 Aug 2017 17:08:28 -0400
Message-ID: <1503954508-11713-1-git-send-email-mjeanson__30808.5495526486$1503954545$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xh4BL16SPzsnt
 for <lttng-dev@lists.lttng.org>; Mon, 28 Aug 2017 21:08:41 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogTWFrZWZpbGUuYW0gfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5hbQpp
bmRleCBkZTQzNmM0Li4yYmQ2YmYwIDEwMDY0NAotLS0gYS9NYWtlZmlsZS5hbQorKysgYi9NYWtl
ZmlsZS5hbQpAQCAtMyw3ICszLDggQEAgQUNMT0NBTF9BTUZMQUdTID0gLUkgbTQKIFNVQkRJUlMg
PSBpbmNsdWRlCQlcCiAJY29tbW9uCQkJXAogCWNvbXBhdAkJCVwKLQlsb2dnaW5nCisJbG9nZ2lu
ZwkJCVwKKwlsaWIKIAogaWYgRU5BQkxFX1BZVEhPTl9QTFVHSU5TCiAjIE9ubHkgYnVpbGQgdGhl
IFB5dGhvbiBwbHVnaW4gcHJvdmlkZXIgc2hhcmVkIG9iamVjdCBpZiB0aGUKQEAgLTEyLDcgKzEz
LDYgQEAgU1VCRElSUyArPSBweXRob24tcGx1Z2luLXByb3ZpZGVyCiBlbmRpZgogCiBTVUJESVJT
ICs9CQkJXAotCWxpYgkJCVwKIAlwbHVnaW5zCQkJXAogCWNsaQkJCVwKIAliaW5kaW5ncwkJXAot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
