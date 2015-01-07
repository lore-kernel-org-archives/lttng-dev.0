From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Cleanup: lock file already
 taken is error, not warning
Date: Wed, 7 Jan 2015 16:10:57 -0500
Message-ID: <CA+jJMxsvSVoqDt1qzYyx3bWUfsG4OsPegPNT_3o6xGQ_aAc0Hg__27117.3830064528$1420665223$gmane$org@mail.gmail.com>
References: <1420491529-12389-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Y8xsd-0003JI-BP
 for lttng-dev@lists.lttng.org; Wed, 07 Jan 2015 16:11:05 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so1546674qcv.29
 for <lttng-dev@lists.lttng.org>; Wed, 07 Jan 2015 13:10:58 -0800 (PST)
In-Reply-To: <1420491529-12389-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIE1vbiwgSmFuIDUsIDIwMTUgYXQgMzo1OCBQ
TSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3Jv
dGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi91dGlscy5jIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9zcmMvY29tbW9uL3V0aWxzLmMgYi9zcmMvY29tbW9uL3V0aWxzLmMKPiBpbmRleCAzNDI4ZDMx
Li43ZjkxZGNiIDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vdXRpbHMuYwo+ICsrKyBiL3NyYy9j
b21tb24vdXRpbHMuYwo+IEBAIC01MTYsNyArNTE2LDcgQEAgaW50IHV0aWxzX2NyZWF0ZV9sb2Nr
X2ZpbGUoY29uc3QgY2hhciAqZmlsZXBhdGgpCj4gICAgICAgICAgKi8KPiAgICAgICAgIHJldCA9
IGZsb2NrKGZkLCBMT0NLX0VYIHwgTE9DS19OQik7Cj4gICAgICAgICBpZiAocmV0KSB7Cj4gLSAg
ICAgICAgICAgICAgIFdBUk4oIkNvdWxkIG5vdCBnZXQgbG9jayBmaWxlICVzLCBhbm90aGVyIGlu
c3RhbmNlIGlzIHJ1bm5pbmcuIiwKPiArICAgICAgICAgICAgICAgRVJSKCJDb3VsZCBub3QgZ2V0
IGxvY2sgZmlsZSAlcywgYW5vdGhlciBpbnN0YW5jZSBpcyBydW5uaW5nLiIsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgZmlsZXBhdGgpOwo+ICAgICAgICAgICAgICAgICBpZiAoY2xvc2UoZmQp
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgUEVSUk9SKCJjbG9zZSBsb2NrIGZpbGUiKTsK
PiAtLQo+IDIuMS4xCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
