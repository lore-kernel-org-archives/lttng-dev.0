From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC lttng-modules v4] Add kmalloc failover to
	vmalloc
Date: Tue, 26 Sep 2017 16:03:53 +0000 (UTC)
Message-ID: <727182319.18716.1506441833522.JavaMail.zimbra__37746.8651663095$1506441779$gmane$org@efficios.com>
References: <1506351380-4988-1-git-send-email-mjeanson@efficios.com>
 <1217070996.17685.1506352743808.JavaMail.zimbra@efficios.com>
 <2e9e834c-2694-f7db-c6f6-ae048dee22fe@efficios.com>
 <2105422460.18557.1506437855430.JavaMail.zimbra@efficios.com>
 <fb827131-67aa-752a-175b-041c6b3fb0ee@efficios.com>
 <2136492543.18709.1506441425836.JavaMail.zimbra@efficios.com>
 <7e5b6ade-ba4d-d7eb-c1ce-6565bce87933@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1m1y3smQzv1D
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 16:02:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2BBB53403A2
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 16:03:54 +0000 (UTC)
In-Reply-To: <7e5b6ade-ba4d-d7eb-c1ce-6565bce87933@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gU2VwIDI2LCAyMDE3LCBhdCAxMTo1OSBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFu
c29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gT24gMjAxNy0wOS0yNiAxMTo1NywgTWF0aGlldSBE
ZXNub3llcnMgd3JvdGU6Cj4+IC0tLS0tIE9uIFNlcCAyNiwgMjAxNywgYXQgMTE6NTEgQU0sIE1p
Y2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lvcy5jb20gd3JvdGU6Cj4+IAo+Pj4gT24gMjAx
Ny0wOS0yNiAxMDo1NywgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4+Pj4+IEkgZG9uJ3Qga25v
dyB3aGF0IHRoZSBzaWRlIGVmZmVjdHMgb2Ygc2V0dGluZyB0aGUgY2FsbGVyIHRvIE5VTEwgd291
bGQKPj4+Pj4gYmUgaGVyZSwgeW91J3JlIHRoZSBrZXJuZWwgZGV2ZWxvcGVyIEknbGwgdHJ1c3Qg
eW91IG9uIHRoYXQgb25lLgo+Pj4+Pgo+Pj4+PiBTbyB3aGljaGV2ZXIgc29sdXRpb24geW91IHBy
ZWZlci4KPj4+Pgo+Pj4+IEknbGwgdGFrZSB5b3VyIHBhdGNoIGFzIGlzLgo+Pj4KPj4+IE9rLCBJ
J2xsIHNlbmQgYSBub24tUkZDIHZlcnNpb24uIEp1c3QgdG8gbWFrZSBzdXJlIHdlJ3JlIG9uIHRo
ZSBzYW1lCj4+PiBwYWdlLCBJIHdvdWxkbid0IGJhY2twb3J0IHRoaXMgdG8gdGhlIHN0YWJsZSBi
cmFuY2hlcyBzaW5jZSBpdCdzIGEKPj4+IHByZXR0eSBzaWduaWZpY2FudCBjaGFuZ2Ugb2YgYmVo
YXZpb3VyLgo+PiAKPj4gQWxyZWFkeSBtZXJnZWQgaW50byBtYXN0ZXIsIDIuMTAsIDIuOSwgc29y
cnkuCj4+IAo+PiBNYXRoaWV1Cj4+IAo+PiAKPiAKPiBXZWxsIHRoZW4sIGxldCdzIG1ha2Ugc3Vy
ZSB3ZSB0ZXN0IGl0IHByb3Blcmx5IGJlZm9yZSBkb2luZyBhbnkgcG9pbnQKPiByZWxlYXNlIHRv
IHRoZSBzdGFibGUgYnJhbmNoZXMuCgpPZiBjb3Vyc2UsCgpUaGFua3MsCgpNYXRoaWV1CgoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
