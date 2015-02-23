From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Mismatching code and console
 output in log4j example
Date: Mon, 23 Feb 2015 21:26:50 +0000 (UTC)
Message-ID: <1350876451.162106.1424726810651.JavaMail.zimbra__27231.5537011766$1424726865$gmane$org@efficios.com>
References: <1424726573-10819-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YQ0Wl-0000cV-45
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 16:26:56 -0500
In-Reply-To: <1424726573-10819-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyIGFuZCBzdGFibGUtMi42LCB0aGFua3MhCgpNYXRoaWV1CgotLS0t
LSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxq
ZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKPiBDYzogIm1hdGhpZXUgZGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPiwgIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lv
cy5jb20+Cj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyMywgMjAxNSA0OjIyOjUzIFBNCj4gU3Vi
amVjdDogW1BBVENIIGx0dG5nLXVzdF0gRml4OiBNaXNtYXRjaGluZyBjb2RlIGFuZCBjb25zb2xl
IG91dHB1dCBpbiBsb2c0aiBleGFtcGxlCj4gCj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdh
bGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBkb2MvZXhh
bXBsZXMvamF2YS1sb2c0ai9IZWxsby5qYXZhIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVz
L2phdmEtbG9nNGovSGVsbG8uamF2YQo+IGIvZG9jL2V4YW1wbGVzL2phdmEtbG9nNGovSGVsbG8u
amF2YQo+IGluZGV4IGEwMTA1YWQuLjA4M2VjMTIgMTAwNjQ0Cj4gLS0tIGEvZG9jL2V4YW1wbGVz
L2phdmEtbG9nNGovSGVsbG8uamF2YQo+ICsrKyBiL2RvYy9leGFtcGxlcy9qYXZhLWxvZzRqL0hl
bGxvLmphdmEKPiBAQCAtNDgsNyArNDgsNyBAQCBwdWJsaWMgY2xhc3MgSGVsbG8KPiAgCQkvKiBU
cmlnZ2VyIGEgdHJhY2luZyBldmVudCB1c2luZyB0aGUgSlVMIExvZ2dlciBjcmVhdGVkIGJlZm9y
ZS4gKi8KPiAgCQloZWxsb0xvZy5pbmZvKCJIZWxsbyBXb3JsZCwgdGhlIGFuc3dlciBpcyAiICsg
YW5zd2VyKTsKPiAgCj4gLQkJU3lzdGVtLm91dC5wcmludGxuKCJGaXJpbmcgaGVsbG8gZGVsYXkg
aW4gMTAgc2Vjb25kcy4uLiIpOwo+ICsJCVN5c3RlbS5vdXQucHJpbnRsbigiRmlyaW5nIGhlbGxv
IGRlbGF5IGluIDUgc2Vjb25kcy4uLiIpOwo+ICAJCVRocmVhZC5zbGVlcCg1MDAwKTsKPiAgCQlo
ZWxsb0xvZy5pbmZvKCJIZWxsbyBXb3JsZCBkZWxheWVkLi4uIik7Cj4gIAl9Cj4gLS0KPiAyLjMu
MAo+IAo+IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
