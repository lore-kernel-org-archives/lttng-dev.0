From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] x is never reused,
	no need to shift it
Date: Tue, 17 Jan 2017 10:07:31 -0500
Message-ID: <1484665651-23987-1-git-send-email-jonathan.rajotte-julien__32628.6607575186$1484665687$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v2tmr6ndHzk3L
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jan 2017 15:09:32 +0000 (UTC)
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

QWxzbyByZW1vdmUgbm9pc2UgaW4gc2NhbmJ1aWxkIHJlcG9ydC4KClNpZ25lZC1vZmYtYnk6IEpv
bmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0t
CiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1tZXRhZGF0YS5jIHwgMSAtCiBzcmMvY29tbW9u
L2NvbXBhdC9zdHJpbmcuaCAgICAgICAgICAgIHwgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtbWV0YWRh
dGEuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LW1ldGFkYXRhLmMKaW5kZXggYzFhODBj
Ny4uZmIxZjExNSAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtbWV0YWRh
dGEuYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1tZXRhZGF0YS5jCkBAIC03NCw3
ICs3NCw2IEBAIGludCBmbHModW5zaWduZWQgaW50IHgpCiAJCXIgLT0gMjsKIAl9CiAJaWYgKCEo
eCAmIDB4ODAwMDAwMDBVKSkgewotCQl4IDw8PSAxOwogCQlyIC09IDE7CiAJfQogCXJldHVybiBy
OwpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb21wYXQvc3RyaW5nLmggYi9zcmMvY29tbW9uL2Nv
bXBhdC9zdHJpbmcuaAppbmRleCA3YzQyNmVmLi5kYjNkYjgwIDEwMDY0NAotLS0gYS9zcmMvY29t
bW9uL2NvbXBhdC9zdHJpbmcuaAorKysgYi9zcmMvY29tbW9uL2NvbXBhdC9zdHJpbmcuaApAQCAt
MTE3LDcgKzExNyw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGx0dG5nX2ZscyhpbnQgdmFsKQogCQly
IC09IDI7CiAJfQogCWlmICghKHggJiAweDgwMDAwMDAwVSkpIHsKLQkJeCA8PD0gMTsKIAkJciAt
PSAxOwogCX0KIAlyZXR1cm4gcjsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
