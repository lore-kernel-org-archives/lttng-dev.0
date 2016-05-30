From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 4/4] Use config.h to detect
	sched_getcpu support
Date: Mon, 30 May 2016 16:31:33 -0400
Message-ID: <1464640293-10157-4-git-send-email-mjeanson__37652.3065534004$1464640338$gmane$org@efficios.com>
References: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 624D5A3724
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 41A2234026C
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:59 +0000 (UTC)
In-Reply-To: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
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
LQogbGlicmluZ2J1ZmZlci9nZXRjcHUuaCB8IDEyICsrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWJyaW5n
YnVmZmVyL2dldGNwdS5oIGIvbGlicmluZ2J1ZmZlci9nZXRjcHUuaAppbmRleCBmYmRkYjc5Li43
YjAwOWRjIDEwMDY0NAotLS0gYS9saWJyaW5nYnVmZmVyL2dldGNwdS5oCisrKyBiL2xpYnJpbmdi
dWZmZXIvZ2V0Y3B1LmgKQEAgLTIyLDYgKzIyLDcgQEAKICNpbmNsdWRlIDx1cmN1L2NvbXBpbGVy
Lmg+CiAjaW5jbHVkZSA8dXJjdS9zeXN0ZW0uaD4KICNpbmNsdWRlIDx1cmN1L2FyY2guaD4KKyNp
bmNsdWRlIDxjb25maWcuaD4KIAogdm9pZCBsdHRuZ191c3RfZ2V0Y3B1X2luaXQodm9pZCk7CiAK
QEAgLTQ3LDEwICs0OCw3IEBAIGludCBsdHRuZ191c3RfZ2V0X2NwdV9pbnRlcm5hbCh2b2lkKQog
ICovCiAjaWZkZWYgX19saW51eF9fCiAKLS8qIG9sZCB1Q2xpYmMgdmVyc2lvbnMgZGlkbid0IGhh
dmUgc2NoZWRfZ2V0Y3B1ICovCi0jaWYgZGVmaW5lZChfX1VDTElCQ19fKSAmJiBfX1VDTElCQ19N
QUpPUl9fID09IDAgJiYgXAotCShfX1VDTElCQ19NSU5PUl9fIDwgOSB8fCBcCi0JIChfX1VDTElC
Q19NSU5PUl9fID09IDkgJiYgX19VQ0xJQkNfU1VCTEVWRUxfXyA8PSAzMikpCisjaWYgIUhBVkVf
U0NIRURfR0VUQ1BVCiAjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KICNkZWZpbmUgX19nZXRjcHUo
Y3B1LCBub2RlLCBjYWNoZSkJc3lzY2FsbChfX05SX2dldGNwdSwgY3B1LCBub2RlLCBjYWNoZSkK
IC8qCkBAIC02NCw5ICs2Miw5IEBAIGludCBsdHRuZ191c3RfZ2V0X2NwdV9pbnRlcm5hbCh2b2lk
KQogCXJldCA9IF9fZ2V0Y3B1KCZjcHUsIE5VTEwsIE5VTEwpOwogCWlmIChjYWFfdW5saWtlbHko
cmV0IDwgMCkpCiAJCXJldHVybiAwOwotCXJldHVybiBjOworCXJldHVybiBjcHU7CiB9Ci0jZWxz
ZSAvKiBfX1VDTElCQ19fICovCisjZWxzZSAvKiBIQVZFX1NDSEVEX0dFVENQVSAqLwogI2luY2x1
ZGUgPHNjaGVkLmg+CiAKIC8qCkBAIC04Miw3ICs4MCw3IEBAIGludCBsdHRuZ191c3RfZ2V0X2Nw
dV9pbnRlcm5hbCh2b2lkKQogCQlyZXR1cm4gMDsKIAlyZXR1cm4gY3B1OwogfQotI2VuZGlmCS8q
IF9fVUNMSUJDX18gKi8KKyNlbmRpZgkvKiBIQVZFX1NDSEVEX0dFVENQVSAqLwogCiAjZWxpZiAo
ZGVmaW5lZChfX0ZyZWVCU0RfXykgfHwgZGVmaW5lZChfX0NZR1dJTl9fKSkKIAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
