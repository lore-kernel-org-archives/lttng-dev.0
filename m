From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: consumerd main: needs to
	be a registered RCU thread
Date: Wed, 18 Jan 2017 19:23:27 -0500
Message-ID: <1484785407-28923-2-git-send-email-mathieu.desnoyers__12225.8113384762$1484785466$gmane$org@efficios.com>
References: <1484785407-28923-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v3l3z4j7Tzjt4
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jan 2017 00:25:35 +0000 (UTC)
In-Reply-To: <1484785407-28923-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

bWFpbi0+bHR0bmdfY29uc3VtZXJfZGVzdHJveS0+ZGVzdHJveV9kYXRhX3N0cmVhbV9odCByZXF1
aXJlcyBhIFJDVQpyZWFkLXNpZGUgbG9jay4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95
ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1j
b25zdW1lcmQvbHR0bmctY29uc3VtZXJkLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLWNvbnN1bWVyZC9sdHRuZy1j
b25zdW1lcmQuYyBiL3NyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZC5jCmlu
ZGV4IDdmNzhjNGUuLjJmOGVlZDEgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctY29uc3VtZXJk
L2x0dG5nLWNvbnN1bWVyZC5jCisrKyBiL3NyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNv
bnN1bWVyZC5jCkBAIC0zMDgsNiArMzA4LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogCXZvaWQgKnN0YXR1czsKIAlzdHJ1Y3QgbHR0bmdfY29uc3VtZXJfbG9jYWxfZGF0YSAq
dG1wX2N0eDsKIAorCXJjdV9yZWdpc3Rlcl90aHJlYWQoKTsKKwogCWlmIChzZXRfc2lnbmFsX2hh
bmRsZXIoKSkgewogCQlyZXR2YWwgPSAtMTsKIAkJZ290byBleGl0X3NldF9zaWduYWxfaGFuZGxl
cjsKQEAgLTY0Myw2ICs2NDUsOCBAQCBleGl0X2hlYWx0aF9jb25zdW1lcmRfY2xlYW51cDoKIGV4
aXRfb3B0aW9uczoKIGV4aXRfc2V0X3NpZ25hbF9oYW5kbGVyOgogCisJcmN1X3VucmVnaXN0ZXJf
dGhyZWFkKCk7CisKIAlpZiAoIXJldHZhbCkgewogCQlleGl0KEVYSVRfU1VDQ0VTUyk7CiAJfSBl
bHNlIHsKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
