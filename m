From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2] Fix: free previous instance of
	url (alloc_url) on default live url assignation
Date: Mon, 12 Dec 2016 16:39:17 -0500
Message-ID: <1481578757-27974-1-git-send-email-jonathan.rajotte-julien__936.133464756672$1481578781$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tcx9s0N9qztm4
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 21:41:36 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgfCA0ICsr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvYmlu
L2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUu
YwppbmRleCAwZjdkMWE0Li40MGQyYTc3IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1h
bmRzL2NyZWF0ZS5jCisrKyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMKQEAgLTM0
Miw2ICszNDIsMTAgQEAgc3RhdGljIGludCBjcmVhdGVfc2Vzc2lvbih2b2lkKQogCiAJLyogVXNl
IGRlZmF1bHQgbGl2ZSBVUkwgaWYgTk8gdXJsIGlzL2FyZSBmb3VuZC4gKi8KIAlpZiAoKG9wdF9s
aXZlX3RpbWVyICYmICFvcHRfdXJsKSAmJiAob3B0X2xpdmVfdGltZXIgJiYgIW9wdF9kYXRhX3Vy
bCkpIHsKKwkJLyogT3ZlcnJpZGUgdGhlIHVybCAqLworCQlmcmVlKHVybCk7CisJCXVybCA9IE5V
TEw7CisKIAkJcmV0ID0gYXNwcmludGYoJmFsbG9jX3VybCwgIm5ldDovLzEyNy4wLjAuMSIpOwog
CQlpZiAocmV0IDwgMCkgewogCQkJUEVSUk9SKCJhc3ByaW50ZiBkZWZhdWx0IGxpdmUgVVJMIik7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
