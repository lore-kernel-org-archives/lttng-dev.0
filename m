From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: put viewer stream on send
	error
Date: Sat, 5 Sep 2015 12:18:57 -0400
Message-ID: <CA+jJMxunQL8DAYFTfmUfrU830qZLXnc9rumdetHKYpho+Vpqpg__43909.557714551$1441469985$gmane$org@mail.gmail.com>
References: <1441382616-20398-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZYGBC-0002rT-FV
 for lttng-dev@lists.lttng.org; Sat, 05 Sep 2015 12:19:06 -0400
Received: by ykek143 with SMTP id k143so47224164yke.2
 for <lttng-dev@lists.lttng.org>; Sat, 05 Sep 2015 09:18:57 -0700 (PDT)
In-Reply-To: <1441382616-20398-1-git-send-email-mathieu.desnoyers@efficios.com>
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

U3F1YXNoZWQgaW50byAiRml4OiBSZWxheSBkYWVtb24gb3duZXJzaGlwIGFuZCByZWZlcmVuY2Ug
Y291bnRpbmciLgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIEZyaSwgU2VwIDQsIDIwMTUgYXQgMTI6
MDMgUE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+
IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25v
eWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyB8
IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jIGIvc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvbGl2ZS5jCj4gaW5kZXggYmNjNDA0NS4uYTFmYmJiZSAxMDA2NDQKPiAtLS0gYS9z
cmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9s
aXZlLmMKPiBAQCAtMjQzLDEwICsyNDMsMTAgQEAgc3NpemVfdCBzZW5kX3ZpZXdlcl9zdHJlYW1z
KHN0cnVjdCBsdHRjb21tX3NvY2sgKnNvY2ssCj4gICAgICAgICAgICAgICAgIHB0aHJlYWRfbXV0
ZXhfdW5sb2NrKCZ2c3RyZWFtLT5zdHJlYW0tPmxvY2spOwo+Cj4gICAgICAgICAgICAgICAgIHJl
dCA9IHNlbmRfcmVzcG9uc2Uoc29jaywgJnNlbmRfc3RyZWFtLCBzaXplb2Yoc2VuZF9zdHJlYW0p
KTsKPiArICAgICAgICAgICAgICAgdmlld2VyX3N0cmVhbV9wdXQodnN0cmVhbSk7Cj4gICAgICAg
ICAgICAgICAgIGlmIChyZXQgPCAwKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBl
bmRfdW5sb2NrOwo+ICAgICAgICAgICAgICAgICB9Cj4gLSAgICAgICAgICAgICAgIHZpZXdlcl9z
dHJlYW1fcHV0KHZzdHJlYW0pOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICByZXQgPSAwOwo+IC0t
Cj4gMi4xLjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
