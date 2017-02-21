From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.2
Date: Mon, 20 Feb 2017 22:25:23 -0500
Message-ID: <CA+jJMxv9=qkb9i=LLmt9xz-dGYMxoO87hzhagXxdO3+VE875JQ__13612.5773344704$1487647537$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x229.google.com (mail-vk0-x229.google.com
 [IPv6:2607:f8b0:400c:c05::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3vS5Vk6QfVzl9n
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 03:25:50 +0000 (UTC)
Received: by mail-vk0-x229.google.com with SMTP id x75so72321078vke.2
 for <lttng-dev@lists.lttng.org>; Mon, 20 Feb 2017 19:25:24 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKV2UgYXJlIHJlbGVhc2luZyBCYWJlbHRyYWNlIDEuNS4yLCB3aGljaCBpcyBhIGJ1
Zy1maXggcmVsZWFzZS4KCkJhYmVsdHJhY2UgaXMgYW4gb3BlbiBzb3VyY2UgdHJhY2UgZm9ybWF0
IGNvbnZlcnRlci4KClRoZSBCYWJlbHRyYWNlIHByb2plY3QgcHJvdmlkZXMgYSBsaWJyYXJ5LCBQ
eXRob24gYmluZGluZ3MgZm9yIHRoaXMKbGlicmFyeSwgYXMgd2VsbCBhcyBhIGhhbmR5IGNvbW1h
bmQtbGluZSB0b29s4oCUYXB0bHkgbmFtZWQKYmFiZWx0cmFjZeKAlHdoaWNoIG1ha2VzIGl0IHZl
cnkgZWFzeSB0byB2aWV3IGFuZCBjb252ZXJ0IHRyYWNlcy4KCkJhYmVsdHJhY2UgaXMgYWxzbyB0
aGUgcmVmZXJlbmNlIHBhcnNlciBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQ29tbW9uClRyYWNlIEZv
cm1hdCAoQ1RGKSwgYSB2ZXJ5IHZlcnNhdGlsZSB0cmFjZSBmb3JtYXQuCgoyMDE3LTAyLTIwIGJh
YmVsdHJhY2UgMS41LjIgKE5hdGlvbmFsIENoZXJyeSBQaWUgRGF5KQogICAgICAgICogQWRkIGVt
cHR5IHBsdWctaW4gaG9va3MgdG8gcHJldmVudCB0aGVpciBlbGltaW5hdGlvbiBieSB0aGUgbGlu
a2VyCiAgICAgICAgKiBQb3J0OiBMaW5rIGxpdmUgbGliIHdpdGggY3RmIHRvIHNhdGlzZnkgY3ln
d2luIGxpbmtlcgogICAgICAgICogUG9ydDogTGluayB3aXRoIG5vLXVuZGVmaW5lZCBvbiBXaW5k
b3dzCiAgICAgICAgKiBQb3J0OiB3aW4zMiBETExzIGRvbid0IHN1cHBvcnQgaGlkZGVuIHN5bWJv
bHMKICAgICAgICAqIFBvcnQ6IHJlcGxhY2Ugc3RyZXJyb3JfcigpIHdpdGggZ2xpYiBnX3N0cmVy
cm9yKCkKClByb2plY3Qgd2Vic2l0ZTogaHR0cDovL2RpYW1vbi5vcmcvYmFiZWx0cmFjZS8KRG93
bmxvYWQgbGluazogaHR0cDovL3d3dy5lZmZpY2lvcy5jb20vZmlsZXMvYmFiZWx0cmFjZS9iYWJl
bHRyYWNlLTEuNS4yLnRhci5iejIKQ1RGIHNwZWNpZmljYXRpb246IGh0dHA6Ly9kaWFtb24ub3Jn
L2N0Zi8KCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
