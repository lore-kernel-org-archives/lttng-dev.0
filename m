From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] [URCU] Allow forcing the use of sys
 membarrier
Date: Mon, 12 Sep 2016 15:05:01 +0000 (UTC)
Message-ID: <1661830054.13479.1473692701109.JavaMail.zimbra__49093.5507849374$1473693076$gmane$org@efficios.com>
References: <6667246e-6677-1a47-94b6-b469fdf558ff@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E6EB4A3AF4
 for <lttng-dev@lists.lttng.org>; Mon, 12 Sep 2016 15:11:33 +0000 (UTC)
In-Reply-To: <6667246e-6677-1a47-94b6-b469fdf558ff@free.fr>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Duncan Sands <duncan.sands@deepbluecap.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gU2VwIDYsIDIwMTYsIGF0IDk6MDcgQU0sIER1bmNhbiBTYW5kcyBkdW5jYW4uc2Fu
ZHNAZGVlcGJsdWVjYXAuY29tIHdyb3RlOgoKPiBXaGVuIHVzaW5nIHRoZSBSQ1VfTUVNQkFSUklF
UiBmbGF2b3VyIG9mIHVzZXJzcGFjZS1SQ1UsIGtlcm5lbCBzdXBwb3J0IGZvcgo+IHN5cy1tZW1i
YXJyaWVyIGlzIGRldGVjdGVkIGR5bmFtaWNhbGx5IGFuZCBzdG9yZWQgaW4gdGhlIHJjdV9oYXNf
c3lzX21lbWJhcnJpZXIKPiBnbG9iYWwgdmFyaWFibGUuICBDaGVja2luZyB0aGUgdmFsdWUgb2Yg
dGhpcyB2YXJpYWJsZSBhZGRzIGEgc21hbGwgYnV0Cj4gbWVhc3VyYWJsZSBvdmVyaGVhZCB0byBz
bXBfbWJfc2xhdmUuICBJIG9ubHkgdXNlIHVzZXJzcGFjZS1yY3Ugb24gc3lzdGVtcyB3aGljaAo+
IHN1cHBvcnQgc3lzLW1lbWJhcnJpZXIsIGFuZCBJJ2QgbGlrZSBhIHdheSBvZiBhdm9pZGluZyB0
aGF0IG92ZXJoZWFkLgo+IAo+IFRoZSBhdHRhY2hlZCBwYXRjaCBtYWtlcyB0aGUgZm9sbG93aW5n
IGNoYW5nZXM6IGlmIFJDVV9GT1JDRV9TWVNfTUVNQkFSUklFUiBpcwo+IGRlZmluZWQgdGhlbiBy
Y3VfaGFzX3N5c19tZW1iYXJyaWVyIGlzIHJlcGxhY2VkIHdpdGggdGhlIGNvbnN0YW50IDEsIGVs
aW1pbmF0aW5nCj4gdGhlIG92ZXJoZWFkIGluIHNtcF9tYl9zbGF2ZS4gIEFzIGEgc2FuaXR5IGNo
ZWNrLCBzdXBwb3J0IGZvciBzeXMtbWVtYmFycmllciBpcwo+IHN0aWxsIGRldGVjdGVkIGF0IHN0
YXJ0dXAgYW5kIGlmIGl0IGlzbid0IHN1cHBvcnRlZCB0aGVuIHRoZSBwcm9ncmFtIGFib3J0cy4K
PiAKPiBJIGRpZG4ndCB0cnkgdG8gaW50ZWdyYXRlIHRoaXMgZmVhdHVyZSBpbnRvIHRoZSBidWls
ZCBzeXN0ZW0gKGVnIGJ5IGFkZGluZyBhCj4gY29uZmlndXJlIG9wdGlvbiBmb3IgaXQpIHNpbmNl
IEknbSB1c2luZyBteSBvd24gYnVpbGQgc3lzdGVtLgoKSGkgRHVuY2FuLAoKVGhpcyBpcyBhbiBp
bnRlcmVzdGluZyBpbXByb3ZlbWVudC4gSSdkIGJlIGludGVyZXN0ZWQgdG8gbWVyZ2UgaXQgaWYg
aXQgd2FzCmludGVncmF0ZWQgd2l0aCB0aGUgbGlidXJjdSBidWlsZCBzeXN0ZW0uIFBlcmhhcHMg
YSAtLWRpc2FibGUtZHluYW1pYy1tZW1iYXJyaWVyLWNoZWNrCmF0IGNvbmZpZ3VyZSA/CgpUaGFu
a3MsCgpNYXRoaWV1Cgo+IAo+IEJlc3Qgd2lzaGVzLCBEdW5jYW4uCj4gCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVy
cwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
