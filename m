From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Always build vmscan probe
Date: Thu, 20 Apr 2017 19:39:32 +0000 (UTC)
Message-ID: <1601281322.15723.1492717172325.JavaMail.zimbra__17237.0211490945$1492717089$gmane$org@efficios.com>
References: <1492716205-26717-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3w88LP71WqzD8Z
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 19:38:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6FAEC34030C
 for <lttng-dev@lists.lttng.org>; Thu, 20 Apr 2017 19:39:33 +0000 (UTC)
In-Reply-To: <1492716205-26717-1-git-send-email-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TGV0J3MgbWVyZ2UgaXQgaW50byBtYXN0ZXIgZm9yIG5vdywgYW5kIHNlZSBpZiB0aGUgQ0kgY29t
cGxhaW5zLiBJZiBpdCBhbGwKcGFzcyBmaW5lLCBJJ2xsIGNoZXJyeS1waWNrIHRoaXMgaW50byBz
dGFibGUgdmVyc2lvbnMgYXMgd2VsbC4KClRoYW5rcywKCk1hdGhpZXUKCi0tLS0tIE9uIEFwciAy
MCwgMjAxNywgYXQgMzoyMyBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNv
bSB3cm90ZToKCj4gVGhlIG1tL3Ztc2Nhbi5jIGNvbXBpbGUgdW5pdCBpcyBhIG9iai15LCBldmVu
IG9uIGFuIG9sZCAyLjYuMzYga2VybmVsLAo+IGFsd2F5cyBidWlsZCB0aGUgdm1zY2FuIHByb2Jl
IHJlZ2FyZGxlc3Mgb2Yga2VybmVsIGNvbmZpZ3VyYXRpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gcHJvYmVzL0ti
dWlsZCB8IDEwICstLS0tLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkg
ZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Byb2Jlcy9LYnVpbGQgYi9wcm9iZXMvS2J1
aWxkCj4gaW5kZXggMmFmYjZkZC4uYmYxNGM3NSAxMDA2NDQKPiAtLS0gYS9wcm9iZXMvS2J1aWxk
Cj4gKysrIGIvcHJvYmVzL0tidWlsZAo+IEBAIC0xNDMsMTkgKzE0MywxMSBAQCBpZm5lcSAoJChD
T05GSUdfU0NTSSksKQo+ICAgICAgIGVjaG8gImx0dG5nLXByb2JlLXNjc2kubyIgOyBmaTspCj4g
ZW5kaWYgIyBDT05GSUdfU0NTSQo+IAo+IC12bXNjYW4gPSAkKHNoZWxsIFwKPiArb2JqLSQoQ09O
RklHX0xUVE5HKSArPSAkKHNoZWxsIFwKPiAgIGlmIFsgJChWRVJTSU9OKSAtZ2UgMyBcCj4gICAg
IC1vIFwoICQoVkVSU0lPTikgLWVxIDIgLWEgJChQQVRDSExFVkVMKSAtZXEgNiAtYSAkKFNVQkxF
VkVMKSAtZ2UgMzYgXCkgXSA7IHRoZW4KPiAgICAgXAo+ICAgICBlY2hvICJsdHRuZy1wcm9iZS12
bXNjYW4ubyIgOyBmaTspCj4gCj4gLWlmbmVxICgkKENPTkZJR19TV0FQKSwpCj4gLSAgb2JqLSQo
Q09ORklHX0xUVE5HKSArPSAkKHZtc2NhbikKPiAtZWxzZQo+IC0gIGlmbmVxICgkKENPTkZJR19D
R1JPVVBfTUVNX1JFU19DVExSKSwpCj4gLSAgICBvYmotJChDT05GSUdfTFRUTkcpICs9ICQodm1z
Y2FuKQo+IC0gIGVuZGlmICMgQ09ORklHX0NHUk9VUF9NRU1fUkVTX0NUTFIKPiAtZW5kaWYgIyBD
T05GSUdfU1dBUAo+IC0KPiAjIGxvY2sgcHJvYmUgZG9lcyBub3Qgd29yaywgc28gZGlzYWJsaW5n
IGl0IGZvciBub3cKPiAjaWZuZXEgKCQoQ09ORklHX0xPQ0tERVApLCkKPiAjICBvYmotJChDT05G
SUdfTFRUTkcpICs9IGx0dG5nLXByb2JlLWxvY2subwo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1
IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
