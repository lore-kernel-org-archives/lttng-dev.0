From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: session list lock must be
 held on session put operation
Date: Tue, 12 Feb 2019 11:22:41 -0500
Message-ID: <CA+jJMxvpSzLBoegJBBbmh2bxbp1Dio9C9hVep-PMR02U4y=10w__3197.58076673082$1549988638$gmane$org@mail.gmail.com>
References: <20181219184723.11974-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43zSd34589zgfS
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:19 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 38AF619D611
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:19 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id SFHUNorGa8ZL for <lttng-dev@lists.lttng.org>;
 Tue, 12 Feb 2019 11:23:19 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F1CBA19D609
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:18 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id xwld8m8YrppE for <lttng-dev@lists.lttng.org>;
 Tue, 12 Feb 2019 11:23:18 -0500 (EST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id 9EA8719D5FE
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 11:23:18 -0500 (EST)
Received: by mail-lf1-f49.google.com with SMTP id m11so2461639lfc.6
 for <lttng-dev@lists.lttng.org>; Tue, 12 Feb 2019 08:23:18 -0800 (PST)
In-Reply-To: <20181219184723.11974-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTEuCgpUaGFua3MhCkrDqXLDqW1pZQoKT24g
V2VkLCAxOSBEZWMgMjAxOCBhdCAxMzo0NywgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFq
b3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0
aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9yb3RhdGlvbi10aHJlYWQuYyB8IDQgKystLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvcm90YXRpb24tdGhyZWFkLmMgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL3JvdGF0aW9uLXRocmVhZC5jCj4gaW5kZXggOGU2M2UxNjBmLi42NjY5
MzcyZGQgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9yb3RhdGlvbi10aHJl
YWQuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvcm90YXRpb24tdGhyZWFkLmMKPiBA
QCAtNzYxLDkgKzc2MSw5IEBAIGludCBoYW5kbGVfam9iX3F1ZXVlKHN0cnVjdCByb3RhdGlvbl90
aHJlYWRfaGFuZGxlICpoYW5kbGUsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICogcG9zc2li
bGUgZm9yIGEgam9iIHRhcmdldGluZyB0aGF0IHNlc3Npb24gdG8gaGF2ZQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGFscmVhZHkgYmVlbiBxdWV1ZWQgYmVmb3JlIGl0IHdhcyBkZXN0cm95
ZWQuCj4gICAgICAgICAgICAgICAgICAgICAgICAgICovCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgc2Vzc2lvbl91bmxvY2tfbGlzdCgpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUo
am9iKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBzZXNzaW9uX3B1dChzZXNzaW9uKTsKPiAr
ICAgICAgICAgICAgICAgICAgICAgICBzZXNzaW9uX3VubG9ja19saXN0KCk7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7Cj4gICAgICAgICAgICAgICAgIH0KPgo+IEBAIC04MzIs
NyArODMyLDYgQEAgaW50IGhhbmRsZV9jb25kaXRpb24oY29uc3Qgc3RydWN0IGx0dG5nX2NvbmRp
dGlvbiAqY29uZGl0aW9uLAo+ICAgICAgICAgICAgICAgICBnb3RvIGVuZDsKPiAgICAgICAgIH0K
PiAgICAgICAgIHNlc3Npb25fbG9jayhzZXNzaW9uKTsKPiAtICAgICAgIHNlc3Npb25fdW5sb2Nr
X2xpc3QoKTsKPgo+ICAgICAgICAgcmV0ID0gdW5zdWJzY3JpYmVfc2Vzc2lvbl9jb25zdW1lZF9z
aXplX3JvdGF0aW9uKHNlc3Npb24sCj4gICAgICAgICAgICAgICAgICAgICAgICAgbm90aWZpY2F0
aW9uX3RocmVhZF9oYW5kbGUpOwo+IEBAIC04NjEsNiArODYwLDcgQEAgaW50IGhhbmRsZV9jb25k
aXRpb24oY29uc3Qgc3RydWN0IGx0dG5nX2NvbmRpdGlvbiAqY29uZGl0aW9uLAo+ICBlbmRfdW5s
b2NrOgo+ICAgICAgICAgc2Vzc2lvbl91bmxvY2soc2Vzc2lvbik7Cj4gICAgICAgICBzZXNzaW9u
X3B1dChzZXNzaW9uKTsKPiArICAgICAgIHNlc3Npb25fdW5sb2NrX2xpc3QoKTsKPiAgZW5kOgo+
ICAgICAgICAgcmV0dXJuIHJldDsKPiAgfQo+IC0tCj4gMi4xNy4xCj4KCgotLSAKSsOpcsOpbWll
IEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
