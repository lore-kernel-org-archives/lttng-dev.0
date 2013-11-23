From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [lttng-tools PATCH 3/5] Fix: utils_expand_path now
	works for paths that ends with '/.' or '/..'
Date: Sat, 23 Nov 2013 17:32:26 -0500
Message-ID: <1385245948-23011-4-git-send-email-raphael.beamonte__33791.4572483443$1385246531$gmane$org@gmail.com>
References: <20131115154539.GA6986@thessa>
	<1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1VkLks-0004vB-BL
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 17:32:56 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so4425427ieb.4
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 14:32:41 -0800 (PST)
In-Reply-To: <1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Q2FzZXMgd2hlcmUgdGhlIHBhdGggZ2l2ZW4gZW5kZWQgd2l0aCAnLy4nIG9yICcvLi4nIHdlcmUg
bm90IGhhbmRsZWQKcHJvcGVybHkgdXNpbmcgdGhlIHV0aWxzX2V4cGFuZF9wYXRoIGZ1bmN0aW9u
IGFuZCB0aGUgcmVzdWx0aW5nIHBhdGgKd2FzIHN0aWxsIHNob3dpbmcgdGhpcyBlbmQgcGFydC4g
VGhpcyBmaXggYWltcyB0byB0cmVhdCB0aGF0IGxhc3QKcGFydCBhbmQgJ2V4cGFuZCcgaXQgYXMg
ZXhwZWN0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBSYXBoYcOrbCBCZWFtb250ZSA8cmFwaGFlbC5iZWFt
b250ZUBnbWFpbC5jb20+Ci0tLQogc3JjL2NvbW1vbi91dGlscy5jIHwgICAyNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvc3JjL2NvbW1vbi91dGlscy5jIGIvc3JjL2NvbW1vbi91dGlscy5jCmluZGV4IDMz
MGMwNGUuLmNlMjVmMjMgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24vdXRpbHMuYworKysgYi9zcmMv
Y29tbW9uL3V0aWxzLmMKQEAgLTE3OCw2ICsxNzgsOCBAQCBMVFROR19ISURERU4KIGNoYXIgKnV0
aWxzX2V4cGFuZF9wYXRoKGNvbnN0IGNoYXIgKnBhdGgpCiB7CiAJY2hhciAqbmV4dCwgKnByZXZp
b3VzLCAqc2xhc2gsICpzdGFydF9wYXRoLCAqYWJzb2x1dGVfcGF0aCA9IE5VTEw7CisJY2hhciAq
bGFzdF90b2tlbjsKKwlpbnQgaXNfZG90LCBpc19kb3Rkb3Q7CiAKIAkvKiBTYWZldHkgbmV0ICov
CiAJaWYgKHBhdGggPT0gTlVMTCkgewpAQCAtMjQxLDYgKzI0MywzMSBAQCBjaGFyICp1dGlsc19l
eHBhbmRfcGF0aChjb25zdCBjaGFyICpwYXRoKQogCQkJCWFic29sdXRlX3BhdGgsIFBBVEhfTUFY
KTsKIAl9CiAKKwkvKiBJZGVudGlmeSB0aGUgbGFzdCB0b2tlbiAqLworCWxhc3RfdG9rZW4gPSBz
dHJyY2hyKGFic29sdXRlX3BhdGgsICcvJyk7CisKKwkvKiBWZXJpZnkgdGhhdCB0aGlzIHRva2Vu
IGlzIG5vdCBhIHJlbGF0aXZlIHBhdGggKi8KKwlpc19kb3Rkb3QgPSAoc3RyY21wKGxhc3RfdG9r
ZW4sICIvLi4iKSA9PSAwKTsKKwlpc19kb3QgPSAoc3RyY21wKGxhc3RfdG9rZW4sICIvLiIpID09
IDApOworCisJLyogSWYgaXQgaXMsIHRha2UgYWN0aW9uICovCisJaWYgKGlzX2RvdCB8fCBpc19k
b3Rkb3QpIHsKKwkJLyogRm9yIGJvdGgsIHJlbW92ZSB0aGlzIHRva2VuICovCisJCSpsYXN0X3Rv
a2VuID0gJ1wwJzsKKworCQkvKiBJZiBpdCB3YXMgYSByZWZlcmVuY2UgdG8gcGFyZW50IGRpcmVj
dG9yeSwgZ28gYmFjayBvbmUgbW9yZSB0aW1lICovCisJCWlmIChpc19kb3Rkb3QpIHsKKwkJCWxh
c3RfdG9rZW4gPSBzdHJyY2hyKGFic29sdXRlX3BhdGgsICcvJyk7CisKKwkJCS8qIElmIHRoZXJl
IHdhcyBvbmx5IG9uZSBsZXZlbCBsZWZ0LCB3ZSBrZWVwIHRoZSBmaXJzdCAnLycgKi8KKwkJCWlm
IChsYXN0X3Rva2VuID09IGFic29sdXRlX3BhdGgpIHsKKwkJCQlsYXN0X3Rva2VuKys7CisJCQl9
CisKKwkJCSpsYXN0X3Rva2VuID0gJ1wwJzsKKwkJfQorCX0KKwogCXJldHVybiBhYnNvbHV0ZV9w
YXRoOwogCiBlcnJvcjoKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
