From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] build: check for CXX_WORKS for
	cmake example
Date: Mon, 3 Oct 2016 16:14:00 +0000 (UTC)
Message-ID: <2098459617.43790.1475511240110.JavaMail.zimbra__47549.1525292911$1475511209$gmane$org@efficios.com>
References: <1475507721-6550-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 475C1A1DC1
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:14:29 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C3937340240
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 16:14:00 +0000 (UTC)
In-Reply-To: <1475507721-6550-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBPY3QgMywgMjAx
NiwgYXQgMTE6MTUgQU0sIEpvbmF0aGFuIFJham90dGUgam9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUcmFjZXBvaW50cyBhbmQgdHJhY2Vwb2ludCBwcm92aWRl
ciBjb21waWxhdGlvbiBuZWVkIGEgZnVuY3Rpb25hbAo+IGMrKyBjb21waWxlciAoZysrID4gNC43
KS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRl
LWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gY29uZmlndXJlLmFjICAgICAgICAgICAgIHwg
MSAtCj4gZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtIHwgMiArLQo+IDIgZmlsZXMgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3Vy
ZS5hYyBiL2NvbmZpZ3VyZS5hYwo+IGluZGV4IDQyNTZmNjYuLjQxNTM4OGYgMTAwNjQ0Cj4gLS0t
IGEvY29uZmlndXJlLmFjCj4gKysrIGIvY29uZmlndXJlLmFjCj4gQEAgLTgwLDcgKzgwLDYgQEAg
QU1fQ09ORElUSU9OQUwoW05PX1NIQVJFRF0sIFt0ZXN0ICJ4JGVuYWJsZV9zaGFyZWQiID0gInhu
byJdKQo+ICMgQ2hlY2tzIGZvciBwcm9ncmFtcy4KPiBBQ19QUk9HX0NDCj4gQUNfUFJPR19DWFgK
PiAtQU1fQ09ORElUSU9OQUwoW0hBVkVfQ1hYXSwgW3Rlc3QgIngkQ1hYIiAhPSAieCJdKQo+IEFD
X0NIRUNLX1BST0coW0hBVkVfQ01BS0VdLCBbY21ha2VdLCBbInllcyJdKQo+IEFNX0NPTkRJVElP
TkFMKFtIQVZFX0NNQUtFXSwgW3Rlc3QgIngkSEFWRV9DTUFLRSIgPSAieHllcyJdKQo+IEFDX1BS
T0dfTUFLRV9TRVQKPiBkaWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtIGIvZG9j
L2V4YW1wbGVzL01ha2VmaWxlLmFtCj4gaW5kZXggYzdlNWI2OC4uMDg5MGM1MiAxMDA2NDQKPiAt
LS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KPiArKysgYi9kb2MvZXhhbXBsZXMvTWFrZWZp
bGUuYW0KPiBAQCAtMzQsNyArMzQsNyBAQCBkaXN0X2RvY19leGFtcGxlc19weXRob25fREFUQSA9
IHB5dGhvbi9oZWxsby5weQo+IGVuZGlmCj4gCj4gaWYgSEFWRV9DTUFLRQo+IC1pZiBIQVZFX0NY
WAo+ICtpZiBDWFhfV09SS1MKPiBTVUJESVJTX0NNQUtFID0gY21ha2UtbXVsdGlwbGUtc2hhcmVk
LWxpYnJhcmllcwo+IGVuZGlmCj4gZW5kaWYKPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNu
b3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
