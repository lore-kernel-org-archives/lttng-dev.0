From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Add support for 4.9.27-rt18
	kernel
Date: Wed, 24 May 2017 11:19:50 -0400
Message-ID: <1495639190-29926-1-git-send-email-mjeanson__41785.0726786584$1495639213$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXx1K0qsXz10d1
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 15:20:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5683A340380
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 15:20:47 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaCB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaCBiL2luc3RydW1l
bnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3NjaGVkLmgKaW5kZXggYzY4ZGQyNy4uZTZmMzZi
MSAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQu
aAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5oCkBAIC01
NDAsNyArNTQwLDggQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChzY2hlZF9zdGF0X3J1bnRpbWUs
CiApCiAjZW5kaWYKIAotI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04o
NCwxMiwwKSkKKyNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTIs
MCkgfHwgXAorCUxUVE5HX1JUX0tFUk5FTF9SQU5HRSg0LDksMjcsMTgsIDQsMTAsMCwwKSkKIC8q
CiAgKiBUcmFjZXBvaW50IGZvciBzaG93aW5nIHByaW9yaXR5IGluaGVyaXRhbmNlIG1vZGlmeWlu
ZyBhIHRhc2tzCiAgKiBwcmlvcml0eS4KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
