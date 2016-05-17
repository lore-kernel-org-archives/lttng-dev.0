From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 12/24] Fix: illegal memory access in
	list_lttng_channels
Date: Mon, 16 May 2016 21:42:51 -0400
Message-ID: <1463449383-6553-13-git-send-email-mathieu.desnoyers__9069.94303591109$1463449440$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 40BA1A3542
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:19 +0000 (UTC)
In-Reply-To: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDE4ICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpMTEuIGJ1ZmZlcl9zaXplX3dhcm5pbmc6
IENhbGxpbmcgc3RybmNweSB3aXRoIGEKbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDI1NiBieXRl
cyBvbiBkZXN0aW5hdGlvbiBhcnJheSAoY2hhbm5lbHMgKwppKS5uYW1lIG9mIHNpemUgMjU2IGJ5
dGVzIG1pZ2h0IGxlYXZlIHRoZSBkZXN0aW5hdGlvbiBzdHJpbmcKdW50ZXJtaW5hdGVkLgoKU2ln
bmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jIHwgNiArKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9z
cmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQu
YwppbmRleCA3ZjQ3ODE4Li5lNjZjOTlmIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Np
b25kL2NtZC5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKQEAgLTI3Nyw3ICsy
NzcsMTEgQEAgc3RhdGljIHZvaWQgbGlzdF9sdHRuZ19jaGFubmVscyhlbnVtIGx0dG5nX2RvbWFp
bl90eXBlIGRvbWFpbiwKIAkJCQkmaXRlci5pdGVyLCB1Y2hhbiwgbm9kZS5ub2RlKSB7CiAJCQl1
aW50NjRfdCBkaXNjYXJkZWRfZXZlbnRzID0gMCwgbG9zdF9wYWNrZXRzID0gMDsKIAotCQkJc3Ry
bmNweShjaGFubmVsc1tpXS5uYW1lLCB1Y2hhbi0+bmFtZSwgTFRUTkdfU1lNQk9MX05BTUVfTEVO
KTsKKwkJCWlmIChsdHRuZ19zdHJuY3B5KGNoYW5uZWxzW2ldLm5hbWUsIHVjaGFuLT5uYW1lLAor
CQkJCQlMVFROR19TWU1CT0xfTkFNRV9MRU4pKSB7CisJCQkJcmV0ID0gLTE7CisJCQkJYnJlYWs7
CisJCQl9CiAJCQljaGFubmVsc1tpXS5hdHRyLm92ZXJ3cml0ZSA9IHVjaGFuLT5hdHRyLm92ZXJ3
cml0ZTsKIAkJCWNoYW5uZWxzW2ldLmF0dHIuc3ViYnVmX3NpemUgPSB1Y2hhbi0+YXR0ci5zdWJi
dWZfc2l6ZTsKIAkJCWNoYW5uZWxzW2ldLmF0dHIubnVtX3N1YmJ1ZiA9IHVjaGFuLT5hdHRyLm51
bV9zdWJidWY7Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
