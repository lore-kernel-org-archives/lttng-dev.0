From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 3/6] Fix: strerror_r behavior is
	glibc specific
Date: Wed, 15 Jun 2016 17:18:04 -0400
Message-ID: <1466025487-26743-3-git-send-email-mjeanson__23446.8476417989$1466025536$gmane$org@efficios.com>
References: <1466025487-26743-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 25A7FA385A
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 21:18:42 +0000 (UTC)
In-Reply-To: <1466025487-26743-1-git-send-email-mjeanson@efficios.com>
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
LQogc3JjL2NvbW1vbi9lcnJvci5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9lcnJvci5oIGIvc3Jj
L2NvbW1vbi9lcnJvci5oCmluZGV4IDBmYmQzYTIuLmU4YzgxMWUgMTAwNjQ0Ci0tLSBhL3NyYy9j
b21tb24vZXJyb3IuaAorKysgYi9zcmMvY29tbW9uL2Vycm9yLmgKQEAgLTE5OCw3ICsxOTgsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgX19sdHRuZ19wcmludF9jaGVja19hYm9ydChlbnVtIGx0dG5n
X2Vycm9yX2xldmVsIHR5cGUpCiAKICNkZWZpbmUgX1BFUlJPUihmbXQsIGFyZ3MuLi4pIF9FUlJN
U0coIlBFUlJPUiIsIFBSSU5UX0VSUiwgZm10LCAjIyBhcmdzKQogCi0jaWYgIWRlZmluZWQoX19s
aW51eF9fKSB8fCAoKF9QT1NJWF9DX1NPVVJDRSA+PSAyMDAxMTJMIHx8IF9YT1BFTl9TT1VSQ0Ug
Pj0gNjAwKSAmJiAhZGVmaW5lZChfR05VX1NPVVJDRSkpCisjaWYgIWRlZmluZWQoX19HTElCQ19f
KSB8fCAoKF9QT1NJWF9DX1NPVVJDRSA+PSAyMDAxMTJMIHx8IF9YT1BFTl9TT1VSQ0UgPj0gNjAw
KSAmJiAhZGVmaW5lZChfR05VX1NPVVJDRSkpCiAKIC8qCiAgKiBWZXJzaW9uIHVzaW5nIFhTSSBz
dHJlcnJvcl9yLgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
