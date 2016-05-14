From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 0/5] Fix: static build make
	check/long reg/distcheck
Date: Sat, 14 May 2016 16:57:09 -0400
Message-ID: <CA+jJMxvbe9MhhZYFZfJ6D0zPvL4sr4C3ANYSRUbiMKGLU+nRGA__18567.4096960158$1463259464$gmane$org@mail.gmail.com>
References: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id BABDFA34C5
 for <lttng-dev@lists.lttng.org>; Sat, 14 May 2016 20:57:10 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id n62so4817807qkc.2
 for <lttng-dev@lists.lttng.org>; Sat, 14 May 2016 13:57:10 -0700 (PDT)
In-Reply-To: <1463083727-15190-1-git-send-email-mathieu.desnoyers@efficios.com>
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

QWxsIGZpdmUgcGF0Y2hlcyBtZXJnZWQgaW4gbWFzdGVyIGFuZCBzdGFibGUtMi44LCB0aGFua3Mh
CgpKw6lyw6ltaWUKCk9uIFRodSwgTWF5IDEyLCAyMDE2IGF0IDQ6MDggUE0sIE1hdGhpZXUgRGVz
bm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IE1hdGhpZXUg
RGVzbm95ZXJzICg1KToKPiAgIEZpeDogdGVzdHM6IGRvbid0IGJ1aWxkIGR5bmFtaWMgbGliIHRl
c3RzIGlmIHN1cHBvcnQgZGlzYWJsZWQKPiAgIEZpeDogdGVzdHM6IHNraXAgdGVzdHMgb24gc3Rh
dGljIGJ1aWxkCj4gICBGaXg6IHRlc3RzOiBkb24ndCBtYXRjaCBjb21tYW5kIGxpbmUgYXJndW1l
bnRzLCBtYXRjaCBzdGF0aWMgYnVpbGQKPiAgICAgYmluYXJ5IG5hbWVzCj4gICBGaXg6IGNvbmZp
Z3VyZTogZm9yYmlkIFB5dGhvbiBiaW5kaW5ncyBpZiBzaGFyZWQgbGlicmFyaWVzIGFyZQo+ICAg
ICBkaXNhYmxlZAo+ICAgRml4OiBkaXN0Y2hlY2sgcmVxdWlyZXMgdGhhdCB3ZSBjbGVhbiB2ZXJz
aW9uLmgKPgo+ICBjb25maWd1cmUuYWMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxICsKPiAgaW5jbHVkZS9NYWtlZmlsZS5hbSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiArKwo+ICB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2hlYWx0aC9NYWtlZmls
ZS5hbSAgICAgICAgICB8IDIwICsrKysrKystLS0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xz
L2hlYWx0aC90ZXN0X2hlYWx0aC5zaCAgICAgICB8IDEyICsrKysrLS0tCj4gIHRlc3RzL3JlZ3Jl
c3Npb24vdXN0L2Nsb2NrLW92ZXJyaWRlL01ha2VmaWxlLmFtICAgIHwgMTMgKysrKysrKysKPiAg
Li4uL3VzdC9jbG9jay1vdmVycmlkZS90ZXN0X2Nsb2NrX292ZXJyaWRlICAgICAgICAgfCAxMiAr
KysrKy0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3VzdC9nZXRjcHUtb3ZlcnJpZGUvTWFrZWZpbGUu
YW0gICB8IDE0ICsrKysrKysrKwo+ICAuLi4vdXN0L2dldGNwdS1vdmVycmlkZS90ZXN0X2dldGNw
dV9vdmVycmlkZSAgICAgICB8IDEyICsrKysrLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vdXN0L2xp
bmtpbmcvTWFrZWZpbGUuYW0gICAgICAgICAgIHwgMjAgKysrKysrKystLS0tCj4gIHRlc3RzL3Jl
Z3Jlc3Npb24vdXN0L292ZXJsYXAvZGVtby9NYWtlZmlsZS5hbSAgICAgIHwgMTIgKysrKysrKy0K
PiAgdGVzdHMvcmVncmVzc2lvbi91c3Qvb3ZlcmxhcC90ZXN0X292ZXJsYXAgICAgICAgICAgfCAx
MiArKysrKy0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3VzdC91c3QtZGwvTWFrZWZpbGUuYW0gICAg
ICAgICAgICB8IDE5ICsrKysrKysrKystLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3VzdC91c3QtZGwv
dGVzdF91c3QtZGwgICAgICAgICAgICB8ICA1ICsrKwo+ICB0ZXN0cy91dGlscy91dGlscy5zaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDM2ICsrKysrKysrKysrKy0tLS0tLS0tLS0K
PiAgMTQgZmlsZXMgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQo+
Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4K
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
