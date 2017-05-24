From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Wed, 24 May 2017 10:57:10 -0400
Message-ID: <eb2eec76-8ad8-bea2-5933-629ac1f1df07__33804.8041951426$1495637985$gmane$org@efficios.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
 <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw@mail.gmail.com>
 <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXwW34Xc3z10Xv
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 14:58:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A150434025D
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 14:58:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rTKogJ-dETyN for <lttng-dev@lists.lttng.org>;
 Wed, 24 May 2017 14:58:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3E34F34035D
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 14:58:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CiZb6KWIg3c3 for <lttng-dev@lists.lttng.org>;
 Wed, 24 May 2017 14:58:01 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 24E3E34025D
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 14:58:01 +0000 (UTC)
In-Reply-To: <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wNS0yNCAxMDo1MiwgSsOpcsOpbWllIEdhbGFybmVhdSB3cm90ZToKPiBPbiAyMyBN
YXkgMjAxNyBhdCAwOTo1MCwgRMOhdmlkIEJlY2sgPGRhdmlkLmJlY2sucHJpdkBnbWFpbC5jb20+
IHdyb3RlOgo+PiBIaSBKw6lyw6ltaWUsCj4+Cj4+IEkgZ3Vlc3MgdGhpcyBpcyBteSBsYWNrIG9m
IGx0dG5nIHVuZGVyc3RhbmRpbmcuCj4+Cj4+IEkgd2FudGVkIHRvIHBsYXkgYXJvdW5kIHdpdGgg
cmVsYXlkIG9uIE1hYyBieSBoYXZpbmcgYSBMaW51eCBib3ggZ2VuZXJhdGluZwo+PiB0aGUgdHJh
Y2VzIGFuZCBnaXZlIGl0IGEgcmVtb3RlIHJlbGF5ZCBmb3Igc3RvcmluZyB0aGUgdHJhY2VzIGxv
Y2FsbHkgb24gbXkKPj4gTWFjLgo+Pgo+PiBJIHdhcyB0aGlua2luZyB0aGF0IEkgZG9uJ3QgbmVl
ZCBhIGxvY2FsIHNlc3Npb25kIG9uIHRoZSBNYWMgZm9yIHRoaXMsIGRvIEk/Cj4gCj4gRXhhY3Rs
eS4gVGhlIHJlbGF5ZCBpcyB0aGUgb25seSBkYWVtb24gdGhhdCBpcyBuZWVkZWQgdG8gcmVjZWl2
ZQo+IHRyYWNlcyByZW1vdGVseS4KPiAKPj4KPj4gVG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24gSSB3
YW50IHRvIHBsYXkgYXJvdW5kIHdpdGggUnVzdCBhbmQgTHR0bmcgb24gTWFjCj4+IGJlY2F1c2Ug
SSBoYXZlIGEgZmV3IGlkZWFzIG9mIGhvdyB0byBnZW5lcmF0ZSBhIGZldyBzdGF0aXN0aWNhbCBw
ZXJmb3JtYW5jZQo+PiBtZXRyaWNzIGZyb20gdGhlIHRyYWNlcy4gU2luY2UgdGhpcyBpcyBhIG1p
ZG5pZ2h0IHByb2plY3QgSSBoYXZlIHRoZSBsdXh1cnkKPj4gdG8gZG8gaXQgaW4gYSBsYW5ndWFn
ZSB0aGF0IEkgbGlrZSBhcyBvcHBvc2VkIHRvIEphdmEgKHRoZSB2aWV3ZXIpIG9yCj4+IEMvUHl0
aG9uIChCYWJlbHRyYWNlKS4gU28gZXZlbnR1YWxseSBJIHdhbnQgdG8gYnVpbGQgYW4gZXZlbnQg
Y29sbGVjdG9yIGluCj4+IFJ1c3QsIGFuZCB0byB0ZXN0IHRoZSBkYXRhIGZsb3cgSSB0aG91Z2h0
IGl0IGlzIGdvb2QgdG8gaGF2ZSB0aGUgcmVsYXlkIG9uCj4+IE1hYy4KPiAKPiBHb29kIHRvIGhl
YXIuIERvbid0IGhlc2l0YXRlIHRvIHNoYXJlIGFueSBwcm9ncmVzcyB5b3UgbWFrZSwgd2UncmUK
PiBhbHdheXMgaW50ZXJlc3RlZCEKPiAKPiBKw6lyw6ltaWUKPiAKPj4KPj4gVGhhbmsgeW91LCBE
YXZpZAoKSSBjb3VsZCBtYWtlIGEgcGF0Y2ggdGhhdCBzZXRzIHRoZSBjb3JyZWN0IGRlZmF1bHRz
IG9uIG1hY09TIGFuZCBvdGhlcgpzaW1pbGFyIHBsYXRmb3JtcyB3aGVyZSB3ZSBvbmx5IHN1cHBv
cnQgYnVpbGRpbmcgdGhlIHJlbGF5ZC4gVGhvdWdodHM/CgpNaWNoYWVsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
