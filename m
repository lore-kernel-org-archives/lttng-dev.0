From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: free previous instance of
 url (alloc_url) on default live url assignation
Date: Mon, 12 Dec 2016 16:36:23 -0500
Message-ID: <2d455a39-9f58-7beb-76f8-447123bbd1de__4167.14848620376$1481578593$gmane$org@efficios.com>
References: <1481577378-1776-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CAB4xu_3L7EqLUWOv-nSyvnse3SPpZsZMG6x59=ZJEnxMp8SzsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tcx6H3x4fztld
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 21:38:31 +0000 (UTC)
In-Reply-To: <CAB4xu_3L7EqLUWOv-nSyvnse3SPpZsZMG6x59=ZJEnxMp8SzsA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

CgpPbiAyMDE2LTEyLTEyIDA0OjI0IFBNLCBQaGlsaXBwZSBQcm91bHggd3JvdGU6Cj4gT24gTW9u
LCBEZWMgMTIsIDIwMTYgYXQgNDoxNiBQTSwgSm9uYXRoYW4gUmFqb3R0ZQo+IDxqb25hdGhhbi5y
YWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBKb25h
dGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4+IC0t
LQo+PiAgIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgfCA2ICsrKysrKwo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmcvY29tbWFuZHMvY3JlYXRlLmMgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5j
Cj4+IGluZGV4IDBmN2QxYTQuLmU2ZjE1YzcgMTAwNjQ0Cj4+IC0tLSBhL3NyYy9iaW4vbHR0bmcv
Y29tbWFuZHMvY3JlYXRlLmMKPj4gKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUu
Ywo+PiBAQCAtMzQyLDYgKzM0MiwxMiBAQCBzdGF0aWMgaW50IGNyZWF0ZV9zZXNzaW9uKHZvaWQp
Cj4+Cj4+ICAgICAgICAgIC8qIFVzZSBkZWZhdWx0IGxpdmUgVVJMIGlmIE5PIHVybCBpcy9hcmUg
Zm91bmQuICovCj4+ICAgICAgICAgIGlmICgob3B0X2xpdmVfdGltZXIgJiYgIW9wdF91cmwpICYm
IChvcHRfbGl2ZV90aW1lciAmJiAhb3B0X2RhdGFfdXJsKSkgewo+PiArICAgICAgICAgICAgICAg
LyogT3ZlcnJpZGUgdGhlIHVybCAqLwo+PiArICAgICAgICAgICAgICAgaWYgKHVybCkgewo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBmcmVlKHVybCk7Cj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHVybCA9IE5VTEw7Cj4+ICsgICAgICAgICAgICAgICB9Cj4gSnVzdDoKClNpcmUsIHlvdSBh
cmUgcXVpdGUgcmlnaHQuCgo+Cj4gKyAgICAgICAgICAgICAgIGZyZWUodXJsKTsKPiArICAgICAg
ICAgICAgICAgdXJsID0gTlVMTDsKPgo+IGlmIHRoZSBwcm9qZWN0J3MgY29kaW5nIHN0eWxlIGFs
bG93cy4KPgo+IFBoaWwKPgo+PiArCj4+ICAgICAgICAgICAgICAgICAgcmV0ID0gYXNwcmludGYo
JmFsbG9jX3VybCwgIm5ldDovLzEyNy4wLjAuMSIpOwo+PiAgICAgICAgICAgICAgICAgIGlmIChy
ZXQgPCAwKSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBQRVJST1IoImFzcHJpbnRmIGRl
ZmF1bHQgbGl2ZSBVUkwiKTsKPj4gLS0KPj4gMi43LjQKPj4KPj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
PiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApKb25hdGhhbiBSLiBKdWxpZW4K
RWZmaWNpb3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
