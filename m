From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.5 - KeKriek
Date: Mon, 23 Jul 2018 22:18:48 -0400
Message-ID: <CA+jJMxtuAWMtDFQzu_7dFzamOk0Fyw+euk-TB=AukOt6CqMD2A__3497.67326047203$1532398687$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41ZMW943K1z14TX
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jul 2018 22:19:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E83BF223FE4
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jul 2018 22:19:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id gpNgVZ-zWHuV for <lttng-dev@lists.lttng.org>;
 Mon, 23 Jul 2018 22:19:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A68E7223FDD
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jul 2018 22:19:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id he3QSb4TsD6b for <lttng-dev@lists.lttng.org>;
 Mon, 23 Jul 2018 22:19:30 -0400 (EDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mail.efficios.com (Postfix) with ESMTPSA id 4F924223FD3
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jul 2018 22:19:30 -0400 (EDT)
Received: by mail-lf1-f54.google.com with SMTP id u202-v6so1858908lff.9
 for <lttng-dev@lists.lttng.org>; Mon, 23 Jul 2018 19:19:30 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVGhlIGZpZnRoIGJ1Zy1maXggcmVsZWFzZSBvZiBMVFRuZy1Ub29scyAyLjEwIC0g
S2VLcmllayBoYXMganVzdCBiZWVuCnJlbGVhc2VkLiBUaGlzIHJlbGVhc2UgYWRkcmVzc2VzIGEg
bnVtYmVyIG9mIGlzc3VlcyBsaXN0ZWQgYmVsb3cuCgoyMDE4LTA3LTIzIGx0dG5nLXRvb2xzIDIu
MTAuNSAoTmF0aW9uYWwgVmFuaWxsYSBJY2UgQ3JlYW0gRGF5KQogICAgICAgICogRml4OiBtaXNz
aW5nIGNvbnRleHQgZW51bSB2YWx1ZXMgaW4gc2Vzc2lvbiB4bWwgc2NoZW1hCiAgICAgICAgKiBU
ZXN0czogYWRkIHNlc3Npb24gYXV0by1sb2FkaW5nIHRlc3QgY2FzZXMKICAgICAgICAqIEJhc2gg
Y29tcGxldGlvbjogaWdub3JlIG5hbWVzcGFjZSBmb3IgeG1sbGludCBwYXJzaW5nCiAgICAgICAg
KiBUeXBvIGluIHVzdCBjb25zdW1lciBsb2cgbWVzc2FnZSAoY2hhbm5layAtPiBjaGFubmVsKQog
ICAgICAgICogRml4OiB1c2Ugc2lnbmVkIHZhcmlhYmxlIGZvciByZWZjb3VudGluZyBvZiBjb25z
dW1lcl9yZWxheWRfc29ja19wYWlyCiAgICAgICAgKiBGaXg6IHdhcm5pbmcgZHVlIHRvIGhhc2hf
a2V5X3N0cigpIGJlaW5nIG5vdCBjb25zdC1jb3JyZWN0CiAgICAgICAgKiBQcmludCBjb25zdW1l
cmQzMi82NC9rZXJuZWwgY29uZmlndXJhdGlvbgogICAgICAgICogRml4OiBjYWxsaW5nIGh0X3to
YXNoLCBtYXRjaH1fZW51bSB3aXRoIHdyb25nIGFyZ3VtZW50CiAgICAgICAgKiBGaXg6IHByb2Jl
cyBzaG91bGQgYmUgY29tcGFyZWQgc3RyaWN0bHkgYnkgZXZlbnRzIG1ldGFkYXRhCiAgICAgICAg
KiBGaXg6IHRlc3RfdXN0LWRsIGlzIGdlbmVyYXRlZCBhdCBjb25maWd1cmUtdGltZQogICAgICAg
ICogRml4OiBjbWQgbGluZSBvcHRpb25zIG92ZXJ3cml0ZSBlbnYgdmFyaWFibGUgY29uZmlnIG9w
dGlvbnMKICAgICAgICAqIEZpeDogcGVyZm9ybSB0aGUgaW5pdGlhbGl6YXRpb24gbWVtb3J5IGJh
cnJpZXIgb3V0IG9mIGxvb3AgYm9keQogICAgICAgICogUG9ydDogZml4IGZvcm1hdCB3YXJuaW5n
cyBvbiBDeWd3aW4KICAgICAgICAqIEFkZCBtaXNzaW5nIGluY2x1ZGUgZm9yIHNzaXplX3Qgb24g
Q3lnd2luCiAgICAgICAgKiBGaXg6IHNlc3Npb25zIHdpdGggYWdlbnQgY2hhbm5lbHMgZmFpbCB0
byBsb2FkCiAgICAgICAgKiBGaXg6IGRvbid0IHdhaXQgZm9yIHRoZSBsb2FkIHRocmVhZCBiZWZv
cmUgc2VydmluZyBjbGllbnQgY29tbWFuZHMKICAgICAgICAqIEZpeDogc2Vzc2lvbmQgZmFpbHMg
dG8gbGF1bmNoIG9uIC0td2l0aG91dC11c3QgY29uZmlndXJhdGlvbgogICAgICAgICogRml4OiBh
Z2VudCB0aHJlYWQgcG9sbCBzZXQgY3JlYXRpb24gZmFpbHVyZSByZXN1bHRzIGluIGRlYWRsb2Nr
CiAgICAgICAgKiBGaXg6IHRlc3QgdXNlcyBzaXplb2YoKSBvbiB0aGUgd3Jvbmcgb3BlcmFuZCBv
ZiBzdHJuY3B5CiAgICAgICAgKiBGaXg6IHJldCBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGlu
IHNhbXBsZV9jaGFubmVsX3Bvc2l0aW9ucygpCgpBcyBhbHdheXMsIHBsZWFzZSByZXBvcnQgYW55
IGlzc3VlIHlvdSBtYXkgZW5jb3VudGVyIHRvIGJ1Z3MubHR0bmcub3JnCm9yIG9uIHRoaXMgbWFp
bGluZyBsaXN0LgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwczovL2x0dG5nLm9yZwoKRG93bmxvYWQg
bGluazoKaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdG9vbHMvbHR0bmctdG9vbHMtMi4x
MC41LnRhci5iejIKCkdQRyBzaWc6Cmh0dHBzOi8vbHR0bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xz
L2x0dG5nLXRvb2xzLTIuMTAuNS50YXIuYnoyLmFzYwoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
