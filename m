From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Lazily initialize max poll
 set size in poll compat
Date: Tue, 31 Jan 2017 15:16:14 -0500
Message-ID: <CA+jJMxuwLBUqto6-yz5LYpFA8WOpDN3ieZkaNdR6UpN7-5iUvg__49385.0017818206$1485893793$gmane$org@mail.gmail.com>
References: <1485459405-24862-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3vCczq4zMpzky4
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2017 20:19:19 +0000 (UTC)
Received: by mail-ua0-x242.google.com with SMTP id d5so34123729uag.0
 for <lttng-dev@lists.lttng.org>; Tue, 31 Jan 2017 12:16:15 -0800 (PST)
In-Reply-To: <1485459405-24862-1-git-send-email-mjeanson@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuOSBhbmQgc3RhYmxlLTIuOC4KClRoYW5rcyEKSsOp
csOpbWllCgpPbiAyNiBKYW51YXJ5IDIwMTcgYXQgMTQ6MzYsIE1pY2hhZWwgSmVhbnNvbiA8bWpl
YW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGlzIHdhcyBhcHBsaWVkIHRvIHRoZSBlcG9s
bCBpbXBsZW1lbnRhdGlvbiBpbiBjb21taXQKPiAyMmRhZDU2ODE1Y2UwMjAxYzVhZTdkNWVmNWQ3
OWNjMGM2YTQyYzVlCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29u
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LXBvbGwuYyB8
IDUgKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtcG9sbC5jIGIvc3Jj
L2NvbW1vbi9jb21wYXQvY29tcGF0LXBvbGwuYwo+IGluZGV4IGNjMjgwYzcuLjdkNGQwZTEgMTAw
NjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LXBvbGwuYwo+ICsrKyBiL3NyYy9j
b21tb24vY29tcGF0L2NvbXBhdC1wb2xsLmMKPiBAQCAtMTExLDggKzExMSw5IEBAIGludCBjb21w
YXRfcG9sbF9jcmVhdGUoc3RydWN0IGx0dG5nX3BvbGxfZXZlbnQgKmV2ZW50cywgaW50IHNpemUp
Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIGlmICghcG9sbF9tYXhfc2l6ZSkgewo+IC0gICAgICAg
ICAgICAgICBFUlIoInBvbGxfbWF4X3NpemUgbm90IGluaXRpYWxpemVkIHlldCIpOwo+IC0gICAg
ICAgICAgICAgICBnb3RvIGVycm9yOwo+ICsgICAgICAgICAgICAgICBpZiAobHR0bmdfcG9sbF9z
ZXRfbWF4X3NpemUoKSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7Cj4g
KyAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+ICAgICAgICAgLyogRG9uJ3QgYnVzdCB0
aGUgbGltaXQgaGVyZSAqLwo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVh
dQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
