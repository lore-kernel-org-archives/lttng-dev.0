From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: remove logically dead code
	in send_channel_uid_to_ust
Date: Wed, 18 May 2016 16:07:49 -0400
Message-ID: <CA+jJMxubD-p8KYmC5jJ+7a49Z--3rpHqiZNmey6wfs5qSXgFSQ__7365.13139349899$1463602091$gmane$org@mail.gmail.com>
References: <1463502683-14057-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BB30BA35B9
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 20:07:50 +0000 (UTC)
Received: by mail-qk0-f196.google.com with SMTP id n62so4913843qkc.2
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 13:07:50 -0700 (PDT)
In-Reply-To: <1463502683-14057-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDEyOjMx
IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBGb3VuZCBieSBDb3Zlcml0eToKPgo+IGF0X21vc3Q6IEF0IGNvbmRpdGlvbiByZXQg
PCAwLCB0aGUgdmFsdWUgb2YgcmV0IG11c3QgYmUgYXQgbW9zdCAtMS4KPiAgICAgY2Fubm90X3Nl
dDogQXQgY29uZGl0aW9uIHJldCA8IDAsIHRoZSB2YWx1ZSBvZiByZXQgY2Fubm90IGJlIGVxdWFs
Cj4gdG8gYW55IG9mIHstMTAzMCwgLTMyfS4KPiAgICAgZGVhZF9lcnJvcl9jb25kaXRpb246IFRo
ZSBjb25kaXRpb24gcmV0IDwgMCBtdXN0IGJlIHRydWUuCj4gMjgyNSAgICAgICAgICAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAocmV0IDwgMCkgewo+IDI4MjYgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyb3Jfc3RyZWFtX3VubG9jazsKPiAyODI3ICAgICAgICAgICAgICAg
ICAgICAgICAgfQo+ICAgICBDSUQgMTMyMzEzNSAoIzEgb2YgMSk6IExvZ2ljYWxseSBkZWFkIGNv
ZGUKPiAoREVBRENPREUpZGVhZF9lcnJvcl9saW5lOiBFeGVjdXRpb24gY2Fubm90IHJlYWNoIHRo
aXMgc3RhdGVtZW50OiBnb3RvCj4gZXJyb3Jfc3RyZWFtX3VubG9jazsuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+
IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYyB8IDIgLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC91c3QtYXBwLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwo+IGlu
ZGV4IDFiYjE4M2QuLjQ4YjFhZGMgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC91c3QtYXBwLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwo+IEBA
IC0yODIyLDggKzI4MjIsNiBAQCBzdGF0aWMgaW50IHNlbmRfY2hhbm5lbF91aWRfdG9fdXN0KHN0
cnVjdCBidWZmZXJfcmVnX2NoYW5uZWwgKnJlZ19jaGFuLAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChyZXQgPT0gLUVQSVBFIHx8IHJldCA9PSAtTFRUTkdfVVNUX0VSUl9FWElUSU5HKSB7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PVENPTk47IC8qIENh
dXNlZCBieSBhcHAgZXhpdGluZy4gKi8KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyb3Jfc3RyZWFtX3VubG9jazsKPiAtICAgICAgICAgICAgICAgICAgICAgICB9IGVs
c2UgaWYgKHJldCA8IDApIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyb3Jfc3RyZWFtX3VubG9jazsKPiAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4gICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9zdHJlYW1fdW5sb2NrOwo+ICAgICAgICAgICAg
ICAgICB9Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
