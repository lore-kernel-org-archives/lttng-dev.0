From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: PATH_MAX requires limits.h
	on some platforms
Date: Tue, 3 May 2016 12:58:48 -0400
Message-ID: <CA+jJMxs08fNm39iuWSMDRPmqY-pUiDiksa8BW9F30d5Qc=ignQ__41327.7430147447$1462294753$gmane$org@mail.gmail.com>
References: <1462294311-28165-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 600B2A3373
 for <lttng-dev@lists.lttng.org>; Tue,  3 May 2016 16:58:50 +0000 (UTC)
Received: by mail-qg0-f43.google.com with SMTP id f92so11155849qgf.0
 for <lttng-dev@lists.lttng.org>; Tue, 03 May 2016 09:58:49 -0700 (PDT)
In-Reply-To: <1462294311-28165-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIHdpdGggYSB0aXRsZSBlZGl0IHRvIG1lbnRpb24gT1MgWCBhbmQgU29sYXJpcywgdGhh
bmtzIQoKSsOpcsOpbWllCgpPbiBUdWUsIE1heSAzLCAyMDE2IGF0IDEyOjUxIFBNLCBNaWNoYWVs
IEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL2xp
Yi9jb21tb24uYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRp
ZmYgLS1naXQgYS90ZXN0cy9saWIvY29tbW9uLmMgYi90ZXN0cy9saWIvY29tbW9uLmMKPiBpbmRl
eCBkMTM3Y2IzLi4wYjhlYmRmIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL2xpYi9jb21tb24uYwo+ICsr
KyBiL3Rlc3RzL2xpYi9jb21tb24uYwo+IEBAIC0yMiw2ICsyMiw3IEBACj4gICNpbmNsdWRlIDxi
YWJlbHRyYWNlL2NvbnRleHQuaD4KPiAgI2luY2x1ZGUgPGJhYmVsdHJhY2UvaXRlcmF0b3IuaD4K
PiAgI2luY2x1ZGUgPGJhYmVsdHJhY2UvY29tcGF0L2RpcmVudC5oPgo+ICsjaW5jbHVkZSA8YmFi
ZWx0cmFjZS9jb21wYXQvbGltaXRzLmg+Cj4gICNpbmNsdWRlIDxzeXMvc3RhdC5oPgo+Cj4gIHN0
cnVjdCBidF9jb250ZXh0ICpjcmVhdGVfY29udGV4dF93aXRoX3BhdGgoY29uc3QgY2hhciAqcGF0
aCkKPiAtLQo+IDIuNy40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
