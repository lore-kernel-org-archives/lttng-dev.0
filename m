From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 1/4] Add support for musl libc to
	ust-dlfcn.h
Date: Mon, 30 May 2016 16:31:30 -0400
Message-ID: <1464640293-10157-1-git-send-email-mjeanson__29213.9416946613$1464640325$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6DEF1A3713
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 20A703401F8
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:45 +0000 (UTC)
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
LQogaW5jbHVkZS9sdHRuZy91c3QtZGxmY24uaCB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbHR0bmcvdXN0LWRsZmNuLmggYi9p
bmNsdWRlL2x0dG5nL3VzdC1kbGZjbi5oCmluZGV4IGM5MmYxYmIuLjc0NzFkOTQgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbHR0bmcvdXN0LWRsZmNuLmgKKysrIGIvaW5jbHVkZS9sdHRuZy91c3QtZGxm
Y24uaApAQCAtMzEsNiArMzEsNyBAQAogI2Vycm9yICJQbGVhc2UgaW5jbHVkZSBsdHRuZy91c3Qt
ZGxmY24uaCBiZWZvcmUgZGxmY24uaC4iCiAjZW5kaWYgLyogX0RMRkNOX0ggKi8KIAorI2lmZGVm
IF9fR0xJQkNfXwogLyoKICAqIGdsaWJjIGRlY2xhcmVzIGRsc3ltKCkgYW5kIGRsZXJyb3IoKSB3
aXRoIF9fYXR0cmlidXRlX18oKGxlYWYpKSAoc2VlCiAgKiBUSFJPVyBhbm5vdGF0aW9uKS4gVW5m
b3J0dW5hdGVseSwgdGhpcyBpcyBub3QgaW4gc3luYyB3aXRoIHJlYWxpdHksCkBAIC01Nyw1ICs1
OCw4IEBAIGV4dGVybiBpbnQgZGxjbG9zZSh2b2lkICpfX2hhbmRsZSkgX19ub25udWxsICgoMSkp
OwogZXh0ZXJuIHZvaWQgKmRsc3ltKHZvaWQgKl9fcmVzdHJpY3QgX19oYW5kbGUsCiAJCV9fY29u
c3QgY2hhciAqX19yZXN0cmljdCBfX25hbWUpIF9fbm9ubnVsbCAoKDIpKTsKIGV4dGVybiBjaGFy
ICpkbGVycm9yKHZvaWQpOworI2Vsc2UKKyNpbmNsdWRlIDxkbGZjbi5oPgorI2VuZGlmIC8qIF9f
R0xJQkNfXyAqLwogCiAjZW5kaWYgLyogX0xUVE5HX1VTVF9ETEZDTl9IICovCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
