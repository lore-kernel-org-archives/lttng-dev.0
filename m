From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC lttng-modules v4] Add kmalloc failover to
	vmalloc
Date: Tue, 26 Sep 2017 11:59:16 -0400
Message-ID: <7e5b6ade-ba4d-d7eb-c1ce-6565bce87933__7345.4434438192$1506441568$gmane$org@efficios.com>
References: <1506351380-4988-1-git-send-email-mjeanson@efficios.com>
 <1217070996.17685.1506352743808.JavaMail.zimbra@efficios.com>
 <2e9e834c-2694-f7db-c6f6-ae048dee22fe@efficios.com>
 <2105422460.18557.1506437855430.JavaMail.zimbra@efficios.com>
 <fb827131-67aa-752a-175b-041c6b3fb0ee@efficios.com>
 <2136492543.18709.1506441425836.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1lxy1tM5zv0f
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 15:59:17 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D2FED34020A
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 16:00:25 +0000 (UTC)
In-Reply-To: <2136492543.18709.1506441425836.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wOS0yNiAxMTo1NywgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gLS0tLS0gT24g
U2VwIDI2LCAyMDE3LCBhdCAxMTo1MSBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmlj
aW9zLmNvbSB3cm90ZToKPiAKPj4gT24gMjAxNy0wOS0yNiAxMDo1NywgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4+Pj4gSSBkb24ndCBrbm93IHdoYXQgdGhlIHNpZGUgZWZmZWN0cyBvZiBzZXR0
aW5nIHRoZSBjYWxsZXIgdG8gTlVMTCB3b3VsZAo+Pj4+IGJlIGhlcmUsIHlvdSdyZSB0aGUga2Vy
bmVsIGRldmVsb3BlciBJJ2xsIHRydXN0IHlvdSBvbiB0aGF0IG9uZS4KPj4+Pgo+Pj4+IFNvIHdo
aWNoZXZlciBzb2x1dGlvbiB5b3UgcHJlZmVyLgo+Pj4KPj4+IEknbGwgdGFrZSB5b3VyIHBhdGNo
IGFzIGlzLgo+Pgo+PiBPaywgSSdsbCBzZW5kIGEgbm9uLVJGQyB2ZXJzaW9uLiBKdXN0IHRvIG1h
a2Ugc3VyZSB3ZSdyZSBvbiB0aGUgc2FtZQo+PiBwYWdlLCBJIHdvdWxkbid0IGJhY2twb3J0IHRo
aXMgdG8gdGhlIHN0YWJsZSBicmFuY2hlcyBzaW5jZSBpdCdzIGEKPj4gcHJldHR5IHNpZ25pZmlj
YW50IGNoYW5nZSBvZiBiZWhhdmlvdXIuCj4gCj4gQWxyZWFkeSBtZXJnZWQgaW50byBtYXN0ZXIs
IDIuMTAsIDIuOSwgc29ycnkuCj4gCj4gTWF0aGlldQo+IAo+IAoKV2VsbCB0aGVuLCBsZXQncyBt
YWtlIHN1cmUgd2UgdGVzdCBpdCBwcm9wZXJseSBiZWZvcmUgZG9pbmcgYW55IHBvaW50CnJlbGVh
c2UgdG8gdGhlIHN0YWJsZSBicmFuY2hlcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
