From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: use lttng_clock_gettime
	instead of clock_gettime
Date: Wed, 18 Oct 2017 11:39:06 -0400
Message-ID: <20171018153906.25870-1-jonathan.rajotte-julien__39807.3919619948$1508341554$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yHGc628jDzyxt
 for <lttng-dev@lists.lttng.org>; Wed, 18 Oct 2017 15:45:42 +0000 (UTC)
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

SXQgYXBwZWFycyB0aGF0IGNvbW1pdCAzODlmYmYwNGI0MWUyMDAyYmU0NGExZTMzOTJiZmFkZTJm
MWRlZWVmIG1pc3NlZAppdC4KClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0
aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiB0ZXN0cy91dGlscy91dGlscy5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdHMvdXRpbHMvdXRpbHMuYyBiL3Rlc3RzL3V0aWxzL3V0aWxzLmMKaW5k
ZXggYjg1ZjAyN2UuLjBiOTY1NTI0IDEwMDY0NAotLS0gYS90ZXN0cy91dGlscy91dGlscy5jCisr
KyBiL3Rlc3RzL3V0aWxzL3V0aWxzLmMKQEAgLTU1LDcgKzU1LDcgQEAgaW50IHVzbGVlcF9zYWZl
KHVzZWNvbmRzX3QgdXNlYykKIAkJCWdvdG8gZW5kOwogCQl9CiAKLQkJcmV0ID0gY2xvY2tfZ2V0
dGltZShDTE9DS19NT05PVE9OSUMsICZ0Mik7CisJCXJldCA9IGx0dG5nX2Nsb2NrX2dldHRpbWUo
Q0xPQ0tfTU9OT1RPTklDLCAmdDIpOwogCQlpZiAocmV0KSB7CiAJCQlwZXJyb3IoImNsb2NrX2dl
dHRpbWUiKTsKIAkJCWdvdG8gZW5kOwotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
