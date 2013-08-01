From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
	realloc.
Date: Thu, 1 Aug 2013 21:57:28 +0400
Message-ID: <CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg__37845.4732629054$1375379911$gmane$org@mail.gmail.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amonakov@gmail.com>) id 1V4x81-0007gV-MV
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 13:57:39 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so4533891obb.1
	for <lttng-dev@lists.lttng.org>; Thu, 01 Aug 2013 10:57:28 -0700 (PDT)
In-Reply-To: <51FA9AD8.4010502@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCBBdWcgMSwgMjAxMyBhdCA5OjI4IFBNLCBTdGVmYW4gU2VlZmVsZAo8c3RlZmFuX3Nl
ZWZlbGRAbWVudG9yLmNvbT4gd3JvdGU6Cj4gSSBkb24ndCB0aGluayBhbnkgb2YgdGhpcyB3b3Jr
cy4gVGhlIHVsdGltYXRlIHByb2JsZW0gaXMgdGhlIG9uZSBKw6lyw6ltaWUKPiByZXBvcnRlZCBp
bml0aWFsbHk6IGRsc3ltIHdpbGwgZXZlbnR1YWxseSBjYWxsIGZyZWUoKSBvbiB0aGUgbWVtb3J5
Cj4gY2FsbG9jKCkgcmV0dXJuZWQsIHNvIG15IGNhbGxvYyBmYWxsYmFjayBuZWVkcyB0byByZXR1
cm4gc29tZXRoaW5nIHRoYXQKPiBjYW4gYWN0dWFsbHkgYmUgZnJlZWQuCgpJIHBvaW50ZWQgb3V0
IGhvdyBmcmVlKCkgd2lsbCBiZSBzYWZlIHNwZWNpZmljYWxseToKCj4+IGRsc3ltIHN0b3JlcyBw
b2ludGVyIHRvIGNhbGxvYydlZCBidWZmZXIsIG92ZXJ3cml0aW5nIHRoZSBwb2ludGVyIHRvIG1t
YXAnZWQKPj4gYnVmZmVyLCBjb21wbGV0aW5nIGluaXRpYWxpemF0aW9uIGZvciB0aGUgc2Vjb25k
IHRpbWUgYW5kIG1ha2luZyB0aGUKPj4gc3Vic2VxdWVudCBmcmVlKCkgc2FmZS4KCkJlc2lkZXMs
IHlvdSdyZSBpbnRlcmNlcHRpbmcgZnJlZSgpIGluIHlvdXIgTERfUFJFTE9BRCBtb2R1bGUgYXMg
d2VsbCwKc28geW91IGNhbiBqdXN0IGNhdGNoIGF0dGVtcHRzIHRvIGZyZWUgeW91ciBtbWFwJ2Vk
IGJ1ZmZlcnMgdGhlcmUgYW5kCm11bm1hcCB0aGVtIHNhZmVseS4KCkFsZXhhbmRlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
