From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Cleanup: spaghetti function
	return path
Date: Thu, 27 Nov 2014 17:30:22 -0500
Message-ID: <CA+jJMxtw=Vvn+wBvo0nA4Limym9QD1jU6ofvUGENeu6QdRWm5w__8592.55072796277$1417127460$gmane$org@mail.gmail.com>
References: <1416591396-7750-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7Zz-0002hx-Vu
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:30:30 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so4490738qcw.23
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:30:22 -0800 (PST)
In-Reply-To: <1416591396-7750-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTm92IDIxLCAyMDE0IGF0IDEyOjM2
IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3ll
cnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXJlbGF5ZC9saXZlLmMgfCA1
IC0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUu
Ywo+IGluZGV4IDI5NDBiMmMuLmE3NmY1MzAgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1y
ZWxheWQvbGl2ZS5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5jCj4gQEAgLTgw
NCwxNCArODA0LDkgQEAgaW50IHZpZXdlcl9saXN0X3Nlc3Npb25zKHN0cnVjdCByZWxheV9jb25u
ZWN0aW9uICpjb25uKQo+ICAgICAgICAgfQo+ICAgICAgICAgaGVhbHRoX2NvZGVfdXBkYXRlKCk7
Cj4KPiAtICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+ICAgICAgICAgcmV0ID0gMDsKPiAtICAg
ICAgIGdvdG8gZW5kOwo+IC0KPiAgZW5kX3VubG9jazoKPiAgICAgICAgIHJjdV9yZWFkX3VubG9j
aygpOwo+IC0KPiAtZW5kOgo+ICAgICAgICAgcmV0dXJuIHJldDsKPiAgfQo+Cj4gLS0KPiAyLjEu
MQo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
