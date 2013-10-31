From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Uninitialized
 ctf_stream_pos	structure in ctf_float_write()
Date: Thu, 31 Oct 2013 13:18:53 +0000 (UTC)
Message-ID: <1524283830.54353.1383225533285.JavaMail.zimbra__372.381837996905$1383225576$gmane$org@efficios.com>
References: <1381857813-6904-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vbs9J-0007M0-Eu
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 09:18:58 -0400
In-Reply-To: <1381857813-6904-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTZW50OiBUdWVzZGF5LCBPY3Rv
YmVyIDE1LCAyMDEzIDE6MjM6MzMgUE0KPiBTdWJqZWN0OiBbbHR0bmctZGV2XSBbUEFUQ0ggYmFi
ZWx0cmFjZV0gRml4OiBVbmluaXRpYWxpemVkIGN0Zl9zdHJlYW1fcG9zCXN0cnVjdHVyZSBpbiBj
dGZfZmxvYXRfd3JpdGUoKQo+IAo+IFRoaXMgc3RydWN0dXJlIGlzIHBhc3NlZCB0byBfY3RmX2Zs
b2F0X2NvcHkoKSB3aGljaCB1c2VzIHRoZQo+IHVuaW5pdGlhbGl6ZWQgbW1hcF9vZmZzZXQgYW5k
IG9mZnNldCB2YWx1ZXMgdG8gcmVhZCB0aGUgc291cmNlCj4gZmxvYXRpbmcgcG9pbnQgdmFsdWUu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5l
YXVAZWZmaWNpb3MuY29tPgo+IFJldmlld2VkLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBmb3JtYXRzL2N0Zi90eXBlcy9mbG9h
dC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZm9ybWF0cy9jdGYvdHlwZXMvZmxvYXQuYyBiL2Zvcm1hdHMv
Y3RmL3R5cGVzL2Zsb2F0LmMKPiBpbmRleCAyZGFhZGY5Li42ODkwMjgzIDEwMDY0NAo+IC0tLSBh
L2Zvcm1hdHMvY3RmL3R5cGVzL2Zsb2F0LmMKPiArKysgYi9mb3JtYXRzL2N0Zi90eXBlcy9mbG9h
dC5jCj4gQEAgLTIzMiw3ICsyMzIsNyBAQCBpbnQgY3RmX2Zsb2F0X3dyaXRlKHN0cnVjdCBidF9z
dHJlYW1fcG9zICpwcG9zLCBzdHJ1Y3QKPiBidF9kZWZpbml0aW9uICpkZWZpbml0aW9uCj4gIAl1
bmlvbiBkb3VibGVJRUVFNzU0IHU7Cj4gIAlzdHJ1Y3QgYnRfZGVmaW5pdGlvbiAqdG1wZGVmOwo+
ICAJc3RydWN0IGRlZmluaXRpb25fZmxvYXQgKnRtcGZsb2F0Owo+IC0Jc3RydWN0IGN0Zl9zdHJl
YW1fcG9zIHNyY3A7Cj4gKwlzdHJ1Y3QgY3RmX3N0cmVhbV9wb3Mgc3JjcCA9IHsgeyAwIH0gfTsK
PiAgCXN0cnVjdCBtbWFwX2FsaWduIG1tYTsKPiAgCWludCByZXQ7Cj4gIAo+IC0tCj4gMS44LjQK
PiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4g
CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9z
LmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
