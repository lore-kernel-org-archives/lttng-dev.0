From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: mm_page_alloc_extfrag
	instrumentation for kernel 3.16.35
Date: Thu,  5 May 2016 16:10:36 -0400
Message-ID: <1462479036-5623-1-git-send-email-mjeanson__16097.378897439$1462479068$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C5A31A063F
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:10:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8C17E340365
 for <lttng-dev@lists.lttng.org>; Thu,  5 May 2016 20:10:43 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21lbS5oIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9pbnN0cnVtZW50YXRpb24v
ZXZlbnRzL2x0dG5nLW1vZHVsZS9rbWVtLmggYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5n
LW1vZHVsZS9rbWVtLmgKaW5kZXggOWVlM2FhMi4uYWQ3YmY3NyAxMDA2NDQKLS0tIGEvaW5zdHJ1
bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva21lbS5oCisrKyBiL2luc3RydW1lbnRhdGlv
bi9ldmVudHMvbHR0bmctbW9kdWxlL2ttZW0uaApAQCAtMjA1LDYgKzIwNSw3IEBAIExUVE5HX1RS
QUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0VfTUFQKGttZW1fbW1fcGFnZSwgbW1fcGFnZV9wY3B1X2Ry
YWluLAogCiAjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTigzLDE5LDIp
CVwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywxNCwzNiwgMywxNSwwKQkJXAorCXx8IExUVE5H
X0tFUk5FTF9SQU5HRSgzLDE2LDM1LCAzLDE3LDApCQlcCiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdF
KDMsMTgsMTAsIDMsMTksMCkJCVwKIAl8fCBMVFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDMsMTYs
Nyw5LDAsMCwgMywxNywwLDAsMCwwKQlcCiAJfHwgTFRUTkdfVUJVTlRVX0tFUk5FTF9SQU5HRSgz
LDEzLDExLDUwLCAzLDE0LDAsMCkJXAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
