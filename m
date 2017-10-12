From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: close channel monitor pipe
	after killing the metadata_timer_thread
Date: Thu, 12 Oct 2017 11:19:39 -0400
Message-ID: <20171012151939.1534-1-jonathan.rajotte-julien__18414.6332824186$1507821608$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3yCZK733llz10H4
 for <lttng-dev@lists.lttng.org>; Thu, 12 Oct 2017 15:19:55 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVy
ZC5jIHwgMTUgKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0
dG5nLWNvbnN1bWVyZC5jIGIvc3JjL2Jpbi9sdHRuZy1jb25zdW1lcmQvbHR0bmctY29uc3VtZXJk
LmMKaW5kZXggZmVmMDNjNmYuLmMwNzE2YWYyIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLWNv
bnN1bWVyZC9sdHRuZy1jb25zdW1lcmQuYworKysgYi9zcmMvYmluL2x0dG5nLWNvbnN1bWVyZC9s
dHRuZy1jb25zdW1lcmQuYwpAQCAtNTc2LDE0ICs1NzYsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCiAJCVBFUlJPUigicHRocmVhZF9qb2luIHNlc3Npb25kX3RocmVhZCIpOwog
CQlyZXR2YWwgPSAtMTsKIAl9Ci0KLQlyZXQgPSBjb25zdW1lcl90aW1lcl90aHJlYWRfZ2V0X2No
YW5uZWxfbW9uaXRvcl9waXBlKCk7Ci0JaWYgKHJldCA+PSAwKSB7Ci0JCXJldCA9IGNsb3NlKHJl
dCk7Ci0JCWlmIChyZXQpIHsKLQkJCVBFUlJPUigiY2xvc2UgY2hhbm5lbCBtb25pdG9yIHBpcGUi
KTsKLQkJfQotCX0KIGV4aXRfc2Vzc2lvbmRfdGhyZWFkOgogCiAJcmV0ID0gcHRocmVhZF9qb2lu
KGRhdGFfdGhyZWFkLCAmc3RhdHVzKTsKQEAgLTY1MCw2ICs2NDIsMTMgQEAgZXhpdF9pbml0X2Rh
dGE6CiAJCQlQRVJST1IoInB0aHJlYWRfam9pbiBtZXRhZGF0YV90aW1lcl90aHJlYWQiKTsKIAkJ
CXJldHZhbCA9IC0xOwogCQl9CisJCXJldCA9IGNvbnN1bWVyX3RpbWVyX3RocmVhZF9nZXRfY2hh
bm5lbF9tb25pdG9yX3BpcGUoKTsKKwkJaWYgKHJldCA+PSAwKSB7CisJCQlyZXQgPSBjbG9zZShy
ZXQpOworCQkJaWYgKHJldCkgeworCQkJCVBFUlJPUigiY2xvc2UgY2hhbm5lbCBtb25pdG9yIHBp
cGUiKTsKKwkJCX0KKwkJfQogCQltZXRhZGF0YV90aW1lcl90aHJlYWRfb25saW5lID0gZmFsc2U7
CiAJfQogCXRtcF9jdHggPSBjdHg7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
