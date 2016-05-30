From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 2/4] Fix: strerror_r behavior is glibc
	specific
Date: Mon, 30 May 2016 16:31:31 -0400
Message-ID: <1464640293-10157-2-git-send-email-mjeanson__26719.8273599663$1464640332$gmane$org@efficios.com>
References: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EE9A6A3713
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C9E383401F8
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:52 +0000 (UTC)
In-Reply-To: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5jbHVkZS91c3RlcnItc2lnbmFsLXNhZmUuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdXN0ZXJy
LXNpZ25hbC1zYWZlLmggYi9pbmNsdWRlL3VzdGVyci1zaWduYWwtc2FmZS5oCmluZGV4IGJjNjhm
YmYuLjFkZjVhZGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdXN0ZXJyLXNpZ25hbC1zYWZlLmgKKysr
IGIvaW5jbHVkZS91c3RlcnItc2lnbmFsLXNhZmUuaApAQCAtMTA2LDcgKzEwNiw3IEBAIGRvIHsJ
CQkJCQkJCQlcCiAjZGVmaW5lIEVSUihmbXQsIGFyZ3MuLi4pCUVSUk1TRygiRXJyb3I6ICIgZm10
LCAjIyBhcmdzKQogI2RlZmluZSBCVUcoZm10LCBhcmdzLi4uKQlFUlJNU0coIkJVRzogIiBmbXQs
ICMjIGFyZ3MpCiAKLSNpZiAhZGVmaW5lZChfX2xpbnV4X18pIHx8ICgoX1BPU0lYX0NfU09VUkNF
ID49IDIwMDExMkwgfHwgX1hPUEVOX1NPVVJDRSA+PSA2MDApICYmICFkZWZpbmVkKF9HTlVfU09V
UkNFKSkKKyNpZiAhZGVmaW5lZChfX0dMSUJDX18pIHx8ICgoX1BPU0lYX0NfU09VUkNFID49IDIw
MDExMkwgfHwgX1hPUEVOX1NPVVJDRSA+PSA2MDApICYmICFkZWZpbmVkKF9HTlVfU09VUkNFKSkK
IC8qCiAgKiBWZXJzaW9uIHVzaW5nIFhTSSBzdHJlcnJvcl9yLgogICovCi0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
