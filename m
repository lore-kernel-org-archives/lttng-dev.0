From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Mon, 25 Mar 2019 11:10:23 -0400
Message-ID: <CA+jJMxsbA0ksOJN9yqbtCVXkTLKOqfEMek6P9_bxSdKH75zEPQ__20570.5499205337$1553526917$gmane$org@mail.gmail.com>
References: <20190321150453.7312-1-ylamarre@efficios.com>
 <20190321150453.7312-6-ylamarre@efficios.com>
 <CA+jJMxui0_5EF6XLH-9G90-yJEE63zdiBifTeF4i9iQp95D7tg@mail.gmail.com>
 <8703543.6154.1553267076349.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Sd4r6PSNz18P4
 for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2019 11:11:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CF67C1C9067
 for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2019 11:11:01 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id sRsbN87W-OZL for <lttng-dev@lists.lttng.org>;
 Mon, 25 Mar 2019 11:11:01 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3E97F1C905B
 for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2019 11:11:01 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id x88ZNK3XLllL for <lttng-dev@lists.lttng.org>;
 Mon, 25 Mar 2019 11:11:01 -0400 (EDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mail.efficios.com (Postfix) with ESMTPSA id DC3701C9048
 for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2019 11:11:00 -0400 (EDT)
Received: by mail-lf1-f50.google.com with SMTP id m13so6266199lfb.6
 for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2019 08:11:00 -0700 (PDT)
In-Reply-To: <8703543.6154.1553267076349.JavaMail.zimbra@efficios.com>
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

T24gRnJpLCAyMiBNYXIgMjAxOSBhdCAxMTowNCwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUu
ZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiAtLS0tLSBPbiBNYXIgMjEsIDIwMTks
IGF0IDQ6MjUgUE0sIEplcmVtaWUgR2FsYXJuZWF1IGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9z
LmNvbSB3cm90ZToKPgo+IFsuLi5dCj4gPj4gKyAgICAgICAgICAgICAgIGFzc2VydChpZHggPCBl
dmVudHMtPndhaXQubmJfZmQpOwo+ID4KPiA+IE5vdCBuZWVkZWQuIFVzaW5nIGFzc2VydCgpIGlz
IGZpbmUgdG8gaGlnaGxpZ2h0IGFzc3VtcHRpb25zIGFjcm9zcwo+ID4gaW50ZXJmYWNlcy9mdW5j
dGlvbnMgYW5kL29yIGNhdGNoIGNhdGFzdHJvcGhpYyBpbnRlcm5hbCBlcnJvcnMuIEhlcmUsCj4g
PiB0aGlzIHdvdWxkIGJlIGEgdmVyeSBsb2NhbCBjb25kaXRpb24gdGhhdCBzZWVtcyB0byBiZSBh
bHJlYWR5Cj4gPiBlbmZvcmNlZC4KPiA+Cj4gPiBSZXdvcmtpbmcgdGhlICdmb3InIGNvbmRpdGlv
biB0byB1c2UgJ2kgPCBldmVudHMtPndhaXQubmJfZmQnIGFuZAo+ID4gYnJlYWtpbmcgb3V0IGVh
cmx5IG9mIHRoZSBsb29wIGlzIGFsc28gYW4gb3B0aW9uIGhlcmUuCj4KPiBUaGUgcmVhc29uIGZv
ciB1c2luZyBhc3NlcnQoKSBoZXJlIGlzIHRvIGVuc3VyZSB0aGF0IHRoZXJlIGlzIG5vIGRpc2Ny
ZXBhbmN5Cj4gYmV0d2VlbiB0aGUgbnVtYmVyIG9mIGFjdGl2ZSBwb2xsIGZkIGluIHRoZSBzZXQg
YW5kIHRoZSB2YWx1ZSByZXR1cm5lZCBieQo+IHBvbGwgaW5kaWNhdGluZyB0aGF0IHNhbWUgbnVt
YmVyIG9mIGFjdGl2ZSBmZHMuCj4KPiBXZSdkIG5lZWQgYSBrZXJuZWwgYnVnIChvciBtZW1vcnkg
Y29ycnVwdGlvbikgdG8gaGF2ZSBhIG1pc21hdGNoLCBidXQgSSB0aG91Z2h0Cj4gaGF2aW5nIGFu
IGFzc2VydCBpbiB0aGVyZSB3b3VsZCBub3QgaHVydCwgc2luY2UgaXQgbWlnaHQgaGVscCBkaWFn
bm9zZSBpc3N1ZXMKPiB0aGF0IGNyb3NzIHVzZXIta2VybmVsIGJvdW5kYXJpZXMuCj4KPiBUaG91
Z2h0cyA/CgpIaSwKCkkgdW5kZXJzdGFuZCB0aGUgaW50ZW50LCBidXQgSSBkb24ndCBmZWVsIHRo
ZXNlIHR5cGUgb2Yga2VybmVsIHRlc3RzL2NoZWNrcwpiZWxvbmcgaW4gdGhlIGNvZGUuCgpIb3dl
dmVyLCBpZiB0aGVyZSBpcyBhIHNwZWNpZmljIGNvbmNlcm4gdGhhdCBvdXIgdXNlIG9mIHBvbGwo
KSBjb3VsZCBoaWdobGlnaHQKdGhpcyB0eXBlIG9mIGJ1ZyAoaW4gdGhlIGtlcm5lbCBvciBpbiB0
aGUgaW50ZXJhY3Rpb25zIHdpdGggbHR0bmctbW9kdWxlcyksCndlIGNhbiBhZGQgdGVzdHMgZm9y
IHRoYXQuCgpUaGFua3MsCkrDqXLDqW1pZQoKPgo+IE1hdGhpZXUKPgo+IC0tCj4gTWF0aGlldSBE
ZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4gaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCgotLQpK
w6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
