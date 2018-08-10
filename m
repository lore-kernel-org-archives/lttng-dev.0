From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Using lttng for traces and (in-process) logging
Date: Fri, 10 Aug 2018 12:23:20 -0400
Message-ID: <CA+jJMxuvkd2=OM8G_NGjgGzeZTL6dEzq=DcH-XLWx8rQfesQYw__49378.8750646219$1533918136$gmane$org@mail.gmail.com>
References: <CADYdroNy37NmavhVhMaUkR+k9+rJLc_6C3PoXq1rx_ZMwX=VtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41n9Rt5Qcsz14K6
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 12:24:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B4B0F23BD22
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 12:24:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id Nl_ZZGa0a5Kk for <lttng-dev@lists.lttng.org>;
 Fri, 10 Aug 2018 12:24:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1B69D23BD19
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 12:24:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id FCdAYlW0cv14 for <lttng-dev@lists.lttng.org>;
 Fri, 10 Aug 2018 12:24:03 -0400 (EDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mail.efficios.com (Postfix) with ESMTPSA id B82B823BD0E
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 12:24:02 -0400 (EDT)
Received: by mail-lj1-f177.google.com with SMTP id v9-v6so7622897ljk.4
 for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2018 09:24:02 -0700 (PDT)
In-Reply-To: <CADYdroNy37NmavhVhMaUkR+k9+rJLc_6C3PoXq1rx_ZMwX=VtQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGksCgpJIGNhbiBzZWUgaG93IHRoaXMgY291bGQgYmUgYXBwcm94aW1hdGVkIGJ5IGNvbmZpZ3Vy
aW5nIGEgImxpdmUiIHRyYWNpbmcKc2Vzc2lvbiAoaS5lLiB5b3Ugd291bGQgc2VlIHRoZSBsb2cg
YXMgdGhleSBhcmUgcHJvZHVjZWQpLCBidXQgdGhlcmUgaXMKbm8gd2F5LCBjdXJyZW50bHksIHRv
IHNlcmlhbGl6ZSB0aGUgZXZlbnRzIHRvIHN0ZG91dC9zdGRlcnIgZnJvbSB0aGUKYXBwbGljYXRp
b24gaXRzZWxmLgoKTWF5YmUgSSBtaXN1bmRlcnN0b29kIHlvdXIgcXVlc3Rpb24uIExldCBtZSBr
bm93LgoKSsOpcsOpbWllCgpPbiA2IEF1Z3VzdCAyMDE4IGF0IDE4OjQyLCBOb3JiZXJ0IExhbmdl
IDxub2xhbmdlNzlAZ21haWwuY29tPiB3cm90ZToKPiBIZWxsbywKPgo+IHNpbmNlIGx0dG5nIHdv
dWxkIG1ha2UgZm9yIGEgZGVjZW50IGxvZ2dlciwgaXMgaXQgcG9zc2libGUgdG8gY3JlYXRlIGEK
PiBvd24gdHJhY2Vwb2ludCBwcm92aWRlciBhbmQgY2hhbm5lbCBhbmQgYWNlc3MgaXQgaW4gdGhl
IHZlcnkgc2FtZQo+IHByb2Nlc3MgdGhhdHMgdHJhY2VkPwo+IHRoZSBsb2cgZW50cmllcyB3b3Vs
ZCBuZWVkIHRvIGJlIGFjY2Vzc2libGUgZGlyZWN0bHkgdG8gc3VwcG9ydCBzb21lCj4gZXhpc3Rp
bmcgc2NoZW1lcyBmb3IgbWFuaXB1bGF0aW5nIChpbnRlcnBvbGF0aW5nIHRvIGEgZGlmZmVyZW50
Cj4gY2xvY2stc291cmNlKSwgZm9yd2FyZGluZyBhbmQgc3RvcmluZyB0aGVtLgo+Cj4gZWcuIEkg
d291bGQgbGlrZSB0byBhY2Nlc3MgdGhlIGxvZ3MgYW5kIG90aGVyIHRyYWNlcyB3aXRoIHRoZSBu
b3JtYWwKPiBsdHRuZyB0b29scywgYnV0IGFsc28gYmUgYWJsZSB0byBnZXQgYSBjb3B5IG9mIHRo
ZSBsb2dzIGRpcmVjdGx5IGZyb20KPiB0aGUgcHJvY2VzcyBnZW5lcmF0aW5nIHRoZW0uCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgoKLS0gCkrDqXLD
qW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
