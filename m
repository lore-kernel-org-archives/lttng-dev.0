From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: liblttng-ust overhead, take 2
Date: Thu, 7 Sep 2017 14:07:19 -0400
Message-ID: <CAB4xu_1L6noYo=Uxw6h5H_0+di2kHwNbtiycEn8kn72LuYjURg__45716.8833622292$1504807707$gmane$org@mail.gmail.com>
References: <1671874.aHIhmVXznC@milian-kdab2>
 <CA+jJMxvhEEMLCHwukqrmvuvEL+bSn9h_Acz7=nhZPaSV2xGgsQ@mail.gmail.com>
 <65439674.cr8eqjdoCK@milian-kdab2>
 <257847924.5427.1504806922162.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x235.google.com (mail-qt0-x235.google.com
 [IPv6:2607:f8b0:400d:c0d::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3xp7j25f7qzCXP
 for <lttng-dev@lists.lttng.org>; Thu,  7 Sep 2017 18:07:50 +0000 (UTC)
Received: by mail-qt0-x235.google.com with SMTP id m35so1243179qte.1
 for <lttng-dev@lists.lttng.org>; Thu, 07 Sep 2017 11:07:50 -0700 (PDT)
In-Reply-To: <257847924.5427.1504806922162.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCBTZXAgNywgMjAxNyBhdCAxOjU1IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBBbHNvLCBwbGVhc2Ugbm90ZSB0aGF0
IGx0dG5nLW1vZHVsZXMgZXhwb3NlcyBhIC9wcm9jL2x0dG5nLWxvZ2dlcgo+IGZpbGUsIGludG8g
d2hpY2ggeW91IGNhbiB3cml0ZSBmcm9tIHVzZXItc3BhY2UuIEl0IGVuZHMgdXAgaW4gdGhlCj4g
a2VybmVsIHRyYWNlLiBUaGlzIGNvdWxkIGRvIHRoZSB0cmljayBpZiBmb3Igc29tZSByZWFzb24g
bHR0bmctdXN0Cj4gZG9lcyBub3Qgd29yayBmb3IgeW91ciBzY2VuYXJpby4gSG93ZXZlciwgdGhl
IGx0dG5nLWxvZ2dlciBwcm9jCj4gZmlsZSBpcyBqdXN0IHRoZXJlIGFzIGEgY29udmVuaWVuY2Ug
Zm9yIHNjcmlwdHMsIGFuZCBpcyBieSBubyBtZWFuCj4gYSAiZmFzdCIgdHJhY2luZyBpbnRlcmZh
Y2UuCgpTZWUgPGh0dHA6Ly9sdHRuZy5vcmcvZG9jcy92Mi4xMC8jZG9jLXByb2MtbHR0bmctbG9n
Z2VyLWFiaT4uCgpQaGlsCgo+Cj4gVGhhbmtzLAo+Cj4gTWF0aGlldQo+Cj4gPgo+ID4gVGhhbmtz
Cj4gPgo+ID4gLS0KPiA+IE1pbGlhbiBXb2xmZiB8IG1pbGlhbi53b2xmZkBrZGFiLmNvbSB8IFNl
bmlvciBTb2Z0d2FyZSBFbmdpbmVlcgo+ID4gS0RBQiAoRGV1dHNjaGxhbmQpIEdtYkgmQ28gS0cs
IGEgS0RBQiBHcm91cCBjb21wYW55Cj4gPiBUZWw6ICs0OS0zMC01MjEzMjU0NzAKPiA+IEtEQUIg
LSBUaGUgUXQgRXhwZXJ0cwo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKPgo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJ
bmMuCj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
