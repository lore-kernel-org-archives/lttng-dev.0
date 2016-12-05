From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu 1/3] Fix: uatomic arm32: add missing
	release barrier before uatomic_xchg
Date: Mon,  5 Dec 2016 12:31:11 -0500
Message-ID: <1480959073-11973-1-git-send-email-mathieu.desnoyers__17686.1404827379$1480959457$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tXX6w3S4xztk3
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 17:38:48 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: rp@svcs.cs.pdx.edu, paulmck@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

X19zeW5jX2xvY2tfdGVzdF9hbmRfc2V0KCkgb25seSBpbXBseSBhIHJlbGVhc2UgYmFycmllciwg
YnV0CnVhdG9taWNfeGNoZygpIGd1YXJhbnRlZXMgYm90aCBhY3F1aXJlIGFuZCByZWxlYXNlIGJh
cnJpZXIgc2VtYW50aWNzLgpUaGVyZWZvcmUsIGFkZCB0aGUgbWlzc2luZyByZWxlYXNlIGJhcnJp
ZXIuCgpTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPgotLS0KIGluY2x1ZGUvdXJjdS91YXRvbWljL2FybS5oIHwgMTYgKysrKysr
KysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VyY3UvdWF0b21pYy9hcm0uaCBiL2luY2x1ZGUvdXJj
dS91YXRvbWljL2FybS5oCmluZGV4IGZkOGZlNmEuLjk1ZjMyZjMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvdXJjdS91YXRvbWljL2FybS5oCisrKyBiL2luY2x1ZGUvdXJjdS91YXRvbWljL2FybS5oCkBA
IC0yNiwxMyArMjYsMjcgQEAKIAogI2luY2x1ZGUgPHVyY3UvY29tcGlsZXIuaD4KICNpbmNsdWRl
IDx1cmN1L3N5c3RlbS5oPgorI2luY2x1ZGUgPHVyY3UvYXJjaC5oPgogCiAjaWZkZWYgX19jcGx1
c3BsdXMKIGV4dGVybiAiQyIgewogI2VuZGlmCiAKIC8qIHhjaGcgKi8KLSNkZWZpbmUgdWF0b21p
Y194Y2hnKGFkZHIsIHYpIF9fc3luY19sb2NrX3Rlc3RfYW5kX3NldChhZGRyLCB2KQorCisvKgor
ICogQmFzZWQgb24gWzFdLCBfX3N5bmNfbG9ja190ZXN0X2FuZF9zZXQoKSBpcyBub3QgYSBmdWxs
IGJhcnJpZXIsIGJ1dAorICogaW5zdGVhZCBvbmx5IGFuIGFjcXVpcmUgYmFycmllci4gR2l2ZW4g
dGhhdCB1YXRvbWljX3hjaGcoKSBhY3RzIGFzCisgKiBib3RoIHJlbGVhc2UgYW5kIGFjcXVpcmUg
YmFycmllcnMsIHdlIHRoZXJlZm9yZSBuZWVkIHRvIGhhdmUgb3VyIG93bgorICogcmVsZWFzZSBi
YXJyaWVyIGJlZm9yZSB0aGlzIG9wZXJhdGlvbi4KKyAqCisgKiBbMV0gaHR0cHM6Ly9nY2MuZ251
Lm9yZy9vbmxpbmVkb2NzL2djYy00LjEuMC9nY2MvQXRvbWljLUJ1aWx0aW5zLmh0bWwKKyAqLwor
I2RlZmluZSB1YXRvbWljX3hjaGcoYWRkciwgdikJCQkJXAorCSh7CQkJCQkJXAorCQljbW1fc21w
X21iKCk7CQkJCVwKKwkJX19zeW5jX2xvY2tfdGVzdF9hbmRfc2V0KGFkZHIsIHYpOwlcCisJfSkK
IAogI2lmZGVmIF9fY3BsdXNwbHVzCiB9Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
