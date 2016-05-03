From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: PATH_MAX requires limits.h on
	some platforms
Date: Tue,  3 May 2016 12:51:51 -0400
Message-ID: <1462294311-28165-1-git-send-email-mjeanson__43067.0806592845$1462294344$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 42F90A00FA
 for <lttng-dev@lists.lttng.org>; Tue,  3 May 2016 16:51:59 +0000 (UTC)
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
LQogdGVzdHMvbGliL2NvbW1vbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKCmRpZmYgLS1naXQgYS90ZXN0cy9saWIvY29tbW9uLmMgYi90ZXN0cy9saWIvY29tbW9uLmMK
aW5kZXggZDEzN2NiMy4uMGI4ZWJkZiAxMDA2NDQKLS0tIGEvdGVzdHMvbGliL2NvbW1vbi5jCisr
KyBiL3Rlc3RzL2xpYi9jb21tb24uYwpAQCAtMjIsNiArMjIsNyBAQAogI2luY2x1ZGUgPGJhYmVs
dHJhY2UvY29udGV4dC5oPgogI2luY2x1ZGUgPGJhYmVsdHJhY2UvaXRlcmF0b3IuaD4KICNpbmNs
dWRlIDxiYWJlbHRyYWNlL2NvbXBhdC9kaXJlbnQuaD4KKyNpbmNsdWRlIDxiYWJlbHRyYWNlL2Nv
bXBhdC9saW1pdHMuaD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgogCiBzdHJ1Y3QgYnRfY29udGV4
dCAqY3JlYXRlX2NvbnRleHRfd2l0aF9wYXRoKGNvbnN0IGNoYXIgKnBhdGgpCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
