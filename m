From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 14/24] Fix: illegal memory access in
	syscall_init_table
Date: Mon, 16 May 2016 21:42:53 -0400
Message-ID: <1463449383-6553-15-git-send-email-mathieu.desnoyers__13271.8015615412$1463449436$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D60A7A354B
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:20 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDIxICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpMjUuIGJ1ZmZlcl9zaXplX3dhcm5pbmc6
IENhbGxpbmcgc3RybmNweSB3aXRoIGEKbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDI1NSBieXRl
cyBvbiBkZXN0aW5hdGlvbiBhcnJheSAoc3lzY2FsbF90YWJsZSArCmluZGV4KS5uYW1lIG9mIHNp
emUgMjU1IGJ5dGVzIG1pZ2h0IGxlYXZlIHRoZSBkZXN0aW5hdGlvbiBzdHJpbmcKdW50ZXJtaW5h
dGVkLgoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYyB8IDcg
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYyBiL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5jCmluZGV4IDdhZTY2ODIuLjAyZmVjMTUgMTAwNjQ0Ci0t
LSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5jCisrKyBiL3NyYy9iaW4vbHR0bmct
c2Vzc2lvbmQvc3lzY2FsbC5jCkBAIC0xMDgsOCArMTA4LDExIEBAIGludCBzeXNjYWxsX2luaXRf
dGFibGUodm9pZCkKIAkJfQogCQlzeXNjYWxsX3RhYmxlW2luZGV4XS5pbmRleCA9IGluZGV4Owog
CQlzeXNjYWxsX3RhYmxlW2luZGV4XS5iaXRuZXNzID0gYml0bmVzczsKLQkJc3RybmNweShzeXNj
YWxsX3RhYmxlW2luZGV4XS5uYW1lLCBuYW1lLAotCQkJCXNpemVvZihzeXNjYWxsX3RhYmxlW2lu
ZGV4XS5uYW1lKSk7CisJCWlmIChsdHRuZ19zdHJuY3B5KHN5c2NhbGxfdGFibGVbaW5kZXhdLm5h
bWUsIG5hbWUsCisJCQkJc2l6ZW9mKHN5c2NhbGxfdGFibGVbaW5kZXhdLm5hbWUpKSkgeworCQkJ
cmV0ID0gLUVJTlZBTDsKKwkJCWdvdG8gZXJyb3I7CisJCX0KIAkJLyoKIAkJREJHKCJTeXNjYWxs
IG5hbWUgJyVzJyBhdCBpbmRleCAlIiBQUkl1MzIgIiBvZiBiaXRuZXNzICV1IiwKIAkJCQlzeXNj
YWxsX3RhYmxlW2luZGV4XS5uYW1lLAotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
