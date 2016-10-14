From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Out of tree build of
	liblttng-ust-java
Date: Fri, 14 Oct 2016 21:01:10 +0000 (UTC)
Message-ID: <622526928.55667.1476478870188.JavaMail.zimbra__27204.4342513711$1476478825$gmane$org@efficios.com>
References: <1476477920-25433-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4555AA42F4
 for <lttng-dev@lists.lttng.org>; Fri, 14 Oct 2016 21:01:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3CA833402C3
 for <lttng-dev@lists.lttng.org>; Fri, 14 Oct 2016 21:01:14 +0000 (UTC)
In-Reply-To: <1476477920-25433-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuOCwgMi43LCB0aGFua3MhCgpNYXRoaWV1CgotLS0t
LSBPbiBPY3QgMTQsIDIwMTYsIGF0IDEwOjQ1IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25A
ZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1q
ZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBsaWJsdHRuZy11c3QtamF2YS9NYWtlZmlsZS5h
bSB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvbGlibHR0bmctdXN0LWphdmEvTWFrZWZpbGUuYW0gYi9saWJsdHRu
Zy11c3QtamF2YS9NYWtlZmlsZS5hbQo+IGluZGV4IGJhYWRhNTcuLjBjMmY2YTUgMTAwNjQ0Cj4g
LS0tIGEvbGlibHR0bmctdXN0LWphdmEvTWFrZWZpbGUuYW0KPiArKysgYi9saWJsdHRuZy11c3Qt
amF2YS9NYWtlZmlsZS5hbQo+IEBAIC03LDcgKzcsNyBAQCBkaXN0X25vaW5zdF9KQVZBID0gJChw
a2dwYXRoKS9MVFRuZ1VzdC5qYXZhCj4gamFyX0RBVEEgPSAkKGphcmZpbGUpCj4gQlVJTFRfU09V
UkNFUyA9IG9yZ19sdHRuZ191c3RfTFRUbmdVc3QuaAo+IAo+IC1BTV9DUFBGTEFHUyA9IC1JJCh0
b3Bfc3JjZGlyKS9pbmNsdWRlCj4gK0FNX0NQUEZMQUdTID0gLUkkKHRvcF9zcmNkaXIpL2luY2x1
ZGUgLUkkKHRvcF9idWlsZGRpcikvaW5jbHVkZQo+IGxpYl9MVExJQlJBUklFUyA9IGxpYmx0dG5n
LXVzdC1qYXZhLmxhCj4gbGlibHR0bmdfdXN0X2phdmFfbGFfU09VUkNFUyA9IExUVG5nVXN0LmMg
bHR0bmdfdXN0X2phdmEuaAo+IG5vZGlzdF9saWJsdHRuZ191c3RfamF2YV9sYV9TT1VSQ0VTID0g
b3JnX2x0dG5nX3VzdF9MVFRuZ1VzdC5oCj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95
ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
