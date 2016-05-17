From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unchecked return value in low
	throughput test
Date: Tue, 17 May 2016 12:22:44 -0400
Message-ID: <1463502164-11198-1-git-send-email-mathieu.desnoyers__31479.8503801741$1463502200$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2119FA3525
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 16:22:49 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTAxOTk2NyAoIzEgb2YgMSk6IFVuY2hlY2tlZCByZXR1
cm4gdmFsdWUgZnJvbSBsaWJyYXJ5CihDSEVDS0VEX1JFVFVSTikyLiBjaGVja19yZXR1cm46IENh
bGxpbmcgcG9sbChOVUxMLCAwVUwsIDYwMDAwKSB3aXRob3V0CmNoZWNraW5nIHJldHVybiB2YWx1
ZS4gVGhpcyBsaWJyYXJ5IGZ1bmN0aW9uIG1heSBmYWlsIGFuZCByZXR1cm4gYW4KZXJyb3IgY29k
ZS4KCldlIHJlYWxseSBkb24ndCBjYXJlIHdoZXRoZXIgdGhpcyBwb2xsIHN1Y2NlZWRzIG9yIG5v
dC4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvcmVncmVzc2lvbi91c3QvbG93LXRocm91Z2hwdXQvbWFp
bi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvcmVncmVzc2lvbi91c3QvbG93LXRocm91Z2hwdXQvbWFpbi5j
IGIvdGVzdHMvcmVncmVzc2lvbi91c3QvbG93LXRocm91Z2hwdXQvbWFpbi5jCmluZGV4IDA2YWI5
ZWYuLmIxYzM4YmMgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L2xvdy10aHJvdWdo
cHV0L21haW4uYworKysgYi90ZXN0cy9yZWdyZXNzaW9uL3VzdC9sb3ctdGhyb3VnaHB1dC9tYWlu
LmMKQEAgLTM0LDcgKzM0LDcgQEAgc3RhdGljIHZvaWQgKnRoX2V2ZW50X21pbnV0ZSh2b2lkICpk
YXRhKQogCS8qIExvb3AgZm9yIDIwIG1pbnV0ZXMgKi8KIAlmb3IgKGkgPSAxOyBpIDwgMjE7IGkr
KykgewogCQkvKiBTbGVlcCA2MCBzZWNvbmRzICovCi0JCXBvbGwoTlVMTCwgMCwgNjAwMDApOwor
CQkodm9pZCkgcG9sbChOVUxMLCAwLCA2MDAwMCk7CiAKIAkJLyogMjAgbWludXRlcyB0cmFjZXBv
aW50ICovCiAJCWlmICgoaSAlIDIwKSA9PSAwKSB7Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
