From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 01/24] Implement lttng_strncpy safe
	string copy
Date: Mon, 16 May 2016 21:42:40 -0400
Message-ID: <1463449383-6553-2-git-send-email-mathieu.desnoyers__20068.6183678501$1463449411$gmane$org@efficios.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6DF09A350E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 01:43:08 +0000 (UTC)
In-Reply-To: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL21hY3Jvcy5oIHwgMjIgKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMv
Y29tbW9uL21hY3Jvcy5oIGIvc3JjL2NvbW1vbi9tYWNyb3MuaAppbmRleCAzMDhkM2Q1Li42MTQ3
ZWZmIDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL21hY3Jvcy5oCisrKyBiL3NyYy9jb21tb24vbWFj
cm9zLmgKQEAgLTIwLDYgKzIwLDcgQEAKICNkZWZpbmUgX01BQ1JPU19ICiAKICNpbmNsdWRlIDxz
dGRsaWIuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KIAogLyoKICAqIFRha2VzIGEgcG9pbnRlciB4
IGFuZCB0cmFuc2Zvcm0gaXQgc28gd2UgY2FuIHVzZSBpdCB0byBhY2Nlc3MgbWVtYmVycwpAQCAt
NzYsNCArNzcsMjUgQEAgdm9pZCAqem1hbGxvYyhzaXplX3QgbGVuKQogI2RlZmluZSBMVFROR19I
SURERU4gX19hdHRyaWJ1dGVfXygodmlzaWJpbGl0eSgiaGlkZGVuIikpKQogI2VuZGlmCiAKKy8q
CisgKiBsdHRuZ19zdHJuY3B5IHJldHVybnMgMCBvbiBzdWNjZXNzLCBvciBub256ZXJvIG9uIGZh
aWx1cmUuCisgKiBJdCBjaGVja3MgdGhhdCB0aGUgQHNyYyBzdHJpbmcgZml0cyBpbnRvIEBkZXN0
X2xlbiBiZWZvcmUgcGVyZm9ybWluZworICogdGhlIGNvcHkuIE9uIGZhaWx1cmUsIG5vIGNvcHkg
aGFzIGJlZW4gcGVyZm9ybWVkLgorICovCitzdGF0aWMgaW5saW5lCitpbnQgbHR0bmdfc3RybmNw
eShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBkZXN0X2xlbikKK3sKKwlpZiAo
c3RybGVuKHNyYykgPj0gZGVzdF9sZW4pIHsKKwkJcmV0dXJuIC0xOworCX0KKwlzdHJuY3B5KGRl
c3QsIHNyYywgZGVzdF9sZW4pOworCS8qCisJICogQmUgZXh0cmEgY2FyZWZ1bCBhbmQgcHV0IGZp
bmFsIFwwIGF0IHRoZSBlbmQgYWZ0ZXIgc3RybmNweSgpLAorCSAqIGV2ZW4gdGhvdWdoIHdlIGNo
ZWNrZWQgdGhlIGxlbmd0aCBiZWZvcmUuIFRoaXMgbWFrZXMgQ292ZXJpdHkKKwkgKiBoYXBweS4K
KwkgKi8KKwlkZXN0W2Rlc3RfbGVuIC0gMV0gPSAnXDAnOworCXJldHVybiAwOworfQorCiAjZW5k
aWYgLyogX01BQ1JPU19IICovCi0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
