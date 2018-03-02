From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 1/2] Fix: reset cached vpid context on
	fork
Date: Fri,  2 Mar 2018 17:36:25 -0500
Message-ID: <1520030186-5612-1-git-send-email-mjeanson__19218.2248262272$1520030090$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3ztPL10FN4zr39
 for <lttng-dev@lists.lttng.org>; Fri,  2 Mar 2018 17:36:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 31EB6419265
 for <lttng-dev@lists.lttng.org>; Fri,  2 Mar 2018 17:36:40 -0500 (EST)
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

V2UgY3VycmVudGx5IHJlc2V0IHRoZSBjYWNoZWQgdnRpZCBvbiBmb3JrIGJ1dCBub3QgdGhlIHZw
aWQuIFRoaXMgaXMgbm90CmEgcHJvYmxlbSBvbiBMaW51eCBiZWNhdXNlIHdlIGRvbid0IGNhY2hl
IHRoZSB2cGlkIGludGVybmFsbHkgYnV0IGNhbGwKZ2V0cGlkKCkgZGlyZWN0bHkgYW5kIHJlbHkg
b24gdGhlIGdsaWJjIHBpZCBjYWNoZS4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8
bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIGxpYmx0dG5nLXVzdC9sdHRuZy11c3QtY29tbS5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9saWJs
dHRuZy11c3QvbHR0bmctdXN0LWNvbW0uYyBiL2xpYmx0dG5nLXVzdC9sdHRuZy11c3QtY29tbS5j
CmluZGV4IDQzOTE0NDYuLmQ0YWRkMWMgMTAwNjQ0Ci0tLSBhL2xpYmx0dG5nLXVzdC9sdHRuZy11
c3QtY29tbS5jCisrKyBiL2xpYmx0dG5nLXVzdC9sdHRuZy11c3QtY29tbS5jCkBAIC0yMDExLDYg
KzIwMTEsNyBAQCB2b2lkIHVzdF9hZnRlcl9mb3JrX2NoaWxkKHNpZ3NldF90ICpyZXN0b3JlX3Np
Z3NldCkKIHsKIAlpZiAoVVJDVV9UTFMobHR0bmdfdXN0X25lc3RfY291bnQpKQogCQlyZXR1cm47
CisJbHR0bmdfY29udGV4dF92cGlkX3Jlc2V0KCk7CiAJbHR0bmdfY29udGV4dF92dGlkX3Jlc2V0
KCk7CiAJREJHKCJwcm9jZXNzICVkIiwgZ2V0cGlkKCkpOwogCS8qIFJlbGVhc2UgdXJjdSBtdXRl
eGVzICovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
