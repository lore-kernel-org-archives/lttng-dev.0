From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: [LTTng-UST] Linking question with minimum example
Date: Wed, 15 Jun 2016 16:20:12 -0400
Message-ID: <5761B87C.5030607__11110.2748466239$1466021797$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 37634A3513
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 20:16:10 +0000 (UTC)
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

SGksCgpJIGFtIG5vdCBhYmxlIHRvIGxpbmsgbHR0bmctdXN0IHdpdGggb25lIG9mIG15IGV4ZWN1
dGFibGUuCkkgcHJlcGFyZWQgYSBtaW5pIGV4YW1wbGUgKDEwMyBsaW5lcykgdG8gaGVscCB5b3Ug
dW5kZXJzdGFuZCBteSBxdWVzdGlvbi4KClRoZSBjYXNlIGhhcyAyIC5zbyBzaGFyZWQgbGlicmFy
aWVzOgoKbGliYWxpZ25lci5zbwpsaWJ0ZXN0ZXIuc28KCmFuZCAyIGV4ZWN1dGFibGU6CgphbGln
bmVyCnRlc3RlcgoKYWxpZ25lciBpcyBsaW5rZWQgd2l0aCBsaWJhbGlnbmVyLnNvCnRlc3RlciBp
cyBsaW5rZWQgd2l0aCBsaWJhbGlnbmVyLnNvIGFuZCBsaWJ0ZXN0ZXIuc28KCklmIEkgb25seSBp
bnN0cnVtZW50IGxpYmFsaWduZXIuc28sIEkgaGF2ZSBubyBwcm9ibGVtLiBJIGhhdmUgYmVlbiB1
c2luZyB0aGlzIGZvciBhIHdoaWxlIG5vdy4KCklmIEkgYWxzbyBpbnN0cnVtZW50IGxpYnRlc3Rl
ci5zbywgdGhlbiBJIGdldCBhIGxpbmtpbmcgcHJvYmxlbS4KCgpJIGFtIG5vdCBzdXJlIHdoYXQg
aXMgdGhlIGJlc3Qgc29sdXRpb24gZm9yIHRoaXMuCgoKCgoKCiQgZ2l0IGNsb25lIGh0dHBzOi8v
Z2l0aHViLmNvbS9zZWJodG1sL2x0dG5nLXVzdC10cmFjZXBvaW50X2Rsb3Blbl9wdHIuZ2l0CiQg
bWtkaXIgbHR0bmctdXN0LXRyYWNlcG9pbnRfZGxvcGVuX3B0ci5idWlsZAokIGNkIGx0dG5nLXVz
dC10cmFjZXBvaW50X2Rsb3Blbl9wdHIuYnVpbGQKJCBjbWFrZSAuLi9sdHRuZy11c3QtdHJhY2Vw
b2ludF9kbG9wZW5fcHRyCiQgbWFrZQpbIDQwJV0gQnVpbHQgdGFyZ2V0IGFsaWduZXItbGliClsg
NjAlXSBCdWlsdCB0YXJnZXQgYWxpZ25lcgpbIDgwJV0gQnVpbHQgdGFyZ2V0IHRlc3Rlci1saWIK
TGlua2luZyBDWFggZXhlY3V0YWJsZSB0ZXN0ZXIKbGlidGVzdGVyLWxpYi5zbzogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgdHJhY2Vwb2ludF9kbG9wZW5fcHRyJwpjb2xsZWN0MjogZXJyb3I6IGxk
IHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsyXTogKioqIFt0ZXN0ZXJdIEVycm9yIDEKbWFr
ZVsxXTogKioqIFtDTWFrZUZpbGVzL3Rlc3Rlci5kaXIvYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBb
YWxsXSBFcnJvciAyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
