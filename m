From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: Define MANPATH in config.h
Date: Thu,  9 Jun 2016 15:11:31 -0400
Message-ID: <1465499493-29365-1-git-send-email-mjeanson__37990.9314950511$1465499534$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BF807A37FB
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jun 2016 19:11:50 +0000 (UTC)
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
LQogY29uZmlndXJlLmFjICAgICAgICAgICB8IDIgKysKIHNyYy9jb21tb24vTWFrZWZpbGUuYW0g
fCAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCmluZGV4IGM5NGRhN2Eu
LmQ2MTQ5ZmUgMTAwNjQ0Ci0tLSBhL2NvbmZpZ3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAg
LTYyMSw2ICs2MjEsOCBAQCBhbmQgaW5zdGFsbGluZyB0aGUgbWFuIHBhZ2VzLgogQU1fQ09ORElU
SU9OQUwoW01BTl9QQUdFU19PUFRdLCBbdGVzdCAieCRtYW5fcGFnZXNfb3B0IiAhPSAieG5vIl0p
CiBBTV9DT05ESVRJT05BTChbSEFWRV9BU0NJSURPQ19YTUxUT10sIFt0ZXN0ICJ4JGhhdmVfYXNj
aWlkb2NfeG1sdG8iID0gInh5ZXMiXSkKIAorQUNfREVGSU5FX1VOUVVPVEVEKFtNQU5QQVRIXSwg
WyJgZXZhbCBldmFsIGVjaG8gJG1hbmRpcmAiXSwgW1BhdGggdG8gbWFuIHBhZ2VzLl0pCisKICMg
UHl0aG9uIGFnZW50IHRlc3QKIFVTVF9QWVRIT05fQUdFTlQ9Imx0dG5ndXN0IgogCmRpZmYgLS1n
aXQgYS9zcmMvY29tbW9uL01ha2VmaWxlLmFtIGIvc3JjL2NvbW1vbi9NYWtlZmlsZS5hbQppbmRl
eCAxOTMwNTdjLi44NjMzNzMwIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL01ha2VmaWxlLmFtCisr
KyBiL3NyYy9jb21tb24vTWFrZWZpbGUuYW0KQEAgLTEsNSArMSw0IEBACi1BTV9DUFBGTEFHUyA9
IC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIC1JJCh0b3Bfc3JjZGlyKS9zcmMgXAotCS1ETUFOUEFU
SD1cIiIkKG1hbmRpcikiXCIKK0FNX0NQUEZMQUdTID0gLUkkKHRvcF9zcmNkaXIpL2luY2x1ZGUg
LUkkKHRvcF9zcmNkaXIpL3NyYwogCiBBVVRPTUFLRV9PUFRJT05TID0gc3ViZGlyLW9iamVjdHMK
IAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
