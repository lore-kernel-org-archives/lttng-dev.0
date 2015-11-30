From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] configure.ac: use $withval with
	AC_ARG_WITH
Date: Mon, 30 Nov 2015 02:08:36 -0500
Message-ID: <CA+jJMxu2HXS70XT-YKJZv7wjF_yeRiTkgvHLhVoQEC2_TNnkMw__9916.2045437426$1448867381$gmane$org@mail.gmail.com>
References: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
 <1448231881-7988-2-git-send-email-s.martin49@gmail.com>
 <CAHXCMMJhOK9ELj=aKNGiGw_fmgTH46=6hedEXNaX0rvrOBdgmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1a3IZl-0004KN-P2
 for lttng-dev@lists.lttng.org; Mon, 30 Nov 2015 02:08:44 -0500
Received: by ykfs79 with SMTP id s79so175005049ykf.1
 for <lttng-dev@lists.lttng.org>; Sun, 29 Nov 2015 23:08:36 -0800 (PST)
In-Reply-To: <CAHXCMMJhOK9ELj=aKNGiGw_fmgTH46=6hedEXNaX0rvrOBdgmw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Samuel Martin <s.martin49@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTm92IDI3LCAyMDE1IGF0IDQ6MjAg
UE0sIFNhbXVlbCBNYXJ0aW4gPHMubWFydGluNDlAZ21haWwuY29tPiB3cm90ZToKPiBIaSBhbGws
Cj4KPiBPbiBTdW4sIE5vdiAyMiwgMjAxNSBhdCAxMTozOCBQTSwgU2FtdWVsIE1hcnRpbiA8cy5t
YXJ0aW40OUBnbWFpbC5jb20+IHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBTYW11ZWwgTWFydGlu
IDxzLm1hcnRpbjQ5QGdtYWlsLmNvbT4KPiAgLS0tCj4+ICBjb25maWd1cmUuYWMgfCAyICstCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwo+PiBpbmRleCBmYWQ0ZGU2Li45
NzhlM2JjIDEwMDY0NAo+PiAtLS0gYS9jb25maWd1cmUuYWMKPj4gKysrIGIvY29uZmlndXJlLmFj
Cj4+IEBAIC0zMTUsNyArMzE1LDcgQEAgQUNfQVJHX1dJVEgobHR0bmctdXN0LXByZWZpeCwKPj4g
ICMgQ2hlY2sgbGlibHR0bmctdXN0LWN0bCBsaWJyYXJ5Cj4+ICBBQ19BUkdfV0lUSChsdHRuZy11
c3QsCj4+ICAgICAgICAgQVNfSEVMUF9TVFJJTkcoWy0td2l0aG91dC1sdHRuZy11c3RdLFtidWls
ZCB3aXRob3V0IExUVG5nLVVTVCAoVXNlcnNwYWNlIFRyYWNpbmcpIHN1cHBvcnRdKSwKPj4gLSAg
ICAgICBsdHRuZ191c3Rfc3VwcG9ydD0kZW5hYmxldmFsLCBsdHRuZ191c3Rfc3VwcG9ydD15ZXMp
Cj4+ICsgICAgICAgbHR0bmdfdXN0X3N1cHBvcnQ9JHdpdGh2YWwsIGx0dG5nX3VzdF9zdXBwb3J0
PXllcykKPj4KPj4gIEFTX0lGKFt0ZXN0ICJ4JGx0dG5nX3VzdF9zdXBwb3J0IiA9ICJ4eWVzIl0s
IFsKPj4gICAgICAgICBBQ19DSEVDS19MSUIoW2x0dG5nLXVzdC1jdGxdLCBbdXN0Y3RsX3JlY3Zf
Y2hhbm5lbF9mcm9tX2NvbnN1bWVyXSwKPj4gLS0KPj4gMi42LjIKPj4KPgo+IEZvciB0aGUgcmVj
b3JkLCBJIGp1c3QgZmlsZSBhIGJ1ZzoKPiBodHRwczovL2J1Z3MubHR0bmcub3JnL2lzc3Vlcy85
ODAKPgo+IENoZWVycywKPgo+IC0tCj4gU2FtdWVsCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmlj
aU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
