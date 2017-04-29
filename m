From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: lttng-tools build failure with uClibc due to
 dlmopen()
Date: Sat, 29 Apr 2017 15:48:23 +0200
Message-ID: <20170429154823.4cbd2d32__6559.9417467185$1493474304$gmane$org@free-electrons.com>
References: <20170301000945.38a285dc@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3wFXNH4fVCzD54
 for <lttng-dev@lists.lttng.org>; Sat, 29 Apr 2017 13:58:55 +0000 (UTC)
Received: from localhost (132.230.147.77.rev.sfr.net [77.147.230.132])
 by mail.free-electrons.com (Postfix) with ESMTPSA id 543332070F
 for <lttng-dev@lists.lttng.org>; Sat, 29 Apr 2017 15:48:24 +0200 (CEST)
In-Reply-To: <20170301000945.38a285dc@free-electrons.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGVsbG8sCgpPbiBXZWQsIDEgTWFyIDIwMTcgMDA6MDk6NDUgKzAxMDAsIFRob21hcyBQZXRhenpv
bmkgd3JvdGU6Cgo+IEZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciBoYXZpbmcgZml4ZWQgdGhlIGRs
bW9wZW4gaXNzdWUgd2l0aCBtdXNsIGluCj4gbHR0bmctdXN0LiBOb3csIHRoZXJlIGlzIGFub3Ro
ZXIgZGxtb3BlbiBpc3N1ZSwgdGhpcyB0aW1lIGluCj4gbHR0bmctdG9vbHMsIGFuZCB0aGlzIHRp
bWUgd2l0aCB1Q2xpYmM6Cj4gCj4gICBDQyAgICAgICBwcm9nLm8KPiBwcm9nLmM6IEluIGZ1bmN0
aW9uICdtYWluJzoKPiBwcm9nLmM6MjQ6Nzogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24gJ2RsbW9wZW4nIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+
ICAgaDEgPSBkbG1vcGVuKExNX0lEX0JBU0UsICJsaWJmb28uc28iLCBSVExEX0xBWlkpOwo+ICAg
ICAgICBeCj4gcHJvZy5jOjI0OjE1OiBlcnJvcjogJ0xNX0lEX0JBU0UnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQo+ICAgaDEgPSBkbG1vcGVuKExNX0lEX0JBU0UsICJs
aWJmb28uc28iLCBSVExEX0xBWlkpOwo+ICAgICAgICAgICAgICAgIF4KPiBwcm9nLmM6MjQ6MTU6
IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBm
b3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4gCj4gU2VlCj4gaHR0cDovL2F1dG9idWls
ZC5idWlsZHJvb3QubmV0L3Jlc3VsdHMvYzA3L2MwN2I1YmFjNjE0NmQ4M2MzMjI0ZGUxNDdkYTM3
OThkM2U3YjUyN2YvYnVpbGQtZW5kLmxvZwo+IGZvciB0aGUgZnVsbCBidWlsZCBsb2cuCj4gCj4g
U28sIHRoZSB1c3QgcmVncmVzc2lvbiB0ZXN0IGNhc2UgaW4gbHR0bmctdG9vbHMgZG9lc24ndCB0
ZXN0IGlmCj4gZGxtb3BlbigpIGlzIHByb3ZpZGVkIGJ5IHRoZSBDIGxpYnJhcnkgYmVmb3JlIHVz
aW5nIGl0LgoKQW55IGZlZWRiYWNrIG9uIHRoaXMgaXNzdWU/IFdlJ3JlIHN0aWxsIHNlZWluZyBp
dCBpbiBCdWlsZHJvb3Qgd2hlbgpidWlsZGluZyBsdHRuZy10b29scyBhZ2FpbnN0IHVDbGliYy4K
ClRoYW5rcywKClRob21hcwotLSAKVGhvbWFzIFBldGF6em9uaSwgQ1RPLCBGcmVlIEVsZWN0cm9u
cwpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9mcmVlLWVsZWN0
cm9ucy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
