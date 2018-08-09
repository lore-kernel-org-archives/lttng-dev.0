From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/2] Fix: Allow alphanumeric
	characters in SLE version
Date: Thu,  9 Aug 2018 11:55:31 -0400
Message-ID: <20180809155532.7015-1-mjeanson__7461.48417606509$1533830045$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41mXss0PK3z14Yg
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 11:56:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E284123A6BC
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 11:55:53 -0400 (EDT)
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

QWxsb3cgYWxwaGFudW1lcmljIGNoYXJhY3RlcnMgaW4gdGhlIGxvbmcgdmVyc2lvbiBzdHJpbmcg
YmVmb3JlCmV4dHJhY3Rpbmcgc3BlY2lmaWMgdmVyc2lvbiBudW1iZXJzLiBUaGlzIHByZXZlbnRz
IGZhaWx1cmUgaW4gZGV0ZWN0aW5nCmEgU3VTRSBrZXJuZWwgd2hlbiB0aGUgdmVyc2lvbiBzdHJp
bmcgd2FzIGN1c3RvbWl6ZWQgYnkgdGhlIGVuZCB1c2VyLgoKU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogc2NyaXB0cy9hYmktc2xlLXZl
cnNpb24uc2ggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2FiaS1zbGUtdmVyc2lvbi5zaCBiL3NjcmlwdHMv
YWJpLXNsZS12ZXJzaW9uLnNoCmluZGV4IGJkNmQ1ZjEuLmFhZmVkN2MgMTAwNzU1Ci0tLSBhL3Nj
cmlwdHMvYWJpLXNsZS12ZXJzaW9uLnNoCisrKyBiL3NjcmlwdHMvYWJpLXNsZS12ZXJzaW9uLnNo
CkBAIC0yMyw3ICsyMyw3IEBAIGlmIFsgISAtZiAiJHtLUEFUSH0vaW5jbHVkZS9nZW5lcmF0ZWQv
dXRzcmVsZWFzZS5oIiBdOyB0aGVuCiAJZXhpdCAwCiBmaQogCi1TTEVfUkVMRUFTRT0iJChzZWQg
LXJuICdzL14jZGVmaW5lIFVUU19SRUxFQVNFICIoLiopLShbMC05XC5dKyktKC4qKSIvXDIvcCcg
IiR7S1BBVEh9L2luY2x1ZGUvZ2VuZXJhdGVkL3V0c3JlbGVhc2UuaCIpIgorU0xFX1JFTEVBU0U9
IiQoc2VkIC1ybiAncy9eI2RlZmluZSBVVFNfUkVMRUFTRSAiKC4qKS0oWzAtOWEtekEtWlwuXSsp
LSguKikiL1wyL3AnICIke0tQQVRIfS9pbmNsdWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgiKSIK
IAogU0xFX1JFTEVBU0VfTUFKT1I9IiQoZWNobyAiJHtTTEVfUkVMRUFTRX0iIHwgc2VkIC1ybiAn
cy9eKFswLTldKykoLiopJC9cMS9wJykiCiBTTEVfUkVMRUFTRV9NSU5PUj0iJChlY2hvICIke1NM
RV9SRUxFQVNFfSIgfCBzZWQgLXJuICdzL14oWzAtOV0rKVwuKFswLTldKykoLiopJC9cMi9wJyki
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
