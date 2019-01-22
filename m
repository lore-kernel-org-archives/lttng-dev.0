From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: do not repurpose iterator
 while it is being used
Date: Tue, 22 Jan 2019 15:35:04 -0500
Message-ID: <CA+jJMxsU9fQ2Z-GKMhn+_kDCZEFwS=wQzJFESuBvn+811npZYg__21484.1253402241$1548189362$gmane$org@mail.gmail.com>
References: <20181212222411.24517-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43kgCy5CQDznf2
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:35:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 653C5B5D62
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:35:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id hsUzCahkbaLn for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:35:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0D611B5D59
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:35:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id i2oz0CXCAN3v for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:35:41 -0500 (EST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mail.efficios.com (Postfix) with ESMTPSA id AB323B5D4E
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:35:41 -0500 (EST)
Received: by mail-lj1-f176.google.com with SMTP id k15-v6so21856935ljc.8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:35:41 -0800 (PST)
In-Reply-To: <20181212222411.24517-1-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTEuCgpUaGFua3MsCkrDqXLDqW1pZQoKT24g
V2VkLCAxMiBEZWMgMjAxOCBhdCAxNzoyNCwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBUaGUgaGFzaCB0YWJsZSBpdGVyYXRpb24g
dXNlcyBhbiBpdGVyYXRvciB0aGF0IG5lZWRzIHRvIHN0YXkgdmFsaWQgZm9yCj4gdGhlIG5leHQg
bG9vcC4gVXNpbmcgdGhhdCBzYW1lIGl0ZXJhdG9yIHZhcmlhYmxlIGluIGEgbmVzdGVkIGxvb2t1
cAo+IGluIGEgZGlmZmVyZW50IGhhc2ggdGFibGUgbGVhZHMgdG8gc2VnbWVudGF0aW9uIGZhdWx0
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRp
b24tdGhyZWFkLWV2ZW50cy5jIHwgNSArKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+IGluZGV4IDljYzkxY2M0Li45ZDgyYjgz
MSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10aHJl
YWQtZXZlbnRzLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10
aHJlYWQtZXZlbnRzLmMKPiBAQCAtMTkzMSw2ICsxOTMxLDcgQEAgaW50IGJpbmRfdHJpZ2dlcl90
b19tYXRjaGluZ19jaGFubmVscyhjb25zdCBzdHJ1Y3QgbHR0bmdfdHJpZ2dlciAqdHJpZ2dlciwK
PiAgICAgICAgICAgICAgICAgICAgICAgICBjaGFubmVsc19odF9ub2RlKSB7Cj4gICAgICAgICAg
ICAgICAgIHN0cnVjdCBsdHRuZ190cmlnZ2VyX2xpc3RfZWxlbWVudCAqdHJpZ2dlcl9saXN0X2Vs
ZW1lbnQ7Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCBsdHRuZ19jaGFubmVsX3RyaWdnZXJfbGlz
dCAqdHJpZ2dlcl9saXN0Owo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgY2RzX2xmaHRfaXRlciBs
b29rdXBfaXRlcjsKPgo+ICAgICAgICAgICAgICAgICBpZiAoIXRyaWdnZXJfYXBwbGllc190b19j
aGFubmVsKHRyaWdnZXIsIGNoYW5uZWwpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7Cj4gQEAgLTE5NDAsOCArMTk0MSw4IEBAIGludCBiaW5kX3RyaWdnZXJfdG9fbWF0Y2hp
bmdfY2hhbm5lbHMoY29uc3Qgc3RydWN0IGx0dG5nX3RyaWdnZXIgKnRyaWdnZXIsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBoYXNoX2NoYW5uZWxfa2V5KCZjaGFubmVsLT5rZXkp
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF0Y2hfY2hhbm5lbF90cmlnZ2Vy
X2xpc3QsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY2hhbm5lbC0+a2V5LAo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJml0ZXIpOwo+IC0gICAgICAgICAgICAg
ICBub2RlID0gY2RzX2xmaHRfaXRlcl9nZXRfbm9kZSgmaXRlcik7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmbG9va3VwX2l0ZXIpOwo+ICsgICAgICAgICAgICAgICBub2RlID0g
Y2RzX2xmaHRfaXRlcl9nZXRfbm9kZSgmbG9va3VwX2l0ZXIpOwo+ICAgICAgICAgICAgICAgICBh
c3NlcnQobm9kZSk7Cj4gICAgICAgICAgICAgICAgIHRyaWdnZXJfbGlzdCA9IGNhYV9jb250YWlu
ZXJfb2Yobm9kZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBsdHRu
Z19jaGFubmVsX3RyaWdnZXJfbGlzdCwKPiAtLQo+IDIuMTEuMAo+CgoKLS0gCkrDqXLDqW1pZSBH
YWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
