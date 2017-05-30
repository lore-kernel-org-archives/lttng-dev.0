From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: Build ftrace probe on
	kernels prior to 4.12
Date: Tue, 30 May 2017 09:36:31 -0400
Message-ID: <1496151391-26076-1-git-send-email-francis.deslauriers__10339.1927936629$1496151417$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wcZRj15n0z128K
 for <lttng-dev@lists.lttng.org>; Tue, 30 May 2017 13:37:52 +0000 (UTC)
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
ZmZpY2lvcy5jb20+Ci0tLQogcHJvYmVzL0tidWlsZCB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcHJvYmVzL0ti
dWlsZCBiL3Byb2Jlcy9LYnVpbGQKaW5kZXggZmU4NjlkMC4uNzhiZjNmYiAxMDA2NDQKLS0tIGEv
cHJvYmVzL0tidWlsZAorKysgYi9wcm9iZXMvS2J1aWxkCkBAIC0yNjcsOCArMjY3LDkgQEAgaWZu
ZXEgKCQoQ09ORklHX0RZTkFNSUNfRlRSQUNFKSwpCiAgICAgICAgIGVjaG8gIndhcm4iIDsgXAog
ICAgICAgICBleGl0IDsgXAogICAgICAgZmk7IFwKLSAgICAgIGVjaG8gImx0dG5nLWZ0cmFjZS5v
IiA7IFwKLSAgICBmaTspCisgICAgZmk7IFwKKyAgICBlY2hvICJsdHRuZy1mdHJhY2UubyIgOyBc
CisgICAgKQogICBpZmVxICgkKGZ0cmFjZSksd2FybikKICAgICAkKHdhcm5pbmcgRmlsZXMgJChm
dHJhY2VfZGVwKSBub3QgZm91bmQuIFByb2JlICJmdHJhY2UiIGlzIGRpc2FibGVkLiBVc2UgZnVs
bCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0LikKICAgICBmdHJhY2UgPQotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
