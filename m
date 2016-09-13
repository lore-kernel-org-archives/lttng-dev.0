From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] babeltrace: add test for babeltrace --list
Date: Tue, 13 Sep 2016 13:47:36 -0400
Message-ID: <CA+jJMxuGjA9MBm_gh_zLmPGiCQEv7S9OAS-ODhwOW-4dVwDT3A__8082.3301840157$1473788881$gmane$org@mail.gmail.com>
References: <1471540228-24555-1-git-send-email-nathan_lynch@mentor.com>
 <c58c6445-dfe0-0835-4bea-d4b944509200@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
 [209.85.213.42])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id DED9FA3BCB
 for <lttng-dev@lists.lttng.org>; Tue, 13 Sep 2016 17:48:30 +0000 (UTC)
Received: by mail-vk0-f42.google.com with SMTP id f76so191425964vke.0
 for <lttng-dev@lists.lttng.org>; Tue, 13 Sep 2016 10:47:37 -0700 (PDT)
In-Reply-To: <c58c6445-dfe0-0835-4bea-d4b944509200@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

VGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIGJ1dCB3b3VsZCB5b3UgbWluZCBjaGFuZ2luZyB0
aGUgaGVhZGVyIG9mCnRlc3RfZm9ybWF0cyB0byB0aGUgZnVsbCBHUEwgaGVhZGVyICsgY29weXJp
Z2h0IG1lbnRpb24sIGFzIGlzIGRvbmUKaGVyZToKCmh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250
ZW50LmNvbS9lZmZpY2lvcy9iYWJlbHRyYWNlL21hc3Rlci90ZXN0cy9iaW4vaW50ZXJzZWN0aW9u
L3Rlc3RfaW50ZXJzZWN0aW9uLmluCgpJIGNhbiBwZXJmb3JtIHRoZSBjaGFuZ2UgbXlzZWxmLCBi
dXQgSSB3YW50IHRvIG1ha2Ugc3VyZSBpdCdzIG9rYXkuCgpUaGFua3MhCkrDqXLDqW1pZQoKT24g
VHVlLCBTZXAgMTMsIDIwMTYgYXQgMTA6NTQgQU0sIE5hdGhhbiBMeW5jaCA8TmF0aGFuX0x5bmNo
QG1lbnRvci5jb20+IHdyb3RlOgo+IE9uIDA4LzE4LzIwMTYgMTI6MTAgUE0sIE5hdGhhbiBMeW5j
aCB3cm90ZToKPj4gVGhpcyB0ZXN0IHNpbXBseSBjaGVja3MgdGhlIGNvbnZlcnRlcidzIGxpc3Qg
b2Ygc3VwcG9ydGVkIGZvcm1hdHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5hdGhhbiBMeW5jaCA8
bmF0aGFuX2x5bmNoQG1lbnRvci5jb20+Cj4+IC0tLQo+Pgo+PiBDdXJyZW50bHkgSSBleHBlY3Qg
dGhpcyB0byBmYWlsIGZvciBiYWJlbHRyYWNlIGNvbmZpZ3VyZWQgd2l0aAo+PiAtLWRpc2FibGUt
c2hhcmVkOyBzZWUgaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy9pc3N1ZXMvMTA1NQo+Cj4KPiBUaG91
Z2h0cyBvbiB0aGlzIHBhdGNoPwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
