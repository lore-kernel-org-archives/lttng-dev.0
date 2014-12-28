From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: add missing RCU read unlock
Date: Sun, 28 Dec 2014 14:11:00 -0500
Message-ID: <CA+jJMxu_GdAwYxAknLAxeNvVkJ=DW1vTtXXV7aL=7=5Ld8gn_A__9252.82143657586$1419793924$gmane$org@mail.gmail.com>
References: <1419441001-29408-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Y5JF4-00072h-5q
 for lttng-dev@lists.lttng.org; Sun, 28 Dec 2014 14:11:08 -0500
Received: by mail-qg0-f49.google.com with SMTP id a108so8709131qge.36
 for <lttng-dev@lists.lttng.org>; Sun, 28 Dec 2014 11:11:00 -0800 (PST)
In-Reply-To: <1419441001-29408-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgRGVjIDI0LCAyMDE0IGF0IDEyOjEw
IFBNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3
cm90ZToKPiBNYXN0ZXIgY29tbWl0IDI0ZWI4NTY5ZGM4NDFmMzE4ZDc5NjRjYTlhMGFkMGE0Zjk1
MDhhOGUKPiAiRml4OiBNaXNzaW5nIFJDVSByZWFkIGxvY2tzIGluIHN5c2NhbGxfbGlzdF9jaGFu
bmVsKCkiCj4KPiBJbnRyb2R1Y2VzIHVuYmFsYW5jZWQgUkNVIHJlYWQtc2lkZSBsb2NrL3VubG9j
ay4gU2hvdWxkIGJlIGFwcGxpZWQgdG8KPiBtYXN0ZXIgYW5kIHN0YWJsZS0yLjYuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3Mu
Y29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3N5c2NhbGwuYyB8IDEgKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0
dG5nLXNlc3Npb25kL3N5c2NhbGwuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5j
Cj4gaW5kZXggYzM4Zjg5MS4uYmZlMzJhYyAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNl
c3Npb25kL3N5c2NhbGwuYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc3lzY2FsbC5j
Cj4gQEAgLTQwOSw2ICs0MDksNyBAQCBzc2l6ZV90IHN5c2NhbGxfbGlzdF9jaGFubmVsKHN0cnVj
dCBsdHRfa2VybmVsX2NoYW5uZWwgKmtjaGFuLAo+ICAgICAgICAgICAgICAgICBrc3lzY2FsbCA9
IGxvb2t1cF9zeXNjYWxsKHN5c2NhbGxzX2h0LCBzeXNjYWxsX3RhYmxlW2ldLm5hbWUpOwo+ICAg
ICAgICAgICAgICAgICBpZiAoa3N5c2NhbGwpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB1
cGRhdGVfZXZlbnRfc3lzY2FsbF9iaXRuZXNzKGV2ZW50cywgaSwga3N5c2NhbGwtPmluZGV4KTsK
PiArICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAg
ICAgICBrc3lzY2FsbCA9IE5VTEw7Cj4gLS0KPiAyLjEuMQo+CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
