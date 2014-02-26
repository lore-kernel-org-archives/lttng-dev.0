From: Zifei Tong <soariez@gmail.com>
Subject: Re: [GSOC] Interested in contributing to LTTng: Python
 tracing support
Date: Wed, 26 Feb 2014 23:25:05 +0800
Message-ID: <CAJ7wx-HBK54K1tN1e-Mab6g_meiPVHijLLmG32MZ9A9wfb4ZVw__5401.82348709113$1393428420$gmane$org@mail.gmail.com>
References: <CANK7Sy88U0q3YJ=Ys32_zgNf=QJYCh3QCca8iUgksWupBqNuAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1WIgMp-00041B-9x
	for lttng-dev@lists.lttng.org; Wed, 26 Feb 2014 10:25:56 -0500
Received: by mail-vc0-f172.google.com with SMTP id lf12so1095041vcb.3
	for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2014 07:25:45 -0800 (PST)
In-Reply-To: <CANK7Sy88U0q3YJ=Ys32_zgNf=QJYCh3QCca8iUgksWupBqNuAw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?B?5YiY6LeD?= <liuyue0310@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgWXVlLAoKSXQncyBhIF9ncmVhdF8gZXhwZXJpZW5jZSBmb3IgbWUgdG8gd29yayB3aXRoIHRo
ZSBMVFRuZyBjb21tdW5pdHkgaW4KdGhlIGxhc3QgeWVhcidzIEdTb0MuCgpGZWVsIGZyZWUgdG8g
YXNrIG1lIChieSBJUkMgb3IgZW1haWwpIGFueXRoaW5nIGxpa2UgdGhlIEdTb0MKYXBwbGljYXRp
b24gcHJvY2VzcyBvciBzby4KClRoYW5rcywKWmlmZWkgVG9uZwoKT24gV2VkLCBGZWIgMjYsIDIw
MTQgYXQgNToyNiBQTSwg5YiY6LeDIDxsaXV5dWUwMzEwQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGks
Cj4KPiAgICAgSSBhbSBZdWUgTGl1LCBzZWNvbmQgeWVhciBncmFkdWF0ZSBpbiBDb21wdXRlciBT
Y2llbmNlIGFuZCBFbmdpbmVlcmluZy4KPiBJJ20gaW50ZXJlc3RlZCBpbiBjb250cmlidXRpbmcg
dG8gUHl0aG9uIHRyYWNpbmcgc3VwcG9ydC4gSSBhbSBHb29kIGluCj4gQy9DKysvUHl0aG9uIGFu
ZCBVbml4IE9wZXJhdGluZyBTeXN0ZW0uIEkgYWxzbyBoYXZlIGdvb2QgZXhwZXJpZW5jZSBpbgo+
IERlYnVnZ2luZy9SZXZlcnNlIEVuZ2luZWVyaW5nL0JpbmFyeSBIYWNrLgo+ICAgICBQbGVhc2Ug
bGV0IG1lIGtub3cgaG93IHNob3VsZCBJIHByb2NlZWQgZnVydGhlci4KPgo+ICAgICBUaGFuayB5
b3UhCj4KPiBZdWUgTGl1Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IFRzaW5naHVhIFVuaXZlcnNpdHkgTklTTC1MYWIoRklULTEt
MjEzKQo+IFRFTDogKzg2LTE1Ni01Mjc5LTgxOTEKPiBNYWlsOiBsaXV5dWUwMzEwQGdtYWlsLmNv
bQo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0
cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
