From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 04/10] Fix: ust-consumer: flush
	empty packets on snapshot channel
Date: Wed, 18 May 2016 14:04:13 -0400
Message-ID: <1463594659-10964-5-git-send-email-mathieu.desnoyers__40686.5180739716$1463594682$gmane$org@efficios.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 53148A359B
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:04:27 +0000 (UTC)
In-Reply-To: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
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

U25hcHNob3Qgb3BlcmF0aW9uIG9uIGEgbm9uLXN0b3BwZWQgc3RyZWFtIHNob3VsZCB1c2UgYSAi
ZmluYWwiIGZsdXNoIHRvCmVuc3VyZSBlbXB0eSBwYWNrZXRzIGFyZSBmbHVzaGVkLCBzbyB3ZSBn
YXRoZXIgdGltZXN0YW1wcyBhdCB0aGUgbW9tZW50CndoZXJlIHRoZSBzbmFwc2hvdCBpcyB0YWtl
bi4gVGhpcyBpcyBpbXBvcnRhbnQgZm9yIHN0cmVhbXMgdGhhdCBoYXZlIGEKbG93IGFtb3VudCBv
ZiBhY3Rpdml0eSwgd2hpY2ggbWlnaHQgYmUgb24gYW4gZW1wdHkgcGFja2V0IHdoZW4gdGhlCnNu
YXBzaG90IGlzIHRyaWdnZXJlZC4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi91c3QtY29uc3Vt
ZXIvdXN0LWNvbnN1bWVyLmMgfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi91c3QtY29uc3Vt
ZXIvdXN0LWNvbnN1bWVyLmMgYi9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91c3QtY29uc3VtZXIu
YwppbmRleCA5MWZmZGNlLi5jNjMxOTA0IDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL3VzdC1jb25z
dW1lci91c3QtY29uc3VtZXIuYworKysgYi9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91c3QtY29u
c3VtZXIuYwpAQCAtMTExMSw3ICsxMTExLDEzIEBAIHN0YXRpYyBpbnQgc25hcHNob3RfY2hhbm5l
bCh1aW50NjRfdCBrZXksIGNoYXIgKnBhdGgsIHVpbnQ2NF90IHJlbGF5ZF9pZCwKIAkJCX0KIAkJ
fQogCi0JCXVzdGN0bF9mbHVzaF9idWZmZXIoc3RyZWFtLT51c3RyZWFtLCAxKTsKKwkJLyoKKwkJ
ICogSWYgdHJhY2luZyBpcyBhY3RpdmUsIHdlIHdhbnQgdG8gcGVyZm9ybSBhICJmdWxsIiBidWZm
ZXIgZmx1c2guCisJCSAqIEVsc2UsIGlmIHF1aWVzY2VudCwgaXQgaGFzIGFscmVhZHkgYmVlbiBk
b25lIGJ5IHRoZSBwcmlvciBzdG9wLgorCQkgKi8KKwkJaWYgKCFzdHJlYW0tPnF1aWVzY2VudCkg
eworCQkJdXN0Y3RsX2ZsdXNoX2J1ZmZlcihzdHJlYW0tPnVzdHJlYW0sIDApOworCQl9CiAKIAkJ
cmV0ID0gbHR0bmdfdXN0Y29uc3VtZXJfdGFrZV9zbmFwc2hvdChzdHJlYW0pOwogCQlpZiAocmV0
IDwgMCkgewotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
