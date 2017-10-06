From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v3 2/2] man: document dead-peer
	detection for relayd
Date: Fri,  6 Oct 2017 14:22:47 -0400
Message-ID: <20171006182247.6874-2-jonathan.rajotte-julien__40875.2521653243$1507314196$gmane$org@efficios.com>
References: <20171006182247.6874-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y7ygH4vrtztBW
 for <lttng-dev@lists.lttng.org>; Fri,  6 Oct 2017 18:23:07 +0000 (UTC)
In-Reply-To: <20171006182247.6874-1-jonathan.rajotte-julien@efficios.com>
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
ZWZmaWNpb3MuY29tPgotLS0KIGRvYy9tYW4vbHR0bmctcmVsYXlkLjgudHh0IHwgMTkgKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kb2MvbWFuL2x0dG5nLXJlbGF5ZC44LnR4dCBiL2RvYy9tYW4vbHR0bmctcmVsYXlkLjgu
dHh0CmluZGV4IDIxODUyNmExLi5lMzdjZTg0NSAxMDA2NDQKLS0tIGEvZG9jL21hbi9sdHRuZy1y
ZWxheWQuOC50eHQKKysrIGIvZG9jL21hbi9sdHRuZy1yZWxheWQuOC50eHQKQEAgLTE2Miw2ICsx
NjIsMjUgQEAgRU5WSVJPTk1FTlQgVkFSSUFCTEVTCiBgTFRUTkdfUkVMQVlEX0hFQUxUSGA6Ogog
ICAgIFBhdGggdG8gcmVsYXkgZGFlbW9uIGhlYWx0aCdzIHNvY2tldC4KIAorYExUVE5HX1JFTEFZ
RF9UQ1BfS0VFUF9BTElWRV9FTkFCTEVgOjoKKyAgICBTZXQgdG8gMSB0byBlbmFibGUgdGhlIHVz
ZSBvZiB0Y3Aga2VlcC1hbGl2ZSBhbGxvd2luZyB0aGUgZGV0ZWN0aW9uIG9mIGRlYWQKKyAgICBw
ZWVycy4KKworYExUVE5HX1JFTEFZRF9UQ1BfS0VFUF9BTElWRV9USU1FYDo6CisgICAgU2VlIHRj
cCg3KSB0Y3Bfa2VlcGFsaXZlX3RpbWUgb3IgdGNwX2tlZXBhbGl2ZV9pbnRlcnZhbCBvbiBTb2xh
cmlzIDExLgorICAgIEEgdmFsdWUgb2YgLTEgbGV0cyB0aGUgb3BlcmF0aW5nIHN5c3RlbSBtYW5h
Z2UgdGhpcyBwYXJhbWV0ZXIgKGRlZmF1bHQpLgorCitgTFRUTkdfUkVMQVlEX1RDUF9LRUVQX0FM
SVZFX1BST0JFU2A6OgorICAgIFNlZSB0Y3AoNykgdGNwX2tlZXBhbGl2ZV9wcm9iZXMuCisgICAg
QSB2YWx1ZSBvZiAtMSBsZXRzIHRoZSBvcGVyYXRpbmcgc3lzdGVtIG1hbmFnZSB0aGlzIHBhcmFt
ZXRlciAoZGVmYXVsdCkuCisKK05PVEU6IE5vdCBzdXBwb3J0ZWQgb24gU29sYXJpcy4KKworYExU
VE5HX1JFTEFZRF9UQ1BfS0VFUF9BTElWRV9JTlRWTGA6OgorICAgIFNlZSB0Y3AoNykgdGNwX2tl
ZXBhbGl2ZV9pbnR2bC4KKyAgICBBIHZhbHVlIG9mIC0xIGxldHMgdGhlIG9wZXJhdGluZyBzeXN0
ZW0gbWFuYWdlIHRoaXMgcGFyYW1ldGVyIChkZWZhdWx0KS4KKworTk9URTogTm90IHN1cHBvcnRl
ZCBvbiBTb2xhcmlzLgogCiBGSUxFUwogLS0tLS0KLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
