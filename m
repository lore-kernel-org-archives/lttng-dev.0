From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Tests: Replace prove by
 autotools tap runner
Date: Thu, 12 May 2016 15:41:30 +0000 (UTC)
Message-ID: <1220338831.7725.1463067690311.JavaMail.zimbra__43428.4647148617$1463067724$gmane$org@efficios.com>
References: <1463065279-3721-1-git-send-email-mjeanson@efficios.com>
 <2037178407.7705.1463067043355.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3DD6DA3491
 for <lttng-dev@lists.lttng.org>; Thu, 12 May 2016 15:41:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 10B23340391
 for <lttng-dev@lists.lttng.org>; Thu, 12 May 2016 15:41:37 +0000 (UTC)
In-Reply-To: <2037178407.7705.1463067043355.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWF5IDEyLCAyMDE2LCBhdCAxMTozMCBBTSwgTWF0aGlldSBEZXNub3llcnMgbWF0
aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiAtLS0tLSBPbiBNYXkgMTIsIDIw
MTYsIGF0IDExOjAxIEFNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNpb3MuY29tIHdy
b3RlOgo+IAo+PiBUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIGRlcGVuZGVuY3kgb24gdGhlIHByb3Zl
IHBlcmwgc2NyaXB0Cj4+IHRvIHJ1biB0aGUgVEFQIHRlc3Qgc3VpdGUuIEl0IHJlcGxhY2VzIGl0
IHdpdGggdGhlIGF1dG90b29scwo+PiBzaGVsbCBUQVAgZHJpdmVyIHRoYXQgb25seSByZXF1aXJl
cyBhIHNoZWxsIGFuZCBhd2suCj4+IAo+PiBDdXN0b20gYXJndW1lbnRzIGNhbiBiZSBwYXNzZWQg
dG8gdGhlIHRlc3QgcnVubmVyIHdpdGgKPj4gZW52IHZhcmlhYmxlcyBhcyBmb2xsb3c6Cj4+IAo+
PiAgZW52IExPR19EUklWRVJfRkxBR1M9Jy0tY29tbWVudHMgLS1pZ25vcmUtZXhpdCcgXAo+PiAg
ICAgIFRFU1RTPSdmb28udGVzdCBiYXoudGVzdCcgbWFrZSAtZSBjaGVjawo+PiAKPj4gVGhpcyB0
YXAgZHJpdmVyIGFsc28gY3JlYXRlcyBhIGxvZyBmaWxlIGZvciBlYWNoIHRlc3QgdGhhdAo+PiBj
YW4gdGhlbiBiZSB1c2VkIGJ5IGFub3RoZXIgc3lzdGVtIHRvIGJ1aWxkIGEgdGVzdCByZXBvcnQu
Cj4+IAo+IAo+IFRoaXMgY2hhbmdlcyB0aGUgb3V0cHV0IG9mIHRlc3RzIHRvIHRoZSBmb2xsb3dp
bmc6Cj4gCj4gWy4uLl0KPiBQQVNTOiB1c3QtZWxmL3Rlc3RfdXN0X2VsZiA0NCAtIGRlYnVnIGxp
bmsgZmlsZW5hbWUgLSBleHBlY3RlZDogbWFpbi5lbGYuZGVidWcsCj4gZ290OiBtYWluLmVsZi5k
ZWJ1Zwo+IFBBU1M6IHVzdC1lbGYvdGVzdF91c3RfZWxmIDQ1IC0gZGVidWcgbGluayBjcmMgLSBl
eHBlY3RlZDogMHgyYjhjZWRjZSwgZ290Ogo+IDB4MmI4Y2VkY2UKPiBQQVNTOiB1c3QtZWxmL3Rl
c3RfdXN0X2VsZiA0NiAtIGhlbGxvLmV4ZWMgaXMgbm90IFBJQwo+IFBBU1M6IHVzdC1lbGYvdGVz
dF91c3RfZWxmIDQ3IC0gaGVsbG8ucGllIGlzIFBJQwo+IFBBU1M6IHVzdC1lbGYvdGVzdF91c3Rf
ZWxmIDQ4IC0gaGVsbG8ucGljIGlzIFBJQwo+IAo+IElzIGl0IHN0aWxsIFRBUCBjb21wbGlhbnQg
PwoKVGhlIHRlc3RzIHRoZW1zZWx2ZXMgc3RpbGwgb3V0cHV0IFRBUCwgaXQncyB0aGUgb3V0cHV0
IG9mIHRoZSBhdXRvdG9vbHMKVEFQIGRyaXZlciB0aGF0IGlzIGRpZmZlcmVudCBmcm9tICJwcm92
ZSIgdGhhdCB3YXMgcHJldmlvdXNseSB1c2VkLgoKTWljaGFlbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
