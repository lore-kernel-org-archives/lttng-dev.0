From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: How can I get traces in live mode from lttng in my
 c++ application without using tcp sockets?
Date: Mon, 15 Oct 2018 16:44:53 -0400
Message-ID: <CAB4xu_2JqHZkUePyXpCEZTR-=tFc-c4_3knvBNhC9viAXJXXBA__35549.5859556415$1539636203$gmane$org@mail.gmail.com>
References: <CAHaeqCJxxv0SUQOHrFKEGj4-YuHxyqL4Mp8jd60ihDYswkxAuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by lists.lttng.org (Postfix) with ESMTPS id 42Yr6m2cp5z12tp
 for <lttng-dev@lists.lttng.org>; Mon, 15 Oct 2018 16:45:20 -0400 (EDT)
Received: by mail-qt1-x82a.google.com with SMTP id o17-v6so23179865qtr.1
 for <lttng-dev@lists.lttng.org>; Mon, 15 Oct 2018 13:45:20 -0700 (PDT)
In-Reply-To: <CAHaeqCJxxv0SUQOHrFKEGj4-YuHxyqL4Mp8jd60ihDYswkxAuw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: dubinin.andrey88@gmail.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gTW9uLCBPY3QgMTUsIDIwMTggYXQgNDozNyBQTSBBbmRyZXkgRHViaW5pbgo8ZHViaW5pbi5h
bmRyZXk4OEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBJJ20gdXNpbmcgbHR0bmcgYXBp
IGluIG15IGMrKyBhcHBsaWNhdGlvbiB0byBnZXQgdHJhY2VzLCBidXQgdGhlIG9ubHkgc29sdXRp
b24gSSBmb3VuZCBpcyB1c2luZyB0Y3Agc29ja2V0cy4gQ2FuIEkgZG8gdGhpcyB3aXRob3V0IHVz
aW5nIG5ldHdvcms/CgpTZWUgPGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzUy
ODE4MTgxL2hvdy1jYW4taS1nZXQtdHJhY2VzLWluLWxpdmUtbW9kZS1mcm9tLWx0dG5nLWluLW15
LWMtYXBwbGljYXRpb24td2l0aG91dC11c2luZyNjb21tZW50OTI1NjA0NTBfNTI4MTgxODE+LgoK
UGhpbGlwcGUgUHJvdWx4Cgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
