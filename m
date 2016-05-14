From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH RFC lttng-tools] Drop installcheck target
Date: Sat, 14 May 2016 16:56:48 -0400
Message-ID: <CA+jJMxtkEbuak0C=s3UJm-LXnkWhTcp9SmOiG7+KHi9SAh0=Tw__12479.3407078416$1463259453$gmane$org@mail.gmail.com>
References: <1463069276-31747-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CD985A34C2
 for <lttng-dev@lists.lttng.org>; Sat, 14 May 2016 20:56:49 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id e35so10729081qge.1
 for <lttng-dev@lists.lttng.org>; Sat, 14 May 2016 13:56:49 -0700 (PDT)
In-Reply-To: <1463069276-31747-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGluIHN0YWJsZS0yLjggYW5kIG1hc3Rlci4gVGhhbmtzIQoKSsOpcsOpbWllCgpPbiBU
aHUsIE1heSAxMiwgMjAxNiBhdCAxMjowNyBQTSwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBl
ZmZpY2lvcy5jb20+IHdyb3RlOgo+IFRoZSBpbnN0YWxsY2hlY2sgdGFyZ2V0IGlzIHN1cHBvc2Vk
IHRvIGJlIHVzZWQgdG8gcnVuIHRlc3RzIG9uIHRoZQo+IGluc3RhbGxlZCBmaWxlcywgaG93ZXZl
ciBvdXIgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBydW5zIHRoZSBleGFjdCBzYW1lCj4gdGVzdHMg
aW4gdGhlIGJ1aWxkIGRpcmVjdG9yeSBhcyB0aGUgY2hlY2sgdGFyZ2V0LCB3aGljaCBtYWtlcyBp
dCB1c2VsZXNzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBl
ZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL01ha2VmaWxlLmFtIHwgMTYgLS0tLS0tLS0tLS0t
LS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
dGVzdHMvTWFrZWZpbGUuYW0gYi90ZXN0cy9NYWtlZmlsZS5hbQo+IGluZGV4IDAxNzE2M2YuLmM3
ZDRjZDAgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvTWFrZWZpbGUuYW0KPiArKysgYi90ZXN0cy9NYWtl
ZmlsZS5hbQo+IEBAIC01LDIyICs1LDYgQEAgaWYgQlVJTERfVEVTVFMKPiAgU1VCRElSUyArPSB1
dGlscyByZWdyZXNzaW9uIHVuaXQgc3RyZXNzIGRlc3RydWN0aXZlCj4gIGVuZGlmCj4KPiAtaW5z
dGFsbGNoZWNrLWFtOgo+IC1pZiBCVUlMRF9URVNUUwo+IC1pZiBIQVNfUEdSRVAKPiAtICAgICAg
IC4vdXRpbHMvd2Fybl9sdHRuZ19wcm9jZXNzZXMuc2ggJChQR1JFUCkKPiAtZW5kaWYKPiAtICAg
ICAgIC4vcnVuLnNoIHVuaXRfdGVzdHMKPiAtICAgICAgIC4vcnVuLnNoIGZhc3RfcmVncmVzc2lv
bgo+IC1pZiBQWVRIT05fQklORElORwo+IC0gICAgICAgLi9ydW4uc2ggd2l0aF9iaW5kaW5nc19y
ZWdyZXNzaW9uCj4gLWVuZGlmCj4gLWVsc2UKPiAtICAgICAgIEBlY2hvICI9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKPiAtICAgICAgIEBlY2hvICJXQVJOSU5HOiBU
ZXN0cyB3ZXJlIGRpc2FibGVkIGF0IGNvbmZpZ3VyZSIKPiAtICAgICAgIEBlY2hvICI9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKPiAtZW5kaWYKPiAtCj4gIGNoZWNr
LWFtOgo+ICBpZiBCVUlMRF9URVNUUwo+ICBpZiBIQVNfUEdSRVAKPiAtLQo+IDEuOS4xCj4KCgoK
LS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
