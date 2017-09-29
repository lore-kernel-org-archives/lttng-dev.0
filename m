From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: version check error in
 btrfs instrumentation
Date: Fri, 29 Sep 2017 20:51:29 +0000 (UTC)
Message-ID: <469226850.22780.1506718289977.JavaMail.zimbra__19216.8922083967$1506718225$gmane$org@efficios.com>
References: <1506717636-1429-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y3kGH0pK5zsgb
 for <lttng-dev@lists.lttng.org>; Fri, 29 Sep 2017 20:50:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C287C3403DA
 for <lttng-dev@lists.lttng.org>; Fri, 29 Sep 2017 20:51:30 +0000 (UTC)
In-Reply-To: <1506717636-1429-1-git-send-email-mjeanson@efficios.com>
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

bWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9u
IFNlcCAyOSwgMjAxNywgYXQgNDo0MCBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmlj
aW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1
bGUvYnRyZnMuaCB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUvYnRyZnMuaAo+IGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRy
ZnMuaAo+IGluZGV4IDQ4YjdjYWUuLmI1MjllOGUgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0
aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaAo+ICsrKyBiL2luc3RydW1lbnRhdGlvbi9l
dmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmgKPiBAQCAtOTgwLDcgKzk4MCw3IEBAIExUVE5HX1RS
QUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0UoYnRyZnNfX3Jlc2VydmVkX2V4dGVudCwKPiBidHJmc19y
ZXNlcnZlZF9leHRlbnRfZgo+IAo+ICNlbmRpZiAvKiAjZWxzZSAjaWYgKExJTlVYX1ZFUlNJT05f
Q09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKSAqLwo+IAo+IC0jaWYgKExJTlVYX1ZFUlNJ
T05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKQo+ICsjaWYgKExJTlVYX1ZFUlNJT05f
Q09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDE0LDApKQo+IAo+IExUVE5HX1RSQUNFUE9JTlRfRVZF
TlRfTUFQKGZpbmRfZnJlZV9leHRlbnQsCj4gCj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVz
bm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
