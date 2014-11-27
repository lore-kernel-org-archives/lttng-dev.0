From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: lttng-relayd: unhandled
	out of memory error
Date: Thu, 27 Nov 2014 17:32:44 -0500
Message-ID: <CA+jJMxsZtpkhP3uENT0LcVf98nkSbjnw+0tr+axF79B4h0Wqdg__11819.9468045079$1417127608$gmane$org@mail.gmail.com>
References: <1416592072-11067-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7cI-0002ne-3F
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:32:50 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so4095072qcv.36
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:32:44 -0800 (PST)
In-Reply-To: <1416592072-11067-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIDIuNSwgMi42IGFuZCBtYXN0ZXIuCgpUaGFua3MsCkrDqXLDqW1pZQoKT24gRnJp
LCBOb3YgMjEsIDIwMTQgYXQgMTI6NDcgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRl
c25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVz
bm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4v
bHR0bmctcmVsYXlkL21haW4uYyB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYyBiL3Ny
Yy9iaW4vbHR0bmctcmVsYXlkL21haW4uYwo+IGluZGV4IGM5ZjIwMjEuLjI3YTQyOGEgMTAwNjQ0
Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbWFpbi5jCj4gKysrIGIvc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbWFpbi5jCj4gQEAgLTIzNCw2ICsyMzQsMTEgQEAgaW50IHNldF9vcHRpb24oaW50
IG9wdCwgY29uc3QgY2hhciAqYXJnLCBjb25zdCBjaGFyICpvcHRuYW1lKQo+ICAgICAgICAgICAg
ICAgICBicmVhazsKPiAgICAgICAgIGNhc2UgJ2cnOgo+ICAgICAgICAgICAgICAgICB0cmFjaW5n
X2dyb3VwX25hbWUgPSBzdHJkdXAoYXJnKTsKPiArICAgICAgICAgICAgICAgaWYgKHRyYWNpbmdf
Z3JvdXBfbmFtZSA9PSBOVUxMKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLWVy
cm5vOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIFBFUlJPUigic3RyZHVwIik7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBlbmQ7Cj4gKyAgICAgICAgICAgICAgIH0KPiAgICAgICAg
ICAgICAgICAgdHJhY2luZ19ncm91cF9uYW1lX292ZXJyaWRlID0gMTsKPiAgICAgICAgICAgICAg
ICAgYnJlYWs7Cj4gICAgICAgICBjYXNlICdoJzoKPiAtLQo+IDIuMS4xCj4KCgoKLS0gCkrDqXLD
qW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
