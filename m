From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 5/6] Fix: location of various
	standard headers
Date: Wed, 15 Jun 2016 17:18:06 -0400
Message-ID: <1466025487-26743-5-git-send-email-mjeanson__46392.7809185863$1466025542$gmane$org@efficios.com>
References: <1466025487-26743-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EEF84A385A
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 21:18:44 +0000 (UTC)
In-Reply-To: <1466025487-26743-1-git-send-email-mjeanson@efficios.com>
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
LQogc3JjL2NvbW1vbi9kYWVtb25pemUuYyB8IDIgKy0KIHNyYy9jb21tb24vcnVuYXMuYyAgICAg
fCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2RhZW1vbml6ZS5jIGIvc3JjL2NvbW1vbi9kYWVtb25p
emUuYwppbmRleCAzMDA4NTFiLi5iMTIxOTRlIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL2RhZW1v
bml6ZS5jCisrKyBiL3NyYy9jb21tb24vZGFlbW9uaXplLmMKQEAgLTIwLDcgKzIwLDcgQEAKICNp
bmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxjb21tb24vY29tcGF0L3BhdGhzLmg+CiAjaW5j
bHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRlIDx3YWl0Lmg+CisjaW5jbHVkZSA8c3lzL3dhaXQuaD4K
ICNpbmNsdWRlIDxzdGRsaWIuaD4KIAogI2luY2x1ZGUgPHVyY3Uvc3lzdGVtLmg+CmRpZmYgLS1n
aXQgYS9zcmMvY29tbW9uL3J1bmFzLmMgYi9zcmMvY29tbW9uL3J1bmFzLmMKaW5kZXggMmE3MWY1
OC4uN2E2YmUyOCAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9ydW5hcy5jCisrKyBiL3NyYy9jb21t
b24vcnVuYXMuYwpAQCAtMjgsNyArMjgsNyBAQAogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1
ZGUgPGZjbnRsLmg+CiAjaW5jbHVkZSA8c2NoZWQuaD4KLSNpbmNsdWRlIDxzeXMvc2lnbmFsLmg+
CisjaW5jbHVkZSA8c2lnbmFsLmg+CiAjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8c2ln
bmFsLmg+CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
