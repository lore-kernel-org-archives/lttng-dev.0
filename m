From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: [PATCH lttng-ust 5/8] Fix: missing enum removal
	from the enum hashtable
Date: Thu, 8 Feb 2018 15:45:00 -0500
Message-ID: <CADcCL0h7joW64uTw3A6788smGTWrexGYdntF2TWQ_D32JSNZrA__8002.99552870474$1518122625$gmane$org@mail.gmail.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1517600891-23632-6-git-send-email-francis.deslauriers@efficios.com>
 <271937624.17827.1518036900541.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcqvk4SjRzDR2
 for <lttng-dev@lists.lttng.org>; Thu,  8 Feb 2018 20:45:22 +0000 (UTC)
Received: by mail-it0-x242.google.com with SMTP id o13so8200973ito.2
 for <lttng-dev@lists.lttng.org>; Thu, 08 Feb 2018 12:45:21 -0800 (PST)
In-Reply-To: <271937624.17827.1518036900541.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

MjAxOC0wMi0wNyAxNTo1NSBHTVQtMDU6MDAgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbT46Cj4gLS0tLS0gT24gRmViIDIsIDIwMTgsIGF0IDI6NDggUE0s
IEZyYW5jaXMgRGVzbGF1cmllcnMgZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20gd3Jv
dGU6Cj4KPiBJcyBpdCBhIGZpeCBvciBhIHByZXBhcmF0aW9uIHN0ZXAgZm9yIGEgbmV3IGZlYXR1
cmUgPwpTYW1lIHRob3VnaHQgcHJvY2VzcyB0aGF0IHdpdGg6IGNkc19obGlzdF9kZWwoJmV2ZW50
LT5obGlzdCk7CgpUaGFua3MsCkZyYW5jaXMKPgo+IFRoYW5rcywKPgo+IE1hdGhpZXUKPgo+PiBT
aWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVm
ZmljaW9zLmNvbT4KPj4gLS0tCj4+IGxpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYyB8IDEgKwo+
PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdpdCBhL2xpYmx0
dG5nLXVzdC9sdHRuZy1ldmVudHMuYyBiL2xpYmx0dG5nLXVzdC9sdHRuZy1ldmVudHMuYwo+PiBp
bmRleCBlOGQ0ODU3Li4yYjY3OWI1IDEwMDY0NAo+PiAtLS0gYS9saWJsdHRuZy11c3QvbHR0bmct
ZXZlbnRzLmMKPj4gKysrIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4+IEBAIC05OTAs
NiArOTkwLDcgQEAgc3RhdGljCj4+IHZvaWQgX2x0dG5nX2VudW1fZGVzdHJveShzdHJ1Y3QgbHR0
bmdfZW51bSAqX2VudW0pCj4+IHsKPj4gICAgICAgY2RzX2xpc3RfZGVsKCZfZW51bS0+bm9kZSk7
Cj4+ICsgICAgIGNkc19obGlzdF9kZWwoJl9lbnVtLT5obGlzdCk7Cj4+ICAgICAgIGZyZWUoX2Vu
dW0pOwo+PiB9Cj4+Cj4+IC0tCj4+IDIuNy40Cj4KPiAtLQo+IE1hdGhpZXUgRGVzbm95ZXJzCj4g
RWZmaWNpT1MgSW5jLgo+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgoKCi0tIApGcmFuY2lzIERl
c2xhdXJpZXJzClNvZnR3YXJlIGRldmVsb3BlcgpFZmZpY2lPUyBpbmMuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
