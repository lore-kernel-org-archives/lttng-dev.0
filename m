From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Always choose large event
 header for UST channels
Date: Tue, 30 Oct 2018 13:46:52 +0100
Message-ID: <CA+jJMxsBz8B5=vtOb4CqWjTCjm-CPaa-+vSUxTg9nRMROxkpww__33594.8664848276$1540903533$gmane$org@mail.gmail.com>
References: <20181017211612.3300-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42krpV65GMzpXR
 for <lttng-dev@lists.lttng.org>; Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 948B6246D30
 for <lttng-dev@lists.lttng.org>; Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id nlpYEfUWO8OP for <lttng-dev@lists.lttng.org>;
 Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5A37E246D2A
 for <lttng-dev@lists.lttng.org>; Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id yHV6PD3xiyZD for <lttng-dev@lists.lttng.org>;
 Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id 0598D246D1B
 for <lttng-dev@lists.lttng.org>; Tue, 30 Oct 2018 08:47:30 -0400 (EDT)
Received: by mail-lf1-f49.google.com with SMTP id m18-v6so8733889lfl.11
 for <lttng-dev@lists.lttng.org>; Tue, 30 Oct 2018 05:47:29 -0700 (PDT)
In-Reply-To: <20181017211612.3300-1-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwIGFuZCBzdGFibGUtMi45
LgoKVGhhbmtzIQpKw6lyw6ltaWUKT24gV2VkLCAxNyBPY3QgMjAxOCBhdCAyMzoxNiwgTWF0aGll
dSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBV
U1QgY2FuIHJlY2VpdmUgdGhlIHNlc3Npb24gc3RhcnQgY29tbWFuZCBiZWZvcmUgYWxsIHByb2Jl
IHByb3ZpZGVyCj4gbGlicmFyeSBjb25zdHJ1Y3RvcnMgaGF2ZSBjb21wbGV0ZWQgcnVubmluZywg
dGhlcmVmb3JlIGZpbmRpbmcgbGVzcwo+IGV2ZW50cyB0aGFuIGV2ZW50dWFsbHkgZW5hYmxlZCB3
aXRoaW4gdGhlIHByb2Nlc3MuIE1vcmVvdmVyLCB3aXRoCj4gcGVyLXVpZCBidWZmZXJzLCBtYW55
IHByb2Nlc3NlcyBlbmQgdXAgcmVnaXN0ZXJpbmcgZXZlbnRzIGludG8gc2hhcmVkCj4gYnVmZmVy
cy4gVGhlcmVmb3JlLCB0aGUgZ3Vlc3MgYmFzZWQgb24gbnVtYmVyIG9mIGV2ZW50cyBmcm9tIHRo
ZSBmaXJzdAo+IHByb2Nlc3MgdG8gdXNlIHRoZSBidWZmZXIgaXMgaW5jb3JyZWN0Lgo+Cj4gQ29u
c2lkZXJpbmcgdGhhdCB3ZSB0eXBpY2FsbHkgaGF2ZSBhcHBsaWNhdGlvbnMgd2l0aCBtb3JlIHRo
YW4gMzAKPiBldmVudHMsIHdlIHdpbGwgbW9kaWZ5IHRoZSBzZXNzaW9uIGRhZW1vbiBzbyBpdCBz
ZWxlY3RzIHRoZSAibGFyZ2UiCj4gaGVhZGVyIHR5cGUgaW5kZXBlbmRlbnRseSBvZiB0aGUgbnVt
YmVyIG9mIGV2ZW50cy4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvdXN0LWFwcC5jIHwgMTUgKysrKysrKy0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC91c3QtYXBwLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwo+
IGluZGV4IDJhODEwYWJhLi5hMTMzZWVlZSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNl
c3Npb25kL3VzdC1hcHAuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5j
Cj4gQEAgLTU0MjksNyArNTQyOSw3IEBAIHN0YXRpYyBpbnQgcmVwbHlfdXN0X3JlZ2lzdGVyX2No
YW5uZWwoaW50IHNvY2ssIGludCBjb2JqZCwKPiAgICAgICAgICAgICAgICAgc2l6ZV90IG5yX2Zp
ZWxkcywgc3RydWN0IHVzdGN0bF9maWVsZCAqZmllbGRzKQo+ICB7Cj4gICAgICAgICBpbnQgcmV0
LCByZXRfY29kZSA9IDA7Cj4gLSAgICAgICB1aW50MzJfdCBjaGFuX2lkLCByZWdfY291bnQ7Cj4g
KyAgICAgICB1aW50MzJfdCBjaGFuX2lkOwo+ICAgICAgICAgdWludDY0X3QgY2hhbl9yZWdfa2V5
Owo+ICAgICAgICAgZW51bSB1c3RjdGxfY2hhbm5lbF9oZWFkZXIgdHlwZTsKPiAgICAgICAgIHN0
cnVjdCB1c3RfYXBwICphcHA7Cj4gQEAgLTU0ODEsMTMgKzU0ODEsMTIgQEAgc3RhdGljIGludCBy
ZXBseV91c3RfcmVnaXN0ZXJfY2hhbm5lbChpbnQgc29jaywgaW50IGNvYmpkLAo+ICAgICAgICAg
YXNzZXJ0KGNoYW5fcmVnKTsKPgo+ICAgICAgICAgaWYgKCFjaGFuX3JlZy0+cmVnaXN0ZXJfZG9u
ZSkgewo+IC0gICAgICAgICAgICAgICByZWdfY291bnQgPSB1c3RfcmVnaXN0cnlfZ2V0X2V2ZW50
X2NvdW50KGNoYW5fcmVnKTsKPiAtICAgICAgICAgICAgICAgaWYgKHJlZ19jb3VudCA8IDMxKSB7
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHlwZSA9IFVTVENUTF9DSEFOTkVMX0hFQURFUl9D
T01QQUNUOwo+IC0gICAgICAgICAgICAgICB9IGVsc2Ugewo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHR5cGUgPSBVU1RDVExfQ0hBTk5FTF9IRUFERVJfTEFSR0U7Cj4gLSAgICAgICAgICAgICAg
IH0KPiAtCj4gKyAgICAgICAgICAgICAgIC8qCj4gKyAgICAgICAgICAgICAgICAqIFRPRE86IGV2
ZW50dWFsbHkgdXNlIHRoZSByZWdpc3RyeSBldmVudCBjb3VudCBmb3IKPiArICAgICAgICAgICAg
ICAgICogdGhpcyBjaGFubmVsIHRvIGJldHRlciBndWVzcyBoZWFkZXIgdHlwZSBmb3IgcGVyLXBp
ZAo+ICsgICAgICAgICAgICAgICAgKiBidWZmZXJzLgo+ICsgICAgICAgICAgICAgICAgKi8KPiAr
ICAgICAgICAgICAgICAgdHlwZSA9IFVTVENUTF9DSEFOTkVMX0hFQURFUl9MQVJHRTsKPiAgICAg
ICAgICAgICAgICAgY2hhbl9yZWctPm5yX2N0eF9maWVsZHMgPSBucl9maWVsZHM7Cj4gICAgICAg
ICAgICAgICAgIGNoYW5fcmVnLT5jdHhfZmllbGRzID0gZmllbGRzOwo+ICAgICAgICAgICAgICAg
ICBmaWVsZHMgPSBOVUxMOwo+IC0tCj4gMi4xMS4wCj4KCgotLQpKw6lyw6ltaWUgR2FsYXJuZWF1
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
