From: =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Subject: Re: lttng-modules build broken against linux 4.9.x
Date: Fri, 2 Feb 2018 07:52:25 +0100
Message-ID: <CAEYzJUGwkCMHsx78y2OpO2PL+uhZXGoY5Tga3PXS7BQ9M9sWig__13098.065069835$1517554246$gmane$org@mail.gmail.com>
References: <CAEYzJUECg0sdn-z7QkW=0C+JYthcen2UdkdT5CkGo0ZKmpVsng@mail.gmail.com>
 <bebe91dc-7092-856e-ccbd-020716bdbc86@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3zXnjR3SKPzpMy
 for <lttng-dev@lists.lttng.org>; Fri,  2 Feb 2018 06:52:27 +0000 (UTC)
Received: by mail-io0-x243.google.com with SMTP id z6so21898578iob.11
 for <lttng-dev@lists.lttng.org>; Thu, 01 Feb 2018 22:52:27 -0800 (PST)
In-Reply-To: <bebe91dc-7092-856e-ccbd-020716bdbc86@efficios.com>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjMgSmFudWFyeSAyMDE4IGF0IDIzOjEwLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVm
ZmljaW9zLmNvbT4gd3JvdGU6Cj4gT24gMjAxOC0wMS0yMyAxNTo0MywgQmrDuHJuIEZvcnNtYW4g
d3JvdGU6Cj4+IEhpIExUVG5nIGRldnMsCj4+Cj4+IE5peE9TIHJlY2VudGx5IHVwZ3JhZGVkIHRo
ZSBzdGFibGUgbGludXgga2VybmVsIGZyb20gNC45Ljc2IHRvIDQuOS43Nwo+PiBhbmQgd2l0aCB0
aGF0IGx0dG5nLW1vZHVsZXMgbm8gbG9uZ2VyIGJ1aWxkLiBTZWUgYnVpbGQgZXJyb3IgYmVsb3cg
bXkKPj4gc2lnbmF0dXJlLgo+Cj4gSGksCj4KPiBUaGlzIGlzIGZpeGVkIGluIHRoZSBzdGFibGUt
Mi4xMCBnaXQgYnJhbmNoIGJ1dCBpcyBub3QgcGFydCBvZiBhIHBvaW50Cj4gcmVsZWFzZSB5ZXQs
IGl0IHNob3VsZCBiZSBwcmV0dHkgc29vbi4KPgo+IEluIHRoZSBtZWFudGltZSwgeW91IGNhbiBj
aGVycnktcGljayB0aGVzZSBjb21taXRzOgo+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0
dG5nLW1vZHVsZXMvY29tbWl0L2JhOGI0YzAwYzIwMTViYWUwNWU4YjZmZTJkYTMxYmM1YmFlZjc5
OGQKPiBodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcy9jb21taXQvNDU0ZGFk
ZWVlMWRhNjdhNDIxMmMyOGNhMDYxMzFmNTM5NDQ5MGI0ZAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9s
dHRuZy9sdHRuZy1tb2R1bGVzL2NvbW1pdC81ODkwMTE3ZGVjZTc4OTMyNGMwMzYxZjRlODI1NmVj
NTI4NTgwZTM4Cj4gaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLW1vZHVsZXMvY29tbWl0
LzRjM2I5MWFlMDkyYjkzY2M2MWQ1ZWZkMDM5MzQxOWMyM2Q2MzY5ODcKCk5peE9TIGhhcyB3b3Jr
aW5nIGx0dG5nLW1vZHVsZXMgbm93ICh1cGRhdGVkIHRvIDIuMTAuNSByZWxlYXNlKS4gVGhhbmtz
IQoKQmVzdCByZWdhcmRzLApCasO4cm4gRm9yc21hbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
