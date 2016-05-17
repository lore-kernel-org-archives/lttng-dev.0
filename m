From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 06/24] Fix: illegal memory access in
	disable_event
Date: Mon, 16 May 2016 21:42:45 -0400
Message-ID: <1463449383-6553-7-git-send-email-mathieu.desnoyers__7154.47488842091$1463449422$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DC121A3523
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:14 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CkNJRCAxMjQzMDE2ICgjMSBvZiAxKTogQnVmZmVyIG5vdCBudWxs
IHRlcm1pbmF0ZWQKKEJVRkZFUl9TSVpFX1dBUk5JTkcpMTQuIGJ1ZmZlcl9zaXplX3dhcm5pbmc6
IENhbGxpbmcgc3RybmNweSB3aXRoIGEKbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDI1NiBieXRl
cyBvbiBkZXN0aW5hdGlvbiBhcnJheSBtc2cubmFtZSBvZiBzaXplCjI1NiBieXRlcyBtaWdodCBs
ZWF2ZSB0aGUgZGVzdGluYXRpb24gc3RyaW5nIHVudGVybWluYXRlZC4KClNpZ25lZC1vZmYtYnk6
IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQog
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9hZ2VudC5jIHwgNyArKysrKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvYWdlbnQuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvYWdlbnQuYwpp
bmRleCBmNzlhYzAwLi42ODQxZDQxIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25k
L2FnZW50LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9hZ2VudC5jCkBAIC01OTQsMTQg
KzU5NCwxNyBAQCBzdGF0aWMgaW50IGRpc2FibGVfZXZlbnQoc3RydWN0IGFnZW50X2FwcCAqYXBw
LCBzdHJ1Y3QgYWdlbnRfZXZlbnQgKmV2ZW50KQogCQkJYXBwLT5waWQsIGFwcC0+c29jay0+ZmQp
OwogCiAJZGF0YV9zaXplID0gc2l6ZW9mKG1zZyk7CisJbWVtc2V0KCZtc2csIDAsIHNpemVvZiht
c2cpKTsKKwlpZiAobHR0bmdfc3RybmNweShtc2cubmFtZSwgZXZlbnQtPm5hbWUsIHNpemVvZiht
c2cubmFtZSkpKSB7CisJCXJldCA9IExUVE5HX0VSUl9JTlZBTElEOworCQlnb3RvIGVycm9yOwor
CX0KIAogCXJldCA9IHNlbmRfaGVhZGVyKGFwcC0+c29jaywgZGF0YV9zaXplLCBBR0VOVF9DTURf
RElTQUJMRSwgMCk7CiAJaWYgKHJldCA8IDApIHsKIAkJZ290byBlcnJvcl9pbzsKIAl9CiAKLQlt
ZW1zZXQoJm1zZywgMCwgc2l6ZW9mKG1zZykpOwotCXN0cm5jcHkobXNnLm5hbWUsIGV2ZW50LT5u
YW1lLCBzaXplb2YobXNnLm5hbWUpKTsKIAlyZXQgPSBzZW5kX3BheWxvYWQoYXBwLT5zb2NrLCAm
bXNnLCBzaXplb2YobXNnKSk7CiAJaWYgKHJldCA8IDApIHsKIAkJZ290byBlcnJvcl9pbzsKLS0g
CjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
