From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: check for lttng-modules
 presence
Date: Mon, 1 Apr 2019 16:53:33 -0400
Message-ID: <CA+jJMxvXMaLHBiv-_gjxrN9+s4rkx=fzHYKZ67xpaFFR2Z8Diw__21835.086115037$1554152069$gmane$org@mail.gmail.com>
References: <20190325184939.24845-1-jonathan.rajotte-julien@efficios.com>
 <20190329181555.GB28162@gmail.com> <20190401202615.GA28595@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Y4MT6SJxz18Kr
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:54:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 05AC91C05AC
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:54:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id Ks3rP4mNGFI9 for <lttng-dev@lists.lttng.org>;
 Mon,  1 Apr 2019 16:54:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 718C51C05A1
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:54:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id 19du8iiFAC-O for <lttng-dev@lists.lttng.org>;
 Mon,  1 Apr 2019 16:54:12 -0400 (EDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by mail.efficios.com (Postfix) with ESMTPSA id 1F1BD1C0591
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:54:12 -0400 (EDT)
Received: by mail-lf1-f48.google.com with SMTP id r25so7309254lfn.13
 for <lttng-dev@lists.lttng.org>; Mon, 01 Apr 2019 13:54:12 -0700 (PDT)
In-Reply-To: <20190401202615.GA28595@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

RG9uZS4KClRoYW5rcyBhIGxvdCEKSsOpcsOpbWllCgpPbiBNb24sIDEgQXByIDIwMTkgYXQgMTY6
MjYsIEpvbmF0aGFuIFJham90dGUtSnVsaWVuCjxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiBGcmksIE1hciAyOSwgMjAxOSBhdCAwMjox
NTo1NlBNIC0wNDAwLCBKw6lyw6ltaWUgR2FsYXJuZWF1IHdyb3RlOgo+ID4gTWVyZ2VkIGluIG1h
c3Rlciwgc3RhYmxlLTIuMTEsIGFuZCBzdGFibGUtMi4xMC4KPgo+IE5vdGUgdGhhdCB0byBiZSB2
YWxpZCBvbiBzdGFibGUtMi4xMCB5b3Ugd2lsbCBhbHNvIGhhdmUgdG8gYmFja3BvcnQgYW5vdGhl
cgo+IHBhdGNoLiAyLjExIGlzIG9rYWkuCj4KPiA5YzhhMzk2NDk2YTI4NzAyNzMwMTkyYWUxZGVk
MDYxMDVjNTRjNWRjIG9uIG1hc3Rlci4KPgo+ID4KPiA+IFRoYW5rcyEKPiA+IErDqXLDqW1pZQo+
ID4KPiA+IE9uIE1vbiwgTWFyIDI1LCAyMDE5IGF0IDAyOjQ5OjM5UE0gLTA0MDAsIEpvbmF0aGFu
IFJham90dGUgd3JvdGU6Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpv
bmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICB0ZXN0
cy9yZWdyZXNzaW9uL3Rvb2xzL25vdGlmaWNhdGlvbi90ZXN0X25vdGlmaWNhdGlvbl9rZXJuZWwg
fCAxICsKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPgo+ID4gPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9ub3RpZmljYXRpb24vdGVzdF9ub3Rp
ZmljYXRpb25fa2VybmVsIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9ub3RpZmljYXRpb24vdGVz
dF9ub3RpZmljYXRpb25fa2VybmVsCj4gPiA+IGluZGV4IDZkN2YyNTZhZS4uZTczNjhkZjI2IDEw
MDc1NQo+ID4gPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL25vdGlmaWNhdGlvbi90ZXN0
X25vdGlmaWNhdGlvbl9rZXJuZWwKPiA+ID4gKysrIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9u
b3RpZmljYXRpb24vdGVzdF9ub3RpZmljYXRpb25fa2VybmVsCj4gPiA+IEBAIC0xMDgsNiArMTA4
LDcgQEAgZnVuY3Rpb24ga2VybmVsX3Rlc3QKPiA+ID4gIH0KPiA+ID4KPiA+ID4gIGlmIFsgIiQo
aWQgLXUpIiA9PSAiMCIgXTsgdGhlbgo+ID4gPiArICAgdmFsaWRhdGVfbHR0bmdfbW9kdWxlc19w
cmVzZW50Cj4gPiA+ICAgICBrZXJuZWxfdGVzdAo+ID4gPiAgZWxzZQo+ID4gPiAgICAgIyBLZXJu
ZWwgdGVzdHMgYXJlIHNraXBwZWQuCj4gPiA+IC0tCj4gPiA+IDIuMTcuMQo+ID4gPgo+Cj4gLS0K
PiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbgo+IEVmZmljaU9TCgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
