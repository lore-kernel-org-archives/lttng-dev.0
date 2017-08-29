From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: build lib before
	python-plugin-provider
Date: Tue, 29 Aug 2017 14:54:54 -0400
Message-ID: <CA+jJMxv4kmzyiDdU-bW2kMjGE0r8+W9Hy+vaaTV+A7TcrDt1Lw__18557.9906953082$1504032963$gmane$org@mail.gmail.com>
References: <1503954508-11713-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3xhd9W30wJz14hY
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 18:54:55 +0000 (UTC)
Received: by mail-qk0-x244.google.com with SMTP id p67so3461332qkd.2
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2017 11:54:55 -0700 (PDT)
In-Reply-To: <1503954508-11713-1-git-send-email-mjeanson@efficios.com>
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
OCBBdWd1c3QgMjAxNyBhdCAxNzowOCwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lv
cy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBNYWtlZmlsZS5hbSB8IDQgKystLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL01h
a2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0KPiBpbmRleCBkZTQzNmM0Li4yYmQ2YmYwIDEwMDY0NAo+
IC0tLSBhL01ha2VmaWxlLmFtCj4gKysrIGIvTWFrZWZpbGUuYW0KPiBAQCAtMyw3ICszLDggQEAg
QUNMT0NBTF9BTUZMQUdTID0gLUkgbTQKPiAgU1VCRElSUyA9IGluY2x1ZGUgICAgICAgICAgICAg
IFwKPiAgICAgICAgIGNvbW1vbiAgICAgICAgICAgICAgICAgIFwKPiAgICAgICAgIGNvbXBhdCAg
ICAgICAgICAgICAgICAgIFwKPiAtICAgICAgIGxvZ2dpbmcKPiArICAgICAgIGxvZ2dpbmcgICAg
ICAgICAgICAgICAgIFwKPiArICAgICAgIGxpYgo+Cj4gIGlmIEVOQUJMRV9QWVRIT05fUExVR0lO
Uwo+ICAjIE9ubHkgYnVpbGQgdGhlIFB5dGhvbiBwbHVnaW4gcHJvdmlkZXIgc2hhcmVkIG9iamVj
dCBpZiB0aGUKPiBAQCAtMTIsNyArMTMsNiBAQCBTVUJESVJTICs9IHB5dGhvbi1wbHVnaW4tcHJv
dmlkZXIKPiAgZW5kaWYKPgo+ICBTVUJESVJTICs9ICAgICAgICAgICAgICAgICAgICAgXAo+IC0g
ICAgICAgbGliICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgcGx1Z2lucyAgICAgICAg
ICAgICAgICAgXAo+ICAgICAgICAgY2xpICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAg
YmluZGluZ3MgICAgICAgICAgICAgICAgXAo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWll
IEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
