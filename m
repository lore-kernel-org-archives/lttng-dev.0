From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Fri, 15 Feb 2019 10:32:00 -0500
Message-ID: <CADcCL0jBrNyhbVvpbhmLD_vZgi9bcgDUN5dAGpbf5JvuG9MDmw__14006.5212430031$1550244751$gmane$org@mail.gmail.com>
References: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by lists.lttng.org (Postfix) with ESMTPS id 441HLj3Mb0zftB
 for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2019 10:32:13 -0500 (EST)
Received: by mail-ot1-f49.google.com with SMTP id 98so17196126oty.1
 for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2019 07:32:13 -0800 (PST)
In-Reply-To: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgTW9zbGVoLApJdCdzIGV4cGVjdGVkIHRvIG5vdCBzZWUgYW55IGV2ZW50IHdoZW4gcnVubmlu
ZyBsdHRuZyBsaXN0IC11IGlmIG5vCmx0dG5nLXVzdCBpbnN0cnVtZW50ZWQgYXBwbGljYXRpb25z
IGFyZSBydW5uaW5nLgoKV2hhdCBhcmUgdGhlIGV4YWN0IGx0dG5nIGNvbW1hbmRzIHlvdSBhcmUg
cnVubmluZyB0byBzZWUgdGhvc2UKdW5leHBlY3RlZCBldmVudHM/CgpUaGFuayB5b3UsCkZyYW5j
aXMKCgpMZSB2ZW4uIDE1IGbDqXZyLiAyMDE5LCDDoCAxMCBoIDA4LCBNb3NsZWggVWRkaW4gPG1v
c2xlaDEyMzVAZ21haWwuY29tPiBhIMOpY3JpdCA6Cj4KPiBIZWxsbywKPgo+IEkgYW0gaGF2aW5n
IGEgc3RyYW5nZSBpc3N1ZSB3aXRoIG15IGN1cnJlbnQgYXBwbGljYXRpb24uIEZvciBzb21lIGNv
bnRleHQsIEkgaGF2ZSBpbnRlZ3JhdGVkIExUVG5nIGludG8gYSBZb2N0byBidWlsZCBhbmQgcHV0
IGN1c3RvbSB0cmFjZSBwb2ludHMgaW4gbXkgZW1iZWRkZWQgc3lzdGVtIGFwcGxpY2F0aW9uLiBP
bmNlIEkgbG9hZCB0aGUgYnVpbHQgaW1hZ2Ugb250byBteSBzeXN0ZW0gYW5kIHN0YXJ0IGEgc2Vz
c2lvbiBkYWVtb24sIEkgdHJ5IHRvIGxpc3QgYWxsIGF2YWlsYWJsZSB1c2Vyc3BhY2UgZXZlbnRz
ICh1c2luZyBsdHRuZyBsaXN0IC11KSwgYnV0IG5vIGV2ZW50cyBzaG93IHVwLgo+Cj4gVGhlIHN0
cmFuZ2Ugb2NjdXJyZW5jZSBpcyB3aGVuIEkgY3JlYXRlIGEgc2Vzc2lvbiAobGx0bmcgY3JlYXRl
IG15LXNlc3MpIGFuZCBub3Qgc3RhcnQgdHJhY2luZyB0aGUgdHJhY2UgZXZlbnRzIHdpbGwgZGlz
cGxheSBvbiB0aGUgc2NyZWVuIHJlZ2FyZGxlc3MgKHdoZW4gc3RhcnRpbmcgc2Vzc2lvbiBpbiBs
aXZlIG1vZGUgd2l0aCBsdHRuZyB2aWV3KS4gSSB3YXMgd29uZGVyaW5nIGlmIGFueW9uZSBoYXMg
YW55IGluc2lnaHQgb24gdGhpcyBpc3N1ZSBJIGFtIGhhdmluZy4KPgo+IFRoYW5rcyBmb3IgYW55
IGFzc2lzdGFuY2UsCj4gTW9zbGVoCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKCi0tIApGcmFuY2lzIERlc2xhdXJpZXJzCkNvbXB1dGVyIEVuZ2luZWVy
CkVmZmljaU9TIGluYy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
