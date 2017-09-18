From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: use the in-tree tap-driver.sh
Date: Mon, 18 Sep 2017 17:06:59 -0400
Message-ID: <1505768819-20248-1-git-send-email-mjeanson__46815.7910196625$1505768843$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xwz901LqhzDLd
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:07:15 +0000 (UTC)
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
LQogdGVzdHMvTWFrZWZpbGUuYW0gfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL01ha2VmaWxlLmFtIGIvdGVzdHMvTWFrZWZpbGUuYW0K
aW5kZXggYzVkNjFiYS4uZjljMjA3ZiAxMDA2NDQKLS0tIGEvdGVzdHMvTWFrZWZpbGUuYW0KKysr
IGIvdGVzdHMvTWFrZWZpbGUuYW0KQEAgLTEsNSArMSw4IEBACiBTVUJESVJTID0gdXRpbHMgY2xp
IGxpYiBiaW5kaW5ncyBwbHVnaW5zCiAKK0xPR19EUklWRVJfRkxBR1M9Jy0tbWVyZ2UnCitMT0df
RFJJVkVSID0gZW52IEFNX1RBUF9BV0s9JyQoQVdLKScgJChTSEVMTCkgJCh0b3Bfc3JjZGlyKS9j
b25maWcvdGFwLWRyaXZlci5zaAorCiBFWFRSQV9ESVNUID0gJChzcmNkaXIpL2N0Zi10cmFjZXMv
KiogXAogCSAgICAgJChzcmNkaXIpL2RlYnVnLWluZm8tZGF0YS8qKiBcCiAJICAgICAkKHNyY2Rp
cikvZGVidWctaW5mby1kYXRhLy5idWlsZC1pZC9jZC8qKgotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
