From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2.10] Fix: do not repurpose
 iterator while it is being used (register trigger, 2.10)
Date: Tue, 22 Jan 2019 15:32:04 -0500
Message-ID: <CA+jJMxucb7pRDExK9H1b8KX+tRi+WpF3D4EVn8vQ8Bi8Adxefg__32146.1696339369$1548189179$gmane$org@mail.gmail.com>
References: <20181212223754.26205-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43kg8X35B8zncP
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:32:44 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 42964B5BFC
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:32:43 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id RJdw2ERCY06y for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:32:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D1388B5BF7
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:32:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id gf5eHVi2ltjq for <lttng-dev@lists.lttng.org>;
 Tue, 22 Jan 2019 15:32:42 -0500 (EST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by mail.efficios.com (Postfix) with ESMTPSA id 7AF09B5BEA
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:32:42 -0500 (EST)
Received: by mail-lf1-f46.google.com with SMTP id a16so19109161lfg.3
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:32:42 -0800 (PST)
In-Reply-To: <20181212223754.26205-1-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIHN0YWJsZS0yLjEwLgoKVGhhbmtzLApKw6lyw6ltaWUKCk9uIFdlZCwgMTIgRGVj
IDIwMTggYXQgMTc6MzcsIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+IHdyb3RlOgo+Cj4gVGhlIGhhc2ggdGFibGUgaXRlcmF0aW9uIHVzZXMgYW4gaXRl
cmF0b3IgdGhhdCBuZWVkcyB0byBzdGF5IHZhbGlkIGZvcgo+IHRoZSBuZXh0IGxvb3AuIFVzaW5n
IHRoYXQgc2FtZSBpdGVyYXRvciB2YXJpYWJsZSBpbiBhIG5lc3RlZCBsb29rdXAgaW4gYQo+IGRp
ZmZlcmVudCBoYXNoIHRhYmxlIGxlYWRzIHRvIHNlZ21lbnRhdGlvbiBmYXVsdC4KPgo+IFRoaXMg
aXMgYSAyLjEwLXNwZWNpZmljIGluc3RhbmNlIG9mIHRoZSBpc3N1ZSBhZmZlY3RpbmcKPiBiaW5k
X3RyaWdnZXJfdG9fbWF0Y2hpbmdfY2hhbm5lbHMoKSB3aGljaCB3YXMgZm91bmQgaW4gdGhlCj4g
bWFzdGVyIGFuZCAyLjExIGJyYW5jaGVzLiBUaGlzIG9uZSBhZmZlY3RzCj4gaGFuZGxlX25vdGlm
aWNhdGlvbl90aHJlYWRfY29tbWFuZF9yZWdpc3Rlcl90cmlnZ2VyKCkuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+
IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL25vdGlmaWNhdGlvbi10aHJlYWQtZXZlbnRz
LmMgfCA1ICsrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRp
b24tdGhyZWFkLWV2ZW50cy5jIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRpb24t
dGhyZWFkLWV2ZW50cy5jCj4gaW5kZXggNjc3N2ZkNmQuLmY1NDE0MWU3IDEwMDY0NAo+IC0tLSBh
L3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+ICsr
KyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+
IEBAIC0xMTE5LDYgKzExMTksNyBAQCBpbnQgaGFuZGxlX25vdGlmaWNhdGlvbl90aHJlYWRfY29t
bWFuZF9yZWdpc3Rlcl90cmlnZ2VyKAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNoYW5uZWxz
X2h0X25vZGUpIHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IGx0dG5nX3RyaWdnZXJfbGlzdF9l
bGVtZW50ICp0cmlnZ2VyX2xpc3RfZWxlbWVudDsKPiAgICAgICAgICAgICAgICAgc3RydWN0IGx0
dG5nX2NoYW5uZWxfdHJpZ2dlcl9saXN0ICp0cmlnZ2VyX2xpc3Q7Cj4gKyAgICAgICAgICAgICAg
IHN0cnVjdCBjZHNfbGZodF9pdGVyIGxvb2t1cF9pdGVyOwo+Cj4gICAgICAgICAgICAgICAgIGlm
ICghdHJpZ2dlcl9hcHBsaWVzX3RvX2NoYW5uZWwodHJpZ2dlciwgY2hhbm5lbCkpIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiBAQCAtMTEyOCw4ICsxMTI5LDggQEAgaW50
IGhhbmRsZV9ub3RpZmljYXRpb25fdGhyZWFkX2NvbW1hbmRfcmVnaXN0ZXJfdHJpZ2dlcigKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhhc2hfY2hhbm5lbF9rZXkoJmNoYW5uZWwt
PmtleSksCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXRjaF9jaGFubmVsX3Ry
aWdnZXJfbGlzdCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjaGFubmVsLT5r
ZXksCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaXRlcik7Cj4gLSAgICAgICAg
ICAgICAgIG5vZGUgPSBjZHNfbGZodF9pdGVyX2dldF9ub2RlKCZpdGVyKTsKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZsb29rdXBfaXRlcik7Cj4gKyAgICAgICAgICAgICAgIG5v
ZGUgPSBjZHNfbGZodF9pdGVyX2dldF9ub2RlKCZsb29rdXBfaXRlcik7Cj4gICAgICAgICAgICAg
ICAgIGFzc2VydChub2RlKTsKPiAgICAgICAgICAgICAgICAgdHJpZ2dlcl9saXN0ID0gY2FhX2Nv
bnRhaW5lcl9vZihub2RlLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGx0dG5nX2NoYW5uZWxfdHJpZ2dlcl9saXN0LAo+IC0tCj4gMi4xMS4wCj4KCgotLSAKSsOpcsOp
bWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
