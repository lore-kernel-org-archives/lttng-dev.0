From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: use sys/types.h for
 ssize_t on Cygwin
Date: Tue, 22 Jan 2019 14:31:31 -0500
Message-ID: <CA+jJMxt9C_tRt3uijBB_0gAdM535KQfs9QmSV4N-D0qtWmZinA__17133.6757879303$1548185552$gmane$org@mail.gmail.com>
References: <20181127192401.8236-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43kdpg3jvqznTF
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:32:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 38680B5D1F
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:32:10 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id lD5IkpAxd6B0 for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 14:32:09 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8521EB5D15
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:32:09 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id Pb_a7STKzhfQ for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 14:32:09 -0500 (EST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mail.efficios.com (Postfix) with ESMTPSA id 2D6E2B5D0F
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:32:09 -0500 (EST)
Received: by mail-lj1-f182.google.com with SMTP id l15-v6so21688136lja.9
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 11:32:09 -0800 (PST)
In-Reply-To: <20181127192401.8236-1-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTEuCgpUaGFua3MhCkrDqXLDqW1pZQoKT24g
VHVlLCAyNyBOb3YgMjAxOCBhdCAxNDoyNCwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVh
bnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbHR0bmcvbG9jYXRpb24taW50ZXJu
YWwuaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sdHRuZy9sb2NhdGlvbi1pbnRlcm5hbC5oIGIv
aW5jbHVkZS9sdHRuZy9sb2NhdGlvbi1pbnRlcm5hbC5oCj4gaW5kZXggOTA3MmVmMzQuLjZjMmE5
OTIzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbHR0bmcvbG9jYXRpb24taW50ZXJuYWwuaAo+ICsr
KyBiL2luY2x1ZGUvbHR0bmcvbG9jYXRpb24taW50ZXJuYWwuaAo+IEBAIC0yMiw3ICsyMiw3IEBA
Cj4gICNpbmNsdWRlIDxjb21tb24vZHluYW1pYy1idWZmZXIuaD4KPiAgI2luY2x1ZGUgPGNvbW1v
bi9idWZmZXItdmlldy5oPgo+ICAjaW5jbHVkZSA8Y29tbW9uL21hY3Jvcy5oPgo+IC0jaW5jbHVk
ZSA8c3RkZGVmLmg+Cj4gKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPgo+ICBzdHJ1Y3QgbHR0bmdf
dHJhY2VfYXJjaGl2ZV9sb2NhdGlvbiB7Cj4gICAgICAgICBlbnVtIGx0dG5nX3RyYWNlX2FyY2hp
dmVfbG9jYXRpb25fdHlwZSB0eXBlOwo+IC0tCj4gMi4xNy4xCj4KCgotLSAKSsOpcsOpbWllIEdh
bGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
