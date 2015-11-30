From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: fix tracefile count when
 page_size is > 4k
Date: Mon, 30 Nov 2015 08:58:29 -0500
Message-ID: <CA+jJMxsAK8HyWucfZ21D4A9WmDjX95mm8Bs5nghYdSg0CUBtZA__38563.8435524472$1448891970$gmane$org@mail.gmail.com>
References: <1448659468-25013-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1a3OyR-0006WN-Lo
 for lttng-dev@lists.lttng.org; Mon, 30 Nov 2015 08:58:36 -0500
Received: by ykba77 with SMTP id a77so183579342ykb.2
 for <lttng-dev@lists.lttng.org>; Mon, 30 Nov 2015 05:58:30 -0800 (PST)
In-Reply-To: <1448659468-25013-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTm92IDI3LCAyMDE1IGF0IDQ6MjQg
UE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTZXQg
dGhlIHRyYWNlZmlsZSBzaXplIGFjY29yZGluZyB0byB0aGUgcGxhdGZvcm0gcGFnZV9zaXplIGFu
ZCBpbmNyZWFzZQo+IHRoZSBudW1iZXIgb2YgaXRlcmF0aW9ucyB0byBwcm9wZXJseSB0ZXN0IHRo
ZSByb3RhdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNlZmlsZS1s
aW1pdHMvdGVzdF90cmFjZWZpbGVfY291bnQgfCA1ICsrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcmVn
cmVzc2lvbi90b29scy90cmFjZWZpbGUtbGltaXRzL3Rlc3RfdHJhY2VmaWxlX2NvdW50IGIvdGVz
dHMvcmVncmVzc2lvbi90b29scy90cmFjZWZpbGUtbGltaXRzL3Rlc3RfdHJhY2VmaWxlX2NvdW50
Cj4gaW5kZXggNGZlNmFjMy4uNmFkYTg1OCAxMDA3NTUKPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9u
L3Rvb2xzL3RyYWNlZmlsZS1saW1pdHMvdGVzdF90cmFjZWZpbGVfY291bnQKPiArKysgYi90ZXN0
cy9yZWdyZXNzaW9uL3Rvb2xzL3RyYWNlZmlsZS1saW1pdHMvdGVzdF90cmFjZWZpbGVfY291bnQK
PiBAQCAtMjgsNiArMjgsNyBAQCBTVEFUU19CSU49IiRURVNURElSL3V0aWxzL2JhYmVsc3RhdHMu
cGwiCj4gIE5VTV9URVNUUz03NAo+Cj4gIE5VTV9DUFVTPWBucHJvY2AKPiArUEFHRV9TSVpFPSQo
Z2V0Y29uZiBQQUdFX1NJWkUpCj4KPiAgc291cmNlICRURVNURElSL3V0aWxzL3V0aWxzLnNoCj4K
PiBAQCAtNDcsNyArNDgsNyBAQCBmdW5jdGlvbiBlbmFibGVfbHR0bmdfY2hhbm5lbF9jb3VudF9s
aW1pdCAoKQo+Cj4gICAgICAgICAkVEVTVERJUi8uLi9zcmMvYmluL2x0dG5nLyRMVFROR19CSU4g
ZW5hYmxlLWNoYW5uZWwgXAo+ICAgICAgICAgICAgIC11ICRjaGFubmVsX25hbWUgLXMgJHNlc3Nf
bmFtZSBcCj4gLSAgICAgICAgICAgLUMgNDA5NiAtVyAkdHJhY2VmaWxlX2NvdW50X2xpbWl0IFwK
PiArICAgICAgICAgICAtQyAkKCgkUEFHRV9TSVpFKjMpKSAtVyAkdHJhY2VmaWxlX2NvdW50X2xp
bWl0IFwKPiAgICAgICAgICAgICAtLW92ZXJ3cml0ZSA+L2Rldi9udWxsIDI+JjEKPgo+ICAgICAg
ICAgb2sgJD8gIiR0ZXN0X25hbWUiCj4gQEAgLTEwMyw3ICsxMDQsNyBAQCBmdW5jdGlvbiB0ZXN0
X3RyYWNlZmlsZV9jb3VudF9saW1pdCAoKQo+ICAgICAgICAgc2Vzc2lvbl9uYW1lPSQocmFuZHN0
cmluZyAxNiAwKQo+ICAgICAgICAgY2hhbm5lbF9uYW1lPSJjaGFubmVsIgo+ICAgICAgICAgZXZl
bnRfbmFtZT0idHA6dHB0ZXN0Igo+IC0gICAgICAgbnVtX2l0ZXI9MTAwMAo+ICsgICAgICAgbnVt
X2l0ZXI9MTAwMDAwCj4gICAgICAgICBleHBlY3RlZF9tYXg9JCgoJG51bV9pdGVyIC0gMSkpCj4K
PiAgICAgICAgIGRpYWcgIlRlc3QgdHJhY2VmaWxlIGNvdW50IGxpbWl0IDogJGNvdW50X2xpbWl0
IHRyYWNlZmlsZXMiCj4gLS0KPiAxLjkuMQo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVm
ZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
