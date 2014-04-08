From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: .split() the CC environment
 variable in lttng-gen-tp
Date: Tue, 8 Apr 2014 17:39:06 +0000 (UTC)
Message-ID: <1235150978.20.1396978746115.JavaMail.zimbra__6312.03905581987$1396978817$gmane$org@efficios.com>
References: <20140408085021.GA3326@hal>
 <1396970903-17438-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXZzO-0001pw-5s
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 13:39:19 -0400
In-Reply-To: <1396970903-17438-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBDYzogIm1hdGhpZXUgZGVzbm95
ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiwgImphbiBnbGF1YmVyIiA8amFu
LmdsYXViZXJAZ21haWwuY29tPiwgIkrDqXLDqW1pZSBHYWxhcm5lYXUiCj4gPGplcmVtaWUuZ2Fs
YXJuZWF1QGVmZmljaW9zLmNvbT4KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA4LCAyMDE0IDExOjI4
OjIzIEFNCj4gU3ViamVjdDogW1BBVENIIGx0dG5nLXVzdF0gRml4OiAuc3BsaXQoKSB0aGUgQ0Mg
ZW52aXJvbm1lbnQgdmFyaWFibGUgaW4gbHR0bmctZ2VuLXRwCj4gCj4gVGhlIENDIHZhcmlhYmxl
IG1pZ2h0IGNvbnRhaW4gY29tbWFuZCBsaW5lIGFyZ3VtZW50cyB3aGljaCBsdHRuZy1nZW4tdHAK
PiBjdXJyZW50bHkgZG9lcyBub3QgaGFuZGxlLiBUaGlzIGZpeCBlbnN1cmVzIHRoYXQgdGhlIGFy
Z3VtZW50cyBhcmUKPiBwcm9wZXJseSBwYXNzZWQgb24gdG8gdGhlIGNvbXBpbGVyIGJpbmFyeSBh
cyBpZiBhIG5vcm1hbCBNYWtlZmlsZQo+IHdhcyB1c2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IErD
qXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgdG9vbHMvbHR0bmctZ2VuLXRwIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbHR0bmctZ2VuLXRw
IGIvdG9vbHMvbHR0bmctZ2VuLXRwCj4gaW5kZXggYTNhMDFmMi4uYjYyY2Q5OSAxMDA3NTUKPiAt
LS0gYS90b29scy9sdHRuZy1nZW4tdHAKPiArKysgYi90b29scy9sdHRuZy1nZW4tdHAKPiBAQCAt
OTQsNyArOTQsNyBAQCBjbGFzcyBPYmpGaWxlOgo+ICAgICAgICAgIGlmICdDQycgaW4gb3MuZW52
aXJvbjoKPiAgICAgICAgICAgICAgY2MgPSBvcy5lbnZpcm9uWydDQyddCj4gICAgICAgICAgICAg
IHRyeToKPiAtICAgICAgICAgICAgICAgIHN1YnByb2Nlc3MuY2FsbChjYywKPiArICAgICAgICAg
ICAgICAgIHN1YnByb2Nlc3MuY2FsbChjYy5zcGxpdCgpLAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0ZG91dD1zdWJwcm9jZXNzLlBJUEUsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RkZXJyPXN1YnByb2Nlc3MuUElQRSkKPiAgICAgICAgICAgICAgZXhj
ZXB0IE9TRXJyb3IgYXMgbXNnOgo+IC0tCj4gMS45LjEKPiAKPiAKCi0tIApNYXRoaWV1IERlc25v
eWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
