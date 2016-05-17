From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 15/24] Fix: illegal memory access in
	consumer_set_subdir
Date: Mon, 16 May 2016 21:42:54 -0400
Message-ID: <1463449383-6553-16-git-send-email-mathieu.desnoyers__14277.0285289318$1463449440$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B11AEA354E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:22 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDE1ICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpOC4gYnVmZmVyX3NpemVfd2FybmluZzog
Q2FsbGluZyBzdHJuY3B5IHdpdGggYQptYXhpbXVtIHNpemUgYXJndW1lbnQgb2YgNDA5NiBieXRl
cyBvbiBkZXN0aW5hdGlvbiBhcnJheQpjb25zdW1lci0+c3ViZGlyIG9mIHNpemUgNDA5NiBieXRl
cyBtaWdodCBsZWF2ZSB0aGUgZGVzdGluYXRpb24gc3RyaW5nCnVudGVybWluYXRlZC4KClNpZ25l
ZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jb25zdW1lci5jIHwgNiArKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NvbnN1bWVyLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Np
b25kL2NvbnN1bWVyLmMKaW5kZXggYThjNWZiOC4uZTllNDMwZSAxMDA2NDQKLS0tIGEvc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC9jb25zdW1lci5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
Y29uc3VtZXIuYwpAQCAtMTA4OSw3ICsxMDg5LDExIEBAIGludCBjb25zdW1lcl9zZXRfc3ViZGly
KHN0cnVjdCBjb25zdW1lcl9vdXRwdXQgKmNvbnN1bWVyLAogCQlnb3RvIGVycm9yOwogCX0KIAot
CXN0cm5jcHkoY29uc3VtZXItPnN1YmRpciwgdG1wX3BhdGgsIHNpemVvZihjb25zdW1lci0+c3Vi
ZGlyKSk7CisJaWYgKGx0dG5nX3N0cm5jcHkoY29uc3VtZXItPnN1YmRpciwgdG1wX3BhdGgsCisJ
CQlzaXplb2YoY29uc3VtZXItPnN1YmRpcikpKSB7CisJCXJldCA9IC0xOworCQlnb3RvIGVycm9y
OworCX0KIAlEQkcyKCJDb25zdW1lciBzdWJkaXIgc2V0IHRvICVzIiwgY29uc3VtZXItPnN1YmRp
cik7CiAKIGVycm9yOgotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
