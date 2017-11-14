From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: use lttng_clock_gettime
	instead of clock_gettime
Date: Mon, 13 Nov 2017 19:26:33 -0500
Message-ID: <CA+jJMxt3m0t+dPWw6qBF+_09W41S-S3DTTqEtX2exa-Yk0Eq-g__32388.9763480567$1510619255$gmane$org@mail.gmail.com>
References: <20171018153906.25870-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybSx71FYKz16Bb
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 00:26:35 +0000 (UTC)
Received: by mail-wm0-x242.google.com with SMTP id l8so12640856wmg.4
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 16:26:35 -0800 (PST)
In-Reply-To: <20171018153906.25870-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDE4IE9jdG9iZXIgMjAxNyBhdCAxMTozOSwg
Sm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBJdCBhcHBlYXJzIHRoYXQgY29tbWl0IDM4OWZiZjA0YjQxZTIwMDJiZTQ0YTFlMzM5
MmJmYWRlMmYxZGVlZWYgbWlzc2VkCj4gaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBS
YWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRl
c3RzL3V0aWxzL3V0aWxzLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3V0aWxzL3V0aWxzLmMgYi90
ZXN0cy91dGlscy91dGlscy5jCj4gaW5kZXggYjg1ZjAyN2UuLjBiOTY1NTI0IDEwMDY0NAo+IC0t
LSBhL3Rlc3RzL3V0aWxzL3V0aWxzLmMKPiArKysgYi90ZXN0cy91dGlscy91dGlscy5jCj4gQEAg
LTU1LDcgKzU1LDcgQEAgaW50IHVzbGVlcF9zYWZlKHVzZWNvbmRzX3QgdXNlYykKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGVuZDsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gLSAgICAg
ICAgICAgICAgIHJldCA9IGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmdDIpOwo+ICsg
ICAgICAgICAgICAgICByZXQgPSBsdHRuZ19jbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywg
JnQyKTsKPiAgICAgICAgICAgICAgICAgaWYgKHJldCkgewo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHBlcnJvcigiY2xvY2tfZ2V0dGltZSIpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZW5kOwo+IC0tCj4gMi4xMS4wCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNp
T1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
