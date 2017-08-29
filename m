From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix test: OOT build of
	test_trace_copy and test_trimmer
Date: Tue, 29 Aug 2017 14:54:31 -0400
Message-ID: <CA+jJMxvMOqR3=+NDfPnszmSfb_FpPEn8gdaOfycf=DkXe2xiqg__38019.3215133206$1504032888$gmane$org@mail.gmail.com>
References: <1503936728-12827-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3xhd953G5Tz14gf
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 18:54:33 +0000 (UTC)
Received: by mail-qt0-x243.google.com with SMTP id v29so3527044qtv.1
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 11:54:32 -0700 (PDT)
In-Reply-To: <1503936728-12827-1-git-send-email-mjeanson@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMC4gVGhhbmtzIQoKSsOpcsOpbWllCgpPbiAy
OCBBdWd1c3QgMjAxNyBhdCAxMjoxMiwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lv
cy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy9jbGkvdGVzdF90cmFjZV9jb3B5LmluIHwgMiAr
LQo+ICB0ZXN0cy9jbGkvdGVzdF90cmltbWVyLmluICAgIHwgMiArLQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0
cy9jbGkvdGVzdF90cmFjZV9jb3B5LmluIGIvdGVzdHMvY2xpL3Rlc3RfdHJhY2VfY29weS5pbgo+
IGluZGV4IDVkMWU3YjQuLjM2ZTI3MTggMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvY2xpL3Rlc3RfdHJh
Y2VfY29weS5pbgo+ICsrKyBiL3Rlc3RzL2NsaS90ZXN0X3RyYWNlX2NvcHkuaW4KPiBAQCAtMTUs
NyArMTUsNyBAQAo+ICAjIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLCA1MQo+ICAjIEZyYW5rbGluIFN0cmVldCwgRmlmdGgg
Rmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCj4KPiAtLiAiQGFic190b3Bfc3JjZGly
QC90ZXN0cy91dGlscy9jb21tb24uc2giCj4gKy4gIkBhYnNfdG9wX2J1aWxkZGlyQC90ZXN0cy91
dGlscy9jb21tb24uc2giCj4KPiAgY2xlYW5fdG1wKCkgewo+ICAgICAgICAgcm0gLXJmICIke291
dF9wYXRofSIgIiR7dGV4dF9vdXRwdXQxfSIgIiR7dGV4dF9vdXRwdXQyfSIKPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvY2xpL3Rlc3RfdHJpbW1lci5pbiBiL3Rlc3RzL2NsaS90ZXN0X3RyaW1tZXIuaW4K
PiBpbmRleCA5MzAzY2RmLi41YTY4N2M2IDEwMDY0NAo+IC0tLSBhL3Rlc3RzL2NsaS90ZXN0X3Ry
aW1tZXIuaW4KPiArKysgYi90ZXN0cy9jbGkvdGVzdF90cmltbWVyLmluCj4gQEAgLTE1LDcgKzE1
LDcgQEAKPiAgIyB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbiwgSW5jLiwgNTEKPiAgIyBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29y
LCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBLgo+Cj4gLS4gIkBhYnNfdG9wX3NyY2RpckAvdGVz
dHMvdXRpbHMvY29tbW9uLnNoIgo+ICsuICJAYWJzX3RvcF9idWlsZGRpckAvdGVzdHMvdXRpbHMv
Y29tbW9uLnNoIgo+Cj4gIFRSQUNFX1BBVEg9IiR7QlRfQ1RGX1RSQUNFU30vc3VjY2VlZC93ay1o
ZWFydGJlYXQtdS8iCj4KPiAtLQo+IDIuNy40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
