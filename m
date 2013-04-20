From: Zifei Tong <soariez@gmail.com>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Sat, 20 Apr 2013 20:29:17 +0800
Message-ID: <CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw__35119.0118039542$1366461034$gmane$org@mail.gmail.com>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1UTWvb-0000pc-Gy
	for lttng-dev@lists.lttng.org; Sat, 20 Apr 2013 08:30:03 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so4649628vcb.19
	for <lttng-dev@lists.lttng.org>; Sat, 20 Apr 2013 05:29:58 -0700 (PDT)
In-Reply-To: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gRnJpLCBBcHIgMTksIDIwMTMgYXQgMTozOCBQTSwgWmlmZWkgVG9uZyA8c29hcmllekBnbWFp
bC5jb20+IHdyb3RlOgo+IFdoaWxlIGZvciBnKyssIHNpbmNlIGl0IGRvZXMgbm90IHN1cHBvcnQg
QydzIGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXIKPiAoY2xhbmcrKyBkb2VzKSwgZnVydGhlciB3b3Jr
IHNoYWxsIGJlIGRvbmUuIEFsbCByZW1haW5pbmcgZXJyb3JzIGFyZQo+IHJlbGF0ZWQgdG8gdGhp
cyBzdHJ1Y3QgaW5pdGlhbGl6ZXIgaXNzdWUKPiAoaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vNWtn
LzU0MTc4NTApLCBjYW4gYW55b25lIHN1Z2dlc3QgYSBjbGVhbiBoYWNrCj4gdG8gd29ya2Fyb3Vu
ZCB0aGlzPwoKSSBkaWQgc29tZSByZXNlYXJjaCBvbiBkZXNpZ25hdGVkIGluaXRpYWxpemVyIHRv
ZGF5LCBhbmQgZmluYWxseSBtYWRlCmcrKyBjb21waWxlICdoZWxsby5jeHgnIGV4YW1wbGUuCgpH
KysgZG8gc3VwcG9ydCBkZXNpZ25hdGVkIGluaXRpYWxpemVyLCBob3dldmVyIG9ubHkgJ3RyaXZp
YWwKZGVzaWduYXRlZCBpbml0aWFsaXplcnMnIGFyZSBzdXBwb3J0ZWQsIG90aGVyd2lzZSBpdCB3
aWxsIGNvbXBsYWluOgonc29ycnksIHVuaW1wbGVtZW50ZWQ6IG5vbi10cml2aWFsIGRlc2lnbmF0
ZWQgaW5pdGlhbGl6ZXJzIG5vdApzdXBwb3J0ZWQnLgoKQWZ0ZXIgc29tZSB0cmlhbC1hbmQtZXJy
b3IsIGl0IHNlZW1zIHRoYXQgJ3RyaXZpYWwgZGVzaWduYXRlZAppbml0aWFsaXplcnMnIG1lYW5z
IG5vIG91dC1vZi1vcmRlciBpbml0aWFsaXphdGlvbiBhbmQgbm8gbWlzc2luZwppbml0aWFsaXph
dGlvbiAoZXhjZXB0IHRoZSBmaWVsZHMgb24gdGhlIHRhaWwgb2YgYSBzdHJ1Y3QpLgpBbmQgbmVz
dGVkIGluaXRpYWxpemF0aW9uIHNob3VsZCBiZSBkb25lIGluIHRoZSBmb3JtIHsuZm9vID0gey5i
YXIgPQoxfX0gaW5zdGVhZCBvZiB7LmZvby5iYXIgPSAxfS4KClNvIEkgcmVvcmRlcmVkIHNvbWUg
aW5pdGlhbGl6ZXJzLCBhZGQgc29tZSBmaWVsZHMsIGFuZCBjaGFuZ2UgbmVzdGVkCmluaXRpYWxp
emF0aW9ucyBpbiB0aGUgYWJvdmUgb2RkIGZvcm0gdG8gbWFrZSBnKysgaGFwcHkuCgpJJ3ZlIHVw
bG9hZGVkIGEgcGF0Y2ggdG86IGh0dHA6Ly9idWdzLmx0dG5nLm9yZy9pc3N1ZXMvMzM4CgpDb3Vs
ZCB5b3UgcGxlYXNlIHJldmlldyBpdD8KClRoYW5rcy4KLS0KQmVzdCBSZWdhcmRzLArku53lrZDp
o54gKFppZmVpIFRvbmcpCkNvbGxlZ2Ugb2YgQ29tcHV0ZXIgU2NpZW5jZSBhbmQgVGVjaG5vbG9n
eSwgWmhlamlhbmcgVW5pdmVyc2l0eQoKc29hcmllekBnbWFpbC5jb20gLyB0b25nemlmZWlAemp1
LmVkdS5jbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
