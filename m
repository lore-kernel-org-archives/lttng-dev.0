From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-ust] Clean-up: remove unused variables to
	silence gcc warning
Date: Fri,  5 May 2017 11:52:07 -0400
Message-ID: <20170505155207.22687-1-jeremie.galarneau__33200.6352291957$1493999539$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKGd52vjQzDQs
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 15:52:56 +0000 (UTC)
Received: by mail-io0-x241.google.com with SMTP id 12so2291348iol.1
 for <lttng-dev@lists.lttng.org>; Fri, 05 May 2017 08:52:10 -0700 (PDT)
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

R0NDIDYuMy4xIHdhcm5zIHRoYXQgdHdvIHZhcmlhYmxlcyAod3JpdGVfb2Zmc2V0IGFuZCBjb25z
dW1lZF9jdXIpCmluIGxpYl9yaW5nX2J1ZmZlcl9zbmFwc2hvdF9zYW1wbGVfcG9zaXRpb25zKCkg
YXJlIHVudXNlZC4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUu
Z2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBsaWJyaW5nYnVmZmVyL3JpbmdfYnVmZmVyX2Zy
b250ZW5kLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvbGlicmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9mcm9udGVuZC5jIGIvbGlicmluZ2J1ZmZlci9y
aW5nX2J1ZmZlcl9mcm9udGVuZC5jCmluZGV4IDliMTY2ODUyLi45ZWNkYzE1NyAxMDA2NDQKLS0t
IGEvbGlicmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9mcm9udGVuZC5jCisrKyBiL2xpYnJpbmdidWZm
ZXIvcmluZ19idWZmZXJfZnJvbnRlbmQuYwpAQCAtMTMyMyw3ICsxMzIzLDYgQEAgaW50IGxpYl9y
aW5nX2J1ZmZlcl9zbmFwc2hvdF9zYW1wbGVfcG9zaXRpb25zKAogewogCXN0cnVjdCBjaGFubmVs
ICpjaGFuOwogCWNvbnN0IHN0cnVjdCBsdHRuZ191c3RfbGliX3JpbmdfYnVmZmVyX2NvbmZpZyAq
Y29uZmlnOwotCXVuc2lnbmVkIGxvbmcgY29uc3VtZWRfY3VyLCB3cml0ZV9vZmZzZXQ7CiAKIAlj
aGFuID0gc2htcChoYW5kbGUsIGJ1Zi0+YmFja2VuZC5jaGFuKTsKIAlpZiAoIWNoYW4pCi0tIAoy
LjEyLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
