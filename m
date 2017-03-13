From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: handle syscall table
	resizing if nbmem is equal to zero
Date: Mon, 13 Mar 2017 18:13:17 -0400
Message-ID: <1489443197-12484-2-git-send-email-jonathan.rajotte-julien__49892.5508269624$1489443229$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vhsZp70KQzwhg
 for <lttng-dev@lists.lttng.org>; Mon, 13 Mar 2017 22:13:38 +0000 (UTC)
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

TFRUbmctbW9kdWxlcyByZXR1cm5zIGluZGV4ZXMgc3RhcnRpbmcgZnJvbSB6ZXJvLiBIZW5jZSwg
aWYgbmJtZW0gaXMgemVybwphbmQgaW5kZXggaXMgemVybyB0aGUgdGFibGUgd2lsbCBmYWlsIHRv
IGdyb3cgdG8gY29udGFpbiBvbmUKZWxlbWVudC4KClRoaXMgc2l0dWF0aW9uIHNob3VsZCBuZXZl
ciBoYXBwZW4gc2luY2UgbmJtZW0gaXMgYXNzaWduZWQgdGhlIHZhbHVlIG9mClNZU0NBTExfVEFC
TEVfSU5JVF9TSVpFIHdoaWNoIGlzIDI1NiBjdXJyZW50bHkuCgpTaWduZWQtb2ZmLWJ5OiBKb25h
dGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Ci0tLQog
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxsLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL3N5c2NhbGwuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5jCmlu
ZGV4IGMyMWU0ZDguLjUxMjE0YmYgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
c3lzY2FsbC5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5jCkBAIC04NSw3
ICs4NSw3IEBAIGludCBzeXNjYWxsX2luaXRfdGFibGUodm9pZCkKIAkJCXNpemVfdCBuZXdfbmJt
ZW07CiAKIAkJCS8qIERvdWJsZSBtZW1vcnkgc2l6ZS4gKi8KLQkJCW5ld19uYm1lbSA9IG1heChp
bmRleCwgbmJtZW0gPDwgMSk7CisJCQluZXdfbmJtZW0gPSBtYXgoaW5kZXggKyAxLCBuYm1lbSA8
PCAxKTsKIAkJCWlmIChuZXdfbmJtZW0gPiAoU0laRV9NQVggLyBzaXplb2YoKm5ld19saXN0KSkp
IHsKIAkJCQkvKiBPdmVyZmxvdywgc3RvcCBldmVyeXRoaW5nLCBzb21ldGhpbmcgd2VudCByZWFs
bHkgd3JvbmcuICovCiAJCQkJRVJSKCJTeXNjYWxsIGxpc3RpbmcgbWVtb3J5IHNpemUgb3ZlcmZs
b3cuIFN0b3BwaW5nIik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
