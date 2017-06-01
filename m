From: =?utf-8?Q?D=C3=A1vid_Beck?= <david.beck.priv@gmail.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Thu, 1 Jun 2017 22:30:12 +0100
Message-ID: <9EB290C2-A968-4B16-9A1D-AA7BC38E2DE5__2143.68905076316$1496352788$gmane$org@gmail.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
 <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw@mail.gmail.com>
 <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
 <eb2eec76-8ad8-bea2-5933-629ac1f1df07@efficios.com>
 <CA+jJMxs2=ua4LsaPS9DqBGY6gdLQqjCaibhnPYLt5k9d7Ke42Q@mail.gmail.com>
 <019415e6-017c-09b9-7f4a-0df71b51fc1a@efficios.com>
 <CA+jJMxvnbQuvPTR0uWw=XNXR-FARxyErDJhkND9kUwDUrLvNzQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3wf0sH6gbtz12H7
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 21:31:31 +0000 (UTC)
Received: by mail-wm0-x241.google.com with SMTP id k15so14460738wmh.3
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jun 2017 14:30:12 -0700 (PDT)
In-Reply-To: <CA+jJMxvnbQuvPTR0uWw=XNXR-FARxyErDJhkND9kUwDUrLvNzQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSsOpcsOpbWllLAoKU291bmRzIGdyZWF0LCB0aGFuayB5b3UhCgpJIGhhZCBhIHF1aWNrIGxv
b2sgaW50byB0aGlzIHB1bGwgcmVxdWVzdCBhbmQgSSBoYXZlbuKAmXQgZm91bmQgaG93IHRoaXMg
cmVsYXRlcyB0aGUgaXNzdWVzIEkgZm91bmQ6CgoxLCBIT1NUX05BTUVfTUFYIHdhcyBub3QgZGVm
aW5lZAoyLCBlcnJuby5oIHdhcyBuZWVkZWQgb24gTWFjCgpNYXkgYmUgaXQgaXMgb25seSBteSBs
YWNrIG9mIGF1dG8gdG9vbHMga25vd2xlZGdlLCBJIGRvbuKAmXQga25vdy4gQW55d2F5cywgdGhh
bmsgeW91IGFnYWluLgoKQmVzdCwgRGF2aWQKCgo+IE9uIDAxIEp1biAyMDE3LCBhdCAyMjowMiwg
SsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPiB3cm90
ZToKPiAKPiBIaSBEYXZpZCwKPiAKPiBUaGUgcHVsbCByZXF1ZXN0IE1pY2hhZWwgcmVmZXJlbmNl
ZCB3YXMgbWVyZ2VkIGFuZCB5b3VyIGlzc3VlIHNob3VsZAo+IGJlIHJlc29sdmVkIGluIGJvdGgg
dGhlIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAgYnJhbmNoZXMuCj4gCj4gSsOpcsOpbWllCj4gCj4g
T24gMjQgTWF5IDIwMTcgYXQgMTQ6MDYsIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNp
b3MuY29tPiB3cm90ZToKPj4gT24gMjAxNy0wNS0yNCAxMToxMSwgSsOpcsOpbWllIEdhbGFybmVh
dSB3cm90ZToKPj4+IAo+Pj4gR29vZCBpZGVhISBJdCB3aWxsIGNlcnRhaW5seSBiZSBsZXNzIGVy
cm9yLXByb25lLgo+Pj4gCj4+IAo+PiBJIGFkZGVkIGl0IHRvIHRoaXMgWzFdIHB1bGwgcmVxdWVz
dCBzaW5jZSBpdCdzIGJ1aWxkIHN5c3RlbSByZWxhdGVkLiBJdAo+PiB3YXMgdGVzdGVkIG9uIG1h
Y09TIDEwLjEyLjQuCj4+IAo+PiBNaWNoYWVsCj4+IAo+PiBbMV0gaHR0cHM6Ly9naXRodWIuY29t
L2x0dG5nL2x0dG5nLXRvb2xzL3B1bGwvOTEKPj4gCj4gCj4gCj4gCj4gLS0gCj4gSsOpcsOpbWll
IEdhbGFybmVhdQo+IEVmZmljaU9TIEluYy4KPiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
