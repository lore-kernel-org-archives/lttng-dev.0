From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Use fs_initcall instead
 of rootfs_initcall
Date: Thu, 28 Jul 2016 20:52:14 +0000 (UTC)
Message-ID: <566205193.2588.1469739134742.JavaMail.zimbra__25346.8208051801$1469739156$gmane$org@efficios.com>
References: <1469722331-21673-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 00600A00F2
 for <lttng-dev@lists.lttng.org>; Thu, 28 Jul 2016 20:52:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BA2213401FB
 for <lttng-dev@lists.lttng.org>; Thu, 28 Jul 2016 20:52:15 +0000 (UTC)
In-Reply-To: <1469722331-21673-1-git-send-email-mjeanson@efficios.com>
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

LS0tLS0gT24gSnVsIDI4LCAyMDE2LCBhdCAxMjoxMiBQTSwgTWljaGFlbCBKZWFuc29uIG1qZWFu
c29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gVGhlIHJvb3Rmc19pbml0Y2FsbCBmb3IgZHJpdmVy
cyBidWlsdCBhcyBtb2R1bGVzIHdhcyBvbmx5IGludHJvZHVjZWQgaW4KPiBrZXJuZWwgMy4xNCBi
eSBjb21taXQgYjQ2ZDBjNDZjY2FhMzY2YTViYjhhYzcwOWZkZjJiY2FhNzYyMjFmZC4gVXNlCj4g
ZnNfaW5pdGNhbGwgaW5zdGVhZCB3aGljaCBjb21lcyBqdXN0IGJlZm9yZSBhbmQgZXhpc3RzIGlu
IG9sZGVyIGtlcm5lbHMuCgptZXJnZWQgaW50byBtYXN0ZXIgYW5kIHN0YWJsZS0yLjgsIHRoYW5r
cyEKCk1hdGhpZXUKCj4gCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gdGVzdHMvY2xvY2stcGx1Z2luL2x0dG5nLWNsb2NrLXBs
dWdpbi10ZXN0LmMgfCAyICstCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Nsb2NrLXBsdWdpbi9sdHRuZy1jbG9j
ay1wbHVnaW4tdGVzdC5jCj4gYi90ZXN0cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2stcGx1Z2lu
LXRlc3QuYwo+IGluZGV4IGJmODE5MzIuLjU1ZmFjYjcgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvY2xv
Y2stcGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKPiArKysgYi90ZXN0cy9jbG9jay1w
bHVnaW4vbHR0bmctY2xvY2stcGx1Z2luLXRlc3QuYwo+IEBAIC02Nyw3ICs2Nyw3IEBAIGludCBs
dHRuZ19jbG9ja19wbHVnaW5faW5pdCh2b2lkKQo+IHsKPiAJcmV0dXJuIGx0dG5nX2Nsb2NrX3Jl
Z2lzdGVyX3BsdWdpbigmbHRjLCBUSElTX01PRFVMRSk7Cj4gfQo+IC1yb290ZnNfaW5pdGNhbGwo
bHR0bmdfY2xvY2tfcGx1Z2luX2luaXQpOwo+ICtmc19pbml0Y2FsbChsdHRuZ19jbG9ja19wbHVn
aW5faW5pdCk7Cj4gCj4gc3RhdGljIF9fZXhpdAo+IHZvaWQgbHR0bmdfY2xvY2tfcGx1Z2luX2V4
aXQodm9pZCkKPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
