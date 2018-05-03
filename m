From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-tools 2.10.4 broken when auto loading session
Date: Thu, 3 May 2018 11:32:58 -0400
Message-ID: <20180503153252.GA2332__48748.9926898435$1525361474$gmane$org@joraj-alpa>
References: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40cK0h16MHz17cv
 for <lttng-dev@lists.lttng.org>; Thu,  3 May 2018 11:33:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Wallin <wallinux@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCBNYXkgMDMsIDIwMTggYXQgMTI6Mjc6NDhQTSArMDAwMCwgQW5kZXJzIFdhbGxpbiB3
cm90ZToKPiBIaSwKPiAKPiBsdHRuZy10b29scyBoYW5ncyB3aGVuIGEgc2Vzc2lvbiBpcyBzdG9y
ZWQgL2V0Yy9sdHRuZy9zZXNzaW9uL2F1dG8vCj4gCj4gJCBoZWFkIC0xMCAvZXRjL2x0dG5nL3Nl
c3Npb25zL2F1dG8vdGVzdC5sdHRuZwo+IDw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9IlVU
Ri04Ij8+Cj4gPHNlc3Npb25zPgo+ICAgICAgICAgPHNlc3Npb24+Cj4gICAgICAgICAgICAgICAg
IDxuYW1lPnRlc3Q8L25hbWU+Cj4gICAgICAgICAgICAgICAgIDxkb21haW5zPgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIDxkb21haW4+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8dHlwZT5VU1Q8L3R5cGU+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8YnVm
ZmVyX3R5cGU+UEVSX1VJRDwvYnVmZmVyX3R5cGU+Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8Y2hhbm5lbHM+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDxjaGFubmVsPgoKQ291bGQgeW91IGdpdmUgdXMgdGhlIGNvbXBsZXRlIHhtbD8KCkNoZWVy
cwoKPiAkIGx0dG5nLXNlc3Npb25kIC1kICAjIEhhbmdpbmcgZm9yZXZlcgo+IAo+IEkgd2lsbCBj
b250aW51ZSBpbnZlc3RpZ2F0ZSB3aHksIGJ1dCBJIHRob3VnaCB5b3Ugd2FubmEga25vdyBBU0FQ
Cj4gCj4gUmVnYXJkcwo+IEFuZGVycyBXYWxsaW4KCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgotLSAKSm9uYXRoYW4gUmFqb3R0ZS1KdWxpZW4KRWZm
aWNpT1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
