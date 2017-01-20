From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix:
 thread_dispatch_ust_registration needs to be a RCU thread
Date: Fri, 20 Jan 2017 15:54:27 -0500
Message-ID: <CA+jJMxu+VMyCdVtE1pSOrFZwhBp0CUY7PCUYMVjRO2vvnGuq1w__32764.1131975271$1484945685$gmane$org@mail.gmail.com>
References: <1484785407-28923-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3v4tKx4TvJzl7V
 for <lttng-dev@lists.lttng.org>; Fri, 20 Jan 2017 20:56:37 +0000 (UTC)
Received: by mail-vk0-x241.google.com with SMTP id t8so6958039vke.0
 for <lttng-dev@lists.lttng.org>; Fri, 20 Jan 2017 12:54:29 -0800 (PST)
In-Reply-To: <1484785407-28923-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlMi05IGFuZCBzdGFibGUt
Mi44LgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIDE4IEphbnVhcnkgMjAxNyBhdCAxOToyMywgTWF0
aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4g
SXQgdXNlcyBhIHJlYWQtc2lkZSBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNu
b3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9s
dHRuZy1zZXNzaW9uZC9tYWluLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMgYi9z
cmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwo+IGluZGV4IDQwNjcwZGQuLjE3MmY4YzIgMTAw
NjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tYWluLmMKPiArKysgYi9zcmMvYmlu
L2x0dG5nLXNlc3Npb25kL21haW4uYwo+IEBAIC0xODU1LDYgKzE4NTUsOCBAQCBzdGF0aWMgdm9p
ZCAqdGhyZWFkX2Rpc3BhdGNoX3VzdF9yZWdpc3RyYXRpb24odm9pZCAqZGF0YSkKPiAgICAgICAg
ICAgICAgICAgLmNvdW50ID0gMCwKPiAgICAgICAgIH07Cj4KPiArICAgICAgIHJjdV9yZWdpc3Rl
cl90aHJlYWQoKTsKPiArCj4gICAgICAgICBoZWFsdGhfcmVnaXN0ZXIoaGVhbHRoX3Nlc3Npb25k
LCBIRUFMVEhfU0VTU0lPTkRfVFlQRV9BUFBfUkVHX0RJU1BBVENIKTsKPgo+ICAgICAgICAgaWYg
KHRlc3Rwb2ludChzZXNzaW9uZF90aHJlYWRfYXBwX3JlZ19kaXNwYXRjaCkpIHsKPiBAQCAtMjA4
OCw2ICsyMDkwLDcgQEAgZXJyb3JfdGVzdHBvaW50Ogo+ICAgICAgICAgICAgICAgICBFUlIoIkhl
YWx0aCBlcnJvciBvY2N1cnJlZCBpbiAlcyIsIF9fZnVuY19fKTsKPiAgICAgICAgIH0KPiAgICAg
ICAgIGhlYWx0aF91bnJlZ2lzdGVyKGhlYWx0aF9zZXNzaW9uZCk7Cj4gKyAgICAgICByY3VfdW5y
ZWdpc3Rlcl90aHJlYWQoKTsKPiAgICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4KPiAtLQo+IDIu
MS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3
LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
