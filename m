From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 07/10] Fix: WARN() should print as
	WARN level, not ERR
Date: Wed, 18 May 2016 14:04:16 -0400
Message-ID: <1463594659-10964-8-git-send-email-mathieu.desnoyers__34402.1385805265$1463594701$gmane$org@efficios.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D77FAA35AE
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:04:31 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2Vycm9yLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2Vy
cm9yLmggYi9zcmMvY29tbW9uL2Vycm9yLmgKaW5kZXggY2E1YWY4Ni4uOWM5ZDJhNyAxMDA2NDQK
LS0tIGEvc3JjL2NvbW1vbi9lcnJvci5oCisrKyBiL3NyYy9jb21tb24vZXJyb3IuaApAQCAtMTAz
LDcgKzEwMyw3IEBAIGV4dGVybiBpbnQgbHR0bmdfb3B0X21pOwogI2RlZmluZSBFUlIoZm10LCBh
cmdzLi4uKSBcCiAJX19sdHRuZ19wcmludChQUklOVF9FUlIsICJFcnJvcjogIiBmbXQgIlxuIiwg
IyMgYXJncykKICNkZWZpbmUgV0FSTihmbXQsIGFyZ3MuLi4pIFwKLQlfX2x0dG5nX3ByaW50KFBS
SU5UX0VSUiwgIldhcm5pbmc6ICIgZm10ICJcbiIsICMjIGFyZ3MpCisJX19sdHRuZ19wcmludChQ
UklOVF9XQVJOLCAiV2FybmluZzogIiBmbXQgIlxuIiwgIyMgYXJncykKIAogI2RlZmluZSBCVUco
Zm10LCBhcmdzLi4uKSBfRVJSTVNHKCJCVUciLCBQUklOVF9CVUcsIGZtdCwgIyMgYXJncykKIAot
LSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
