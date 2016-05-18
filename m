From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Double free in
	utils_partial_realpath error path
Date: Wed, 18 May 2016 12:17:27 -0400
Message-ID: <1463588247-28885-1-git-send-email-mjeanson__8053.504539612$1463588277$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 98E21A358C
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 16:17:34 +0000 (UTC)
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

Rml4ZXMgY292ZXJpdHkgIzEzNTU1MjEKClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8
bWplYW5zb25AZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vdXRpbHMuYyB8IDQgKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3NyYy9jb21tb24vdXRpbHMuYyBiL3NyYy9jb21tb24vdXRpbHMuYwppbmRleCAzMGE1ZjEw
Li45MDFkZGIwIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL3V0aWxzLmMKKysrIGIvc3JjL2NvbW1v
bi91dGlscy5jCkBAIC0xOTAsNyArMTkwLDkgQEAgZXJyb3I6CiAJZnJlZShyZXNvbHZlZF9wYXRo
KTsKIAlmcmVlKGN1dF9wYXRoKTsKIAlmcmVlKHRyeV9wYXRoKTsKLQlmcmVlKHRyeV9wYXRoX3By
ZXYpOworCWlmICh0cnlfcGF0aF9wcmV2ICE9IHRyeV9wYXRoKSB7CisJCWZyZWUodHJ5X3BhdGhf
cHJldik7CisJfQogCXJldHVybiBOVUxMOwogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
