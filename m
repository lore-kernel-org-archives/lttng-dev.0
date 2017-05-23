From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: update sched instrumentation
	for kernel 4.12
Date: Tue, 23 May 2017 15:45:18 -0400
Message-ID: <1495568718-29003-1-git-send-email-mjeanson__22818.21414731$1495568755$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXQyL2yK4zygm
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:46:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7291D340263
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:46:28 +0000 (UTC)
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

U2VlIHVwc3RyZWFtIGNvbW1pdCBiOTE0NzNmZjZlOTc5YzAwMjhmMDJmOTBlNDBjODQ0OTU5Yzcz
NmQ4CgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNv
bT4KLS0tCiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5oIHwgMjAg
KysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUvc2NoZWQuaCBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3NjaGVk
LmgKaW5kZXggZTUwNjZhZi4uYzY4ZGQyNyAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0
dG5nLW1vZHVsZS9zY2hlZC5oCkBAIC01NDAsNyArNTQwLDI1IEBAIExUVE5HX1RSQUNFUE9JTlRf
RVZFTlQoc2NoZWRfc3RhdF9ydW50aW1lLAogKQogI2VuZGlmCiAKLSNpZiAoTElOVVhfVkVSU0lP
Tl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDIsNiwzNykpCisjaWYgKExJTlVYX1ZFUlNJT05fQ09E
RSA+PSBLRVJORUxfVkVSU0lPTig0LDEyLDApKQorLyoKKyAqIFRyYWNlcG9pbnQgZm9yIHNob3dp
bmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9kaWZ5aW5nIGEgdGFza3MKKyAqIHByaW9yaXR5Lgor
ICovCitMVFROR19UUkFDRVBPSU5UX0VWRU5UKHNjaGVkX3BpX3NldHByaW8sCisKKwlUUF9QUk9U
TyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgc3RydWN0IHRhc2tfc3RydWN0ICpwaV90YXNrKSwK
KworCVRQX0FSR1ModHNrLCBwaV90YXNrKSwKKworCVRQX0ZJRUxEUygKKwkJY3RmX2FycmF5X3Rl
eHQoY2hhciwgY29tbSwgdHNrLT5jb21tLCBUQVNLX0NPTU1fTEVOKQorCQljdGZfaW50ZWdlcihw
aWRfdCwgdGlkLCB0c2stPnBpZCkKKwkJY3RmX2ludGVnZXIoaW50LCBvbGRwcmlvLCB0c2stPnBy
aW8gLSBNQVhfUlRfUFJJTykKKwkJY3RmX2ludGVnZXIoaW50LCBuZXdwcmlvLCBwaV90YXNrID8g
cGlfdGFzay0+cHJpbyAtIE1BWF9SVF9QUklPIDogdHNrLT5wcmlvIC0gTUFYX1JUX1BSSU8pCisJ
KQorKQorI2VsaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTigyLDYsMzcp
KQogLyoKICAqIFRyYWNlcG9pbnQgZm9yIHNob3dpbmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9k
aWZ5aW5nIGEgdGFza3MKICAqIHByaW9yaXR5LgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
