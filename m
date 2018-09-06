From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Regarding lttng ust trace-point usage
Date: Thu, 6 Sep 2018 16:49:57 -0400
Message-ID: <CA+jJMxuNW9jAtM3ZE+B3Q0GCpkjSDB=jwy4Lu_ozw5CBar6FtQ__13191.3483063274$1536266926$gmane$org@mail.gmail.com>
References: <CAEQd43P0u=ikq=OKOjO0fC1vhwFEmvH0fEBRENzCbPLx8aP0eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 425t4w6zttzv6B
 for <lttng-dev@lists.lttng.org>; Thu,  6 Sep 2018 16:50:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 353CC1C8B2B
 for <lttng-dev@lists.lttng.org>; Thu,  6 Sep 2018 16:50:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id pUf7cZK0htif for <lttng-dev@lists.lttng.org>;
 Thu,  6 Sep 2018 16:50:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B606C1C8B19
 for <lttng-dev@lists.lttng.org>; Thu,  6 Sep 2018 16:50:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 6mDNu-EXjzsK for <lttng-dev@lists.lttng.org>;
 Thu,  6 Sep 2018 16:50:39 -0400 (EDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id 607181C8B03
 for <lttng-dev@lists.lttng.org>; Thu,  6 Sep 2018 16:50:39 -0400 (EDT)
Received: by mail-lf1-f49.google.com with SMTP id v77-v6so10254704lfa.6
 for <lttng-dev@lists.lttng.org>; Thu, 06 Sep 2018 13:50:39 -0700 (PDT)
In-Reply-To: <CAEQd43P0u=ikq=OKOjO0fC1vhwFEmvH0fEBRENzCbPLx8aP0eA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jagadeesh konakalla <kjagadeesh27@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMTQgQXVndXN0IDIwMTggYXQgMDg6MDYsIGphZ2FkZWVzaCBrb25ha2FsbGEgPGtqYWdhZGVl
c2gyN0BnbWFpbC5jb20+IHdyb3RlOgo+IEhpIE1hdGhpZXUsCj4KPiBUaGlzIGlzIEphZ2FkZWVz
aC4gSSBhbSB1c2VyIG9mIGx0dG5nIHRvb2xzLgo+Cj4gSSBoYXZlIG9uZSBxdWVyeSByZWdhcmRp
bmcgdGhlIGx0dG5nIHVzdCB1c2FnZS4KPgo+IEkgaGF2ZSB3cml0dGVuIG15IGxpbnV4IGFwcGxp
Y2F0aW9uIHdoaWNoIGhhcyB0cmFjZSBwb2ludCBBUEkncyB0byB0cmFjZSB0aGUKPiB1c2VyIGFw
cGxpY2F0aW9uLgo+IE15IHJlcXVpcmVtZW50IGlzIHRvIGRvIGJvdGgga2VybmVsIGRvbWFpbiB0
cmFjZSBhbmQgdXNlciBkb21haW4gdHJhY2UgZm9yCj4gbXkgYXBwbGljYXRpb24uCj4KPiBXaGVu
IGkgc3RhcnQgdGhlIGx0dG5nIGFuZCB0aGVuIHJ1biBteSBhcHBsaWNhdGlvbiwgaSBkbyBub3Qg
c2VlIGFueSBpc3N1ZXMuCj4gSSBtZWFuIHRvIHNheSB0aGF0IGkgZ2V0IGFsbCB0aGUgdXNlciB0
cmFjZSBldmVudHMgYW5kIGtlcm5lbCBldmVudHMuCj4KPiBJZiBpIHN0YXJ0IHRoZSBhcHBsaWNh
dGlvbiwgdGhlbiBpIGNvbmZpZ3VyZSBhbmQgc3RhcnQgdGhlIGx0dG5nLCBpIHNlZSBzb21lCj4g
dXNlciBldmVudHMgYXJlIG5vdCBjYXB0dXJlZCBhdCB0aGUgc3RhcnQgKG1heSBiZSBkcm9wcGVk
KS4gSSBoYXZlIG9ic2VydmVkCj4gdGhhdCB0aGVyZSBpcyBhIGRlbGF5IGluIHRoZSBmaXJzdCBr
ZXJuZWwgZXZlbnQgb2NjdXJyZW5jZSB0byBmaXJzdCB1c2VyCj4gZXZlbnQgb2NjdXJyZW5jZS4g
SSBoYXZlIG5vdCBzZWVuIHRoaXMgYmVoYXZpb3IgaWYgaSBzdGFydCB0aGUgbHR0bmcgYW5kIHJ1
bgo+IG15IGFwcGxpY2F0aW9uLgoKSGksCgpJdCBpcyBleHBlY3RlZCBmb3IgdGhlIGtlcm5lbCB0
cmFjZXIgdG8gc3RhcnQgdHJhY2luZyBiZWZvcmUgdGhlIHVzZXIgc3BhY2UKdHJhY2VyIGR1cmlu
ZyB0aGUgZXhlY3V0aW9uIG9mIHRoZSBzdGFydCBjb21tYW5kLiBTdGFydGluZyB0aGUgdHJhY2lu
ZwphY3Jvc3MgZG9tYWlucyBpcyBub3QgZG9uZSBpbiBhIHNpbmdsZSBvcGVyYXRpb24uCgpMVFRu
ZyBndWFyYW50ZWVzIHRoYXQgYWxsIGV2ZW50cyB0aGF0IG9jY3VyIGFmdGVyIHRoZSAnbHR0bmcg
c3RhcnQnIGNvbW1hbmQKcmV0dXJucyB3aWxsIGJlIGNhcHR1cmVkIChwcm92aWRlZCB0aGF0IHRo
ZSBidWZmZXJzIGFyZSBub3QgZnVsbCkuCgpKw6lyw6ltaWUKCj4KPiBIZXJlIGlzIG15IHF1ZXN0
aW9uIDogSXMgdGhpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IgPwo+IG9yCj4gQXJlIHRoZXJlIGFu
eSBzZXR0aW5ncyB0aGF0IGNhbiBoZWxwIG1lIHRvIHJlc29sdmUgdGhpcyBpc3N1ZSA/Cj4KPiBW
ZXJzaW9uIG9mIGx0dG5nIHVzZWQgOgo+IGx0dG5nLXRvb2xzICgyLjkuNCkKPiBsdHRuZy1tb2R1
bGVzICgyLjkuMSkKPiBsdHRuZy1saWJ1c3QgKDIuOS4wICkKPgo+IEkgYXBwcmVjaWF0ZSB5b3Vy
IGhlbHAuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGluZm9ybWF0aW9uLgo+
Cj4gV2l0aCByZWdhcmRzLAo+IEphZ2FkZWVzaCBLLgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpF
ZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
