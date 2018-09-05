From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: add missing stdbool.h include
Date: Wed,  5 Sep 2018 15:56:59 -0400
Message-ID: <20180905195659.13418-1-mjeanson__14551.3898962692$1536177308$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 425DxY5Sp3zt4D
 for <lttng-dev@lists.lttng.org>; Wed,  5 Sep 2018 15:57:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 935691C78B0
 for <lttng-dev@lists.lttng.org>; Wed,  5 Sep 2018 15:57:04 -0400 (EDT)
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
LQogbGlibHR0bmctdXN0L2x0dG5nLWZpbHRlci5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9saWJsdHRuZy11c3QvbHR0bmctZmlsdGVyLmggYi9s
aWJsdHRuZy11c3QvbHR0bmctZmlsdGVyLmgKaW5kZXggZTQyNWI0YTUuLmNjMTVjMTU0IDEwMDY0
NAotLS0gYS9saWJsdHRuZy11c3QvbHR0bmctZmlsdGVyLmgKKysrIGIvbGlibHR0bmctdXN0L2x0
dG5nLWZpbHRlci5oCkBAIC0yOSw2ICsyOSw3IEBACiAKICNpbmNsdWRlIDxlcnJuby5oPgogI2lu
Y2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkYm9vbC5oPgogI2luY2x1ZGUgPGhlbHBlci5o
PgogI2luY2x1ZGUgPGx0dG5nL3VzdC1ldmVudHMuaD4KICNpbmNsdWRlIDxsdHRuZy91c3QtY29u
dGV4dC1wcm92aWRlci5oPgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
