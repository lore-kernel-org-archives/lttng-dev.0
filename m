From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix:
 handle_notification_thread_command: handle partial read
Date: Tue, 22 Jan 2019 15:13:16 -0500
Message-ID: <CA+jJMxuY82kKU53SX9Q9oT4tX6mzYMCwDqrs61OeK6AnPdyfGg__45297.4996458337$1548188054$gmane$org@mail.gmail.com>
References: <20181212201115.14997-1-mathieu.desnoyers@efficios.com>
 <20181212201115.14997-2-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43kfkp6BN9znZq
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 96AFCB5772
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id W2dLBxcvSagl for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5C4F7B576D
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id O1HquVcmBHXp for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mail.efficios.com (Postfix) with ESMTPSA id 04194B5763
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:13:54 -0500 (EST)
Received: by mail-lj1-f176.google.com with SMTP id t18-v6so21833333ljd.4
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:13:53 -0800 (PST)
In-Reply-To: <20181212201115.14997-2-mathieu.desnoyers@efficios.com>
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

Tm90ZSB0aGF0IHRoaXMgcGF0Y2ggd2FzIG1lcmdlZCBpbiBzdGFibGUtMi4xMCB0b28uCgpKw6ly
w6ltaWUKCk9uIFdlZCwgMTIgRGVjIDIwMTggYXQgMTU6MTEsIE1hdGhpZXUgRGVzbm95ZXJzCjxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Cj4gVXNlIGx0dG5nX3JlYWQo
KSB0byBoYW5kbGUgcGFydGlhbCByZWFkcyAocmV0dXJuaW5nIGxlc3MgdGhhbiB0aGUKPiByZXF1
ZXN0ZWQgYW1vdW50IG9mIGJ5dGVzKSBhcyB3ZWxsIGFzIHJldCA9IC0xLCBlcnJubyA9PSBFSU5U
Ui4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVy
c0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0
aW9uLXRocmVhZC1ldmVudHMuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+IGluZGV4IDM0ODJhN2U4Li45Y2M5MWNj
NCAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10aHJl
YWQtZXZlbnRzLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10
aHJlYWQtZXZlbnRzLmMKPiBAQCAtMjI3Nyw5ICsyMjc3LDkgQEAgaW50IGhhbmRsZV9ub3RpZmlj
YXRpb25fdGhyZWFkX2NvbW1hbmQoCj4gICAgICAgICBzdHJ1Y3Qgbm90aWZpY2F0aW9uX3RocmVh
ZF9jb21tYW5kICpjbWQ7Cj4KPiAgICAgICAgIC8qIFJlYWQgdGhlIGV2ZW50IHBpcGUgdG8gcHV0
IGl0IGJhY2sgaW50byBhIHF1aWVzY2VudCBzdGF0ZS4gKi8KPiAtICAgICAgIHJldCA9IHJlYWQo
bHR0bmdfcGlwZV9nZXRfcmVhZGZkKGhhbmRsZS0+Y21kX3F1ZXVlLmV2ZW50X3BpcGUpLCAmY291
bnRlciwKPiArICAgICAgIHJldCA9IGx0dG5nX3JlYWQobHR0bmdfcGlwZV9nZXRfcmVhZGZkKGhh
bmRsZS0+Y21kX3F1ZXVlLmV2ZW50X3BpcGUpLCAmY291bnRlciwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2YoY291bnRlcikpOwo+IC0gICAgICAgaWYgKHJldCA9PSAtMSkgewo+ICsg
ICAgICAgaWYgKHJldCAhPSBzaXplb2YoY291bnRlcikpIHsKPiAgICAgICAgICAgICAgICAgZ290
byBlcnJvcjsKPiAgICAgICAgIH0KPgo+IC0tCj4gMi4xMS4wCj4KCgotLSAKSsOpcsOpbWllIEdh
bGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
