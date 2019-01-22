From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: notification thread:
 free session trigger list on error
Date: Tue, 22 Jan 2019 15:10:46 -0500
Message-ID: <CA+jJMxtTiUC9O8sq50DaVXstxwpgBo517iY48xxvYsSAvzBSBA__4955.2670841635$1548187905$gmane$org@mail.gmail.com>
References: <20181212201115.14997-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43kfgx5LjCznYx
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:11:25 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0E944B56B8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:11:25 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id hOG2KKRdOOYH for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:11:24 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8E2DAB56AE
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:11:24 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id a2RJh5KnEDBN for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:11:24 -0500 (EST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mail.efficios.com (Postfix) with ESMTPSA id 37846B56A8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:11:24 -0500 (EST)
Received: by mail-lj1-f182.google.com with SMTP id k15-v6so21794493ljc.8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:11:24 -0800 (PST)
In-Reply-To: <20181212201115.14997-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien <joraj@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTEuCgpUaGFu
a3MhCkrDqXLDqW1pZQoKT24gV2VkLCAxMiBEZWMgMjAxOCBhdCAxNToxMSwgTWF0aGlldSBEZXNu
b3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBTaWduZWQt
b2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
Pgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10aHJlYWQtZXZl
bnRzLmMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0t
Z2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRpb24tdGhyZWFkLWV2ZW50cy5j
IGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRpb24tdGhyZWFkLWV2ZW50cy5jCj4g
aW5kZXggYmE0ZTVhMDUuLjM0ODJhN2U4IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmct
c2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+IEBAIC0xNTE4LDYgKzE1MTgs
NyBAQCBzdHJ1Y3Qgc2Vzc2lvbl9pbmZvICpmaW5kX29yX2NyZWF0ZV9zZXNzaW9uX2luZm8oCj4g
ICAgICAgICBpZiAoIXNlc3Npb24pIHsKPiAgICAgICAgICAgICAgICAgRVJSKCJbbm90aWZpY2F0
aW9uLXRocmVhZF0gRmFpbGVkIHRvIGFsbG9jYXRpb24gc2Vzc2lvbiBpbmZvIGZvciBzZXNzaW9u
IFwiJXNcIiAodWlkID0gJWksIGdpZCA9ICVpKSIsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBuYW1lLCB1aWQsIGdpZCk7Cj4gKyAgICAgICAgICAgICAgIGx0dG5nX3Nlc3Npb25f
dHJpZ2dlcl9saXN0X2Rlc3Ryb3kodHJpZ2dlcl9saXN0KTsKPiAgICAgICAgICAgICAgICAgZ290
byBlcnJvcjsKPiAgICAgICAgIH0KPiAgICAgICAgIHRyaWdnZXJfbGlzdCA9IE5VTEw7Cj4gLS0K
PiAyLjExLjAKPgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
