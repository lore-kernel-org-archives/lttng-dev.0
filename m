From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-ust v2 2/6] Cleanup: Move version numbers
	in separate variables in configure script
Date: Fri,  9 Feb 2018 15:15:21 -0500
Message-ID: <1518207325-9641-3-git-send-email-francis.deslauriers__33621.4283518077$1518207287$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1518207325-9641-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zdRC02NRfznmh
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 20:15:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7FCA934020E
 for <lttng-dev@lists.lttng.org>; Fri,  9 Feb 2018 20:16:31 +0000 (UTC)
In-Reply-To: <1518207325-9641-1-git-send-email-francis.deslauriers@efficios.com>
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogY29uZmlndXJlLmFjIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9jb25maWd1cmUu
YWMgYi9jb25maWd1cmUuYWMKaW5kZXggZmIyZjI3OC4uYjBiNDE1NyAxMDA2NDQKLS0tIGEvY29u
ZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtMjAsNyArMjAsMTEgQEAgQUNfU1VCU1Qo
W1BBVENITEVWRUxfVkVSU0lPTl0sIFtWX1BBVENIXSkKICMgRm9sbG93aW5nIHRoZSBudW1iZXJp
bmcgc2NoZW1lIHByb3Bvc2VkIGJ5IGxpYnRvb2wgZm9yIHRoZSBsaWJyYXJ5IHZlcnNpb24KICMg
aHR0cDovL3d3dy5nbnUub3JnL3NvZnR3YXJlL2xpYnRvb2wvbWFudWFsL2h0bWxfbm9kZS9VcGRh
dGluZy12ZXJzaW9uLWluZm8uaHRtbAogIyBUaGlzIGlzIHRoZSBsaWJyYXJ5IHZlcnNpb24gb2Yg
bGlibHR0bmctdXN0LgotQUNfU1VCU1QoW0xUVE5HX1VTVF9MSUJSQVJZX1ZFUlNJT05dLCBbMDow
OjBdKQorbTRfZGVmaW5lKFtVU1RfTElCX1ZfTUFKT1JdLCBbMF0pCittNF9kZWZpbmUoW1VTVF9M
SUJfVl9NSU5PUl0sIFswXSkKK200X2RlZmluZShbVVNUX0xJQl9WX1BBVENIXSwgWzBdKQorCitB
Q19TVUJTVChbTFRUTkdfVVNUX0xJQlJBUllfVkVSU0lPTl0sIFtVU1RfTElCX1ZfTUFKT1I6VVNU
X0xJQl9WX01JTk9SOlVTVF9MSUJfVl9QQVRDSF0pCiAjIG5vdGU6IHJlbWVtYmVyIHRvIHVwZGF0
ZSB0cmFjZXBvaW50LmggZGxvcGVuKCkgdG8gbWF0Y2ggdGhpcyB2ZXJzaW9uCiAjIG51bWJlci4g
VE9ETzogZXZlbnR1YWxseSBhdXRvbWF0ZSBieSBleHBvcnRpbmcgdGhlIG1ham9yIG51bWJlci4K
IAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
