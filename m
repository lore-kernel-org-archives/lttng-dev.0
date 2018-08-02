From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: LTTng undefined reference while building the sample
 application.
Date: Thu, 2 Aug 2018 11:11:47 -0400
Message-ID: <20180802151147.GC18033__28870.8486398265$1533222651$gmane$org@joraj-alpa>
References: <CAEN7SXPpZKTgHDU91AwwrzdVQeM+fr=06CKmLJqKUn6uiRbZwg@mail.gmail.com>
 <365f8241-e04e-95b7-881a-f9ffc6d0e555@efficios.com>
 <CAEN7SXNggOTubKvvAOJ8FTmJLpORGEauk1D7+MX6QwThk1uxEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41hDD56nvvz15bg
 for <lttng-dev@lists.lttng.org>; Thu,  2 Aug 2018 11:11:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAEN7SXNggOTubKvvAOJ8FTmJLpORGEauk1D7+MX6QwThk1uxEg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Attel Raghavendra <attel.raghavendra@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGkgUmFnaHUsCgpPbiBUaHUsIEF1ZyAwMiwgMjAxOCBhdCAxMTo0MDo0OUFNICswNTMwLCBBdHRl
bCBSYWdoYXZlbmRyYSB3cm90ZToKPiBUaGFuayB5b3UgZm9yIHlvdXIgaGVscCEKPiBSYWdodQo+
IAo+IE9uIFdlZCwgQXVnIDEsIDIwMTggYXQgODozNiBQTSBNaWNoYWVsIEplYW5zb24gPG1qZWFu
c29uQGVmZmljaW9zLmNvbT4KPiB3cm90ZToKPiAKPiA+IE9uIDIwMTgtMDgtMDEgMDc6MjIgQU0s
IEF0dGVsIFJhZ2hhdmVuZHJhIHdyb3RlOgo+ID4gPiBIaSBUZWFtLAo+ID4gPgo+ID4gPiBJIGhh
dmUgbmV3IHRvIHRoZSBMVFRuZy4gSSBhbSB0cnlpbmcgdG8gYnVpbGQgYSBzYW1wbGUgYXBwbGlj
YXRpb24gdG8KPiA+ID4gdGVzdCB0aGUgTFRUbmcuCgpEaWQgeW91IGhhdmUgYSBsb29rIGF0IHRo
ZSBkb2M/IFsxXSBodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEwLyNkb2MtYy1hcHBsaWNhdGlv
bgoKPiA+ID4gSSB3YXMgYWJsZSB0byBjb21waWxlIHRoZSBzYW1wbGUgYXBwbGljYXRpb24gc3Vj
Y2Vzc2Z1bGx5LCBob3dldmVyCj4gPiA+IGZhY2luZyB0aGUgZm9sbG93aW5nIGxpbmtlciBwcm9i
bGVtcy4gUGxlYXNlIGhlbHAgdG8gcmVzb2x2ZSB0aGUgc2FtZS4KCldlIHdpbGwgbmVlZCB0aGUg
Y29tcGxldGUgY29tcGlsZSBjb21tYW5kLCBsaW5rZXIgY29tbWFuZCB1c2VkIGFuZCB0aGF0IHlv
dSBpZGVudGlmaWVkIHRoZSBzY2VuYXJpbyBbMl0gZnJvbSB0aGUgZG9jIG1hdGNoaW5nIHlvdXIg
c2l0dWF0aW9uLgoKWzJdIGh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTAvI2RvYy1idWlsZGlu
Zy10cmFjZXBvaW50LXByb3ZpZGVycy1hbmQtdXNlci1hcHBsaWNhdGlvbgoKQWxzbyBjb3VsZCB5
b3UgZ2l2ZSB1cyB0aGUgdmVyc2lvbiBvZiBsdHRuZy10b29scyBhbmQgbHR0bmctdXN0IGluc3Rh
bGxlZD8KCkNoZWVycwoKPiA+ID4KPiA+ID4geHhfYXBwLm86KF9fdHJhY2Vwb2ludHMrMHgxOCk6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8KPiA+ID4gYF9fdHJhY2Vwb2ludF9wcm92aWRlcl9ydHRM
b2dnZXInCj4gPiA+IHh4X3RwcC5vOiBJbiBmdW5jdGlvbiBgX190cmFjZXBvaW50X3Byb3ZpZGVy
X2NoZWNrX3J0dGxvZ2dlcic6Cj4gPiA+IHh4X3RwcC5jOigudGV4dCsweDI3MSk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8KPiA+ID4gYF9fdHJhY2Vwb2ludF9wcm92aWRlcl9taXNtYXRjaF9ydHRM
b2dnZXInCj4gPiA+IHh4X3RwcC5jOigudGV4dCsweDI3Yik6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8KPiA+ID4gYF9fdHJhY2Vwb2ludF9wcm92aWRlcl9taXNtYXRjaF9ydHRMb2dnZXInCj4gPiA+
IGNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwo+ID4gPgo+ID4gPgo+
ID4gPiBUaGFuayB5b3UsCj4gPiA+IFJhZ2h1Lgo+ID4gPgotLSAKSm9uYXRoYW4gUmFqb3R0ZS1K
dWxpZW4KRWZmaWNpT1MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
