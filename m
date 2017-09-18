From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: use the in-tree
	tap-driver.sh
Date: Mon, 18 Sep 2017 17:53:06 -0400
Message-ID: <CA+jJMxteq2NHjB6GE7i0YUp2z2C3V5WqCzoa+Smi10Z02AsMfw__8895.73179088092$1505771594$gmane$org@mail.gmail.com>
References: <1505768819-20248-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3xx09w1XWhzDSD
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:53:08 +0000 (UTC)
Received: by mail-qk0-x241.google.com with SMTP id r66so1171056qke.4
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 14:53:08 -0700 (PDT)
In-Reply-To: <1505768819-20248-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

SSBtaXNzZWQgeW91ciBwYXRjaCBieSBhIGNvdXBsZSBtaW51dGVzLCBmaXhlZCBieToKCmNvbW1p
dCAxMWQzMjhkZWNhYTAzM2FjNWI5OGIzMzNjNGFlY2ZjMWQ4MmY2YmY1CkF1dGhvcjogUGhpbGlw
cGUgUHJvdWx4IDxlZXBwZWxpdGVsb29wQGdtYWlsLmNvbT4KRGF0ZTogICBNb24gU2VwIDE4IDE3
OjI3OjI4IDIwMTcgLTA0MDAKCiAgICBGaXg6IHRlc3RzL01ha2VmaWxlLmFtOiBhZGQgbWlzc2lu
ZyBMT0dfRFJJVkVSCgogICAgU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgUHJvdWx4IDxlZXBwZWxp
dGVsb29wQGdtYWlsLmNvbT4KICAgIFNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUg
PGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiAx
OCBTZXB0ZW1iZXIgMjAxNyBhdCAxNzowNiwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5z
b25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy9NYWtlZmlsZS5hbSB8IDMgKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9NYWtl
ZmlsZS5hbSBiL3Rlc3RzL01ha2VmaWxlLmFtCj4gaW5kZXggYzVkNjFiYS4uZjljMjA3ZiAxMDA2
NDQKPiAtLS0gYS90ZXN0cy9NYWtlZmlsZS5hbQo+ICsrKyBiL3Rlc3RzL01ha2VmaWxlLmFtCj4g
QEAgLTEsNSArMSw4IEBACj4gIFNVQkRJUlMgPSB1dGlscyBjbGkgbGliIGJpbmRpbmdzIHBsdWdp
bnMKPgo+ICtMT0dfRFJJVkVSX0ZMQUdTPSctLW1lcmdlJwo+ICtMT0dfRFJJVkVSID0gZW52IEFN
X1RBUF9BV0s9JyQoQVdLKScgJChTSEVMTCkgJCh0b3Bfc3JjZGlyKS9jb25maWcvdGFwLWRyaXZl
ci5zaAo+ICsKPiAgRVhUUkFfRElTVCA9ICQoc3JjZGlyKS9jdGYtdHJhY2VzLyoqIFwKPiAgICAg
ICAgICAgICAgJChzcmNkaXIpL2RlYnVnLWluZm8tZGF0YS8qKiBcCj4gICAgICAgICAgICAgICQo
c3JjZGlyKS9kZWJ1Zy1pbmZvLWRhdGEvLmJ1aWxkLWlkL2NkLyoqCj4gLS0KPiAyLjcuNAo+CgoK
Ci0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lv
cy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
