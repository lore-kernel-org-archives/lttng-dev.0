From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: do not print error and bug
 messages when quiet (-q) is present
Date: Thu, 14 Jan 2016 11:58:56 -0500
Message-ID: <CA+jJMxuQ2u1jepaCfpYDkwzNv4GQcxjrUW7DW7XcyQqp3Jf-hA__18614.5062595189$1452790801$gmane$org@mail.gmail.com>
References: <1452551534-2130-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aJlEk-0000cN-8D
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 11:59:06 -0500
Received: by mail-ig0-f193.google.com with SMTP id ik10so20490438igb.1
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 08:59:02 -0800 (PST)
In-Reply-To: <1452551534-2130-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIE1vbiwgSmFuIDExLCAyMDE2IGF0IDU6MzIg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gQ29uZm9ybSB0byB0aGUgbHR0bmcgbWFuIHBhZ2UKPgo+IGZpeGVzICM5ODgK
Pgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVs
aWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9lcnJvci5oIHwgNSArKy0tLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL3NyYy9jb21tb24vZXJyb3IuaCBiL3NyYy9jb21tb24vZXJyb3IuaAo+IGluZGV4
IGUwY2IxNTguLmQwNzJiMDAgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi9lcnJvci5oCj4gKysr
IGIvc3JjL2NvbW1vbi9lcnJvci5oCj4gQEAgLTg1LDkgKzg1LDggQEAgZXh0ZXJuIGludCBsdHRu
Z19vcHRfbWk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKHR5cGUgJiAoUFJJ
TlRfREJHIHwgUFJJTlRfREJHMiB8IFBSSU5UX0RCRzMpKSAmJiAgXAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsdHRuZ19vcHRfdmVyYm9zZSA9PSAzKSkpIHsgICAg
ICAgICAgICAgICAgICAgICBcCj4gICAgICAgICAgICAgICAgICAgICAgICAgZnByaW50ZihzdGRl
cnIsIGZtdCwgIyMgYXJncyk7ICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gLSAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAobHR0bmdfb3B0X3F1aWV0ID09IDAgJiYgKHR5cGUgJiAoUFJJTlRf
V0FSTikpKSB7IFwKPiAtICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgZm10
LCAjIyBhcmdzKTsgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiAtICAgICAgICAgICAgICAg
fSBlbHNlIGlmICh0eXBlICYgKFBSSU5UX0VSUiB8IFBSSU5UX0JVRykpIHsgICAgICAgICAgICAg
ICAgXAo+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGx0dG5nX29wdF9xdWlldCA9PSAwICYm
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAodHlwZSAmIChQUklOVF9XQVJOIHwgUFJJTlRfRVJSIHwgUFJJTlRfQlVHKSkpIHsgICAg
XAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCBmbXQsICMjIGFyZ3Mp
OyAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgICAgICAgICB9ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gICAg
ICAgICB9IHdoaWxlICgwKTsKPiAtLQo+IDIuNS4wCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5l
YXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
