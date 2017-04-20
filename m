From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Always build vmscan probe
Date: Thu, 20 Apr 2017 15:23:25 -0400
Message-ID: <1492716205-26717-1-git-send-email-mjeanson__29253.7926733077$1492716232$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3w881s5PGczD7V
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 19:24:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A269634030C
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 19:25:12 +0000 (UTC)
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

VGhlIG1tL3Ztc2Nhbi5jIGNvbXBpbGUgdW5pdCBpcyBhIG9iai15LCBldmVuIG9uIGFuIG9sZCAy
LjYuMzYga2VybmVsLAphbHdheXMgYnVpbGQgdGhlIHZtc2NhbiBwcm9iZSByZWdhcmRsZXNzIG9m
IGtlcm5lbCBjb25maWd1cmF0aW9uLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxt
amVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogcHJvYmVzL0tidWlsZCB8IDEwICstLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9wcm9iZXMvS2J1aWxkIGIvcHJvYmVzL0tidWlsZAppbmRleCAyYWZiNmRkLi5iZjE0Yzc1
IDEwMDY0NAotLS0gYS9wcm9iZXMvS2J1aWxkCisrKyBiL3Byb2Jlcy9LYnVpbGQKQEAgLTE0Mywx
OSArMTQzLDExIEBAIGlmbmVxICgkKENPTkZJR19TQ1NJKSwpCiAgICAgICBlY2hvICJsdHRuZy1w
cm9iZS1zY3NpLm8iIDsgZmk7KQogZW5kaWYgIyBDT05GSUdfU0NTSQogCi12bXNjYW4gPSAkKHNo
ZWxsIFwKK29iai0kKENPTkZJR19MVFRORykgKz0gJChzaGVsbCBcCiAgIGlmIFsgJChWRVJTSU9O
KSAtZ2UgMyBcCiAgICAgLW8gXCggJChWRVJTSU9OKSAtZXEgMiAtYSAkKFBBVENITEVWRUwpIC1l
cSA2IC1hICQoU1VCTEVWRUwpIC1nZSAzNiBcKSBdIDsgdGhlbiBcCiAgICAgZWNobyAibHR0bmct
cHJvYmUtdm1zY2FuLm8iIDsgZmk7KQogCi1pZm5lcSAoJChDT05GSUdfU1dBUCksKQotICBvYmot
JChDT05GSUdfTFRUTkcpICs9ICQodm1zY2FuKQotZWxzZQotICBpZm5lcSAoJChDT05GSUdfQ0dS
T1VQX01FTV9SRVNfQ1RMUiksKQotICAgIG9iai0kKENPTkZJR19MVFRORykgKz0gJCh2bXNjYW4p
Ci0gIGVuZGlmICMgQ09ORklHX0NHUk9VUF9NRU1fUkVTX0NUTFIKLWVuZGlmICMgQ09ORklHX1NX
QVAKLQogIyBsb2NrIHByb2JlIGRvZXMgbm90IHdvcmssIHNvIGRpc2FibGluZyBpdCBmb3Igbm93
CiAjaWZuZXEgKCQoQ09ORklHX0xPQ0tERVApLCkKICMgIG9iai0kKENPTkZJR19MVFRORykgKz0g
bHR0bmctcHJvYmUtbG9jay5vCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
