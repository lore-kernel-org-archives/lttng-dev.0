From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/2] Fix: SCSI instrumentation for
	SLES12 SP2
Date: Tue,  6 Dec 2016 18:05:33 -0500
Message-ID: <1481065533-25966-2-git-send-email-mjeanson__6002.69444189525$1481065562$gmane$org@efficios.com>
References: <1481065533-25966-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYHN02nm1zdX1
 for <lttng-dev@lists.lttng.org>; Tue,  6 Dec 2016 23:07:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 81C363402B8
 for <lttng-dev@lists.lttng.org>; Tue,  6 Dec 2016 23:07:27 +0000 (UTC)
In-Reply-To: <1481065533-25966-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NzaS5oIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY3NpLmggYi9pbnN0cnVtZW50
YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY3NpLmgKaW5kZXggMDJlMzM1My4uN2M2ZWNmMSAx
MDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NzaS5oCisr
KyBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3Njc2kuaApAQCAtMTUsNyAr
MTUsOCBAQAogCiAjZGVmaW5lIHNjc2lfb3Bjb2RlX25hbWUob3Bjb2RlKQl7IG9wY29kZSwgI29w
Y29kZSB9CiAKLSNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsNyww
KSkKKyNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsNywwKSBcCisJ
fHwgTFRUTkdfU0xFX0tFUk5FTF9SQU5HRSg0LDQsOSwzNiwwLDAgLDQsNSwwLDAsMCwwKSkKIAog
I2RlZmluZSBzaG93X29wY29kZV9uYW1lKHZhbCkJCQkJCVwKIAlfX3ByaW50X3N5bWJvbGljKHZh
bCwJCQkJCVwKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
