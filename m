From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Problem using pthread and libc wrapper
Date: Wed, 29 Jun 2016 15:47:49 -0400
Message-ID: <577425E5.9080503__26600.3630160869$1467229702$gmane$org@efficios.com>
References: <d705ea6e085e4d1ab85d123e9bafaa5a@itk-engineering.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 58A58A1E94
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jun 2016 19:47:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 246E6340329
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jun 2016 19:47:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id aepgapUUjwH3 for <lttng-dev@lists.lttng.org>;
 Wed, 29 Jun 2016 19:47:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7FFBF34032A
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jun 2016 19:47:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id XyIvfvIgRW9o for <lttng-dev@lists.lttng.org>;
 Wed, 29 Jun 2016 19:47:51 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 040D9340329
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jun 2016 19:47:50 +0000 (UTC)
In-Reply-To: <d705ea6e085e4d1ab85d123e9bafaa5a@itk-engineering.de>
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

SGkgQ2hyaXN0b3BoZXIsCgpJIGd1ZXNzIHlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGlzIFsxXS4g
SSdtIHZlcnkgc29ycnkgSSBmb3Jnb3QgdG8gc2VuZCAKdGhlIGZvbGxvdy11cCB0byB0aGUgbWFp
bGluZyBsaXN0IGJ1dCBoZXJlIGlzIGEgc2hvcnQgZXhwbGljYXRpb246CgotIGx0dG5nLXVzdCB1
c2VzIGEgY29tYmluYXRpb24gb2YgaGlkZGVuIGFuZCB3ZWFrIGF0dHJpYnV0ZSBmb3IgaXQncyAK
dHJhY2Vwb2ludCBzdGFydCBhbmQgc3RvcCBzZWN0aW9uLgotIFRoZSBjdXJyZW50IGdjYyBpbmNs
dWRlZCBpbiB5b2N0by9maWRvIGlzIGVpdGhlciBnY2MgNC44LzQuOS4gQm90aCAKaGF2ZSBhIHNl
cmllcyBvZiBwYXRjaGVzIHRoYXQgZ2V0cyBhcHBsaWVkIGJlZm9yZSBpdCdzIGNvbXBpbGF0aW9u
LgotIE9uZSBwYXRjaCBjaGFuZ2UgdGhlIGJlaGF2aW9yIHJlZ2FyZGluZyB0aGUgd2VhayBhbmQg
aGlkZGVuIGF0dHJpYnV0ZXMgCm9uIGNvbXBpbGF0aW9uLgotIFRoZSBwYXRjaCBjYXVzZWQgdGhl
IHJlZ2lzdHJhdGlvbiBvZiBhcHBsaWNhdGlvbi1zcGVjaWZpYyB0cmFjZXBvaW50cyAKb25seSBz
aW5jZSB0aGUgaW50ZXJuYWwgcG9pbnRlciB0byB0aGUgcmVnaXN0ZXJpbmcgc2VjdGlvbiB3YXMg
YWx3YXlzIAp0aGUgc2FtZS4KLSBXZSBoYXZlIGFscmVhZHkgY29udGFjdGVkIHRoZSBPRSBtYWls
aW5nIGxpc3QgcmVnYXJkaW5nIHRoaXMgWzJdLgotIFlvdSBjYW4gc2ltcGx5IGVtcHR5IHRoZSBw
YXRjaCBbNF0gaW4gcXVlc3Rpb24gYW5kIHJlYnVpbGQgdGhlIHRvb2xjaGFpbi4KCkNoZWVycwoK
ClsxXSBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9waXBlcm1haWwvbHR0bmctZGV2LzIwMTYtSmFu
dWFyeS8wMjU0MzcuaHRtbApbMl0gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvcGlwZXJtYWlsL2x0
dG5nLWRldi8yMDE2LUphbnVhcnkvMDI1NDU0Lmh0bWwKWzNdIGNhdCAvZGV2L251bGwgPiAKLi9t
ZXRhL3JlY2lwZXMtZGV2dG9vbHMvZ2NjL2djYy00LjkvMDAyNC1QUi10YXJnZXQtMzIyMTkucGF0
Y2gKCgoKT24gMjAxNi0wNi0yOSAwMToyMiBBTSwgQ2hyaXN0b3BoZXIgU2Nod2FnZXIgd3JvdGU6
Cj4KPiBIZWxsbywKPgo+IEkgcmFuIGludG8gdGhlIHNhbWUgaXNzdWUgbGlrZSBNYXJ0aW4uIElz
IHRoZXJlIGFscmVhZHkgYSBmaXggZm9yIGl0ID8KPgo+IFJlZ2FyZHMsCj4KPiBDaHJpc3RvcGhl
cgo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
CgotLSAKSm9uYXRoYW4gUi4gSnVsaWVuCkVmZmljaW9zCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
