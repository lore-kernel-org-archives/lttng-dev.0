From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: Skip uid registry when
	metadata key is 0
Date: Mon, 10 Sep 2018 20:09:13 -0400
Message-ID: <20180911000915.29177-3-jonathan.rajotte-julien__30195.3310067349$1536624506$gmane$org@efficios.com>
References: <20180911000915.29177-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 428QJr6P1bzYh
 for <lttng-dev@lists.lttng.org>; Mon, 10 Sep 2018 20:09:48 -0400 (EDT)
In-Reply-To: <20180911000915.29177-1-jonathan.rajotte-julien@efficios.com>
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

QSB2YWx1ZSBvZiB6ZXJvIGZvciB0aGUgbWV0YWRhdGEga2V5IGluZGljYXRlIHRoYXQgbWV0YWRh
dGEgd2FzIG5ldmVyCmNyZWF0ZWQvcHVzaGVkIHRvIHRoZSBjb25zdW1lci4KClRoaXMgY2FuIG9j
Y3VyIGluIHNjZW5hcmlvIHdlcmUgYSB0cmFja2VyIGlzIHByZXNlbnQgc2luY2UgbWV0YWRhdGEK
bWlnaHQgbmV2ZXIgYmUgY3JlYXRlZC9wdXNoZWQuCgpTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBS
YWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC91c3QtYXBwLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtYXBw
LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwppbmRleCA1Y2Y5MDQ5MzkuLjUy
ZDFkYTc4NyAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtYXBwLmMKKysr
IGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtYXBwLmMKQEAgLTU5NzUsNiArNTk3NSwxMSBA
QCBpbnQgdXN0X2FwcF9zbmFwc2hvdF9yZWNvcmQoc3RydWN0IGx0dF91c3Rfc2Vzc2lvbiAqdXNl
c3MsCiAJCQlzdHJ1Y3QgYnVmZmVyX3JlZ19jaGFubmVsICpyZWdfY2hhbjsKIAkJCXN0cnVjdCBj
b25zdW1lcl9zb2NrZXQgKnNvY2tldDsKIAorCQkJaWYgKCFyZWctPnJlZ2lzdHJ5LT5yZWcudXN0
LT5tZXRhZGF0YV9rZXkpIHsKKwkJCQkvKiBTa2lwIHNpbmNlIG5vIG1ldGFkYXRhIGlzIHByZXNl
bnQgKi8KKwkJCQljb250aW51ZTsKKwkJCX0KKwogCQkJLyogR2V0IGNvbnN1bWVyIHNvY2tldCB0
byB1c2UgdG8gcHVzaCB0aGUgbWV0YWRhdGEuKi8KIAkJCXNvY2tldCA9IGNvbnN1bWVyX2ZpbmRf
c29ja2V0X2J5X2JpdG5lc3MocmVnLT5iaXRzX3Blcl9sb25nLAogCQkJCQl1c2Vzcy0+Y29uc3Vt
ZXIpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
