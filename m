From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: update btrfs instrumentation
	for kernel 4.11
Date: Tue,  7 Mar 2017 09:53:28 -0500
Message-ID: <1488898408-27166-1-git-send-email-francis.deslauriers__9190.39651421389$1488898431$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vd06Q6LjxzlGR
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 14:54:06 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRy
ZnMuaCB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaCBiL2lu
c3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmgKaW5kZXggY2M3YmE1MC4u
Mjk1NWUyOCAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUv
YnRyZnMuaAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9idHJmcy5o
CkBAIC04Nyw5ICs4NywxOCBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNFKGJ0cmZz
X19pbm9kZSwgYnRyZnNfaW5vZGVfZXZpY3QsCiAKIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQoYnRy
ZnNfZ2V0X2V4dGVudCwKIAorI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJ
T04oNCwxMSwwKSkKKworCVRQX1BST1RPKHN0cnVjdCBidHJmc19yb290ICpyb290LCBzdHJ1Y3Qg
YnRyZnNfaW5vZGUgKmlub2RlLAorCQlzdHJ1Y3QgZXh0ZW50X21hcCAqbWFwKSwKKworI2Vsc2Ug
LyogI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxMSwwKSkgKi8K
KwogCVRQX1BST1RPKHN0cnVjdCBidHJmc19yb290ICpyb290LCBzdHJ1Y3QgaW5vZGUgKmlub2Rl
LAogCQlzdHJ1Y3QgZXh0ZW50X21hcCAqbWFwKSwKIAorI2VuZGlmIC8qICNlbHNlICNpZiAoTElO
VVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTEsMCkpICovCisKIAlUUF9BUkdT
KHJvb3QsIGlub2RlLCBtYXApLAogCiAJVFBfRklFTERTKAotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
