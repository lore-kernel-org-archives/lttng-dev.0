From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC lttng-modules v4] Add kmalloc failover to
	vmalloc
Date: Tue, 26 Sep 2017 15:57:05 +0000 (UTC)
Message-ID: <2136492543.18709.1506441425836.JavaMail.zimbra__42560.5157310658$1506441368$gmane$org@efficios.com>
References: <1506351380-4988-1-git-send-email-mjeanson@efficios.com>
 <1217070996.17685.1506352743808.JavaMail.zimbra@efficios.com>
 <2e9e834c-2694-f7db-c6f6-ae048dee22fe@efficios.com>
 <2105422460.18557.1506437855430.JavaMail.zimbra@efficios.com>
 <fb827131-67aa-752a-175b-041c6b3fb0ee@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1lt66sSRzv0B
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 15:55:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6708B340385
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 15:57:06 +0000 (UTC)
In-Reply-To: <fb827131-67aa-752a-175b-041c6b3fb0ee@efficios.com>
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

LS0tLS0gT24gU2VwIDI2LCAyMDE3LCBhdCAxMTo1MSBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFu
c29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gT24gMjAxNy0wOS0yNiAxMDo1NywgTWF0aGlldSBE
ZXNub3llcnMgd3JvdGU6Cj4+PiBJIGRvbid0IGtub3cgd2hhdCB0aGUgc2lkZSBlZmZlY3RzIG9m
IHNldHRpbmcgdGhlIGNhbGxlciB0byBOVUxMIHdvdWxkCj4+PiBiZSBoZXJlLCB5b3UncmUgdGhl
IGtlcm5lbCBkZXZlbG9wZXIgSSdsbCB0cnVzdCB5b3Ugb24gdGhhdCBvbmUuCj4+Pgo+Pj4gU28g
d2hpY2hldmVyIHNvbHV0aW9uIHlvdSBwcmVmZXIuCj4+IAo+PiBJJ2xsIHRha2UgeW91ciBwYXRj
aCBhcyBpcy4KPiAKPiBPaywgSSdsbCBzZW5kIGEgbm9uLVJGQyB2ZXJzaW9uLiBKdXN0IHRvIG1h
a2Ugc3VyZSB3ZSdyZSBvbiB0aGUgc2FtZQo+IHBhZ2UsIEkgd291bGRuJ3QgYmFja3BvcnQgdGhp
cyB0byB0aGUgc3RhYmxlIGJyYW5jaGVzIHNpbmNlIGl0J3MgYQo+IHByZXR0eSBzaWduaWZpY2Fu
dCBjaGFuZ2Ugb2YgYmVoYXZpb3VyLgoKQWxyZWFkeSBtZXJnZWQgaW50byBtYXN0ZXIsIDIuMTAs
IDIuOSwgc29ycnkuCgpNYXRoaWV1CgoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIElu
Yy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
