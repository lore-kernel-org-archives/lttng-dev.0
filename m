From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: ext3 was completely
 removed from the kernel in v4.3
Date: Wed, 24 May 2017 16:09:11 +0000 (UTC)
Message-ID: <1242437908.24005.1495642151799.JavaMail.zimbra__30998.8992558376$1495642117$gmane$org@efficios.com>
References: <1495568605-28541-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXy594D3Lz112L
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:09:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8DC96340378
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 16:09:16 +0000 (UTC)
In-Reply-To: <1495568605-28541-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0t
LS0gT24gTWF5IDIzLCAyMDE3LCBhdCA5OjQzIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25A
ZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBEb24ndCBkaXNwbGF5IHRoZSB3YXJuaW5nIGFib3V0IG1p
c3NpbmcgZXh0MyBoZWFkZXJzIG9uIGtlcm5lbHMgPj0gNC4zCj4gCj4gU2VlIHVwc3RyZWFtIGNv
bW1pdCBlMzFmYjllMDA1NDNlNWQzYzViNjg2NzQ3ZDNjODYyYmMwOWI1OWYzCj4gCj4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4g
cHJvYmVzL0tidWlsZCB8IDE0ICsrKysrKysrLS0tLS0tCj4gMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvcHJvYmVzL0tidWls
ZCBiL3Byb2Jlcy9LYnVpbGQKPiBpbmRleCA2NjQ1OTVkLi5mZTg2OWQwIDEwMDY0NAo+IC0tLSBh
L3Byb2Jlcy9LYnVpbGQKPiArKysgYi9wcm9iZXMvS2J1aWxkCj4gQEAgLTk3LDEzICs5NywxNSBA
QCBpZm5lcSAoJChDT05GSUdfRVhUM19GUyksKQo+ICAgZXh0M19kZXAgPSAkKHNyY3RyZWUpL2Zz
L2V4dDMvKi5oCj4gICBleHQzX2RlcF9jaGVjayA9ICQod2lsZGNhcmQgJChleHQzX2RlcCkpCj4g
ICBleHQzID0gJChzaGVsbCBcCj4gLSAgICBpZiBbICQoVkVSU0lPTikgLWdlIDQgLW8gXCggJChW
RVJTSU9OKSAtZXEgMyAtYSAkKFBBVENITEVWRUwpIC1nZSAxIFwpIF0gOwo+IHRoZW4gXAo+IC0g
ICAgICBpZiBbIFwoICQoVkVSU0lPTikgLWdlIDQgLW8gXCggJChWRVJTSU9OKSAtZXEgMyAtYSAk
KFBBVENITEVWRUwpIC1nZSA0IFwpCj4gXCkgLWEgXAo+IC0gICAgICAgIC16ICIkKGV4dDNfZGVw
X2NoZWNrKSIgXSA7IHRoZW4gXAo+IC0gICAgICAgIGVjaG8gIndhcm4iIDsgXAo+IC0gICAgICAg
IGV4aXQgOyBcCj4gKyAgICBpZiBbICQoVkVSU0lPTikgLWx0IDQgLW8gXCggJChWRVJTSU9OKSAt
ZXEgNCAtYSAkKFBBVENITEVWRUwpIC1sdCAzIFwpIF0gOwo+IHRoZW4gXAo+ICsgICAgICBpZiBb
ICQoVkVSU0lPTikgLWdlIDQgLW8gXCggJChWRVJTSU9OKSAtZXEgMyAtYSAkKFBBVENITEVWRUwp
IC1nZSAxIFwpIF0KPiA7IHRoZW4gXAo+ICsgICAgICAgIGlmIFsgXCggJChWRVJTSU9OKSAtZ2Ug
NCAtbyBcKCAkKFZFUlNJT04pIC1lcSAzIC1hICQoUEFUQ0hMRVZFTCkgLWdlIDQKPiBcKSBcKSAt
YSBcCj4gKyAgICAgICAgICAteiAiJChleHQzX2RlcF9jaGVjaykiIF0gOyB0aGVuIFwKPiArICAg
ICAgICAgIGVjaG8gIndhcm4iIDsgXAo+ICsgICAgICAgICAgZXhpdCA7IFwKPiArICAgICAgICBm
aTsgXAo+ICsgICAgICAgIGVjaG8gImx0dG5nLXByb2JlLWV4dDMubyIgOyBcCj4gICAgICAgZmk7
IFwKPiAtICAgICAgZWNobyAibHR0bmctcHJvYmUtZXh0My5vIiA7IFwKPiAgICAgZmk7KQo+ICAg
aWZlcSAoJChleHQzKSx3YXJuKQo+ICAgICAkKHdhcm5pbmcgRmlsZXMgJChleHQzX2RlcCkgbm90
IGZvdW5kLiBQcm9iZSAiZXh0MyIgaXMgZGlzYWJsZWQuIFVzZSBmdWxsIGtlcm5lbAo+ICAgICBz
b3VyY2UgdHJlZSB0byBlbmFibGUgaXQuKQo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25v
eWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
