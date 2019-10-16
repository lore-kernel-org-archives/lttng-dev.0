From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: LTTng 2.11 new features blog posts
Date: Wed, 16 Oct 2019 15:33:10 -0400
Message-ID: <20191016193310.GG23844__29089.248825197$1571254413$gmane$org@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46tjBc0b6xzr34
 for <lttng-dev@lists.lttng.org>; Wed, 16 Oct 2019 15:33:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 4C8793430F4
 for <lttng-dev@lists.lttng.org>; Wed, 16 Oct 2019 15:33:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id knv4iwPi1MpU for <lttng-dev@lists.lttng.org>;
 Wed, 16 Oct 2019 15:33:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 004763430F1
 for <lttng-dev@lists.lttng.org>; Wed, 16 Oct 2019 15:33:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 5Q5lehaYQrTJ for <lttng-dev@lists.lttng.org>;
 Wed, 16 Oct 2019 15:33:10 -0400 (EDT)
Received: from joraj-alpa (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
 by mail.efficios.com (Postfix) with ESMTPSA id D47233430E3
 for <lttng-dev@lists.lttng.org>; Wed, 16 Oct 2019 15:33:10 -0400 (EDT)
Content-Disposition: inline
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

SGVsbG8gZXZlcnlvbmUhCgpXZSByZWNlbnRseSBwdWJsaXNoZWQgdHdvIGJsb2cgcG9zdHMgWzFd
WzJdIGNvbmNlcm5pbmcgdXBjb21pbmcgZmVhdHVyZXMgb2YKTFRUbmcgMi4xMS4KClsxXSBpbnRy
b2R1Y2VzIHRoZSBuZXcgc2Vzc2lvbiByb3RhdGlvbiBmZWF0dXJlIGFsbG93aW5nIHVzZXJzIHRv
IGNyZWF0ZQpzZWxmLWNvbnRhaW5lZCB0cmFjZSBhcmNoaXZlcyBvbi1kZW1hbmQgdGhhdCBjYW4g
YmUgYW5hbHl6ZWQgd2hpbGUgdHJhY2luZwpjb250aW51ZXMgaW4gdGhlIGJhY2tncm91bmQuCgpb
Ml0gZGVtb25zdHJhdGVzIGhvdyB0byBsZXZlcmFnZSB0aGUgbmV3IGR5bmFtaWMgdXNlcnNwYWNl
IHByb2JlIHN1cHBvcnQuIEl0CmFsbG93cyB5b3UgdG8gYWRkIHRyYWNlcG9pbnRzIGluIHJ1bm5p
bmcgYXBwcyB3aXRob3V0IG5lZWRpbmcgdG8gcmVjb21waWxlIG9yCmV2ZW4gcmVzdGFydCB0aGVt
LiBJdCBzdXBwb3J0cyBpbnN0cnVtZW50YXRpb24gb24gRUxGIGZ1bmN0aW9uIHN5bWJvbCBhbmQK
U3lzdGVtdGFw4oCZcyBTRFQgcHJvYmUgcG9pbnRzLgoKQ2hlZXJzCgpbMV0gaHR0cHM6Ly9sdHRu
Zy5vcmcvYmxvZy8yMDE5LzEwLzE1L2x0dG5nLXNlc3Npb24tcm90YXRpb24vClsyXSBodHRwczov
L2x0dG5nLm9yZy9ibG9nLzIwMTkvMTAvMTUvbmV3LWR5bmFtaWMtdXNlci1zcGFjZS10cmFjaW5n
LWluLWx0dG5nLwoKLS0gCkpvbmF0aGFuIFJham90dGUtSnVsaWVuCkVmZmljaU9TCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
