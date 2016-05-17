From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 12/24] Fix: illegal memory
	access in list_lttng_channels
Date: Tue, 17 May 2016 11:55:07 -0400
Message-ID: <CA+jJMxvNcp-FBB5DPE27fWOjpPwLTUJvKXQarnfPoQGwFFhQog__28235.4424744428$1463500526$gmane$org@mail.gmail.com>
References: <1463449383-6553-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463449383-6553-13-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f68.google.com (mail-qg0-f68.google.com
 [209.85.192.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 544EDA3537
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 15:55:08 +0000 (UTC)
Received: by mail-qg0-f68.google.com with SMTP id b14so1739234qge.2
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 08:55:08 -0700 (PDT)
In-Reply-To: <1463449383-6553-13-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBNYXkgMTYsIDIwMTYgYXQgOTo0MiBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gRm91bmQgYnkgQ292ZXJpdHk6Cj4g
Q0lEIDEyNDMwMTggKCMxIG9mIDEpOiBCdWZmZXIgbm90IG51bGwgdGVybWluYXRlZAo+IChCVUZG
RVJfU0laRV9XQVJOSU5HKTExLiBidWZmZXJfc2l6ZV93YXJuaW5nOiBDYWxsaW5nIHN0cm5jcHkg
d2l0aCBhCj4gbWF4aW11bSBzaXplIGFyZ3VtZW50IG9mIDI1NiBieXRlcyBvbiBkZXN0aW5hdGlv
biBhcnJheSAoY2hhbm5lbHMgKwo+IGkpLm5hbWUgb2Ygc2l6ZSAyNTYgYnl0ZXMgbWlnaHQgbGVh
dmUgdGhlIGRlc3RpbmF0aW9uIHN0cmluZwo+IHVudGVybWluYXRlZC4KPgo+IFNpZ25lZC1vZmYt
Ynk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4g
LS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgfCA2ICsrKysrLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21k
LmMKPiBpbmRleCA3ZjQ3ODE4Li5lNjZjOTlmIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmct
c2Vzc2lvbmQvY21kLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jCj4gQEAg
LTI3Nyw3ICsyNzcsMTEgQEAgc3RhdGljIHZvaWQgbGlzdF9sdHRuZ19jaGFubmVscyhlbnVtIGx0
dG5nX2RvbWFpbl90eXBlIGRvbWFpbiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZpdGVyLml0ZXIsIHVjaGFuLCBub2RlLm5vZGUpIHsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50NjRfdCBkaXNjYXJkZWRfZXZlbnRzID0gMCwgbG9zdF9wYWNrZXRzID0gMDsKPgo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIHN0cm5jcHkoY2hhbm5lbHNbaV0ubmFtZSwgdWNoYW4tPm5h
bWUsIExUVE5HX1NZTUJPTF9OQU1FX0xFTik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYg
KGx0dG5nX3N0cm5jcHkoY2hhbm5lbHNbaV0ubmFtZSwgdWNoYW4tPm5hbWUsCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIExUVE5HX1NZTUJPTF9OQU1FX0xFTikpIHsK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC0xOwoKUmVtb3ZlZCByZXQg
PSAtMSBzaW5jZSByZXQgaXMgbmV2ZXIgdXNlZCAodGhlIGZ1bmN0aW9uIGhhcyBubyByZXR1cm4g
dmFsdWUpLgoKSsOpcsOpbWllCgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNoYW5uZWxzW2ldLmF0dHIub3ZlcndyaXRlID0gdWNoYW4tPmF0dHIub3ZlcndyaXRlOwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWxzW2ldLmF0dHIuc3ViYnVmX3NpemUgPSB1Y2hh
bi0+YXR0ci5zdWJidWZfc2l6ZTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBjaGFubmVsc1tp
XS5hdHRyLm51bV9zdWJidWYgPSB1Y2hhbi0+YXR0ci5udW1fc3ViYnVmOwo+IC0tCj4gMi4xLjQK
PgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZm
aWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
