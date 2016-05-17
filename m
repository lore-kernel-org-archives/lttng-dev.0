From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: macro compares unsigned to
	0 (no effect)
Date: Tue, 17 May 2016 16:42:22 -0400
Message-ID: <CA+jJMxt=-kCwd=bwvkXd6e5haYGi79Br+=Wqcqziw0vcRe+Htg__27496.7528101572$1463517767$gmane$org@mail.gmail.com>
References: <1463490111-13604-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E658DA3443
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 20:42:23 +0000 (UTC)
Received: by mail-qk0-f195.google.com with SMTP id q184so2588110qkf.0
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 13:42:23 -0700 (PDT)
In-Reply-To: <1463490111-13604-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDk6MDEg
QU0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IEZvdW5kIGJ5IENvdmVyaXR5Ogo+Cj4gQ0lEIDEyNjIxMTcgKCMxIG9mIDEpOiBNYWNy
byBjb21wYXJlcyB1bnNpZ25lZCB0byAwCj4gKE5PX0VGRkVDVCl1bnNpZ25lZF9jb21wYXJlOiBU
aGlzIGdyZWF0ZXItdGhhbi1vci1lcXVhbC10by16ZXJvCj4gY29tcGFyaXNvbiBvZiBhbiB1bnNp
Z25lZCB2YWx1ZSBpcyBhbHdheXMgdHJ1ZS4gZXZlbnRzLT5uYl9mZCA+PSAwVS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+Cj4gLS0tCj4gIHNyYy9jb21tb24vY29tcGF0L2NvbXBhdC1lcG9sbC5jIHwgMSAtCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9j
b21wYXQvY29tcGF0LWVwb2xsLmMgYi9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtZXBvbGwuYwo+
IGluZGV4IDU4ZjUwY2MuLjYyNTlmZDMgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi9jb21wYXQv
Y29tcGF0LWVwb2xsLmMKPiArKysgYi9zcmMvY29tbW9uL2NvbXBhdC9jb21wYXQtZXBvbGwuYwo+
IEBAIC0yMDgsNyArMjA4LDYgQEAgaW50IGNvbXBhdF9lcG9sbF93YWl0KHN0cnVjdCBsdHRuZ19w
b2xsX2V2ZW50ICpldmVudHMsIGludCB0aW1lb3V0KQo+ICAgICAgICAgICAgICAgICBFUlIoIldy
b25nIGFyZ3VtZW50cyBpbiBjb21wYXRfZXBvbGxfd2FpdCIpOwo+ICAgICAgICAgICAgICAgICBn
b3RvIGVycm9yOwo+ICAgICAgICAgfQo+IC0gICAgICAgYXNzZXJ0KGV2ZW50cy0+bmJfZmQgPj0g
MCk7Cj4KPiAgICAgICAgIGlmIChldmVudHMtPm5iX2ZkID09IDApIHsKPiAgICAgICAgICAgICAg
ICAgZXJybm8gPSBFSU5WQUw7Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJu
ZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
