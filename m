From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [RFC PATCH v2 babeltrace] Fix: Double free when calling
	bt_context_remove_trace().
Date: Mon, 21 Jan 2013 15:58:12 +0000
Message-ID: <1358783892-30542-1-git-send-email-jeremie.galarneau__15680.0772216686$1358801972$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TxOS3-0005tg-8J
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 15:58:43 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so4068085qcp.12
	for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2013 12:58:37 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Y3RmX2Nsb3NlX3RyYWNlIHdhcyBiZWluZyBjYWxsZWQgdHdpY2Ugd2hlbiBjYWxsaW5nIGJ0X2Nv
bnRleHRfcmVtb3ZlX3RyYWNlIHRodXMKY2F1c2luZyBmcmVlKCkgdG8gYmUgY2FsbGVkIG9uIGFu
IGludmFsaWQgcG9pbnRlci4KCkNhbGxpbmcgYnRfY29udGV4dF9yZW1vdmVfdHJhY2UoKSB3b3Vs
ZCBjYWxsIGN0Zl9jbG9zZV90cmFjZSgpIG9uY2UgdmlhIHRoZQpjbG9zZV9oYW5kbGUgY2FsbGJh
Y2sgcmVnaXN0ZXJlZCBvbiB0aGUgY3RmIGZvcm1hdCBzdHJ1Y3QgYW5kIGEgc2Vjb25kIGNhbGwg
d291bGQKdGFrZSBwbGFjZSBmcm9tIGJ0X3RyYWNlX2hhbmRsZV9kZXN0cm95KCkgd2hpY2ggaXMg
cmVnaXN0ZXJlZCBhcyB0aGUKdmFsdWVfZGVzdHJveV9mdW5jIG9uIHRoZSB0cmFjZV9oYW5kbGVz
IGhhc2ggdGFibGUgb2YgdGhlIGN1cnJlbnQgY29udGV4dC4KCmJ0X3RyYWNlX2hhbmRsZV9kZXN0
cm95KCkgbm93IG9ubHkgZGVhbGxvY2F0ZXMgdGhlIHRyYWNlIGhhbmRsZSBhbmQgZG9lcyBub3QK
cGVyZm9ybSB0aGUgdHJhY2UgY2xvc2luZy4gVGhpcyBtYWtlcyB0aGUgYnRfdHJhY2VfaGFuZGxl
X2NyZWF0ZS9kZXN0cm95IGFuZApidF9jb250ZXh0X2FkZC9yZW1vdmVfdHJhY2UgcGFydHMgb2Yg
dGhlIHB1YmxpYyBBUEkgc3ltbWV0cmljLgoKVGhlIGNyYXNoIGlzIHJlcHJvZHVjaWJsZSBieSBp
bnZva2luZyB0aGUgdGVzdHMtcHl0aG9uLnB5IHNjcmlwdC4KClNpZ25lZC1vZmYtYnk6IErDqXLD
qW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBsaWIv
dHJhY2UtaGFuZGxlLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvbGliL3RyYWNlLWhhbmRsZS5jIGIvbGliL3RyYWNlLWhhbmRsZS5jCmluZGV4IDBk
YTU2NWIuLjQ1NWU0NDAgMTAwNjQ0Ci0tLSBhL2xpYi90cmFjZS1oYW5kbGUuYworKysgYi9saWIv
dHJhY2UtaGFuZGxlLmMKQEAgLTQ5LDcgKzQ5LDYgQEAgc3RydWN0IGJ0X3RyYWNlX2hhbmRsZSAq
YnRfdHJhY2VfaGFuZGxlX2NyZWF0ZShzdHJ1Y3QgYnRfY29udGV4dCAqY3R4KQogCiB2b2lkIGJ0
X3RyYWNlX2hhbmRsZV9kZXN0cm95KHN0cnVjdCBidF90cmFjZV9oYW5kbGUgKnRoKQogewotCXRo
LT5mb3JtYXQtPmNsb3NlX3RyYWNlKHRoLT50ZCk7CiAJZ19mcmVlKHRoKTsKIH0KIAotLSAKMS44
LjEuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
