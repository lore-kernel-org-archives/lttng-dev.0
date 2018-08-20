From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP
 to override `poll'
Date: Mon, 20 Aug 2018 15:48:35 -0400 (EDT)
Message-ID: <421142351.3072.1534794515817.JavaMail.zimbra__38598.0437779382$1534794400$gmane$org@efficios.com>
References: <20180801185445.mcvkvxmhqm5hflrj@dcvr>
 <1597828270.1143.1534169594018.JavaMail.zimbra@efficios.com>
 <20180817203134.zhvzvddsdtv54wg5@dcvr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41vPW84lF1z1D0
 for <lttng-dev@lists.lttng.org>; Mon, 20 Aug 2018 15:48:36 -0400 (EDT)
In-Reply-To: <20180817203134.zhvzvddsdtv54wg5@dcvr>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXVnIDE3LCAyMDE4LCBhdCA0OjMxIFBNLCBFcmljIFdvbmcgbm9ybWFscGVyc29u
QHloYnQubmV0IHdyb3RlOgoKPiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNA
ZWZmaWNpb3MuY29tPiB3cm90ZToKPj4gLS0tLS0gT24gQXVnIDEsIDIwMTgsIGF0IDI6NTQgUE0s
IEVyaWMgV29uZyBub3JtYWxwZXJzb25AeWhidC5uZXQgd3JvdGU6Cj4+IAo+PiA+IFVzZXJzIG1h
eSB3YW50IHRvIHVzZSBhbHRlcm5hdGl2ZSBzbGVlcGluZyBiZWhhdmlvciBpbnN0ZWFkIG9mCj4+
ID4gYHBvbGwnLiAgTWFrZSBDRFNfV0ZDUV9XQUlUX1NMRUVQIGEgbWFjcm8gd2hpY2ggbWF5IGJl
IGRlZmluZWQKPj4gPiBiZWZvcmUgaW5jbHVkaW5nIHdmY3F1ZXVlLmguCj4+ID4gCj4+ID4gVGhp
cyBhbHRlcm5hdGl2ZSBiZWhhdmlvciBjb3VsZCBpbmNsdWRlIGxvZ2dpbmcsIHBlcmZvcm1pbmcK
Pj4gPiBsb3ctcHJpb3JpdHkgY2xlYW51cCB3b3JrLCBzbGVlcGluZyBhIHNob3J0ZXIvbG9uZ2Vy
IGludGVydmFsCj4+ID4gb3IgYW55IGNvbWJpbmF0aW9uIG9mIHRoYXQuCj4+ID4gCj4+ID4gVGhp
cyB3aWxsIGFsc28gbWFrZSBpbnRlZ3JhdGlvbiBpbnRvIGdsaWJjIGVhc2llciwgYXMgYHBvbGwn
Cj4+ID4gbGlua2FnZSBjYXVzZXMgY29uZm9ybWFuY2UgdGVzdCBmYWlsdXJlcyBldmVuIHdoZW4g
cmVsZWdhdGVkCj4+ID4gdG8gYW4gaW1wb3NzaWJsZSBjb2RlIHBhdGg6Cj4+ID4gaHR0cHM6Ly9w
dWJsaWMtaW5ib3gub3JnL2xpYmMtYWxwaGEvMjAxODA4MDEwOTI2MjYuanJ3eXJvamZ5ZTRhdmNp
c0B3aGlyLwo+PiAKPj4gUmF0aGVyIHRoYW4gaW50cm9kdWNpbmcgYSBtYWNybyBoZXJlLCBjYW4g
d2UgZXh0ZW5kIHRoZSBBUEkgdG8KPj4gcGFzcyBhIGNhbGxiYWNrIGFuZCBhIHByaXZhdGUgcG9p
bnRlciB0aGF0IHdvdWxkIHBlcmZvcm0gdGhlCj4+IHNsZWVwaW5nIGJlaGF2aW9yIHJlcXVlc3Rl
ZCBieSB0aGUgY2FsbGVyID8KPiAKPiBHaXZlbiB0aGlzIGlzIGRlZXAgaW4gdGhlIGNhbGwgc3Rh
Y2ssIGl0IHdvdWxkIHJlcXVpcmUgbW9kaWZ5aW5nCj4gYSBsb3Qgb2YgY2FsbGVycy4gIFNvIGl0
IHNlZW1zIGxpa2UgYSBjb21wYXRpYmlsaXR5L21pZ3JhdGlvbgo+IG5pZ2h0bWFyZS4gIEkgZmVh
ciBpdCdzIHRvbyBtdWNoIHdvcmsgZm9yIGEgc21hbGwgaW1wcm92ZW1lbnQuCj4gCj4gRm9yIGds
aWJjLCB3ZSBjYW4gc2ltcGx5IGRlZmluZSBgcG9sbCcgdG8gYF9fcG9sbCcgdG8gYXZvaWQKPiB0
aG9zZSB0ZXN0IGZhaWx1cmVzLCBhdCBsZWFzdAoKSSBtZXJnZWQgdGhlIHBhdGNoIHlvdSBwcm9w
b3NlZCwgaXQgbWFrZXMgc2Vuc2UgY29uc2lkZXJpbmcgdGhlCmNvbnRleHQuCgpUaGFua3MhCgpN
YXRoaWV1CgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
