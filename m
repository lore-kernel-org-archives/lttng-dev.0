From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/3] Fix: Define MANPATH in
	config.h
Date: Tue, 14 Jun 2016 14:56:03 -0400
Message-ID: <CA+jJMxt1TEs_cySgRis4+=LX0n8yUS2uOs_RzY4WGu0pH5nniA__7363.22269444845$1465930592$gmane$org@mail.gmail.com>
References: <1465499493-29365-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4855FA385C
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 18:56:05 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id 78so5160674qgt.3
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 11:56:05 -0700 (PDT)
In-Reply-To: <1465499493-29365-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

QWxsIHRocmVlIHBhdGNoZXMgYXJlIG1lcmdlZCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBUaHUs
IEp1biA5LCAyMDE2IGF0IDM6MTEgUE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNp
b3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29u
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgY29uZmlndXJlLmFjICAgICAgICAgICB8IDIgKysKPiAg
c3JjL2NvbW1vbi9NYWtlZmlsZS5hbSB8IDMgKy0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBi
L2NvbmZpZ3VyZS5hYwo+IGluZGV4IGM5NGRhN2EuLmQ2MTQ5ZmUgMTAwNjQ0Cj4gLS0tIGEvY29u
ZmlndXJlLmFjCj4gKysrIGIvY29uZmlndXJlLmFjCj4gQEAgLTYyMSw2ICs2MjEsOCBAQCBhbmQg
aW5zdGFsbGluZyB0aGUgbWFuIHBhZ2VzLgo+ICBBTV9DT05ESVRJT05BTChbTUFOX1BBR0VTX09Q
VF0sIFt0ZXN0ICJ4JG1hbl9wYWdlc19vcHQiICE9ICJ4bm8iXSkKPiAgQU1fQ09ORElUSU9OQUwo
W0hBVkVfQVNDSUlET0NfWE1MVE9dLCBbdGVzdCAieCRoYXZlX2FzY2lpZG9jX3htbHRvIiA9ICJ4
eWVzIl0pCj4KPiArQUNfREVGSU5FX1VOUVVPVEVEKFtNQU5QQVRIXSwgWyJgZXZhbCBldmFsIGVj
aG8gJG1hbmRpcmAiXSwgW1BhdGggdG8gbWFuIHBhZ2VzLl0pCj4gKwo+ICAjIFB5dGhvbiBhZ2Vu
dCB0ZXN0Cj4gIFVTVF9QWVRIT05fQUdFTlQ9Imx0dG5ndXN0Igo+Cj4gZGlmZiAtLWdpdCBhL3Ny
Yy9jb21tb24vTWFrZWZpbGUuYW0gYi9zcmMvY29tbW9uL01ha2VmaWxlLmFtCj4gaW5kZXggMTkz
MDU3Yy4uODYzMzczMCAxMDA2NDQKPiAtLS0gYS9zcmMvY29tbW9uL01ha2VmaWxlLmFtCj4gKysr
IGIvc3JjL2NvbW1vbi9NYWtlZmlsZS5hbQo+IEBAIC0xLDUgKzEsNCBAQAo+IC1BTV9DUFBGTEFH
UyA9IC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIC1JJCh0b3Bfc3JjZGlyKS9zcmMgXAo+IC0gICAg
ICAgLURNQU5QQVRIPVwiIiQobWFuZGlyKSJcIgo+ICtBTV9DUFBGTEFHUyA9IC1JJCh0b3Bfc3Jj
ZGlyKS9pbmNsdWRlIC1JJCh0b3Bfc3JjZGlyKS9zcmMKPgo+ICBBVVRPTUFLRV9PUFRJT05TID0g
c3ViZGlyLW9iamVjdHMKPgo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVh
dQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
