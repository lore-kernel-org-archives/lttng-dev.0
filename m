From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: merge tap tests stdout and stderr
Date: Wed, 18 May 2016 15:18:05 -0400
Message-ID: <1463599085-28416-1-git-send-email-mjeanson__13716.6592562155$1463599121$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 68761A3586
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:18:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3E981340372
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:18:13 +0000 (UTC)
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

VGhpcyBtYWtlcyB0aGUgb3V0cHV0IGFuZCBlcnJvciBzdGF0ZW1lbnQgb3JkZXJlZCBpbiB0aGUg
bG9nCmZpbGUgYW5kIGVuc3VyZSB0aGF0IHRoZSBmaXJzdCBsaW5lIGlzIHRoZSB0YXAgdGVzdCBw
bGFuLiBTb21lIHRhcApwYXJzZXIgYXJlIGNvbmZ1c2VkIGlmIHRoZSB0ZXN0IHBsYW4gaXMgbm90
IG9uIHRoZSBmaXJzdCBsaW5lLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvTWFrZWZpbGUuYW0gfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL01ha2VmaWxlLmFtIGIv
dGVzdHMvTWFrZWZpbGUuYW0KaW5kZXggOTZhM2ZhYS4uZmQyZWFjMyAxMDA2NDQKLS0tIGEvdGVz
dHMvTWFrZWZpbGUuYW0KKysrIGIvdGVzdHMvTWFrZWZpbGUuYW0KQEAgLTUsNiArNSw3IEBAIGlm
IENYWF9XT1JLUwogU1VCRElSUyArPSBoZWxsby5jeHgKIGVuZGlmCiAKK0xPR19EUklWRVJfRkxB
R1M9Jy0tbWVyZ2UnCiBMT0dfRFJJVkVSID0gZW52IEFNX1RBUF9BV0s9JyQoQVdLKScgJChTSEVM
TCkgXAogCSQodG9wX3NyY2RpcikvY29uZmlnL3RhcC1kcml2ZXIuc2gKIAotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
