From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 0/4] Allow discard buffers in
	snapshot sessions
Date: Tue, 7 Jun 2016 09:46:43 -0400
Message-ID: <CA+jJMxs32OjL1BsDj8FJH+o9GR6zPbc2X35ofDsi4EHk7psxhg__21239.6579249345$1465307229$gmane$org@mail.gmail.com>
References: <1461165600-17288-1-git-send-email-mathieu.desnoyers@efficios.com>
 <577218297.30283.1465295889296.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3C11BA376B
 for <lttng-dev@lists.lttng.org>; Tue,  7 Jun 2016 13:46:45 +0000 (UTC)
Received: by mail-qt0-f193.google.com with SMTP id 72so1645536qtb.0
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jun 2016 06:46:45 -0700 (PDT)
In-Reply-To: <577218297.30283.1465295889296.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBKdW4gNywgMjAxNiBhdCA2OjM4IEFNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBCdW1wLiBKdXN0IGEgcmVtaW5kZXIg
YWJvdXQgdGhpcyBwYXRjaCBzZXJpZXMuCgpFLW1haWwgY2xpZW50IHN0aWxsIHdvcmtzLCBubyB3
b3JyaWVzLgoKSsOpcsOpbWllCgo+Cj4gVGhhbmtzLAo+Cj4gTWF0aGlldQo+Cj4gLS0tLS0gT24g
QXByIDIwLCAyMDE2LCBhdCAxMToxOSBBTSwgTWF0aGlldSBEZXNub3llcnMgbWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tIHdyb3RlOgo+Cj4+IFRoaXMgcGF0Y2hzZXQgYWxsb3dzIHVzZXJz
IHRvIG92ZXJyaWRlIHRoZSBjaGFubmVsIG1vZGUKPj4gKGRpc2NhcmQvb3ZlcndyaXRlKSBmb3Ig
c25hcHNob3Qgc2Vzc2lvbnMgZm9yIGJvdGggbHR0bmctdXN0IGFuZCBsdHRuZwo+PiBrZXJuZWwg
dHJhY2luZy4gUHJldmlvdXNseSwgc25hcHNob3Qgc2Vzc2lvbnMgd2VyZSBlbmZvcmNpbmcgb3Zl
cndyaXRlCj4+IGJ1ZmZlciB0eXBlcy4KPj4KPj4gVGhhbmtzLAo+Pgo+PiBNYXRoaWV1Cj4+Cj4+
IE1hdGhpZXUgRGVzbm95ZXJzICg0KToKPj4gIEZpeDogdmFsaWRhdGUgbnVtYmVyIG9mIHN1YmJ1
ZmZlcnMgYWZ0ZXIgdHdlYWtpbmcgcHJvcGVydGllcwo+PiAgQWxsb3cgY2hhbm5lbCBtb2RlIG92
ZXJyaWRlIGluIHNuYXBzaG90IHNlc3Npb25zCj4+ICB0ZXN0czogdGVzdCBrZXJuZWwgc25hcHNo
b3Qgd2l0aCBkaXNjYXJkIGJ1ZmZlcnMKPj4gIHRlc3RzOiB0ZXN0IHVzdCBzbmFwc2hvdCB3aXRo
IGRpc2NhcmQgYnVmZmVycwo+Pgo+PiBpbmNsdWRlL2x0dG5nL2NoYW5uZWwuaCAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMiArLQo+PiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NoYW5uZWwuYyAg
ICAgICAgICAgICB8ICA1NSArKysrKysrKystCj4+IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21k
LmMgICAgICAgICAgICAgICAgIHwgIDEwIC0tCj4+IHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvY3Jl
YXRlLmMgICAgICAgICAgICAgIHwgICAyICstCj4+IHNyYy9jb21tb24vZGVmYXVsdHMuaCAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4+IHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc25h
cHNob3RzL3Rlc3Rfa2VybmVsIHwgIDk0ICsrKysrKysrKysrKysrKystCj4+IHRlc3RzL3JlZ3Jl
c3Npb24vdG9vbHMvc25hcHNob3RzL3VzdF90ZXN0ICAgIHwgMTUwICsrKysrKysrKysrKysrKysr
KysrKysrKysrLQo+PiB0ZXN0cy91dGlscy91dGlscy5zaCAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAzMCArKysrKysKPj4gOCBmaWxlcyBjaGFuZ2VkLCAzMjEgaW5zZXJ0aW9ucygrKSwgMjQg
ZGVsZXRpb25zKC0pCj4+Cj4+IC0tCj4+IDIuMS40Cj4KPiAtLQo+IE1hdGhpZXUgRGVzbm95ZXJz
Cj4gRWZmaWNpT1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgoKCi0tIApKw6lyw6lt
aWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
