From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 09/24] Fix: illegal memory access in
	consumer_set_network_uri
Date: Mon, 16 May 2016 21:42:48 -0400
Message-ID: <1463449383-6553-10-git-send-email-mathieu.desnoyers__16212.1300156743$1463449426$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 70C41A350D
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:18 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDI5ICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpMzEuIGJ1ZmZlcl9zaXplX3dhcm5pbmc6
IENhbGxpbmcgc3RybmNweSB3aXRoIGEKbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDQwOTYgYnl0
ZXMgb24gZGVzdGluYXRpb24gYXJyYXkgb2JqLT5zdWJkaXIgb2YKc2l6ZSA0MDk2IGJ5dGVzIG1p
Z2h0IGxlYXZlIHRoZSBkZXN0aW5hdGlvbiBzdHJpbmcgdW50ZXJtaW5hdGVkLgoKU2lnbmVkLW9m
Zi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
LS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NvbnN1bWVyLmMgfCA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L2Jpbi9sdHRuZy1zZXNzaW9uZC9jb25zdW1lci5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9j
b25zdW1lci5jCmluZGV4IGJkMDE5ZGQuLmE4YzVmYjggMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvY29uc3VtZXIuYworKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NvbnN1
bWVyLmMKQEAgLTcxNSw3ICs3MTUsMTAgQEAgaW50IGNvbnN1bWVyX3NldF9uZXR3b3JrX3VyaShz
dHJ1Y3QgY29uc3VtZXJfb3V0cHV0ICpvYmosCiAJCQlnb3RvIGVycm9yOwogCQl9CiAKLQkJc3Ry
bmNweShvYmotPnN1YmRpciwgdG1wX3BhdGgsIHNpemVvZihvYmotPnN1YmRpcikpOworCQlpZiAo
bHR0bmdfc3RybmNweShvYmotPnN1YmRpciwgdG1wX3BhdGgsIHNpemVvZihvYmotPnN1YmRpcikp
KSB7CisJCQlyZXQgPSAtTFRUTkdfRVJSX0lOVkFMSUQ7CisJCQlnb3RvIGVycm9yOworCQl9CiAJ
CURCRzMoIkNvbnN1bWVyIHNldCBuZXR3b3JrIHVyaSBzdWJkaXIgcGF0aCAlcyIsIHRtcF9wYXRo
KTsKIAl9CiAKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
