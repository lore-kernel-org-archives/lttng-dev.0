From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH 3/4] Correct the behavior of the
 utils_expand_path function
Date: Thu, 14 Nov 2013 13:46:27 +0000 (UTC)
Message-ID: <660157471.67103.1384436787478.JavaMail.zimbra__801.497980910604$1384436832$gmane$org@efficios.com>
References: <1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
	<20131112195134.GB12183@thessa>
	<1384320878-28808-4-git-send-email-raphael.beamonte@gmail.com>
	<647704866.66921.1384397059144.JavaMail.zimbra@efficios.com>
	<CAE_Gge2rcE7-pH9KBh9WAkfcQYM-aNw1iAb2brUeyjVvA=Nn3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgxFd-0000Mi-Dj
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 08:46:30 -0500
In-Reply-To: <CAE_Gge2rcE7-pH9KBh9WAkfcQYM-aNw1iAb2brUeyjVvA=Nn3Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?Rapha=C3=ABl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJSYXBoYcOrbCBCZWFtb250ZSIg
PHJhcGhhZWwuYmVhbW9udGVAZ21haWwuY29tPgo+IFRvOiAiTWF0aGlldSBEZXNub3llcnMiIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4gQ2M6ICJEYXZpZCBHb3VsZXQiIDxkZ291
bGV0QGVmZmljaW9zLmNvbT4sIGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDEzLCAyMDEzIDEwOjI3OjAzIFBNCj4gU3ViamVjdDogUmU6IFtsdHRu
Zy1kZXZdIFtsdHRuZy10b29scyBQQVRDSCAzLzRdIENvcnJlY3QgdGhlIGJlaGF2aW9yIG9mIHRo
ZSB1dGlsc19leHBhbmRfcGF0aCBmdW5jdGlvbgo+IAo+ID4gSSBtaWdodCBiZSBtaXNzaW5nIHNv
bWV0aGluZywgYnV0IGhvdyBhYm91dCwgaW5zdGVhZDoKPiA+Cj4gPiAxKSBpZiBwYXRoIHN0YXJ0
IHdpdGggLywgZGlyZWN0bHkgcGFzcyBpdCB0byByZWFscGF0aCgpCj4gPiAyKSBpZiBwYXRoIGRv
ZXMgbm90IHN0YXJ0IHdpdGggLywgcHJlcGVuZCBnZXRjd2QoKSB0byBpdCwgYW5kIHRoZW4gY2Fs
bAo+ID4gcmVhbHBhdGgoKSBvbiB0aGUgcmVzdWx0Lgo+ID4KPiA+IElmIHdlIGNhbiBkbyB0aGUg
c2FtZSByZXN1bHQgYXMgdGhpcyBwYXRjaCB3aXRob3V0IHJlaW1wbGVtZW50aW5nIHRyaWNreQo+
ID4gc3RyaW5nIGhhbmRsaW5nLCB3ZSBzaG91bGQgcmVhbGx5IGFpbSBmb3IgcmUtdXNpbmcgZXhp
c3RpbmcgbGlicmFyaWVzLgo+ID4KPiA+IFRob3VnaHRzID8KPiAKPiBIZWxsbyBNYXRoaWV1LAo+
IAo+IFRoaW5nIGlzIHJlYWxwYXRoIG9ubHkgd29ya3MgaWYgdGhlIHBhdGggZXhpc3RzIChyZWFs
cGF0aCgzKSkuIEkKPiBwZXJoYXBzIHdhbnQgdG8gZ2l2ZSBhcyBhcmd1bWVudCBhbiBhYnNvbHV0
ZSBwYXRoIHRoYXQgZG9lcyBub3QgZXhpc3QsCj4gb3IgYSBwYXRoIGNvbnRhaW5pbmcgc3RyaW5n
cyBzdWNoIGFzICcuLi8nIG9yICcuLycuIEluIHN1Y2ggY2FzZXMsCj4gcmVhbHBhdGggd291bGQg
ZG8gbm8gZ29vZCwgYW5kIGlmIHdlIGRvbid0IGFjY2VwdCB0byB1c2UgdW5leGlzdGluZwo+IHBh
dGhzLCB0aGVuIHRoZXJlIGlzIG5vIHBvaW50IGluIHVzaW5nIGEgcmVjdXJzaXZlIG1rZGlyLgo+
IElmIGZhY3QsIGlmIHJlYWxwYXRoIHdvdWxkIHdvcmsgaW4gc3VjaCBjYXNlcywgdXNpbmcgYW4g
J2lmJyB3b3VsZCBub3QKPiBldmVuIGJlIG5lY2Vzc2FyeSwgd2UgY291bGQganVzdCBjYWxsIHJl
YWxwYXRoIGFuZCBsZXQgaXQgcmVzb2x2ZSB0aGUKPiBjdXJyZW50IGRpcmVjdG9yeSBpZiBuZWNl
c3NhcnkuCj4gCj4gSG9wZSBpdCBoZWxwcyB0byB1bmRlcnN0YW5kLAoKWWVzLCBpdCBkb2VzLCB0
aGFuayB5b3UhCgpNYXRoaWV1Cgo+IAo+IFJhcGhhw6tsCj4gCgotLSAKTWF0aGlldSBEZXNub3ll
cnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
