From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace 3/3] Fix: Removed Python bindings to
	static constructor and destructor.
Date: Fri, 18 Jan 2013 16:45:34 +0000
Message-ID: <1358527534-16401-3-git-send-email-jeremie.galarneau__27097.4218765788$1358545646$gmane$org@efficios.com>
References: <1358527534-16401-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TwJlv-0006IE-LN
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 16:46:47 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so2687183qco.7
	for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2013 13:46:42 -0800 (PST)
In-Reply-To: <1358527534-16401-1-git-send-email-jeremie.galarneau@efficios.com>
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

UmVzb2x2ZXMgYW4gdW5kZWZpbmVkIHN5bWJvbCBvbiBQeXRob24gbW9kdWxlIGxvYWQuCgpTaWdu
ZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lv
cy5jb20+Ci0tLQogYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbiB8IDMgLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9iaW5kaW5ncy9weXRob24v
YmFiZWx0cmFjZS5pLmluIGIvYmluZGluZ3MvcHl0aG9uL2JhYmVsdHJhY2UuaS5pbgppbmRleCBk
NDVhZmIwLi5kZDQ5YmE1IDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24vYmFiZWx0cmFjZS5p
LmluCisrKyBiL2JpbmRpbmdzL3B5dGhvbi9iYWJlbHRyYWNlLmkuaW4KQEAgLTE5NCw5ICsxOTQs
NiBAQCBleHRlcm4gc3RydWN0IGZvcm1hdCAqYnRfbG9va3VwX2Zvcm1hdChidF9pbnRlcm5fc3Ry
IHFuYW1lKTsKIGV4dGVybiB2b2lkIGJ0X2ZwcmludGZfZm9ybWF0X2xpc3QoRklMRSAqZnApOwog
ZXh0ZXJuIGludCBidF9yZWdpc3Rlcl9mb3JtYXQoc3RydWN0IGZvcm1hdCAqZm9ybWF0KTsKIAot
dm9pZCBmb3JtYXRfaW5pdCh2b2lkKTsKLXZvaWQgZm9ybWF0X2ZpbmFsaXplKHZvaWQpOwotCiAl
cHl0aG9uY29kZSAlewogCiBkZWYgcHJpbnRfZm9ybWF0X2xpc3QoYmFiZWx0cmFjZV9maWxlKToK
LS0gCjEuOC4xLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
