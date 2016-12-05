From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Add missing pthread.h include
Date: Mon,  5 Dec 2016 15:39:26 -0500
Message-ID: <1480970366-14140-1-git-send-email-mjeanson__41131.8103936084$1480970384$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tXc9b1HJVztr7
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:41:22 +0000 (UTC)
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

U29tZSBsaWJjIGxpa2UgbXVzbCBhbmQgdUNsaWJjIHJlcXVpcmVzIGV4cGxpY2l0IGluY2x1ZGVz
IG9mIHB0aHJlYWQuaAoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBl
ZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi9kZWZhdWx0cy5oIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2RlZmF1bHRzLmgg
Yi9zcmMvY29tbW9uL2RlZmF1bHRzLmgKaW5kZXggMjdmMWRkYy4uMzdkMjIyYSAxMDA2NDQKLS0t
IGEvc3JjL2NvbW1vbi9kZWZhdWx0cy5oCisrKyBiL3NyYy9jb21tb24vZGVmYXVsdHMuaApAQCAt
MjAsNiArMjAsNyBAQAogI2lmbmRlZiBfREVGQVVMVFNfSAogI2RlZmluZSBfREVGQVVMVFNfSAog
CisjaW5jbHVkZSA8cHRocmVhZC5oPgogI2luY2x1ZGUgPHNyYy9jb21tb24vbWFjcm9zLmg+CiAK
IC8qIERlZmF1bHQgdW5peCBncm91cCBuYW1lIGZvciB0cmFjaW5nLiAqLwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
