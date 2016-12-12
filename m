From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: free previous instance of url
	(alloc_url) on default live url assignation
Date: Mon, 12 Dec 2016 16:16:18 -0500
Message-ID: <1481577378-1776-1-git-send-email-jonathan.rajotte-julien__46372.8759241805$1481577422$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tcwgc0lJSztk4
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 21:18:51 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgfCA2ICsr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9i
aW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0
ZS5jCmluZGV4IDBmN2QxYTQuLmU2ZjE1YzcgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmcvY29t
bWFuZHMvY3JlYXRlLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYwpAQCAt
MzQyLDYgKzM0MiwxMiBAQCBzdGF0aWMgaW50IGNyZWF0ZV9zZXNzaW9uKHZvaWQpCiAKIAkvKiBV
c2UgZGVmYXVsdCBsaXZlIFVSTCBpZiBOTyB1cmwgaXMvYXJlIGZvdW5kLiAqLwogCWlmICgob3B0
X2xpdmVfdGltZXIgJiYgIW9wdF91cmwpICYmIChvcHRfbGl2ZV90aW1lciAmJiAhb3B0X2RhdGFf
dXJsKSkgeworCQkvKiBPdmVycmlkZSB0aGUgdXJsICovCisJCWlmICh1cmwpIHsKKwkJCWZyZWUo
dXJsKTsKKwkJCXVybCA9IE5VTEw7CisJCX0KKwogCQlyZXQgPSBhc3ByaW50ZigmYWxsb2NfdXJs
LCAibmV0Oi8vMTI3LjAuMC4xIik7CiAJCWlmIChyZXQgPCAwKSB7CiAJCQlQRVJST1IoImFzcHJp
bnRmIGRlZmF1bHQgbGl2ZSBVUkwiKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
