From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: silence unused warning in
	native_bt
Date: Tue, 29 Aug 2017 12:17:39 -0400
Message-ID: <1504023459-15576-1-git-send-email-mjeanson__24248.2663867579$1504023502$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xhYhH4NLQz14RK
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 16:17:51 +0000 (UTC)
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
LQogYmluZGluZ3MvcHl0aG9uL2J0Mi9idDIvbmF0aXZlX2J0Y29tcG9uZW50Y2xhc3MuaSB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2JpbmRpbmdzL3B5dGhvbi9idDIvYnQyL25hdGl2ZV9idGNvbXBvbmVudGNsYXNzLmkg
Yi9iaW5kaW5ncy9weXRob24vYnQyL2J0Mi9uYXRpdmVfYnRjb21wb25lbnRjbGFzcy5pCmluZGV4
IDE5NWNhMzguLmRhMjVlMzcgMTAwNjQ0Ci0tLSBhL2JpbmRpbmdzL3B5dGhvbi9idDIvYnQyL25h
dGl2ZV9idGNvbXBvbmVudGNsYXNzLmkKKysrIGIvYmluZGluZ3MvcHl0aG9uL2J0Mi9idDIvbmF0
aXZlX2J0Y29tcG9uZW50Y2xhc3MuaQpAQCAtODE2LDcgKzgxNiw3IEBAIHN0YXRpYyB2b2lkIGJ0
X3B5M19jY19zZXRfb3B0aW9uYWxfaXRlcl9tZXRob2RzKHN0cnVjdCBidF9jb21wb25lbnRfY2xh
c3MgKmNjLAogCQlpbnQgKCpzZXRfbm90aWZfaXRlcl9pbml0X21ldGhvZCkoc3RydWN0IGJ0X2Nv
bXBvbmVudF9jbGFzcyAqLCBidF9jb21wb25lbnRfY2xhc3Nfbm90aWZpY2F0aW9uX2l0ZXJhdG9y
X2luaXRfbWV0aG9kKSwKIAkJaW50ICgqc2V0X25vdGlmX2l0ZXJfZmluYWxpemVfbWV0aG9kKShz
dHJ1Y3QgYnRfY29tcG9uZW50X2NsYXNzICosIGJ0X2NvbXBvbmVudF9jbGFzc19ub3RpZmljYXRp
b25faXRlcmF0b3JfZmluYWxpemVfbWV0aG9kKSkKIHsKLQlpbnQgcmV0OworCWludCByZXQgX19h
dHRyaWJ1dGVfXygodW51c2VkKSk7CiAKIAlyZXQgPSBzZXRfbm90aWZfaXRlcl9pbml0X21ldGhv
ZCgKIAkJY2MsIGJ0X3B5M19jY19ub3RpZmljYXRpb25faXRlcmF0b3JfaW5pdCk7Ci0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
