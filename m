From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/2] Update: kvm instrumentation
	for fedora 4.14.13-300
Date: Tue, 20 Feb 2018 12:10:05 -0500
Message-ID: <1519146605-24297-2-git-send-email-mjeanson__8412.30219598419$1519146528$gmane$org@efficios.com>
References: <1519146605-24297-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zm6Yz3Zjjzqm7
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:10:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3B74241202F
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:10:15 -0500 (EST)
In-Reply-To: <1519146605-24297-1-git-send-email-mjeanson@efficios.com>
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

U3RhcnRpbmcgZnJvbSA0LjE0LjEzLTMwMCB0aGUgZmVkb3JhIGtlcm5lbCBiYWNrcG9ydCBhIGt2
bSBpbnN0cnVtZW50YXRpb24KY2hhbmdlIGludHJvZHVjZWQgaW4gNC4xNSB3aGljaCBhZmZlY3Rz
IHRoZSBwcm90b3R5cGUgb2YgdGhlIGt2bV9tbWlvIGV2ZW50LgoKU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogaW5zdHJ1bWVudGF0aW9u
L2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9l
dmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKaW5kZXggOWJiZjk1Zi4uNzZlYWE2OSAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTkxLDcgKzkxLDggQEAgTFRUTkdfVFJBQ0VQT0lO
VF9FVkVOVChrdm1fYWNrX2lycSwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoNCw0LDExMiwgNCw1
LDApIFwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoMywxNiw1MiwgMywxNywwKSBcCiAJfHwgTFRU
TkdfS0VSTkVMX1JBTkdFKDMsMiw5NywgMywzLDApIFwKLQl8fCBMVFROR19ERUJJQU5fS0VSTkVM
X1JBTkdFKDQsOSw2NSwwLDMsMCwgNCwxMCwwLDAsMCwwKSkKKwl8fCBMVFROR19ERUJJQU5fS0VS
TkVMX1JBTkdFKDQsOSw2NSwwLDMsMCwgNCwxMCwwLDAsMCwwKSBcCisJfHwgTFRUTkdfRkVET1JB
X0tFUk5FTF9SQU5HRSg0LDE0LDEzLDMwMCwgNCwxNSwwLDApKQogCiBMVFROR19UUkFDRVBPSU5U
X0VWRU5UKGt2bV9tbWlvLAogCVRQX1BST1RPKGludCB0eXBlLCBpbnQgbGVuLCB1NjQgZ3BhLCB2
b2lkICp2YWwpLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
