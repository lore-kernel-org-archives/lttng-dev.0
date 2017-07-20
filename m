From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 1/3] Tests fix: unused variable warnings
Date: Thu, 20 Jul 2017 17:33:45 -0400
Message-ID: <1500586427-30038-1-git-send-email-mjeanson__6801.25336298278$1500586451$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xD6fH3C1Hz13fC
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:36:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A71BD340300
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jul 2017 21:35:41 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvYmVuY2htYXJrL3Rlc3RfdXJjdV9sZnNfcmN1LmMgfCA1ICsrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL2JlbmNobWFyay90ZXN0X3VyY3VfbGZzX3JjdS5jIGIvdGVzdHMvYmVuY2htYXJrL3Rlc3Rf
dXJjdV9sZnNfcmN1LmMKaW5kZXggY2UwMTE0My4uOWUwYmZhZCAxMDA2NDQKLS0tIGEvdGVzdHMv
YmVuY2htYXJrL3Rlc3RfdXJjdV9sZnNfcmN1LmMKKysrIGIvdGVzdHMvYmVuY2htYXJrL3Rlc3Rf
dXJjdV9sZnNfcmN1LmMKQEAgLTgzLDkgKzgzLDEwIEBAIHB0aHJlYWRfbXV0ZXhfdCBhZmZpbml0
eV9tdXRleCA9IFBUSFJFQURfTVVURVhfSU5JVElBTElaRVI7CiAKIHN0YXRpYyB2b2lkIHNldF9h
ZmZpbml0eSh2b2lkKQogeworI2lmIEhBVkVfU0NIRURfU0VUQUZGSU5JVFkKIAljcHVfc2V0X3Qg
bWFzazsKLQlpbnQgY3B1OwotCWludCByZXQ7CisJaW50IGNwdSwgcmV0OworI2VuZGlmIC8qIEhB
VkVfU0NIRURfU0VUQUZGSU5JVFkgKi8KIAogCWlmICghdXNlX2FmZmluaXR5KQogCQlyZXR1cm47
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
