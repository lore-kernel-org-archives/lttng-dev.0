From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.7.2 (Linux user-space tracer)
Date: Thu, 10 Mar 2016 01:35:04 +0000 (UTC)
Message-ID: <1447016643.21485.1457573704476.JavaMail.zimbra__7014.1811659143$1457573737$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C68CBA0678
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 01:35:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E027D34032C
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 01:35:14 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YXc2e6EH3jnO for <lttng-dev@lists.lttng.org>;
 Thu, 10 Mar 2016 01:35:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DDF24340330
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 01:35:04 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fAx61PCv52u7 for <lttng-dev@lists.lttng.org>;
 Thu, 10 Mar 2016 01:35:04 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id B733834032C
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 01:35:04 +0000 (UTC)
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

TFRUbmctVVNULCB0aGUgTGludXggVHJhY2UgVG9vbGtpdCBOZXh0IEdlbmVyYXRpb24gVXNlcnNw
YWNlIFRyYWNlciwKaXMgYSBsb3ctb3ZlcmhlYWQgYXBwbGljYXRpb24gdHJhY2VyLiBUaGUgbGli
cmFyeSAibGlibHR0bmctdXN0IiBlbmFibGVzCnRyYWNpbmcgb2YgYXBwbGljYXRpb25zIGFuZCBs
aWJyYXJpZXMuCgpUaGlzIGlzIGEgYnVnZml4IHJlbGVhc2UuCgpQcm9qZWN0IHdlYnNpdGU6IGh0
dHA6Ly9sdHRuZy5vcmcKRG9jdW1lbnRhdGlvbjogaHR0cDovL2x0dG5nLm9yZy9kb2NzCkRvd25s
b2FkIGxpbms6IGh0dHA6Ly9sdHRuZy5vcmcvZG93bmxvYWQKCkNoYW5nZWxvZzoKCjIwMTYtMDMt
MDkgbHR0bmctdXN0IDIuNy4yCiAgICAgICAgKiBGaXg6IGRpc2FibGUgdXNlIG9mIF9fYnVpbHRp
bl9yZXR1cm5fYWRkcmVzcygwKSBvbiAzMi1iaXQgUG93ZXJQQwogICAgICAgICogRml4OiBoYW5k
bGUgbmVnYXRpdmUgcmFuZ2UgZm9yIExUVE5HX1VTVF9SRUdJU1RFUl9USU1FT1VUCiAgICAgICAg
KiBGaXg6IEVuc3VyZSB0aGUgSmF2YSBKVUwgbWVzc2FnZXMgYXJlIGNvcnJlY3RseSBmb3JtYXR0
ZWQKICAgICAgICAqIEZpeDogZG91YmxlLWZyZWUgb24gZXJyb3Igc2VuZGluZyBmaWVsZHMKCi0t
IApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
