From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: use the configured swig
	executable
Date: Mon, 18 Sep 2017 17:28:13 -0400
Message-ID: <1505770093-23415-1-git-send-email-mjeanson__39392.0086244636$1505770115$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xwzdN3N3yzDNn
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:28:24 +0000 (UTC)
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
LQogYmluZGluZ3MvcHl0aG9uL2J0Mi9NYWtlZmlsZS5hbSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2JpbmRpbmdzL3B5
dGhvbi9idDIvTWFrZWZpbGUuYW0gYi9iaW5kaW5ncy9weXRob24vYnQyL01ha2VmaWxlLmFtCmlu
ZGV4IGZlMWM4M2IuLjk0NzRlYmIgMTAwNjQ0Ci0tLSBhL2JpbmRpbmdzL3B5dGhvbi9idDIvTWFr
ZWZpbGUuYW0KKysrIGIvYmluZGluZ3MvcHl0aG9uL2J0Mi9NYWtlZmlsZS5hbQpAQCAtODAsNyAr
ODAsNyBAQCBjb3B5LXN0YXRpYy1kZXBzLnN0YW1wOiAkKFNUQVRJQ19CSU5ESU5HU19ERVBTKQog
CXRvdWNoICRACiAKIGJ1aWxkLXB5dGhvbi1iaW5kaW5ncy5zdGFtcDogY29weS1zdGF0aWMtZGVw
cy5zdGFtcCAkKEdFTkVSQVRFRF9CSU5ESU5HU19ERVBTKQotCSQoQlVJTERfRkxBR1MpICQoUFlU
SE9OKSAkKGJ1aWxkZGlyKS9zZXR1cC5weSBidWlsZF9leHQKKwkkKEJVSUxEX0ZMQUdTKSAkKFBZ
VEhPTikgJChidWlsZGRpcikvc2V0dXAucHkgYnVpbGRfZXh0IC0tc3dpZyAiJChTV0lHKSIKIAkk
KEJVSUxEX0ZMQUdTKSAkKFBZVEhPTikgJChidWlsZGRpcikvc2V0dXAucHkgYnVpbGQKIAl0b3Vj
aCAkQAogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
