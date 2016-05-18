From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: merge tap tests stdout and
	stderr
Date: Wed, 18 May 2016 15:43:06 -0400
Message-ID: <1463600586-29374-1-git-send-email-mjeanson__35977.9564234943$1463600619$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A2561A35B0
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:43:13 +0000 (UTC)
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

VGhpcyBtYWtlcyB0aGUgb3V0cHV0IGFuZCBlcnJvciBzdGF0ZW1lbnQgb3JkZXJlZCBpbiB0aGUg
bG9nCmZpbGUgYW5kIGVuc3VyZSB0aGF0IHRoZSBmaXJzdCBsaW5lIGlzIHRoZSB0YXAgdGVzdCBw
bGFuLiBTb21lIHRhcApwYXJzZXIgYXJlIGNvbmZ1c2VkIGlmIHRoZSB0ZXN0IHBsYW4gaXMgbm90
IG9uIHRoZSBmaXJzdCBsaW5lLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvcmVncmVzc2lvbi9NYWtlZmlsZS5hbSB8IDEg
KwogdGVzdHMvdW5pdC9NYWtlZmlsZS5hbSAgICAgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL01ha2VmaWxlLmFt
IGIvdGVzdHMvcmVncmVzc2lvbi9NYWtlZmlsZS5hbQppbmRleCA1ZjRhNmU0Li42YTJkMjRjIDEw
MDY0NAotLS0gYS90ZXN0cy9yZWdyZXNzaW9uL01ha2VmaWxlLmFtCisrKyBiL3Rlc3RzL3JlZ3Jl
c3Npb24vTWFrZWZpbGUuYW0KQEAgLTEsNSArMSw2IEBACiBTVUJESVJTID0gdG9vbHMga2VybmVs
IHVzdAogCitMT0dfRFJJVkVSX0ZMQUdTPSctLW1lcmdlJwogTE9HX0RSSVZFUiA9IGVudiBBTV9U
QVBfQVdLPSckKEFXSyknICQoU0hFTEwpIFwKIAkkKHRvcF9zcmNkaXIpL2NvbmZpZy90YXAtZHJp
dmVyLnNoCiAKZGlmZiAtLWdpdCBhL3Rlc3RzL3VuaXQvTWFrZWZpbGUuYW0gYi90ZXN0cy91bml0
L01ha2VmaWxlLmFtCmluZGV4IGI3ZjMxOGYuLjU2MjVjZjAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3Vu
aXQvTWFrZWZpbGUuYW0KKysrIGIvdGVzdHMvdW5pdC9NYWtlZmlsZS5hbQpAQCAtMyw2ICszLDcg
QEAgU1VCRElSUyA9IGluaV9jb25maWcKIEFNX0NGTEFHUyA9IC1JJCh0b3Bfc3JjZGlyKS9pbmNs
dWRlIC1JJCh0b3Bfc3JjZGlyKS9zcmMgLUkkKHRvcF9zcmNkaXIpL3Rlc3RzL3V0aWxzLyAtSSQo
c3JjZGlyKQogQU1fTERGTEFHUyA9CiAKK0xPR19EUklWRVJfRkxBR1M9Jy0tbWVyZ2UnCiBMT0df
RFJJVkVSID0gZW52IEFNX1RBUF9BV0s9JyQoQVdLKScgJChTSEVMTCkgXAogCSQodG9wX3NyY2Rp
cikvY29uZmlnL3RhcC1kcml2ZXIuc2gKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
