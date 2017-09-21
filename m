From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC v2] Add kmalloc failover to vmalloc
Date: Thu, 21 Sep 2017 18:52:13 +0000 (UTC)
Message-ID: <779758199.15975.1506019933645.JavaMail.zimbra__38656.9093484015$1506019888$gmane$org@efficios.com>
References: <1506018582-22403-1-git-send-email-mjeanson@efficios.com>
 <1705207820.15923.1506019177110.JavaMail.zimbra@efficios.com>
 <73494ae7-dd98-4069-6b2c-49fad21698ca@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xym0l2hjRzC5N
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 18:51:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 528CE34020B
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 18:52:14 +0000 (UTC)
In-Reply-To: <73494ae7-dd98-4069-6b2c-49fad21698ca@efficios.com>
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

LS0tLS0gT24gU2VwIDIxLCAyMDE3LCBhdCAyOjQzIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5z
b25AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBPbiAyMDE3LTA5LTIxIDE0OjM5LCBNYXRoaWV1IERl
c25veWVycyB3cm90ZToKPj4gLS0tLS0gT24gU2VwIDIxLCAyMDE3LCBhdCAyOjI5IFBNLCBNaWNo
YWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNpb3MuY29tIHdyb3RlOgo+PiAKPj4+IFRoaXMgcGF0
Y2ggaXMgYmFzZWQgb24gdGhlIGt2bWFsbG9jIGhlbHBlcnMgaW50cm9kdWNlZCBpbiBrZXJuZWwg
NC4xMi4KPj4+Cj4+PiBJdCB3aWxsIGdyYWNlZnVsbHkgZmFpbG92ZXIgbWVtb3J5IGFsbG9jYXRp
b25zIG9mIG1vcmUgdGhhbiBvbmUgcGFnZSB0bwo+Pj4gdm1hbGxvYyBmb3Igc3lzdGVtcyB1bmRl
ciBoaWdoIG1lbW9yeSBwcmVzc3VyZSBvciBmcmFnbWVudGF0aW9uLgo+Pj4KPj4+IEkgb25seSB1
c2VkIGl0IGluIGx0dG5nLWV2ZW50cy5jIGFzIGEgUE9DLCBtb3N0IGFsbG9jYXRpb25zIGZpdCBp
bnRvIGEKPj4+IHNpbmdsZSBwYWdlIHNvIEknbSBub3Qgc3VyZSBob3cgdXNlZnVsIHRoaXMgYWN0
dWFsbHkgaXMuCj4+Pgo+Pj4gVGhvdWdodHM/Cj4+IAo+PiBKdXN0IHVwZGF0ZSB0aGUgY2hhbmdl
bG9nIHRvIHNwZWNpZnkgd2h5IHdlIG5lZWQgdGhpcyBmb3Igc3RydWN0IGx0dG5nX3Nlc3Npb24K
Pj4gKH4zMmtCKSwgYW5kIHlvdSBjYW4gc3VibWl0IGl0IGZvciBnb29kIHdpdGggYSAiRml4OiAi
IHRhZy4KPiAKPiBJJ20gbm90IHN1cmUgaXQgc2hvdWxkIGJlIGEgZml4LCBmb3IgdGhpcyB0byBi
ZSBvZiBhbnkgdXNlIGFsbCB0aGUgb3RoZXIKPiBhbGxvY2F0aW9ucyBiaWdnZXIgdGhhbiBQQUdF
X1NJWkUgc2hvdWxkIGFsc28gdXNlIGl0LiBPdGhlcndpc2UsIHRoZQo+IHNlc3Npb24gYWxsb2Nh
dGlvbiB3aWxsIHN1Y2NlZWQgYnV0IHRoZSBuZXh0IHNpemVhYmxlIGFsbG9jYXRpb24gd2lsbAo+
IHN0aWxsIGZhaWwuCgpXaGF0IG90aGVyIGFsbG9jYXRpb25zIGxhcmdlciB0aGFuIFBBR0VfU0la
RSB1c2luZyBrbWFsbG9jIGRpZCB5b3Ugc3BvdCA/CgpUaGFua3MsCgpNYXRoaWV1CgoKPiAKPj4g
Cj4+IFRoYW5rcywKPj4gCj4gPiBNYXRoaWV1CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
