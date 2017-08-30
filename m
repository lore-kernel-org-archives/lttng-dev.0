From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: remove
	g_spawn_check_exit_status to support glib 2.22
Date: Wed, 30 Aug 2017 14:54:23 -0400
Message-ID: <1504119263-15163-1-git-send-email-mjeanson__17878.2040290118$1504119286$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xjF6Z47c1zD9H
 for <lttng-dev@lists.lttng.org>; Wed, 30 Aug 2017 18:54:30 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jIHwgMTAgKysrKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0
cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMgYi90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMKaW5k
ZXggM2QyNGVhNC4uOWM2NWQ4NCAxMDA2NDQKLS0tIGEvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRl
ci5jCisrKyBiL3Rlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYwpAQCAtMTIyLDEwICsxMjIsMTYg
QEAgdm9pZCB2YWxpZGF0ZV90cmFjZShjaGFyICpwYXJzZXJfcGF0aCwgY2hhciAqdHJhY2VfcGF0
aCkKIAkJZ290byByZXN1bHQ7CiAJfQogCi0JaWYoIWdfc3Bhd25fY2hlY2tfZXhpdF9zdGF0dXMo
ZXhpdF9zdGF0dXMsIE5VTEwpKSB7CisJLyogUmVwbGFjZSBieSBnX3NwYXduX2NoZWNrX2V4aXRf
c3RhdHVzIHdoZW4gd2UgcmVxdWlyZSBnbGliID49IDIuMzQgKi8KKyNpZiBHX09TX1VOSVgKKwly
ZXQgPSBXSUZFWElURUQoZXhpdF9zdGF0dXMpID8gV0VYSVRTVEFUVVMoZXhpdF9zdGF0dXMpIDog
LTE7CisjZWxzZQorCXJldCA9IGV4aXRfc3RhdHVzOworI2VuZGlmCisKKwlpZihyZXQgIT0gMCkg
ewogCQlkaWFnKCJCYWJlbHRyYWNlIHJldHVybmVkIGFuIGVycm9yLiIpOwogCQlkaWFnX211bHRp
bGluZShzdGFuZGFyZF9lcnJvcik7Ci0JCXJldCA9IC0xOwogCQlnb3RvIHJlc3VsdDsKIAl9CiAK
LS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
