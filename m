From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Load preemptirq lttng-modules
	probe
Date: Tue, 20 Feb 2018 15:33:14 -0500
Message-ID: <CA+jJMxs-pncs7Aoi5_RpJoJAHwxz05EPPb9BUCWsNUaO=Je6dQ__37810.7798322619$1519158703$gmane$org@mail.gmail.com>
References: <1519148449-31509-1-git-send-email-mjeanson@efficios.com>
 <535574030.31022.1519148729133.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3zmC4d1xnZzpyn
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 15:33:36 -0500 (EST)
Received: by mail-lf0-x242.google.com with SMTP id r80so6048533lfe.13
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:33:36 -0800 (PST)
In-Reply-To: <535574030.31022.1519148729133.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

SXMgdGhpcyBuZXcgaW5zdHJ1bWVudGF0aW9uIG9ubHkgaW4gbHR0bmctbW9kdWxlcyBtYXN0ZXI/
CgpKw6lyw6ltaWUKCk9uIDIwIEZlYnJ1YXJ5IDIwMTggYXQgMTI6NDUsIE1hdGhpZXUgRGVzbm95
ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IC0tLS0tIE9uIEZl
YiAyMCwgMjAxOCwgYXQgMTI6NDAgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lv
cy5jb20gd3JvdGU6Cj4KPiBBY2tlZC1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24g
PG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPj4gLS0tCj4+IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
bW9kcHJvYmUuYyB8IDEgKwo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+PiBiL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+PiBpbmRleCA3NWQ2Mzg3Li5kNjM0ODM0IDEw
MDY0NAo+PiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMKPj4gKysrIGIv
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5jCj4+IEBAIC03MSw2ICs3MSw3IEBAIHN0
cnVjdCBrZXJuX21vZHVsZXNfcGFyYW0ga2Vybl9tb2R1bGVzX3Byb2Jlc19kZWZhdWx0W10gPSB7
Cj4+ICAgICAgIHsgImx0dG5nLXByb2JlLW5hcGkiIH0sCj4+ICAgICAgIHsgImx0dG5nLXByb2Jl
LW5ldCIgfSwKPj4gICAgICAgeyAibHR0bmctcHJvYmUtcG93ZXIiIH0sCj4+ICsgICAgIHsgImx0
dG5nLXByb2JlLXByZWVtcHRpcnEiIH0sCj4+ICAgICAgIHsgImx0dG5nLXByb2JlLXByaW50ayIg
fSwKPj4gICAgICAgeyAibHR0bmctcHJvYmUtcmFuZG9tIiB9LAo+PiAgICAgICB7ICJsdHRuZy1w
cm9iZS1yY3UiIH0sCj4+IC0tCj4+IDIuNy40Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPj4gbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+PiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4KPiAtLQo+IE1hdGhpZXUgRGVzbm95ZXJzCj4g
RWZmaWNpT1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgoKCi0tIApKw6lyw6ltaWUg
R2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
