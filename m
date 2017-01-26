From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Lazily initialize max poll set
	size in poll compat
Date: Thu, 26 Jan 2017 14:36:45 -0500
Message-ID: <1485459405-24862-1-git-send-email-mjeanson__9960.05883575908$1485459440$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v8XLD2pvgzjqJ
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2017 19:39:32 +0000 (UTC)
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

VGhpcyB3YXMgYXBwbGllZCB0byB0aGUgZXBvbGwgaW1wbGVtZW50YXRpb24gaW4gY29tbWl0CjIy
ZGFkNTY4MTVjZTAyMDFjNWFlN2Q1ZWY1ZDc5Y2MwYzZhNDJjNWUKClNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29t
cGF0L2NvbXBhdC1wb2xsLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29tcGF0L2NvbXBh
dC1wb2xsLmMgYi9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtcG9sbC5jCmluZGV4IGNjMjgwYzcu
LjdkNGQwZTEgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24vY29tcGF0L2NvbXBhdC1wb2xsLmMKKysr
IGIvc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LXBvbGwuYwpAQCAtMTExLDggKzExMSw5IEBAIGlu
dCBjb21wYXRfcG9sbF9jcmVhdGUoc3RydWN0IGx0dG5nX3BvbGxfZXZlbnQgKmV2ZW50cywgaW50
IHNpemUpCiAJfQogCiAJaWYgKCFwb2xsX21heF9zaXplKSB7Ci0JCUVSUigicG9sbF9tYXhfc2l6
ZSBub3QgaW5pdGlhbGl6ZWQgeWV0Iik7Ci0JCWdvdG8gZXJyb3I7CisJCWlmIChsdHRuZ19wb2xs
X3NldF9tYXhfc2l6ZSgpKSB7CisJCQlnb3RvIGVycm9yOworCQl9CiAJfQogCiAJLyogRG9uJ3Qg
YnVzdCB0aGUgbGltaXQgaGVyZSAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
