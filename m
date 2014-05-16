From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH v2] Fix: Align buffers from objstack_alloc
	on sizeof(void *)
Date: Fri, 16 May 2014 11:52:46 -0400
Message-ID: <CA+jJMxuyfxVmjHZWRAsx6O2mdOoLgV=nJDoD-TDtM4cDbu9j-A__9953.40185841105$1400255645$gmane$org@mail.gmail.com>
References: <1400206238-11343-1-git-send-email-rongqing.li@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WlKRI-0002y4-57
 for lttng-dev@lists.lttng.org; Fri, 16 May 2014 11:52:54 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so4563228qcy.37
 for <lttng-dev@lists.lttng.org>; Fri, 16 May 2014 08:52:46 -0700 (PDT)
In-Reply-To: <1400206238-11343-1-git-send-email-rongqing.li@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rongqing Li <rongqing.li@windriver.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I2luY2x1ZGUgPGJhYmVsdHJhY2UvYWxpZ24uaD4gaXMgbWlzc2luZy4gSSd2ZSBhZGRlZCBpdCBh
bmQgbWVyZ2VkLgoKQWxzbywgbm90ZSB0aGF0IHlvdSBzaG91bGQgdXNlIGdpdCBmb3JtYXQtcGF0
Y2gncwotLXN1YmplY3QtcHJlZml4PSJQQVRDSCBwcm9qZWN0X25hbWUiIG9wdGlvbi4gSXQgbWFr
ZXMgaXQgZWFzaWVyIHRvCmtlZXAgdHJhY2sgb2YgcGF0Y2hlcyBzaW5jZSB0aGlzIG1haWxpbmcg
bGlzdCBpcyBzaGFyZWQgYmV0d2VlbgptdWx0aXBsZSBwcm9qZWN0cy4KClRoYW5rcyEKSsOpcsOp
bWllCgpPbiBUaHUsIE1heSAxNSwgMjAxNCBhdCAxMDoxMCBQTSwgIDxyb25ncWluZy5saUB3aW5k
cml2ZXIuY29tPiB3cm90ZToKPiBGcm9tOiBGcmVkcmlrIE1hcmtzdHLDtm0gPGZyZWRyaWsubWFy
a3N0cm9tQGdtYWlsLmNvbT4KPgo+IFRoZSBidWZmZXJzIGZyb20gb2Jqc3RhY2tfYWxsb2Mgd2ls
bCBzdG9yZSB0aGUgcG9pbnRlciwgc28gaXQgbXVzdAo+IGJlIGFsaWduZWQgb24gcG9pbnRlciwg
b3IgZWxzZSBpdCB3aWxsIGNhdXNlIGlzc3VlIG9uIHRoZSBjcHUKPiB3aGljaCBkb2VzIG5vdCBz
dXBwb3J0IHVuYWxpZ25lZCBhZGRyZXNzZXMgYWNjZXNzCj4KPiBTaWduZWQtb2ZmLWJ5OiBGcmVk
cmlrIE1hcmtzdHJvbSA8ZnJlZHJpay5tYXJrc3Ryb21AZ21haWwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IFJveSBMaSA8cm9uZ3FpbmcubGlAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAgZm9ybWF0cy9j
dGYvbWV0YWRhdGEvb2Jqc3RhY2suYyB8ICAgIDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZm9ybWF0cy9jdGYv
bWV0YWRhdGEvb2Jqc3RhY2suYyBiL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMKPiBp
bmRleCA5ZTI2NGE0Li4wZTdkMDRlIDEwMDY0NAo+IC0tLSBhL2Zvcm1hdHMvY3RmL21ldGFkYXRh
L29ianN0YWNrLmMKPiArKysgYi9mb3JtYXRzL2N0Zi9tZXRhZGF0YS9vYmpzdGFjay5jCj4gQEAg
LTM5LDcgKzM5LDcgQEAgc3RydWN0IG9ianN0YWNrX25vZGUgewo+ICAgICAgICAgc3RydWN0IGJ0
X2xpc3RfaGVhZCBub2RlOwo+ICAgICAgICAgc2l6ZV90IGxlbjsKPiAgICAgICAgIHNpemVfdCB1
c2VkX2xlbjsKPiAtICAgICAgIGNoYXIgZGF0YVtdOwo+ICsgICAgICAgY2hhciBfX2F0dHJpYnV0
ZV9fICgoYWxpZ25lZCAoc2l6ZW9mKHZvaWQgKikpKSkgZGF0YVtdOwo+ICB9Owo+Cj4gIEJUX0hJ
RERFTgo+IEBAIC0xMTgsNiArMTE4LDggQEAgdm9pZCAqb2Jqc3RhY2tfYWxsb2Moc3RydWN0IG9i
anN0YWNrICpvYmpzdGFjaywgc2l6ZV90IGxlbikKPiAgICAgICAgIHN0cnVjdCBvYmpzdGFja19u
b2RlICpsYXN0X25vZGU7Cj4gICAgICAgICB2b2lkICpwOwo+Cj4gKyAgICAgICBsZW4gPSBBTElH
TihsZW4sIHNpemVvZih2b2lkICopKTsKPiArCj4gICAgICAgICAvKiBHZXQgbGFzdCBub2RlICov
Cj4gICAgICAgICBsYXN0X25vZGUgPSBidF9saXN0X2VudHJ5KG9ianN0YWNrLT5oZWFkLnByZXYs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG9ianN0YWNrX25vZGUsIG5vZGUpOwo+
IC0tCj4gMS43LjEwLjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMu
Cmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
