From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Assert on null index_file
Date: Mon, 8 May 2017 11:45:02 -0400
Message-ID: <CA+jJMxs2ti0-RbXPXs_rR-GFaMsabUaB0jGbccum7LMv8fuOTQ__20467.6809757531$1494258321$gmane$org@mail.gmail.com>
References: <20170508152254.13846-1-jonathan.rajotte-julien@efficios.com>
 <20170508152254.13846-2-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3wM6KY0CSjzCNs
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 15:45:52 +0000 (UTC)
Received: by mail-yb0-x243.google.com with SMTP id l192so2205895ybl.1
 for <lttng-dev@lists.lttng.org>; Mon, 08 May 2017 08:45:03 -0700 (PDT)
In-Reply-To: <20170508152254.13846-2-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIHdpdGggYSBzbGlnaHRseSBtb2RpZmllZCB0aXRsZSBpbiBtYXN0ZXIsIHN0YWJsZS0y
LjEwIGFuZCBzdGFibGUtMi45LgoKIkZpeDogYXNzZXJ0KCkgb24gbnVsbCBpbmRleF9maWxlIGlu
IGx0dG5nX2luZGV4X2ZpbGVfd3JpdGUoKSIKClRoYW5rcywKSsOpcsOpbWllCgpPbiA4IE1heSAy
MDE3IGF0IDExOjIyLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBl
ZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpv
bmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi9p
bmRleC9pbmRleC5jIHwgOCArKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vaW5kZXgvaW5k
ZXguYyBiL3NyYy9jb21tb24vaW5kZXgvaW5kZXguYwo+IGluZGV4IGI0ODFiYWRiLi5jOTRlYzcw
MSAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL2luZGV4L2luZGV4LmMKPiArKysgYi9zcmMvY29t
bW9uL2luZGV4L2luZGV4LmMKPiBAQCAtMTI4LDEyICsxMjgsMTYgQEAgZXJyb3I6Cj4gIGludCBs
dHRuZ19pbmRleF9maWxlX3dyaXRlKGNvbnN0IHN0cnVjdCBsdHRuZ19pbmRleF9maWxlICppbmRl
eF9maWxlLAo+ICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgY3RmX3BhY2tldF9pbmRleCAq
ZWxlbWVudCkKPiAgewo+ICsgICAgICAgaW50IGZkOwo+ICsgICAgICAgc2l6ZV90IGxlbjsKPiAg
ICAgICAgIHNzaXplX3QgcmV0Owo+IC0gICAgICAgaW50IGZkID0gaW5kZXhfZmlsZS0+ZmQ7Cj4g
LSAgICAgICBzaXplX3QgbGVuID0gaW5kZXhfZmlsZS0+ZWxlbWVudF9sZW47Cj4KPiArICAgICAg
IGFzc2VydChpbmRleF9maWxlKTsKPiAgICAgICAgIGFzc2VydChlbGVtZW50KTsKPgo+ICsgICAg
ICAgZmQgPSBpbmRleF9maWxlLT5mZDsKPiArICAgICAgIGxlbiA9IGluZGV4X2ZpbGUtPmVsZW1l
bnRfbGVuOwo+ICsKPiAgICAgICAgIGlmIChmZCA8IDApIHsKPiAgICAgICAgICAgICAgICAgZ290
byBlcnJvcjsKPiAgICAgICAgIH0KPiAtLQo+IDIuMTEuMAo+CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
