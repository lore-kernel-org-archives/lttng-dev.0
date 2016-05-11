From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Add modules target to base
	Makefile
Date: Wed, 11 May 2016 10:38:06 -0400
Message-ID: <1462977486-18690-1-git-send-email-mjeanson__48024.293073877$1462977517$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7D5C1A3443
 for <lttng-dev@lists.lttng.org>; Wed, 11 May 2016 14:38:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 363D5340349
 for <lttng-dev@lists.lttng.org>; Wed, 11 May 2016 14:38:17 +0000 (UTC)
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

VGhpcyB3YXkgcnVubmluZyAnbWFrZSBtb2R1bGVzJyB3aWxsIGluZGVlZCBidWlsZCB0aGUgbW9k
dWxlcwpsaWtlIGluIHRoZSB1cHN0cmVhbSBidWlsZCBzeXN0ZW0uCgpTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KLS0tCiBNYWtlZmlsZSB8IDQg
KysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggNTg4Y2E5Ni4uNzM4YTM1YyAxMDA2
NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTEwMSw3ICsxMDEsOSBAQCBLRVJO
RUxESVIgPz0gL2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUgLXIpL2J1aWxkCiBQV0QgOj0gJChz
aGVsbCBwd2QpCiBDRkxBR1MgPSAkKEVYVENGTEFHUykKIAotZGVmYXVsdDoKK2RlZmF1bHQ6IG1v
ZHVsZXMKKworbW9kdWxlczoKIAkkKE1BS0UpIC1DICQoS0VSTkVMRElSKSBNPSQoUFdEKSBDT05G
SUdfTFRUTkc9bSBtb2R1bGVzCiAKIG1vZHVsZXNfaW5zdGFsbDoKLS0gCjEuOS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
