From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
Date: Tue, 28 Apr 2020 14:51:30 -0400 (EDT)
Message-ID: <1859708486.72922.1588099890391.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
 <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BW2c42K5z1nG8
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:51:36 -0400 (EDT)
In-Reply-To: <1031751564.72894.1588099218629.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <pproulx@efficios.com>
Cc: Diamon discuss <diamon-discuss@lists.linuxfoundation.org>, lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Genevieve Bastien <gbastien+lttng@versatic.net>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXByIDI4LCAyMDIwLCBhdCAyOjQwIFBNLCBQaGlsaXBwZSBQcm91bHggcHByb3Vs
eEBlZmZpY2lvcy5jb20gd3JvdGU6Cgo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPj4g
RnJvbTogIk1hdGhpZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
Pgo+PiBUbzogImdiYXN0aWVuK2x0dG5nIiA8Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0Piwg
Ik1hdHRoZXcgS2hvdXphbSIKPj4gPG1hdHRoZXcua2hvdXphbUBlcmljc3Nvbi5jb20+LAo+PiBk
aWFtb24tZGlzY3Vzc0BsaW51eGZvdW5kYXRpb24ub3JnLCBwcHJvdWx4QGVmZmljaW9zLmNvbSwg
IkplcmVtaWUgR2FsYXJuZWF1Igo+PiA8amdhbGFyQGVmZmljaW9zLmNvbT4KPj4gQ2M6ICJsdHRu
Zy1kZXYiIDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiwgIk1hdGhpZXUgRGVzbm95ZXJzIgo+
PiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgMjMg
QXByaWwsIDIwMjAgMTY6NTI6MjQKPj4gU3ViamVjdDogW1JGQyBQQVRDSCBDVEYgMS8zXSBDbGFy
aWZ5IHRoYXQgdW5saXN0ZWQgZW51bSB2YWx1ZXMgYXJlCj4+IGltcGxlbWVudGF0aW9uLWRlZmlu
ZWQKPiAKPj4gRnJvbTogR2VuZXZpw6h2ZSBCYXN0aWVuIDxnYmFzdGllbitsdHRuZ0B2ZXJzYXRp
Yy5uZXQ+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVu
K2x0dG5nQHZlcnNhdGljLm5ldD4KPj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPj4gLS0tCj4+IGNvbW1vbi10cmFjZS1m
b3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmlj
YXRpb24ubWQKPj4gYi9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQKPj4gaW5k
ZXggZmQ0OWU1OS4uZjVmZWE1MSAxMDA2NDQKPj4gLS0tIGEvY29tbW9uLXRyYWNlLWZvcm1hdC1z
cGVjaWZpY2F0aW9uLm1kCj4+ICsrKyBiL2NvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlv
bi5tZAo+PiBAQCAtNDY0LDYgKzQ2NCw5IEBAIGVudW0gewo+PiB9Cj4+IH5+fgo+PiAKPj4gK1Ro
ZSBtYXBwaW5ncyBpbiB0aGUgZW51bWVyYXRpb24gdHlwZSBkbyBub3QgaGF2ZSB0byBiZSBleGhh
dXN0aXZlLgo+PiArVW5saXN0ZWQgdmFsdWVzIGFyZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkLgo+
PiArCj4gCj4gV2h5IG5vdCBqdXN0Ogo+IAo+ICAgIEFuIGVudW1lcmF0aW9uIGZpZWxkIGNhbiBo
YXZlIGFuIGludGVncmFsIHZhbHVlIHdoaWNoIGl0cyB0eXBlIGRvZXMgbm90Cj4gICAgbWFwIHRv
IGEgc3RyaW5nLgo+IAo+ID8KCkdvb2QgcG9pbnQsIEkgd2lsbCB1c2UgdGhhdCB3b3JkaW5nLgoK
VGhhbmtzLAoKTWF0aGlldQoKPiAKPiBQaGlsCj4gCj4+ICMjIyA0LjIgQ29tcG91bmQgdHlwZXMK
Pj4gCj4+IENvbXBvdW5kIGFyZSBhZ2dyZWdhdGlvbiBvZiB0eXBlIGRlY2xhcmF0aW9ucy4gQ29t
cG91bmQgdHlwZXMgaW5jbHVkZQo+PiAtLQo+ID4gMi4xMS4wCgotLSAKTWF0aGlldSBEZXNub3ll
cnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
