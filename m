From: Antoine Busque <abusque@efficios.com>
Subject: Re: Userspace C++ Fucntion entry exit insert tracepoints
Date: Sat, 29 Aug 2015 00:25:00 -0400
Message-ID: <CA+MZcXs6DULNcVXUOqC=nbo2qZXUVxL_nezYd3icY5L4iN126A__23039.4292892472$1440822399$gmane$org@mail.gmail.com>
References: <BAY179-W1929B629FBBDDBA12D96AD92750@phx.gbl>
 <CA+MZcXt0JTMQ8cwthAgAbnxonVQ3UpTYKmBC_w4Rn0qHS9eCyw@mail.gmail.com>
 <BAY179-W393BA87F5BA841B1432BC5926D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZVXhW-00075R-Ar
 for lttng-dev@lists.lttng.org; Sat, 29 Aug 2015 00:25:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4324F340298
 for <lttng-dev@lists.lttng.org>; Sat, 29 Aug 2015 04:25:05 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 9qDFiIczm-tg for <lttng-dev@lists.lttng.org>;
 Sat, 29 Aug 2015 04:25:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0789D3402C3
 for <lttng-dev@lists.lttng.org>; Sat, 29 Aug 2015 04:25:03 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1mrixNfYYM_a for <lttng-dev@lists.lttng.org>;
 Sat, 29 Aug 2015 04:25:02 +0000 (UTC)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by mail.efficios.com (Postfix) with ESMTPSA id 83729340298
 for <lttng-dev@lists.lttng.org>; Sat, 29 Aug 2015 04:25:02 +0000 (UTC)
Received: by igcse8 with SMTP id se8so34346125igc.1
 for <lttng-dev@lists.lttng.org>; Fri, 28 Aug 2015 21:25:00 -0700 (PDT)
