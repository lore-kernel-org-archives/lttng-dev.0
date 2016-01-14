From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test script requires bash
Date: Thu, 14 Jan 2016 11:59:16 -0500
Message-ID: <CA+jJMxuM3wfdKuxyXYeXSW7fcBJioSgLSMPhHYzmQoQ-S3yMVw__15776.1260089048$1452790881$gmane$org@mail.gmail.com>
References: <1452471053-5739-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f196.google.com ([209.85.223.196])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aJlF4-0000dF-7F
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 11:59:23 -0500
Received: by mail-io0-f196.google.com with SMTP id 77so18472819ioc.2
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 08:59:22 -0800 (PST)
In-Reply-To: <1452471053-5739-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFN1biwgSmFuIDEwLCAyMDE2IGF0IDc6MTAg
UE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IFRoZSB0ZXN0IGJhZGRyIHN0YXRlZHVtcCBzY3JpcHQgcmVxdWlyZXMgYmFzaC4gSXQg
ZmFpbHMgdG8gcnVuIG9uCj4gc3lzdGVtcyB3aGVyZSAvYmluL3NoIGlzIG5vdCBhbiBhbGlhcyB0
byBiYXNoLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgdGVzdHMvcmVncmVzc2lvbi91c3QvYmFkZHIt
c3RhdGVkdW1wL3Rlc3RfYmFkZHItc3RhdGVkdW1wIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9yZWdy
ZXNzaW9uL3VzdC9iYWRkci1zdGF0ZWR1bXAvdGVzdF9iYWRkci1zdGF0ZWR1bXAgYi90ZXN0cy9y
ZWdyZXNzaW9uL3VzdC9iYWRkci1zdGF0ZWR1bXAvdGVzdF9iYWRkci1zdGF0ZWR1bXAKPiBpbmRl
eCAxZjQwNDRhLi4wNmExM2E5IDEwMDc1NQo+IC0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L2Jh
ZGRyLXN0YXRlZHVtcC90ZXN0X2JhZGRyLXN0YXRlZHVtcAo+ICsrKyBiL3Rlc3RzL3JlZ3Jlc3Np
b24vdXN0L2JhZGRyLXN0YXRlZHVtcC90ZXN0X2JhZGRyLXN0YXRlZHVtcAo+IEBAIC0xLDQgKzEs
NCBAQAo+IC0jIS9iaW4vc2gKPiArIyEvYmluL2Jhc2gKPiAgIwo+ICAjIENvcHlyaWdodCAoQykg
LSAyMDEzIErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNv
bT4KPiAgIwo+IC0tCj4gMi4xLjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lP
UyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
