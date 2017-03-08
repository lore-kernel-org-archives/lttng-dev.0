From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules v3] Fix: atomic_add_unless()
	returns true/false rather than prior value
Date: Wed,  8 Mar 2017 11:50:38 -0500
Message-ID: <1488991838-13807-1-git-send-email-francis.deslauriers__2739.24352736703$1488991860$gmane$org@efficios.com>
References: <1488991131-9828-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdffb2FSdzw4W
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 16:50:46 +0000 (UTC)
In-Reply-To: <1488991131-9828-1-git-send-email-francis.deslauriers@efficios.com>
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
List-Id: lttng-dev@lists.lttng.org

VGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGFzc3VtZWQgdGhhdCBgYXRvbWljX2FkZF91bmxl
c3NgIHJldHVybmVkCnRoZSBwcmlvciB2YWx1ZSBvZiB0aGUgYXRvbWljIGNvdW50ZXIgd2hlbiBp
biBmYWN0IGl0IHJldHVybmVkIGlmIHRoZQphZGRpdGlvbiB3YXMgcGVyZm9ybWVkICh0cnVlKSBv
ciBub3QgcGVyZm9ybWVkIChmYWxzZSkuClNpbmNlIGBhdG9taWNfYWRkX3VubGVzc2AgY2FuIG5v
dCByZXR1cm4gSU5UX01BWCwgdGhlIGBsdHRuZ19rcmVmX2dldGAKYWx3YXlzIHJldHVybmVkIHRo
YXQgdGhlIGNhbGwgd2FzIHN1Y2Nlc3NmdWwuCgpUaGlzIGlzc3VlIGhhZCBhIGxvdyBsaWtlbGlo
b29kIG9mIGJlaW5nIHRyaWdnZXJlZCBzaW5jZSB0aGUgdHdvIHJlZmNvdW50cwpvZiB0aGUgY291
bnRlcnMgdXNlZCB3aXRoIHRoaXMgY2FsbCBhcmUgYm90aCBib3VuZGVkIGJ5IHRoZSBtYXhpbXVt
Cm51bWJlciBvZiBmaWxlIGRlc2NyaXB0b3JzIG9uIHRoZSBzeXN0ZW0uCgpTaWduZWQtb2ZmLWJ5
OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbT4K
LS0tCiB3cmFwcGVyL2tyZWYuaCB8IDYgKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd3JhcHBlci9rcmVmLmggYi93cmFw
cGVyL2tyZWYuaAppbmRleCBlZWRlZmJmLi5mMzBhOWFlIDEwMDY0NAotLS0gYS93cmFwcGVyL2ty
ZWYuaAorKysgYi93cmFwcGVyL2tyZWYuaApAQCAtMzYsMTEgKzM2LDcgQEAKICAqLwogc3RhdGlj
IGlubGluZSBpbnQgbHR0bmdfa3JlZl9nZXQoc3RydWN0IGtyZWYgKmtyZWYpCiB7Ci0JaWYgKGF0
b21pY19hZGRfdW5sZXNzKCZrcmVmLT5yZWZjb3VudCwgMSwgSU5UX01BWCkgIT0gSU5UX01BWCkg
ewotCQlyZXR1cm4gMTsKLQl9IGVsc2UgewotCQlyZXR1cm4gMDsKLQl9CisJcmV0dXJuIGF0b21p
Y19hZGRfdW5sZXNzKCZrcmVmLT5yZWZjb3VudCwgMSwgSU5UX01BWCk7CiB9CiAKICNlbmRpZiAv
KiBfTFRUTkdfV1JBUFBFUl9LUkVGX0ggKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
