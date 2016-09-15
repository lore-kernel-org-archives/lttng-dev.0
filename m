From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 3/3] Port: Add glib g_mkdtemp to
	mkdtemp wrapper
Date: Thu, 15 Sep 2016 12:14:43 -0400
Message-ID: <1473956083-25901-3-git-send-email-mjeanson__3392.99830743602$1473956191$gmane$org@efficios.com>
References: <1473956083-25901-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DA3B7A42F1
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 16:17:04 +0000 (UTC)
In-Reply-To: <1473956083-25901-1-git-send-email-mjeanson@efficios.com>
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
LQogaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC9zdGRsaWIuaCB8IDIwICsrKysrKysrKysrKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvc3RkbGliLmggYi9pbmNsdWRl
L2JhYmVsdHJhY2UvY29tcGF0L3N0ZGxpYi5oCmluZGV4IDU3Zjk0MmQuLmJlMDUxOGYgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvYmFiZWx0cmFjZS9jb21wYXQvc3RkbGliLmgKKysrIGIvaW5jbHVkZS9i
YWJlbHRyYWNlL2NvbXBhdC9zdGRsaWIuaApAQCAtMjUsMTYgKzI1LDM0IEBACiAgKiBTT0ZUV0FS
RS4KICAqLwogCisvKgorICogVGhpcyBjb21wYXQgd3JhcHBlciBjYW4gYmUgcmVtb3ZlZCBhbmQg
cmVwbGFjZWQgYnkgZ19ta2R0ZW1wKCkgd2hlbiB3ZSBidW1wCisgKiB0aGUgcmVxdWlyZW1lbnQg
b24gZ2xpYiB0byB2ZXJzaW9uIDIuMzAuCisgKi8KKwogI2luY2x1ZGUgPHN0ZGxpYi5oPgogI2lu
Y2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8Z2xpYi5oPgogCiAjaWZkZWYgSEFWRV9NS0RU
RU1QCisKIHN0YXRpYyBpbmxpbmUKIGNoYXIgKmJ0X21rZHRlbXAoY2hhciAqdGVtcGxhdGUpCiB7
CiAJcmV0dXJuIG1rZHRlbXAodGVtcGxhdGUpOwogfQorCisjZWxpZiBHTElCX0NIRUNLX1ZFUlNJ
T04oMiwzMCwwKQorCisjaW5jbHVkZSA8Z2xpYi9nc3RkaW8uaD4KK3N0YXRpYyBpbmxpbmUKK2No
YXIgKmJ0X21rZHRlbXAoY2hhciAqdGVtcGxhdGUpCit7CisJcmV0dXJuIGdfbWtkdGVtcCh0ZW1w
bGF0ZSk7Cit9CisKICNlbHNlCisKIHN0YXRpYyBpbmxpbmUKIGNoYXIgKmJ0X21rZHRlbXAoY2hh
ciAqdGVtcGxhdGUpCiB7CkBAIC01NCw3ICs3Miw3IEBAIGNoYXIgKmJ0X21rZHRlbXAoY2hhciAq
dGVtcGxhdGUpCiBlbmQ6CiAJcmV0dXJuIHJldDsKIH0KLSNlbmRpZgogCisjZW5kaWYKIAogI2Vu
ZGlmIC8qIF9CQUJFTFRSQUNFX0NPTVBBVF9TVERMSUJfSCAqLwotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
