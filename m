From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH v2 03/13] Terminate dispatch thread
 after reg_apps_thread is terminated
Date: Wed, 13 Dec 2017 20:55:26 -0500
Message-ID: <CA+jJMxsM-9UbBtmuUuWwnccQmo3tSNLmiMQCwUDV69unPnsqbw__46886.1889829443$1513216557$gmane$org@mail.gmail.com>
References: <20170918225206.17725-1-jonathan.rajotte-julien@efficios.com>
 <20170918225206.17725-4-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3yxxVC27MCzhcL
 for <lttng-dev@lists.lttng.org>; Thu, 14 Dec 2017 01:55:47 +0000 (UTC)
Received: by mail-yb0-x241.google.com with SMTP id k2so2371015ybd.2
 for <lttng-dev@lists.lttng.org>; Wed, 13 Dec 2017 17:55:47 -0800 (PST)
In-Reply-To: <20170918225206.17725-4-jonathan.rajotte-julien@efficios.com>
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

Tm8gb2JqZWN0aW9uIHRvIHRoZSBjb2RlLCBidXQgcGxlYXNlIGFkZCBhIGRlc2NyaXB0aW9uIGFu
ZCBjb21tZW50LgoKSsOpcsOpbWllCgpPbiAxOCBTZXB0ZW1iZXIgMjAxNyBhdCAxODo1MSwgSm9u
YXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1
bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5j
IHwgNyArKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMgYi9z
cmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+IGluZGV4IDQ1YzAyNzBlLi4wY2E3MmVjOCAx
MDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+ICsrKyBiL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jCj4gQEAgLTQ5Nyw5ICs0OTcsNiBAQCBzdGF0aWMgdm9p
ZCBzdG9wX3RocmVhZHModm9pZCkKPiAgICAgICAgICAgICAgICAgRVJSKCJ3cml0ZSBlcnJvciBv
biB0aHJlYWQgcXVpdCBwaXBlIik7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIC8qIERpc3BhdGNo
IHRocmVhZCAqLwo+IC0gICAgICAgQ01NX1NUT1JFX1NIQVJFRChkaXNwYXRjaF90aHJlYWRfZXhp
dCwgMSk7Cj4gLSAgICAgICBmdXRleF9udG8xX3dha2UoJnVzdF9jbWRfcXVldWUuZnV0ZXgpOwo+
ICB9Cj4KPiAgLyoKPiBAQCAtNjMwNiw2ICs2MzAzLDEwIEBAIGV4aXRfY2xpZW50Ogo+ICAgICAg
ICAgICAgICAgICByZXR2YWwgPSAtMTsKPiAgICAgICAgIH0KPiAgZXhpdF9yZWdfYXBwczoKPiAr
ICAgICAgIC8qIEluc3RydWN0IHRoZSBkaXNwYXRjaCB0aHJlYWQgdG8gcXVpdCAqLwo+ICsgICAg
ICAgQ01NX1NUT1JFX1NIQVJFRChkaXNwYXRjaF90aHJlYWRfZXhpdCwgMSk7Cj4gKyAgICAgICBm
dXRleF9udG8xX3dha2UoJnVzdF9jbWRfcXVldWUuZnV0ZXgpOwo+ICsKPiAgICAgICAgIHJldCA9
IHB0aHJlYWRfam9pbihkaXNwYXRjaF90aHJlYWQsICZzdGF0dXMpOwo+ICAgICAgICAgaWYgKHJl
dCkgewo+ICAgICAgICAgICAgICAgICBlcnJubyA9IHJldDsKPiAtLQo+IDIuMTEuMAo+CgoKCi0t
IApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
