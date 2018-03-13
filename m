From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [lttng-ust] Missing events when just before a
 process exits
Date: Tue, 13 Mar 2018 11:35:04 -0400
Message-ID: <20180313153504.GD29367__8844.8936156512$1520955200$gmane$org@joraj-alpa>
References: <13B832E4CA0EA14BAB2DA7118C642FF76CFFCC43@XMB-DCFR-35.europe.corp.altran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 400zSc6d6vzlq
 for <lttng-dev@lists.lttng.org>; Tue, 13 Mar 2018 11:35:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <13B832E4CA0EA14BAB2DA7118C642FF76CFFCC43@XMB-DCFR-35.europe.corp.altran.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: THEUNISSEN Rolf <rolf.theunissen@altran.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgUm9sZiwKCk9uIFR1ZSwgTWFyIDEzLCAyMDE4IGF0IDEwOjQ4OjE3QU0gKzAwMDAsIFRIRVVO
SVNTRU4gUm9sZiB3cm90ZToKPiBIaSwKPiAKPiBJIGFtIGN1cnJlbnRseSB0cmFjaW5nIG1hbnkg
cHJvY2Vzc2VzIHdpdGggTFRUbmctVVNUIG9uIGEgc3lzdGVtIHVuZGVyIGhlYXZ5IGxvYWQsIHdp
dGggMiBDUFVzLgo+IAo+IFRoZSB0cmFjZXMgc2VlbSB0byBiZSBtaXNzaW5nIHVzdC1ldmVudHMg
bmVhciB0aGUgZW5kIG9mIGEgdHJhY2UuIEFmdGVyIGRvaW5nIHNvbWUgYW5hbHlzaXMsIGl0IHNl
ZW1zIHRoYXQgZXZlbnRzIGFyZSBtaXNzaW5nIGZyb20gdGhlIG90aGVyIENQVSB0aGVuIHRoZSBw
cm9jZXNzIGV4aXRzIG9uLiBNb3JlIGNvbmNyZXRlbHk6Cj4gCj4gRHVyaW5nIHRoZSBsaWZldGlt
ZSBvZiBhIHByb2Nlc3M6Cj4gLSBQcm9jZXNzIFggZXhlY3V0ZXMgb24gQ1BVIDAsMTogYWxsIGV2
ZW50cyBhcmUgaW4gdGhlIHRyYWNlCj4gSnVzdCBiZWZvcmUgdGhlIHByb2Nlc3MgaXMgYWJvdXQg
dG8gZXhpdDoKPiAtIFByb2Nlc3MgWCBleGVjdXRlcyBvbiBDUFUgMDogbWlzc2luZyBldmVudHMg
ZnJvbSB0aGUgdHJhY2UKCkhvdyBhcmUgeW91IHZhbGlkYXRpbmcgdGhpcz8KCj4gQSBmZXcgbWls
aS1zZWNvbmRzIGxhdGVyOgo+IC0gUHJvY2VzcyBYIGV4ZWN1dGVzIG9uIENQVTEgYW5kIGV4aXRz
OiBUaGUgbGFzdCBldmVudHMgYXJlIGluIHRoZSB0cmFjZQoKVGhpcyBpcyBub3QgZXhwZWN0ZWQu
IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBzbyB3ZSBjYW4gY2hlY2sgd2hhdCBtaWdodCBiZQpo
YXBwZW5pbmc/CgpXZSB3aWxsIG5lZWQgdGhlIHZlcnNpb24gZm9yIGx0dG5nLXVzdCwgbHR0bmct
dG9vbHMsIGJhYmVsdHJhY2UuCgpOb3RlIHRoYXQgeW91IGNhbiBydW4geW91ciBhcHBsaWNhdGlv
biB3aXRoIGx0dG5nLXVzdCBpbiBkZWJ1ZyBtb2RlIHVzaW5nCkxUVE5HX1VTVF9ERUJVRz15LiBE
ZWJ1ZyBzdGF0ZW1lbnRzIHdpbGwgYmUgb3V0cHV0dGVkIG9uIHN0ZGVyci4KCmUuZzoKICAgICQg
TFRUTkdfVVNUX0RFQlVHPXkgLi9teV9zYW1wbGVfYXBwCgpDaGVlcnMKCi0tIApKb25hdGhhbiBS
YWpvdHRlLUp1bGllbgpFZmZpY2lPUwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
