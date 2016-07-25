From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] configure: fix uuid support
 detection on static build
Date: Mon, 25 Jul 2016 15:22:08 -0400
Message-ID: <CA+jJMxtV9e6MdXSB3X4+qBQj_kuU=Bv6Vp1ifB_E_SXX3mM3=Q__48036.3891496838$1469474551$gmane$org@mail.gmail.com>
References: <20160601195632.23585-1-s.martin49@gmail.com>
 <CA+jJMxuRg7U-TuA5sWgW+e8mRf3ebO1BjcQ+1caqHT6ecUOTNw@mail.gmail.com>
 <CAHXCMMLfmjew0zJPzvdfW5nT2GWrJ=WpZkbo8oAB4660EqPgAQ@mail.gmail.com>
 <CAHXCMMLp5tBMbo3oEzbY1yqnpGphKYMid+UTfwtr8zdYQvbfKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
 [209.85.161.195])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DA92AA023E
 for <lttng-dev@lists.lttng.org>; Mon, 25 Jul 2016 19:22:09 +0000 (UTC)
Received: by mail-yw0-f195.google.com with SMTP id r9so5439764ywg.2
 for <lttng-dev@lists.lttng.org>; Mon, 25 Jul 2016 12:22:10 -0700 (PDT)
In-Reply-To: <CAHXCMMLp5tBMbo3oEzbY1yqnpGphKYMid+UTfwtr8zdYQvbfKQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Samuel Martin <s.martin49@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTEuNCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBT
dW4sIEp1biAyNiwgMjAxNiBhdCAxMjoyNiBQTSwgU2FtdWVsIE1hcnRpbiA8cy5tYXJ0aW40OUBn
bWFpbC5jb20+IHdyb3RlOgo+IEhpIErDqXLDqW1pZSwKPgo+IE9uIFR1ZSwgSnVuIDE0LCAyMDE2
IGF0IDg6MjEgQU0sIFNhbXVlbCBNYXJ0aW4gPHMubWFydGluNDlAZ21haWwuY29tPiB3cm90ZToK
Pj4gSGkgSsOpcsOpbWllLAo+Pgo+PiBPbiBUdWUsIEp1biAxNCwgMjAxNiBhdCAxOjIxIEFNLCBK
w6lyw6ltaWUgR2FsYXJuZWF1Cj4+IDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+IHdy
b3RlOgo+Pj4gT24gV2VkLCBKdW4gMSwgMjAxNiBhdCAzOjU2IFBNLCBTYW11ZWwgTWFydGluIDxz
Lm1hcnRpbjQ5QGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4gVGhpcyBjaGFuZ2UgYWRkcyB1dWlkIGRl
dGVjdGlvbiB1c2luZyBwa2ctY29uZmlnIGhlbHBlciBiZWZvcmUgZmFsbGluZwo+Pj4+IGJhY2sg
b24gdGhlIHN0YW5kYXJkIEFDX0NIRUNLX0xJQiBkZXRlY3Rpb24gZm9yIHBsYXRmb3JtcyBtaXNz
aW5nCj4+Pj4gcGtnLWNvbmZpZy4KPj4+Pgo+Pj4+IEFDX0NIRUNLX0xJQiBmdW5jdGlvbiBhY2hp
ZXZlcyBpdHMgdGVzdCBieSB0cnlpbmcgdG8gbGluayBhZ2FpbnN0IHRoZQo+Pj4+IHJlcXVlc3Rl
ZCBsaWJyYXJ5LCB3aXRob3V0IHRha2luZyBjYXJlIG9mIGl0cyBkZXBlbmRlbmN5Cj4+Pj4gcmVx
dWlyZW1lbnRzL2ZsYWdzIHRoYXQgbWF5IGRpZmZlciBiZXR3ZWVuIGRpZmZlcmVudCB0YXJnZXRz
Lgo+Pj4+IFRoZXJlZm9yZSwgaW4gY2FzZSBvZiBzdGF0aWMgYnVpbGQsIGl0IGNhbiBmYWlsIG9u
IHRoZSB1dWlkIGRldGVjdGlvbgo+Pj4+IGxpa2UgWzFdLCBiZWNhdXNlIHRoZSB1dWlkJ3MgZGVw
ZW5kZW5jeSBmbGFncyAocmVnYXJkaW5nIGdldHRleHQpIGFyZQo+Pj4+IG1pc3NpbmcuCj4+Pgo+
Pj4gSGkgU2FtdWVsLAo+Pj4KPj4+IFRoZSBzYW1lIHJlcXVpcmVtZW50cyBzZWVtIHRvIGV4aXN0
IGZvciBnbGliIChnZXR0ZXh0KSwgZG9lcyB0aGUKPj4+IGNoYW5nZSBuZWVkIHRvIGJlIG1hZGUg
Zm9yIGl0IGFsc28/Cj4+IE1heWJlLCBJIGRpZCBub3QgdHJpZ2dlciB0aGlzIGluIG15IHRlc3Qg
KGNlcnRhaW5seSBiZWNhdXNlIGZpeCB0aGUKPj4gZmlyc3QgZXJyb3Igd2FzIGVub3VnaCB0byBw
cm92aWRlIGFsbCBkZXBzIHRoZSBvdGhlcnMgbmVlZC4uLikKPj4gSSdsbCBjaGVjayBpdCBhbmQg
cmVwb3J0IGJhY2sgaGVyZS4KPgo+IFNvcnJ5IGZvciBiZWluZyBzbyBsb25nIDotLwo+Cj4gQUZB
SUNTLCB0aGUgZ2xpYiBkZXBlbmRlbmN5IGlzIGFscmVhZHkgY29ycmVjdGx5IGhhbmRsZSBzaW5j
ZSBpdAo+IGFscmVhZHkgYW5kIHVuY29uZGl0aW9uYWxseSB1c2VzIFBLR19DSEVDS19NT0RVTEVT
IHRvIHNldCBpdHMgTElCUyBhbmQKPiBDRkxBR1MgdmFyaWFibGVzIFsxXTsgc28sIHRoZSBnZXR0
ZXh0L2xpYmludGwgZGVwZW5kZW5jeSBmbGFncyBhcmUKPiBhbHJlYWR5IGFuZCBwcm9wZXJseSBz
ZXQgd2hlbiBpdCBpcyBuZWVkZWQuCj4KPiBbMV0gaHR0cDovL2dpdC5lZmZpY2lvcy5jb20vP3A9
YmFiZWx0cmFjZS5naXQ7YT1ibG9iO2Y9Y29uZmlndXJlLmFjO2g9ODRmOTAwMGQ4MzMyNGVkMDk4
OTgwZjI1MDYzMmQ1NjZmNDJiMTcwMTtoYj1IRUFEI2wzMDMKPgo+IEJSLAo+Cj4gLS0KPiBTYW11
ZWwKCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
