From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.8.1 (Linux user-space tracer)
Date: Wed, 15 Jun 2016 15:36:06 +0000 (UTC)
Message-ID: <1670848897.37384.1466004966109.JavaMail.zimbra__35280.198013834$1466004988$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C1DF1A3891
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 15:36:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4430834017E
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 15:36:07 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dr6yZ7pFkNe5 for <lttng-dev@lists.lttng.org>;
 Wed, 15 Jun 2016 15:36:06 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9AACD3401AC
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 15:36:06 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jGoTlGWQiX5X for <lttng-dev@lists.lttng.org>;
 Wed, 15 Jun 2016 15:36:06 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 647E034017E
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 15:36:06 +0000 (UTC)
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

SGksCgpUaGlzIHJlbGVhc2UgaXMgYSBidWdmaXggcmVsZWFzZSBmb3IgdGhlIHN0YWJsZS0yLjgg
YnJhbmNoIG9mIGx0dG5nLXVzdC4KCkxUVG5nLVVTVCwgdGhlIExpbnV4IFRyYWNlIFRvb2xraXQg
TmV4dCBHZW5lcmF0aW9uIFVzZXJzcGFjZSBUcmFjZXIsCmlzIGEgbG93LW92ZXJoZWFkIGFwcGxp
Y2F0aW9uIHRyYWNlci4gVGhlIGxpYnJhcnkgImxpYmx0dG5nLXVzdCIgZW5hYmxlcwp0cmFjaW5n
IG9mIGFwcGxpY2F0aW9ucyBhbmQgbGlicmFyaWVzLgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8v
bHR0bmcub3JnCkRvY3VtZW50YXRpb246IGh0dHA6Ly9sdHRuZy5vcmcvZG9jcwpEb3dubG9hZCBs
aW5rOiBodHRwOi8vbHR0bmcub3JnL2Rvd25sb2FkCgpDaGFuZ2Vsb2c6CgoyMDE2LTA2LTE1IGx0
dG5nLXVzdCAyLjguMQogICAgICAgICogQ29tbWVudCB0aGUgbG9ja2luZyBtZWNoYW5pc21zIGlu
IENvbnRleHRJbmZvTWFuYWdlcgogICAgICAgICogRml4OiBOdWxsLWNoZWNrIHJldHVybiB2YWx1
ZSBvZiBsb2c0ai5DYXRlZ29yeS5nZXRBbGxBcHBlbmRlcnMoKQogICAgICAgICogQWRkIGxpYmx0
dG5nLXVzdC1hZ2VudC5qYXIgdG8gdGhlIC5naXRpZ25vcmUKICAgICAgICAqIEZpeDogU3BlY2lm
eSBlbmNvZGluZyB3aGVuIHJlYWRpbmcgYWdlbnQgcG9ydCBmaWxlCiAgICAgICAgKiBGaXg6IElu
Y2x1ZGUgY2hpbGQgbG9nZ2VycyBpbiB0aGUgb3V0cHV0IG9mICJsdHRuZyBsaXN0IgogICAgICAg
ICogRml4OiBIYW5kbGUgYm90aCBhZ2VudCBjb25maWcgZmlsZXMgcG9pbnRpbmcgdG8gc2FtZSBw
b3J0CiAgICAgICAgKiBTdXBwcmVzcyBzdGF0aWMgbWV0aG9kIHdhcm5pbmcKICAgICAgICAqIEFk
ZCBtb3JlIGxvZ2dpbmcgdG8gdGhlIEx0dG5nVGNwU2Vzc2lvbmRDbGllbnQKICAgICAgICAqIFVz
ZSBjb25maWcuaCB0byBkZXRlY3Qgc2NoZWRfZ2V0Y3B1IHN1cHBvcnQKICAgICAgICAqIEZpeDog
dXNlIGxpbWl0cy5oIGluIHVzdC1lbGYgdGVzdAogICAgICAgICogRml4OiBzdHJlcnJvcl9yIGJl
aGF2aW9yIGlzIGdsaWJjIHNwZWNpZmljCiAgICAgICAgKiBBZGQgc3VwcG9ydCBmb3IgbXVzbCBs
aWJjIHRvIHVzdC1kbGZjbi5oCiAgICAgICAgKiBGaXg6IGRvbid0IGdlbmVyYXRlIDAtbGVuIGFy
cmF5IGluIHRyYWNlcG9pbnQgcHJvYmVzCiAgICAgICAgKiBGaXg6IGxvZzRqIGV4YW1wbGU6IHNl
dCBsb2dnZXIgbGV2ZWwgdG8gcHJldmVudCB1bmV4cGVjdGVkIGxldmVsIGluaGVyaXRhbmNlCiAg
ICAgICAgKiBGaXg6IGluaXRpYWxpemUgUkNVIGNhbGxiYWNrcyB3aXRoIG1peGVkIExHUEwvbm9u
LUxHUEwgb2JqZWN0cwogICAgICAgICogRml4OiBpbmNvcnJlY3Qgc3RydWN0dXJlIGxheW91dCB3
aXRoIG1peGVkIExHUEwvbm9uLUxHUEwgb2JqZWN0cwogICAgICAgICogRml4OiBkb24ndCBjYWxs
IF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSBvbiAzMi1iaXQgcG93ZXJwYwogICAgICAgICog
Rml4OiB0cmFjZXBvaW50IGhlYWRlcjogZGVjbGFyZSB0cmFjZXBvaW50X2Rsb3Blbl9wdHIKICAg
ICAgICAqIEZpeDogdXBkYXRlIGRlYnVnIG1lc3NhZ2UgYWJvdXQgd2Vhay1oaWRkZW4gc3ltYm9s
cwogICAgICAgICogRml4OiB0cmFjZXBvaW50LXJjdSBoZWFkZXI6IHVzZSB0cmFjZXBvaW50X2Rs
b3Blbl9wdHIKICAgICAgICAqIEZpeDogdGVzdDogcmVsYXggcmVxdWlyZW1lbnQgb24gd2Vhay1o
aWRkZW4gc3ltYm9sIGFkZHJlc3MKICAgICAgICAqIEZpeDogd29yay1hcm91bmQgZ2NjIG9wdGlt
aXNhdGlvbiBvZGRuZXNzIG9uIDMyLWJpdCBwb3dlcnBjCiAgICAgICAgKiBGaXg6IHRlc3Qgd2Vh
ay1oaWRkZW4gc3ltYm9scwoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0
cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
