From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools stable-2.6 2/3] Tests: use
	configured processor count in snapshot tests
Date: Tue, 15 Mar 2016 16:13:25 -0400
Message-ID: <1458072806-19932-2-git-send-email-mjeanson__44969.6796866649$1458072838$gmane$org@efficios.com>
References: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C42FEA0A77
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 20:13:36 +0000 (UTC)
In-Reply-To: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
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

RnJvbTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29t
PgoKU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVA
ZWZmaWNpb3MuY29tPgotLS0KIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc25hcHNob3RzL3VzdF90
ZXN0IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9zbmFwc2hvdHMvdXN0X3Rlc3Qg
Yi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy91c3RfdGVzdAppbmRleCBlODM5Yjg0
Li4wYjhiYjI0IDEwMDc1NQotLS0gYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy91
c3RfdGVzdAorKysgYi90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy91c3RfdGVzdApA
QCAtMTgyLDcgKzE4Miw3IEBAIGZ1bmN0aW9uIHRlc3RfdXN0X2xvY2FsX3NuYXBzaG90ICgpCiBm
dW5jdGlvbiB0ZXN0X3VzdF9sb2NhbF9zbmFwc2hvdF9tYXhfc2l6ZSAoKQogewogCXN1YmJ1Zl9z
aXplPTgxOTIKLQludW1fY3B1cz1gbnByb2NgCisJbnVtX2NwdXM9JChjb25mX3Byb2NfY291bnQp
CiAKIAkjIFRoZSBtaW5pbXVtIHNpemUgbGltaXQgaXMgbWluKHN1YmJ1Zl9zaXplKSAqIG5iX3N0
cmVhbXMKIAltYXhfc2l6ZT0kKCgkc3ViYnVmX3NpemUqJG51bV9jcHVzKSkKLS0gCjIuNy4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
