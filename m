From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: NULL pointer dereference
	in relay_index_get_by_id_or_create
Date: Wed, 18 May 2016 15:19:14 -0400
Message-ID: <CA+jJMxsie8RvAU_F64ARQBBkMoGEMxQcR0MWk9RW-u_z-H3r_w__16179.387845523$1463599175$gmane$org@mail.gmail.com>
References: <1463496265-28682-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f68.google.com (mail-qg0-f68.google.com
 [209.85.192.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 53A7EA0242
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:19:15 +0000 (UTC)
Received: by mail-qg0-f68.google.com with SMTP id b14so5017907qge.2
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 12:19:15 -0700 (PDT)
In-Reply-To: <1463496265-28682-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDEwOjQ0
IEFNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBGb3VuZCBieSBDb3Zlcml0eToKPgo+IENJRCAxMzIzMTM0ICgjMSBvZiAxKTogRGVy
ZWZlcmVuY2UgYWZ0ZXIgbnVsbCBjaGVjayAoRk9SV0FSRF9OVUxMKTM0Lgo+IHZhcl9kZXJlZl9v
cDogRGVyZWZlcmVuY2luZyBudWxsIHBvaW50ZXIgaW5kZXguCj4KPiBTaWduZWQtb2ZmLWJ5OiBN
YXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+
ICBzcmMvYmluL2x0dG5nLXJlbGF5ZC9pbmRleC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0
dG5nLXJlbGF5ZC9pbmRleC5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvaW5kZXguYwo+IGluZGV4
IDljMzA3NzkuLjgwYTRiYjkgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvaW5k
ZXguYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2luZGV4LmMKPiBAQCAtMTYyLDcgKzE2
Miw3IEBAIHN0cnVjdCByZWxheV9pbmRleCAqcmVsYXlfaW5kZXhfZ2V0X2J5X2lkX29yX2NyZWF0
ZShzdHJ1Y3QgcmVsYXlfc3RyZWFtICpzdHJlYW0sCj4gIGVuZDoKPiAgICAgICAgIHJjdV9yZWFk
X3VubG9jaygpOwo+ICAgICAgICAgREJHMigiSW5kZXggJXNmb3VuZCBvciBjcmVhdGVkIGluIEhU
IGZvciBzdHJlYW0gSUQgJSIgUFJJdTY0ICIgYW5kIHNlcW51bSAlIiBQUkl1NjQsCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgKGluZGV4ID09IE5VTEwpID8gIk5PVCAiIDogIiIsIGluZGV4LT5z
dHJlYW0tPnN0cmVhbV9oYW5kbGUsIG5ldF9zZXFfbnVtKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAoaW5kZXggPT0gTlVMTCkgPyAiTk9UICIgOiAiIiwgc3RyZWFtLT5zdHJlYW1faGFuZGxl
LCBuZXRfc2VxX251bSk7Cj4gICAgICAgICByZXR1cm4gaW5kZXg7Cj4gIH0KPgo+IC0tCj4gMi4x
LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cu
ZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
