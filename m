From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tool 1/2] Fix: out-of-tree build:
 missing xsd file for save-load test execution
Date: Fri, 6 Feb 2015 12:07:42 -0500
Message-ID: <CA+jJMxsAv=+0uQi90BP3aDLcFLKE+VM7XOLi6Y-5tNZJj3G_7Q__12694.1779898063$1423242519$gmane$org@mail.gmail.com>
References: <1422642611-28785-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YJmNg-0003jH-5C
 for lttng-dev@lists.lttng.org; Fri, 06 Feb 2015 12:07:49 -0500
Received: by mail-qg0-f52.google.com with SMTP id h3so8231363qgf.11
 for <lttng-dev@lists.lttng.org>; Fri, 06 Feb 2015 09:07:42 -0800 (PST)
In-Reply-To: <1422642611-28785-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGluIG1hc3RlciBhbmQgdGhlIGFmZmVjdGVkIHN0YWJs
ZSBicmFuY2hlcy4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBGcmksIEphbiAzMCwgMjAxNSBhdCAx
OjMwIFBNLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lv
cy5jb20+IHdyb3RlOgo+IFRoaXMgbmVlZCB0byBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZSAyLjYg
YW5kIHN0YWJsZSAyLjUKPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0
aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9jb25m
aWcvTWFrZWZpbGUuYW0gfCAxNCArKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29uZmlnL01ha2VmaWxl
LmFtIGIvc3JjL2NvbW1vbi9jb25maWcvTWFrZWZpbGUuYW0KPiBpbmRleCA1YWNjODlkLi5lMzZi
NDJmIDEwMDY0NAo+IC0tLSBhL3NyYy9jb21tb24vY29uZmlnL01ha2VmaWxlLmFtCj4gKysrIGIv
c3JjL2NvbW1vbi9jb25maWcvTWFrZWZpbGUuYW0KPiBAQCAtOSwzICs5LDE3IEBAIGxpYmNvbmZp
Z19sYV9MSUJBREQgPSAkKFhNTF9MSUJTKQo+ICB4bWxkaXIgPSAkKGRhdGFkaXIpL3htbC9sdHRu
Zwo+ICBkaXN0X3htbF9EQVRBID0gc2Vzc2lvbi54c2QKPiAgRVhUUkFfRElTVCA9IHNlc3Npb24u
eHNkCj4gKwo+ICthbGwtbG9jYWw6Cj4gKyAgICAgICBAaWYgWyB4IiQoc3JjZGlyKSIgIT0geCIk
KGJ1aWxkZGlyKSIgXTsgdGhlbiBcCj4gKyAgICAgICAgICAgICAgIGZvciBzY3JpcHQgaW4gJChF
WFRSQV9ESVNUKTsgZG8gXAo+ICsgICAgICAgICAgICAgICBjcCAtZiAkKHNyY2RpcikvJCRzY3Jp
cHQgJChidWlsZGRpcik7IFwKPiArICAgICAgICAgICAgICAgZG9uZTsgXAo+ICsgICAgICAgZmkK
PiArCj4gK2NsZWFuLWxvY2FsOgo+ICsgICAgICAgQGlmIFsgeCIkKHNyY2RpcikiICE9IHgiJChi
dWlsZGRpcikiIF07IHRoZW4gXAo+ICsgICAgICAgICAgICAgICBmb3Igc2NyaXB0IGluICQoRVhU
UkFfRElTVCk7IGRvIFwKPiArICAgICAgICAgICAgICAgcm0gLWYgJChidWlsZGRpcikvJCRzY3Jp
cHQ7IFwKPiArICAgICAgICAgICAgICAgZG9uZTsgXAo+ICsgICAgICAgZmkKPiAtLQo+IDEuOS4x
Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
