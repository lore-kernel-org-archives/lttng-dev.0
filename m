From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] build: pass configure flags to cmake
	example
Date: Mon,  3 Oct 2016 10:42:45 -0400
Message-ID: <1475505765-22557-1-git-send-email-jonathan.rajotte-julien__4434.44633060626$1475505806$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 05B1DA0CF9
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 14:44:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D10D8340237
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 14:43:54 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIGRvYy9leGFtcGxlcy9NYWtlZmlsZS5hbSB8IDggKysrKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0gYi9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0K
aW5kZXggYzdlNWI2OC4uNWQ2N2U3OSAxMDA2NDQKLS0tIGEvZG9jL2V4YW1wbGVzL01ha2VmaWxl
LmFtCisrKyBiL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQpAQCAtMTQ5LDcgKzE0OSwxMyBAQCBh
bGwtbG9jYWw6CiAJCQkJY2QgJChTVUJESVJTX0NNQUtFKSAmJiBcCiAJCQkJJChNS0RJUl9QKSBi
dWlsZCAmJiBcCiAJCQkJY2QgYnVpbGQgJiYgXAotCQkJCWNtYWtlIC1EQ01BS0VfSU5DTFVERV9Q
QVRIPSIkKGFic190b3Bfc3JjZGlyKS9pbmNsdWRlOyQoYWJzX3RvcF9idWlsZGRpcikvaW5jbHVk
ZSIgLURDTUFLRV9MSUJSQVJZX1BBVEg9IiQoYWJzX3RvcF9idWlsZGRpcikvbGlibHR0bmctdXN0
Ly5saWJzIiAuLiAmJiBcCisJCQkJY21ha2UgXAorCQkJCS1EQ01BS0VfSU5DTFVERV9QQVRIPSIk
KGFic190b3Bfc3JjZGlyKS9pbmNsdWRlOyQoYWJzX3RvcF9idWlsZGRpcikvaW5jbHVkZSIgXAor
CQkJCS1EQ01BS0VfTElCUkFSWV9QQVRIPSIkKGFic190b3BfYnVpbGRkaXIpL2xpYmx0dG5nLXVz
dC8ubGlicyIgXAorCQkJCS1EQ01BS0VfQ19GTEFHUz0iJChDRkxBR1MpICQoQ1BQRkxBR1MpIiBc
CisJCQkJLURDTUFLRV9DWFhfRkxBR1M9IiQoQ1hYRkxBR1MpICQoQ1BQRkxBR1MpIiBcCisJCQkJ
LURDTUFLRV9FWEVfTElOS0VSX0ZMQUdTPSIkKExERkxBR1MpIiBcCisJCQkJLi4gJiYgXAogCQkJ
CSQoTUFLRSkgJiYgXAogCQkJCWNkIC4uIFwKIAkJCSkgfHwgZXhpdCAxOyBcCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
