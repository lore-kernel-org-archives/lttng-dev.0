From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/3] Update kvm instrumentation
	for debian kernel 4.9.65-3
Date: Tue,  9 Jan 2018 15:43:20 -0500
Message-ID: <1515530601-19259-2-git-send-email-mjeanson__32783.4968259141$1515530525$gmane$org@efficios.com>
References: <1515530601-19259-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGPHc5Nfjzp51
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 20:43:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6F620340363
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 20:47:04 +0000 (UTC)
In-Reply-To: <1515530601-19259-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0
aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKaW5kZXggZWE2M2U4OC4uZDlkMDMwMCAxMDA2
NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIv
aW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTg2LDcgKzg2LDgg
QEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChrdm1fYWNrX2lycSwKIAogI2lmIChMSU5VWF9WRVJT
SU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxNSwwKSBcCiAJfHwgTFRUTkdfS0VSTkVMX1JB
TkdFKDMsMTYsNTIsIDMsMTcsMCkgXAotCXx8IExUVE5HX0tFUk5FTF9SQU5HRSgzLDIsOTcsIDMs
MywwKSkKKwl8fCBMVFROR19LRVJORUxfUkFOR0UoMywyLDk3LCAzLDMsMCkgXAorCXx8IExUVE5H
X0RFQklBTl9LRVJORUxfUkFOR0UoNCw5LDY1LDAsMywwLCA0LDEwLDAsMCwwLDApKQogCiBMVFRO
R19UUkFDRVBPSU5UX0VWRU5UKGt2bV9tbWlvLAogCVRQX1BST1RPKGludCB0eXBlLCBpbnQgbGVu
LCB1NjQgZ3BhLCB2b2lkICp2YWwpLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
