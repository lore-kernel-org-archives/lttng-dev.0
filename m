From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC babeltrace 1/2] fs-src: add argument for
 metadata src dir
Date: Tue, 1 May 2018 13:01:31 -0400
Message-ID: <20180501170131.wiylahrklfahqzid__35024.1977641874$1525193987$gmane$org@x220t>
References: <20180430213107.10666-1-aring@mojatatu.com>
 <20180430213107.10666-2-aring@mojatatu.com>
 <CAB4xu_3x6ycKDDuZyydBKDC-iaL8Xpz8vh0tHrwjtkbid98XXg@mail.gmail.com>
 <20180501151239.kpcj2khuj2wvygxc@x220t>
 <CAB4xu_0Me0PVQ0Y-EJOZwYN331bO+GTyhKnPH4MmXufrmWPGkw@mail.gmail.com>
 <20180501154332.tcta2vycdmpygs4r@x220t>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x22e.google.com (mail-it0-x22e.google.com
 [IPv6:2607:f8b0:4001:c0b::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 40b73q44j3z18Vv
 for <lttng-dev@lists.lttng.org>; Tue,  1 May 2018 13:01:43 -0400 (EDT)
Received: by mail-it0-x22e.google.com with SMTP id j186-v6so13802563ita.5
 for <lttng-dev@lists.lttng.org>; Tue, 01 May 2018 10:01:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180501154332.tcta2vycdmpygs4r@x220t>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: kernel@mojatatu.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBNYXkgMDEsIDIwMTggYXQgMTE6NDM6MzJBTSAtMDQwMCwgQWxleGFuZGVyIEFyaW5n
IHdyb3RlOgouLi4KPiA+IAo+ID4gTm9ybWFsbHksIGEgdHJhY2UgaGFzIGEgdW5pcXVlIFVVSUQu
IElmIHlvdSBjYW5ub3QgZW5zdXJlIHRoaXMsIEkKPiA+IHN1Z2dlc3QgdGhhdCB5b3UgcmVtb3Zl
IHRoZSBVVUlEIGZpZWxkIGZyb20gdGhlIHBhY2tldCBoZWFkZXIuCj4gPiAKPiAKPiBJIHNlZSwg
YWNjb3JkaW5nIFswXToKPiAKPiBUcmFjZSBVVUlELCB1c2VkIHRvIGVuc3VyZSB0aGUgZXZlbnQg
cGFja2V0IG1hdGNoIHRoZSBtZXRhZGF0YSB1c2VkLgo+IE5vdGU6IHdlIGNhbm5vdCB1c2UgYSBt
ZXRhZGF0YSBjaGVja3N1bSBpbiBldmVyeSBjYXNlcyBpbnN0ZWFkIG9mIGEgVVVJRAo+IGJlY2F1
c2UgbWV0YWRhdGEgY2FuIGJlIGFwcGVuZGVkIHRvIHdoaWxlIHRyYWNpbmcgaXMgYWN0aXZlLiBU
aGlzIGZpZWxkCj4gaXMgb3B0aW9uYWwuCj4gCgpJIHJlbW92ZWQgc29tZSBvdGhlciBmaWVsZHMg
d2hpY2ggSSBkb24ndCBuZWVkLiBUaGFua3MgZm9yIHJlbWluZGluZyBtZSEKSSByZW1vdmVkOgoK
CiAtIFN0cmVhbS1JRDogSSBoYXZlIG9ubHkgb25lIHN0cmVhbQogLSBldmVudHNfZGlzY2FyZGVk
OiBJIGRvbid0IGhhbmRsZSB0aGlzIGluIGZzIHBsYXRmb3JtIHJpZ2h0IG5vdywgY291bGQKICAg
YmUgbWF5YmUgYXMgImZpbGVzeXN0ZW0gaXMgZnVsbD8iCgpNYXkgSSBkcm9wIHV1aWQgd2hlbiBJ
IGhhdmUgb25seSBvbmUgbWV0YWRhdGEgZmlsZSwgYnV0IHZhbGlkYXRpb24gaWYKbWV0YWRhdGEg
Zml0cyBvciBub3QgY291bGQgYmUgdXNlZnVsIGZvciBoYW5kbGluZyB0aGUgY2FzZSBpZiBzb21l
Ym9keQp1c2UgYSBkaWZmZXJlbnQgb25lLgoKSSBzZWUgdGhhdCBiYXJlY3RmIHdpbGwgc3RpbGwg
Z2VuZXJhdGUgc29tZSB1dWlkIGFuZCBwbGFjZSBpdCBpbjoKCnRyYWNlIHsKCXV1aWQgPSAuLi4u
Cn07CgpidXQgSSBndWVzcyBpdCB3aWxsIG5vdCBiZSB1c2VkIGFueW1vcmUgaW4gdGhlIHN0cmVh
bS4gU28gZmFyIEkgZG9uJ3QKc2VlIGl0IGFueW1vcmUgd2l0aCBhIHNpbXBsZSBoZXhkdW1wIChM
b29rcyBmb3IgbWUgYXMgdGhlIGJlc3Qgd2F5IHRvCmNoZWNrIHdoYXQgYmFyZWN0ZiBpcyBkb2lu
ZykuCgpUaGFua3MuCgotIEFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
