From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: remove
 g_spawn_check_exit_status to support glib 2.22
Date: Thu, 31 Aug 2017 16:54:19 -0400
Message-ID: <CA+jJMxsGXvD=nswPKRsoH4pUBs=q_g_t+LLCwSRWq=tAeyfCnw__37053.1253902756$1504212900$gmane$org@mail.gmail.com>
References: <1504119263-15163-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3xjvkP2h7gzD4Z
 for <lttng-dev@lists.lttng.org>; Thu, 31 Aug 2017 20:54:21 +0000 (UTC)
Received: by mail-qt0-x242.google.com with SMTP id v20so624262qtg.1
 for <lttng-dev@lists.lttng.org>; Thu, 31 Aug 2017 13:54:21 -0700 (PDT)
In-Reply-To: <1504119263-15163-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDMwIEF1Z3VzdCAyMDE3IGF0IDE0OjU0LCBN
aWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRl
c3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYyB8IDEwICsrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0
cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMgYi90ZXN0cy9saWIvdGVzdF9jdGZfd3JpdGVyLmMKPiBp
bmRleCAzZDI0ZWE0Li45YzY1ZDg0IDEwMDY0NAo+IC0tLSBhL3Rlc3RzL2xpYi90ZXN0X2N0Zl93
cml0ZXIuYwo+ICsrKyBiL3Rlc3RzL2xpYi90ZXN0X2N0Zl93cml0ZXIuYwo+IEBAIC0xMjIsMTAg
KzEyMiwxNiBAQCB2b2lkIHZhbGlkYXRlX3RyYWNlKGNoYXIgKnBhcnNlcl9wYXRoLCBjaGFyICp0
cmFjZV9wYXRoKQo+ICAgICAgICAgICAgICAgICBnb3RvIHJlc3VsdDsKPiAgICAgICAgIH0KPgo+
IC0gICAgICAgaWYoIWdfc3Bhd25fY2hlY2tfZXhpdF9zdGF0dXMoZXhpdF9zdGF0dXMsIE5VTEwp
KSB7Cj4gKyAgICAgICAvKiBSZXBsYWNlIGJ5IGdfc3Bhd25fY2hlY2tfZXhpdF9zdGF0dXMgd2hl
biB3ZSByZXF1aXJlIGdsaWIgPj0gMi4zNCAqLwo+ICsjaWYgR19PU19VTklYCj4gKyAgICAgICBy
ZXQgPSBXSUZFWElURUQoZXhpdF9zdGF0dXMpID8gV0VYSVRTVEFUVVMoZXhpdF9zdGF0dXMpIDog
LTE7Cj4gKyNlbHNlCj4gKyAgICAgICByZXQgPSBleGl0X3N0YXR1czsKPiArI2VuZGlmCj4gKwo+
ICsgICAgICAgaWYocmV0ICE9IDApIHsKPiAgICAgICAgICAgICAgICAgZGlhZygiQmFiZWx0cmFj
ZSByZXR1cm5lZCBhbiBlcnJvci4iKTsKPiAgICAgICAgICAgICAgICAgZGlhZ19tdWx0aWxpbmUo
c3RhbmRhcmRfZXJyb3IpOwo+IC0gICAgICAgICAgICAgICByZXQgPSAtMTsKPiAgICAgICAgICAg
ICAgICAgZ290byByZXN1bHQ7Cj4gICAgICAgICB9Cj4KPiAtLQo+IDIuNy40Cj4KCgoKLS0gCkrD
qXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
