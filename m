From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: use
	LTTNG_VIEWER_ATTACH_UNK to report a closed session
Date: Fri,  7 Sep 2018 15:18:37 -0400
Message-ID: <20180907191838.17832-1-jonathan.rajotte-julien__13813.8885995888$1536347810$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 426S0Q3m9mzx3c
 for <lttng-dev@lists.lttng.org>; Fri,  7 Sep 2018 15:18:46 -0400 (EDT)
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

TFRUTkdfVklFV0VSX05FV19TVFJFQU1TX0hVUCBpcyBub3QgYSB2YWxpZCBlcnJvciBudW1iZXIg
Zm9yIHRoZQpMVFROR19WSUVXRVJfQVRUQUNIX1NFU1NJT04gY29tbWFuZC4gVGhpcyByZXN1bHQg
aW4gZXJyb25lb3VzIGVycm9yCnJlcG9ydGluZyBvbiB0aGUgY2xpZW50IHNpZGUuCgpTaWduZWQt
b2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lv
cy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy1yZWxheWQvbGl2ZS5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCmluZGV4
IDZmNTBhZmM2Yy4uYmMwZTQ1MjlhIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9s
aXZlLmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCkBAIC0xMDg5LDcgKzEwODks
NyBAQCBpbnQgdmlld2VyX2F0dGFjaF9zZXNzaW9uKHN0cnVjdCByZWxheV9jb25uZWN0aW9uICpj
b25uKQogCWlmIChjbG9zZWQpIHsKIAkJc2VuZF9zdHJlYW1zID0gMDsKIAkJcmVzcG9uc2Uuc3Ry
ZWFtc19jb3VudCA9IDA7Ci0JCXJlc3BvbnNlLnN0YXR1cyA9IGh0b2JlMzIoTFRUTkdfVklFV0VS
X05FV19TVFJFQU1TX0hVUCk7CisJCXJlc3BvbnNlLnN0YXR1cyA9IGh0b2JlMzIoTFRUTkdfVklF
V0VSX0FUVEFDSF9VTkspOwogCQlnb3RvIHNlbmRfcmVwbHk7CiAJfQogCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
