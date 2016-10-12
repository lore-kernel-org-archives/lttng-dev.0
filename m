From: "Staffan Tjernstrom" <staffan@eternaltraveller.com>
Subject: Re: [lttng-ust] [babeltrace] use case question - field
 names in event classes
Date: Wed, 12 Oct 2016 08:51:46 -0500
Message-ID: <7110ec441dc2f14caee4a447826c31f7.squirrel__29609.4337631532$1476282183$gmane$org@email.powweb.com>
References: <8867c80160a75f382ac5dd3f50d2014b.squirrel@email.powweb.com>
 <CAB4xu_0ohmGica3QkEMR2sXNdhmqQvnfethmjHQig3EFaULrhQ@mail.gmail.com>
Reply-To: stjernstrom@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from walmailout09.yourhostingaccount.com
 (walmailout09.yourhostingaccount.com [65.254.253.77])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CE8A6A0A07
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 14:24:14 +0000 (UTC)
Received: from mailscan14.yourhostingaccount.com ([10.1.15.14]
 helo=walmailscan14.yourhostingaccount.com)
 by walmailout09.yourhostingaccount.com with esmtp (Exim)
 id 1buJwz-00014A-9J
 for lttng-dev@lists.lttng.org; Wed, 12 Oct 2016 09:52:05 -0400
Received: from [10.114.3.31] (helo=walimpout11)
 by walmailscan14.yourhostingaccount.com with esmtp (Exim)
 id 1buJwz-0006ec-53
 for lttng-dev@lists.lttng.org; Wed, 12 Oct 2016 09:52:05 -0400
In-Reply-To: <CAB4xu_0ohmGica3QkEMR2sXNdhmqQvnfethmjHQig3EFaULrhQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Pgo+IEluIHRoZSBjb2RlLCBiZWZvcmUgY2FsbGluZyB0aGUgYXNzb2NpYXRlZCBgdHdvX2ludHNf
YW5kX3N0cmluZ2AKPiB0cmFjZXBvaW50LCBhbmQgb25seSBvbmNlOgo+Cj4gICAgIHRyYWNlcG9p
bnQobXlfYXBwLCBsb2dfc3RhdGVtZW50X2ZpZWxkX25hbWVzLCAxLAo+ICAgICAgICAgICAgICAg
ICJ3aWRnZXRfaGVpZ2h0IiwgIndpZGdldF93aWR0aCIsICJ3aWRnZXRfbmFtZSIsICIiKTsKPgo+
IFRoZW46Cj4KPiAgICAgdHJhY2Vwb2ludChteV9hcHAsIHR3b19pbnRzX2FuZF9zdHJpbmcsIDEs
IGhlaWdodCwgd2lkdGgsIG5hbWUpOwo+Cj4gVGhlbiBpbiB5b3VyIFB5dGhvbiBzY3JpcHQgeW91
IGNhbiByZWdpc3RlciB0aGUgZHluYW1pYyBmaWVsZCBuYW1lcwo+IHdoZW4KPiB5b3UgZ2V0IGEg
YGxvZ19zdGF0ZW1lbnRfZmllbGRfbmFtZXNgIGV2ZW50IGFuZCB1c2UgdGhlbSB3aGVuIHlvdSBn
ZXQKPiBhCj4gInJlYWwiIGV2ZW50IChub3QgdGVzdGVkKToKPgo+ICAgICBpZF90b19maWVsZF9u
YW1lcyA9IHt9Cj4KPiAgICAgIyBvcGVuIHRyYWNlLCBldGMuCj4KPiAgICAgIyBzb21lIGxvb3Ag
b3ZlciB0aGUgdHJhY2UncyBldmVudHM6Cj4gICAgICAgICBpZiBldnQubmFtZSA9PSAnbG9nX3N0
YXRlbWVudF9maWVsZF9uYW1lcyc6Cj4gICAgICAgICAgICAgZmllbGRfbmFtZXMgPSAoZXZ0Wydh
cmcxJ10sIGV2dFsnYXJnMiddLCBldnRbJ2FyZzMnXSwKPiBldnRbJ2FyZzQnXSkKPiAgICAgICAg
ICAgICBpZF90b19maWVsZF9uYW1lc1tldnRbJ2lkJ11dID0gZmllbGRfbmFtZXMKPiAgICAgICAg
IGVsaWYgZXZ0Lm5hbWUgPT0gJ3R3b19pbnRzX2FuZF9zdHJpbmcnOgo+ICAgICAgICAgICAgIGZp
ZWxkX25hbWVzID0gaWRfdG9fZmllbGRfbmFtZXNbZXZ0WydpZCddXQo+ICAgICAgICAgICAgIHBy
aW50KCd7fToge30nLmZvcm1hdChmaWVsZF9uYW1lc1swXSwgZXZ0Wyd2YWx1ZTEnXSkpCj4gICAg
ICAgICAgICAgcHJpbnQoJ3t9OiB7fScuZm9ybWF0KGZpZWxkX25hbWVzWzFdLCBldnRbJ3ZhbHVl
MiddKSkKPiAgICAgICAgICAgICBwcmludCgne306IHt9Jy5mb3JtYXQoZmllbGRfbmFtZXNbMl0s
IGV2dFsndmFsdWUzJ10pKQo+ICAgICAgICAgICAgIHByaW50KCkKPgo+IE5vdyB0aGlzIGlzIGEg
Z3JlYXQgdXNlIGNhc2UgZm9yIGZ1dHVyZSBleHRlbnNpb25zIG9mIExUVG5nLVVTVCBhbmQvb3IK
PiB0aGUgdXBjb21pbmcgQ1RGIDIuCj4KPiBQaGlsCj4KPj4KPj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
PiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKPgpUaGFua3MgLSBJIGhhZG4ndCB0aG91
Z2h0IG9mIHRoZSBQeXRob24gYmluZGluZ3MgLSBJIHRoaW5rIHdlIGNvdWxkCm1ha2UgdGhhdCB3
b3JrIChtYXliZSB3cmFwcGluZyB0aGUgdHdvIHRyYWNlcG9pbnQgaW5jYW50YXRpb25zIGludG8g
YQpzaW5nbGUgbWFjcm8gZGVmaW5pdGlvbikuCgpTdGFmZmFuIFRqLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
