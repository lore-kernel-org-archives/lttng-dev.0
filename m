From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Using Babeltrace to write CTF for MPI application
Date: Tue, 4 Apr 2017 19:52:47 -0400
Message-ID: <e60c08f5-189c-bacc-b4bc-5438c6a36476__25159.7039089122$1491349990$gmane$org@efficios.com>
References: <CAK-w0DeOHsrygOt4CLVBB55edg6W+hrEzX2+A-UwFn6E14HDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vyQlY3nBlz5H
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 23:53:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0528B34020C
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 23:53:58 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Kn51vlCON7vk for <lttng-dev@lists.lttng.org>;
 Tue,  4 Apr 2017 23:53:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B96834022A
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 23:53:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zhPEsNJO6UKc for <lttng-dev@lists.lttng.org>;
 Tue,  4 Apr 2017 23:53:57 +0000 (UTC)
Received: from [192.168.2.14] (mtrlpq2848w-70-48-16-61.dsl.bell.ca
 [70.48.16.61])
 by mail.efficios.com (Postfix) with ESMTPSA id 4588134020C
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 23:53:57 +0000 (UTC)
In-Reply-To: <CAK-w0DeOHsrygOt4CLVBB55edg6W+hrEzX2+A-UwFn6E14HDoQ@mail.gmail.com>
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

SGkgUm9ja3ksCgpOb3Qgc3VyZSBpZiBwZXJ0aW5lbnQgYnV0IGRpZCB5b3UgdGFrZSBhIGxvb2sg
YXQgdGhlIGJhcmVjdGYgWzFdIHByb2plY3Q/CgpDaGVlcnMKClsxXSBodHRwczovL2dpdGh1Yi5j
b20vZWZmaWNpb3MvYmFyZWN0ZgoKT24gMjAxNy0wNC0wNCAwNToyOSBQTSwgUm9ja3kgRHVubGFw
IHdyb3RlOgo+IEkgYW0gaW5zdHJ1bWVudGluZyBhbiBNUEkgYXBwbGljYXRpb24gdG8gb3V0cHV0
IGEgY3VzdG9tIGFwcGxpY2F0aW9uIHRyYWNlIGluIENURiB1c2luZyBCYWJlbHRyYWNlIDEuNS4y
LiAgSSB3b3VsZCBsaWtlIHRvIGVuZCB1cCB3aXRoIGEgc2luZ2xlIHRyYWNlIHdpdGggbXVsdGlw
bGUgc3RyZWFtcywgb25lIHBlciBwcm9jZXNzLiAgQWxsIHN0cmVhbXMgc2hhcmUgdGhlIHNhbWUg
c3RyZWFtIGNsYXNzIChhbmQgbWV0YWRhdGEpLiBBbGwgcHJvY2Vzc2VzIGhhdmUgYWNjZXNzIHRv
IHRoZSBzYW1lIGZpbGUgc3lzdGVtLiAgSSBhbSB1c2luZyB0aGUgQyBDVEYgd3JpdGVyIEFQSSB1
c2luZyB0aGlzIHRlc3QgYXMgYW4gZXhhbXBsZToKPiBodHRwczovL2dpdGh1Yi5jb20vZWZmaWNp
b3MvYmFiZWx0cmFjZS9ibG9iL3N0YWJsZS0xLjUvdGVzdHMvbGliL3Rlc3RfY3RmX3dyaXRlci5j
Cj4gCj4gV2hhdCBJIGhhdmUgaW4gbWluZCBpcyBzb21ldGhpbmcgbGlrZSB0aGlzOiBwcm9jZXNz
IDAgd291bGQgYmUgcmVzcG9uc2libGUgZm9yIHdyaXRpbmcgdGhlIG1ldGFkYXRhIGFuZCBpdHMg
b3duIHN0cmVhbSwgd2hpbGUgYWxsIG90aGVyIHByb2Nlc3NlcyB3b3VsZCBvbmx5IG5lZWQgdG8g
d3JpdGUgdGhlaXIgb3duIHN0cmVhbS4KPiAKPiBUaGUgaXNzdWUgSSBoYXZlIHJ1biBpbnRvIGlz
IHRoYXQgdGhlIGluZGl2aWR1YWwgc3RyZWFtIGZpbGUgbmFtZXMgYXJlIGRldGVybWluZWQgYnkg
YXBwZW5kaW5nIHN0cmVhbS0+aWQgdG8gdGhlIHN0cmVhbSBmaWxlbmFtZSBhbmQgdGhlIHN0cmVh
bSBpZCBpcyBkZXRlcm1pbmVkIGJlaGluZCB0aGUgc2NlbmVzIGFzIHN0cmVhbS0+aWQgPSBzdHJl
YW1fY2xhc3MtPm5leHRfc3RyZWFtX2lkKysuICBTaW5jZSBlYWNoIHByb2Nlc3MgaGFzIGl0cyBv
d24gYWRkcmVzcyBzcGFjZSwgYWxsIHByb2Nlc3NlcyB3YW50IHN0cmVhbSBpZCBvZiAwLgo+IAo+
IElzIHRoZXJlIGEgd2F5IHVzaW5nIHRoZSBjdXJyZW50IEFQSSB0byBleHBsaWNpdGx5IHNldCB0
aGUgc3RyZWFtIGlkIHNvIHRoYXQgZWFjaCBwcm9jZXNzIHdpbGwgd3JpdGUgdG8gYSBzZXBhcmF0
ZSBmaWxlPwo+IAo+IEknbSBhbHNvIG9wZW4gZm9yIHN1Z2dlc3Rpb25zIG9uIHRoZSBvdmVyYWxs
IGFwcHJvYWNoLiAgVGhlIG1haW4gcmVhc29uIHRvIGhhdmUgZWFjaCBwcm9jZXNzIGFzIGEgc2Vw
YXJhdGUgc3RyZWFtIGluIGEgc2luZ2xlIHRyYWNlIGlzIHNvIHRoYXQgSSBjYW4gb3BlbiB0aGUg
ZW50aXJlIHRyYWNlIGluIGFuIGFuYWx5c2lzIHRvb2wgbGlrZSBUcmFjZUNvbXBhc3MgYW5kIHNl
ZSBhbGwgcHJvY2Vzc2VzIHRvZ2V0aGVyLgo+IAo+IFJvY2t5Cj4gCj4gCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPiAKCi0tIApKb25hdGhhbiBSLiBK
dWxpZW4KRWZmaWNpb3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
