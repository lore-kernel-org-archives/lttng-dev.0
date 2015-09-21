From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: shm-path: handling of
	snprintf return value
Date: Mon, 21 Sep 2015 11:31:35 -0400
Message-ID: <CA+jJMxtE==Ppog+gLaryKb+9d1kygbEy+GOWhhwfTaedS1rLRg__15488.4675205269$1442849952$gmane$org@mail.gmail.com>
References: <1442601983-2536-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ze348-0000oR-Nd
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 11:31:47 -0400
Received: by ykdt18 with SMTP id t18so105660650ykd.3
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 08:31:35 -0700 (PDT)
In-Reply-To: <1442601983-2536-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNy4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBG
cmksIFNlcCAxOCwgMjAxNSBhdCAyOjQ2IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERl
c25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvY29t
bW9uL3VzdC1jb25zdW1lci91c3QtY29uc3VtZXIuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2NvbW1v
bi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMgYi9zcmMvY29tbW9uL3VzdC1jb25zdW1lci91
c3QtY29uc3VtZXIuYwo+IGluZGV4IGQ0NTcwN2IuLmEzNDJmOTcgMTAwNjQ0Cj4gLS0tIGEvc3Jj
L2NvbW1vbi91c3QtY29uc3VtZXIvdXN0LWNvbnN1bWVyLmMKPiArKysgYi9zcmMvY29tbW9uL3Vz
dC1jb25zdW1lci91c3QtY29uc3VtZXIuYwo+IEBAIC0yNTQsNyArMjU0LDcgQEAgaW50IGdldF9z
dHJlYW1fc2htX3BhdGgoY2hhciAqc3RyZWFtX3NobV9wYXRoLCBjb25zdCBjaGFyICpzaG1fcGF0
aCwgaW50IGNwdSkKPiAgICAgICAgIHN0cm5jcHkoc3RyZWFtX3NobV9wYXRoLCBzaG1fcGF0aCwg
UEFUSF9NQVgpOwo+ICAgICAgICAgc3RyZWFtX3NobV9wYXRoW1BBVEhfTUFYIC0gMV0gPSAnXDAn
Owo+ICAgICAgICAgcmV0ID0gc25wcmludGYoY3B1X25yLCBVSU5UX01BWF9TVFJfTEVOLCAiJXUi
LCBjcHUpOwo+IC0gICAgICAgaWYgKHJldCAhPSAxKSB7Cj4gKyAgICAgICBpZiAocmV0IDwgMCkg
ewo+ICAgICAgICAgICAgICAgICByZXQgPSAtMTsKPiAgICAgICAgICAgICAgICAgZ290byBlbmQ7
Cj4gICAgICAgICB9Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVm
ZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
