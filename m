From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Double free in
 utils_partial_realpath error path
Date: Wed, 18 May 2016 16:08:03 -0400
Message-ID: <CA+jJMxvxMHNNjVG9-CA5REjDU6-rfEALySSzX_qkTB1u=YRykg__32881.3723790974$1463602099$gmane$org@mail.gmail.com>
References: <1463588247-28885-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 79518A35D5
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 20:08:04 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id i7so5370246qkd.1
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 13:08:04 -0700 (PDT)
In-Reply-To: <1463588247-28885-1-git-send-email-mjeanson@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgTWF5IDE4LCAyMDE2IGF0IDEyOjE3
IFBNLCBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gRml4
ZXMgY292ZXJpdHkgIzEzNTU1MjEKPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8
bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvY29tbW9uL3V0aWxzLmMgfCA0ICsr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vdXRpbHMuYyBiL3NyYy9jb21tb24vdXRpbHMuYwo+IGlu
ZGV4IDMwYTVmMTAuLjkwMWRkYjAgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi91dGlscy5jCj4g
KysrIGIvc3JjL2NvbW1vbi91dGlscy5jCj4gQEAgLTE5MCw3ICsxOTAsOSBAQCBlcnJvcjoKPiAg
ICAgICAgIGZyZWUocmVzb2x2ZWRfcGF0aCk7Cj4gICAgICAgICBmcmVlKGN1dF9wYXRoKTsKPiAg
ICAgICAgIGZyZWUodHJ5X3BhdGgpOwo+IC0gICAgICAgZnJlZSh0cnlfcGF0aF9wcmV2KTsKPiAr
ICAgICAgIGlmICh0cnlfcGF0aF9wcmV2ICE9IHRyeV9wYXRoKSB7Cj4gKyAgICAgICAgICAgICAg
IGZyZWUodHJ5X3BhdGhfcHJldik7Cj4gKyAgICAgICB9Cj4gICAgICAgICByZXR1cm4gTlVMTDsK
PiAgfQo+Cj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
