From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: return NULL pointer on
	memory allocation failure
Date: Tue, 9 May 2017 08:37:16 -0400
Message-ID: <CA+jJMxvgA1b4xGODd_8Gm7UCQdSjLebnhui0xiJ1h7Qw_eM=cQ__44905.8000384413$1494333448$gmane$org@mail.gmail.com>
References: <1494244132-10812-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMf6R45xxzdTf
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 12:38:07 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id j9so7188344ywj.3
 for <lttng-dev@lists.lttng.org>; Tue, 09 May 2017 05:37:17 -0700 (PDT)
In-Reply-To: <1494244132-10812-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAsIHRoYW5rcyEKCkrDqXLDqW1pZQoKT24g
OCBNYXkgMjAxNyBhdCAwNzo0OCwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9idWZm
ZXItdXNhZ2UuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9idWZmZXItdXNhZ2UuYyBiL3Ny
Yy9jb21tb24vYnVmZmVyLXVzYWdlLmMKPiBpbmRleCA0OTY5NmEzLi5kZmUwZDg1IDEwMDY0NAo+
IC0tLSBhL3NyYy9jb21tb24vYnVmZmVyLXVzYWdlLmMKPiArKysgYi9zcmMvY29tbW9uL2J1ZmZl
ci11c2FnZS5jCj4gQEAgLTIzMSw3ICsyMzEsNyBAQCBzdHJ1Y3QgbHR0bmdfY29uZGl0aW9uICps
dHRuZ19jb25kaXRpb25fYnVmZmVyX3VzYWdlX2NyZWF0ZSgKPgo+ICAgICAgICAgY29uZGl0aW9u
ID0gem1hbGxvYyhzaXplb2Yoc3RydWN0IGx0dG5nX2NvbmRpdGlvbl9idWZmZXJfdXNhZ2UpKTsK
PiAgICAgICAgIGlmICghY29uZGl0aW9uKSB7Cj4gLSAgICAgICAgICAgICAgIGdvdG8gZW5kOwo+
ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgbHR0
bmdfY29uZGl0aW9uX2luaXQoJmNvbmRpdGlvbi0+cGFyZW50LCB0eXBlKTsKPiAtLQo+IDIuMS40
Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
