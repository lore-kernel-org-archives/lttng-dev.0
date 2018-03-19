From: Alexandre Montplaisir <alexmonthy@efficios.com>
Subject: Announcing LTTng Scope
Date: Mon, 19 Mar 2018 06:58:06 -0400
Message-ID: <8100c8e5-df31-d63b-d612-dd2c4c196db7__38857.8900871382$1521456981$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 404Y2H0NlLz1C8
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 06:58:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 11A9141942C
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 06:58:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id LH60ylicORDD for <lttng-dev@lists.lttng.org>;
 Mon, 19 Mar 2018 06:58:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 610B8419427
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 06:58:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id U9kljss_KEgl for <lttng-dev@lists.lttng.org>;
 Mon, 19 Mar 2018 06:58:07 -0400 (EDT)
Received: from [192.168.1.193] (cable-192.222.181.125.electronicbox.net
 [192.222.181.125])
 by mail.efficios.com (Postfix) with ESMTPSA id 44EE441941B
 for <lttng-dev@lists.lttng.org>; Mon, 19 Mar 2018 06:58:07 -0400 (EDT)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgZXZlcnlvbmUsCgpXZSBhdCBFZmZpY2lPUyBhcmUgaGFwcHkgdG8gYW5ub3VuY2UgdGhlIGZp
cnN0IHB1YmxpYyBwcmV2aWV3IG9mIHRoZQpMVFRuZyBTY29wZSBwcm9qZWN0LgoKTFRUbmcgU2Nv
cGUgaXMgYW4gZXhwZXJpbWVudGFsIGdyYXBoaWNhbCB2aWV3ZXIgZm9yIExUVG5nIGtlcm5lbCBh
bmQKdXNlcnNwYWNlIHRyYWNlcyBmb3IgTGludXgsIFdpbmRvd3MgYW5kIG1hY09TLiBXaXRoIHRo
aXMgbmV3IHByb2plY3QsIHdlCndhbnQgdG8gZXhwZXJpbWVudCB3aXRoIFVJL1VYIGFuZCBkZXRl
cm1pbmUgaG93IHVzZXJzIGNhbiBlZmZpY2llbnRseQppbnRlcmFjdCB3aXRoIHRyYWNlcyB1c2lu
ZyBhIGdyYXBoaWNhbCB1c2VyIGludGVyZmFjZS4KClBsZWFzZSBub3RlIGl0IGlzIGRlZmluaXRl
bHkgKk5PVCogcmVhZHkgZm9yIHVzZSBpbiBwcm9kdWN0aW9uIGF0IHRoaXMKc3RhZ2UuIFdlIGFy
ZSBtYWtpbmcgaXQgYXZhaWxhYmxlIHRvIGdldCBpdCAib3V0IGhlcmUiIGFuZCB0byBnYXRoZXIK
dmFsdWFibGUgdXNlciBmZWVkYmFjay4KClNvbWUgY3VycmVudGx5IGF2YWlsYWJsZSBmZWF0dXJl
cyBpbmNsdWRlOgoqIERldGFpbGVkIGV2ZW50IHJlY29yZCBsaXN0CiogVGhyZWFkIGFuZCBDUFUg
ZXhlY3V0aW9uIHN0YXRlIHZpc3VhbGl6YXRpb24KKiBQcm9qZWN0LXdpZGUgZXZlbnQgaGlnaGxp
Z2h0aW5nIChmaWx0ZXJzKSBzaG93biBpbiBhbGwgdmlld3MKKiBUaW1lc3RhbXAgZm9ybWF0dGlu
ZyBpbnRlcm9wZXJhYmxlIHdpdGggQmFiZWx0cmFjZQoqIFN0cmVhbWxpbmVkIHdvcmtmbG93Ciog
Q29udmVuaWVudCBpbnN0YWxsZXIKClRoZXJlIGFyZSBzb21lIG9idmlvdXMgbGltaXRhdGlvbnMg
aW4gdGhpcyBpbml0aWFsIHZlcnNpb246CiogSGFyZC1jb2RlZCBzZXQgb2Ygdmlld3Mgc3BlY2lm
aWMgdG8ga2VybmVsIHRyYWNlcwoqIE9ubHkgb25lIHRyYWNlIGNhbiBiZSBvcGVuZWQgcGVyIHBy
b2plY3QuCgpXZSBhcmUgcGxhbm5pbmcgdG8gcmVsZWFzZSBuZXcgcHJldmlldyB2ZXJzaW9ucyBv
dmVyIHRoZSBuZXh0IGZldyBtb250aHMKYXMgd2UgaW50cm9kdWNlIGNoYW5nZXMsIG5ldyBmZWF0
dXJlcyBhbmQgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLgoKClN0YW5kYWxvbmUsIHByZS1jb21w
aWxlZCBidWlsZHMgYXJlIGF2YWlsYWJsZSBvbiB0aGUgbmV3ICJiZXRhIiBzZWN0aW9uCm9mIHRo
ZSBMVFRuZyB3ZWJzaXRlOgpodHRwczovL2x0dG5nLm9yZy9iZXRhLwoKWW91IGNhbiBhbHNvIGJ1
aWxkIGl0IGZyb20gc291cmNlLCB0aGUgY29kZSAoRVBMLWxpY2Vuc2VkKSBjYW4gYmUgZm91bmQg
YXQ6Cmh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy1zY29wZQoKRG8gbm90IGhlc2l0YXRl
IHRvIHJlcG9ydCBhbnkgaXNzdWUgeW91IGVuY291bnRlciBvbiB0aGUgcHJvamVjdCdzCkdpdGh1
YiBwYWdlCmh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy1zY29wZS9pc3N1ZXMKb3Igb24g
dGhlIGx0dG5nLWRldiBtYWlsaW5nIGxpc3QuCgpSZWdhcmRzLApBbGV4YW5kcmUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
