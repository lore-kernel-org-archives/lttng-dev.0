From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: CMake examples integration
Date: Mon, 20 Feb 2017 16:52:18 -0500
Message-ID: <80d862ed-7d47-5934-aace-61ddb18e31ac__3580.09776468879$1487627562$gmane$org@efficios.com>
References: <1487627336-15045-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vRy6W6gcBzkh2
 for <lttng-dev@lists.lttng.org>; Mon, 20 Feb 2017 21:52:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BDCCD340195
 for <lttng-dev@lists.lttng.org>; Mon, 20 Feb 2017 21:55:54 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id p1eh95AyQT3b for <lttng-dev@lists.lttng.org>;
 Mon, 20 Feb 2017 21:55:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 012B134025C
 for <lttng-dev@lists.lttng.org>; Mon, 20 Feb 2017 21:55:52 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 62zka9Em92Ph for <lttng-dev@lists.lttng.org>;
 Mon, 20 Feb 2017 21:55:51 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id DA5F2340195
 for <lttng-dev@lists.lttng.org>; Mon, 20 Feb 2017 21:55:51 +0000 (UTC)
In-Reply-To: <1487627336-15045-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpPbiAyMDE3LTAyLTIwIDA0OjQ4IFBNLCBNaWNoYWVsIEplYW5zb24gd3JvdGU6Cj4gRml4
IG11bHRpcGxlIGlzc3VlcyB3aXRoIHRoZSBDTWFrZSBleGFtcGxlcyBpbnRlZ3JhdGlvbiB3aXRo
IG91ciBidWlsZAo+IHN5c3RlbS4KCkNvdWxkIHlvdSBwcm92aWRlIG1vcmUgY29udGV4dD8KCkNo
ZWVycwoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmlj
aW9zLmNvbT4KPiAtLS0KPiAgLmdpdGlnbm9yZSAgICAgICAgICAgICAgIHwgIDEgKwo+ICBkb2Mv
ZXhhbXBsZXMvTWFrZWZpbGUuYW0gfCAxMiArKysrKystLS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhLy5naXRp
Z25vcmUgYi8uZ2l0aWdub3JlCj4gaW5kZXggMGQzMjJiMS4uZTM1ZTVkNSAxMDA2NDQKPiAtLS0g
YS8uZ2l0aWdub3JlCj4gKysrIGIvLmdpdGlnbm9yZQo+IEBAIC00MSw2ICs0MSw3IEBAIGRvYy9l
eGFtcGxlcy9nZW4tdHAvc2FtcGxlCj4gIGRvYy9leGFtcGxlcy9nZW4tdHAvc2FtcGxlX3RyYWNl
cG9pbnQuaAo+ICBkb2MvZXhhbXBsZXMvZGVtby10cmFjZWYvZGVtby10cmFjZWYKPiAgZG9jL2V4
YW1wbGVzL2RlbW8tdHJhY2Vsb2cvZGVtby10cmFjZWxvZwo+ICtkb2MvZXhhbXBsZXMvY21ha2Ut
bXVsdGlwbGUtc2hhcmVkLWxpYnJhcmllcy9idWlsZC8KPiAgCj4gIGRvYy9tYW4vKi54bWwKPiAg
ZG9jL21hbi9sdHRuZy1nZW4tdHAuMQo+IGRpZmYgLS1naXQgYS9kb2MvZXhhbXBsZXMvTWFrZWZp
bGUuYW0gYi9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KPiBpbmRleCA1YmMxZjRjLi4yMzkwNDZm
IDEwMDY0NAo+IC0tLSBhL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQo+ICsrKyBiL2RvYy9leGFt
cGxlcy9NYWtlZmlsZS5hbQo+IEBAIC0xMzUsMjYgKzEzNSwyNiBAQCBhbGwtbG9jYWw6Cj4gIAlk
b25lOyBcCj4gIAlpZiBbIHgiJChTVUJESVJTX0pVTCkiICE9IHgiIiBdOyB0aGVuIFwKPiAgCQlm
b3Igc3ViZGlyIGluICQoU1VCRElSU19KVUwpOyBkbyBcCj4gLQkJCShjZCAkKFNVQkRJUlNfSlVM
KSAmJiAkKE1BS0UpIEpBVkFfQ0xBU1NQQVRIX09WRVJSSURFX0pVTD0iLi4vLi4vLi4vbGlibHR0
bmctdXN0LWphdmEtYWdlbnQvamF2YS9sdHRuZy11c3QtYWdlbnQtanVsIiBKQVZBX0NMQVNTUEFU
SF9PVkVSUklERV9DT01NT049Ii4uLy4uLy4uL2xpYmx0dG5nLXVzdC1qYXZhLWFnZW50L2phdmEv
bHR0bmctdXN0LWFnZW50LWNvbW1vbiIgJChBTV9NQUtFRkxBR1MpIGFsbCAmJiBjZCAuLikgfHwg
ZXhpdCAxOyBcCj4gKwkJCShjZCAkJHN1YmRpciAmJiAkKE1BS0UpIEpBVkFfQ0xBU1NQQVRIX09W
RVJSSURFX0pVTD0iLi4vLi4vLi4vbGlibHR0bmctdXN0LWphdmEtYWdlbnQvamF2YS9sdHRuZy11
c3QtYWdlbnQtanVsIiBKQVZBX0NMQVNTUEFUSF9PVkVSUklERV9DT01NT049Ii4uLy4uLy4uL2xp
Ymx0dG5nLXVzdC1qYXZhLWFnZW50L2phdmEvbHR0bmctdXN0LWFnZW50LWNvbW1vbiIgJChBTV9N
QUtFRkxBR1MpIGFsbCAmJiBjZCAuLikgfHwgZXhpdCAxOyBcCj4gIAkJZG9uZTsgXAo+ICAJZmk7
IFwKPiAgCWlmIFsgeCIkKFNVQkRJUlNfTE9HNEopIiAhPSB4IiIgXTsgdGhlbiBcCj4gIAkJZm9y
IHN1YmRpciBpbiAkKFNVQkRJUlNfTE9HNEopOyBkbyBcCj4gLQkJCShjZCAkKFNVQkRJUlNfTE9H
NEopICYmICQoTUFLRSkgSkFWQV9DTEFTU1BBVEhfT1ZFUlJJREVfTE9HNEo9Ii4uLy4uLy4uL2xp
Ymx0dG5nLXVzdC1qYXZhLWFnZW50L2phdmEvbHR0bmctdXN0LWFnZW50LWxvZzRqIiBKQVZBX0NM
QVNTUEFUSF9PVkVSUklERV9DT01NT049Ii4uLy4uLy4uL2xpYmx0dG5nLXVzdC1qYXZhLWFnZW50
L2phdmEvbHR0bmctdXN0LWFnZW50LWNvbW1vbiIgJChBTV9NQUtFRkxBR1MpIGFsbCAmJiBjZCAu
LikgfHwgZXhpdCAxOyBcCj4gKwkJCShjZCAkJHN1YmRpciAmJiAkKE1BS0UpIEpBVkFfQ0xBU1NQ
QVRIX09WRVJSSURFX0xPRzRKPSIuLi8uLi8uLi9saWJsdHRuZy11c3QtamF2YS1hZ2VudC9qYXZh
L2x0dG5nLXVzdC1hZ2VudC1sb2c0aiIgSkFWQV9DTEFTU1BBVEhfT1ZFUlJJREVfQ09NTU9OPSIu
Li8uLi8uLi9saWJsdHRuZy11c3QtamF2YS1hZ2VudC9qYXZhL2x0dG5nLXVzdC1hZ2VudC1jb21t
b24iICQoQU1fTUFLRUZMQUdTKSBhbGwgJiYgY2QgLi4pIHx8IGV4aXQgMTsgXAo+ICAJCWRvbmU7
IFwKPiAtCWZpOwo+ICsJZmk7IFwKPiAgCWlmIFsgeCIkKFNVQkRJUlNfQ01BS0UpIiAhPSB4IiIg
XTsgdGhlbiBcCj4gIAkJZm9yIHN1YmRpciBpbiAkKFNVQkRJUlNfQ01BS0UpOyBkbyBcCj4gIAkJ
CSggXAo+IC0JCQkJY2QgJChTVUJESVJTX0NNQUtFKSAmJiBcCj4gKwkJCQljZCAkJHN1YmRpciAm
JiBcCj4gIAkJCQkkKE1LRElSX1ApIGJ1aWxkICYmIFwKPiAgCQkJCWNkIGJ1aWxkICYmIFwKPiAr
CQkJCUNDPSQoQ0MpIFwKPiArCQkJCUNYWD0kKENYWCkgXAo+ICAJCQkJY21ha2UgXAo+ICAJCQkJ
LURDTUFLRV9JTkNMVURFX1BBVEg9IiQoYWJzX3RvcF9zcmNkaXIpL2luY2x1ZGU7JChhYnNfdG9w
X2J1aWxkZGlyKS9pbmNsdWRlIiBcCj4gIAkJCQktRENNQUtFX0xJQlJBUllfUEFUSD0iJChhYnNf
dG9wX2J1aWxkZGlyKS9saWJsdHRuZy11c3QvLmxpYnMiIFwKPiAtCQkJCS1EQ01BS0VfQ19DT01Q
SUxFUj0iJChDQykiIFwKPiAgCQkJCS1EQ01BS0VfQ19GTEFHUz0iJChDRkxBR1MpICQoQ1BQRkxB
R1MpIiBcCj4gLQkJCQktRENNQUtFX0NYWF9DT01QSUxFUj0iJChDWFgpIiBcCj4gIAkJCQktRENN
QUtFX0NYWF9GTEFHUz0iJChDWFhGTEFHUykgJChDUFBGTEFHUykiIFwKPiAgCQkJCS1EQ01BS0Vf
RVhFX0xJTktFUl9GTEFHUz0iJChMREZMQUdTKSIgXAo+ICAJCQkJLi4gJiYgXAo+IAoKLS0gCkpv
bmF0aGFuIFIuIEp1bGllbgpFZmZpY2lvcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
