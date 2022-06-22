Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D280FC433EF
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jun 2022 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655931124;
	bh=YUoNNZ/0nzELoDrwVJFCm051Rz/MTwhYoyUc5S2YHoE=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zEBE97Argr9aNkx79UqfGAfKD8eHUU8wGQ//1Xi05Uhw4d9UHmlhGOmwYBZijstvC
	 FWZINnYf1VO8fauVm4fWtvQZssy0b3K17HA85dmfwaom0GJIu6IyRLgN9OvdYE7iKi
	 mbHmlxvnpliSlI3IjG0pJokZTGgFxFqUm7VWnlirB3zFUrdzue/6L9wEKtheyFKeiq
	 JH8IXeBztDIasHcJgJGYsSnd4TL/Z8jt/3UKYzP+BhkwXOGZLgT6l5bX4jyI7pJiEV
	 C7t0N6LHbQfUsCwKIL5b5C+9UbkwGC98yGXlAmtroEsociNZGZuZ3oxYIW2TPeKiv9
	 F13Jz3MWcUiGg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LSwYJ1GGfzDPt;
	Wed, 22 Jun 2022 16:52:04 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LSwYG6PxnzCwJ
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 16:52:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4578D3ABEC5
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2022 16:52:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8Qt1ZFrziWXg; Wed, 22 Jun 2022 16:52:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A67303AB9E5;
 Wed, 22 Jun 2022 16:52:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A67303AB9E5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5T4lCMHpIfYH; Wed, 22 Jun 2022 16:52:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 9B5843AB9E4;
 Wed, 22 Jun 2022 16:52:00 -0400 (EDT)
Date: Wed, 22 Jun 2022 16:52:00 -0400 (EDT)
To: Minlan Wang <wangminlan@szsandstone.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <589742415.26853.1655931120526.JavaMail.zimbra@efficios.com>
In-Reply-To: <1779693726.26841.1655929703853.JavaMail.zimbra@efficios.com>
References: <20220614035533.GA174967@localhost.localdomain>
 <20220616080912.GA246781@localhost.localdomain>
 <1711122492.5944.1655473043420.JavaMail.zimbra@efficios.com>
 <20220621035206.GA267474@localhost.localdomain>
 <1843612610.17820.1655817158376.JavaMail.zimbra@efficios.com>
 <20220622074535.GA269641@localhost.localdomain>
 <1420937751.21327.1655903998961.JavaMail.zimbra@efficios.com>
 <1779693726.26841.1655929703853.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: ***UNCHECKED*** Re: Re: urcu workqueue thread uses 99% of cpu
 while workqueue is empty
