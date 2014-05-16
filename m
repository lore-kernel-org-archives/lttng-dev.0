From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] FIX: Align buffers on 4 bytes for 64bit
	access
Date: Fri, 16 May 2014 11:47:22 -0400
Message-ID: <CA+jJMxs+3voq1Q=6jBt7pqJnDjEr1U7BSpWTtCR7SUC9CMKxYg__27916.8728543029$1400255293$gmane$org@mail.gmail.com>
References: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
 <CA+jJMxt=fh0FW7VNmpnZwrZ9JtBhAAGuJKbrxDrEKt+nSw95FQ@mail.gmail.com>
 <53756A15.9080208@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WlKM3-0002uh-Lh
 for lttng-dev@lists.lttng.org; Fri, 16 May 2014 11:47:30 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so4421082qge.22
 for <lttng-dev@lists.lttng.org>; Fri, 16 May 2014 08:47:22 -0700 (PDT)
In-Reply-To: <53756A15.9080208@windriver.com>
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

T24gVGh1LCBNYXkgMTUsIDIwMTQgYXQgOToyOSBQTSwgUm9uZ3FpbmcgTGkgPHJvbmdxaW5nLmxp
QHdpbmRyaXZlci5jb20+IHdyb3RlOgo+Cj4KPiBPbiAwNS8xNi8yMDE0IDAzOjM2IEFNLCBKw6ly
w6ltaWUgR2FsYXJuZWF1IHdyb3RlOgo+Pgo+PiBPbiBUaHUsIE1heSAxNSwgMjAxNCBhdCA0OjU3
IEFNLCAgPHJvbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+IHdyb3RlOgo+Pj4KPj4+IEZyb206IEZy
ZWRyaWsgTWFya3N0csO2bSA8ZnJlZHJpay5tYXJrc3Ryb21AZ21haWwuY29tPgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IEZyZWRyaWsgTWFya3N0cuaemm0gPGZyZWRyaWsubWFya3N0cm9tQGdtYWls
LmNvbT4KPj4+IC0tLQo+Pj4gICBmb3JtYXRzL2N0Zi9tZXRhZGF0YS9vYmpzdGFjay5jIHwgICAg
MiArKwo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMKPj4+IGIvZm9ybWF0cy9jdGYv
bWV0YWRhdGEvb2Jqc3RhY2suYwo+Pj4gaW5kZXggOWUyNjRhNC4uOTY0M2I5YiAxMDA2NDQKPj4+
IC0tLSBhL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMKPj4+ICsrKyBiL2Zvcm1hdHMv
Y3RmL21ldGFkYXRhL29ianN0YWNrLmMKPj4+IEBAIC0xMTgsNiArMTE4LDggQEAgdm9pZCAqb2Jq
c3RhY2tfYWxsb2Moc3RydWN0IG9ianN0YWNrICpvYmpzdGFjaywKPj4+IHNpemVfdCBsZW4pCj4+
PiAgICAgICAgICBzdHJ1Y3Qgb2Jqc3RhY2tfbm9kZSAqbGFzdF9ub2RlOwo+Pj4gICAgICAgICAg
dm9pZCAqcDsKPj4+Cj4+PiArICAgICAgIGxlbiA9IChsZW4gKyAzKSAmIH4zOwo+Pgo+Pgo+PiBQ
bGVhc2UgdXNlIHRoZSAiQUxJR04iIG1hY3JvIGRlZmluZWQgaW4gaW5jbHVkZS9iYWJlbHRyYWNl
L2FsaWduLmguCj4+IGxlbiA9IEFMSUdOKGxlbiwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKQo+Pgo+
Cj4KPiBIaSBHYWxhcm5lYXU6Cj4KPiBJIHRoaW5rIGl0IGlzIG1vcmUgZXhwbGljaXQgdG8gbWFr
ZSB0aGUgYWRkcmVzcyx3aGljaCBpcyBhbGxvY2F0ZWQKPiBieSBvYmpzdGFja19hbGxvYywgdG8g
YWxpZ24gdGhlIHNpemVvZih2b2lkKiksIG5vdCBzaXplb2YobG9uZyk7Cj4gdGhvdWdoIHRoZSBz
aXplIG9mIHZvaWQqIGFuZCBsb25nIGFyZSBzYW1lLgo+Cj4gZG8geW91IGFncmVlPwo+CgpBZ3Jl
ZWQuCgpKw6lyw6ltaWUKCj4KPiAtUm95Cj4KPgo+PiBBbHNvLCB0aGUgImRhdGEiIG1lbWJlciBp
biBzdHJ1Y3Qgb2Jqc3RhY2tfbm9kZSBzaG91bGQgYmUgYWxpZ25lZC4KPj4KPj4gc3RydWN0IG9i
anN0YWNrX25vZGUgewo+PiAgICBzdHJ1Y3QgYnRfbGlzdF9oZWFkIG5vZGU7Cj4+ICAgIHNpemVf
dCBsZW47Cj4+ICAgIHNpemVfdCB1c2VkX2xlbjsKPj4gICAgY2hhciBfX2F0dHJpYnV0ZV9fICgo
YWxpZ25lZCAoc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKSkpIGRhdGFbXTsKPj4gfTsKPj4KPj4gVGhh
bmtzIGZvciBicmluZ2luZyB0aGUgcHJvYmxlbSB0byBvdXIgYXR0ZW50aW9uISBJJ2xsIHdhaXQg
Zm9yIGEgdjIuCj4+Cj4+IFJlZ2FyZHMsCj4+IErDqXLDqW1pZQo+Pgo+Pj4gKwo+Pj4gICAgICAg
ICAgLyogR2V0IGxhc3Qgbm9kZSAqLwo+Pj4gICAgICAgICAgbGFzdF9ub2RlID0gYnRfbGlzdF9l
bnRyeShvYmpzdGFjay0+aGVhZC5wcmV2LAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBvYmpzdGFja19ub2RlLCBub2RlKTsKPj4+IC0tCj4+PiAxLjcuMTAuNAo+Pj4KPj4+Cj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+Pj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+Pj4gaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4+
Cj4+Cj4+Cj4+Cj4KPiAtLQo+IEJlc3QgUmVhZ3JkcywKPiBSb3kgfCBSb25nUWluZyBMaQoKCgot
LSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3Mu
Y29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
