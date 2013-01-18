From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace 2/3] Fix: Python 3 binding
	compatibility and clean intermediate files.
Date: Fri, 18 Jan 2013 16:45:33 +0000
Message-ID: <1358527534-16401-2-git-send-email-jeremie.galarneau__42451.9009342932$1358545625$gmane$org@efficios.com>
References: <1358527534-16401-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TwJlb-0006HO-6Q
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 16:46:27 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so5571508qaq.19
	for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2013 13:46:21 -0800 (PST)
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

ClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVm
ZmljaW9zLmNvbT4KLS0tCiBiaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gfCA1ICsrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbSBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmls
ZS5hbQppbmRleCBiZjgwNTBlLi41MzZlMDdmIDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24v
TWFrZWZpbGUuYW0KKysrIGIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtCkBAIC0yMyw2ICsy
Myw1IEBAIF9iYWJlbHRyYWNlX2xhX0xJQkFERCA9ICQodG9wX3NyY2RpcikvZm9ybWF0cy9jdGYv
bGliYmFiZWx0cmFjZS1jdGYubGEJXAogIyBTV0lHICd3YXJuaW5nIG1kIHZhcmlhYmxlIHVudXNl
ZCcgZml4ZWQgYWZ0ZXIgU1dJRyBidWlsZDoKIGJhYmVsdHJhY2Vfd3JhcC5jOiBiYWJlbHRyYWNl
LmkKIAkkKFNXSUcpIC1weXRob24gLVdhbGwgLUkuIC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIGJh
YmVsdHJhY2UuaQotCXNlZCAtaSAicy9QeU9iamVjdCBcKm0sIFwqZCwgXCptZDsvUHlPYmplY3Qg
XCptLCBcKmQ7XG4jaWYgZGVmaW5lZChTV0lHUFlUSE9OX0JVSUxUSU4pXG5QeU9iamVjdCAqbWQ7
XG4jZW5kaWYvZyIgYmFiZWx0cmFjZV93cmFwLmMKLQlzZWQgLWkgInMvbWQgPSBkL2QvZyIgYmFi
ZWx0cmFjZV93cmFwLmMKLQlzZWQgLWkgInMvKHZvaWQpcHVibGljX3N5bWJvbDsvKHZvaWQpcHVi
bGljX3N5bWJvbDtcbiAgbWQgPSBkOy9nIiBiYWJlbHRyYWNlX3dyYXAuYworCitDTEVBTkZJTEVT
ID0gYmFiZWx0cmFjZS5pIGJhYmVsdHJhY2UucHkgYmFiZWx0cmFjZV93cmFwLmMKLS0gCjEuOC4x
LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
