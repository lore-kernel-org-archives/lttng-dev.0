From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace] Fix: Added a null pointer check to
	bt_ctf_field_name.
Date: Mon, 28 Jan 2013 10:36:07 +0000
Message-ID: <1359369367-12876-1-git-send-email-jeremie.galarneau__6441.51771343804$1359387470$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TzqlZ-0000ND-Dw
	for lttng-dev@lists.lttng.org; Mon, 28 Jan 2013 10:37:01 -0500
Received: by mail-qe0-f44.google.com with SMTP id a11so893158qen.31
	for <lttng-dev@lists.lttng.org>; Mon, 28 Jan 2013 07:36:56 -0800 (PST)
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

VGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgaW5kaXJlY3RseSB3aGVuIGNhbGxpbmcgX19yZXByX18g
KHByaW50KSBpbiB0aGUgcHl0aG9uCmJpbmRpbmdzIG9uIHRoZSBkZWZpbml0aW9uIG9iamVjdCBy
ZXR1cm5lZCBieSB0aGUgZ2V0X3RvcF9sZXZlbF9zY29wZSBtZXRob2QKdGh1cyByZXN1bHRpbmcg
aW4gYSBzZWdtZW50YXRpb24gZmF1bHQgd2hlbiB0aGUgbmFtZSBhdHRyaWJ1dGUgaXMgbm90IHNl
dC4KCkZpeGVzICMzNzMKClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVt
aWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBmb3JtYXRzL2N0Zi9ldmVudHMuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2Zvcm1hdHMvY3RmL2V2ZW50cy5jIGIvZm9ybWF0cy9jdGYvZXZlbnRzLmMKaW5kZXgg
YWM3ZGNlNC4uMTgyZDBkZSAxMDA2NDQKLS0tIGEvZm9ybWF0cy9jdGYvZXZlbnRzLmMKKysrIGIv
Zm9ybWF0cy9jdGYvZXZlbnRzLmMKQEAgLTE2OCw3ICsxNjgsNyBAQCBjb25zdCBjaGFyICpidF9j
dGZfZXZlbnRfbmFtZShjb25zdCBzdHJ1Y3QgYnRfY3RmX2V2ZW50ICpjdGZfZXZlbnQpCiAKIGNv
bnN0IGNoYXIgKmJ0X2N0Zl9maWVsZF9uYW1lKGNvbnN0IHN0cnVjdCBkZWZpbml0aW9uICpkZWYp
CiB7Ci0JaWYgKCFkZWYpCisJaWYgKCFkZWYgfHwgIWRlZi0+bmFtZSkKIAkJcmV0dXJuIE5VTEw7
CiAKIAlyZXR1cm4gcmVtXyhnX3F1YXJrX3RvX3N0cmluZyhkZWYtPm5hbWUpKTsKLS0gCjEuOC4x
LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
