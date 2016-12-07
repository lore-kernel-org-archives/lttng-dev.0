From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: asoc instrumentation for
	RHEL 7.3
Date: Wed,  7 Dec 2016 14:17:33 -0500
Message-ID: <1481138253-2365-1-git-send-email-mjeanson__15024.4159195156$1481138282$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYpGL0ZtLzdyP
 for <lttng-dev@lists.lttng.org>; Wed,  7 Dec 2016 19:19:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3877B3402EC
 for <lttng-dev@lists.lttng.org>; Wed,  7 Dec 2016 19:19:27 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYXNvYy5oIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9hc29jLmggYi9pbnN0cnVtZW50
YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9hc29jLmgKaW5kZXggMDllMWZlMi4uMjUxMzZlYyAx
MDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYXNvYy5oCisr
KyBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2Fzb2MuaApAQCAtMjEsNyAr
MjEsOCBAQCBzdHJ1Y3Qgc25kX3NvY19jYXJkOwogc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQ7
CiAjZW5kaWYKIAotI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywx
NiwwKSkKKyNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDMsMTYsMCkg
XAorCXx8IExUVE5HX1JIRUxfS0VSTkVMX1JBTkdFKDMsMTAsMCw1MTQsMCwwLCAzLDExLDAsMCww
LDApKQogI2RlZmluZSBDT0RFQ19OQU1FX0ZJRUxEIGNvbXBvbmVudC5uYW1lCiAjZGVmaW5lIENP
REVDX0lEX0ZJRUxEIGNvbXBvbmVudC5pZAogI2Vsc2UKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
