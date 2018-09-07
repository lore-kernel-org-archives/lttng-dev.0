From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Skip closed session on viewer
	listing
Date: Fri,  7 Sep 2018 15:18:38 -0400
Message-ID: <20180907191838.17832-2-jonathan.rajotte-julien__22261.8190142841$1536347835$gmane$org@efficios.com>
References: <20180907191838.17832-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 426S0R1z7rzx3f
 for <lttng-dev@lists.lttng.org>; Fri,  7 Sep 2018 15:18:47 -0400 (EDT)
In-Reply-To: <20180907191838.17832-1-jonathan.rajotte-julien@efficios.com>
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

VGhlcmUgaXMgbm8gdmFsdWUgaW4gbGlzdGluZyBhIGNsb3NlZCBzZXNzaW9uLiBBIHZpZXdlciBj
YW5ub3QgaG9vayBpdHNlbGYKdG8gYSBjbG9zZWQgc2Vzc2lvbiBpbiBsaXZlIG1vZGUgYW5kIHRo
ZSBzZXNzaW9uIGlzIGFib3V0IHRvIGJlIHJlbW92ZWQgZnJvbSB0aGUKc2Vzc2lvbnMgaGFzaCB0
YWJsZS4KClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUt
anVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMgfCA1
ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3Jj
L2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCmlu
ZGV4IGJjMGU0NTI5YS4uMGZkNDFmMWE4IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXJlbGF5
ZC9saXZlLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCkBAIC04MzUsNiArODM1
LDExIEBAIGludCB2aWV3ZXJfbGlzdF9zZXNzaW9ucyhzdHJ1Y3QgcmVsYXlfY29ubmVjdGlvbiAq
Y29ubikKIAogCQloZWFsdGhfY29kZV91cGRhdGUoKTsKIAorCQlpZiAoc2Vzc2lvbi0+Y29ubmVj
dGlvbl9jbG9zZWQpIHsKKwkJCS8qIFNraXAgY2xvc2VkIHNlc3Npb24gKi8KKwkJCWNvbnRpbnVl
OworCQl9CisKIAkJaWYgKGNvdW50ID49IGJ1Zl9jb3VudCkgewogCQkJc3RydWN0IGx0dG5nX3Zp
ZXdlcl9zZXNzaW9uICpuZXdidWY7CiAJCQl1aW50MzJfdCBuZXdfYnVmX2NvdW50ID0gYnVmX2Nv
dW50IDw8IDE7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
