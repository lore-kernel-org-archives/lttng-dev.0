From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Load preemptirq lttng-modules
 probe
Date: Tue, 20 Feb 2018 12:45:29 -0500 (EST)
Message-ID: <535574030.31022.1519148729133.JavaMail.zimbra__20918.39986756$1519148617$gmane$org@efficios.com>
References: <1519148449-31509-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zm7Lf36m6zr0p
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:45:30 -0500 (EST)
In-Reply-To: <1519148449-31509-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gRmViIDIwLCAyMDE4LCBhdCAxMjo0MCBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFu
c29uQGVmZmljaW9zLmNvbSB3cm90ZToKCkFja2VkLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0
aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEpl
YW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBzcmMvYmluL2x0dG5nLXNlc3Np
b25kL21vZHByb2JlLmMgfCAxICsKPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAK
PiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5jCj4gYi9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMKPiBpbmRleCA3NWQ2Mzg3Li5kNjM0ODM0IDEw
MDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+ICsrKyBiL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+IEBAIC03MSw2ICs3MSw3IEBAIHN0cnVj
dCBrZXJuX21vZHVsZXNfcGFyYW0ga2Vybl9tb2R1bGVzX3Byb2Jlc19kZWZhdWx0W10gPSB7Cj4g
CXsgImx0dG5nLXByb2JlLW5hcGkiIH0sCj4gCXsgImx0dG5nLXByb2JlLW5ldCIgfSwKPiAJeyAi
bHR0bmctcHJvYmUtcG93ZXIiIH0sCj4gKwl7ICJsdHRuZy1wcm9iZS1wcmVlbXB0aXJxIiB9LAo+
IAl7ICJsdHRuZy1wcm9iZS1wcmludGsiIH0sCj4gCXsgImx0dG5nLXByb2JlLXJhbmRvbSIgfSwK
PiAJeyAibHR0bmctcHJvYmUtcmN1IiB9LAo+IC0tCj4gMi43LjQKPiAKPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJz
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
