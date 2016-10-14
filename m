From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: Out of tree build of
	liblttng-ust-java
Date: Fri, 14 Oct 2016 16:45:20 -0400
Message-ID: <1476477920-25433-1-git-send-email-mjeanson__48945.5454786823$1476477952$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 276CFA4439
 for <lttng-dev@lists.lttng.org>; Fri, 14 Oct 2016 20:47:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 390AB3402C3
 for <lttng-dev@lists.lttng.org>; Fri, 14 Oct 2016 20:46:56 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogbGlibHR0bmctdXN0LWphdmEvTWFrZWZpbGUuYW0gfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWJsdHRuZy11c3Qt
amF2YS9NYWtlZmlsZS5hbSBiL2xpYmx0dG5nLXVzdC1qYXZhL01ha2VmaWxlLmFtCmluZGV4IGJh
YWRhNTcuLjBjMmY2YTUgMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC1qYXZhL01ha2VmaWxlLmFt
CisrKyBiL2xpYmx0dG5nLXVzdC1qYXZhL01ha2VmaWxlLmFtCkBAIC03LDcgKzcsNyBAQCBkaXN0
X25vaW5zdF9KQVZBID0gJChwa2dwYXRoKS9MVFRuZ1VzdC5qYXZhCiBqYXJfREFUQSA9ICQoamFy
ZmlsZSkKIEJVSUxUX1NPVVJDRVMgPSBvcmdfbHR0bmdfdXN0X0xUVG5nVXN0LmgKIAotQU1fQ1BQ
RkxBR1MgPSAtSSQodG9wX3NyY2RpcikvaW5jbHVkZQorQU1fQ1BQRkxBR1MgPSAtSSQodG9wX3Ny
Y2RpcikvaW5jbHVkZSAtSSQodG9wX2J1aWxkZGlyKS9pbmNsdWRlCiBsaWJfTFRMSUJSQVJJRVMg
PSBsaWJsdHRuZy11c3QtamF2YS5sYQogbGlibHR0bmdfdXN0X2phdmFfbGFfU09VUkNFUyA9IExU
VG5nVXN0LmMgbHR0bmdfdXN0X2phdmEuaAogbm9kaXN0X2xpYmx0dG5nX3VzdF9qYXZhX2xhX1NP
VVJDRVMgPSBvcmdfbHR0bmdfdXN0X0xUVG5nVXN0LmgKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
