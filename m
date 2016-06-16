From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Only build python lib when agent is
	enabled
Date: Thu, 16 Jun 2016 11:33:51 -0400
Message-ID: <1466091231-14452-1-git-send-email-mjeanson__2104.68549416891$1466091268$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 333E0A38AF
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jun 2016 15:34:05 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 10B0B340344
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jun 2016 15:34:05 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogTWFrZWZpbGUuYW0gfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5hbQpp
bmRleCAxZGI3NDgwLi5lNDk4NzE5IDEwMDY0NAotLS0gYS9NYWtlZmlsZS5hbQorKysgYi9NYWtl
ZmlsZS5hbQpAQCAtNiw3ICs2LDYgQEAgU1VCRElSUyA9IC4gaW5jbHVkZSBzbnByaW50ZiBsaWJy
aW5nYnVmZmVyIGxpYmx0dG5nLXVzdC1jb21tIFwKIAkJbGlibHR0bmctdXN0LWZvcmsgXAogCQls
aWJsdHRuZy11c3QtbGliYy13cmFwcGVyIFwKIAkJbGlibHR0bmctdXN0LWN5Zy1wcm9maWxlIFwK
LQkJbGlibHR0bmctdXN0LXB5dGhvbi1hZ2VudCBcCiAJCXRvb2xzCiAKIGlmIEhBVkVfRExJTkZP
CkBAIC0yMiw3ICsyMSw4IEBAIFNVQkRJUlMgKz0gbGlibHR0bmctdXN0LWphdmEtYWdlbnQKIGVu
ZGlmCiAKIGlmIEJVSUxEX1BZVEhPTl9BR0VOVAotU1VCRElSUyArPSBweXRob24tbHR0bmd1c3QK
K1NVQkRJUlMgKz0gcHl0aG9uLWx0dG5ndXN0IFwKKwkJbGlibHR0bmctdXN0LXB5dGhvbi1hZ2Vu
dAogZW5kaWYKIAogU1VCRElSUyArPSB0ZXN0cyBkb2MKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
