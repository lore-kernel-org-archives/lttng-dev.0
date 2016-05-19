From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 04/10] Fix: ust-consumer: flush
 empty packets on snapshot channel
Date: Thu, 19 May 2016 00:12:16 -0400
Message-ID: <CA+jJMxuLAwsSt6w44mTM=YF6dAbsCCo=35R_Jz-OXYJDRhbLTQ__32878.6862236031$1463631154$gmane$org@mail.gmail.com>
References: <1463594659-10964-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1463594659-10964-5-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f67.google.com (mail-qg0-f67.google.com
 [209.85.192.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E3D2AA35A4
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2016 04:12:17 +0000 (UTC)
Received: by mail-qg0-f67.google.com with SMTP id b14so5960189qge.2
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 21:12:17 -0700 (PDT)
In-Reply-To: <1463594659-10964-5-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgTWF5IDE4LCAyMDE2IGF0IDI6MDQg
UE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IFNuYXBzaG90IG9wZXJhdGlvbiBvbiBhIG5vbi1zdG9wcGVkIHN0cmVhbSBzaG91bGQg
dXNlIGEgImZpbmFsIiBmbHVzaCB0bwo+IGVuc3VyZSBlbXB0eSBwYWNrZXRzIGFyZSBmbHVzaGVk
LCBzbyB3ZSBnYXRoZXIgdGltZXN0YW1wcyBhdCB0aGUgbW9tZW50Cj4gd2hlcmUgdGhlIHNuYXBz
aG90IGlzIHRha2VuLiBUaGlzIGlzIGltcG9ydGFudCBmb3Igc3RyZWFtcyB0aGF0IGhhdmUgYQo+
IGxvdyBhbW91bnQgb2YgYWN0aXZpdHksIHdoaWNoIG1pZ2h0IGJlIG9uIGFuIGVtcHR5IHBhY2tl
dCB3aGVuIHRoZQo+IHNuYXBzaG90IGlzIHRyaWdnZXJlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1h
dGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4g
IHNyYy9jb21tb24vdXN0LWNvbnN1bWVyL3VzdC1jb25zdW1lci5jIHwgOCArKysrKysrLQo+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvc3JjL2NvbW1vbi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMgYi9zcmMvY29tbW9u
L3VzdC1jb25zdW1lci91c3QtY29uc3VtZXIuYwo+IGluZGV4IDkxZmZkY2UuLmM2MzE5MDQgMTAw
NjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMKPiArKysg
Yi9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91c3QtY29uc3VtZXIuYwo+IEBAIC0xMTExLDcgKzEx
MTEsMTMgQEAgc3RhdGljIGludCBzbmFwc2hvdF9jaGFubmVsKHVpbnQ2NF90IGtleSwgY2hhciAq
cGF0aCwgdWludDY0X3QgcmVsYXlkX2lkLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAg
ICAgICAgICAgICAgICAgfQo+Cj4gLSAgICAgICAgICAgICAgIHVzdGN0bF9mbHVzaF9idWZmZXIo
c3RyZWFtLT51c3RyZWFtLCAxKTsKPiArICAgICAgICAgICAgICAgLyoKPiArICAgICAgICAgICAg
ICAgICogSWYgdHJhY2luZyBpcyBhY3RpdmUsIHdlIHdhbnQgdG8gcGVyZm9ybSBhICJmdWxsIiBi
dWZmZXIgZmx1c2guCj4gKyAgICAgICAgICAgICAgICAqIEVsc2UsIGlmIHF1aWVzY2VudCwgaXQg
aGFzIGFscmVhZHkgYmVlbiBkb25lIGJ5IHRoZSBwcmlvciBzdG9wLgo+ICsgICAgICAgICAgICAg
ICAgKi8KPiArICAgICAgICAgICAgICAgaWYgKCFzdHJlYW0tPnF1aWVzY2VudCkgewo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHVzdGN0bF9mbHVzaF9idWZmZXIoc3RyZWFtLT51c3RyZWFtLCAw
KTsKPiArICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgIHJldCA9IGx0dG5nX3Vz
dGNvbnN1bWVyX3Rha2Vfc25hcHNob3Qoc3RyZWFtKTsKPiAgICAgICAgICAgICAgICAgaWYgKHJl
dCA8IDApIHsKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
