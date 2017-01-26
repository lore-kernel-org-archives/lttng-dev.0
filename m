From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] x is never reused,
	no need to shift it
Date: Wed, 25 Jan 2017 19:32:50 -0500
Message-ID: <CA+jJMxvPi54_17XUUf9OfjUv1+OdQ64W4Lwri5vuoLQZMkwE5A__16058.4625359208$1485390873$gmane$org@mail.gmail.com>
References: <1484665651-23987-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3v82y609JYzk9y
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2017 00:35:25 +0000 (UTC)
Received: by mail-ua0-x241.google.com with SMTP id d5so20890377uag.0
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jan 2017 16:32:51 -0800 (PST)
In-Reply-To: <1484665651-23987-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlci4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiAxNyBKYW51YXJ5IDIwMTcg
YXQgMTA6MDcsIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmlj
aW9zLmNvbT4gd3JvdGU6Cj4gQWxzbyByZW1vdmUgbm9pc2UgaW4gc2NhbmJ1aWxkIHJlcG9ydC4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVs
aWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtbWV0
YWRhdGEuYyB8IDEgLQo+ICBzcmMvY29tbW9uL2NvbXBhdC9zdHJpbmcuaCAgICAgICAgICAgIHwg
MSAtCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9z
cmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1tZXRhZGF0YS5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNz
aW9uZC91c3QtbWV0YWRhdGEuYwo+IGluZGV4IGMxYTgwYzcuLmZiMWYxMTUgMTAwNjQ0Cj4gLS0t
IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtbWV0YWRhdGEuYwo+ICsrKyBiL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvdXN0LW1ldGFkYXRhLmMKPiBAQCAtNzQsNyArNzQsNiBAQCBpbnQgZmxz
KHVuc2lnbmVkIGludCB4KQo+ICAgICAgICAgICAgICAgICByIC09IDI7Cj4gICAgICAgICB9Cj4g
ICAgICAgICBpZiAoISh4ICYgMHg4MDAwMDAwMFUpKSB7Cj4gLSAgICAgICAgICAgICAgIHggPDw9
IDE7Cj4gICAgICAgICAgICAgICAgIHIgLT0gMTsKPiAgICAgICAgIH0KPiAgICAgICAgIHJldHVy
biByOwo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2NvbXBhdC9zdHJpbmcuaCBiL3NyYy9jb21t
b24vY29tcGF0L3N0cmluZy5oCj4gaW5kZXggN2M0MjZlZi4uZGIzZGI4MCAxMDA2NDQKPiAtLS0g
YS9zcmMvY29tbW9uL2NvbXBhdC9zdHJpbmcuaAo+ICsrKyBiL3NyYy9jb21tb24vY29tcGF0L3N0
cmluZy5oCj4gQEAgLTExNyw3ICsxMTcsNiBAQCBzdGF0aWMgaW5saW5lIGludCBsdHRuZ19mbHMo
aW50IHZhbCkKPiAgICAgICAgICAgICAgICAgciAtPSAyOwo+ICAgICAgICAgfQo+ICAgICAgICAg
aWYgKCEoeCAmIDB4ODAwMDAwMDBVKSkgewo+IC0gICAgICAgICAgICAgICB4IDw8PSAxOwo+ICAg
ICAgICAgICAgICAgICByIC09IDE7Cj4gICAgICAgICB9Cj4gICAgICAgICByZXR1cm4gcjsKPiAt
LQo+IDIuNy40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRw
Oi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
