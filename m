From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust] Fix: remove NULL check of nonnull
	parameter in dlclose
Date: Mon,  9 May 2016 16:33:29 -0400
Message-ID: <1462826009-3883-1-git-send-email-abusque__40395.9613795907$1462826041$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D5644A2E28
 for <lttng-dev@lists.lttng.org>; Mon,  9 May 2016 20:33:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9F0C53402DB
 for <lttng-dev@lists.lttng.org>; Mon,  9 May 2016 20:33:35 +0000 (UTC)
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

IFRoZSBgaGFuZGxlYCBwYXJhbWV0ZXIgb2YgYGRsY2xvc2VgLCBhcyBkZWZpbmVkIGluCiBgaW5j
bHVkZS9sdHRuZy91c3QtZGxmY24uaGAgaXMgbWFya2VkIGBfX25vbm51bGxgLiBHQ0Mgc3RhcnRp
bmcgd2l0aAogdmVyc2lvbiA2LjEgZW1pdHMgd2FybmluZ3MgZm9yIGNvbXBhcmlzb25zIG9mIG5v
bm51bGwgYXJndW1lbnRzCiBhZ2FpbnN0IE5VTEwgYnkgZGVmYXVsdCAoc2VlIC1Xbm9ubnVsbC1j
b21wYXJlKS4KCiBUaGVyZWZvcmUsIHRoaXMgcmVtb3ZlcyBhIHN1cGVyZmx1b3VzIE5VTEwgY2hl
Y2sgb24gYGhhbmRsZWAsIGZvcgogd2hpY2ggR0NDIGVtaXR0ZWQgYSB3YXJuaW5nLgoKU2lnbmVk
LW9mZi1ieTogQW50b2luZSBCdXNxdWUgPGFidXNxdWVAZWZmaWNpb3MuY29tPgotLS0KIGxpYmx0
dG5nLXVzdC1kbC9sdHRuZy11c3QtZGwuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC1kbC9sdHRu
Zy11c3QtZGwuYyBiL2xpYmx0dG5nLXVzdC1kbC9sdHRuZy11c3QtZGwuYwppbmRleCA5NTRkOWRm
Li5hYzNjOTUxIDEwMDY0NAotLS0gYS9saWJsdHRuZy11c3QtZGwvbHR0bmctdXN0LWRsLmMKKysr
IGIvbGlibHR0bmctdXN0LWRsL2x0dG5nLXVzdC1kbC5jCkBAIC0xNDQsNyArMTQ0LDcgQEAgdm9p
ZCAqZGxvcGVuKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBpbnQgZmxhZykKIAogaW50IGRsY2xvc2Uo
dm9pZCAqaGFuZGxlKQogewotCWlmIChfX3RyYWNlcG9pbnRfcHRyc19yZWdpc3RlcmVkICYmIGhh
bmRsZSkgeworCWlmIChfX3RyYWNlcG9pbnRfcHRyc19yZWdpc3RlcmVkKSB7CiAJCXN0cnVjdCBs
aW5rX21hcCAqcCA9IE5VTEw7CiAJCWludCByZXQ7CiAKLS0gCjIuOC4yCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
