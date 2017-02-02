From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5 4/5] Port: Link live lib
	with ctf to satisfy cygwin linker
Date: Thu,  2 Feb 2017 17:03:11 -0500
Message-ID: <1486072992-21895-4-git-send-email-mjeanson__45344.8655819104$1486073102$gmane$org@efficios.com>
References: <1486072992-21895-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vDvGv0S2LzkxG
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2017 22:06:46 +0000 (UTC)
In-Reply-To: <1486072992-21895-1-git-send-email-mjeanson@efficios.com>
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
LQogZm9ybWF0cy9sdHRuZy1saXZlL01ha2VmaWxlLmFtIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mb3JtYXRzL2x0
dG5nLWxpdmUvTWFrZWZpbGUuYW0gYi9mb3JtYXRzL2x0dG5nLWxpdmUvTWFrZWZpbGUuYW0KaW5k
ZXggZTUzNjE2MC4uZjVmMjkxYyAxMDA2NDQKLS0tIGEvZm9ybWF0cy9sdHRuZy1saXZlL01ha2Vm
aWxlLmFtCisrKyBiL2Zvcm1hdHMvbHR0bmctbGl2ZS9NYWtlZmlsZS5hbQpAQCAtMTUsNCArMTUs
NSBAQCBsaWJiYWJlbHRyYWNlX2x0dG5nX2xpdmVfbGFfTERGTEFHUyA9IFwKIAkkKExEX05PX0FT
X05FRURFRCkgLXZlcnNpb24taW5mbyAkKEJBQkVMVFJBQ0VfTElCUkFSWV9WRVJTSU9OKQogCiBs
aWJiYWJlbHRyYWNlX2x0dG5nX2xpdmVfbGFfTElCQUREID0gXAotCSQodG9wX2J1aWxkZGlyKS9s
aWIvbGliYmFiZWx0cmFjZS5sYQorCSQodG9wX2J1aWxkZGlyKS9saWIvbGliYmFiZWx0cmFjZS5s
YSBcCisJJCh0b3BfYnVpbGRkaXIpL2Zvcm1hdHMvY3RmL2xpYmJhYmVsdHJhY2UtY3RmLmxhCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
