From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unchecked return value in
	relayd live.c
Date: Tue, 17 May 2016 12:13:13 -0400
Message-ID: <1463501593-5871-1-git-send-email-mathieu.desnoyers__14554.3208848268$1463501621$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5E28EA3530
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 16:13:17 +0000 (UTC)
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

Q0lEIDEzMjMxMzcgKCMxIG9mIDEpOiBVbmNoZWNrZWQgcmV0dXJuIHZhbHVlIChDSEVDS0VEX1JF
VFVSTikzMC4KY2hlY2tfcmV0dXJuOiBDYWxsaW5nIHZpZXdlcl9zdHJlYW1fZ2V0IHdpdGhvdXQg
Y2hlY2tpbmcgcmV0dXJuIHZhbHVlCihhcyBpcyBkb25lIGVsc2V3aGVyZSA1IG91dCBvZiA2IHRp
bWVzKS4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVy
c0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIHwgNSArKysr
LQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlk
L2xpdmUuYwppbmRleCA4MmJkMmJkLi4wYTY2NDA1IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5n
LXJlbGF5ZC9saXZlLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCkBAIC0zMzks
NyArMzM5LDEwIEBAIGludCBtYWtlX3ZpZXdlcl9zdHJlYW1zKHN0cnVjdCByZWxheV9zZXNzaW9u
ICpzZXNzaW9uLAogCQkJCSAqIEVuc3VyZSBhIHNlbGYtcmVmZXJlbmNlIGlzIHByZXNlcnZlZCBl
dmVuCiAJCQkJICogYWZ0ZXIgd2UgaGF2ZSBwdXQgb3VyIGxvY2FsIHJlZmVyZW5jZS4KIAkJCQkg
Ki8KLQkJCQl2aWV3ZXJfc3RyZWFtX2dldCh2c3RyZWFtKTsKKwkJCQlpZiAoIXZpZXdlcl9zdHJl
YW1fZ2V0KHZzdHJlYW0pKSB7CisJCQkJCUVSUigiVW5hYmxlIHRvIGdldCBzZWxmLXJlZmVyZW5j
ZSBvbiB2aWV3ZXIgc3RyZWFtLCBsb2dpYyBlcnJvci4iKTsKKwkJCQkJYWJvcnQoKTsKKwkJCQl9
CiAJCQl9IGVsc2UgewogCQkJCWlmICghdnN0cmVhbS0+c2VudF9mbGFnICYmIG5iX3Vuc2VudCkg
ewogCQkJCQkvKiBVcGRhdGUgbnVtYmVyIG9mIHVuc2VudCBzdHJlYW0gY291bnRlci4gKi8KLS0g
CjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
