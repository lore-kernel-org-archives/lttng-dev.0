From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [RFC/PATCH 3/3] babeltrace: add simple tests for
 converter command line options
Date: Wed, 26 Oct 2016 11:29:37 -0500
Message-ID: <3a353056-a549-b626-fce4-cb09fe11c934__26157.3131582283$1477499422$gmane$org@mentor.com>
References: <1477409667-8309-1-git-send-email-nathan_lynch@mentor.com>
 <1477409667-8309-4-git-send-email-nathan_lynch@mentor.com>
 <cf84fcde-92c8-e3fc-90ff-a2dda72d037f@gydle.com>
 <1311701030.5606.1477488992406.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C14FBA0DFF
 for <lttng-dev@lists.lttng.org>; Wed, 26 Oct 2016 16:29:55 +0000 (UTC)
In-Reply-To: <1311701030.5606.1477488992406.JavaMail.zimbra@efficios.com>
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

T24gMTAvMjYvMjAxNiAwODozNiBBTSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gLS0tLS0g
T24gT2N0IDI2LCAyMDE2LCBhdCAzOjExIEFNLCBTZWJhc3RpZW4gQm9pc3ZlcnQgc2JvaXN2ZXJ0
QGd5ZGxlLmNvbSB3cm90ZToKPiAKPj4gSGkgTmF0aGFuLAo+Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL2Jpbi90ZXN0X2Nsb2NrX3NlY29uZHMgYi90ZXN0cy9iaW4vdGVzdF9jbG9ja19zZWNvbmRz
Cj4+PiArIyBbc10rLltubm5ubm5ubm5dCj4+PiArdGltZXN0YW1wX2ZtdD0iXFsiCj4+PiArdGlt
ZXN0YW1wX2ZtdCs9IltbOmRpZ2l0Ol1dKyIgIyBbc10rCj4+PiArdGltZXN0YW1wX2ZtdCs9Ilwu
Igo+Pj4gK3RpbWVzdGFtcF9mbXQrPSJbWzpkaWdpdDpdXXs5fSIgIyBbbm5ubm5ubm5uXQo+Pj4g
K3RpbWVzdGFtcF9mbXQrPSJcXSIKPj4+ICsKPj4KPj4KPj4gSXMgdGhlIHRpbWVzdGFtcCAwLjEy
MzQ1Njc4OSBwb3NzaWJsZSA/Cj4+Cj4+IElzIHRoZXJlIGEgbWluaW11bSBmb3IgdGhlIGxlZnQg
cGFydCwgc29tZXRoaW5nIGxpa2UgRXBvY2ggPwo+IAo+IFdlIGNhbiBhbHNvIGhhdmUgc2xpZ2h0
bHkgbmVnYXRpdmUgdGltZXN0YW1wcyBkdWUgdG8gc3VwcG9ydCBvZgo+IG5vbi1HTVQgdGltZXpv
bmVzLiBBIHRpbWV6b25lIHdpdGggYSBuZWdhdGl2ZSBvZmZzZXQgZnJvbSBHTVQgd2l0aAo+IGFu
IG9mZnNldCAwIChhIHRyYWNlIHdoaWNoIGFwcGVhcnMgdG8gYmUgdGFrZW4gZXhhY3RseSBhdCBl
cG9jaCkKPiBlbmRzIHVwIGF0IHRoZSB2ZXJ5IGVuZCBvZiBEZWMgMzEsIDE5NjkuIEl0IGNhbiBi
ZSByZXByZXNlbnRlZAo+IHdpdGggYSBuZWdhdGl2ZSB0aW1lc3RhbXAgd2l0aCB0aGUgcy5ucyBu
b3RhdGlvbi4KPiAKPiBUaGlzIG1haW5seSBoYXBwZW4gd2hlbiBhIHN5c3RlbSBib290cyB3aXRo
b3V0IG5ldHdvcmsgY29ubmVjdGl2aXR5Cj4gYW5kIHRoaW5rIGl0IGlzIGV4YWN0bHkgYXQgRXBv
Y2guIE5vdCB0aGF0IHVuY29tbW9uIHVuZm9ydHVuYXRlbHkuCgpJIGhhZG4ndCByZWFsbHkgaW50
ZW5kZWQgdG8gbWFrZSB0aGUgcmVnZXhlcyBpbiB0aGVzZSB0ZXN0cyByaWdvcm91cwpiZXlvbmQg
d2hhdCB3YXMgcmVxdWlyZWQgZm9yIHRoZSB3ay1oZWFydGJlYXQtdSBzYW1wbGUgdHJhY2UgYnV0
IEkKc3VwcG9zZSBJIGNvdWxkIGRvIHNvLiAgU2FtcGxlIHRyYWNlcyBmb3IgdGhpcyBraW5kIG9m
IGNhc2Ugd291bGQgYmUKaGVscGZ1bC4KCkFsdGVybmF0aXZlbHksIEkgY291bGQgdGVzdCB2ZXJi
YXRpbSAobm8gcmVnZXhlcykgYWdhaW5zdCB0aGUgb3V0cHV0IG9mOgoKJCBUWj0nJyBiYWJlbHRy
YWNlIC0tY2xvY2stc2Vjb25kcyBcCiAgIHRlc3RzL2N0Zi10cmFjZXMvc3VjY2VlZC93ay1oZWFy
dGJlYXQtdQoKV2hpY2ggc2hvdWxkIGJlIHN0YWJsZSBhY3Jvc3Mgc3lzdGVtcywgbm8/CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
