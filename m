From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH] Fix test: ctf writer has too large offset_s
Date: Tue,  8 Aug 2017 15:18:48 -0400
Message-ID: <1502219928-17184-1-git-send-email-mjeanson__21142.469198867$1502219968$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xRkjD0ySGzCSj
 for <lttng-dev@lists.lttng.org>; Tue,  8 Aug 2017 19:19:11 +0000 (UTC)
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

VGhlIG9mZnNldF9zIHZhbHVlcyBtdWx0aXBsaWVkIGJ5IDEwMDAwMDAwMDAgb3ZlcmZsb3dzIDY0
LWJpdC4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3Mu
Y29tPgotLS0KIHRlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2xp
Yi90ZXN0X2N0Zl93cml0ZXIuYyBiL3Rlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYwppbmRleCBk
M2M3YTk2Li5jY2Q4YTI0IDEwMDY0NAotLS0gYS90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMK
KysrIGIvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5jCkBAIC0yODMwLDcgKzI4MzAsNyBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJY29uc3QgY2hhciAqcmV0dXJuZWRfY2xv
Y2tfbmFtZTsKIAljb25zdCBjaGFyICpyZXR1cm5lZF9jbG9ja19kZXNjcmlwdGlvbjsKIAljb25z
dCB1aW50NjRfdCBmcmVxdWVuY3kgPSAxMTIzNDU2Nzg5OwotCWNvbnN0IGludDY0X3Qgb2Zmc2V0
X3MgPSAxMzUxNTMwOTI5OTQ1ODI0MzIzOworCWNvbnN0IGludDY0X3Qgb2Zmc2V0X3MgPSAxMzUx
NTMwOTsKIAljb25zdCBpbnQ2NF90IG9mZnNldCA9IDEyMzQ1Njc7CiAJaW50NjRfdCBnZXRfb2Zm
c2V0X3MsCiAJCWdldF9vZmZzZXQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
