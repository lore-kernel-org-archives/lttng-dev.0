From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [RFC PATCH v2 13/13] Fix: quit early if instructed to
Date: Mon, 18 Sep 2017 18:52:06 -0400
Message-ID: <20170918225206.17725-14-jonathan.rajotte-julien__42948.5194538303$1505775308$gmane$org@efficios.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx1VL4qlfzslb
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 22:52:26 +0000 (UTC)
In-Reply-To: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
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

SWYgdGhlIHdhaXRfcXVldWUgc2l6ZSBpcyBjb25zaWRlcmFibGUsIG5vdCBjaGVja2luZyBpZiB0
aGUgdGhyZWFkIHNob3VsZApxdWl0IGRlbGF5cyB0aGUgdGVybWluYXRpb24gKDMrIHNlY29uZHMg
ZHVyaW5nIHN0cmVzcyB0ZXN0aW5nKS4KClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUg
PGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5n
LXNlc3Npb25kL21haW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5j
IGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKaW5kZXggZmI1OGFiNGIuLjA0NzVjNWEz
IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYworKysgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL21haW4uYwpAQCAtMjI0NCw3ICsyMjQ0LDcgQEAgc3RhdGljIHZvaWQg
KnRocmVhZF9kaXNwYXRjaF91c3RfcmVnaXN0cmF0aW9uKHZvaWQgKmRhdGEpCiAJCQkJcmN1X3Jl
YWRfdW5sb2NrKCk7CiAJCQkJc2Vzc2lvbl91bmxvY2tfbGlzdCgpOwogCQkJfQotCQl9IHdoaWxl
IChub2RlICE9IE5VTEwpOworCQl9IHdoaWxlIChub2RlICE9IE5VTEwgJiYgIUNNTV9MT0FEX1NI
QVJFRChkaXNwYXRjaF90aHJlYWRfZXhpdCkpOwogCiAJCWhlYWx0aF9wb2xsX2VudHJ5KCk7CiAJ
CS8qIEZ1dGV4IHdhaXQgb24gcXVldWUuIEJsb2NraW5nIGNhbGwgb24gZnV0ZXgoKSAqLwotLSAK
Mi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
