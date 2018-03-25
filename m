From: Khalid Elmously <khalid.elmously@canonical.com>
Subject: Re: [PATCH lttng-modules v3] Update: kvm
 instrumentation for ubuntu 4.13.0-38
Date: Sat, 24 Mar 2018 21:34:05 -0400
Message-ID: <20180325013402.bxkq7ec42h3axll6__8835.91388487748$1521941543$gmane$org@kbuntu>
References: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
 <20180323172803.26196-1-khalid.elmously@canonical.com>
 <1889599385.3895.1521842622168.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 4080Dm410dzxvS
 for <lttng-dev@lists.lttng.org>; Sat, 24 Mar 2018 21:34:16 -0400 (EDT)
Received: from mail-qk0-f200.google.com ([209.85.220.200])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <khalid.elmously@canonical.com>)
 id 1ezuXx-0004Xm-Gp
 for lttng-dev@lists.lttng.org; Sun, 25 Mar 2018 01:34:09 +0000
Received: by mail-qk0-f200.google.com with SMTP id v194so10481365qka.2
 for <lttng-dev@lists.lttng.org>; Sat, 24 Mar 2018 18:34:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1889599385.3895.1521842622168.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxOC0wMy0yMyAxODowMzo0MiAsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOgo+IC0tLS0t
IE9uIE1hciAyMywgMjAxOCwgYXQgMToyOCBQTSwgS2hhbGlkIEVsbW91c2x5IGtoYWxpZC5lbG1v
dXNseUBjYW5vbmljYWwuY29tIHdyb3RlOgo+IAo+ID4gU3RhcnRpbmcgZnJvbSA0LjEzLjAtMzgg
dGhlIHVidW50dSBrZXJuZWwgYmFja3BvcnQgYSBrdm0gaW5zdHJ1bWVudGF0aW9uCj4gPiBjaGFu
Z2UgaW50cm9kdWNlZCBpbiA0LjE1IHdoaWNoIGFmZmVjdHMgdGhlIHByb3RvdHlwZSBvZiB0aGUg
a3ZtX21taW8gZXZlbnQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEtoYWxpZCBFbG1vdXNseSA8
a2hhbGlkLmVsbW91c2x5QGNhbm9uaWNhbC5jb20+Cj4gPiAtLS0KPiA+IGluc3RydW1lbnRhdGlv
bi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIHwgMSArCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMv
bHR0bmctbW9kdWxlL2t2bS5oCj4gPiBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9k
dWxlL2t2bS5oCj4gPiBpbmRleCA4ZjlhMTMyLi5hNTk4MmM5IDEwMDY0NAo+ID4gLS0tIGEvaW5z
dHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKPiA+ICsrKyBiL2luc3RydW1l
bnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oCj4gPiBAQCAtOTIsNiArOTIsNyBAQCBM
VFROR19UUkFDRVBPSU5UX0VWRU5UKGt2bV9hY2tfaXJxLAo+ID4gCXx8IExUVE5HX0tFUk5FTF9S
QU5HRSg0LDEsNTAsIDQsMiwwKSBcCj4gPiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDMsMTYsNTIs
IDMsMTcsMCkgXAo+ID4gCXx8IExUVE5HX0tFUk5FTF9SQU5HRSgzLDIsOTcsIDMsMywwKSBcCj4g
PiArCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoNCwxMywxNiwzOCwgNCwxNCwwLDApIFwK
PiA+IAl8fCBMVFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDQsOSw2NSwwLDMsMCwgNCwxMCwwLDAs
MCwwKSBcCj4gPiAJfHwgTFRUTkdfRkVET1JBX0tFUk5FTF9SQU5HRSg0LDE0LDEzLDMwMCwgNCwx
NSwwLDApKQo+IAo+IFRoZSBtZXNzYWdlIGlzIGluIGJhc2U2NCBJIHRoaW5rLiBDYW4geW91IHJl
c2VuZCBpdCBpbiBwbGFpbiB0ZXh0ID8KCm11dHQgdGVsbHMgbWUgaXQncyBhbHJlYWR5IGluIHRl
eHQvcGxhaW46CgpEYXRlOiBGcmksIDIzIE1hciAyMDE4IDEzOjI4OjAzIC0wNDAwClgtTWFpbGVy
OiBnaXQtc2VuZC1lbWFpbCAyLjE0LjEKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UcmFuc2Zl
ci1FbmNvZGluZzogOGJpdApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9dXRmLTgK
U3RhdHVzOiBSTwoKCkJ1dCBJIHdpbGwgc2VuZCB2NCBhbnl3YXkganVzdCBpbiBjYXNlLiBZb3Ug
Y2FuIGFsc28gZmV0Y2ggZ2l0Oi8vZ2l0LmxhdW5jaHBhZC5uZXQvfmttb3VzbHkvdWJ1bnR1Lytz
b3VyY2UvbHR0bmcgNmE1OGFjYjY4ZjgxM2FjNDkyMjA1NGQ0YWNjM2Q5MmZhZjI2MDc3YQoKVGhh
bmtzCi1LaGFsaWQKCgo+IAo+IFRoYW5rcywKPiAKPiBNYXRoaWV1Cj4gCj4gPiAKPiA+IC0tCj4g
PiAyLjE0LjEKPiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiA+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiA+IGx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKPiA+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKPiAKPiAtLSAKPiBNYXRoaWV1IERlc25veWVycwo+IEVmZmljaU9TIElu
Yy4KPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
