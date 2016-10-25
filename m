From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [RFC/PATCH 0/3] babeltrace: test harness
 improvements + new tests
Date: Tue, 25 Oct 2016 15:48:31 -0500
Message-ID: <e4c195d1-b4c3-31ed-8990-1842bca05270__7910.91292999244$1477428557$gmane$org@mentor.com>
References: <1477409667-8309-1-git-send-email-nathan_lynch@mentor.com>
 <70c97759-e06a-a744-7b71-e8a22275cc78@efficios.com>
 <a32c590f-8538-e7db-c2e0-2dfb9b6c949f@mentor.com>
 <f5722cd5-1b07-a21f-f841-5813cc76cfee@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9D7D5A3A48
 for <lttng-dev@lists.lttng.org>; Tue, 25 Oct 2016 20:48:46 +0000 (UTC)
In-Reply-To: <f5722cd5-1b07-a21f-f841-5813cc76cfee@efficios.com>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMTAvMjUvMjAxNiAxMjo0MyBQTSwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IE9uIDIwMTYt
MTAtMjUgMTI6MDUsIE5hdGhhbiBMeW5jaCB3cm90ZToKPj4gT24gMTAvMjUvMjAxNiAxMDo1MCBB
TSwgSm9uYXRoYW4gUmFqb3R0ZSBKdWxpZW4gd3JvdGU6Cj4+Pgo+Pj4gT24gMjAxNi0xMC0yNSAx
MTozNCBBTSwgTmF0aGFuIEx5bmNoIHdyb3RlOgo+Pj4+IFRoaXMgaXMgd29ya2luZyB0b3dhcmQg
bW92aW5nIGZyb20gcG9wdCB0byBHTGliIGZvciBjb21tYW5kLWxpbmUKPj4+PiBwYXJzaW5nLgo+
Pj4KPj4+IFdoYXQgaXMgdGhlIG1vdGl2YXRpb24gYmVoaW5kIHRoaXMgPwo+Pgo+PiBCYWJlbHRy
YWNlIGFscmVhZHkgdXNlcyBHTGliIGV4dGVuc2l2ZWx5IGFuZCwgYXMgYmVzdCBJIGNhbiB0ZWxs
LCBpdAo+PiBkb2Vzbid0IGRvIGFueXRoaW5nIHdpdGggY29tbWFuZC1saW5lIG9wdGlvbnMgdGhh
dCBHTGliIGRvZXNuJ3Qgc3VwcG9ydC4KPj4gIEdMaWIncyBjb21tYW5kLWxpbmUgcGFyc2luZyBm
YWNpbGl0eSBpcyBleHBsaWNpdGx5IGludGVuZGVkIHRvIGJlIGEKPj4gcmVwbGFjZW1lbnQgZm9y
IHBvcHQ6Cj4+Cj4+IGh0dHBzOi8vZGV2ZWxvcGVyLmdub21lLm9yZy9nbGliL3N0YWJsZS9nbGli
LUNvbW1hbmRsaW5lLW9wdGlvbi1wYXJzZXIuaHRtbCNnbGliLUNvbW1hbmRsaW5lLW9wdGlvbi1w
YXJzZXIuZGVzY3JpcHRpb24KPj4KPj4gSSdtIGFsc28gd29ya2luZyBvbiBpbXByb3ZpbmcgQmFi
ZWx0cmFjZSdzIE1pbkdXIHBvcnQgYW5kIHJlbW92aW5nIHRoZQo+PiBwb3B0IGRlcGVuZGVuY3kg
d2lsbCBtYWtlIHRoYXQgZWFzaWVyLgo+IAo+IFlvdSBzaG91bGQgaGF2ZSBhIGxvb2sgYXQKPiBo
dHRwczovL2dpdGh1Yi5jb20vbWplYW5zb24vYmFiZWx0cmFjZS9jb21taXRzL21pbmd3NjQKCmFo
LCBncmVhdCEgIEkgc2VlIHNvbWUgb3ZlcmxhcCB3aXRoIGxvY2FsIGNoYW5nZXMgSSBoYXZlIGFs
cmVhZHksIGJ1dCBpdApsb29rcyBsaWtlIHlvdSd2ZSBnb3R0ZW4gZnVydGhlci4KCldoYXQgY2Fu
IEkgZG8gdG8gaGVscCB0aGlzIGVmZm9ydCBhbG9uZz8KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