Thread-Index: /dYvM5tb7eJkihrmAnXa3+eAc0+3EPpIC4W+ynSC1fo=
Subject: Re: [lttng-dev] ***UNCHECKED*** Re: Re: urcu workqueue thread uses
 99% of cpu while	workqueue is empty
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LS0tLS0gT24gSnVuIDIyLCAyMDIyLCBhdCA0OjI4IFBNLCBNYXRoaWV1IERlc25veWVycyBtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9uIEp1biAyMiwgMjAy
MiwgYXQgOToxOSBBTSwgTWF0aGlldSBEZXNub3llcnMKPiBtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20gd3JvdGU6Cj4gCj4+IC0tLS0tIE9uIEp1biAyMiwgMjAyMiwgYXQgMzo0NSBBTSwg
TWlubGFuIFdhbmcgd2FuZ21pbmxhbkBzenNhbmRzdG9uZS5jb20gd3JvdGU6Cj4+IAo+PiBbLi4u
XQo+PiAKPj4gSGkgTWlubGFuLAo+PiAKPj4+IC0tCj4+PiAxLjguMy4xCj4+PiAKPj4+IAo+Pj4g
QW5kIHRoZSBsdHRuZyBzZXNzaW9uIGlzIGNvbmZpZ3VyZWQgdG8gdHJhY2UgdGhlc2UgZXZlbnRz
Ogo+Pj4ga2VybmVsOiBzeXNjYWxsIGZ1dGV4Cj4+IAo+PiBPbiB0aGUga2VybmVsIHNpZGUsIGlu
IGFkZGl0aW9uIHRvIHRoZSBzeXNjYWxsIGZ1dGV4LCBJIHdvdWxkIHJlYWxseSBsaWtlIHRvIHNl
ZQo+PiB3aGF0Cj4+IGhhcHBlbnMgaW4gdGhlIHNjaGVkdWxlciwgbWFpbmx5IHRoZSB3YWl0L3dh
a2V1cCB0cmFjZXBvaW50cy4gVGhpcyBjYW4gYmUgYWRkZWQKPj4gYnkgdXNpbmc6Cj4+IAo+PiBs
dHRuZyBlbmFibGUtZXZlbnQgLWsgJ3NjaGVkXyonCj4+IAo+PiBUaGlzIHNob3VsZCBoZWxwIHVz
IGNvbmZpcm0gd2hldGhlciB3ZSBpbmRlZWQgaGF2ZSBhIHNpdHVhdGlvbiB3aGVyZSBxdWV1ZWQg
d2FrZQo+PiB1cHMKPj4gaGFwcGVuIHRvIHdha2UgdXAgYSB3YWl0IGhhcHBlbmluZyBvbmx5IGxh
dGVyLCB3aGljaCBpcyB1bmV4cGVjdGVkIGJ5IHRoZQo+PiBjdXJyZW50IGxpYnVyY3UKPj4gdXNl
cnNwYWNlIGNvZGUuCj4+IAo+PiBbLi4uXQo+PiAKPj4+IC0tLQo+Pj4gCj4+PiBUaGUgYmFibGV0
cmFjZSBvdXRwdXQgb2YgdGhpcyBzZXNzaW9uIGlzIHByZXR0eSBiaWcsIDYgTUIgaW4gc2l6ZSwg
aSBwdXQgaXQgaW4KPj4+IHRoZSBhdHRhY2htZW50IHRyYWNlXzA2MjIudGFyLmJ6Mi4KPj4+IExl
dCBteSBrbm93IGlmIHlvdXIgbWFpbGJveCBjYW4ndCBoYW5kbGUgc3VjaCBiaWcgYXR0YWNobWVu
dC4KPj4gCj4+IEl0IHdvdWxkIGJlIGV2ZW4gYmV0dGVyIGlmIHlvdSBjYW4gc2hhcmUgdGhlIGJp
bmFyeSB0cmFjZSwgYmVjYXVzZSB0aGVuIGl0J3MKPj4gZWFzeSB0bwo+PiBsb2FkIGl0IGluIHRy
YWNlIGNvbXBhc3MsIGN1dCBhd2F5IHRpbWUgcmFuZ2VzIHRoYXQgZG9uJ3QgbWF0dGVyLCBhbmQg
bG90cyBvZgo+PiBvdGhlcgo+PiB1c2VmdWwgc3R1ZmYuCj4gCj4gSSBqdXN0IGZvdW5kIHRoZSBy
ZWxldmFudCBzbmlwcGV0IG9mIGRvY3VtZW50YXRpb24gaW4gZnV0ZXgoNSk6Cj4gCj4gICAgICAg
RlVURVhfV0FJVAo+ICAgICAgICAgICAgICBSZXR1cm5zIDAgaWYgdGhlIGNhbGxlciB3YXMgd29r
ZW4gdXAuICBOb3RlIHRoYXQgYSAgd2FrZS11cCAgY2FuCj4gICAgICAgICAgICAgIGFsc28gIGJl
IGNhdXNlZCBieSBjb21tb24gZnV0ZXggdXNhZ2UgcGF0dGVybnMgaW4gdW5yZWxhdGVkIGNvZGUK
PiAgICAgICAgICAgICAgdGhhdCBoYXBwZW5lZCB0byBoYXZlIHByZXZpb3VzbHkgdXNlZCB0aGUg
IGZ1dGV4ICB3b3JkJ3MgIG1lbW9yeQo+ICAgICAgICAgICAgICBsb2NhdGlvbiAgKGUuZy4sIHR5
cGljYWwgZnV0ZXgtYmFzZWQgaW1wbGVtZW50YXRpb25zIG9mIFB0aHJlYWRzCj4gICAgICAgICAg
ICAgIG11dGV4ZXMgY2FuIGNhdXNlIHRoaXMgdW5kZXIgc29tZSBjb25kaXRpb25zKS4gIFRoZXJl
Zm9yZSwgY2FsbOKAkAo+ICAgICAgICAgICAgICBlcnMgc2hvdWxkIGFsd2F5cyBjb25zZXJ2YXRp
dmVseSBhc3N1bWUgdGhhdCBhIHJldHVybiB2YWx1ZSBvZiAwCj4gICAgICAgICAgICAgIGNhbiBt
ZWFuIGEgc3B1cmlvdXMgd2FrZS11cCwgYW5kICB1c2UgIHRoZSAgZnV0ZXggIHdvcmQncyAgdmFs
dWUKPiAgICAgICAgICAgICAgKGkuZS4sICB0aGUgdXNlci1zcGFjZSBzeW5jaHJvbml6YXRpb24g
c2NoZW1lKSB0byBkZWNpZGUgd2hldGhlcgo+ICAgICAgICAgICAgICB0byBjb250aW51ZSB0byBi
bG9jayBvciBub3QuCj4gCj4gSSdtIHByZXR0eSBzdXJlIHRoaXMgaXMgd2hhdCBpcyBoYXBwZW5p
bmcgaGVyZS4KCkhlcmUgaXMgdGhlIHNlcmllcyBvZiBwYXRjaGVzIGZvciByZXZpZXcgb24gZ2Vy
cml0OgoKcmVtb3RlOiAgIGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL3VzZXJzcGFjZS1yY3Uv
Ky84NDQxIEZpeDogd29ya3F1ZXVlOiBmdXRleCB3YWl0OiBoYW5kbGUgc3B1cmlvdXMgZnV0ZXgg
d2FrZXVwcyBbTkVXXSAgICAgICAgCnJlbW90ZTogICBodHRwczovL3Jldmlldy5sdHRuZy5vcmcv
Yy91c2Vyc3BhY2UtcmN1LysvODQ0MiBGaXg6IHVyY3U6IGZ1dGV4IHdhaXQ6IGhhbmRsZSBzcHVy
aW91cyBmdXRleCB3YWtldXBzIFtORVddICAgICAgICAKcmVtb3RlOiAgIGh0dHBzOi8vcmV2aWV3
Lmx0dG5nLm9yZy9jL3VzZXJzcGFjZS1yY3UvKy84NDQzIEZpeDogY2FsbF9yY3U6IGZ1dGV4IHdh
aXQ6IGhhbmRsZSBzcHVyaW91cyBmdXRleCB3YWtldXBzIFtORVddICAgICAgICAKcmVtb3RlOiAg
IGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL3VzZXJzcGFjZS1yY3UvKy84NDQ0IEZpeDogdXJj
dS13YWl0OiBmdXRleCB3YWl0OiBoYW5kbGUgc3B1cmlvdXMgZnV0ZXggd2FrZXVwcyBbTkVXXSAg
ICAgICAgCnJlbW90ZTogICBodHRwczovL3Jldmlldy5sdHRuZy5vcmcvYy91c2Vyc3BhY2UtcmN1
LysvODQ0NSBGaXg6IGRlZmVyX3JjdTogZnV0ZXggd2FpdDogaGFuZGxlIHNwdXJpb3VzIGZ1dGV4
IHdha2V1cHMgW05FV10gICAgICAgIApyZW1vdGU6ICAgaHR0cHM6Ly9yZXZpZXcubHR0bmcub3Jn
L2MvdXNlcnNwYWNlLXJjdS8rLzg0NDYgRml4OiB1cmN1LXFzYnI6IGZ1dGV4IHdhaXQ6IGhhbmRs
ZSBzcHVyaW91cyBmdXRleCB3YWtldXBzIFtORVddIAoKVGhhbmtzLAoKTWF0aGlldQoKPiAKPiBU
aGFua3MsCj4gCj4gTWF0aGlldQo+IAo+IAo+PiAKPj4gVGhhbmtzLAo+PiAKPj4gTWF0aGlldQo+
PiAKPj4gLS0KPj4gTWF0aGlldSBEZXNub3llcnMKPj4gRWZmaWNpT1MgSW5jLgo+PiBodHRwOi8v
d3d3LmVmZmljaW9zLmNvbQo+IAo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJ
bmMuCj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZp
Y2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
