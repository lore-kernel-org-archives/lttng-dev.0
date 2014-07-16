From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.0
Date: Wed, 16 Jul 2014 22:28:31 +0000 (UTC)
Message-ID: <12855255.15816.1405549711062.JavaMail.zimbra__682.234709575091$1405549771$gmane$org@efficios.com>
References: <372671276.15791.1405549480840.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X7Xge-0008Az-So
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 18:28:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3370B340179
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:28:36 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UYkdm-fpKFYY for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:28:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7EDE03401D0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:28:31 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Gu0C1utV_9RT for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:28:31 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 4860E340179
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:28:31 +0000 (UTC)
In-Reply-To: <372671276.15791.1405549480840.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TFRUbmctVVNULCB0aGUgTGludXggVHJhY2UgVG9vbGtpdCBOZXh0IEdlbmVyYXRpb24gVXNlcnNw
YWNlIFRyYWNlciwgaXMKcG9ydCBvZiB0aGUgbG93LW92ZXJoZWFkIHRyYWNpbmcgY2FwYWJpbGl0
aWVzIG9mIHRoZSBMVFRuZyBrZXJuZWwgdHJhY2VyCnRvIHVzZXItc3BhY2UuIFRoZSBsaWJyYXJ5
ICJsaWJsdHRuZy11c3QiIGVuYWJsZXMgdHJhY2luZyBvZgphcHBsaWNhdGlvbnMgYW5kIGxpYnJh
cmllcy4KCk5vdGV3b3J0aHkgbmV3IGZlYXR1cmVzIGluIExUVG5nLVVTVCAyLjUuMDoKCk5ldyBh
bmQgbm90ZXdvcnRoeToKCi0gTmV3IHRyYWNlZigpIGluc3RydW1lbnRhdGlvbiBmYWNpbGl0eS4g
RXhjZXJwdCBmcm9tIGx0dG5nLXVzdCgzKSBtYW4gcGFnZToKClVTQUdFIFdJVEggVFJBQ0VGCgog
ICAgICAgVGhlIHNpbXBsZXN0IHdheSB0byBhZGQgaW5zdHJ1bWVudGF0aW9uIHRvIHlvdXIgIGNv
ZGUgIGlzICBieSAgZmFyICB0aGUKICAgICAgIHRyYWNlZigpIEFQSS4gVG8gZG8gaXQsIGluIGEg
bnV0c2hlbGw6CgogICAgICAgMSkgI2luY2x1ZGUgPGx0dG5nL3RyYWNlZi5oPgoKICAgICAgIDIp
IC8qIGluIHlvdXIgY29kZSwgdXNlIGxpa2UgYSBwcmludGYgKi8KICAgICAgICAgIHRyYWNlZigi
bXkgbWVzc2FnZSwgdGhpcyBpbnRlZ2VyICVkIiwgMTIzNCk7CgogICAgICAgMykgTGluayB5b3Vy
IHByb2dyYW0gYWdhaW5zdCBsaWJsdHRuZy11c3Quc28uCgogICAgICAgNCkgRW5hYmxlICBVU1Qg
ZXZlbnRzIHdoZW4gdHJhY2luZyB3aXRoIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2Ugb2YgY29tbWFu
ZHMKICAgICAgICAgIGZyb20gbHR0bmctdG9vbHM6CgogICAgICAgICAgbHR0bmcgY3JlYXRlCiAg
ICAgICAgICBsdHRuZyBlbmFibGUtZXZlbnQgLXUgLWEKICAgICAgICAgIGx0dG5nIHN0YXJ0CiAg
ICAgICAgICBbLi4uIHJ1biB5b3VyIHByb2dyYW0gLi4uXQogICAgICAgICAgbHR0bmcgc3RvcAog
ICAgICAgICAgbHR0bmcgdmlldwoKICAgICAgIFRoYXQncyBpdCEKCiAgICAgICBJZiB5b3Ugd2Fu
dCB0byBoYXZlIG1vcmUgZmxleGliaWxpdHkgYW5kIGNvbnRyb2wgb24gIHRoZSAgZXZlbnQgIG5h
bWVzLAogICAgICAgcGF5bG9hZCAgdHlwaW5nLCAgZXRjLCAgeW91ICBjYW4gY29udGludWUgcmVh
ZGluZyBvbiBhbmQgdXNlIHRoZSB0cmFjZeKAkAogICAgICAgcG9pbnRzIGJlbG93LiAidHJhY2Vm
KCkiIGlzIHRoZXJlIGZvciBxdWljayBhbmQgZGlydHkgYWQgaG9jIGluc3RydW1lbuKAkAogICAg
ICAgdGF0aW9uLCB3aGVyZWFzIHRyYWNlcG9pbnQuaCBpcyBtZWFudCBmb3IgdGhvcm91Z2ggaW5z
dHJ1bWVudGF0aW9uIG9mIGEKICAgICAgIGNvZGUgYmFzZSB0byBiZSBpbnRlZ3JhdGVkIHdpdGgg
YW4gdXBzdHJlYW0gcHJvamVjdC4KCi0gUGVyZiBQTVUgY291bnRlcnMgc3VwcG9ydCBmcm9tIHVz
ZXItc3BhY2Ugb24geDg2LgoKLSBMaWJyYXJ5IGJhc2UgYWRkcmVzcyBkdW1wIGlzIG5vdyBzdGFi
bGUgKHRoYW5rcyB0byBNZW50b3IgZm9yIHRoZWlyCiAgY29udHJpYnV0aW9uKQoKCkNoYW5nZWxv
ZzoKCjIwMTQtMDctMTYgKFRha2UgWW91ciBQb2V0IHRvIFdvcmsgRGF5KSBsdHRuZy11c3QgMi41
LjAKICAgICAgICAqIE11dGV4IHdoaWxlIHVwZGF0aW5nIHN0YXRlZHVtcF9wZW5kaW5nIGlzIG5v
dCBuZWVkZWQKICAgICAgICAqIFJldmVydCAiVHVybiBiYXNlIGFkZHJlc3MgZHVtcCBpbnRvIGV4
cGVyaW1lbnRhbCBmZWF0dXJlIgogICAgICAgICogRml4OiBkb2N1bWVudCB1c3RfZm9ya19tdXRl
eCBuZXN0aW5nCiAgICAgICAgKiBCdWdmaXggZm9yICM3NDUgZGVhZGxvY2sgd2l0aCBiYWRkciBz
dGF0ZWR1bXArZm9yawogICAgICAgICogTW92ZSBlbmFibGVycyBzeW5jaW5nIGFmdGVyIHRoZSBj
aGFubmVsIHJlZ2lzdHJhdGlvbgogICAgICAgICogQWRkIGx0dG5nX3VzdF9ub3RyYWNlIHRvIHN0
YXRpYyBpbmxpbmUgZnVuY3Rpb25zCiAgICAgICAgKiBsdHRuZyB1c3Q6IHN1cHBvcnQgcHBjNjRs
ZSB3aXRoaW4gY29uZmlndXJlCgpQcm9qZWN0IHdlYnNpdGU6IGh0dHA6Ly9sdHRuZy5vcmcKRG93
bmxvYWQgbGluazogaHR0cDovL2x0dG5nLm9yZy9kb3dubG9hZAoocGxlYXNlIHJlZmVyIHRvIHRo
ZSBSRUFETUUgZmlsZSBmb3IgaW5zdGFsbGF0aW9uIGluc3RydWN0aW9ucykKCgotLSAKTWF0aGll
dSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
