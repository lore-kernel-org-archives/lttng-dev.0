From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace stable-1.5] Fix: use LDFLAGS
 instead of LIBS for python bindings
Date: Tue, 13 Jun 2017 11:41:54 -0400
Message-ID: <CA+jJMxt26ggJXbLrkd44HfAZ3YCN+-4X9v25GOuJP+1kO9C=+g__1212.13188763267$1497368778$gmane$org@mail.gmail.com>
References: <1496419004-6922-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x234.google.com (mail-yb0-x234.google.com
 [IPv6:2607:f8b0:4002:c09::234])
 by lists.lttng.org (Postfix) with ESMTPS id 3wnDZf3f4cz11hL
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2017 15:43:54 +0000 (UTC)
Received: by mail-yb0-x234.google.com with SMTP id t7so8512463yba.3
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2017 08:41:56 -0700 (PDT)
In-Reply-To: <1496419004-6922-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGluIHN0YWJsZS0xLjUuIFRoYW5rcyEKCkrDqXLDqW1pZQoKT24gMiBKdW5lIDIwMTcg
YXQgMTE6NTYsIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToK
PiBUdXJucyBvdXQgdGhhdCBjb250cmFyeSB0byB3aGF0IGlzIGRvY3VtZW50ZWQgc29tZSB2ZXJz
aW9ucyBvZiBkaXN0dXRpbHMKPiBkb24ndCBob25vciB0aGUgTElCUyB2YXJpYWJsZSwgdXNlIExE
RkxBR1MgaW5zdGVhZC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5z
b25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBiaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gfCAz
ICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtIGIvYmluZGluZ3MvcHl0
aG9uL01ha2VmaWxlLmFtCj4gaW5kZXggZjY4MDZhOC4uMmNlYWIwMyAxMDA2NDQKPiAtLS0gYS9i
aW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0KPiArKysgYi9iaW5kaW5ncy9weXRob24vTWFrZWZp
bGUuYW0KPiBAQCAtMjUsOCArMjUsNyBAQCBCSU5ESU5HU19ERVBTPXNldHVwLnB5IFwKPiAgQlVJ
TERfRkxBR1M9Q0M9IiQoQ0MpIiBcCj4gICAgICAgICAgICAgICAgIENGTEFHUz0iJChHTElCX0NG
TEFHUykgJChBTV9DRkxBR1MpICQoQ0ZMQUdTKSIgXAo+ICAgICAgICAgICAgICAgICBDUFBGTEFH
Uz0iJChERUZTKSAkKERFRkFVTFRfSU5DTFVERVMpICQoQU1fQ1BQRkxBR1MpICQoQ1BQRkxBR1Mp
IiBcCj4gLSAgICAgICAgICAgICAgIExERkxBR1M9IiQoQU1fTERGTEFHUykgJChMREZMQUdTKSIg
XAo+IC0gICAgICAgICAgICAgICBMSUJTPSIkKEdMSUJfTElCUykgJChMSUJTKSIKPiArICAgICAg
ICAgICAgICAgTERGTEFHUz0iJChBTV9MREZMQUdTKSAkKExERkxBR1MpICQoR0xJQl9MSUJTKSAk
KExJQlMpIgo+Cj4gIGJ1aWxkLXB5dGhvbi1iaW5kaW5ncy5zdGFtcDogJChCSU5ESU5HU19ERVBT
KQo+ICAgICAgICAgJChCVUlMRF9GTEFHUykgJChQWVRIT04pICQoYnVpbGRkaXIpL3NldHVwLnB5
IGJ1aWxkX2V4dAo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZp
Y2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
