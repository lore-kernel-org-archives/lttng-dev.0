From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: report error on session listing
Date: Fri, 21 Jul 2017 11:09:14 -0400
Message-ID: <20170721150914.21567-1-jonathan.rajotte-julien__49377.8922748335$1500649929$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xDZ474vX0z13LL
 for <lttng-dev@lists.lttng.org>; Fri, 21 Jul 2017 15:11:51 +0000 (UTC)
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
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvZGVzdHJveS5jIHwgMyAr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2Rlc3Ryb3kuYyBiL3NyYy9iaW4vbHR0bmcv
Y29tbWFuZHMvZGVzdHJveS5jCmluZGV4IDBlNjAzZTEzLi4wMmM3MTM5YyAxMDA2NDQKLS0tIGEv
c3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9kZXN0cm95LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21t
YW5kcy9kZXN0cm95LmMKQEAgLTIzMiw3ICsyMzIsOCBAQCBpbnQgY21kX2Rlc3Ryb3koaW50IGFy
Z2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCS8qIFJlY3VwZXJhdGUgYWxsIHNlc3Npb25zIGZvciBm
dXJ0aGVyIG9wZXJhdGlvbiAqLwogCWNvdW50ID0gbHR0bmdfbGlzdF9zZXNzaW9ucygmc2Vzc2lv
bnMpOwogCWlmIChjb3VudCA8IDApIHsKLQkJY29tbWFuZF9yZXQgPSBjb3VudDsKKwkJRVJSKCIl
cyIsIGx0dG5nX3N0cmVycm9yKGNvdW50KSk7CisJCWNvbW1hbmRfcmV0ID0gQ01EX0VSUk9SOwog
CQlzdWNjZXNzID0gMDsKIAkJZ290byBtaV9jbG9zaW5nOwogCX0KLS0gCjIuMTEuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
