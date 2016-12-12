From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: [PATCH lttng-tools] Fix: free previous instance of
 url (alloc_url) on default live url assignation
Date: Mon, 12 Dec 2016 16:24:07 -0500
Message-ID: <CAB4xu_3L7EqLUWOv-nSyvnse3SPpZsZMG6x59=ZJEnxMp8SzsA__16273.3224490241$1481577888$gmane$org@mail.gmail.com>
References: <1481577378-1776-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3tcwrh46H7ztl0
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 21:26:44 +0000 (UTC)
Received: by mail-qt0-x242.google.com with SMTP id n6so11519971qtd.0
 for <lttng-dev@lists.lttng.org>; Mon, 12 Dec 2016 13:24:38 -0800 (PST)
In-Reply-To: <1481577378-1776-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBEZWMgMTIsIDIwMTYgYXQgNDoxNiBQTSwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRo
YW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IFNpZ25lZC1vZmYtYnk6
IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4K
PiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYyB8IDYgKysrKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0
dG5nL2NvbW1hbmRzL2NyZWF0ZS5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9jcmVhdGUuYwo+
IGluZGV4IDBmN2QxYTQuLmU2ZjE1YzcgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy9jb21t
YW5kcy9jcmVhdGUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3JlYXRlLmMKPiBA
QCAtMzQyLDYgKzM0MiwxMiBAQCBzdGF0aWMgaW50IGNyZWF0ZV9zZXNzaW9uKHZvaWQpCj4KPiAg
ICAgICAgIC8qIFVzZSBkZWZhdWx0IGxpdmUgVVJMIGlmIE5PIHVybCBpcy9hcmUgZm91bmQuICov
Cj4gICAgICAgICBpZiAoKG9wdF9saXZlX3RpbWVyICYmICFvcHRfdXJsKSAmJiAob3B0X2xpdmVf
dGltZXIgJiYgIW9wdF9kYXRhX3VybCkpIHsKPiArICAgICAgICAgICAgICAgLyogT3ZlcnJpZGUg
dGhlIHVybCAqLwo+ICsgICAgICAgICAgICAgICBpZiAodXJsKSB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZnJlZSh1cmwpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHVybCA9IE5VTEw7
Cj4gKyAgICAgICAgICAgICAgIH0KCkp1c3Q6CgorICAgICAgICAgICAgICAgZnJlZSh1cmwpOwor
ICAgICAgICAgICAgICAgdXJsID0gTlVMTDsKCmlmIHRoZSBwcm9qZWN0J3MgY29kaW5nIHN0eWxl
IGFsbG93cy4KClBoaWwKCj4gKwo+ICAgICAgICAgICAgICAgICByZXQgPSBhc3ByaW50ZigmYWxs
b2NfdXJsLCAibmV0Oi8vMTI3LjAuMC4xIik7Cj4gICAgICAgICAgICAgICAgIGlmIChyZXQgPCAw
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgUEVSUk9SKCJhc3ByaW50ZiBkZWZhdWx0IGxp
dmUgVVJMIik7Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
