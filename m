From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5] Fix: disable debug by
	default info on Cygwin
Date: Fri,  7 Apr 2017 15:44:34 -0400
Message-ID: <1491594274-18158-1-git-send-email-mjeanson__21915.7762163833$1491594321$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3w096D2w4LzkPl
 for <lttng-dev@lists.lttng.org>; Fri,  7 Apr 2017 19:45:23 +0000 (UTC)
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

ZWxmdXRpbHMgaXMgbm90IGF2YWlsYWJsZSBvbiBDeWd3aW4uCgpTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KLS0tCiBjb25maWd1cmUuYWMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3Vy
ZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCAyMzgyZTUzLi5jOGU5Yjk4IDEwMDY0NAotLS0gYS9j
b25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC0xNDIsNiArMTQyLDcgQEAgQVNfQ0FT
RShbJGhvc3Rfb3NdLAogICBbY3lnd2luKl0sCiAgICAgWwogCUxUX05PX1VOREVGSU5FRD0iLW5v
LXVuZGVmaW5lZCIKKwlERUZBVUxUX0VOQUJMRV9ERUJVR19JTkZPPW5vCiAgICAgXQogKQogCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
