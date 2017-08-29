From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: add missing void param to
	bt_clock_class_priority_map_create
Date: Tue, 29 Aug 2017 14:55:01 -0400
Message-ID: <CA+jJMxsqZ8PL4upQJbnJ8Bta5aJjmz=xwvxqSZyyGcRnZ8wh+g__22781.273831106$1504032992$gmane$org@mail.gmail.com>
References: <1504023399-15321-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3xhd9f2zb5z14hx
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 18:55:02 +0000 (UTC)
Received: by mail-qk0-x241.google.com with SMTP id o63so3593046qkb.5
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 11:55:02 -0700 (PDT)
In-Reply-To: <1504023399-15321-1-git-send-email-mjeanson@efficios.com>
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
OSBBdWd1c3QgMjAxNyBhdCAxMjoxNiwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lv
cy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBpbmNsdWRlL2JhYmVsdHJhY2UvZ3JhcGgvY2xvY2stY2xh
c3MtcHJpb3JpdHktbWFwLmggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmFiZWx0cmFjZS9ncmFw
aC9jbG9jay1jbGFzcy1wcmlvcml0eS1tYXAuaCBiL2luY2x1ZGUvYmFiZWx0cmFjZS9ncmFwaC9j
bG9jay1jbGFzcy1wcmlvcml0eS1tYXAuaAo+IGluZGV4IGJkYTllYjMuLmQwM2IxZWEgMTAwNjQ0
Cj4gLS0tIGEvaW5jbHVkZS9iYWJlbHRyYWNlL2dyYXBoL2Nsb2NrLWNsYXNzLXByaW9yaXR5LW1h
cC5oCj4gKysrIGIvaW5jbHVkZS9iYWJlbHRyYWNlL2dyYXBoL2Nsb2NrLWNsYXNzLXByaW9yaXR5
LW1hcC5oCj4gQEAgLTkzLDcgKzkzLDcgQEAgc3RydWN0IGJ0X2Nsb2NrX2NsYXNzX3ByaW9yaXR5
X21hcDsKPgo+ICBAcG9zdHN1Y2Nlc3NyZWZjb3VudHJldDEKPiAgKi8KPiAtZXh0ZXJuIHN0cnVj
dCBidF9jbG9ja19jbGFzc19wcmlvcml0eV9tYXAgKmJ0X2Nsb2NrX2NsYXNzX3ByaW9yaXR5X21h
cF9jcmVhdGUoKTsKPiArZXh0ZXJuIHN0cnVjdCBidF9jbG9ja19jbGFzc19wcmlvcml0eV9tYXAg
KmJ0X2Nsb2NrX2NsYXNzX3ByaW9yaXR5X21hcF9jcmVhdGUodm9pZCk7Cj4KPiAgLyoqCj4gIEBi
cmllZiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgQ1RGIElSIGNsb2NrIGNsYXNzZXMgY29udGFpbmVk
IGluIHRoZQo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
