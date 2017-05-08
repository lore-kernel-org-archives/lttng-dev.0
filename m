From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Set -Wall globally in AM_CFLAGS
Date: Mon,  8 May 2017 16:15:22 -0400
Message-ID: <1494274522-28670-1-git-send-email-mjeanson__10377.8053461157$1494274541$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMDKc53XxzGfT
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 20:16:20 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E0886340357
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 20:17:37 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogY29uZmlndXJlLmFjICAgIHwgMSArCiBzcmMvTWFrZWZpbGUuYW0gfCAxIC0KIDIgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9jb25m
aWd1cmUuYWMgYi9jb25maWd1cmUuYWMKaW5kZXggNzUzYmVjNS4uMDIwYWRmYyAxMDA2NDQKLS0t
IGEvY29uZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtMzY5LDYgKzM2OSw3IEBAIEFD
X0NIRUNLX0ZVTkNTKFtzY2hlZF9zZXRhZmZpbml0eV0sWwogQU1fQ1BQRkxBR1M9Ii1pbmNsdWRl
IGNvbmZpZy5oIgogQUNfU1VCU1QoQU1fQ1BQRkxBR1MpCiAKK0FNX0NGTEFHUz0iLVdhbGwgJEFN
X0NGTEFHUyIKIEFDX1NVQlNUKEFNX0NGTEFHUykKIAogQUNfQ09ORklHX0xJTktTKFsKZGlmZiAt
LWdpdCBhL3NyYy9NYWtlZmlsZS5hbSBiL3NyYy9NYWtlZmlsZS5hbQppbmRleCA3NzZjMmEzLi5h
ODAxMDIwIDEwMDY0NAotLS0gYS9zcmMvTWFrZWZpbGUuYW0KKysrIGIvc3JjL01ha2VmaWxlLmFt
CkBAIC02LDcgKzYsNiBAQCBBTV9MREZMQUdTPS12ZXJzaW9uLWluZm8gJChVUkNVX0xJQlJBUllf
VkVSU0lPTikKIGlmIFVTRV9DWUdXSU4KIEFNX0xERkxBR1MrPS1uby11bmRlZmluZWQKIGVuZGlm
Ci1BTV9DRkxBR1MrPS1XYWxsCiAKIGluY2x1ZGVfSEVBREVSUyA9IHVyY3UuaCB1cmN1LWJwLmgg
dXJjdS1jYWxsLXJjdS5oIHVyY3UtZGVmZXIuaCBcCiAJCXVyY3UtcG9pbnRlci5oIHVyY3UtcXNi
ci5oIHVyY3UtZmxhdm9yLmgKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
