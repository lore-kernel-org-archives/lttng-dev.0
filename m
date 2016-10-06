From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] lttng-sessiond:
	auto-load	lttng-probe-i2c module
Date: Thu, 6 Oct 2016 15:55:51 +0000 (UTC)
Message-ID: <1370966900.48777.1475769351410.JavaMail.zimbra__12034.4801493504$1475769308$gmane$org@efficios.com>
References: <20161004222450.8004-1-simon.marchi@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BF0DEA438C
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2016 15:56:22 +0000 (UTC)
In-Reply-To: <20161004222450.8004-1-simon.marchi@ericsson.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@ericsson.com>, Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gT2N0IDQsIDIwMTYsIGF0IDY6MjQgUE0sIFNpbW9uIE1hcmNoaSBzaW1vbi5tYXJj
aGlAZXJpY3Nzb24uY29tIHdyb3RlOgoKPiBBdXRvbWF0aWNhbGx5IGxvYWQgdGhlIGx0dG5nLXBy
b2JlLWkyYyBrZXJuZWwgbW9kdWxlLCB3aGljaCB3YXMgcmVjZW50bHkKPiBhZGRlZCBpbiBsdHRu
Zy1tb2R1bGVzLCBhbG9uZyB3aXRoIHRoZSBvdGhlciBwcm9iZSBtb2R1bGVzLgoKQWNrZWQtYnk6
IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFNpbW9uIE1hcmNoaSA8c2ltb24ubWFyY2hpQGVyaWNzc29uLmNvbT4K
PiAtLS0KPiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMgfCAxICsKPiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tb2Rwcm9iZS5jCj4gYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMK
PiBpbmRleCBjYTA0NjdlLi5mNThmNTBjIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbW9kcHJvYmUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUu
Ywo+IEBAIC01Nyw2ICs1Nyw3IEBAIHN0cnVjdCBrZXJuX21vZHVsZXNfcGFyYW0ga2Vybl9tb2R1
bGVzX3Byb2Jlc19kZWZhdWx0W10gPSB7Cj4gCXsgImx0dG5nLXByb2JlLWV4dDMiIH0sCj4gCXsg
Imx0dG5nLXByb2JlLWV4dDQiIH0sCj4gCXsgImx0dG5nLXByb2JlLWdwaW8iIH0sCj4gKwl7ICJs
dHRuZy1wcm9iZS1pMmMiIH0sCj4gCXsgImx0dG5nLXByb2JlLWlycSIgfSwKPiAJeyAibHR0bmct
cHJvYmUtamJkIiB9LAo+IAl7ICJsdHRuZy1wcm9iZS1qYmQyIiB9LAo+IC0tCj4gMi4xMC4xCj4g
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApN
YXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
