From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: run_command_wait() handle
 partial write
Date: Tue, 22 Jan 2019 15:33:07 -0500
Message-ID: <CA+jJMxvdfM03FdSCe4hd3oWV9eUjQ=noiTyxLDRJjgRHL5fJxg__12854.1699423053$1548189242$gmane$org@mail.gmail.com>
References: <20181213185635.8019-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43kg9j6BNhzncx
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:33:45 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 821E7B5C62
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:33:45 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id ejRuy_eIP7yc for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:33:45 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 42C37B5C5D
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:33:45 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id HjKKfpCLyi3L for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:33:45 -0500 (EST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id E2ECFB5C4E
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:33:44 -0500 (EST)
Received: by mail-lf1-f49.google.com with SMTP id c16so19089341lfj.8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:33:44 -0800 (PST)
In-Reply-To: <20181213185635.8019-1-mathieu.desnoyers@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIGFuZCBzdGFibGUtMi4xMC4KClRoYW5rcywK
SsOpcsOpbWllCgpPbiBUaHUsIDEzIERlYyAyMDE4IGF0IDEzOjU2LCBNYXRoaWV1IERlc25veWVy
cwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IFVzZSBsdHRuZ193
cml0ZSgpIHRvIGhhbmRsZSBwYXJ0aWFsIHdyaXRlcyAod3JpdGluZyBsZXNzIHRoYW4gdGhlCj4g
cmVxdWVzdGVkIGFtb3VudCBvZiBieXRlcykgYXMgd2VsbCBhcyByZXQgPSAtMSwgZXJybm8gPSBF
SU5UUi4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25v
eWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZp
Y2F0aW9uLXRocmVhZC1jb21tYW5kcy5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9ub3RpZmljYXRpb24tdGhyZWFkLWNvbW1hbmRzLmMgYi9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL25vdGlmaWNhdGlvbi10aHJlYWQtY29tbWFuZHMuYwo+IGluZGV4IDExMjc1ZmZj
Li4xMjljZjRlZSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNh
dGlvbi10aHJlYWQtY29tbWFuZHMuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90
aWZpY2F0aW9uLXRocmVhZC1jb21tYW5kcy5jCj4gQEAgLTQ0LDkgKzQ0LDkgQEAgaW50IHJ1bl9j
b21tYW5kX3dhaXQoc3RydWN0IG5vdGlmaWNhdGlvbl90aHJlYWRfaGFuZGxlICpoYW5kbGUsCj4g
ICAgICAgICBjZHNfbGlzdF9hZGRfdGFpbCgmY21kLT5jbWRfbGlzdF9ub2RlLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICZoYW5kbGUtPmNtZF9xdWV1ZS5saXN0KTsKPiAgICAgICAgIC8qIFdh
a2UtdXAgdGhyZWFkLiAqLwo+IC0gICAgICAgcmV0ID0gd3JpdGUobHR0bmdfcGlwZV9nZXRfd3Jp
dGVmZChoYW5kbGUtPmNtZF9xdWV1ZS5ldmVudF9waXBlKSwKPiArICAgICAgIHJldCA9IGx0dG5n
X3dyaXRlKGx0dG5nX3BpcGVfZ2V0X3dyaXRlZmQoaGFuZGxlLT5jbWRfcXVldWUuZXZlbnRfcGlw
ZSksCj4gICAgICAgICAgICAgICAgICAgICAgICAgJm5vdGlmaWNhdGlvbl9jb3VudGVyLCBzaXpl
b2Yobm90aWZpY2F0aW9uX2NvdW50ZXIpKTsKPiAtICAgICAgIGlmIChyZXQgPCAwKSB7Cj4gKyAg
ICAgICBpZiAocmV0ICE9IHNpemVvZihub3RpZmljYXRpb25fY291bnRlcikpIHsKPiAgICAgICAg
ICAgICAgICAgUEVSUk9SKCJ3cml0ZSB0byBub3RpZmljYXRpb24gdGhyZWFkJ3MgcXVldWUgZXZl
bnQgZmQiKTsKPiAgICAgICAgICAgICAgICAgLyoKPiAgICAgICAgICAgICAgICAgICogUmVtb3Zl
IHRoZSBjb21tYW5kIGZyb20gdGhlIGxpc3Qgc28gdGhlIG5vdGlmaWNhdGlvbgo+IC0tCj4gMi4x
MS4wCj4KCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
