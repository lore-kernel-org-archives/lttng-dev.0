From: Joel Fernandes via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Need some advice/tips for hacking lttng-analyses
Date: Sun, 4 Jun 2017 23:51:45 -0700
Message-ID: <CAJWu+orsoDsA-agDQReX3c1N0nfrBvBwvqS-j4DLGH5At3TyZw__7294.98641235313$1496645520$gmane$org@mail.gmail.com>
Reply-To: Joel Fernandes <joelaf@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x231.google.com (mail-ua0-x231.google.com
 [IPv6:2607:f8b0:400c:c08::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3wh5B514hVz12Ps
 for <lttng-dev@lists.lttng.org>; Mon,  5 Jun 2017 06:53:16 +0000 (UTC)
Received: by mail-ua0-x231.google.com with SMTP id h39so16205485uaa.3
 for <lttng-dev@lists.lttng.org>; Sun, 04 Jun 2017 23:51:46 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

SGkgSnVsaWVuLCBNYXRoaWV1IGFuZCBhbGwsCgpJIHNlZSBsdHRuZy1hbmFseXNlcyBoYXMgZG9u
ZSBhIGxvdCBvZiB3aGF0IHdlJ3JlIHN0YXJ0aW5nIHRvIHRyeSB0bwpkbyB3aGVuIHBhcnNpbmcg
QW5kcm9pZCB0cmFjZXMgYW5kIEknZCBsaWtlIHRvIGxldmVyYWdlIHRoYXQuCgpDdXJyZW50bHkg
aW4gQW5kcm9pZCB3ZSBqdXN0IGRlYWwgd2l0aCB0ZXh0IHRyYWNlcyAoZnRyYWNlIHN0b3JlZCBp
bgphbiBodG1sIGZpbGUpIC0gSXRzIGhhcmQgdG8gbW92ZSBhd2F5IGZyb20gdGhhdCBnaXZlbiBp
dHMgcG9wdWxhcml0eQphbmQgaXQgc2VlbXMgdG8gd29yayB3ZWxsIGZvciBvdXIgdXNlY2FzZXMg
KHRoZSB0cmFjZSBmb3JtYXQgaXRzZWxmIGlzCmFub3RoZXIgZGlzY3Vzc2lvbiB0aG91Z2gpLgoK
V2UndmUgc3RhcnRlZCB0byB1c2UgTElTQSB0byBwYXJzZSB0aGVtIHRvIGRvIGFuYWx5c2VzLiBD
dXJyZW50bHkKdGhvdWdoIHRoZSBhbmFseXNlcyBpcyBwcmltaXRpdmUgKGJ1aWxkIGEgRGF0YUZy
YW1lIG91dCBvZiB0cmFjZXMsCmpvaW4gdGhlIGZyYW1lcyBhbmQgYXBwbHkgYSBmdW5jdGlvbiku
IEhvd2V2ZXIgSSBleHRlbmRlZCB0aGlzIHRvIGJlCmFibGUgdG8gdXNlIGNhbGxiYWNrcyBzaW5j
ZSB0aGF0IHNlZW1zIG11Y2ggbW9yZSBmbGV4aWJsZToKClRyYWNlQ2FsbGJhY2soJzxwYXRoIHRv
IGh0bWw+JywgIHsgJ3NjaGVkX3N3aXRjaCc6CnNjaGVkX3N3aXRjaF9jYWxsYmFjaywgJ3NjaGVk
X3dha2V1cCc6IHNjaGVkX3dha2V1cF9jYWxsYmFjayB9KQoKRG8geW91IGhhdmUgYW55IHRob3Vn
aHRzIGFib3V0IHRoZSBlYXNpZXN0IHdheSB0byBnZXQgbHR0bmctYW5hbHlzZXMKdG8gd29yayB3
aXRoIGEgZGlmZmVyZW50ICdiYWNrZW5kJyBvdGhlciB0aGFuIENURj8gSSBhbSB3aWxsaW5nIHNw
ZW5kCnRpbWUgdG8gaGFjayBpdCBidXQgSSByZXF1ZXN0IHlvdSBmb3IgYW55IHRob3VnaHRzIG9u
IHdoZXJlIHRvIHN0YXJ0CmhhY2tpbmcgKHdoaWNoIGNsYXNzZXMsIGZpbGVzIGV0YykuIEkgYXBw
cmVjaWF0ZSBhbnkgdGlwcyBmcm9tIHlvdQp0aGF0IGNhbiBoZWxwIG1lIGdldCBhIGhlYWRzdGFy
dC4KCklPVywgSSBoYXZlIGEgYmFja2VuZCArIGNhbGxiYWNrcyB0byBjYWxsIChjYWxsYmFja3Mg
d3JpdHRlbiBpbgpQeXRob24pLiBJIHdhbnQgdG8gdXNlIGx0dG5nLWFuYWx5c2VzIHRvIGFuYWx5
emUgdGhlIGRhdGEgcGFzc2VkIHRvCnRoZSBjYWxsYmFja3MgYW5kIHJldXNlIGFsbCB0aGUgZXhp
c3Rpbmcgc3R1ZmYgaW4gaXQuCgpUaGFua3MgYSBsb3QhCgotSm9lbApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
