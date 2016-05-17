From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: insecure data handling
Date: Tue, 17 May 2016 15:34:07 -0400
Message-ID: <CA+jJMxuDLSgp0UK5zfqtgft5mopDMB=56r2W=TBux6u6O5eNbA__48173.9556453705$1463513662$gmane$org@mail.gmail.com>
References: <1463456169-12405-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f67.google.com (mail-qg0-f67.google.com
 [209.85.192.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 58424A02DB
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 19:34:09 +0000 (UTC)
Received: by mail-qg0-f67.google.com with SMTP id e35so2290137qge.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 12:34:09 -0700 (PDT)
In-Reply-To: <1463456169-12405-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Rml4ZWQgYnk6Cgpjb21taXQgMDJkOGFjM2RhZjE4MWRjOGIwN2JmMjA2ZThjZDg1NWU3NGUzZmNk
OApBdXRob3I6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgpEYXRlOiAg
IFR1ZSBNYXkgMTcgMTQ6MTI6MDkgMjAxNiAtMDQwMAoKICAgIEZpeDogRnJlZSB2YXJpYWJsZSBi
ZWZvcmUgc3RyZHVwKCkgaW4gcHJvY2Vzc19ldmVudF9ub2RlCgogICAgRml4ZXMgY292ZXJpdHkg
IzEyNDMwNDAKCiAgICBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVm
ZmljaW9zLmNvbT4KICAgIFNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVt
aWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KCgpUaGFua3MsCkrDqXLDqW1pZQoKT24gTW9uLCBN
YXkgMTYsIDIwMTYgYXQgMTE6MzYgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25v
eWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IEZvdW5kIGJ5IENvdmVyaXR5Ogo+Cj4gQ0lEIDEz
NTM0NjIgKCMxIG9mIDEpOiBVc2Ugb2YgdW50cnVzdGVkIHN0cmluZyB2YWx1ZSAoVEFJTlRFRF9T
VFJJTkcpNS4KPiB0YWludGVkX3N0cmluZzogUGFzc2luZyB0YWludGVkIHN0cmluZyBtYW5fYmlu
X3BhdGggdG8gZXhlY2xwLCB3aGljaAo+IGNhbm5vdCBhY2NlcHQgdGFpbnRlZCBkYXRhLgo+Cj4g
U2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbT4KPiAtLS0KPiAgc3JjL2NvbW1vbi91dGlscy5jIHwgMyArKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Ny
Yy9jb21tb24vdXRpbHMuYyBiL3NyYy9jb21tb24vdXRpbHMuYwo+IGluZGV4IGRmNTVkYzkuLmI2
YjQ1ZTMgMTAwNjQ0Cj4gLS0tIGEvc3JjL2NvbW1vbi91dGlscy5jCj4gKysrIGIvc3JjL2NvbW1v
bi91dGlscy5jCj4gQEAgLTEzNDcsNyArMTM0Nyw4IEBAIGVuZDoKPgo+ICBzdGF0aWMgY29uc3Qg
Y2hhciAqZ2V0X21hbl9iaW5fcGF0aCh2b2lkKQo+ICB7Cj4gLSAgICAgICBjaGFyICplbnZfbWFu
X3BhdGggPSBnZXRlbnYoREVGQVVMVF9NQU5fQklOX1BBVEhfRU5WKTsKPiArICAgICAgIGNoYXIg
KmVudl9tYW5fcGF0aCA9Cj4gKyAgICAgICAgICAgICAgIGx0dG5nX3NlY3VyZV9nZXRlbnYoREVG
QVVMVF9NQU5fQklOX1BBVEhfRU5WKTsKPgo+ICAgICAgICAgaWYgKGVudl9tYW5fcGF0aCkgewo+
ICAgICAgICAgICAgICAgICByZXR1cm4gZW52X21hbl9wYXRoOwo+IC0tCj4gMi4xLjQKPgoKCgot
LSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3Mu
Y29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
