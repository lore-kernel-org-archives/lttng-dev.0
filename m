From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: Wrong sizeof argument in pid
	tracker
Date: Tue, 17 May 2016 09:23:50 -0400
Message-ID: <1463491430-21099-1-git-send-email-mathieu.desnoyers__32811.3844072961$1463491459$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0BE1AA350E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 13:23:57 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTI5MjU1NyAoIzEgb2YgMSk6IFdyb25nIHNpemVvZiBh
cmd1bWVudAooU0laRU9GX01JU01BVENIKXN1c3BpY2lvdXNfc2l6ZW9mOiBQYXNzaW5nIGFyZ3Vt
ZW50IDhVTCAvKiBzaXplb2YKKCpfcGlkX2xpc3QpICovIHRvIGZ1bmN0aW9uIHptYWxsb2MgYW5k
IHRoZW4gY2FzdGluZyB0aGUgcmV0dXJuIHZhbHVlIHRvCmludCAqIGlzIHN1c3BpY2lvdXMuCgpT
aWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvdHJhY2stdW50cmFjay5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy90cmFjay11bnRyYWNrLmMgYi9zcmMvYmluL2x0
dG5nL2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYwppbmRleCAzNzcxZGU1Li5kOWUxOGMxIDEwMDY0
NAotLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYworKysgYi9zcmMv
YmluL2x0dG5nL2NvbW1hbmRzL3RyYWNrLXVudHJhY2suYwpAQCAtODcsNyArODcsNyBAQCBpbnQg
cGFyc2VfcGlkX3N0cmluZyhjb25zdCBjaGFyICpfcGlkX3N0cmluZywKIAkJZ290byBlcnJvcjsK
IAl9CiAJaWYgKGFsbCkgewotCQlwaWRfbGlzdCA9IHptYWxsb2Moc2l6ZW9mKCpfcGlkX2xpc3Qp
KTsKKwkJcGlkX2xpc3QgPSB6bWFsbG9jKHNpemVvZigqcGlkX2xpc3QpKTsKIAkJaWYgKCFwaWRf
bGlzdCkgewogCQkJRVJSKCJPdXQgb2YgbWVtb3J5Iik7CiAJCQlyZXR2YWwgPSBDTURfRVJST1I7
Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
