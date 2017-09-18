From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [RFC PATCH v2 08/13] Fix: perform lookup then test for
	condition
Date: Mon, 18 Sep 2017 18:52:01 -0400
Message-ID: <20170918225206.17725-9-jonathan.rajotte-julien__46119.4026670002$1505775224$gmane$org@efficios.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx1VJ5sGyzsh7
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 22:52:24 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIHwgNyArKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tYWluLmMKaW5kZXggMzU5NmQ3ZTMuLjhjZmZhNmY2IDEwMDY0NAotLS0gYS9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21haW4uYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21h
aW4uYwpAQCAtMTg5OSw4ICsxODk5LDExIEBAIHN0YXRpYyB2b2lkIHNhbml0aXplX3dhaXRfcXVl
dWUoc3RydWN0IHVzdF9yZWdfd2FpdF9xdWV1ZSAqd2FpdF9xdWV1ZSkKIAogCQljZHNfbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZlKHdhaXRfbm9kZSwgdG1wX3dhaXRfbm9kZSwKIAkJCQkmd2FpdF9x
dWV1ZS0+aGVhZCwgaGVhZCkgewotCQkJaWYgKHBvbGxmZCA9PSB3YWl0X25vZGUtPmFwcC0+c29j
ayAmJgotCQkJCQkocmV2ZW50cyAmIChMUE9MTEhVUCB8IExQT0xMRVJSKSkpIHsKKwkJCWlmIChw
b2xsZmQgIT0gd2FpdF9ub2RlLT5hcHAtPnNvY2spIHsKKwkJCQljb250aW51ZTsKKwkJCX0KKwor
CQkJaWYgKHJldmVudHMgJiAoTFBPTExIVVAgfCBMUE9MTEVSUikpIHsKIAkJCQljZHNfbGlzdF9k
ZWwoJndhaXRfbm9kZS0+aGVhZCk7CiAJCQkJd2FpdF9xdWV1ZS0+Y291bnQtLTsKIAkJCQl1c3Rf
YXBwX2Rlc3Ryb3kod2FpdF9ub2RlLT5hcHApOwotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
