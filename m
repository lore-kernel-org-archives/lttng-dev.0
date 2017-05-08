From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: return NULL pointer on memory
	allocation failure
Date: Mon,  8 May 2017 07:48:52 -0400
Message-ID: <1494244132-10812-1-git-send-email-mathieu.desnoyers__38133.7338862524$1494244156$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wM15C2JSdzD7B
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 11:49:50 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2J1ZmZlci11c2FnZS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Nv
bW1vbi9idWZmZXItdXNhZ2UuYyBiL3NyYy9jb21tb24vYnVmZmVyLXVzYWdlLmMKaW5kZXggNDk2
OTZhMy4uZGZlMGQ4NSAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9idWZmZXItdXNhZ2UuYworKysg
Yi9zcmMvY29tbW9uL2J1ZmZlci11c2FnZS5jCkBAIC0yMzEsNyArMjMxLDcgQEAgc3RydWN0IGx0
dG5nX2NvbmRpdGlvbiAqbHR0bmdfY29uZGl0aW9uX2J1ZmZlcl91c2FnZV9jcmVhdGUoCiAKIAlj
b25kaXRpb24gPSB6bWFsbG9jKHNpemVvZihzdHJ1Y3QgbHR0bmdfY29uZGl0aW9uX2J1ZmZlcl91
c2FnZSkpOwogCWlmICghY29uZGl0aW9uKSB7Ci0JCWdvdG8gZW5kOworCQlyZXR1cm4gTlVMTDsK
IAl9CiAKIAlsdHRuZ19jb25kaXRpb25faW5pdCgmY29uZGl0aW9uLT5wYXJlbnQsIHR5cGUpOwot
LSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
