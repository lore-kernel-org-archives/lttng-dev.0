From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: Quote CMAKE variable assignment
	in Makefile
Date: Tue,  9 May 2017 16:55:44 -0400
Message-ID: <1494363344-16910-1-git-send-email-mjeanson__21116.3825974383$1494363360$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMs8l0QdTzsQ2
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 20:55:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1123A340374
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 20:55:50 +0000 (UTC)
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
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvYy9leGFtcGxlcy9N
YWtlZmlsZS5hbSBiL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQppbmRleCA5YzcyYWZhLi40OTNl
MDdkIDEwMDY0NAotLS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KKysrIGIvZG9jL2V4YW1w
bGVzL01ha2VmaWxlLmFtCkBAIC0xNDUsOCArMTQ1LDggQEAgYWxsLWxvY2FsOgogCQkJCWNkICQk
c3ViZGlyICYmIFwKIAkJCQkkKE1LRElSX1ApIGJ1aWxkICYmIFwKIAkJCQljZCBidWlsZCAmJiBc
Ci0JCQkJQ0M9JChDQykgXAotCQkJCUNYWD0kKENYWCkgXAorCQkJCUNDPSIkKENDKSIgXAorCQkJ
CUNYWD0iJChDWFgpIiBcCiAJCQkJY21ha2UgXAogCQkJCS1EQ01BS0VfSU5DTFVERV9QQVRIPSIk
KGFic190b3Bfc3JjZGlyKS9pbmNsdWRlOyQoYWJzX3RvcF9idWlsZGRpcikvaW5jbHVkZSIgXAog
CQkJCS1EQ01BS0VfTElCUkFSWV9QQVRIPSIkKGFic190b3BfYnVpbGRkaXIpL2xpYmx0dG5nLXVz
dC8ubGlicyIgXAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
