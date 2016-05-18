From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: unchecked return value in
	low throughput test
Date: Wed, 18 May 2016 16:07:35 -0400
Message-ID: <CA+jJMxs2RNo4NK8J1vjku5bo28hr6=Nx4w72UacyETokFK0gLQ__5811.91777387193$1463602075$gmane$org@mail.gmail.com>
References: <1463502164-11198-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id AB516A35B9
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 20:07:36 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id l68so5357558qkf.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 13:07:36 -0700 (PDT)
In-Reply-To: <1463502164-11198-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6lybWllCgpPbiBUdWUsIE1heSAxNywgMjAxNiBhdCAxMjoy
MiBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4g
d3JvdGU6Cj4gRm91bmQgYnkgQ292ZXJpdHk6Cj4KPiBDSUQgMTAxOTk2NyAoIzEgb2YgMSk6IFVu
Y2hlY2tlZCByZXR1cm4gdmFsdWUgZnJvbSBsaWJyYXJ5Cj4gKENIRUNLRURfUkVUVVJOKTIuIGNo
ZWNrX3JldHVybjogQ2FsbGluZyBwb2xsKE5VTEwsIDBVTCwgNjAwMDApIHdpdGhvdXQKPiBjaGVj
a2luZyByZXR1cm4gdmFsdWUuIFRoaXMgbGlicmFyeSBmdW5jdGlvbiBtYXkgZmFpbCBhbmQgcmV0
dXJuIGFuCj4gZXJyb3IgY29kZS4KPgo+IFdlIHJlYWxseSBkb24ndCBjYXJlIHdoZXRoZXIgdGhp
cyBwb2xsIHN1Y2NlZWRzIG9yIG5vdC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95
ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jl
c3Npb24vdXN0L2xvdy10aHJvdWdocHV0L21haW4uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcmVn
cmVzc2lvbi91c3QvbG93LXRocm91Z2hwdXQvbWFpbi5jIGIvdGVzdHMvcmVncmVzc2lvbi91c3Qv
bG93LXRocm91Z2hwdXQvbWFpbi5jCj4gaW5kZXggMDZhYjllZi4uYjFjMzhiYyAxMDA2NDQKPiAt
LS0gYS90ZXN0cy9yZWdyZXNzaW9uL3VzdC9sb3ctdGhyb3VnaHB1dC9tYWluLmMKPiArKysgYi90
ZXN0cy9yZWdyZXNzaW9uL3VzdC9sb3ctdGhyb3VnaHB1dC9tYWluLmMKPiBAQCAtMzQsNyArMzQs
NyBAQCBzdGF0aWMgdm9pZCAqdGhfZXZlbnRfbWludXRlKHZvaWQgKmRhdGEpCj4gICAgICAgICAv
KiBMb29wIGZvciAyMCBtaW51dGVzICovCj4gICAgICAgICBmb3IgKGkgPSAxOyBpIDwgMjE7IGkr
Kykgewo+ICAgICAgICAgICAgICAgICAvKiBTbGVlcCA2MCBzZWNvbmRzICovCj4gLSAgICAgICAg
ICAgICAgIHBvbGwoTlVMTCwgMCwgNjAwMDApOwo+ICsgICAgICAgICAgICAgICAodm9pZCkgcG9s
bChOVUxMLCAwLCA2MDAwMCk7Cj4KPiAgICAgICAgICAgICAgICAgLyogMjAgbWludXRlcyB0cmFj
ZXBvaW50ICovCj4gICAgICAgICAgICAgICAgIGlmICgoaSAlIDIwKSA9PSAwKSB7Cj4gLS0KPiAy
LjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
