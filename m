From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 2/2] Fix: cache the result of getpid()
	internally
Date: Fri,  2 Mar 2018 17:36:26 -0500
Message-ID: <1520030186-5612-2-git-send-email-mjeanson__44946.9583844349$1520030104$gmane$org@efficios.com>
References: <1520030186-5612-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3ztPL14rrgzr3J
 for <lttng-dev@lists.lttng.org>; Fri,  2 Mar 2018 17:36:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7E870419270
 for <lttng-dev@lists.lttng.org>; Fri,  2 Mar 2018 17:36:41 -0500 (EST)
In-Reply-To: <1520030186-5612-1-git-send-email-mjeanson@efficios.com>
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

T24gTGludXggd2UgY2FsbGVkIGdldHBpZCgpIGRpcmVjdGx5IG9uIGVhY2ggdHJhY2Vwb2ludCBh
bmQgcmVsaWVkIG9uCnRoZSBnbGliYyBwaWQgY2FjaGUuIEhvd2V2ZXIsIGluIGdsaWJjIDIuMjUs
IHJlbGVhc2VkIG9uIDIwMTctMDItMDUsIHRoZQpwaWQgY2FjaGUgd2FzIHJlbW92ZWQgd2hpY2gg
cmVzdWx0cyBpbiBhIGdldHBpZCBzeXNjYWxsIG9uIGVhY2ggZXZlbnQKd2hlbiB0aGUgdnBpZCBj
b250ZXh0IGlzIGVuYWJsZWQuCgpSZW1vdmUgdGhlIExpbnV4IHNwZWNpZmljIGNhc2UgYW5kIHVz
ZSBvdXIgaW50ZXJuYWwgY2FjaGUgYWxsIHRoZSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogbGlibHR0bmctdXN0L2x0dG5n
LWNvbnRleHQtdnBpZC5jIHwgMTIgLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0L2x0dG5nLWNvbnRleHQtdnBpZC5j
IGIvbGlibHR0bmctdXN0L2x0dG5nLWNvbnRleHQtdnBpZC5jCmluZGV4IDVlNWVkMTQuLjUzZmIz
MTQgMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC9sdHRuZy1jb250ZXh0LXZwaWQuYworKysgYi9s
aWJsdHRuZy11c3QvbHR0bmctY29udGV4dC12cGlkLmMKQEAgLTI3LDE3ICsyNyw2IEBACiAjaW5j
bHVkZSA8bHR0bmcvdXN0LXRyYWNlci5oPgogI2luY2x1ZGUgPGx0dG5nL3JpbmdidWZmZXItY29u
ZmlnLmg+CiAKLSNpZmRlZiBfX2xpbnV4X18KLXN0YXRpYyBpbmxpbmUKLXBpZF90IHdyYXBwZXJf
Z2V0cGlkKHZvaWQpCi17Ci0JcmV0dXJuIGdldHBpZCgpOwotfQotCi12b2lkIGx0dG5nX2NvbnRl
eHRfdnBpZF9yZXNldCh2b2lkKQotewotfQotI2Vsc2UKIC8qCiAgKiBXZSBjYWNoZSB0aGUgcmVz
dWx0IHRvIGVuc3VyZSB3ZSBkb24ndCB0cmlnZ2VyIGEgc3lzdGVtIGNhbGwgZm9yCiAgKiBlYWNo
IGV2ZW50LgpAQCAtNjAsNyArNDksNiBAQCB2b2lkIGx0dG5nX2NvbnRleHRfdnBpZF9yZXNldCh2
b2lkKQogewogCWNhY2hlZF92cGlkID0gMDsKIH0KLSNlbmRpZgogCiBzdGF0aWMKIHNpemVfdCB2
cGlkX2dldF9zaXplKHN0cnVjdCBsdHRuZ19jdHhfZmllbGQgKmZpZWxkLCBzaXplX3Qgb2Zmc2V0
KQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
