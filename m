From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: atomic_add_unless() returns
	true/false rather than prior value
Date: Wed,  8 Mar 2017 11:38:51 -0500
Message-ID: <1488991131-9828-1-git-send-email-francis.deslauriers__20179.9141745598$1488991170$gmane$org@efficios.com>
References: <1488947760-25045-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vdfPL4KtPzw2V
 for <lttng-dev@lists.lttng.org>; Wed,  8 Mar 2017 16:39:18 +0000 (UTC)
In-Reply-To: <1488947760-25045-1-git-send-email-francis.deslauriers@efficios.com>
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

VGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGFzc3VtZWQgdGhhdCBgYXRvbWljX2FkZF91bmxl
c3NgIHJldHVybmVkIHRoZQpwcmlvciB2YWx1ZSBvZiB0aGUgYXRvbWljIGNvdW50ZXIgd2hlbiBp
biBmYWN0IGl0IHJldHVybmVkIGlmIGFkZGl0aW9uIHdhcwpzdWNjZXNzZnVsKHRydWUpIG9yIG92
ZXJmbG93ZWQoZmFsc2UpLgpTaW5jZSBgYXRvbWljX2FkZF91bmxlc3NgIGNhbiBub3QgcmV0dXJu
IElOVF9NQVgsIHRoZSBgbHR0bmdfa3JlZl9nZXRgCmFsd2F5cyByZXR1cm5lZCB0aGF0IHRoZSBj
YWxsIHdhcyBzdWNjZXNzZnVsLgoKVGhpcyBpc3N1ZSBoYWQgYSBsb3cgbGlrZWxpaG9vZCBvZiBi
ZWluZyB0cmlnZ2VyZWQgc2luY2UgdGhlIHR3byByZWZjb3VudHMKb2YgdGhlIGNvdW50ZXJzIHVz
ZWQgd2l0aCB0aGlzIGNhbGwgYXJlIGJvdGggYm91bmRlZCBieSB0aGUgbWF4aW11bQpudW1iZXIg
b2YgZmlsZSBkZXNjcmlwdG9ycyBvbiB0aGUgc3lzdGVtLgoKU2lnbmVkLW9mZi1ieTogRnJhbmNp
cyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogd3Jh
cHBlci9rcmVmLmggfCA2ICstLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dyYXBwZXIva3JlZi5oIGIvd3JhcHBlci9rcmVm
LmgKaW5kZXggZWVkZWZiZi4uZjMwYTlhZSAxMDA2NDQKLS0tIGEvd3JhcHBlci9rcmVmLmgKKysr
IGIvd3JhcHBlci9rcmVmLmgKQEAgLTM2LDExICszNiw3IEBACiAgKi8KIHN0YXRpYyBpbmxpbmUg
aW50IGx0dG5nX2tyZWZfZ2V0KHN0cnVjdCBrcmVmICprcmVmKQogewotCWlmIChhdG9taWNfYWRk
X3VubGVzcygma3JlZi0+cmVmY291bnQsIDEsIElOVF9NQVgpICE9IElOVF9NQVgpIHsKLQkJcmV0
dXJuIDE7Ci0JfSBlbHNlIHsKLQkJcmV0dXJuIDA7Ci0JfQorCXJldHVybiBhdG9taWNfYWRkX3Vu
bGVzcygma3JlZi0+cmVmY291bnQsIDEsIElOVF9NQVgpOwogfQogCiAjZW5kaWYgLyogX0xUVE5H
X1dSQVBQRVJfS1JFRl9IICovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
