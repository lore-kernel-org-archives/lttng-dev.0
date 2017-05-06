From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Test: use output_path instead
	of argument position
Date: Sat, 6 May 2017 15:48:44 -0400
Message-ID: <CA+jJMxshDCOmJdY6rGu7eVrSLf_cKTTU2PFeaOC4S5EM8hVx8A__31281.1128831983$1494100135$gmane$org@mail.gmail.com>
References: <1491404021-2026-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKzqd6dL2zDVH
 for <lttng-dev@lists.lttng.org>; Sat,  6 May 2017 19:49:33 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id 203so2680191ywe.0
 for <lttng-dev@lists.lttng.org>; Sat, 06 May 2017 12:48:45 -0700 (PDT)
In-Reply-To: <1491404021-2026-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDUgQXByaWwgMjAxNyBhdCAxMDo1MywgSm9u
YXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1
bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVz
dF9taSB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVzdF9t
aSBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvbWkvdGVzdF9taQo+IGluZGV4IDM4MDM4NWYuLjBk
M2JkNGYgMTAwNzU1Cj4gLS0tIGEvdGVzdHMvcmVncmVzc2lvbi90b29scy9taS90ZXN0X21pCj4g
KysrIGIvdGVzdHMvcmVncmVzc2lvbi90b29scy9taS90ZXN0X21pCj4gQEAgLTEzMiwxMCArMTMy
LDEwIEBAIGZ1bmN0aW9uIGlzX2NvbW1hbmRfc3VjY2VzcyAoKQo+Cj4gIGZ1bmN0aW9uIG1pX3By
aW50X3ZlcnNpb24gKCkKPiAgewo+IC0gICAgICAgbG9jYWwgb3B0PSQyCj4gICAgICAgICBsb2Nh
bCBvdXRwdXRfcGF0aD0kMQo+ICsgICAgICAgbG9jYWwgb3B0PSQyCj4KPiAtICAgICAgICRMVFRO
RyB2ZXJzaW9uICRvcHQgPiAkMQo+ICsgICAgICAgJExUVE5HIHZlcnNpb24gJG9wdCA+ICRvdXRw
dXRfcGF0aAo+ICAgICAgICAgb2sgJD8gIk1JIHRlc3Q6IEx0dG5nIHZlcnNpb24iCj4KPiAgfQo+
IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
