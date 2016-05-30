From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 1/2] sys/param.h is required for
	MAXNAMLEN on musl libc
Date: Mon, 30 May 2016 16:39:01 -0400
Message-ID: <1464640742-24658-1-git-send-email-mjeanson__16217.3636294485$1464640771$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9D638A3724
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:39:11 +0000 (UTC)
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
LQogZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxp
dmUuaCBiL2Zvcm1hdHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLmgKaW5kZXggZTAwYTUxZS4uYjMx
NTQ1OCAxMDA2NDQKLS0tIGEvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUuaAorKysgYi9m
b3JtYXRzL2x0dG5nLWxpdmUvbHR0bmctbGl2ZS5oCkBAIC0yNSw2ICsyNSw3IEBACiAgKi8KIAog
I2luY2x1ZGUgPHN0ZGludC5oPgorI2luY2x1ZGUgPHN5cy9wYXJhbS5oPgogI2luY2x1ZGUgImx0
dG5nLXZpZXdlci1hYmkuaCIKIAogI2RlZmluZSBMVFROR19ERUZBVUxUX05FVFdPUktfVklFV0VS
X1BPUlQJNTM0NAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
