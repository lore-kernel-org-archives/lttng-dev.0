From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: COMPAT_EPOLL_PROC_PATH
 is available from Linux 2.6.28
Date: Thu, 11 May 2017 10:45:07 -0400
Message-ID: <CA+jJMxuzbkKVtvNwMirKMK=jyhuEEXXjL=4Ap4b_d2_0YfmtNw__20565.1169097566$1494513923$gmane$org@mail.gmail.com>
References: <20170509194635.18701-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wNwrC3j7fzk9l
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 14:45:15 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id 17so1926770ywk.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 07:45:08 -0700 (PDT)
In-Reply-To: <20170509194635.18701-1-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTAsIHN0YWJsZS0yLjksIGFuZCBzdGFibGUtMi44
LgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIDkgTWF5IDIwMTcgYXQgMTU6NDYsIEpvbmF0aGFuIFJh
am90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gdjI6
IFR5cG8gaW4gY29tbWl0IG1lc3NhZ2UgInBlciBzZWUiIC0+ICJwZXIgc2UiCj4KPiBGYWlsaW5n
IG9uIG9wZW5pbmcgWzFdIGlzIG5vdCBhbiBlcnJvciBwZXIgc2UuIFsxXSB3YXMKPiBpbnRyb2R1
Y2VkIGluIExpbnV4IDIuNi4yOCBidXQgZXBvbGwgaXMgYXZhaWxhYmxlIHNpbmNlCj4gMi41LjQ0
LiBIZW5jZSwgZ290byBlbmQgYW5kIHNldCBhIGRlZmF1bHQgdmFsdWUgd2l0aG91dAo+IHNldHRp
bmcgZXJyb3IgcmV0dXJuIHZhbHVlLgo+Cj4gWzFdIC9wcm9jL3N5cy9mcy9lcG9sbC9tYXhfdXNl
cl93YXRjaGVzCj4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5y
YWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9jb21tb24vY29tcGF0L2Nv
bXBhdC1lcG9sbC5jIHwgMTAgKysrKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb21wYXQv
Y29tcGF0LWVwb2xsLmMgYi9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtZXBvbGwuYwo+IGluZGV4
IGRiYWY2ODIzLi42YTc4MWM3YSAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL2NvbXBhdC9jb21w
YXQtZXBvbGwuYwo+ICsrKyBiL3NyYy9jb21tb24vY29tcGF0L2NvbXBhdC1lcG9sbC5jCj4gQEAg
LTMwMSw3ICszMDEsMTUgQEAgaW50IGNvbXBhdF9lcG9sbF9zZXRfbWF4X3NpemUodm9pZCkKPgo+
ICAgICAgICAgZmQgPSBvcGVuKENPTVBBVF9FUE9MTF9QUk9DX1BBVEgsIE9fUkRPTkxZKTsKPiAg
ICAgICAgIGlmIChmZCA8IDApIHsKPiAtICAgICAgICAgICAgICAgcmV0dmFsID0gLTE7Cj4gKyAg
ICAgICAgICAgICAgIC8qCj4gKyAgICAgICAgICAgICAgICAqIEZhaWxpbmcgb24gb3BlbmluZyBb
MV0gaXMgbm90IGFuIGVycm9yIHBlciBzZWUuIFsxXSB3YXMKPiArICAgICAgICAgICAgICAgICog
aW50cm9kdWNlZCBpbiBMaW51eCAyLjYuMjggYnV0IGVwb2xsIGlzIGF2YWlsYWJsZSBzaW5jZQo+
ICsgICAgICAgICAgICAgICAgKiAyLjUuNDQuIEhlbmNlLCBnb3RvIGVuZCBhbmQgc2V0IGEgZGVm
YXVsdCB2YWx1ZSB3aXRob3V0Cj4gKyAgICAgICAgICAgICAgICAqIHNldHRpbmcgYW4gZXJyb3Ig
cmV0dXJuIHZhbHVlLgo+ICsgICAgICAgICAgICAgICAgKgo+ICsgICAgICAgICAgICAgICAgKiBb
MV0gL3Byb2Mvc3lzL2ZzL2Vwb2xsL21heF91c2VyX3dhdGNoZXMKPiArICAgICAgICAgICAgICAg
ICovCj4gKyAgICAgICAgICAgICAgIHJldHZhbCA9IDA7Cj4gICAgICAgICAgICAgICAgIGdvdG8g
ZW5kOwo+ICAgICAgICAgfQo+Cj4gLS0KPiAyLjExLjAKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFy
bmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
