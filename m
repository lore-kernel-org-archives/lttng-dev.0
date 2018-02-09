From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-tools v2 2/5] Fix: calling ht_{hash,
	match}_enum with wrong argument
Date: Fri,  9 Feb 2018 16:56:49 -0500
Message-ID: <1518213412-16593-3-git-send-email-francis.deslauriers__3178.45197064361$1518213342$gmane$org@efficios.com>
References: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
 <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zdTRv2ct9zpSw
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 21:56:59 +0000 (UTC)
In-Reply-To: <1518213412-16593-1-git-send-email-francis.deslauriers@efficios.com>
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

aHRfaGFzaF9lbnVtIGFuZCBodF9tYXRjaF9lbnVtIGFyZSBjdXJyZW50bHkgY2FsbGVkIHdpdGgg
dGhlIGFkZHJlc3Mgb2YgdGhlCnBvaW50ZXIgdG8gYSB1c3RfcmVnaXN0cnlfZW51bSByYXRoZXIg
dGhhbiB0aGUgZXhwZWN0ZWQgcG9pbnRlciB0byBhCnVzdF9yZWdpc3RyeV9lbnVtLiBUaGlzIG1l
YW5zIHRoYXQgdGhvc2UgZnVuY3Rpb24gY2FsbHMgd291bGQgZW5kIHVwCnVzaW5nIGdhcmJhZ2Ug
Zm9yIGhhc2hpbmcgYW5kIGNvbXBhcmluZy4KClNpZ25lZC1vZmYtYnk6IEZyYW5jaXMgRGVzbGF1
cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvdXN0LXJlZ2lzdHJ5LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC91c3QtcmVnaXN0cnkuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LXJlZ2lz
dHJ5LmMKaW5kZXggYTg3NTUxNS4uMTliZDMwZiAxMDA2NDQKLS0tIGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC91c3QtcmVnaXN0cnkuYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1y
ZWdpc3RyeS5jCkBAIC01NTgsOCArNTU4LDggQEAgc3RydWN0IHVzdF9yZWdpc3RyeV9lbnVtICoK
IAlzdHJ1Y3QgbHR0bmdfaHRfaXRlciBpdGVyOwogCiAJY2RzX2xmaHRfbG9va3VwKHNlc3Npb24t
PmVudW1zLT5odCwKLQkJCWh0X2hhc2hfZW51bSgodm9pZCAqKSAmcmVnX2VudW1fbG9va3VwLCBs
dHRuZ19odF9zZWVkKSwKLQkJCWh0X21hdGNoX2VudW0sICZyZWdfZW51bV9sb29rdXAsICZpdGVy
Lml0ZXIpOworCQkJaHRfaGFzaF9lbnVtKCh2b2lkICopIHJlZ19lbnVtX2xvb2t1cCwgbHR0bmdf
aHRfc2VlZCksCisJCQlodF9tYXRjaF9lbnVtLCByZWdfZW51bV9sb29rdXAsICZpdGVyLml0ZXIp
OwogCW5vZGUgPSBsdHRuZ19odF9pdGVyX2dldF9ub2RlX3N0cigmaXRlcik7CiAJaWYgKCFub2Rl
KSB7CiAJICAgICAgICBnb3RvIGVuZDsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
