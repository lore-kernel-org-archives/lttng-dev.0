From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace-1.5 6/6] Fix: lttng-live format:
 do not error out on empty streams hang up
Date: Thu, 12 Dec 2019 20:03:30 -0500
Message-ID: <CA+jJMxvMQMPtEALXmZsm5v7rd9svZM1XCfXWqVRuYMQUprZePg__14472.1287231491$1576199072$gmane$org@mail.gmail.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
 <20191205065809.16728-7-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47YsrH4F1Sz17KJ
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 20:04:15 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8D6D8688352
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 20:04:09 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id 2yyWHpYVWhcC for <lttng-dev@lists.lttng.org>;
 Thu, 12 Dec 2019 20:04:09 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 4B62B68834B
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 20:04:09 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id a9HcPWnZ9EkA for <lttng-dev@lists.lttng.org>;
 Thu, 12 Dec 2019 20:04:09 -0500 (EST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mail.efficios.com (Postfix) with ESMTPSA id EABCE688335
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 20:04:08 -0500 (EST)
Received: by mail-lj1-f169.google.com with SMTP id z17so700055ljk.13
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 17:04:08 -0800 (PST)
In-Reply-To: <20191205065809.16728-7-mathieu.desnoyers@efficios.com>
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

QWxsIHBhdGNoZXMgb2YgdGhpcyBzZXJpZXMgd2VyZSBtZXJnZWQgaW4gc3RhYmxlLTEuNS4KClRo
YW5rcyEKSsOpcsOpbWllCgpPbiBUaHUsIDUgRGVjIDIwMTkgYXQgMDE6NTgsIE1hdGhpZXUgRGVz
bm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Cj4gQXR0YWNo
aW5nIHRvIGEgc3RyZWFtIGh1bmcgdXAgYmVmb3JlIHByb3ZpZGluZyBhbnkgdHJhY2UgcGFja2V0
Cj4gY2F1c2VzIGN0Zl9vcGVuX21tYXBfc3RyZWFtX3JlYWQoKSB0byByZXR1cm4gYW4gZXJyb3Iu
Cj4KPiBUaGlzIGtpbmQgb2Ygc2NlbmFyaW8gY2FuIGhhcHBlbiB3aXRoIHRoZSB1cGNvbWluZyAi
bHR0bmcgY2xlYXIiCj4gZmVhdHVyZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95
ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGZvcm1hdHMvY3Rm
L2N0Zi5jIHwgNyArKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9jdGYuYyBiL2Zvcm1hdHMv
Y3RmL2N0Zi5jCj4gaW5kZXggOTgwZWJjOWEuLjFiYTkwMTdmIDEwMDY0NAo+IC0tLSBhL2Zvcm1h
dHMvY3RmL2N0Zi5jCj4gKysrIGIvZm9ybWF0cy9jdGYvY3RmLmMKPiBAQCAtMjU3MSw4ICsyNTcx
LDEzIEBAIGludCBjdGZfb3Blbl9tbWFwX3N0cmVhbV9yZWFkKHN0cnVjdCBjdGZfdHJhY2UgKnRk
LAo+ICAgICAgICAgfQo+Cj4gICAgICAgICByZXQgPSBwcmVwYXJlX21tYXBfc3RyZWFtX2RlZmlu
aXRpb24odGQsIGZpbGVfc3RyZWFtLCBwYWNrZXRfc2Vlayk7Cj4gLSAgICAgICBpZiAocmV0KQo+
ICsgICAgICAgaWYgKHJldCkgewo+ICsgICAgICAgICAgICAgICAvKiBXZSBuZWVkIHRvIGNoZWNr
IGZvciBFT0YgaGVyZSBmb3IgZW1wdHkgZmlsZXMuICovCj4gKyAgICAgICAgICAgICAgIGlmICh1
bmxpa2VseShmaWxlX3N0cmVhbS0+cG9zLm9mZnNldCA9PSBFT0YpKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gMDsKPiArICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAg
ICBnb3RvIGVycm9yX2luZGV4Owo+ICsgICAgICAgfQo+Cj4gICAgICAgICAvKgo+ICAgICAgICAg
ICogRm9yIG5vdywgb25seSBhIHNpbmdsZSBjbG9jayBwZXIgdHJhY2UgaXMgc3VwcG9ydGVkLgo+
IC0tCj4gMi4xNy4xCj4KCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
