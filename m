From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: vmalloc wrapper on kernel >=
	4.12
Date: Tue, 26 Sep 2017 13:46:30 -0400
Message-ID: <1506447990-27525-1-git-send-email-mjeanson__4408.78461017764$1506448011$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1pKn1n37zv9s
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 17:46:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E1D2F3403A8
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 17:47:44 +0000 (UTC)
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
LQogd3JhcHBlci92bWFsbG9jLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93cmFwcGVyL3ZtYWxsb2MuaCBiL3dyYXBw
ZXIvdm1hbGxvYy5oCmluZGV4IDJkZDA2Y2IuLmUxMTc1ODQgMTAwNjQ0Ci0tLSBhL3dyYXBwZXIv
dm1hbGxvYy5oCisrKyBiL3dyYXBwZXIvdm1hbGxvYy5oCkBAIC0yNyw2ICsyNyw3IEBACiAKICNp
bmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+CiAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgorI2lu
Y2x1ZGUgPGxpbnV4L21tLmg+CiAKICNpZmRlZiBDT05GSUdfS0FMTFNZTVMKIApAQCAtMTA1LDcg
KzEwNiw2IEBAIHZvaWQgbHR0bmdfa3ZmcmVlKGNvbnN0IHZvaWQgKmFkZHIpCiAjZWxzZQogCiAj
aW5jbHVkZSA8bGludXgvc2xhYi5oPgotI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAKIC8qCiAgKiBr
YWxsc3ltcyB3cmFwcGVyIG9mIF9fdm1hbGxvY19ub2RlIHdpdGggYSBmYWxsYmFjayB0byBrbWFs
bG9jX25vZGUuCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
