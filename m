From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/2] Fix: update block
	instrumentation for SuSE 4.4.114-92
Date: Tue, 13 Feb 2018 15:23:50 -0500
Message-ID: <1518553431-14012-1-git-send-email-mjeanson__5197.180590085$1518553334$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zgvBp4S2Gzv4M
 for <lttng-dev@lists.lttng.org>; Tue, 13 Feb 2018 20:24:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 14D3F3402E5
 for <lttng-dev@lists.lttng.org>; Tue, 13 Feb 2018 20:25:00 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2suaCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2Jsb2NrLmggYi9pbnN0cnVtZW50
YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9ibG9jay5oCmluZGV4IDU2MjA4N2IuLjkxMDIxN2Ig
MTAwNjQ0Ci0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2Jsb2NrLmgK
KysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2suaApAQCAtMzQs
NyArMzQsNyBAQCBlbnVtIHsKICNlbmRpZiAvKiBfVFJBQ0VfQkxPQ0tfREVGXyAqLwogCiAjaWYg
KExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDgsMCkgfHwgXAotCUxUVE5H
X1NMRV9LRVJORUxfUkFOR0UoNCw0LDczLDUsMCwwLCA0LDUsMCwwLDAsMCkpCisJTFRUTkdfU0xF
X0tFUk5FTF9SQU5HRSg0LDQsNzMsNSwwLDAsIDQsNCwxMTQsOTIsMCwwKSkKIAogI2RlZmluZSBs
dHRuZ19yZXFfb3AocnEpCXJlcV9vcChycSkKICNkZWZpbmUgbHR0bmdfcmVxX3J3KHJxKQkoKHJx
KS0+Y21kX2ZsYWdzKQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
