From: "Staffan Tjernstrom" <staffan@eternaltraveller.com>
Subject: Re: [RFC] perf sampling library for LTTng-UST
Date: Thu, 17 Nov 2016 10:14:27 -0600
Message-ID: <862192408219b719218a2de866be415e.squirrel__41552.8681631715$1479399282$gmane$org@email.powweb.com>
References: <1483f0d3-da42-8269-a25b-a45d7db5e1ea@gmail.com>
Reply-To: stjernstrom@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from walmailout04.yourhostingaccount.com
 (mailout04.yourhostingaccount.com [65.254.254.70])
 by lists.lttng.org (Postfix) with ESMTPS id 3tKR7G5nqBzmcK
 for <lttng-dev@lists.lttng.org>; Thu, 17 Nov 2016 16:15:38 +0000 (UTC)
Received: from mailscan14.yourhostingaccount.com ([10.1.15.14]
 helo=walmailscan14.yourhostingaccount.com)
 by walmailout04.yourhostingaccount.com with esmtp (Exim)
 id 1c7PKW-0000Hu-Ob
 for lttng-dev@lists.lttng.org; Thu, 17 Nov 2016 11:14:28 -0500
Received: from [10.114.3.32] (helo=walimpout12)
 by walmailscan14.yourhostingaccount.com with esmtp (Exim)
 id 1c7PKW-0004bP-G3
 for lttng-dev@lists.lttng.org; Thu, 17 Nov 2016 11:14:28 -0500
In-Reply-To: <1483f0d3-da42-8269-a25b-a45d7db5e1ea@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

V2hpbHN0IEknbSBub3QgY29tcGV0ZW50IHRvIGNvbW1lbnQgb24gdGhlIGltcGxlbWVudGF0aW9u
LCBJIHJlYWxseQpsaWtlIHRoZSBmdW5jdGlvbmFsaXR5IC0gaXQncyBnb2luZyB0byBiZSBhIGxp
ZmUtc2F2ZXIgZm9yIG1lLgoKVGhlIG5lZWQgdG8gc2FtcGxlIHBlcmYgY291bnRlcnMgZnJvbSB1
c2VyIHNwYWNlIHByb2dyYW1zIGlzIGh1Z2UgaW4KbXkgd29ybGQuCj4gSGVsbG8hCj4KPiBJIGRp
ZCBhIHNtYWxsIHNoYXJlZCBsaWJyYXJ5IGZvciBwcm9maWxpbmcgY29kZSB1c2luZyBwZXJmIHNh
bXBsaW5nCj4gYW5kIExUVG5nLVVTVDoKPgo+ICAgaHR0cHM6Ly9naXRodWIuY29tL2dpcmFsZGVh
dS9sdHRuZy11c3QvdHJlZS9zYW1wbGluZy9saWJsdHRuZy11c3Qtc2FtcGxpbmcKPgo+IEl0IHdv
cmtzIGJ5IHByZWxvYWRpbmcgdGhlIGxpYnJhcnkgd2hlbiBleGVjdXRpbmcgYSBwcm9ncmFtLiBJ
bnNpZGUKPiB0aGUgbGlicmFyeSBjb25zdHJ1Y3RvciwgYSBwZXJmIGNvdW50ZXIgaXMgY3JlYXRl
ZCBhbmQgc2FtcGxlcyBhcmUKPiBzYXZlZCBpbnNpZGUgdGhlIFNJR0lPIGhhbmRsZXIgdXNpbmcg
YW4gTFRUbmctVVNUIHRyYWNlcG9pbnQuIFRoZSBjYWxsCj4gc3RhY2sgaXMgb2J0YWluZWQgdXNp
bmcgbGlidW53aW5kLCBhbmQgdGh1cyBpdCB3b3JrcyBldmVuIHdpdGhvdXQKPiBmcmFtZSBwb2lu
dGVycyBhbmQgd2l0aCB1bm1vZGlmaWVkIGV4ZWN1dGFibGVzLgo+Cj4gUHJlbGltaW5hcnkgb3Zl
cmhlYWQgbWVhc3VyZSB3aXRoIHRoZSBkZWZhdWx0IHNhbXBsaW5nIHBlcmlvZCBvZiAxRTQKPiBm
b3IgY3B1IGN5Y2xlcyBpcyBhYm91dCA4LjUlLCBvciAyLjJ1cyBwZXIgZXZlbnQuIE9uIG15IG1h
Y2hpbmUsIGFib3V0Cj4gMzhrIHNhbXBsZXMgcGVyIHNlY29uZCBhcmUgZ2VuZXJhdGVkLiBUaGlz
IGZpZ3VyZSBpcyBvYnRhaW5lZCB3aGVuCj4gY29tcGlsaW5nIGxpYnVud2luZCB3aXRob3V0IHNp
Z25hbCByZS1lbnRyYW5jZSBzdXBwb3J0Lgo+Cj4gR2VuZXZpZXZlIEJhc3RpZW4gZGlkIGEgbmlj
ZSB2aWV3IGluIFRyYWNlQ29tcGFzcyB0byBsb2FkIHRoaXMgdHJhY2UKPiBhbmQgZGlzcGxheSB0
aGUgY29ycmVzcG9uZGluZyBjYWxsIGdyYXBoIHZpZXcuCj4KPiAgIGh0dHA6Ly9zZWNyZXRhaXJl
LmRvcnNhbC5wb2x5bXRsLmNhL35nYmFzdGllbi9zY3JlZW5zaG90cy9sdHRuZ19zYW1wbGluZ19j
YWxsc3RhY2sucG5nCj4KPiBUaGUgY291bnRlciBpcyBoYXJkIGNvZGVkIG5vdywgYnV0IGl0J3Mg
anVzdCBhIHByb3RvdHlwZSB0bwo+IGRlbW9uc3RyYXRlIHRoZSBjb25jZXB0LiBJIHdvdWxkIGZp
bmQgaXQgdmVyeSBjb29sIHRvIHNlZSBzdWNoIGZlYXR1cmUKPiBpbiBMVFRuZy4gV2hhdCBkbyB5
b3UgdGhpbms/Cj4KPiBDaGVlcnMsCj4KPiBGcmFuY2lzCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
