From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: update kvm instrumentation
	for 4.1.50+
Date: Thu,  8 Mar 2018 11:18:56 -0500
Message-ID: <1520525936-13554-1-git-send-email-mjeanson__40694.8972064585$1520525831$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zxwgW18Sdz130
 for <lttng-dev@lists.lttng.org>; Thu,  8 Mar 2018 11:19:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 39E9E41B1C2
 for <lttng-dev@lists.lttng.org>; Thu,  8 Mar 2018 11:19:02 -0500 (EST)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9l
dmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKaW5kZXggNzZlYWE2OS4uOGY5YTEzMiAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTg5LDYgKzg5LDcgQEAgTFRUTkdfVFJBQ0VQT0lO
VF9FVkVOVChrdm1fYWNrX2lycSwKIAl8fCBMVFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDQsMTQs
MTMsMCwxLDAsIDQsMTUsMCwwLDAsMCkgXAogCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDksNzcs
IDQsMTAsMCkgXAogCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDQsMTEyLCA0LDUsMCkgXAorCXx8
IExUVE5HX0tFUk5FTF9SQU5HRSg0LDEsNTAsIDQsMiwwKSBcCiAJfHwgTFRUTkdfS0VSTkVMX1JB
TkdFKDMsMTYsNTIsIDMsMTcsMCkgXAogCXx8IExUVE5HX0tFUk5FTF9SQU5HRSgzLDIsOTcsIDMs
MywwKSBcCiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0LDksNjUsMCwzLDAsIDQsMTAs
MCwwLDAsMCkgXAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
