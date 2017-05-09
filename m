From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: COMPAT_EPOLL_PROC_PATH is
	available from Linux 2.6.28
Date: Tue,  9 May 2017 15:46:35 -0400
Message-ID: <20170509194635.18701-1-jonathan.rajotte-julien__1484.18896501443$1494359213$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMqcz146Szs4L
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 19:46:42 +0000 (UTC)
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

djI6IFR5cG8gaW4gY29tbWl0IG1lc3NhZ2UgInBlciBzZWUiIC0+ICJwZXIgc2UiCgpGYWlsaW5n
IG9uIG9wZW5pbmcgWzFdIGlzIG5vdCBhbiBlcnJvciBwZXIgc2UuIFsxXSB3YXMKaW50cm9kdWNl
ZCBpbiBMaW51eCAyLjYuMjggYnV0IGVwb2xsIGlzIGF2YWlsYWJsZSBzaW5jZQoyLjUuNDQuIEhl
bmNlLCBnb3RvIGVuZCBhbmQgc2V0IGEgZGVmYXVsdCB2YWx1ZSB3aXRob3V0CnNldHRpbmcgZXJy
b3IgcmV0dXJuIHZhbHVlLgoKWzFdIC9wcm9jL3N5cy9mcy9lcG9sbC9tYXhfdXNlcl93YXRjaGVz
CgpTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGll
bkBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMgfCAx
MCArKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMgYi9zcmMv
Y29tbW9uL2NvbXBhdC9jb21wYXQtZXBvbGwuYwppbmRleCBkYmFmNjgyMy4uNmE3ODFjN2EgMTAw
NjQ0Ci0tLSBhL3NyYy9jb21tb24vY29tcGF0L2NvbXBhdC1lcG9sbC5jCisrKyBiL3NyYy9jb21t
b24vY29tcGF0L2NvbXBhdC1lcG9sbC5jCkBAIC0zMDEsNyArMzAxLDE1IEBAIGludCBjb21wYXRf
ZXBvbGxfc2V0X21heF9zaXplKHZvaWQpCiAKIAlmZCA9IG9wZW4oQ09NUEFUX0VQT0xMX1BST0Nf
UEFUSCwgT19SRE9OTFkpOwogCWlmIChmZCA8IDApIHsKLQkJcmV0dmFsID0gLTE7CisJCS8qCisJ
CSAqIEZhaWxpbmcgb24gb3BlbmluZyBbMV0gaXMgbm90IGFuIGVycm9yIHBlciBzZWUuIFsxXSB3
YXMKKwkJICogaW50cm9kdWNlZCBpbiBMaW51eCAyLjYuMjggYnV0IGVwb2xsIGlzIGF2YWlsYWJs
ZSBzaW5jZQorCQkgKiAyLjUuNDQuIEhlbmNlLCBnb3RvIGVuZCBhbmQgc2V0IGEgZGVmYXVsdCB2
YWx1ZSB3aXRob3V0CisJCSAqIHNldHRpbmcgYW4gZXJyb3IgcmV0dXJuIHZhbHVlLgorCQkgKgor
CQkgKiBbMV0gL3Byb2Mvc3lzL2ZzL2Vwb2xsL21heF91c2VyX3dhdGNoZXMKKwkJICovCisJCXJl
dHZhbCA9IDA7CiAJCWdvdG8gZW5kOwogCX0KIAotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
