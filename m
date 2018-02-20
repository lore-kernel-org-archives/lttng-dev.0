From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Load preemptirq lttng-modules
 probe
Date: Tue, 20 Feb 2018 15:33:53 -0500 (EST)
Message-ID: <468381009.31311.1519158833060.JavaMail.zimbra__45170.2365804978$1519158729$gmane$org@efficios.com>
References: <1519148449-31509-1-git-send-email-mjeanson@efficios.com>
 <535574030.31022.1519148729133.JavaMail.zimbra@efficios.com>
 <CA+jJMxs-pncs7Aoi5_RpJoJAHwxz05EPPb9BUCWsNUaO=Je6dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zmC545Gv4zq0f
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 15:33:59 -0500 (EST)
In-Reply-To: <CA+jJMxs-pncs7Aoi5_RpJoJAHwxz05EPPb9BUCWsNUaO=Je6dQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

WWVzLgoKLS0tLS0gT24gRmViIDIwLCAyMDE4LCBhdCAzOjMzIFBNLCBKZXJlbWllIEdhbGFybmVh
dSBqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IElzIHRoaXMgbmV3IGlu
c3RydW1lbnRhdGlvbiBvbmx5IGluIGx0dG5nLW1vZHVsZXMgbWFzdGVyPwo+IAo+IErDqXLDqW1p
ZQo+IAo+IE9uIDIwIEZlYnJ1YXJ5IDIwMTggYXQgMTI6NDUsIE1hdGhpZXUgRGVzbm95ZXJzCj4g
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4+IC0tLS0tIE9uIEZlYiAy
MCwgMjAxOCwgYXQgMTI6NDAgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lvcy5j
b20gd3JvdGU6Cj4+Cj4+IEFja2VkLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tPgo+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29u
IDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4+PiAtLS0KPj4+IHNyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvbW9kcHJvYmUuYyB8IDEgKwo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+Pj4g
Yi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMKPj4+IGluZGV4IDc1ZDYzODcuLmQ2
MzQ4MzQgMTAwNjQ0Cj4+PiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMK
Pj4+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+Pj4gQEAgLTcxLDYg
KzcxLDcgQEAgc3RydWN0IGtlcm5fbW9kdWxlc19wYXJhbSBrZXJuX21vZHVsZXNfcHJvYmVzX2Rl
ZmF1bHRbXSA9IHsKPj4+ICAgICAgIHsgImx0dG5nLXByb2JlLW5hcGkiIH0sCj4+PiAgICAgICB7
ICJsdHRuZy1wcm9iZS1uZXQiIH0sCj4+PiAgICAgICB7ICJsdHRuZy1wcm9iZS1wb3dlciIgfSwK
Pj4+ICsgICAgIHsgImx0dG5nLXByb2JlLXByZWVtcHRpcnEiIH0sCj4+PiAgICAgICB7ICJsdHRu
Zy1wcm9iZS1wcmludGsiIH0sCj4+PiAgICAgICB7ICJsdHRuZy1wcm9iZS1yYW5kb20iIH0sCj4+
PiAgICAgICB7ICJsdHRuZy1wcm9iZS1yY3UiIH0sCj4+PiAtLQo+Pj4gMi43LjQKPj4+Cj4+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gbHR0bmct
ZGV2IG1haWxpbmcgbGlzdAo+Pj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+Pj4gaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+Pgo+
PiAtLQo+PiBNYXRoaWV1IERlc25veWVycwo+PiBFZmZpY2lPUyBJbmMuCj4+IGh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCj4gCj4gCj4gCj4gLS0KPiBKw6lyw6ltaWUgR2FsYXJuZWF1Cj4gRWZmaWNp
T1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgotLSAKTWF0aGlldSBEZXNub3llcnMK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
