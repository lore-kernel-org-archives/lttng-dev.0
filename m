From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Use fs_initcall instead of
	rootfs_initcall
Date: Thu, 28 Jul 2016 12:12:11 -0400
Message-ID: <1469722331-21673-1-git-send-email-mjeanson__9869.1031839282$1469722371$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7EA0EA2AF5
 for <lttng-dev@lists.lttng.org>; Thu, 28 Jul 2016 16:12:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3BDA73401FB
 for <lttng-dev@lists.lttng.org>; Thu, 28 Jul 2016 16:12:28 +0000 (UTC)
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

VGhlIHJvb3Rmc19pbml0Y2FsbCBmb3IgZHJpdmVycyBidWlsdCBhcyBtb2R1bGVzIHdhcyBvbmx5
IGludHJvZHVjZWQgaW4Ka2VybmVsIDMuMTQgYnkgY29tbWl0IGI0NmQwYzQ2Y2NhYTM2NmE1YmI4
YWM3MDlmZGYyYmNhYTc2MjIxZmQuIFVzZQpmc19pbml0Y2FsbCBpbnN0ZWFkIHdoaWNoIGNvbWVz
IGp1c3QgYmVmb3JlIGFuZCBleGlzdHMgaW4gb2xkZXIga2VybmVscy4KClNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIHRlc3RzL2Nsb2Nr
LXBsdWdpbi9sdHRuZy1jbG9jay1wbHVnaW4tdGVzdC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvY2xvY2st
cGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMgYi90ZXN0cy9jbG9jay1wbHVnaW4vbHR0
bmctY2xvY2stcGx1Z2luLXRlc3QuYwppbmRleCBiZjgxOTMyLi41NWZhY2I3IDEwMDY0NAotLS0g
YS90ZXN0cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYworKysgYi90ZXN0
cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYwpAQCAtNjcsNyArNjcsNyBA
QCBpbnQgbHR0bmdfY2xvY2tfcGx1Z2luX2luaXQodm9pZCkKIHsKIAlyZXR1cm4gbHR0bmdfY2xv
Y2tfcmVnaXN0ZXJfcGx1Z2luKCZsdGMsIFRISVNfTU9EVUxFKTsKIH0KLXJvb3Rmc19pbml0Y2Fs
bChsdHRuZ19jbG9ja19wbHVnaW5faW5pdCk7Citmc19pbml0Y2FsbChsdHRuZ19jbG9ja19wbHVn
aW5faW5pdCk7CiAKIHN0YXRpYyBfX2V4aXQKIHZvaWQgbHR0bmdfY2xvY2tfcGx1Z2luX2V4aXQo
dm9pZCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
