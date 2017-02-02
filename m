From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5 2/5] Port: win32 DLLs
	don't support hidden symbols
Date: Thu,  2 Feb 2017 17:03:09 -0500
Message-ID: <1486072992-21895-2-git-send-email-mjeanson__10722.2962113612$1486073063$gmane$org@efficios.com>
References: <1486072992-21895-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vDvGt5JztzkxC
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2017 22:06:46 +0000 (UTC)
In-Reply-To: <1486072992-21895-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5jbHVkZS9iYWJlbHRyYWNlL2JhYmVsdHJhY2UtaW50ZXJuYWwuaCB8IDYgKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9iYWJl
bHRyYWNlL2JhYmVsdHJhY2UtaW50ZXJuYWwuaCBiL2luY2x1ZGUvYmFiZWx0cmFjZS9iYWJlbHRy
YWNlLWludGVybmFsLmgKaW5kZXggMGU3M2NkYi4uNmY4ZTIwMCAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9iYWJlbHRyYWNlL2JhYmVsdHJhY2UtaW50ZXJuYWwuaAorKysgYi9pbmNsdWRlL2JhYmVsdHJh
Y2UvYmFiZWx0cmFjZS1pbnRlcm5hbC5oCkBAIC0xNjEsOCArMTYxLDE0IEBAIGV4dGVybiBpbnQg
YmFiZWx0cmFjZV92ZXJib3NlLCBiYWJlbHRyYWNlX2RlYnVnOwogCiAvKgogICogQlRfSElEREVO
OiBzZXQgdGhlIGhpZGRlbiBhdHRyaWJ1dGUgZm9yIGludGVybmFsIGZ1bmN0aW9ucworICogT24g
V2luZG93cywgc3ltYm9scyBhcmUgbG9jYWwgdW5sZXNzIGV4cGxpY2l0bHkgZXhwb3J0ZWQsCisg
KiBzZWUgaHR0cHM6Ly9nY2MuZ251Lm9yZy93aWtpL1Zpc2liaWxpdHkKICAqLworI2lmIGRlZmlu
ZWQoX1dJTjMyKSB8fCBkZWZpbmVkKF9fQ1lHV0lOX18pCisjZGVmaW5lIEJUX0hJRERFTgorI2Vs
c2UKICNkZWZpbmUgQlRfSElEREVOIF9fYXR0cmlidXRlX18oKHZpc2liaWxpdHkoImhpZGRlbiIp
KSkKKyNlbmRpZgogCiAjZGVmaW5lIEJUX0NURl9NQUpPUgkxCiAjZGVmaW5lIEJUX0NURl9NSU5P
Ugk4Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
