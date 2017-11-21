From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: specify SONAME in
	python-lttngust LoadLibrary
Date: Tue, 21 Nov 2017 11:11:15 -0500
Message-ID: <1511280675-28375-1-git-send-email-mjeanson__5587.83605597473$1511280703$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yh9Z41KQnzhkB
 for <lttng-dev@lists.lttng.org>; Tue, 21 Nov 2017 16:11:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 87BA8340321
 for <lttng-dev@lists.lttng.org>; Tue, 21 Nov 2017 16:12:27 +0000 (UTC)
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

V2hlbiBsb2FkaW5nIHRoZSBweXRob24gYWdlbnQgbGlicmFyeSB3aXRoIGN0eXBlcyBpbiB0aGUg
cHl0aG9uCmJpbmRpbmdzLCBzcGVjaWZ5IHRoZSBTT05BTUUuIFRoaXMgd2lsbCBtYWtlIHN1cmUg
d2UgbG9hZCB0aGUgcHJvcGVyCmxpYnJhcnkgaW4gdGhlIGV2ZW50IG9mIGEgU09OQU1FIGJ1bXAg
YW5kIHRoZSBiaW5kaW5ncyB3aWxsIHdvcmsgd2l0aG91dApoYXZpbmcgdG8gaW5zdGFsbCB0aGUg
ImRldiIgcGFja2FnZSB3aGljaCBpbiBtb3N0IGRpc3Ryb3MgY29udGFpbnMgdGhlCm5vbi12ZXJz
aW9ubmVkICIuc28iLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBl
ZmZpY2lvcy5jb20+Ci0tLQogcHl0aG9uLWx0dG5ndXN0L2x0dG5ndXN0L2xvZ2hhbmRsZXIucHkg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9weXRob24tbHR0bmd1c3QvbHR0bmd1c3QvbG9naGFuZGxlci5weSBiL3B5dGhv
bi1sdHRuZ3VzdC9sdHRuZ3VzdC9sb2doYW5kbGVyLnB5CmluZGV4IGU4MmNmNWMuLjZmMTQ0Y2Eg
MTAwNjQ0Ci0tLSBhL3B5dGhvbi1sdHRuZ3VzdC9sdHRuZ3VzdC9sb2doYW5kbGVyLnB5CisrKyBi
L3B5dGhvbi1sdHRuZ3VzdC9sdHRuZ3VzdC9sb2doYW5kbGVyLnB5CkBAIC0yMiw3ICsyMiw3IEBA
IGltcG9ydCBjdHlwZXMKIAogCiBjbGFzcyBfSGFuZGxlcihsb2dnaW5nLkhhbmRsZXIpOgotICAg
IF9MSUJfTkFNRSA9ICdsaWJsdHRuZy11c3QtcHl0aG9uLWFnZW50LnNvJworICAgIF9MSUJfTkFN
RSA9ICdsaWJsdHRuZy11c3QtcHl0aG9uLWFnZW50LnNvLjAnCiAKICAgICBkZWYgX19pbml0X18o
c2VsZik6CiAgICAgICAgIHN1cGVyKHNlbGYuX19jbGFzc19fLCBzZWxmKS5fX2luaXRfXyhsZXZl
bD1sb2dnaW5nLk5PVFNFVCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
