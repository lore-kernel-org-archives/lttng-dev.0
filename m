From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: LD_PRELOAD applications using lttng-ust-pthread
Date: Tue, 9 Jan 2018 10:43:51 -0500
Message-ID: <20180109154351.GA17950__40070.2187595472$1515512531$gmane$org@joraj-alpa>
References: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGGdl3rLMznhK
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 15:43:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Majid Rezazadeh <majid3612@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpPbiBNb24sIEphbiAwOCwgMjAxOCBhdCAxMDozNTozOVBNIC0wNTAwLCBNYWppZCBSZXph
emFkZWggd3JvdGU6Cj4gSGkgYWxsCj4gCj4gSSBhbSB1c2luZyBsdHRuZy11c3QtbGliYy13cmFw
cGVyIGZvciBpbnN0cnVtZW50aW5nIHNvbWUgY2FsbHMgdG8gbGliYyBmb3IKPiBzb21lIGFwcGxp
Y2F0aW9ucyBsaWtlIEZpcmVmb3ggYW5kIENocm9tZSwgYnV0IEkgcmVjZWl2ZSAiU2VnbWVudGF0
aW9uCj4gZmF1bHQgKGNvcmUgZHVtcGVkKSIuIEkgY29tcGlsZSBsdHRuZy11c3QtcHRocmVhZC5j
IChnY2MgLWZQSUMgLXNoYXJlZCAgLW8KPiB0ZXN0LnNvIGx0dG5nLXVzdC1wdGhyZWFkLmMgLWxk
bCkgYW5kIHRoZW4gSSB1c2UgIkxEX1BSRUxPQUQ9dGVzdC5zbwo+IGZpcmVmb3giIGJ1dCBJIHJl
Y2VpdmUgc2VnbWVudGF0aW9uIGZhdWx0IChJIGhhdmUgZXhwb3J0ZWQgTERfTElCUkFSWV9QQVRI
Cj4gdG8gdGhlIGFic29sdXRlIHBhdGggb2YgdGVzdC5zbyBmaWxlKS4gSSBmb3VuZCBvdXQgdGhh
dCB3aGVuIEkgcmVwbGFjZQoKQ291bGQgeW91IGdpdmUgdXMgbW9yZSBpbmZvcm1hdGlvbiByZWdh
cmRpbmcgdGhlIGNvcmVkdW1wPwoKInRocmVhZCBhcHBseSBhbGwgYnQiIGluIGdkYiB3aXRoIHRo
ZSBjb3JlZmlsZSBsb2FkZWQuCgpNYWtlIHN1cmUgdG8gY29tcGlsZSB3aXRoIGRlYnVnIHN5bWJv
bCBhbmQgcmVydW4geW91ciB0ZXN0LgoKPiB0cmFjZXBvaW50cyB3aXRoIHByaW50ZiBpbiBsdHRu
Z191c3RfcHRocmVhZC5jLCBJIHJlY2VpdmUgbm8gZXJyb3IuIEl0Cj4gc2VlbXMgdGhhdCBob29r
aW5nIHRyYWNlcG9pbnRzIGluIHRoaXMgd3JhcHBlciBtYWtlcyBzb21lIHByb2JsZW1zLiBEbyB5
b3UKPiBoYXZlIGFueSBpZGVhIGluIHRoaXMgcmVnYXJkPwo+IAo+IFRoYW5rcwo+IAo+IE1hamlk
Cgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0
bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKLS0g
CkpvbmF0aGFuIFJham90dGUtSnVsaWVuCkVmZmljaU9TCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
