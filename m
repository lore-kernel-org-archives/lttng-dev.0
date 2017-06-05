From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH liburcu 0/2] Remove RCU requirements on
 hash table destroy
Date: Mon, 5 Jun 2017 15:56:08 -0700
Message-ID: <20170605225608.GY3721__11407.8116756447$1496703894$gmane$org@linux.vnet.ibm.com>
References: <1496178620-14755-1-git-send-email-mathieu.desnoyers@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by lists.lttng.org (Postfix) with ESMTPS id 3whVb10JS9z11rd
 for <lttng-dev@lists.lttng.org>; Mon,  5 Jun 2017 22:57:48 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55Mrii7015453
 for <lttng-dev@lists.lttng.org>; Mon, 5 Jun 2017 18:56:09 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awc1a1kvg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 05 Jun 2017 18:56:09 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 18:56:08 -0400
Content-Disposition: inline
In-Reply-To: <1496178620-14755-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: jiangshanlai@gmail.com, Stephen Hemminger <shemminger@vyatta.com>, rp@svcs.cs.pdx.edu, Alan Stern <stern@rowland.harvard.edu>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBNYXkgMzAsIDIwMTcgYXQgMDU6MTA6MThQTSAtMDQwMCwgTWF0aGlldSBEZXNub3ll
cnMgd3JvdGU6Cj4gVGhlIFJDVSBsb2NrLWZyZWUgaGFzaCB0YWJsZSBjdXJyZW50bHkgcmVxdWly
ZXMgdGhhdCB0aGUgZGVzdHJveQo+IGZ1bmN0aW9uIHNob3VsZCBub3QgYmUgY2FsbGVkIGZyb20g
d2l0aGluIFJDVSByZWFkLXNpZGUgY3JpdGljYWwKPiBzZWN0aW9ucy4gVGhpcyBpcyBjYXVzZWQg
YnkgdGhlIGxhenkgcmVzaXplLCB3aGljaCB1c2VzIHRoZSBjYWxsX3JjdQo+IHdvcmtlciB0aHJl
YWQsIGV2ZW4gdGhvdWdoIGFsbCBpdCByZWFsbHkgbmVlZHMgaXMgYSB3b3JrcXVldWUvd29ya2Vy
Cj4gdGhyZWFkIHNjaGVtZS4KPiAKPiBJbXBsZW1lbnQgYW4gaW50ZXJuYWwgd29ya3F1ZXVlIEFQ
SSBpbiBsaWJ1cmN1LCBhbmQgdXNlIGl0IGluc3RlYWQgb2YKPiBjYWxsX3JjdSBpbiByY3VsZmhh
c2ggdG8gb3ZlcmNvbWUgdGhpcyBsaW1pdGF0aW9uLgoKVG9vayBhIHF1aWNrIGxvb2ssIGFuZCBp
dCBhcHBlYXJzIHBsYXVzaWJsZS4KClNvbWUgb3Bwb3J0dW5pdHkgdG8gc2hhcmUgQ1BVLWFmZmlu
aXR5IGNvZGUgYmV0d2VlbiB0aGlzIGFuZCB0aGUKY2FsbF9yY3UoKSBjb2RlLCBGV0lXLiAgVHdv
IG9mIHRoZSBzeXN0ZW0tY2FsbCBzdHVicyBsb29rIHRvIGJlIGlkZW50aWNhbApvdGhlciB0aGFu
IHRoZSBzeXN0ZW0gY2FsbCAoRUlOVFIgY2hlY2tzIGFuZCBzb2ZvcnRoKSwgYnV0IEkgYW0gbm90
IHN1cmUKdGhhdCBpdCBpcyB3b3J0aCBjb21iaW5pbmcgdGhlbS4KCgkJCQkJCQkJVGhhbngsIFBh
dWwKCj4gTWF0aGlldSBEZXNub3llcnMgKDIpOgo+ICAgSW1wbGVtZW50IHVyY3Ugd29ya3F1ZXVl
cyBpbnRlcm5hbCBBUEkKPiAgIFVzZSB3b3JrcXVldWUgaW4gcmN1bGZoYXNoCj4gCj4gIGluY2x1
ZGUvdXJjdS9yY3VsZmhhc2guaCB8ICAxNSArLQo+ICBzcmMvTWFrZWZpbGUuYW0gICAgICAgICAg
fCAgIDIgKy0KPiAgc3JjL3JjdWxmaGFzaC1pbnRlcm5hbC5oIHwgICAyICstCj4gIHNyYy9yY3Vs
Zmhhc2guYyAgICAgICAgICB8IDEyNCArKysrKystLS0tLS0KPiAgc3JjL3dvcmtxdWV1ZS5jICAg
ICAgICAgIHwgNTA3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gIHNyYy93b3JrcXVldWUuaCAgICAgICAgICB8IDEwNCArKysrKysrKysrCj4gIDYgZmls
ZXMgY2hhbmdlZCwgNjg2IGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgc3JjL3dvcmtxdWV1ZS5jCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzcmMvd29y
a3F1ZXVlLmgKPiAKPiAtLSAKPiAyLjEuNAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
