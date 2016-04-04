From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2 1/5] Fix: do not return error
	on LTTNG_ERR_SNAPSHOT_NODATA
Date: Mon, 4 Apr 2016 12:49:26 -0400
Message-ID: <CA+jJMxtcisuqceq3A+sBbynEcEQaybX5+nj+6xDM2GjtxghkSA__12806.325700558$1459788581$gmane$org@mail.gmail.com>
References: <367304197.32343.1458596988829.JavaMail.zimbra@efficios.com>
 <1458670328-17521-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1458670328-17521-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
 [209.85.213.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 91747A2FAF
 for <lttng-dev@lists.lttng.org>; Mon,  4 Apr 2016 16:49:27 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id nt3so17171800igb.0
 for <lttng-dev@lists.lttng.org>; Mon, 04 Apr 2016 09:49:27 -0700 (PDT)
In-Reply-To: <1458670328-17521-2-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWFyIDIyLCAyMDE2IGF0IDI6MTIg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gQSB3YXJuaW5nIGlzIGZpbmUgc2luY2UgdGhlIHVzZXIgaGFzIG5vIGNvbnRy
b2wgb24KPiB3aGV0aGVyIG9yIG5vdCBhcHBsaWNhdGlvbnMgKG9yIHRoZSBrZXJuZWwpIGhhdmUK
PiBwcm9kdWNlZCBhbnkgZXZlbnQgYmV0d2VlbiB0aGUgc3RhcnQgb2YgdGhlIHRyYWNpbmcKPiBz
ZXNzaW9uIGFuZCB0aGUgcmVjb3JkaW5nIG9mIHRoZSBzbmFwc2hvdC4KPgo+IE1JIHdpc2UgdGhl
IGNvbW1hbmQgaXMgbm90IGEgc3VjY2VzcyBzaW5jZSBub3RoaW5nIHdhcwo+IHJlY29yZGVkLiBU
aGUgY29tbWFuZCBsaW5lIHJldHVybiBjb2RlIGlzIENNRF9TVUNDRVNTLgo+Cj4gcmVmcyAjMTAw
Mgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1q
dWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL3NuYXBz
aG90LmMgfCA5ICsrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9zbmFwc2hvdC5jIGIvc3JjL2Jp
bi9sdHRuZy9jb21tYW5kcy9zbmFwc2hvdC5jCj4gaW5kZXggYWJkZjE4OS4uMjk4YmM2ZSAxMDA2
NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL3NuYXBzaG90LmMKPiArKysgYi9zcmMv
YmluL2x0dG5nL2NvbW1hbmRzL3NuYXBzaG90LmMKPiBAQCAtNzI1LDYgKzcyNSwxNSBAQCBpbnQg
Y21kX3NuYXBzaG90KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAgY2FzZSBMVFROR19FUlJfU05BUFNI
T1RfTk9EQVRBOgo+ICAgICAgICAgICAgICAgICAgICAgICAgIFdBUk4oIiVzIiwgbHR0bmdfc3Ry
ZXJyb3IoY29tbWFuZF9yZXQpKTsKPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogIEEg
d2FybmluZyBpcyBmaW5lIHNpbmNlIHRoZSB1c2VyIGhhcyBubyBjb250cm9sIG9uCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICogIHdoZXRoZXIgb3Igbm90IGFwcGxpY2F0aW9ucyAob3IgdGhl
IGtlcm5lbCkgaGF2ZQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqICBwcm9kdWNlZCBhbnkg
ZXZlbnQgYmV0d2VlbiB0aGUgc3RhcnQgb2YgdGhlIHRyYWNpbmcKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgKiAgc2Vzc2lvbiBhbmQgdGhlIHJlY29yZGluZyBvZiB0aGUgc25hcHNob3QuIE1J
IHdpc2UKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiAgdGhlIGNvbW1hbmQgaXMgbm90IGEg
c3VjY2VzcyBzaW5jZSBub3RoaW5nIHdhcwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqICBy
ZWNvcmRlZC4KPiArICAgICAgICAgICAgICAgICAgICAgICAgKi8KPiArICAgICAgICAgICAgICAg
ICAgICAgICBjb21tYW5kX3JldCA9IDA7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
Cj4gICAgICAgICAgICAgICAgIGRlZmF1bHQ6Cj4gICAgICAgICAgICAgICAgICAgICAgICAgRVJS
KCIlcyIsIGx0dG5nX3N0cmVycm9yKGNvbW1hbmRfcmV0KSk7Cj4gLS0KPiAyLjcuMAo+CgoKCi0t
IApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
