From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: text output missing
 separator when printing the domain
Date: Fri, 26 May 2017 09:36:44 -0400
Message-ID: <CA+jJMxtfBAUioMMW-mZCKT4Lak5C+X_egDs696oX7w4U7w0AYw__6613.460640847$1495805816$gmane$org@mail.gmail.com>
References: <1489781723-23942-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3wZ6dM45gfz11Jt
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2017 13:37:43 +0000 (UTC)
Received: by mail-yw0-x244.google.com with SMTP id p144so636887ywp.2
 for <lttng-dev@lists.lttng.org>; Fri, 26 May 2017 06:36:45 -0700 (PDT)
In-Reply-To: <1489781723-23942-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTEuNSwgYW5kIHN0YWJsZS0xLjQuIFRoYW5rcyEKCkrD
qXLDqW1pZQoKT24gMTcgTWFyY2ggMjAxNyBhdCAxNjoxNSwgSnVsaWVuIERlc2Zvc3NleiA8amRl
c2Zvc3NlekBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFdpdGggdGhlICItZiBhbGwiIG9wdGlvbiwg
d2UgZXhwZWN0IHRvIHNlZQo+IDxob3N0bmFtZT46PGRvbWFpbj46PGxvZ2xldmVsPiwgYnV0IGlu
c3RlYWQgd2Ugc2VlCj4gPGhvc3RuYW1lPjxkb21haW4+Ojxsb2dsZXZlbD4uCj4KPiBKdWRnaW5n
IGZyb20gdGhlIHBhdHRlcm4gb2YgdGhlIG90aGVyIHByaW50ZWQgZmllbGRzLCB0aGUgY2hlY2sg
Zm9yCj4gImRvbV9wcmludCIgdmFyaWFibGUgc2VlbXMgdG8gYmUgbWlzc2luZyB3aGVuIHByaW50
aW5nIHRoZSBkb21haW4uCj4KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gRGVzZm9zc2V6IDxqZGVz
Zm9zc2V6QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgZm9ybWF0cy9jdGYtdGV4dC9jdGYtdGV4dC5j
IHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZm9ybWF0cy9jdGYtdGV4dC9jdGYtdGV4dC5jIGIvZm9ybWF0cy9jdGYtdGV4dC9jdGYtdGV4
dC5jCj4gaW5kZXggZjYxNTE2MS4uNjk0NTBjZiAxMDA2NDQKPiAtLS0gYS9mb3JtYXRzL2N0Zi10
ZXh0L2N0Zi10ZXh0LmMKPiArKysgYi9mb3JtYXRzL2N0Zi10ZXh0L2N0Zi10ZXh0LmMKPiBAQCAt
MzUwLDYgKzM1MCw4IEBAIGludCBjdGZfdGV4dF93cml0ZV9ldmVudChzdHJ1Y3QgYnRfc3RyZWFt
X3BvcyAqcHBvcywgc3RydWN0IGN0Zl9zdHJlYW1fZGVmaW5pdGlvCj4gICAgICAgICAgICAgICAg
IHNldF9maWVsZF9uYW1lc19wcmludChwb3MsIElURU1fSEVBREVSKTsKPiAgICAgICAgICAgICAg
ICAgaWYgKHBvcy0+cHJpbnRfbmFtZXMpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBmcHJp
bnRmKHBvcy0+ZnAsICJ0cmFjZTpkb21haW4gPSAiKTsKPiArICAgICAgICAgICAgICAgfSBlbHNl
IGlmIChkb21fcHJpbnQpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHBvcy0+
ZnAsICI6Iik7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgZnByaW50Zihw
b3MtPmZwLCAiJXMiLCBzdHJlYW1fY2xhc3MtPnRyYWNlLT5lbnYuZG9tYWluKTsKPiAgICAgICAg
ICAgICAgICAgaWYgKHBvcy0+cHJpbnRfbmFtZXMpCj4gLS0KPiAyLjcuNAo+CgoKCi0tIApKw6ly
w6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
