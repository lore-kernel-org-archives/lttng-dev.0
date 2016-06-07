From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 0/4] Allow discard buffers in
 snapshot sessions
Date: Tue, 7 Jun 2016 10:38:09 +0000 (UTC)
Message-ID: <577218297.30283.1465295889296.JavaMail.zimbra__14458.571552723$1465295916$gmane$org@efficios.com>
References: <1461165600-17288-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id F068AA36CC
 for <lttng-dev@lists.lttng.org>; Tue,  7 Jun 2016 10:38:13 +0000 (UTC)
In-Reply-To: <1461165600-17288-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

QnVtcC4gSnVzdCBhIHJlbWluZGVyIGFib3V0IHRoaXMgcGF0Y2ggc2VyaWVzLgoKVGhhbmtzLAoK
TWF0aGlldQoKLS0tLS0gT24gQXByIDIwLCAyMDE2LCBhdCAxMToxOSBBTSwgTWF0aGlldSBEZXNu
b3llcnMgbWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUaGlzIHBhdGNo
c2V0IGFsbG93cyB1c2VycyB0byBvdmVycmlkZSB0aGUgY2hhbm5lbCBtb2RlCj4gKGRpc2NhcmQv
b3ZlcndyaXRlKSBmb3Igc25hcHNob3Qgc2Vzc2lvbnMgZm9yIGJvdGggbHR0bmctdXN0IGFuZCBs
dHRuZwo+IGtlcm5lbCB0cmFjaW5nLiBQcmV2aW91c2x5LCBzbmFwc2hvdCBzZXNzaW9ucyB3ZXJl
IGVuZm9yY2luZyBvdmVyd3JpdGUKPiBidWZmZXIgdHlwZXMuCj4gCj4gVGhhbmtzLAo+IAo+IE1h
dGhpZXUKPiAKPiBNYXRoaWV1IERlc25veWVycyAoNCk6Cj4gIEZpeDogdmFsaWRhdGUgbnVtYmVy
IG9mIHN1YmJ1ZmZlcnMgYWZ0ZXIgdHdlYWtpbmcgcHJvcGVydGllcwo+ICBBbGxvdyBjaGFubmVs
IG1vZGUgb3ZlcnJpZGUgaW4gc25hcHNob3Qgc2Vzc2lvbnMKPiAgdGVzdHM6IHRlc3Qga2VybmVs
IHNuYXBzaG90IHdpdGggZGlzY2FyZCBidWZmZXJzCj4gIHRlc3RzOiB0ZXN0IHVzdCBzbmFwc2hv
dCB3aXRoIGRpc2NhcmQgYnVmZmVycwo+IAo+IGluY2x1ZGUvbHR0bmcvY2hhbm5lbC5oICAgICAg
ICAgICAgICAgICAgICAgIHwgICAyICstCj4gc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jaGFubmVs
LmMgICAgICAgICAgICAgfCAgNTUgKysrKysrKysrLQo+IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
Y21kLmMgICAgICAgICAgICAgICAgIHwgIDEwIC0tCj4gc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9j
cmVhdGUuYyAgICAgICAgICAgICAgfCAgIDIgKy0KPiBzcmMvY29tbW9uL2RlZmF1bHRzLmggICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+IHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc25h
cHNob3RzL3Rlc3Rfa2VybmVsIHwgIDk0ICsrKysrKysrKysrKysrKystCj4gdGVzdHMvcmVncmVz
c2lvbi90b29scy9zbmFwc2hvdHMvdXN0X3Rlc3QgICAgfCAxNTAgKysrKysrKysrKysrKysrKysr
KysrKysrKystCj4gdGVzdHMvdXRpbHMvdXRpbHMuc2ggICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMzAgKysrKysrCj4gOCBmaWxlcyBjaGFuZ2VkLCAzMjEgaW5zZXJ0aW9ucygrKSwgMjQgZGVs
ZXRpb25zKC0pCj4gCj4gLS0KPiAyLjEuNAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
