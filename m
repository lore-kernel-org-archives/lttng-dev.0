From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/3] Add btrfs tracepoint for
 em's EEXIST case
Date: Thu, 7 Jun 2018 16:11:04 -0400 (EDT)
Message-ID: <646333357.8559.1528402264292.JavaMail.zimbra__28677.8690097437$1528402147$gmane$org@efficios.com>
References: <20180607194832.20578-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 411xWF4RB6znS6
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jun 2018 16:11:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 03285227ED9
 for <lttng-dev@lists.lttng.org>; Thu,  7 Jun 2018 16:11:05 -0400 (EDT)
In-Reply-To: <20180607194832.20578-1-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

QWxsIDMgbWVyZ2VkIGludG8gbWFzdGVyLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBKdW4g
NywgMjAxOCwgYXQgMzo0OCBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNv
bSB3cm90ZToKCj4gU2VlIHVwc3RyZWFtIGNvbW1pdHM6Cj4gCj4gIGNvbW1pdCAzOTNkYTkxODE5
ZTM1YWY1MzhlZjk3YzdjNmEwNDg5OWUyZmJmZTBlCj4gIEF1dGhvcjogTGl1IEJvIDxiby5saS5s
aXVAb3JhY2xlLmNvbT4KPiAgRGF0ZTogICBGcmkgSmFuIDUgMTI6NTE6MTYgMjAxOCAtMDcwMAo+
IAo+ICAgIEJ0cmZzOiBhZGQgdHJhY2Vwb2ludCBmb3IgZW0ncyBFRVhJU1QgY2FzZQo+IAo+ICAg
IFRoaXMgaXMgYWRkaW5nIGEgdHJhY2Vwb2ludCAnYnRyZnNfaGFuZGxlX2VtX2V4aXN0JyB0byBo
ZWxwIGRlYnVnIHRoZQo+ICAgIHN1YnRsZSBidWdzIGFyb3VuZCBtZXJnZV9leHRlbnRfbWFwcGlu
Zy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9z
LmNvbT4KPiAtLS0KPiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9idHJmcy5o
IHwgMTggKysrKysrKysrKysrKysrKysrCj4gMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KykKPiAKPiBkaWZmIC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUv
YnRyZnMuaAo+IGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaAo+
IGluZGV4IDRlYjBkYjIuLmM0MTNlOTIgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaAo+ICsrKyBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMv
bHR0bmctbW9kdWxlL2J0cmZzLmgKPiBAQCAtMjczLDYgKzI3MywyNCBAQCBMVFROR19UUkFDRVBP
SU5UX0VWRU5UKGJ0cmZzX2dldF9leHRlbnQsCj4gCj4gI2VuZGlmIC8qICNlbHNlICNpZiAoTElO
VVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTAsMCkpICovCj4gCj4gKyNpZiAo
TElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsMTcsMCkpCj4gK0xUVE5HX1RS
QUNFUE9JTlRfRVZFTlQoYnRyZnNfaGFuZGxlX2VtX2V4aXN0LAo+ICsKPiArCVRQX1BST1RPKGNv
bnN0IHN0cnVjdCBleHRlbnRfbWFwICpleGlzdGluZywgY29uc3Qgc3RydWN0IGV4dGVudF9tYXAg
Km1hcCwgdTY0Cj4gc3RhcnQsIHU2NCBsZW4pLAo+ICsKPiArCVRQX0FSR1MoZXhpc3RpbmcsIG1h
cCwgc3RhcnQsIGxlbiksCj4gKwo+ICsJVFBfRklFTERTKAo+ICsJCWN0Zl9pbnRlZ2VyKHU2NCwg
ZV9zdGFydCwgZXhpc3RpbmctPnN0YXJ0KQo+ICsJCWN0Zl9pbnRlZ2VyKHU2NCwgZV9sZW4sIGV4
aXN0aW5nLT5sZW4pCj4gKwkJY3RmX2ludGVnZXIodTY0LCBtYXBfc3RhcnQsIG1hcC0+c3RhcnQp
Cj4gKwkJY3RmX2ludGVnZXIodTY0LCBtYXBfbGVuLCBtYXAtPmxlbikKPiArCQljdGZfaW50ZWdl
cih1NjQsIHN0YXJ0LCBzdGFydCkKPiArCQljdGZfaW50ZWdlcih1NjQsIGxlbiwgbGVuKQo+ICsJ
KQo+ICspCj4gKyNlbmRpZgo+ICsKPiAjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxf
VkVSU0lPTig0LDE0LDApKQo+IExUVE5HX1RSQUNFUE9JTlRfRVZFTlRfQ0xBU1MoYnRyZnNfX29y
ZGVyZWRfZXh0ZW50LAo+IAo+IC0tCj4gMi4xNy4xCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
