From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 3/4] Fix: use limits.h in ust-elf test
Date: Mon, 30 May 2016 16:31:32 -0400
Message-ID: <1464640293-10157-3-git-send-email-mjeanson__36729.577164124$1464640344$gmane$org@efficios.com>
References: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9EDB2A3713
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:55 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A31A34020D
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 20:31:55 +0000 (UTC)
In-Reply-To: <1464640293-10157-1-git-send-email-mjeanson@efficios.com>
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvdXN0LWVsZi9wcm9nLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy91c3QtZWxmL3Byb2cuYyBi
L3Rlc3RzL3VzdC1lbGYvcHJvZy5jCmluZGV4IGRhNGYzOTYuLjQwMzY1NjMgMTAwNjQ0Ci0tLSBh
L3Rlc3RzL3VzdC1lbGYvcHJvZy5jCisrKyBiL3Rlc3RzL3VzdC1lbGYvcHJvZy5jCkBAIC0xNiw3
ICsxNiw3IEBACiAgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRo
IEZsb29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAxIFVTQQogICovCiAKLSNpbmNsdWRlIDxsaW51
eC9saW1pdHMuaD4KKyNpbmNsdWRlIDxsaW1pdHMuaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2lu
Y2x1ZGUgPHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
