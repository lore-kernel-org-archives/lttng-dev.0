From: Samuel Martin <s.martin49@gmail.com>
Subject: Re: [PATCH babeltrace] configure: fix uuid support
 detection on static build
Date: Sun, 26 Jun 2016 18:26:56 +0200
Message-ID: <CAHXCMMLp5tBMbo3oEzbY1yqnpGphKYMid+UTfwtr8zdYQvbfKQ__2451.71159408546$1466958479$gmane$org@mail.gmail.com>
References: <20160601195632.23585-1-s.martin49@gmail.com>
 <CA+jJMxuRg7U-TuA5sWgW+e8mRf3ebO1BjcQ+1caqHT6ecUOTNw@mail.gmail.com>
 <CAHXCMMLfmjew0zJPzvdfW5nT2GWrJ=WpZkbo8oAB4660EqPgAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
 [209.85.192.171])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 371DDA385D
 for <lttng-dev@lists.lttng.org>; Sun, 26 Jun 2016 16:27:38 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id i123so53923323pfg.0
 for <lttng-dev@lists.lttng.org>; Sun, 26 Jun 2016 09:27:38 -0700 (PDT)
In-Reply-To: <CAHXCMMLfmjew0zJPzvdfW5nT2GWrJ=WpZkbo8oAB4660EqPgAQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSsOpcsOpbWllLAoKT24gVHVlLCBKdW4gMTQsIDIwMTYgYXQgODoyMSBBTSwgU2FtdWVsIE1h
cnRpbiA8cy5tYXJ0aW40OUBnbWFpbC5jb20+IHdyb3RlOgo+IEhpIErDqXLDqW1pZSwKPgo+IE9u
IFR1ZSwgSnVuIDE0LCAyMDE2IGF0IDE6MjEgQU0sIErDqXLDqW1pZSBHYWxhcm5lYXUKPiA8amVy
ZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPiB3cm90ZToKPj4gT24gV2VkLCBKdW4gMSwgMjAx
NiBhdCAzOjU2IFBNLCBTYW11ZWwgTWFydGluIDxzLm1hcnRpbjQ5QGdtYWlsLmNvbT4gd3JvdGU6
Cj4+PiBUaGlzIGNoYW5nZSBhZGRzIHV1aWQgZGV0ZWN0aW9uIHVzaW5nIHBrZy1jb25maWcgaGVs
cGVyIGJlZm9yZSBmYWxsaW5nCj4+PiBiYWNrIG9uIHRoZSBzdGFuZGFyZCBBQ19DSEVDS19MSUIg
ZGV0ZWN0aW9uIGZvciBwbGF0Zm9ybXMgbWlzc2luZwo+Pj4gcGtnLWNvbmZpZy4KPj4+Cj4+PiBB
Q19DSEVDS19MSUIgZnVuY3Rpb24gYWNoaWV2ZXMgaXRzIHRlc3QgYnkgdHJ5aW5nIHRvIGxpbmsg
YWdhaW5zdCB0aGUKPj4+IHJlcXVlc3RlZCBsaWJyYXJ5LCB3aXRob3V0IHRha2luZyBjYXJlIG9m
IGl0cyBkZXBlbmRlbmN5Cj4+PiByZXF1aXJlbWVudHMvZmxhZ3MgdGhhdCBtYXkgZGlmZmVyIGJl
dHdlZW4gZGlmZmVyZW50IHRhcmdldHMuCj4+PiBUaGVyZWZvcmUsIGluIGNhc2Ugb2Ygc3RhdGlj
IGJ1aWxkLCBpdCBjYW4gZmFpbCBvbiB0aGUgdXVpZCBkZXRlY3Rpb24KPj4+IGxpa2UgWzFdLCBi
ZWNhdXNlIHRoZSB1dWlkJ3MgZGVwZW5kZW5jeSBmbGFncyAocmVnYXJkaW5nIGdldHRleHQpIGFy
ZQo+Pj4gbWlzc2luZy4KPj4KPj4gSGkgU2FtdWVsLAo+Pgo+PiBUaGUgc2FtZSByZXF1aXJlbWVu
dHMgc2VlbSB0byBleGlzdCBmb3IgZ2xpYiAoZ2V0dGV4dCksIGRvZXMgdGhlCj4+IGNoYW5nZSBu
ZWVkIHRvIGJlIG1hZGUgZm9yIGl0IGFsc28/Cj4gTWF5YmUsIEkgZGlkIG5vdCB0cmlnZ2VyIHRo
aXMgaW4gbXkgdGVzdCAoY2VydGFpbmx5IGJlY2F1c2UgZml4IHRoZQo+IGZpcnN0IGVycm9yIHdh
cyBlbm91Z2ggdG8gcHJvdmlkZSBhbGwgZGVwcyB0aGUgb3RoZXJzIG5lZWQuLi4pCj4gSSdsbCBj
aGVjayBpdCBhbmQgcmVwb3J0IGJhY2sgaGVyZS4KClNvcnJ5IGZvciBiZWluZyBzbyBsb25nIDot
LwoKQUZBSUNTLCB0aGUgZ2xpYiBkZXBlbmRlbmN5IGlzIGFscmVhZHkgY29ycmVjdGx5IGhhbmRs
ZSBzaW5jZSBpdAphbHJlYWR5IGFuZCB1bmNvbmRpdGlvbmFsbHkgdXNlcyBQS0dfQ0hFQ0tfTU9E
VUxFUyB0byBzZXQgaXRzIExJQlMgYW5kCkNGTEFHUyB2YXJpYWJsZXMgWzFdOyBzbywgdGhlIGdl
dHRleHQvbGliaW50bCBkZXBlbmRlbmN5IGZsYWdzIGFyZQphbHJlYWR5IGFuZCBwcm9wZXJseSBz
ZXQgd2hlbiBpdCBpcyBuZWVkZWQuCgpbMV0gaHR0cDovL2dpdC5lZmZpY2lvcy5jb20vP3A9YmFi
ZWx0cmFjZS5naXQ7YT1ibG9iO2Y9Y29uZmlndXJlLmFjO2g9ODRmOTAwMGQ4MzMyNGVkMDk4OTgw
ZjI1MDYzMmQ1NjZmNDJiMTcwMTtoYj1IRUFEI2wzMDMKCkJSLAoKLS0gClNhbXVlbApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
