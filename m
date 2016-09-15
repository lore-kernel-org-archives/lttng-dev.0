From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: Use autoconf provided grep in
	test_formats
Date: Thu, 15 Sep 2016 18:47:56 -0400
Message-ID: <1473979676-8006-1-git-send-email-mjeanson__21287.7542050139$1473979702$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3AA18A4078
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 22:49:02 +0000 (UTC)
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
LQogdGVzdHMvYmluL3Rlc3RfZm9ybWF0cy5pbiB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Jpbi90ZXN0X2Zv
cm1hdHMuaW4gYi90ZXN0cy9iaW4vdGVzdF9mb3JtYXRzLmluCmluZGV4IDgxYjkyNGEuLjBkOTE4
OTggMTAwNjQ0Ci0tLSBhL3Rlc3RzL2Jpbi90ZXN0X2Zvcm1hdHMuaW4KKysrIGIvdGVzdHMvYmlu
L3Rlc3RfZm9ybWF0cy5pbgpAQCAtMjcsNiArMjcsNiBAQCBleHBlY3RlZF9mb3JtYXRzPSh0ZXh0
IGx0dG5nLWxpdmUgZHVtbXkgY3RmLW1ldGFkYXRhIGN0ZikKIHBsYW5fdGVzdHMgJHsjZXhwZWN0
ZWRfZm9ybWF0c1sqXX0KIAogZm9yIGZvcm1hdCBpbiAiJHtleHBlY3RlZF9mb3JtYXRzW0BdfSI7
IGRvCi0gICAgIiRCQUJFTFRSQUNFX0JJTiIgLS1saXN0IHwgZ3JlcCAtcXcgIiRmb3JtYXQiCisg
ICAgIiRCQUJFTFRSQUNFX0JJTiIgLS1saXN0IHwgQEdSRVBAIC1xdyAiJGZvcm1hdCIKICAgICBv
ayAkPyAiRGV0ZWN0IHN1cHBvcnQgZm9yIGZvcm1hdCBcIiRmb3JtYXRcIiIKIGRvbmUKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
