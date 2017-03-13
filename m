From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Setenv/getenv are not thread-safe; whose bug is it?
Date: Mon, 13 Mar 2017 01:12:30 +0000 (UTC)
Message-ID: <884824855.3833.1489367550330.JavaMail.zimbra__22946.2005118423$1489367891$gmane$org@efficios.com>
References: <HE1PR07MB095321C916B1298B997744F6F0200@HE1PR07MB0953.eurprd07.prod.outlook.com>
 <1656612379.3244.1489188755549.JavaMail.zimbra@efficios.com>
 <HE1PR07MB09535F02D666D99BB7221713F0250@HE1PR07MB0953.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vhKjx5ShczwN7
 for <lttng-dev@lists.lttng.org>; Mon, 13 Mar 2017 01:17:57 +0000 (UTC)
In-Reply-To: <HE1PR07MB09535F02D666D99BB7221713F0250@HE1PR07MB0953.eurprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Douglas Graham <douglas.graham@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWFyIDEyLCAyMDE3LCBhdCA4OjIxIFBNLCBEb3VnbGFzIEdyYWhhbSBkb3VnbGFz
LmdyYWhhbUBlcmljc3Nvbi5jb20gd3JvdGU6Cgo+PiBUaGFua3MgYSBsb3QgZm9yIHRoZSB2ZXJ5
IHRob3JvdWdoIGJ1dCByZXBvcnQhCj4+IEkganVzdCBwcmVwYXJlZCBhIHBhdGNoIGZvciB5b3Ug
c2VudCBpbiBhIHNlcGFyYXRlIHRocmVhZDoKPj4gIltQQVRDSCBsdHRuZy11c3RdIEZpeDogcmFj
ZSBiZXR3ZWVuIGx0dG5nLXVzdCBnZXRlbnYoKSBhbmQgYXBwbGljYXRpb24KPj4gc2V0ZW52KCki
Cj4+IENhbiB5b3UgZ2l2ZSBpdCBhIHRyeSBhbmQgbGV0IG1lIGtub3cgaWYgaXQgZml4ZXMgdGhp
bmdzIG9uIHlvdXIgc2lkZSA/Cj4gCj4gVGhhbmtzIGZvciB0aGUgcXVpY2sgdHVybmFyb3VuZCBN
YXRoaWV1IQo+IAo+IEkgZG9uJ3Qga25vdyBob3cgd2UgYnVpbGQgbHR0bmcgYnV0IEkgaGF2ZSBw
YXNzZWQgdGhpcyBpbmZvcm1hdGlvbiBhbG9uZyB0byB0aGUKPiB0ZWFtIHRoYXQgZG9lcywgYXNr
aW5nIHRoYXQgdGhleSBwcm92aWRlIG1lIGEgbGlicmFyeSB3aXRoIHRoaXMgcGF0Y2ggYXBwbGll
ZAo+IGZvciB1cyB0byB0ZXN0LiAgSSdsbCBsZXQgeW91IGtub3cgaG93IGl0IGxvb2tzIHdoZW4g
d2UgZ2V0IHRoZXJlLgoKRllJLCB0aGlzIHBhdGNoIGlzIG5vdyBpbiBsdHRuZy11c3QgbWFzdGVy
IGJyYW5jaCwgYW5kIHRoZSBmb2xsb3dpbmcKcGF0Y2ggZml4ZXMgYSB3YXJuaW5nIGludHJvZHVj
ZWQgYnkgbXkgaW5pdGlhbCBwYXRjaDoKCmNvbW1pdCA5MmNlMjU2ZGE0ZGExNTg2NDY1ZTE4MzYy
ZTg4YjViZTE2NzUyZDU5CkF1dGhvcjogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4KRGF0ZTogICBTYXQgTWFyIDExIDIxOjE4OjI3IDIwMTcgLTA1MDAK
CiAgICBGaXg6IGFkZCBtaXNzaW5nIGdldGVudi5oIGluY2x1ZGUgdG8gdXN0Y3RsLmMKICAgIAog
ICAgU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVm
ZmljaW9zLmNvbT4KClRoYW5rcywKCk1hdGhpZXUKCgo+IAo+IFJlZ2FyZHMsCj4gRG91ZwoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
