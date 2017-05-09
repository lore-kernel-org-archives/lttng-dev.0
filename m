From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] doc: how to trace consumerd
	with valgrind
Date: Tue, 9 May 2017 08:37:22 -0400
Message-ID: <CA+jJMxtEsxi76TkO797hBUkF7HnJ4pYG_nq-5jrPVqHYv8R0Zg__4573.91696186296$1494333507$gmane$org@mail.gmail.com>
References: <1494247117-15085-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMf6Y2ZMtzdVB
 for <lttng-dev@lists.lttng.org>; Tue,  9 May 2017 12:38:13 +0000 (UTC)
Received: by mail-yw0-x241.google.com with SMTP id 203so7186894ywe.0
 for <lttng-dev@lists.lttng.org>; Tue, 09 May 2017 05:37:23 -0700 (PDT)
In-Reply-To: <1494247117-15085-1-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTAsIHN0YWJsZS0yLjkgYW5kIHN0YWJsZS0yLjgs
IHRoYW5rcyEKCkrDqXLDqW1pZQoKT24gOCBNYXkgMjAxNyBhdCAwODozOCwgTWF0aGlldSBEZXNu
b3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9m
Zi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4K
PiAtLS0KPiAgZG9jL3ZhbGdyaW5kLWhvd3RvLnR4dCB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RvYy92YWxncmluZC1ob3d0by50
eHQgYi9kb2MvdmFsZ3JpbmQtaG93dG8udHh0Cj4gaW5kZXggNjhkY2FiYS4uYjE5MTBlMCAxMDA2
NDQKPiAtLS0gYS9kb2MvdmFsZ3JpbmQtaG93dG8udHh0Cj4gKysrIGIvZG9jL3ZhbGdyaW5kLWhv
d3RvLnR4dAo+IEBAIC0yLDMgKzIsOCBAQCBCdWlsZCBsdHRuZy10b29scyB3aXRoICItRFZBTEdS
SU5EIiB0byBjcmVhdGUgZXhlY3V0YWJsZXMgY29tcGF0aWJsZQo+ICB3aXRoIHRoZSB2YWxncmlu
ZCB0b29sLiBUaGUgc3RhcnQgd2l0aCBlLmcuOgo+Cj4gIHZhbGdyaW5kIC0tbGVhay1jaGVjaz1m
dWxsIGx0dG5nLXNlc3Npb25kCj4gKwo+ICtJZiB5b3Ugd2FudCB0byB0cmFjayBtZW1vcnkgYWxs
b2NhdGlvbnMgYW5kIGFjY2Vzc2VzIHdpdGhpbgo+ICtsdHRuZy1zZXNzaW9uZCBjaGlsZHJlbiBw
cm9jZXNzZXMgKGUuZy4gbHR0bmctY29uc3VtZXJkKSBhcyB3ZWxsOgo+ICsKPiArdmFsZ3JpbmQg
LS1sZWFrLWNoZWNrPWZ1bGwgLS10cmFjZS1jaGlsZHJlbj15ZXMgbHR0bmctc2Vzc2lvbmQKPiAt
LQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRw
Oi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
