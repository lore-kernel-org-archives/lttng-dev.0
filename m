From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC PATCH lttng-ust 2/2] dl instrumentation: add
 dlmopen event, trace dlopen flags
Date: Tue, 21 Feb 2017 15:19:49 +0100
Message-ID: <20170221151949.3fe21958__5059.76562058112$1487686804$gmane$org@free-electrons.com>
References: <1467672828-19184-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1467672828-19184-2-git-send-email-mathieu.desnoyers@efficios.com>
 <20170221100301.6e409dc3@free-electrons.com>
 <188106062.195366.1487686088345.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3vSN1v0jnvzkYn
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 14:20:18 +0000 (UTC)
In-Reply-To: <188106062.195366.1487686088345.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

SGVsbG8sCgpPbiBUdWUsIDIxIEZlYiAyMDE3IDE0OjA4OjA4ICswMDAwIChVVEMpLCBNYXRoaWV1
IERlc25veWVycyB3cm90ZToKCj4gTXkgZXhwZWN0YXRpb24gaXMgdGhhdCB0aGUgZGxtb3BlbiBv
dmVycmlkZSBzeW1ib2wgZ2V0cyBnZW5lcmF0ZWQsCj4gYnV0IGl0IGlzIG5ldmVyIGludm9rZWQg
aW4gYnVpbGRzIHdoZXJlIHRoZSBsaWJjIGRvZXMgbm90IGltcGxlbWVudAo+IGl0LCBzbyB3ZSBu
ZXZlciBoYXZlIHRvIGxvb2sgaXQgdXAgZHluYW1pY2FsbHkgdGhyb3VnaCBkbHN5bSgpLgoKVGhl
IG1haW4gaXNzdWUgaXMgdGhhdCB0aGUgTG1pZF90IHR5cGUgZG9lc24ndCBleGlzdCBJIGJlbGll
dmUuCgo+IEhvdyBkb2VzIHRoZSBidWlsZCBmYWlsIHdpdGggbXVzbCA/IENhbiB5b3UgcHJvdmlk
ZSB0aGUgYnVpbGQKPiBvdXRwdXQgPwoKU3VyZToKCiAgaHR0cDovL2F1dG9idWlsZC5idWlsZHJv
b3QubmV0L3Jlc3VsdHMvMTEzLzExM2ZhOTVhMDU0ZGYxODMwMTRiNDNlYzM2YjMyOWY5YzU5YmQz
NTYvYnVpbGQtZW5kLmxvZwoKSWYgeW91IHdhbnQgdG8gcmVwcm9kdWNlOgoKJCBnaXQgY2xvbmUg
Z2l0Oi8vZ2l0LmJ1c3lib3gubmV0L2J1aWxkcm9vdAokIGNkIGJ1aWxkcm9vdC8KJCBnaXQgY2hl
Y2tvdXQgMjAxNy4wMi1yYzIKJCBjYXQgPiAuY29uZmlnCkJSMl9hcm09eQpCUjJfY29ydGV4X2E5
PXkKQlIyX0FSTV9FTkFCTEVfVkZQPXkKQlIyX1RPT0xDSEFJTl9FWFRFUk5BTD15CkJSMl9UT09M
Q0hBSU5fRVhURVJOQUxfQ1VTVE9NPXkKQlIyX1RPT0xDSEFJTl9FWFRFUk5BTF9ET1dOTE9BRD15
CkJSMl9UT09MQ0hBSU5fRVhURVJOQUxfVVJMPSJodHRwOi8vYXV0b2J1aWxkLmJ1aWxkcm9vdC5v
cmcvdG9vbGNoYWlucy90YXJiYWxscy9ici1hcm0tY29ydGV4LWE5LW11c2wtMjAxNy4wMi1yYzEt
Mi1nMTMzYzVhYy50YXIuYnoyIgpCUjJfVE9PTENIQUlOX0VYVEVSTkFMX0dDQ181PXkKQlIyX1RP
T0xDSEFJTl9FWFRFUk5BTF9IRUFERVJTXzRfOT15CkJSMl9UT09MQ0hBSU5fRVhURVJOQUxfQ1VT
VE9NX01VU0w9eQpCUjJfVE9PTENIQUlOX0VYVEVSTkFMX0NYWD15CkJSMl9JTklUX05PTkU9eQpC
UjJfU1lTVEVNX0JJTl9TSF9OT05FPXkKIyBCUjJfUEFDS0FHRV9CVVNZQk9YIGlzIG5vdCBzZXQK
QlIyX1BBQ0tBR0VfTFRUTkdfTElCVVNUPXkKIyBCUjJfVEFSR0VUX1JPT1RGU19UQVIgaXMgbm90
IHNldAokIG1ha2Ugb2xkZGVmY29uZmlnCiQgbWFrZQoKVGFrZXMgfjUgbWludXRlcyBtYXliZSBm
b3IgdGhlIGFsbCBidWlsZCB0byBwcm9jZWVkIHVudGlsIGl0IGJyZWFrcyBvbgpsdHRuZy11c3Qu
CgpUaGFua3MhCgpUaG9tYXMKLS0gClRob21hcyBQZXRhenpvbmksIENUTywgRnJlZSBFbGVjdHJv
bnMKRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwOi8vZnJlZS1lbGVj
dHJvbnMuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
