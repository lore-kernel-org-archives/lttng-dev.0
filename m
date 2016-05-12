From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/5] Fix: distcheck requires that we
	clean version.h
Date: Thu, 12 May 2016 16:08:47 -0400
Message-ID: <1463083727-15190-6-git-send-email-mathieu.desnoyers__49733.035270083$1463083766$gmane$org@efficios.com>
References: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 351BAA34C0
 for <lttng-dev@lists.lttng.org>; Thu, 12 May 2016 20:08:58 +0000 (UTC)
In-Reply-To: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbT4KLS0tCiBpbmNsdWRlL01ha2VmaWxlLmFtIHwgMiArKwogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUuYW0gYi9pbmNs
dWRlL01ha2VmaWxlLmFtCmluZGV4IGI2N2QyNjIuLjZjMDdhMzEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvTWFrZWZpbGUuYW0KKysrIGIvaW5jbHVkZS9NYWtlZmlsZS5hbQpAQCAtNTksNiArNTksOCBA
QCB2ZXJzaW9uLmg6CiAjIwogLlBIT05ZOiB2ZXJzaW9uLmgKIAorQ0xFQU5GSUxFUyA9IHZlcnNp
b24uaAorCiBub2Rpc3Rfbm9pbnN0X0hFQURFUlMgPSBcCiAJdmVyc2lvbi5oCiAKLS0gCjIuMS40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
