From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: null dereference on error
	path for create_ctx_type
Date: Wed, 25 Jan 2017 19:32:54 -0500
Message-ID: <CA+jJMxtnRVg8N1CXGcFuxFD-bb_R9eJyGDt9o504ZOD9y501kw__40006.8267401823$1485390877$gmane$org@mail.gmail.com>
References: <1484665727-24204-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3v82y9387zzkBC
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2017 00:35:29 +0000 (UTC)
Received: by mail-ua0-x241.google.com with SMTP id i68so20795522uad.1
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jan 2017 16:32:55 -0800 (PST)
In-Reply-To: <1484665727-24204-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4KClRoYW5rcyEKSsOp
csOpbWllCgpPbiAxNyBKYW51YXJ5IDIwMTcgYXQgMTA6MDgsIEpvbmF0aGFuIFJham90dGUKPGpv
bmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gV2hlbiB6bWFsbG9j
IG9mIHR5cGUtPm9wdCBmYWlsIHRoZSBkZXN0cm95X2N0eF90eXBlIHdvdWxkIHJlc3VsdCBpbiBh
Cj4gbnVsbCBkZXJlZmVyZW5jZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUg
PGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9s
dHRuZy9jb21tYW5kcy9hZGRfY29udGV4dC5jIHwgNCArKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0
dG5nL2NvbW1hbmRzL2FkZF9jb250ZXh0LmMgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2FkZF9j
b250ZXh0LmMKPiBpbmRleCA1ZmM2NWJmLi5kZjcyMmJiIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4v
bHR0bmcvY29tbWFuZHMvYWRkX2NvbnRleHQuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmcvY29tbWFu
ZHMvYWRkX2NvbnRleHQuYwo+IEBAIC02NjIsNyArNjYyLDkgQEAgdm9pZCBkZXN0cm95X2N0eF90
eXBlKHN0cnVjdCBjdHhfdHlwZSAqdHlwZSkKPiAgICAgICAgIGlmICghdHlwZSkgewo+ICAgICAg
ICAgICAgICAgICByZXR1cm47Cj4gICAgICAgICB9Cj4gLSAgICAgICBmcmVlKHR5cGUtPm9wdC0+
c3ltYm9sKTsKPiArICAgICAgIGlmICh0eXBlLT5vcHQpIHsKPiArICAgICAgICAgICAgICAgZnJl
ZSh0eXBlLT5vcHQtPnN5bWJvbCk7Cj4gKyAgICAgICB9Cj4gICAgICAgICBmcmVlKHR5cGUtPm9w
dCk7Cj4gICAgICAgICBmcmVlKHR5cGUpOwo+ICB9Cj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
