From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 2/8] Fix: missing event removal
 from the event hashtable
Date: Wed, 7 Feb 2018 20:50:43 +0000 (UTC)
Message-ID: <785880654.17806.1518036643540.JavaMail.zimbra__26781.8074710251$1518036516$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1517600891-23632-3-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcD3S3RHMzCf9
 for <lttng-dev@lists.lttng.org>; Wed,  7 Feb 2018 20:49:56 +0000 (UTC)
In-Reply-To: <1517600891-23632-3-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgotLS0tLSBPbiBGZWIgMiwgMjAxOCwgYXQgMjo0OCBQTSwgRnJhbmNpcyBEZXNsYXVyaWVycyBm
cmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKCklzIHRoaXMgcmVhbGx5IGEg
Zml4ID8gT3IgaXMgaXQgYSBwcmVwYXJhdGlvbiBzdGVwIGluIG9yZGVyIHRvIGJlIGFibGUgdG8K
cmVtb3ZlIGV2ZW50cyBiZWZvcmUgdGhlIGVuZCBvZiB0aGUgc2Vzc2lvbiBsaWZldGltZSA/CgpU
aGFua3MsCgpNYXRoaWV1CgoKPiBTaWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxm
cmFuY2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBsaWJsdHRuZy11c3QvbHR0
bmctZXZlbnRzLmMgfCA0ICsrKysKPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYyBiL2xpYmx0dG5nLXVz
dC9sdHRuZy1ldmVudHMuYwo+IGluZGV4IGY0YTdjY2MuLjc0MTlmNzggMTAwNjQ0Cj4gLS0tIGEv
bGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4gKysrIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2
ZW50cy5jCj4gQEAgLTg4Myw3ICs4ODMsMTEgQEAgdm9pZCBfbHR0bmdfZXZlbnRfZGVzdHJveShz
dHJ1Y3QgbHR0bmdfZXZlbnQgKmV2ZW50KQo+IHsKPiAJc3RydWN0IGx0dG5nX2VuYWJsZXJfcmVm
ICplbmFibGVyX3JlZiwgKnRtcF9lbmFibGVyX3JlZjsKPiAKPiArCS8qIFJlbW92ZSBmcm9tIGV2
ZW50IGxpc3QuICovCj4gCWNkc19saXN0X2RlbCgmZXZlbnQtPm5vZGUpOwo+ICsJLyogUmVtb3Zl
IGZyb20gZXZlbnQgaGFzaCB0YWJsZS4gKi8KPiArCWNkc19obGlzdF9kZWwoJmV2ZW50LT5obGlz
dCk7Cj4gKwo+IAlsdHRuZ19kZXN0cm95X2NvbnRleHQoZXZlbnQtPmN0eCk7Cj4gCWx0dG5nX2Zy
ZWVfZXZlbnRfZmlsdGVyX3J1bnRpbWUoZXZlbnQpOwo+IAkvKiBGcmVlIGV2ZW50IGVuYWJsZXIg
cmVmcyAqLwo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMu
Cmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
