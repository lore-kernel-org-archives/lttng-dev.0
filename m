From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 3/3] Tests fix: add missing Cygwin thread id
Date: Thu, 20 Jul 2017 17:33:47 -0400
Message-ID: <1500586427-30038-3-git-send-email-mjeanson__35501.5694666237$1500586540$gmane$org@efficios.com>
References: <1500586427-30038-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xD6fK5WtYz13fW
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:36:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8F187340304
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:35:45 +0000 (UTC)
In-Reply-To: <1500586427-30038-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvY29tbW9uL3RocmVhZC1pZC5oIHwgMTIgKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2NvbW1vbi90aHJlYWQt
aWQuaCBiL3Rlc3RzL2NvbW1vbi90aHJlYWQtaWQuaAppbmRleCA5NmYxZjU5Li5jYjBkOTAzIDEw
MDY0NAotLS0gYS90ZXN0cy9jb21tb24vdGhyZWFkLWlkLmgKKysrIGIvdGVzdHMvY29tbW9uL3Ro
cmVhZC1pZC5oCkBAIC01Nyw2ICs1NywxOCBAQCB1bnNpZ25lZCBsb25nIHVyY3VfZ2V0X3RocmVh
ZF9pZCh2b2lkKQogewogCXJldHVybiAodW5zaWduZWQgbG9uZykgcHRocmVhZF9zZWxmKCk7CiB9
CisjZWxpZiBkZWZpbmVkKF9fQ1lHV0lOX18pCisjaW5jbHVkZSA8cHRocmVhZC5oPgorCitleHRl
cm4gdW5zaWduZWQgbG9uZyBwdGhyZWFkX2dldHNlcXVlbmNlX25wKHB0aHJlYWRfdCAqKTsKKwor
c3RhdGljIGlubGluZQordW5zaWduZWQgbG9uZyB1cmN1X2dldF90aHJlYWRfaWQodm9pZCkKK3sK
KwlwdGhyZWFkX3QgdGhyID0gcHRocmVhZF9zZWxmKCk7CisJcmV0dXJuIHB0aHJlYWRfZ2V0c2Vx
dWVuY2VfbnAoJnRocik7Cit9CisKICNlbHNlCiAjIHdhcm5pbmcgInVzZSBwaWQgYXMgdGhyZWFk
IElEIgogc3RhdGljIGlubGluZQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
