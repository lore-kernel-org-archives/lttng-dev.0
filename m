From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Use the packet's final size
	when mmap-ing the next packet
Date: Tue, 15 Oct 2013 13:23:18 -0400
Message-ID: <1381857798-6859-1-git-send-email-jeremie.galarneau__28988.4079284549$1381857868$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VW8LA-0001jL-1p
	for lttng-dev@lists.lttng.org; Tue, 15 Oct 2013 13:23:33 -0400
Received: by mail-qc0-f173.google.com with SMTP id l13so4877830qcy.18
	for <lttng-dev@lists.lttng.org>; Tue, 15 Oct 2013 10:23:22 -0700 (PDT)
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

Y3RmX3BhY2tldF9zZWVrKCkgYXNzdW1lZCB0aGF0IGEgcGFja2V0IHdvdWxkIGJlIG9mIGZpeGVk
IHNpemUKIldSSVRFX1BBQ0tFVF9MRU4iIHdoZW4gc2Vla2luZyB0byB0aGUgbmV4dCBwYWNrZXQg
aW4gd3JpdGUgbW9kZS4KVGhpcyBlbnN1cmVzIHRoYXQgdGhlIHJlYWwgc2l6ZSB1c2VkLgoKU2ln
bmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNp
b3MuY29tPgpSZXZpZXdlZC1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KLS0tCiBmb3JtYXRzL2N0Zi9jdGYuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Zvcm1hdHMv
Y3RmL2N0Zi5jIGIvZm9ybWF0cy9jdGYvY3RmLmMKaW5kZXggOTQ3YjQzOS4uNjBkOWM5ZiAxMDA2
NDQKLS0tIGEvZm9ybWF0cy9jdGYvY3RmLmMKKysrIGIvZm9ybWF0cy9jdGYvY3RmLmMKQEAgLTcx
Miw3ICs3MTIsNyBAQCB2b2lkIGN0Zl9wYWNrZXRfc2VlayhzdHJ1Y3QgYnRfc3RyZWFtX3BvcyAq
c3RyZWFtX3Bvcywgc2l6ZV90IGluZGV4LCBpbnQgd2hlbmNlKQogCQlzd2l0Y2ggKHdoZW5jZSkg
ewogCQljYXNlIFNFRUtfQ1VSOgogCQkJLyogVGhlIHdyaXRlciB3aWxsIGFkZCBwYWRkaW5nICov
Ci0JCQlwb3MtPm1tYXBfb2Zmc2V0ICs9IFdSSVRFX1BBQ0tFVF9MRU4gLyBDSEFSX0JJVDsKKwkJ
CXBvcy0+bW1hcF9vZmZzZXQgKz0gcG9zLT5wYWNrZXRfc2l6ZSAvIENIQVJfQklUOwogCQkJYnJl
YWs7CiAJCWNhc2UgU0VFS19TRVQ6CiAJCQlhc3NlcnQoaW5kZXggPT0gMCk7CS8qIG9ubHkgc2Vl
ayBzdXBwb3J0ZWQgZm9yIG5vdyAqLwotLSAKMS44LjQKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
