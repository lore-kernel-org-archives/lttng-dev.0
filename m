From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Fix: include config.h to resolve
	HAVE_DLMOPEN
Date: Tue, 21 Feb 2017 18:10:11 -0500
Message-ID: <1487718611-28222-1-git-send-email-jonathan.rajotte-julien__6666.58811173892$1487718648$gmane$org@efficios.com>
References: <842296836.195814.1487712447723.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vSbpK6KLCzjrM
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 23:11:05 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 16029340305
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 23:14:04 +0000 (UTC)
In-Reply-To: <842296836.195814.1487712447723.JavaMail.zimbra@efficios.com>
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

Rml4ZXMgY29tbWl0IDQyMzMwYWRjZWZjZDE4MzBkYWQ4OWUyYTk2MGM5M2Q4ZGQxZGExMjUKClNp
Z25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVm
ZmljaW9zLmNvbT4KLS0tCiBsaWJsdHRuZy11c3QtZGwvdXN0X2RsLmggfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC1kbC91c3Rf
ZGwuaCBiL2xpYmx0dG5nLXVzdC1kbC91c3RfZGwuaAppbmRleCBhZmE4ZTg0Li5jOGEwNjk1IDEw
MDY0NAotLS0gYS9saWJsdHRuZy11c3QtZGwvdXN0X2RsLmgKKysrIGIvbGlibHR0bmctdXN0LWRs
L3VzdF9kbC5oCkBAIC0zMyw2ICszMyw3IEBAIGV4dGVybiAiQyIgewogCiAjaW5jbHVkZSA8c3Rk
aW50Lmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8Y29uZmlnLmg+CiAKICNkZWZp
bmUgTFRUTkdfVVNUX0RMX1BST1ZJREVSCiAjaW5jbHVkZSA8bHR0bmcvdHJhY2Vwb2ludC5oPgot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
