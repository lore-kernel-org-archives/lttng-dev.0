From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5] Fix: use LDFLAGS instead
	of LIBS for python bindings
Date: Fri,  2 Jun 2017 11:56:44 -0400
Message-ID: <1496419004-6922-1-git-send-email-mjeanson__46406.7900473767$1496419632$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wfTQM37myz11n2
 for <lttng-dev@lists.lttng.org>; Fri,  2 Jun 2017 15:58:19 +0000 (UTC)
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

VHVybnMgb3V0IHRoYXQgY29udHJhcnkgdG8gd2hhdCBpcyBkb2N1bWVudGVkIHNvbWUgdmVyc2lv
bnMgb2YgZGlzdHV0aWxzCmRvbid0IGhvbm9yIHRoZSBMSUJTIHZhcmlhYmxlLCB1c2UgTERGTEFH
UyBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZp
Y2lvcy5jb20+Ci0tLQogYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtIHwgMyArLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9i
aW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gYi9iaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0K
aW5kZXggZjY4MDZhOC4uMmNlYWIwMyAxMDA2NDQKLS0tIGEvYmluZGluZ3MvcHl0aG9uL01ha2Vm
aWxlLmFtCisrKyBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbQpAQCAtMjUsOCArMjUsNyBA
QCBCSU5ESU5HU19ERVBTPXNldHVwLnB5IFwKIEJVSUxEX0ZMQUdTPUNDPSIkKENDKSIgXAogCQlD
RkxBR1M9IiQoR0xJQl9DRkxBR1MpICQoQU1fQ0ZMQUdTKSAkKENGTEFHUykiIFwKIAkJQ1BQRkxB
R1M9IiQoREVGUykgJChERUZBVUxUX0lOQ0xVREVTKSAkKEFNX0NQUEZMQUdTKSAkKENQUEZMQUdT
KSIgXAotCQlMREZMQUdTPSIkKEFNX0xERkxBR1MpICQoTERGTEFHUykiIFwKLQkJTElCUz0iJChH
TElCX0xJQlMpICQoTElCUykiCisJCUxERkxBR1M9IiQoQU1fTERGTEFHUykgJChMREZMQUdTKSAk
KEdMSUJfTElCUykgJChMSUJTKSIKIAogYnVpbGQtcHl0aG9uLWJpbmRpbmdzLnN0YW1wOiAkKEJJ
TkRJTkdTX0RFUFMpCiAJJChCVUlMRF9GTEFHUykgJChQWVRIT04pICQoYnVpbGRkaXIpL3NldHVw
LnB5IGJ1aWxkX2V4dAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
