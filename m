From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: merge tap tests stdout and
	stderr
Date: Wed, 18 May 2016 15:26:06 -0400
Message-ID: <1463599566-10271-1-git-send-email-mjeanson__42853.9503169761$1463599607$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2F4F7A35B6
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:26:18 +0000 (UTC)
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

VGhpcyBtYWtlcyB0aGUgb3V0cHV0IGFuZCBlcnJvciBzdGF0ZW1lbnQgb3JkZXJlZCBpbiB0aGUg
bG9nCmZpbGUgYW5kIGVuc3VyZSB0aGF0IHRoZSBmaXJzdCBsaW5lIGlzIHRoZSB0YXAgdGVzdCBw
bGFuLiBTb21lIHRhcApwYXJzZXIgYXJlIGNvbmZ1c2VkIGlmIHRoZSB0ZXN0IHBsYW4gaXMgbm90
IG9uIHRoZSBmaXJzdCBsaW5lLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogdGVzdHMvTWFrZWZpbGUuYW0gfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL01ha2VmaWxlLmFtIGIv
dGVzdHMvTWFrZWZpbGUuYW0KaW5kZXggNDY3YjE5MS4uY2QwMDgyMyAxMDA2NDQKLS0tIGEvdGVz
dHMvTWFrZWZpbGUuYW0KKysrIGIvdGVzdHMvTWFrZWZpbGUuYW0KQEAgLTEsNSArMSw2IEBACiBT
VUJESVJTID0gdXRpbHMgYmluIGxpYgogCitMT0dfRFJJVkVSX0ZMQUdTPSctLW1lcmdlJwogTE9H
X0RSSVZFUiA9IGVudiBBTV9UQVBfQVdLPSckKEFXSyknICQoU0hFTEwpIFwKIAkkKHRvcF9zcmNk
aXIpL2NvbmZpZy90YXAtZHJpdmVyLnNoCiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
