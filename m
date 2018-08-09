From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules stable-2.x 1/2] Fix: Allow
	alphanumeric characters in SLE version
Date: Thu,  9 Aug 2018 11:56:55 -0400
Message-ID: <20180809155656.7287-1-mjeanson__9193.98980117894$1533830104$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41mXv06VHNz14Zg
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 11:57:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A3C8C23A770
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 11:57:00 -0400 (EDT)
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
bCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogYWJpLXNsZS12ZXJzaW9uLnNo
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvYWJpLXNsZS12ZXJzaW9uLnNoIGIvYWJpLXNsZS12ZXJzaW9uLnNoCmluZGV4
IDBiZDY1YjEuLjU5ZTdkNjcgMTAwNzU1Ci0tLSBhL2FiaS1zbGUtdmVyc2lvbi5zaAorKysgYi9h
Ymktc2xlLXZlcnNpb24uc2gKQEAgLTIyLDcgKzIyLDcgQEAgaWYgWyAhIC1mICIke0tQQVRIfS9p
bmNsdWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgiIF07IHRoZW4KIAlleGl0IDAKIGZpCiAKLVNM
RV9SRUxFQVNFPSIkKHNlZCAtcm4gJ3MvXiNkZWZpbmUgVVRTX1JFTEVBU0UgIiguKiktKFswLTlc
Ll0rKS0oLiopIi9cMi9wJyAiJHtLUEFUSH0vaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVsZWFzZS5o
IikiCitTTEVfUkVMRUFTRT0iJChzZWQgLXJuICdzL14jZGVmaW5lIFVUU19SRUxFQVNFICIoLiop
LShbMC05YS16QS1aXC5dKyktKC4qKSIvXDIvcCcgIiR7S1BBVEh9L2luY2x1ZGUvZ2VuZXJhdGVk
L3V0c3JlbGVhc2UuaCIpIgogCiBTTEVfUkVMRUFTRV9NQUpPUj0iJChlY2hvICIke1NMRV9SRUxF
QVNFfSIgfCBzZWQgLXJuICdzL14oWzAtOV0rKSguKikkL1wxL3AnKSIKIFNMRV9SRUxFQVNFX01J
Tk9SPSIkKGVjaG8gIiR7U0xFX1JFTEVBU0V9IiB8IHNlZCAtcm4gJ3MvXihbMC05XSspXC4oWzAt
OV0rKSguKikkL1wyL3AnKSIKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
