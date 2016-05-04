From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: Static build on OS X
Date: Wed,  4 May 2016 10:54:55 -0400
Message-ID: <1462373695-15432-1-git-send-email-mjeanson__7311.21803769401$1462373727$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D9187A0CBA
 for <lttng-dev@lists.lttng.org>; Wed,  4 May 2016 14:55:03 +0000 (UTC)
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

VGhlIE9TIFggbGlua2VyIGZhaWxzIHRvIHJlc29sdmUgY29tbW9uIHN5bWJvbHMgaW4gYSBzdGF0
aWMKbGlicmFyeSBmb3Igc29tZSB1bmV4cGxhaW5lZCByZWFzb24uIEluaXRpYWxpemluZyB0aGUg
dmFyaWFibGVzCnRvIHplcm8gbWFrZXMgdGhlIHN5bWJvbCBiZWNvbWUgdW5pbml0aWFsaXplZCBk
YXRhIGFuZCBmaXhlcwp0aGUgbGlua2luZy4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNv
biA8bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIGxpYi9iYWJlbHRyYWNlLmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9saWIvYmFiZWx0cmFjZS5jIGIvbGliL2JhYmVsdHJhY2UuYwppbmRleCAwYmNmZDFkLi5mMDU4
MDhkIDEwMDY0NAotLS0gYS9saWIvYmFiZWx0cmFjZS5jCisrKyBiL2xpYi9iYWJlbHRyYWNlLmMK
QEAgLTMxLDcgKzMxLDcgQEAKICNpbmNsdWRlIDxiYWJlbHRyYWNlL2N0Zi10ZXh0L3R5cGVzLmg+
CiAjaW5jbHVkZSA8c3RkbGliLmg+CiAKLWludCBiYWJlbHRyYWNlX3ZlcmJvc2UsIGJhYmVsdHJh
Y2VfZGVidWc7CitpbnQgYmFiZWx0cmFjZV92ZXJib3NlID0gMCwgYmFiZWx0cmFjZV9kZWJ1ZyA9
IDA7CiAKIHN0YXRpYwogdm9pZCBfX2F0dHJpYnV0ZV9fKChjb25zdHJ1Y3RvcikpIGluaXRfYmFi
ZWx0cmFjZV9saWIodm9pZCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
