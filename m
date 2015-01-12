From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/4] Fix: print format type
	mismatch
Date: Mon, 12 Jan 2015 12:05:35 -0500
Message-ID: <CA+jJMxuRQbv=VAv36wjNE5iBqu8OuSxfCtLOdyJ8dsmgwqLNyw__44151.0080280297$1421082396$gmane$org@mail.gmail.com>
References: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YAiQv-0004RI-9D
 for lttng-dev@lists.lttng.org; Mon, 12 Jan 2015 12:05:45 -0500
Received: by mail-qg0-f48.google.com with SMTP id j5so18514003qga.7
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jan 2015 09:05:35 -0800 (PST)
In-Reply-To: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIHRoZSBzZXJpZXMgYWxsIHRoZSB3YXkgdG8gMi40IChleGNlcHQgZm9yIHRoZSBmaXJz
dCBwYXRjaCwKd2hpY2ggb25seSBtYWtlcyBzZW5zZSBmb3IgMi42KykuCgpUaGFua3MhCkrDqXLD
qW1pZQoKT24gVHVlLCBEZWMgMiwgMjAxNCBhdCA1OjIxIFBNLCBNYXRoaWV1IERlc25veWVycwo8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+
ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy1zZXNzaW9uZC9zeXNjYWxsLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2Nh
bGwuYwo+IGluZGV4IGMzOGY4OTEuLmE2ZjBlMWUgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9zeXNjYWxsLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2Nh
bGwuYwo+IEBAIC03Myw3ICs3Myw3IEBAIGludCBzeXNjYWxsX2luaXRfdGFibGUodm9pZCkKPiAg
ICAgICAgIH0KPgo+ICAgICAgICAgd2hpbGUgKGZzY2FuZihmcCwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJzeXNjYWxsIHsgaW5kZXggPSAlbHU7IFwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJzeXNjYWxsIHsgaW5kZXggPSAlenU7IFwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG5hbWUgPSAlIiBYU1RSKFNZU0NBTExfTkFNRV9MRU4pICJb
XjtdOyBcCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiaXRuZXNzID0gJXU7IH07
XG4iLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmluZGV4LCBuYW1lLCAmYml0
bmVzcykgPT0gMykgewo+IC0tCj4gMi4xLjEKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpF
ZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
