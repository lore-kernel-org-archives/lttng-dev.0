From: "jia,fang" <fang.jia@windriver.com>
Subject: Re: BUG: lttng-ust enable-event with filter,
	tracing error
Date: Mon, 17 Aug 2015 18:55:30 +0800
Message-ID: <55D1BDA2.3000108__18320.4245441177$1439809030$gmane$org@windriver.com>
References: <55CB1674.1060605@windriver.com> <55CD8D18.7000500@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Fang.Jia@windriver.com>) id 1ZRI5P-00077q-2C
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 06:56:17 -0400
In-Reply-To: <55CD8D18.7000500@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGkgbWF0aGlldQoKQ291bGQgeW91IGhlbHAgbWUgdG8gaW5mb3JtIHRoaXMgaXNzdWUgPz8KClRo
YW5rcyBhIGxvdC4KCgpPbiAyMDE15bm0MDjmnIgxNOaXpSAxNDozOSwgamlhLGZhbmcgd3JvdGU6
Cj4gSGksCj4gCj4gQ291bGQgeW91IGhlbHAgbWUgdG8gaW5mb3JtIHRoaXMgaXNzdWUgPwo+IAo+
IEkgZm91bmQgdGhhdCBpZiBlbmFibGUtZXZlbnQgd2l0aCBmaWx0ZXIgYW5kIHRoZW4gc3RhcnQg
dHJhY2Vwb2ludCwKPiB5b3UgY2FuIG5vdCBzdG9wIHlvdXIgdHJhY2luZyBldmVuIGlmIHlvdSBk
aXNhYmxlIHlvdXIgZXZlbnQuCj4gCj4gRG8geW91IGhhdmUgdGhpcyBwcm9ibGVtID8KPiAKPiBU
aGFua3MgYSBsb3QuCj4gCj4gCj4gSGVyZSBpcyBteSBkZXRhaWwgaW5mbzoKPiAKPiBNeSBzeXN0
ZW0gaXMgVWJ1bnR1MTQuMDQsIGFuZCBMdHRuZy12ZXJzaW9uIGlzIGx0dG5nIHZlcnNpb24gMi43
LjAtcHJlIC0gR2FpYSAtCj4gdjIuNi4wLXJjMS0yNDItZzYwZjcwMzUuCj4gCj4gSSBidWlsZCB1
c2VyIGFwcGxpY2F0aW9uICJoZWxsbyIgYXMKPiBodHRwOi8vbHR0bmcub3JnL2RvY3MvdjIuNi8j
ZG9jLXRyYWNpbmcteW91ci1vd24tdXNlci1hcHBsaWNhdGlvbiB0b2xkLiBBbmQKPiBtb2RpZnkg
cGFydCBvZiB0aGUgaGVsbG8uYyBhcyBmb2xsb3c6Cj4gZm9yKDs7KQo+IHsKPiBzbGVlcCgyKTsK
PiBmb3IgKHggPSAwOyB4IDwgYXJnYzsgKyt4KSB7Cj4gICAgICAgICB0cmFjZXBvaW50KGhlbGxv
X3dvcmxkLCBteV9maXJzdF90cmFjZXBvaW50LCB4LCBhcmd2W3hdKTsKPiAgICAgfQo+IH0KPiAK
PiBUaGVuIEkgZG8gdGhpczoKPiAxLyBsdHRuZyBjcmVhdGUgbXlzZXNzaW9uCj4gMi8gbHR0bmcg
ZW5hYmxlLWV2ZW50IGhlbGxvX3dvcmxkOm15X2ZpcnN0X3RyYWNlcG9pbnQgLS1maWx0ZXIgJyRj
dHgucHJvY25hbWUgPT0KPiAiLi9oZWxsbyoiJyAtLXNlc3Npb24gbXlzZXNzaW9uIC11IC1jIGNo
YW5uZWwKPiAKPiAzLyBsdHRuZyBlbmFibGUtZXZlbnQgaGVsbG9fd29ybGQ6bXlfZmlyc3RfdHJh
Y2Vwb2ludCAtLXNlc3Npb24gbXlzZXNzaW9uIC11IC1jCj4gY2hhbm5lbAo+IAo+IDQvIC4vaGVs
bG8KPiBJIHByZXNzIEVudGVyIHRvIHN0YXJ0IHRyYWNlcG9pbnQKPiAKPiA1LyBsdHRuZyBkaXNh
YmxlLWV2ZW50IC0tc2Vzc2lvbiBteXNlc3Npb24gLS1jaGFubmVsIGNoYW5uZWwgLS11c2Vyc3Bh
Y2UKPiBoZWxsb193b3JsZDpteV9maXJzdF90cmFjZXBvaW50Cj4gCj4gNi8gbHR0bmcgc3RhcnQK
PiAKPiA3LyBsdHRuZyBzdG9wCj4gCj4gOC8gbHR0bmcgdmlldwo+IAo+IE15IGRldGFpbCBsb2cg
aXMgYXMgYXR0YWNobWVudAo+IAo+IAo+IAo+IEJSLAo+IEZhbmcKPiAKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
