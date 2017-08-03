From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/1] Fix: uninitialized return
	value on error path
Date: Thu, 3 Aug 2017 12:15:39 -0400
Message-ID: <CA+jJMxtKDz-b5KqFKMNK9jrV2ViWY2TBxx4mUjNkWw50a__dHw__22941.6195805699$1501776949$gmane$org@mail.gmail.com>
References: <20170802153443.29581-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3xNZsn1qR4zCCc
 for <lttng-dev@lists.lttng.org>; Thu,  3 Aug 2017 16:15:40 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id t139so1111145ywg.1
 for <lttng-dev@lists.lttng.org>; Thu, 03 Aug 2017 09:15:40 -0700 (PDT)
In-Reply-To: <20170802153443.29581-1-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTAsIHN0YWJsZS0yLjkgYW5kIHN0YWJsZS0yLjgu
CgpUaGFua3MhCkrDqXLDqW1pZQoKT24gMiBBdWd1c3QgMjAxNyBhdCAxMTozNCwgTWF0aGlldSBE
ZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gRm91bmQg
YnkgQ292ZXJpdHk6Cj4KPiAqKiogQ0lEIDEzNzg4MTA6ICBVbmluaXRpYWxpemVkIHZhcmlhYmxl
cyAgKFVOSU5JVCkKPiAvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jb250ZXh0LmM6IDczIGluIGFk
ZF9rY3R4X2FsbF9jaGFubmVscygpCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVy
cyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NvbnRleHQuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NvbnRleHQuYyBiL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvY29udGV4dC5jCj4gaW5kZXggYTJmMDIyODguLjFlNjhiZDhi
IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY29udGV4dC5jCj4gKysrIGIv
c3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jb250ZXh0LmMKPiBAQCAtNTUsNiArNTUsNyBAQCBzdGF0
aWMgaW50IGFkZF9rY3R4X2FsbF9jaGFubmVscyhzdHJ1Y3QgbHR0X2tlcm5lbF9zZXNzaW9uICpr
c2Vzc2lvbiwKPiAgICAgICAgICAgICAgICAga2N0eF9jb3B5ID0gdHJhY2Vfa2VybmVsX2NvcHlf
Y29udGV4dChrY3R4KTsKPiAgICAgICAgICAgICAgICAgaWYgKCFrY3R4X2NvcHkpIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBQRVJST1IoInptYWxsb2MgbHR0X2tlcm5lbF9jb250ZXh0Iik7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIGVycm9yOwo+ICAgICAgICAgICAgICAgICB9Cj4KPiAtLQo+IDIuMTEu
MAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
