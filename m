From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Building URCU in a Cygwin 64 environment
Date: Tue, 31 May 2016 10:47:45 -0400
Message-ID: <574DA411.3000603__9544.75669791481$1464706091$gmane$org@efficios.com>
References: <574D93FE.7000703@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EE498A3723
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 14:47:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8495A3400F9
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 14:47:48 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id OD5BCkUfPppq for <lttng-dev@lists.lttng.org>;
 Tue, 31 May 2016 14:47:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 345473401C5
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 14:47:47 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id sM-7wmhQ6hCp for <lttng-dev@lists.lttng.org>;
 Tue, 31 May 2016 14:47:47 +0000 (UTC)
Received: from [172.16.0.165] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id CB45D3400F9
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2016 14:47:46 +0000 (UTC)
In-Reply-To: <574D93FE.7000703@gydle.com>
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

SGkgU2ViYXN0aWVuLAoKSSdsbCBzaW1wbHkgbW92ZSB0aGUgY29udmVyc2F0aW9uIGhlcmUgKGZy
b20gSVJDKSB0byBoYXZlIGFuIGFyY2hpdmUgb2YgaXQuCgpPbiAyMDE2LTA1LTMxIDA5OjM5IEFN
LCBTZWJhc3RpZW4gQm9pc3ZlcnQgd3JvdGU6Cj4gSGksCj4KPiBJIGFtIGluIHRoZSBwcm9jZXNz
IG9mIHdyaXRpbmcgYSBibG9nIGFydGljbGUgb24gdGhlIHVzZSBvZiB0aGUgTFRUbmctVVNUIHVz
ZXJzcGFjZSBldmVudCB0cmFjZXIgb24gV2luZG93cy4KPgo+IEkgYW0gYnVpbGRpbmcgdXJjdSBh
bmQgTFRUbmctVVNUIGluIGEgQ3lnd2luIDY0IGVudmlyb25tZW50LiBUaGVuLCBJIHBsYW4gdG8g
dXNlIExUVG5nIGluIFZpc3VhbCBTdHVkaW8gQ29tbXVuaXR5LCBzbyBJIG1vc3RseSBuZWVkIGhl
YWRlcnMgKC5oKSBhbmQgc2hhcmVkIGxpYnJhcmllcyAoLmRsbCkuCgpOaWNlIQoKPgo+IFdoZW4g
SSBhbSBidWlsZGluZyB1cmN1ICgwLjkuMiksIEkgZ2V0IHRoaXMgbWVzc2FnZToKPgo+IGxpYnRv
b2w6IGxpbms6IHdhcm5pbmc6IHVuZGVmaW5lZCBzeW1ib2xzIG5vdCBhbGxvd2VkIGluIHg4Nl82
NC11bmtub3duLWN5Z3dpbiBzaGFyZWQgbGlicmFyaWVzCgpUaGlzIHNlZW1zIHJlbGF0ZWQgdG8g
YSBXaW5kb3dzIHJlc3RyaWN0aW9uIHJlZ2FyZGluZyBpbnRlci1saWJyYXJ5IApkZXBlbmRlbmNp
ZXMgWzFdLCB0aGUgcmVsZXZhbnQgcGFydDoKCiJTb21lIHBsYXRmb3Jtcywgc3VjaCBhcyBXaW5k
b3dzLCBkbyBub3QgZXZlbiBhbGxvdyB5b3UgdGhpcyAKZmxleGliaWxpdHkuIEluIG9yZGVyIHRv
IGJ1aWxkIGEgc2hhcmVkIGxpYnJhcnksIGl0IG11c3QgYmUgZW50aXJlbHkgCnNlbGYtY29udGFp
bmVkIG9yIGl0IG11c3QgaGF2ZSBkZXBlbmRlbmNpZXMga25vd24gYXQgbGluayB0aW1lICh0aGF0
IGlzLCAKaGF2ZSByZWZlcmVuY2VzIG9ubHkgdG8gc3ltYm9scyB0aGF0IGFyZSBmb3VuZCBpbiB0
aGUgLmxvIGZpbGVzIG9yIHRoZSAKc3BlY2lmaWVkIOKAmC1s4oCZIGxpYnJhcmllcyksIGFuZCB5
b3UgbmVlZCB0byBzcGVjaWZ5IHRoZSAtbm8tdW5kZWZpbmVkIApmbGFnLiBCeSBkZWZhdWx0LCBs
aWJ0b29sIGJ1aWxkcyBvbmx5IHN0YXRpYyBsaWJyYXJpZXMgb24gdGhlc2Uga2luZHMgb2YgCnBs
YXRmb3Jtcy4iCgpMb29rcyBsaWtlIHRoZSAtbm8tdW5kZWZpbmVkIG1pZ2h0IGJlIGEgZ29vZCBz
dGFydCBqdWRnaW5nIGZyb20gdGhpcyAKcGF0Y2ggSSBmb3VuZCBmb3IgdGhlIHVyY3UgY3lnd2lu
IHBvcnQgaW4geWFjcCBbMl0uCgpDaGVlcnMhCgpbMV0gCmh0dHBzOi8vd3d3LmdudS5vcmcvc29m
dHdhcmUvbGlidG9vbC9tYW51YWwvbGlidG9vbC5odG1sI0ludGVyXzAwMmRsaWJyYXJ5LWRlcGVu
ZGVuY2llcwpbMl0gCmh0dHBzOi8vZ2l0aHViLmNvbS9mZDAwL3lhY3AvYmxvYi9tYXN0ZXIvdXNl
cnNwYWNlLXJjdS91c2Vyc3BhY2UtcmN1LTAuOC43LTFibDEuc3JjLnBhdGNoCj4KPiBUaGUgaW1t
ZWRpYXRlIGNvbnNlcXVlbmNlIHNlZW1zIHRvIGJlIHRoZSBhYnNlbmNlIG9mIC5kbGwgZmlsZXMg
aW4gdGhlIHVyY3UgYnVpbGQgdGhhdCBJIGFtIGdlbmVyYXRpbmcuIE90aGVyd2lzZSwgdGhlIGJ1
aWxkIGNvbnRhaW5zIHN0YXRpYyBsaWJyYXJ5IGZpbGVzIGFuZCBoZWFkZXJzLgo+Cj4gSG93ZXZl
ciwgSSBzdXBwb3NlIHRoYXQgdGhlIC5hIHN0YXRpYyBsaWJyYXJ5IGZpbGVzIGFsc28gaGF2ZSB1
bmRlZmluZWQgc3ltYm9scyBhcyBJIGFtIGdldHRpbmcgbGlua2luZyBpc3N1ZXMgd2hlbiBidWls
ZGluZyBMVFRuZy1VU1QuCj4KPiBEbyB5b3UgaGF2ZSBhIGNsdWUgb2Ygd2hhdCBtYXkgYmUgdGhl
IGlzc3VlIGhlcmUgPyBPdGhlcndpc2UsIEkgd2lsbCBjb250aW51ZSBteSBpbnZlc3RpZ2F0aW9u
IGFuZCBnZXQgYXJvdW5kIHRoZSBpc3N1ZSBldmVudHVhbGx5Lgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKSm9uYXRoYW4gUi4gSnVsaWVuCkVm
ZmljaW9zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
