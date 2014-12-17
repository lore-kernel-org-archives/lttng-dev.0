From: David Engraf <david.engraf@sysgo.com>
Subject: Re: [PATCH] Update compaction instrumentation for
	3.12.x stable kernels
Date: Wed, 17 Dec 2014 16:34:09 +0100
Message-ID: <5491A271.7060704__46496.8815366321$1418844769$gmane$org@sysgo.com>
References: <5491384D.3070608@sysgo.com>
 <1731068074.28743.1418829713487.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.sysgo.com ([176.9.53.133])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <david.engraf@sysgo.com>) id 1Y1GcD-0003Cq-SV
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 10:34:19 -0500
In-Reply-To: <1731068074.28743.1418829713487.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

UGVyZmVjdCwgdGhhbmsgeW91IQoKRGF2aWQKCgpBbSAxNy4xMi4yMDE0IHVtIDE2OjIxIHNjaHJp
ZWIgTWF0aGlldSBEZXNub3llcnM6Cj4gTWVyZ2VkIGFsbCB0aGUgd2F5IGJhY2sgdG8gc3RhYmxl
LTIuNCwgdGhhbmtzICEKPgo+IE1hdGhpZXUKPgo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0t
LS0KPj4gRnJvbTogIkRhdmlkIEVuZ3JhZiIgPGRhdmlkLmVuZ3JhZkBzeXNnby5jb20+Cj4+IFRv
OiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnLCAic2ltb24gbWFyY2hpIiA8c2ltb24ubWFyY2hp
QHBvbHltdGwuY2E+LCAibWF0aGlldSBkZXNub3llcnMiCj4+IDxtYXRoaWV1LmRlc25veWVyc0Bl
ZmZpY2lvcy5jb20+Cj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTcsIDIwMTQgMzowMTox
NyBBTQo+PiBTdWJqZWN0OiBbUEFUQ0hdIFVwZGF0ZSBjb21wYWN0aW9uIGluc3RydW1lbnRhdGlv
biBmb3IgMy4xMi54IHN0YWJsZSBrZXJuZWxzCj4+Cj4+Cj4+Cj4KCi0tIApNaXQgZnJldW5kbGlj
aGVuIEdyw7zDn2VuL0Jlc3QgcmVnYXJkcywKCkRhdmlkIEVuZ3JhZgpQcm9kdWN0IEVuZ2luZWVy
CgpTWVNHTyBBRwpPZmZpY2UgTWFpbnoKQW0gUGZhZmZlbnN0ZWluIDE0IC8gRC01NTI3MCBLbGVp
bi1XaW50ZXJuaGVpbSAvIEdlcm1hbnkKUGhvbmU6ICs0OS02MTM2LTk5NDgtMCAvIEZheDogKzQ5
LTYxMzYtOTk0OC0xMApWb0lQOiBTSVA6ZGVuQHN5c2dvLmNvbQpFLW1haWw6IGRhdmlkLmVuZ3Jh
ZkBzeXNnby5jb20gLyBXZWI6IGh0dHA6Ly93d3cuc3lzZ28uY29tCgpIYW5kZWxzcmVnaXN0ZXIv
Q29tbWVyY2lhbCBSZWdpc3RyeTogSFJCIE1haW56IDkwIEhSQiA4MDY2ClZvcnN0YW5kL0V4ZWN1
dGl2ZSBCb2FyZDogS251dCBEZWdlbiAoQ0VPKSwgS2FpIFNhYmxvdG55IChDT08pCkF1ZnNpY2h0
c3JhdHN2b3JzaXR6ZW5kZXIvU3VwZXJ2aXNvcnkgQm9hcmQgQ2hhaXJtYW46IFBhc2NhbCBCb3Vj
aGlhdApVU3QtSWQtTnIuL1ZBVC1JZC1Oby46IERFIDE0OTA2MjMyOAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
