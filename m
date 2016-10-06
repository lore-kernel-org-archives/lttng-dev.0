From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] lttng-sessiond: auto-load
 lttng-probe-i2c module
Date: Thu, 6 Oct 2016 12:18:43 -0400
Message-ID: <CA+jJMxtPaHWhgFGQMTh2AHHKvBg1_ja+ed+BMKAVx-q5ML=xvg__25195.4295010821$1475770741$gmane$org@mail.gmail.com>
References: <20161004222450.8004-1-simon.marchi@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 80006A4489
 for <lttng-dev@lists.lttng.org>; Thu,  6 Oct 2016 16:20:21 +0000 (UTC)
Received: by mail-ua0-f196.google.com with SMTP id p25so900738uaa.3
 for <lttng-dev@lists.lttng.org>; Thu, 06 Oct 2016 09:18:44 -0700 (PDT)
In-Reply-To: <20161004222450.8004-1-simon.marchi@ericsson.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simon.marchi@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDQgT2N0b2JlciAyMDE2IGF0IDE4OjI0LCBT
aW1vbiBNYXJjaGkgPHNpbW9uLm1hcmNoaUBlcmljc3Nvbi5jb20+IHdyb3RlOgo+IEF1dG9tYXRp
Y2FsbHkgbG9hZCB0aGUgbHR0bmctcHJvYmUtaTJjIGtlcm5lbCBtb2R1bGUsIHdoaWNoIHdhcyBy
ZWNlbnRseQo+IGFkZGVkIGluIGx0dG5nLW1vZHVsZXMsIGFsb25nIHdpdGggdGhlIG90aGVyIHBy
b2JlIG1vZHVsZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBNYXJjaGkgPHNpbW9uLm1hcmNo
aUBlcmljc3Nvbi5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUu
YyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQg
YS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21vZHByb2JlLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Np
b25kL21vZHByb2JlLmMKPiBpbmRleCBjYTA0NjdlLi5mNThmNTBjIDEwMDY0NAo+IC0tLSBhL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvbW9kcHJvYmUuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbW9kcHJvYmUuYwo+IEBAIC01Nyw2ICs1Nyw3IEBAIHN0cnVjdCBrZXJuX21vZHVsZXNf
cGFyYW0ga2Vybl9tb2R1bGVzX3Byb2Jlc19kZWZhdWx0W10gPSB7Cj4gICAgICAgICB7ICJsdHRu
Zy1wcm9iZS1leHQzIiB9LAo+ICAgICAgICAgeyAibHR0bmctcHJvYmUtZXh0NCIgfSwKPiAgICAg
ICAgIHsgImx0dG5nLXByb2JlLWdwaW8iIH0sCj4gKyAgICAgICB7ICJsdHRuZy1wcm9iZS1pMmMi
IH0sCj4gICAgICAgICB7ICJsdHRuZy1wcm9iZS1pcnEiIH0sCj4gICAgICAgICB7ICJsdHRuZy1w
cm9iZS1qYmQiIH0sCj4gICAgICAgICB7ICJsdHRuZy1wcm9iZS1qYmQyIiB9LAo+IC0tCj4gMi4x
MC4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoK
CgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
