From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: atomic_add_unless() already
	returns zero on overflow
Date: Tue,  7 Mar 2017 23:36:00 -0500
Message-ID: <1488947760-25045-1-git-send-email-francis.deslauriers__49249.7268868194$1488947796$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdLM43wbmzw2w
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 04:36:16 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogRnJhbmNpcyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bl
ZmZpY2lvcy5jb20+Ci0tLQogd3JhcHBlci9rcmVmLmggfCA2ICstLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dyYXBwZXIv
a3JlZi5oIGIvd3JhcHBlci9rcmVmLmgKaW5kZXggZWVkZWZiZi4uZjMwYTlhZSAxMDA2NDQKLS0t
IGEvd3JhcHBlci9rcmVmLmgKKysrIGIvd3JhcHBlci9rcmVmLmgKQEAgLTM2LDExICszNiw3IEBA
CiAgKi8KIHN0YXRpYyBpbmxpbmUgaW50IGx0dG5nX2tyZWZfZ2V0KHN0cnVjdCBrcmVmICprcmVm
KQogewotCWlmIChhdG9taWNfYWRkX3VubGVzcygma3JlZi0+cmVmY291bnQsIDEsIElOVF9NQVgp
ICE9IElOVF9NQVgpIHsKLQkJcmV0dXJuIDE7Ci0JfSBlbHNlIHsKLQkJcmV0dXJuIDA7Ci0JfQor
CXJldHVybiBhdG9taWNfYWRkX3VubGVzcygma3JlZi0+cmVmY291bnQsIDEsIElOVF9NQVgpOwog
fQogCiAjZW5kaWYgLyogX0xUVE5HX1dSQVBQRVJfS1JFRl9IICovCi0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
