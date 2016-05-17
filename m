From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: NULL pointer dereference in
	relay_index_get_by_id_or_create
Date: Tue, 17 May 2016 10:44:25 -0400
Message-ID: <1463496265-28682-1-git-send-email-mathieu.desnoyers__706.236277665262$1463496292$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 457B7A0117
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 14:44:30 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTMyMzEzNCAoIzEgb2YgMSk6IERlcmVmZXJlbmNlIGFm
dGVyIG51bGwgY2hlY2sgKEZPUldBUkRfTlVMTCkzNC4KdmFyX2RlcmVmX29wOiBEZXJlZmVyZW5j
aW5nIG51bGwgcG9pbnRlciBpbmRleC4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJz
IDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1yZWxh
eWQvaW5kZXguYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2luZGV4LmMgYi9zcmMv
YmluL2x0dG5nLXJlbGF5ZC9pbmRleC5jCmluZGV4IDljMzA3NzkuLjgwYTRiYjkgMTAwNjQ0Ci0t
LSBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2luZGV4LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxh
eWQvaW5kZXguYwpAQCAtMTYyLDcgKzE2Miw3IEBAIHN0cnVjdCByZWxheV9pbmRleCAqcmVsYXlf
aW5kZXhfZ2V0X2J5X2lkX29yX2NyZWF0ZShzdHJ1Y3QgcmVsYXlfc3RyZWFtICpzdHJlYW0sCiBl
bmQ6CiAJcmN1X3JlYWRfdW5sb2NrKCk7CiAJREJHMigiSW5kZXggJXNmb3VuZCBvciBjcmVhdGVk
IGluIEhUIGZvciBzdHJlYW0gSUQgJSIgUFJJdTY0ICIgYW5kIHNlcW51bSAlIiBQUkl1NjQsCi0J
CQkoaW5kZXggPT0gTlVMTCkgPyAiTk9UICIgOiAiIiwgaW5kZXgtPnN0cmVhbS0+c3RyZWFtX2hh
bmRsZSwgbmV0X3NlcV9udW0pOworCQkJKGluZGV4ID09IE5VTEwpID8gIk5PVCAiIDogIiIsIHN0
cmVhbS0+c3RyZWFtX2hhbmRsZSwgbmV0X3NlcV9udW0pOwogCXJldHVybiBpbmRleDsKIH0KIAot
LSAKMi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
