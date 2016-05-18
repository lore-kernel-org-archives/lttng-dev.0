From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: unchecked return value in
	trace_clock_read64_monotonic
Date: Wed, 18 May 2016 15:23:53 -0400
Message-ID: <CA+jJMxsHOcee9dqEzKc+=QTnCD6Fmehde-ncxq-_gK-FteW_Tg__11445.9272045226$1463599447$gmane$org@mail.gmail.com>
References: <1463501205-5249-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 71234A35B0
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:23:54 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id z70so158706qge.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 12:23:54 -0700 (PDT)
In-Reply-To: <1463501205-5249-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCBidXQgSSBhbHNvIGFkZGVkIGEgUEVSUk9SKCkgYW5kIGEgVE9ETyB0byByZXBvcnQg
dGhpcyBlcnJvciB1cAp0aGUgY2FsbGVyIGNoYWluLgoKVGhhbmtzLApKw6lyw6ltaWUKCk9uIFR1
ZSwgTWF5IDE3LCAyMDE2IGF0IDEyOjA2IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBGb3VuZCBieSBDb3Zlcml0eToKPgo+IENJ
RCAxMzExNDk4ICgjMSBvZiAxKTogVW5jaGVja2VkIHJldHVybiB2YWx1ZSAoQ0hFQ0tFRF9SRVRV
Uk4pMS4KPiBjaGVja19yZXR1cm46IENhbGxpbmcgY2xvY2tfZ2V0dGltZSB3aXRob3V0IGNoZWNr
aW5nIHJldHVybiB2YWx1ZSAoYXMgaXMKPiBkb25lIGVsc2V3aGVyZSA4IG91dCBvZiA5IHRpbWVz
KS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVy
c0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWNsb2Nr
LmggfCA1ICsrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1jbG9jay5o
IGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtY2xvY2suaAo+IGluZGV4IDg0OTM3MzcuLjE0
YmE3MWMgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtY2xvY2suaAo+
ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWNsb2NrLmgKPiBAQCAtNTcsNyArNTcs
MTAgQEAgdWludDY0X3QgdHJhY2VfY2xvY2tfcmVhZDY0X21vbm90b25pYyh2b2lkKQo+ICB7Cj4g
ICAgICAgICBzdHJ1Y3QgdGltZXNwZWMgdHM7Cj4KPiAtICAgICAgIGNsb2NrX2dldHRpbWUoQ0xP
Q0tfTU9OT1RPTklDLCAmdHMpOwo+ICsgICAgICAgaWYgKGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9O
T1RPTklDLCAmdHMpKSB7Cj4gKyAgICAgICAgICAgICAgIHRzLnR2X3NlYyA9IDA7Cj4gKyAgICAg
ICAgICAgICAgIHRzLnR2X25zZWMgPSAwOwo+ICsgICAgICAgfQo+ICAgICAgICAgcmV0dXJuICgo
dWludDY0X3QpIHRzLnR2X3NlYyAqIDEwMDAwMDAwMDBVTEwpICsgdHMudHZfbnNlYzsKPiAgfQo+
Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4K
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
