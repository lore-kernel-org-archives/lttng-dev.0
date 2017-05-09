From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: COMPAT_EPOLL_PROC_PATH is
	available from Linux 2.6.28
Date: Tue,  9 May 2017 14:17:10 -0400
Message-ID: <20170509181710.14026-1-jonathan.rajotte-julien__17044.6228272796$1494353860$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMnf41Z90zrhW
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 18:17:31 +0000 (UTC)
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

RmFpbGluZyBvbiBvcGVuaW5nIFsxXSBpcyBub3QgYW4gZXJyb3IgcGVyIHNlZS4gWzFdIHdhcwpp
bnRyb2R1Y2VkIGluIExpbnV4IDIuNi4yOCBidXQgZXBvbGwgaXMgYXZhaWxhYmxlIHNpbmNlCjIu
NS40NC4gSGVuY2UsIGdvdG8gZW5kIGFuZCBzZXQgYSBkZWZhdWx0IHZhbHVlIHdpdGhvdXQKc2V0
dGluZyBlcnJvciByZXR1cm4gdmFsdWUuCgpbMV0gL3Byb2Mvc3lzL2ZzL2Vwb2xsL21heF91c2Vy
X3dhdGNoZXMKClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90
dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtZXBv
bGwuYyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtZXBvbGwu
YyBiL3NyYy9jb21tb24vY29tcGF0L2NvbXBhdC1lcG9sbC5jCmluZGV4IGRiYWY2ODIzLi42YTc4
MWM3YSAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMKKysrIGIv
c3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMKQEAgLTMwMSw3ICszMDEsMTUgQEAgaW50
IGNvbXBhdF9lcG9sbF9zZXRfbWF4X3NpemUodm9pZCkKIAogCWZkID0gb3BlbihDT01QQVRfRVBP
TExfUFJPQ19QQVRILCBPX1JET05MWSk7CiAJaWYgKGZkIDwgMCkgewotCQlyZXR2YWwgPSAtMTsK
KwkJLyoKKwkJICogRmFpbGluZyBvbiBvcGVuaW5nIFsxXSBpcyBub3QgYW4gZXJyb3IgcGVyIHNl
ZS4gWzFdIHdhcworCQkgKiBpbnRyb2R1Y2VkIGluIExpbnV4IDIuNi4yOCBidXQgZXBvbGwgaXMg
YXZhaWxhYmxlIHNpbmNlCisJCSAqIDIuNS40NC4gSGVuY2UsIGdvdG8gZW5kIGFuZCBzZXQgYSBk
ZWZhdWx0IHZhbHVlIHdpdGhvdXQKKwkJICogc2V0dGluZyBhbiBlcnJvciByZXR1cm4gdmFsdWUu
CisJCSAqCisJCSAqIFsxXSAvcHJvYy9zeXMvZnMvZXBvbGwvbWF4X3VzZXJfd2F0Y2hlcworCQkg
Ki8KKwkJcmV0dmFsID0gMDsKIAkJZ290byBlbmQ7CiAJfQogCi0tIAoyLjExLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
