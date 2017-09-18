From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [RFC PATCH v2 03/13] Terminate dispatch thread after
	reg_apps_thread is terminated
Date: Mon, 18 Sep 2017 18:51:56 -0400
Message-ID: <20170918225206.17725-4-jonathan.rajotte-julien__45520.2202582315$1505775169$gmane$org@efficios.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx1VJ1zf2zsgP
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 22:52:23 +0000 (UTC)
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
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tYWluLmMKaW5kZXggNDVjMDI3MGUuLjBjYTcyZWM4IDEwMDY0NAotLS0gYS9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21haW4uYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21h
aW4uYwpAQCAtNDk3LDkgKzQ5Nyw2IEBAIHN0YXRpYyB2b2lkIHN0b3BfdGhyZWFkcyh2b2lkKQog
CQlFUlIoIndyaXRlIGVycm9yIG9uIHRocmVhZCBxdWl0IHBpcGUiKTsKIAl9CiAKLQkvKiBEaXNw
YXRjaCB0aHJlYWQgKi8KLQlDTU1fU1RPUkVfU0hBUkVEKGRpc3BhdGNoX3RocmVhZF9leGl0LCAx
KTsKLQlmdXRleF9udG8xX3dha2UoJnVzdF9jbWRfcXVldWUuZnV0ZXgpOwogfQogCiAvKgpAQCAt
NjMwNiw2ICs2MzAzLDEwIEBAIGV4aXRfY2xpZW50OgogCQlyZXR2YWwgPSAtMTsKIAl9CiBleGl0
X3JlZ19hcHBzOgorCS8qIEluc3RydWN0IHRoZSBkaXNwYXRjaCB0aHJlYWQgdG8gcXVpdCAqLwor
CUNNTV9TVE9SRV9TSEFSRUQoZGlzcGF0Y2hfdGhyZWFkX2V4aXQsIDEpOworCWZ1dGV4X250bzFf
d2FrZSgmdXN0X2NtZF9xdWV1ZS5mdXRleCk7CisKIAlyZXQgPSBwdGhyZWFkX2pvaW4oZGlzcGF0
Y2hfdGhyZWFkLCAmc3RhdHVzKTsKIAlpZiAocmV0KSB7CiAJCWVycm5vID0gcmV0OwotLSAKMi4x
MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