In-Reply-To: <BAY179-W393BA87F5BA841B1432BC5926D0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Farhan Shariff <farhan.shariff@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gRnJpLCBBdWcgMjgsIDIwMTUgYXQgMTA6MTIgUE0sIEZhcmhhbiBTaGFyaWZmCjxmYXJoYW4u
c2hhcmlmZkBob3RtYWlsLmNvbT4gd3JvdGU6Cj4gSGkgQW50b2luZSwKPgo+IFRoYW5rIHlvdSBm
b3IgeW91ciByZXBseTopCj4KPiBXaGF0IGlzIHRoZSBtYWpvciBkZXBlbmRlbmN5IG9yIHJlYXNv
biB0aGF0IGx0dG5nIG1vZHVsZXMgYnVpbGQgb24gMi42LjM4Cj4gYW5kIGhpZ2hlciBhbmQgbm90
IG9uIGxvd2VyIDIuNi4zMgo+CgpUaGVyZSBoYXZlIGJlZW4gY2hhbmdlcyBpbiB0aGUga2VybmVs
J3MgdHJhY2Vwb2ludCBBUEkgYmV0d2VlbgoyLjYuMzIgYW5kIDIuNi4zNiwgYW1vbmdzdCBvdGhl
ciBjaGFuZ2VzLCBjYXVzaW5nCmluY29tcGF0aWJpbGl0aWVzLiBQYXRjaGVzIHRvIHN1cHBvcnQg
a2VybmVsIHZlcnNpb25zIGxvd2VyIHRoYW4KMi42LjM2IHdlcmUgYXQgb25lIHBvaW50IG1haW50
YWluZWQsIHVuZGVyIGBsaW51eC1wYXRjaGVzL2AKd2l0aGluIHRoZSBsdHRuZy1tb2R1bGVzIHNv
dXJjZSB0cmVlLCBidXQgYXMgZGlzY3JlcGFuY2llcwpiZXR3ZWVuIG9sZGVyIGFuZCBuZXdlciBr
ZXJuZWxzIGdyZXcgaXQgYmVjYW1lIHRvbyBidXJkZW5zb21lIHRvCmFjdGl2ZWx5IG1haW50YWlu
IHRoZW0uCgo+IGJ0dyAg4oCRY3ln4oCRcHJvZmlsZSBsaWJyYXJ5ICBwcm92aWRlcyBvbmx5IGZ1
bmN0aW9uIGNhbGwgZ3JhcGggYW5kIE5PVCB0aGUgSS9PCj4gYXJndW1lbnRzLiBJIHByZWZlciB1
c2luZyBpdCB3aXRoIHRyYWNlcG9pbnRzKCk7Cj4KClJpZ2h0LCB0aGUgZ2VuZXJhdGVkIGluc3Ry
dW1lbnRhdGlvbiBvbmx5IGhhcyBpbmZvcm1hdGlvbiBhYm91dAp0aGUgZnVuY3Rpb24ncyBhZGRy
ZXNzIGFuZCBpdHMgY2FsbHNpdGUuIEkgZG8gbm90IGJlbGlldmUgdGhlcmUgYXJlCnJlYWR5LW1h
ZGUgZmFjaWxpdGllcyB0byBnZW5lcmF0ZSBzaW1pbGFyIGVudHJ5L2V4aXQKaW5zdHJ1bWVudGF0
aW9uIHRoYXQgYWxzbyBhY2NvdW50cyBmb3IgYWxsIHRoZSBjdXJyZW50IGFyZ3VtZW50cy4KCkFs
c28sIEkndmUgYWRkZWQgYmFjayBsdHRuZy1kZXYgaW4gQ0MgdG8gdGhpcyBtZXNzYWdlLiBQbGVh
c2UgdHJ5CnRvIGtlZXAgdGhlIGRpc2N1c3Npb24gb24gdGhlIHB1YmxpYyBtYWlsaW5nIGxpc3Qu
CgpSZWdhcmRzLApBbnRvaW5lIEJ1c3F1ZQoKPgo+IEJlc3QgUmVnYXJkcwo+IEZhcmhhbiBTaGFy
aWZmCj4gRGVzaWduIEVuZ2luZWVyCj4gU29mdHdhcmUgRmFjaWxpdGllcyBFVVYgU291cmNlCj4g
QVNNTCBWZWxkaG92ZW4tIE5ldGhlcmxhbmRzCj4KPgo+PiBEYXRlOiBGcmksIDcgQXVnIDIwMTUg
MTM6MDc6NDkgLTA0MDAKPj4gU3ViamVjdDogUmU6IFtsdHRuZy1kZXZdIFVzZXJzcGFjZSBDKysg
RnVjbnRpb24gZW50cnkgZXhpdCBpbnNlcnQKPj4gdHJhY2Vwb2ludHMKPj4gRnJvbTogYWJ1c3F1
ZUBlZmZpY2lvcy5jb20KPj4gVG86IGZhcmhhbi5zaGFyaWZmQGhvdG1haWwuY29tCj4+IENDOiBs
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4KPj4KPj4gT24gV2VkLCBBdWcgNSwgMjAxNSBhdCAx
MDozMiBBTSwgRmFyaGFuIFNoYXJpZmYKPj4gPGZhcmhhbi5zaGFyaWZmQGhvdG1haWwuY29tPiB3
cm90ZToKPj4gPiBIaSwKPj4gPgo+PiA+IEkgYW0gd29ya2luZyB3aXRoIGEgYysrIGFwcGxpY2F0
aW9uKCB1c2Vyc3BhY2UgKQo+PiA+Cj4+ID4gSSB3YW50IHRvIHBsYWNlIGluIG15IHNvdXJjZSBj
b2RlCj4+ID4gLSB0cmFjZXBvaW50KHByb3ZpZGUsbmFtZSwuLi4pIGF0IGV2ZXJ5IGZ1bmN0aW9u
IGVudHJ5IGFuZCBleGl0IC4KPj4gPgo+PiA+IGlzIGl0IHBvc3NpYmxlIHRvIGJ5IGFueSBtZWFu
cyB0byBhdXRvbWF0ZSB0aGlzIGFzIGl0IGlzIHZlcnkgY3VtYmVyc29tZQo+PiA+IHRvCj4+ID4g
cGxhY2UgaXQgbWFudWFsbHkuCj4+ID4KPj4gPgo+PiA+Cj4+ID4gQmVzdCBSZWdhcmRzCj4+ID4K
Pj4gPiBGYXJoYW4gU2hhcmlmZgo+PiA+Cj4+ID4gRmFyaGFuIFNoYXJpZmYKPj4gPgo+Pgo+PiBI
aSwKPj4KPj4gSSBzdWdnZXN0IHlvdSBoYXZlIGEgbG9vayBhdCB0aGUgTFRUbmcgZG9jdW1lbnRh
dGlvbiBvbiBmdW5jdGlvbiB0cmFjaW5nOgo+Pgo+PiBodHRwOi8vbHR0bmcub3JnL2RvY3MvI2Rv
Yy1saWJsdHRuZ+KAkXVzdOKAkWN5Z+KAkXByb2ZpbGUKPj4KPj4gSSBiZWxpZXZlIHRoaXMgbWln
aHQgc3VpdCB5b3VyIG5lZWRzLgo+Pgo+PiBSZWdhcmRzLAo+PiBBbnRvaW5lLgo+Pgo+PiA+Cj4+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gPiBs
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4+ID4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+PiA+
IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo+PiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
