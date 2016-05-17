From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: insecure data handling
Date: Mon, 16 May 2016 23:36:09 -0400
Message-ID: <1463456169-12405-1-git-send-email-mathieu.desnoyers__6451.29245608604$1463456199$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EE4D5A350E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 03:36:15 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTM1MzQ2MiAoIzEgb2YgMSk6IFVzZSBvZiB1bnRydXN0
ZWQgc3RyaW5nIHZhbHVlIChUQUlOVEVEX1NUUklORyk1Lgp0YWludGVkX3N0cmluZzogUGFzc2lu
ZyB0YWludGVkIHN0cmluZyBtYW5fYmluX3BhdGggdG8gZXhlY2xwLCB3aGljaApjYW5ub3QgYWNj
ZXB0IHRhaW50ZWQgZGF0YS4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2NvbW1vbi91dGlscy5jIHwgMyAr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9zcmMvY29tbW9uL3V0aWxzLmMgYi9zcmMvY29tbW9uL3V0aWxzLmMKaW5kZXggZGY1
NWRjOS4uYjZiNDVlMyAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi91dGlscy5jCisrKyBiL3NyYy9j
b21tb24vdXRpbHMuYwpAQCAtMTM0Nyw3ICsxMzQ3LDggQEAgZW5kOgogCiBzdGF0aWMgY29uc3Qg
Y2hhciAqZ2V0X21hbl9iaW5fcGF0aCh2b2lkKQogewotCWNoYXIgKmVudl9tYW5fcGF0aCA9IGdl
dGVudihERUZBVUxUX01BTl9CSU5fUEFUSF9FTlYpOworCWNoYXIgKmVudl9tYW5fcGF0aCA9CisJ
CWx0dG5nX3NlY3VyZV9nZXRlbnYoREVGQVVMVF9NQU5fQklOX1BBVEhfRU5WKTsKIAogCWlmIChl
bnZfbWFuX3BhdGgpIHsKIAkJcmV0dXJuIGVudl9tYW5fcGF0aDsKLS0gCjIuMS40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
