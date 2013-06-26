From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Remove unnused function
	bt_trace_handle_get_id
Date: Wed, 26 Jun 2013 13:27:37 -0400
Message-ID: <1372267657-1956-1-git-send-email-jeremie.galarneau__34649.3755736903$1372267733$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UrtVy-0006Ww-SG
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 13:28:19 -0400
Received: by mail-qe0-f41.google.com with SMTP id b4so1061328qen.28
	for <lttng-dev@lists.lttng.org>; Wed, 26 Jun 2013 10:28:13 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: mathieu.desnoyers@efficios.com, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

VGhpcyBmdW5jdGlvbiB3YXMgcmVtb3ZlZCBmcm9tIHRyYWNlLWhhbmRsZS5oIGFzIHBhcnQgb2Yg
Y29tbWl0CmUzZDEyY2Y5M2YwNjc2MDFkZjQxNzllZjRiN2UyYTMwYWEwMDY1Zjcgd2hpY2ggY2hh
bmdlZCB0aGUgdHJhY2UtaGFuZGxlIEFQSSB0bwp1c2UgaGFuZGxlX2lkcyBpbnN0ZWFkIG9mIHBv
aW50ZXJzIHRvIGEgc3RydWN0IGJ0X3RyYWNlX2hhbmRsZS4KClNpZ25lZC1vZmYtYnk6IErDqXLD
qW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBsaWIv
dHJhY2UtaGFuZGxlLmMgfCA4IC0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9saWIvdHJhY2UtaGFuZGxlLmMgYi9saWIvdHJhY2UtaGFuZGxlLmMK
aW5kZXggNDU1ZTQ0MC4uZDViOTA2YSAxMDA2NDQKLS0tIGEvbGliL3RyYWNlLWhhbmRsZS5jCisr
KyBiL2xpYi90cmFjZS1oYW5kbGUuYwpAQCAtNTIsMTQgKzUyLDYgQEAgdm9pZCBidF90cmFjZV9o
YW5kbGVfZGVzdHJveShzdHJ1Y3QgYnRfdHJhY2VfaGFuZGxlICp0aCkKIAlnX2ZyZWUodGgpOwog
fQogCi1pbnQgYnRfdHJhY2VfaGFuZGxlX2dldF9pZChzdHJ1Y3QgYnRfdHJhY2VfaGFuZGxlICp0
aCkKLXsKLQlpZiAoIXRoKQotCQlyZXR1cm4gLTE7Ci0KLQlyZXR1cm4gdGgtPmlkOwotfQotCiBj
b25zdCBjaGFyICpidF90cmFjZV9oYW5kbGVfZ2V0X3BhdGgoc3RydWN0IGJ0X2NvbnRleHQgKmN0
eCwgaW50IGhhbmRsZV9pZCkKIHsKIAlzdHJ1Y3QgYnRfdHJhY2VfaGFuZGxlICpoYW5kbGU7Ci0t
IAoxLjguMy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
