From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: close channel monitor pipe
 after killing the metadata_timer_thread
Date: Mon, 13 Nov 2017 19:26:27 -0500
Message-ID: <CA+jJMxs7-2i=OjcO9TOCXeREpAgQUa8Tf-x_CXx8Z-4LaFeYXw__23110.2130761885$1510619255$gmane$org@mail.gmail.com>
References: <20171012151939.1534-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybSx23bczz16BM
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 00:26:29 +0000 (UTC)
Received: by mail-wr0-x243.google.com with SMTP id o88so15977843wrb.6
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 16:26:29 -0800 (PST)
In-Reply-To: <20171012151939.1534-1-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDEyIE9jdG9iZXIgMjAxNyBhdCAxMToxOSwg
Sm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRl
LWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0
dG5nLWNvbnN1bWVyZC5jIHwgMTUgKysrKysrKy0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9s
dHRuZy1jb25zdW1lcmQvbHR0bmctY29uc3VtZXJkLmMgYi9zcmMvYmluL2x0dG5nLWNvbnN1bWVy
ZC9sdHRuZy1jb25zdW1lcmQuYwo+IGluZGV4IGZlZjAzYzZmLi5jMDcxNmFmMiAxMDA2NDQKPiAt
LS0gYS9zcmMvYmluL2x0dG5nLWNvbnN1bWVyZC9sdHRuZy1jb25zdW1lcmQuYwo+ICsrKyBiL3Ny
Yy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZC5jCj4gQEAgLTU3NiwxNCArNTc2
LDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ICAgICAgICAgICAgICAgICBQ
RVJST1IoInB0aHJlYWRfam9pbiBzZXNzaW9uZF90aHJlYWQiKTsKPiAgICAgICAgICAgICAgICAg
cmV0dmFsID0gLTE7Cj4gICAgICAgICB9Cj4gLQo+IC0gICAgICAgcmV0ID0gY29uc3VtZXJfdGlt
ZXJfdGhyZWFkX2dldF9jaGFubmVsX21vbml0b3JfcGlwZSgpOwo+IC0gICAgICAgaWYgKHJldCA+
PSAwKSB7Cj4gLSAgICAgICAgICAgICAgIHJldCA9IGNsb3NlKHJldCk7Cj4gLSAgICAgICAgICAg
ICAgIGlmIChyZXQpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBQRVJST1IoImNsb3NlIGNo
YW5uZWwgbW9uaXRvciBwaXBlIik7Cj4gLSAgICAgICAgICAgICAgIH0KPiAtICAgICAgIH0KPiAg
ZXhpdF9zZXNzaW9uZF90aHJlYWQ6Cj4KPiAgICAgICAgIHJldCA9IHB0aHJlYWRfam9pbihkYXRh
X3RocmVhZCwgJnN0YXR1cyk7Cj4gQEAgLTY1MCw2ICs2NDIsMTMgQEAgZXhpdF9pbml0X2RhdGE6
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgUEVSUk9SKCJwdGhyZWFkX2pvaW4gbWV0YWRhdGFf
dGltZXJfdGhyZWFkIik7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dmFsID0gLTE7Cj4g
ICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgcmV0ID0gY29uc3VtZXJfdGltZXJf
dGhyZWFkX2dldF9jaGFubmVsX21vbml0b3JfcGlwZSgpOwo+ICsgICAgICAgICAgICAgICBpZiAo
cmV0ID49IDApIHsKPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBjbG9zZShyZXQpOwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpIHsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBFUlJPUigiY2xvc2UgY2hhbm5lbCBtb25pdG9yIHBpcGUiKTsKPiArICAg
ICAgICAgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAg
ICAgbWV0YWRhdGFfdGltZXJfdGhyZWFkX29ubGluZSA9IGZhbHNlOwo+ICAgICAgICAgfQo+ICAg
ICAgICAgdG1wX2N0eCA9IGN0eDsKPiAtLQo+IDIuMTEuMAo+CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
