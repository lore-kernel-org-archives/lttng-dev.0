From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 2/2] Port: win32 DLLs don't support
	hidden symbols
Date: Thu, 26 Jan 2017 15:09:22 -0500
Message-ID: <1485461362-31301-2-git-send-email-mjeanson__46949.9326929965$1485461414$gmane$org@efficios.com>
References: <1485461362-31301-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v8Y440CNzzjw3
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2017 20:12:19 +0000 (UTC)
In-Reply-To: <1485461362-31301-1-git-send-email-mjeanson@efficios.com>
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogc3JjL2NvbW1vbi9tYWNyb3MuaCB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9tYWNy
b3MuaCBiL3NyYy9jb21tb24vbWFjcm9zLmgKaW5kZXggOGFlNjUzNS4uOTA4NDllZCAxMDA2NDQK
LS0tIGEvc3JjL2NvbW1vbi9tYWNyb3MuaAorKysgYi9zcmMvY29tbW9uL21hY3Jvcy5oCkBAIC03
NCw3ICs3NCwxNCBAQCB2b2lkICp6bWFsbG9jKHNpemVfdCBsZW4pCiAjZGVmaW5lIExUVE5HX1BB
Q0tFRCBfX2F0dHJpYnV0ZV9fKChfX3BhY2tlZF9fKSkKICNlbmRpZgogCi0jaWZuZGVmIExUVE5H
X0hJRERFTgorLyoKKyAqIExUVE5HX0hJRERFTjogc2V0IHRoZSBoaWRkZW4gYXR0cmlidXRlIGZv
ciBpbnRlcm5hbCBmdW5jdGlvbnMKKyAqIE9uIFdpbmRvd3MsIHN5bWJvbHMgYXJlIGxvY2FsIHVu
bGVzcyBleHBsaWNpdGx5IGV4cG9ydGVkLAorICogc2VlIGh0dHBzOi8vZ2NjLmdudS5vcmcvd2lr
aS9WaXNpYmlsaXR5CisgKi8KKyNpZiBkZWZpbmVkKF9XSU4zMikgfHwgZGVmaW5lZChfX0NZR1dJ
Tl9fKQorI2RlZmluZSBMVFROR19ISURERU4KKyNlbHNlCiAjZGVmaW5lIExUVE5HX0hJRERFTiBf
X2F0dHJpYnV0ZV9fKCh2aXNpYmlsaXR5KCJoaWRkZW4iKSkpCiAjZW5kaWYKIAotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
