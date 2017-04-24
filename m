From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Always build vmscan probe
Date: Mon, 24 Apr 2017 16:45:51 +0000 (UTC)
Message-ID: <442556239.17504.1493052351736.JavaMail.zimbra__27672.4919364371$1493052265$gmane$org@efficios.com>
References: <1492716205-26717-1-git-send-email-mjeanson@efficios.com>
 <1601281322.15723.1492717172325.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wBXJ56QKdzDHM
 for <lttng-dev@lists.lttng.org>; Mon, 24 Apr 2017 16:44:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8057A340287
 for <lttng-dev@lists.lttng.org>; Mon, 24 Apr 2017 16:45:52 +0000 (UTC)
In-Reply-To: <1601281322.15723.1492717172325.JavaMail.zimbra@efficios.com>
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

bWVyZ2VkIGludG8gMi44IGFuZCAyLjkgdG9vLgoKVGhhbmtzLAoKTWF0aGlldQoKLS0tLS0gT24g
QXByIDIwLCAyMDE3LCBhdCAzOjM5IFBNLCBNYXRoaWV1IERlc25veWVycyBtYXRoaWV1LmRlc25v
eWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IExldCdzIG1lcmdlIGl0IGludG8gbWFzdGVyIGZv
ciBub3csIGFuZCBzZWUgaWYgdGhlIENJIGNvbXBsYWlucy4gSWYgaXQgYWxsCj4gcGFzcyBmaW5l
LCBJJ2xsIGNoZXJyeS1waWNrIHRoaXMgaW50byBzdGFibGUgdmVyc2lvbnMgYXMgd2VsbC4KPiAK
PiBUaGFua3MsCj4gCj4gTWF0aGlldQo+IAo+IC0tLS0tIE9uIEFwciAyMCwgMjAxNywgYXQgMzoy
MyBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNvbSB3cm90ZToKPiAKPj4g
VGhlIG1tL3Ztc2Nhbi5jIGNvbXBpbGUgdW5pdCBpcyBhIG9iai15LCBldmVuIG9uIGFuIG9sZCAy
LjYuMzYga2VybmVsLAo+PiBhbHdheXMgYnVpbGQgdGhlIHZtc2NhbiBwcm9iZSByZWdhcmRsZXNz
IG9mIGtlcm5lbCBjb25maWd1cmF0aW9uLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBK
ZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4+IC0tLQo+PiBwcm9iZXMvS2J1aWxkIHwg
MTAgKy0tLS0tLS0tLQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRp
b25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvcHJvYmVzL0tidWlsZCBiL3Byb2Jlcy9LYnVpbGQK
Pj4gaW5kZXggMmFmYjZkZC4uYmYxNGM3NSAxMDA2NDQKPj4gLS0tIGEvcHJvYmVzL0tidWlsZAo+
PiArKysgYi9wcm9iZXMvS2J1aWxkCj4+IEBAIC0xNDMsMTkgKzE0MywxMSBAQCBpZm5lcSAoJChD
T05GSUdfU0NTSSksKQo+PiAgICAgICBlY2hvICJsdHRuZy1wcm9iZS1zY3NpLm8iIDsgZmk7KQo+
PiBlbmRpZiAjIENPTkZJR19TQ1NJCj4+IAo+PiAtdm1zY2FuID0gJChzaGVsbCBcCj4+ICtvYmot
JChDT05GSUdfTFRUTkcpICs9ICQoc2hlbGwgXAo+PiAgIGlmIFsgJChWRVJTSU9OKSAtZ2UgMyBc
Cj4+ICAgICAtbyBcKCAkKFZFUlNJT04pIC1lcSAyIC1hICQoUEFUQ0hMRVZFTCkgLWVxIDYgLWEg
JChTVUJMRVZFTCkgLWdlIDM2IFwpIF0gOyB0aGVuCj4+ICAgICBcCj4+ICAgICBlY2hvICJsdHRu
Zy1wcm9iZS12bXNjYW4ubyIgOyBmaTspCj4+IAo+PiAtaWZuZXEgKCQoQ09ORklHX1NXQVApLCkK
Pj4gLSAgb2JqLSQoQ09ORklHX0xUVE5HKSArPSAkKHZtc2NhbikKPj4gLWVsc2UKPj4gLSAgaWZu
ZXEgKCQoQ09ORklHX0NHUk9VUF9NRU1fUkVTX0NUTFIpLCkKPj4gLSAgICBvYmotJChDT05GSUdf
TFRUTkcpICs9ICQodm1zY2FuKQo+PiAtICBlbmRpZiAjIENPTkZJR19DR1JPVVBfTUVNX1JFU19D
VExSCj4+IC1lbmRpZiAjIENPTkZJR19TV0FQCj4+IC0KPj4gIyBsb2NrIHByb2JlIGRvZXMgbm90
IHdvcmssIHNvIGRpc2FibGluZyBpdCBmb3Igbm93Cj4+ICNpZm5lcSAoJChDT05GSUdfTE9DS0RF
UCksKQo+PiAjICBvYmotJChDT05GSUdfTFRUTkcpICs9IGx0dG5nLXByb2JlLWxvY2subwo+PiAt
LQo+PiAyLjcuNAo+IAo+IC0tCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4g
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
