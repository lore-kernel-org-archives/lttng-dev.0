From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust v2 2/2] Use ust_lock during sock_info
	operations for atomicity against fork
Date: Mon,  5 Feb 2018 17:58:19 -0500
Message-ID: <1517871499-15532-2-git-send-email-jonathan.rajotte-julien__43876.9348817461$1517871405$gmane$org@efficios.com>
References: <1517871499-15532-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zb30f71JvzpFx
 for <lttng-dev@lists.lttng.org>; Mon,  5 Feb 2018 22:58:26 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7BB35340225
 for <lttng-dev@lists.lttng.org>; Mon,  5 Feb 2018 22:59:11 +0000 (UTC)
In-Reply-To: <1517871499-15532-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KdjI6IFBlcnRpbmVudCBsb2NraW5nLi4uCgpTaG91bGQgdGhlIGxv
Y2tpbmcgYmUgbW9yZSBmaW5lLWdyYWluZWQgYW5kIGFwcGxpZWQgYXJvdW5kCnVzdGNvbW1fY2xv
c2VfdW5peF9zb2NrIGFuZCBzb2NrX2luZm8gb24gYm90aCBjb2RlIHBhdGggb25seT8KCi0tLQog
bGlibHR0bmctdXN0L2x0dG5nLXVzdC1jb21tLmMgfCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlibHR0bmct
dXN0L2x0dG5nLXVzdC1jb21tLmMgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwppbmRl
eCAzMmJhM2MxLi4wY2Y1ZWNkIDEwMDY0NAotLS0gYS9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNv
bW0uYworKysgYi9saWJsdHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYwpAQCAtMTM5Niw2ICsxMzk2
LDEwIEBAIHJlc3RhcnQ6CiAJCXByZXZfY29ubmVjdF9mYWlsZWQgPSAwOwogCX0KIAorCWlmICh1
c3RfbG9jaygpKSB7CisJCWdvdG8gcXVpdDsKKwl9CisKIAlpZiAoc29ja19pbmZvLT5zb2NrZXQg
IT0gLTEpIHsKIAkJLyogRkQgdHJhY2tlciBpcyB1cGRhdGVkIGJ5IHVzdGNvbW1fY2xvc2VfdW5p
eF9zb2NrKCkgKi8KIAkJcmV0ID0gdXN0Y29tbV9jbG9zZV91bml4X3NvY2soc29ja19pbmZvLT5z
b2NrZXQpOwpAQCAtMTQxNSw5ICsxNDE5LDYgQEAgcmVzdGFydDoKIAkJc29ja19pbmZvLT5ub3Rp
Znlfc29ja2V0ID0gLTE7CiAJfQogCi0JaWYgKHVzdF9sb2NrKCkpIHsKLQkJZ290byBxdWl0Owot
CX0KIAogCS8qCiAJICogUmVnaXN0ZXIuIFdlIG5lZWQgdG8gcGVyZm9ybSBib3RoIGNvbm5lY3Qg
YW5kIHNlbmRpbmcKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
