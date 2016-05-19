From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 07/10] Fix: WARN() should print
 as WARN level, not ERR
Date: Thu, 19 May 2016 00:14:04 -0400
Message-ID: <CA+jJMxv=wzrTXxa-pz335VgZHBQPOP+6PcawUj64DuoxgWp9Kw__17360.5646625676$1463631260$gmane$org@mail.gmail.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463594659-10964-8-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f67.google.com (mail-qg0-f67.google.com
 [209.85.192.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9D9A3A35E2
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 04:14:05 +0000 (UTC)
Received: by mail-qg0-f67.google.com with SMTP id 90so5953014qgz.0
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 21:14:05 -0700 (PDT)
In-Reply-To: <1463594659-10964-8-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

R29vZCBjYXRjaCAoYWdhaW4pISBNZXJnZWQuCgpUaGFua3MsCkrDqXLDqW1pZQoKT24gV2VkLCBN
YXkgMTgsIDIwMTYgYXQgMjowNCBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3ll
cnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9l
cnJvci5oIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2Vycm9yLmggYi9zcmMvY29tbW9uL2Vy
cm9yLmgKPiBpbmRleCBjYTVhZjg2Li45YzlkMmE3IDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24v
ZXJyb3IuaAo+ICsrKyBiL3NyYy9jb21tb24vZXJyb3IuaAo+IEBAIC0xMDMsNyArMTAzLDcgQEAg
ZXh0ZXJuIGludCBsdHRuZ19vcHRfbWk7Cj4gICNkZWZpbmUgRVJSKGZtdCwgYXJncy4uLikgXAo+
ICAgICAgICAgX19sdHRuZ19wcmludChQUklOVF9FUlIsICJFcnJvcjogIiBmbXQgIlxuIiwgIyMg
YXJncykKPiAgI2RlZmluZSBXQVJOKGZtdCwgYXJncy4uLikgXAo+IC0gICAgICAgX19sdHRuZ19w
cmludChQUklOVF9FUlIsICJXYXJuaW5nOiAiIGZtdCAiXG4iLCAjIyBhcmdzKQo+ICsgICAgICAg
X19sdHRuZ19wcmludChQUklOVF9XQVJOLCAiV2FybmluZzogIiBmbXQgIlxuIiwgIyMgYXJncykK
Pgo+ICAjZGVmaW5lIEJVRyhmbXQsIGFyZ3MuLi4pIF9FUlJNU0coIkJVRyIsIFBSSU5UX0JVRywg
Zm10LCAjIyBhcmdzKQo+Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
