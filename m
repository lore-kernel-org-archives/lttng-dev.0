From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test: proper redirection
	of stderr to stdout
Date: Mon, 12 Jun 2017 18:16:25 -0400
Message-ID: <CA+jJMxuTkj8Y04-aX7_-1AmsEsNZ1moE+KKG3ietax56NqjtOg__27523.0839303278$1497305808$gmane$org@mail.gmail.com>
References: <20170601221646.9005-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 by lists.lttng.org (Postfix) with ESMTPS id 3wmnNG53N7z11Z4
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jun 2017 22:18:22 +0000 (UTC)
Received: by mail-yw0-x244.google.com with SMTP id j11so1995468ywa.2
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jun 2017 15:16:26 -0700 (PDT)
In-Reply-To: <20170601221646.9005-1-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAuCgpUaGFua3MhCkrDqXLDqW1pZQoKT24g
MSBKdW5lIDIwMTcgYXQgMTg6MTYsIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUt
anVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFq
b3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0
cy9yZWdyZXNzaW9uL3Rvb2xzL2V4Y2x1c2lvbi90ZXN0X2V4Y2x1c2lvbiB8IDIgKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9leGNsdXNpb24vdGVzdF9leGNsdXNpb24gYi90ZXN0
cy9yZWdyZXNzaW9uL3Rvb2xzL2V4Y2x1c2lvbi90ZXN0X2V4Y2x1c2lvbgo+IGluZGV4IDJhZjlh
OTNiLi5jMTU1YzI1ZiAxMDA3NTUKPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL2V4Y2x1
c2lvbi90ZXN0X2V4Y2x1c2lvbgo+ICsrKyBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvZXhjbHVz
aW9uL3Rlc3RfZXhjbHVzaW9uCj4gQEAgLTc5LDcgKzc5LDcgQEAgZnVuY3Rpb24gdGVzdF9leGNs
dXNpb25fZmFpbAo+ICAgICAgICAgZXhjbHVzaW9ucz0iJDIiCj4KPiAgICAgICAgIGNyZWF0ZV9s
dHRuZ19zZXNzaW9uX29rICRTRVNTSU9OX05BTUUgJHRyYWNlX3BhdGgKPiAtICAgICAgICRURVNU
RElSLy4uL3NyYy9iaW4vbHR0bmcvJExUVE5HX0JJTiBlbmFibGUtZXZlbnQgLXUgIiRldmVudF9u
YW1lIiAtcyAkc2Vzc19uYW1lIC14ICIkZXhjbHVzaW9ucyIgMiY+MSA+L2Rldi9udWxsCj4gKyAg
ICAgICAkVEVTVERJUi8uLi9zcmMvYmluL2x0dG5nLyRMVFROR19CSU4gZW5hYmxlLWV2ZW50IC11
ICIkZXZlbnRfbmFtZSIgLXMgJHNlc3NfbmFtZSAteCAiJGV4Y2x1c2lvbnMiID4vZGV2L251bGwg
Mj4mMQo+ICAgICAgICAgcmVzPSQ/Cj4gICAgICAgICBkZXN0cm95X2x0dG5nX3Nlc3Npb25fb2sg
JFNFU1NJT05fTkFNRQo+Cj4gLS0KPiAyLjExLjAKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVh
dQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
