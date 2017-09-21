From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC v2] Add kmalloc failover to vmalloc
Date: Thu, 21 Sep 2017 20:43:08 +0000 (UTC)
Message-ID: <373614089.16058.1506026588612.JavaMail.zimbra__28627.4328282618$1506026539$gmane$org@efficios.com>
References: <1506018582-22403-1-git-send-email-mjeanson@efficios.com>
 <1705207820.15923.1506019177110.JavaMail.zimbra@efficios.com>
 <73494ae7-dd98-4069-6b2c-49fad21698ca@efficios.com>
 <779758199.15975.1506019933645.JavaMail.zimbra@efficios.com>
 <72c66999-9d90-7101-199a-b0fc787d6f8e@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xypSk4PvDzCbN
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 20:42:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 50667340239
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 20:43:09 +0000 (UTC)
In-Reply-To: <72c66999-9d90-7101-199a-b0fc787d6f8e@efficios.com>
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

LS0tLS0gT24gU2VwIDIxLCAyMDE3LCBhdCA0OjMwIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5z
b25AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBPbiAyMDE3LTA5LTIxIDE0OjUyLCBNYXRoaWV1IERl
c25veWVycyB3cm90ZToKPj4gLS0tLS0gT24gU2VwIDIxLCAyMDE3LCBhdCAyOjQzIFBNLCBNaWNo
YWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNpb3MuY29tIHdyb3RlOgo+PiAKPj4+IE9uIDIwMTct
MDktMjEgMTQ6MzksIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOgo+Pj4+IC0tLS0tIE9uIFNlcCAy
MSwgMjAxNywgYXQgMjoyOSBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNv
bSB3cm90ZToKPj4+Pgo+Pj4+PiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBrdm1hbGxvYyBo
ZWxwZXJzIGludHJvZHVjZWQgaW4ga2VybmVsIDQuMTIuCj4+Pj4+Cj4+Pj4+IEl0IHdpbGwgZ3Jh
Y2VmdWxseSBmYWlsb3ZlciBtZW1vcnkgYWxsb2NhdGlvbnMgb2YgbW9yZSB0aGFuIG9uZSBwYWdl
IHRvCj4+Pj4+IHZtYWxsb2MgZm9yIHN5c3RlbXMgdW5kZXIgaGlnaCBtZW1vcnkgcHJlc3N1cmUg
b3IgZnJhZ21lbnRhdGlvbi4KPj4+Pj4KPj4+Pj4gSSBvbmx5IHVzZWQgaXQgaW4gbHR0bmctZXZl
bnRzLmMgYXMgYSBQT0MsIG1vc3QgYWxsb2NhdGlvbnMgZml0IGludG8gYQo+Pj4+PiBzaW5nbGUg
cGFnZSBzbyBJJ20gbm90IHN1cmUgaG93IHVzZWZ1bCB0aGlzIGFjdHVhbGx5IGlzLgo+Pj4+Pgo+
Pj4+PiBUaG91Z2h0cz8KPj4+Pgo+Pj4+IEp1c3QgdXBkYXRlIHRoZSBjaGFuZ2Vsb2cgdG8gc3Bl
Y2lmeSB3aHkgd2UgbmVlZCB0aGlzIGZvciBzdHJ1Y3QgbHR0bmdfc2Vzc2lvbgo+Pj4+ICh+MzJr
QiksIGFuZCB5b3UgY2FuIHN1Ym1pdCBpdCBmb3IgZ29vZCB3aXRoIGEgIkZpeDogIiB0YWcuCj4+
Pgo+Pj4gSSdtIG5vdCBzdXJlIGl0IHNob3VsZCBiZSBhIGZpeCwgZm9yIHRoaXMgdG8gYmUgb2Yg
YW55IHVzZSBhbGwgdGhlIG90aGVyCj4+PiBhbGxvY2F0aW9ucyBiaWdnZXIgdGhhbiBQQUdFX1NJ
WkUgc2hvdWxkIGFsc28gdXNlIGl0LiBPdGhlcndpc2UsIHRoZQo+Pj4gc2Vzc2lvbiBhbGxvY2F0
aW9uIHdpbGwgc3VjY2VlZCBidXQgdGhlIG5leHQgc2l6ZWFibGUgYWxsb2NhdGlvbiB3aWxsCj4+
PiBzdGlsbCBmYWlsLgo+PiAKPj4gV2hhdCBvdGhlciBhbGxvY2F0aW9ucyBsYXJnZXIgdGhhbiBQ
QUdFX1NJWkUgdXNpbmcga21hbGxvYyBkaWQgeW91IHNwb3QgPwo+IAo+IFRoaXMgaXMgbm90IGFu
IGV4aGF1c3RpdmUgbGlzdCA6Cj4gCj4gbHR0bmctY29udGV4dC5jOgo+IC0gbmV3X2ZpZWxkczog
MTM2ICogbgo+IAo+IGx0dG5nLWNvbnRleHQtcGVyZi1jb3VudGVycy5jOgo+IC0gZXZlbnRzOiBp
ZiB5b3UgaGF2ZSBtb3JlIHRoYW4gNTEyIENQVXMKPiAKPiBsaWIvcHJpb19oZWFwL2x0dG5nX3By
aW9faGVhcC5jOgo+IC0gbmV3X3B0cnMKPiAKPiAKPiBCdXQgbW9zdGx5IGluIHRoZSByaW5nYnVm
ZmVyLCB0aG91Z2h0IEkgaGF2ZSBubyBpZGVhIGlmIGEgZmFpbG92ZXIgdG8KPiB2bWFsbG9jIGlz
IGFjY2VwdGFibGUgaW4gdGhpcyBjYXNlLgoKQXMgbG9uZyBhcyB3ZSBpc3N1ZSB2bWFsbG9jX3N5
bmNfYWxsIGFmdGVyIHZtYWxsb2MsIHllcywgaXQncyBhY2NlcHRhYmxlLgoKUGxlYXNlIHByb3Zp
ZGUgYSBwYXRjaCB0aGF0IGNoYW5nZXMgYWxsIGFsbG9jYXRpb25zIHRoYXQgY2FuIGJlIGxhcmdl
ciB0aGFuClBBR0VfU0laRSB0byB0aGUgbmV3IHNjaGVtZS4KClRoYW5rcywKCk1hdGhpZXUKCj4g
Cj4+IAo+PiBUaGFua3MsCj4+IAo+PiBNYXRoaWV1Cj4+IAo+PiAKPj4+Cj4+Pj4KPj4+PiBUaGFu
a3MsCj4+Pj4KPj4+PiBNYXRoaWV1CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
