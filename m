From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: add missing refcount of
	loaded modules
Date: Mon, 21 Nov 2016 12:56:51 -0500
Message-ID: <CA+jJMxuyrD+xrdpN1W6n8dk1NM4zHCRrYjw++AZG4m36Q4Gfhw__11651.3166962706$1479751023$gmane$org@mail.gmail.com>
References: <1479749760-20017-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3tMxCl3S70zlyc
 for <lttng-dev@lists.lttng.org>; Mon, 21 Nov 2016 17:58:11 +0000 (UTC)
Received: by mail-vk0-x244.google.com with SMTP id p9so25233744vkd.1
 for <lttng-dev@lists.lttng.org>; Mon, 21 Nov 2016 09:56:52 -0800 (PST)
In-Reply-To: <1479749760-20017-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

R29vZCBjYXRjaCEgTWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4K
ClRoYW5rcyEKSsOpcsOpbWllCgoKCk9uIDIxIE5vdmVtYmVyIDIwMTYgYXQgMTI6MzYsIEZyYW5j
aXMgRGVzbGF1cmllcnMKPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPiB3cm90ZToK
PiBTaWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJz
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9tb2Rwcm9iZS5j
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMgYi9zcmMv
YmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMKPiBpbmRleCAwNTAyNzQwLi4wMzU0NWVmIDEw
MDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+ICsrKyBiL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+IEBAIC0zNDMsNyArMzQzLDcgQEAgc3Rh
dGljIGludCBtb2Rwcm9iZV9sdHRuZyhzdHJ1Y3Qga2Vybl9tb2R1bGVzX3BhcmFtICptb2R1bGVz
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsK
PiAgICAgICAgICAgICAgICAgICAgICAgICBEQkcoIk1vZHByb2JlIHN1Y2Nlc3NmdWxseSAlcyIs
IG1vZHVsZXNbaV0ubmFtZSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgbW9kdWxlc1tpXS5s
b2FkZWQ7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgbW9kdWxlc1tpXS5sb2FkZWQgPSB0cnVl
Owo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4KPiAtLQo+IDIuNy40Cj4KCgoKLS0g
CkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
