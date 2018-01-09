From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: LD_PRELOAD applications using lttng-ust-pthread
Date: Tue, 9 Jan 2018 10:47:10 -0500
Message-ID: <20180109154710.GB17950__15920.5483775169$1515512720$gmane$org@joraj-alpa>
References: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA@mail.gmail.com>
 <20180109154351.GA17950@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGGjW6GPnznj4
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 15:47:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20180109154351.GA17950@joraj-alpa>
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

T24gVHVlLCBKYW4gMDksIDIwMTggYXQgMTA6NDM6NTFBTSAtMDUwMCwgSm9uYXRoYW4gUmFqb3R0
ZS1KdWxpZW4gd3JvdGU6Cj4gSGksCj4gCj4gT24gTW9uLCBKYW4gMDgsIDIwMTggYXQgMTA6MzU6
MzlQTSAtMDUwMCwgTWFqaWQgUmV6YXphZGVoIHdyb3RlOgo+ID4gSGkgYWxsCj4gPiAKPiA+IEkg
YW0gdXNpbmcgbHR0bmctdXN0LWxpYmMtd3JhcHBlciBmb3IgaW5zdHJ1bWVudGluZyBzb21lIGNh
bGxzIHRvIGxpYmMgZm9yCj4gPiBzb21lIGFwcGxpY2F0aW9ucyBsaWtlIEZpcmVmb3ggYW5kIENo
cm9tZSwgYnV0IEkgcmVjZWl2ZSAiU2VnbWVudGF0aW9uCj4gPiBmYXVsdCAoY29yZSBkdW1wZWQp
Ii4gSSBjb21waWxlIGx0dG5nLXVzdC1wdGhyZWFkLmMgKGdjYyAtZlBJQyAtc2hhcmVkICAtbwo+
ID4gdGVzdC5zbyBsdHRuZy11c3QtcHRocmVhZC5jIC1sZGwpIGFuZCB0aGVuIEkgdXNlICJMRF9Q
UkVMT0FEPXRlc3Quc28KPiA+IGZpcmVmb3giIGJ1dCBJIHJlY2VpdmUgc2VnbWVudGF0aW9uIGZh
dWx0IChJIGhhdmUgZXhwb3J0ZWQgTERfTElCUkFSWV9QQVRICj4gPiB0byB0aGUgYWJzb2x1dGUg
cGF0aCBvZiB0ZXN0LnNvIGZpbGUpLiBJIGZvdW5kIG91dCB0aGF0IHdoZW4gSSByZXBsYWNlCj4g
Cj4gQ291bGQgeW91IGdpdmUgdXMgbW9yZSBpbmZvcm1hdGlvbiByZWdhcmRpbmcgdGhlIGNvcmVk
dW1wPwo+IAo+ICJ0aHJlYWQgYXBwbHkgYWxsIGJ0IiBpbiBnZGIgd2l0aCB0aGUgY29yZWZpbGUg
bG9hZGVkLgo+IAo+IE1ha2Ugc3VyZSB0byBjb21waWxlIHdpdGggZGVidWcgc3ltYm9sIGFuZCBy
ZXJ1biB5b3VyIHRlc3QuCgpGb3Jnb3QgdG8gbWVudGlvbiB0aGF0IHlvdSBzaG91bGQgb3BlbiBh
IGJ1ZyBoZXJlOgoKaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy8KCk1ha2Ugc3VyZSB0byByZWFkIHRo
ZSBidWcgcmVwb3J0aW5nIGd1aWRlbGluZXMuCgpDaGVlcnMhCgotLQpKb25hdGhhbiBSYWpvdHRl
LUp1bGllbgpFZmZpY2lPUwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
