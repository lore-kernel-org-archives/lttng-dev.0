From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: problem running/installing lttng on ubuntu 16.04
Date: Mon, 22 Aug 2016 14:25:11 -0400
Message-ID: <241abc2f-65fc-bdb0-cf58-7a1900c4fd5a__7240.76528936184$1471890331$gmane$org@efficios.com>
References: <CAKH_oXJ+20uS1d1S71JLbYkPO9+Cx=3v4-+Ss_jbj7rnUzp8_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 20F54A205C
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2016 18:25:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8D93C340207
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2016 18:25:19 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id lKz8Eta5JNmt for <lttng-dev@lists.lttng.org>;
 Mon, 22 Aug 2016 18:25:12 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AFDDF34020D
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2016 18:25:12 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id uwOQuGtoPJ-2 for <lttng-dev@lists.lttng.org>;
 Mon, 22 Aug 2016 18:25:12 +0000 (UTC)
Received: from [172.24.0.18] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 47D26340207
 for <lttng-dev@lists.lttng.org>; Mon, 22 Aug 2016 18:25:12 +0000 (UTC)
In-Reply-To: <CAKH_oXJ+20uS1d1S71JLbYkPO9+Cx=3v4-+Ss_jbj7rnUzp8_w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGkgTm9hbSwKCk9uIDIwMTYtMDgtMTcgMDY6MjUgQU0sIE5vYW0gQ29oZW4gd3JvdGU6Cj4gSGVs
bG8KPiBJIGluc3RhbGxlZCBsdHRuZyBvbiBteSB1YnVudHUsIGFuZCB0cmllZCB0aGUgImdldHRp
bmcgU3RhcnRlZCIuCj4KPiBJIHJhbiB0aGUgaGVsbG9Xb3JsZCwgYW5kIHRoZW4KPiAkIGx0dG5n
IGxpc3QgLS11c2Vyc3BhY2UKPiBFcnJvcjogVW5hYmxlIHRvIGxpc3QgVVNUIGV2ZW50czogTm8g
c2Vzc2lvbiBkYWVtb24gaXMgYXZhaWxhYmxlCj4gRXJyb3I6IENvbW1hbmQgZXJyb3IKVGhpcyBs
b29rcyBsaWtlIGEgbm9ybWFsIGVycm9yIGJhc2VkIG9uIHRoZSBhYnNlbmNlIG9mIGEgc2Vzc2lv
biBkYWVtb24uCgo+IFdhaXRlZCBhIG1pbnV0ZSBhbmQgcmV0cmllZCwgYW5kIG5vdyB0aGUgb3V0
cHV0IHdhcyBhcyBleHBlY3RlZC4KCklzIGl0IHBvc3NpYmxlIHlvdSBjcmVhdGVkIGEgc2Vzc2lv
biBpbiB0aGUgbWVhbiB0aW1lID8KClRoZSBvbmx5IGNvbW1hbmQgdGhhdCBzaG91bGQgc3Bhd24g
YSBzZXNzaW9uIGRhZW1vbiBpcyAibHR0bmcgY3JlYXRlIC4uLiAiLgoKSnVzdCB0byBtYWtlIHN1
cmUgdGhpcyAgaXMgbm90IHNpbXBseSBiZWNhdXNlIHNlc3Npb25kIGlzIG5vdCByZWFkeSB5b3Ug
CmNhbiBwYXNzIHRoZSAiLWIiIG9wdGlvbiB0byBsdHRuZy1zZXNzaW9uZCB0byBtYWtlIHN1cmUg
dGhhdCB0aGUgY29tbWFuZCAKbGluZSByZXR1cm4gb25seSB3aGVuIHNlc3Npb25kIGlzIHJlYWR5
LgoKPiAkIGx0dG5nIGxpc3QgLS11c2Vyc3BhY2UKPiBVU1QgZXZlbnRzOgo+IC0tLS0tLS0tLS0t
LS0KPgo+IFBJRDogMTczODYgLSBOYW1lOiAuL2hlbGxvCj4gICAgICAgIGx0dG5nX3VzdF90cmFj
ZWxvZzpUUkFDRV9ERUJVRyAobG9nbGV2ZWw6IFRSQUNFX0RFQlVHICgxNCkpICh0eXBlOgo+IHRy
YWNlcG9pbnQpCj4gICAgICAgIDwgU05JUCA+Cj4gICAgICAgIGhlbGxvX3dvcmxkOm15X2ZpcnN0
X3RyYWNlcG9pbnQgKGxvZ2xldmVsOiBUUkFDRV9ERUJVR19MSU5FICgxMykpCj4gKHR5cGU6IHRy
YWNlcG9pbnQpCj4KPiAqKklzIGl0IG5vcm1hbCBiZWhhdmlvcj8qCj4KPiBUaGVuLAo+ICQgbHR0
bmcgY3JlYXRlCj4gU2Vzc2lvbiBhdXRvLTIwMTYwODE3LTEzMjEyMyBjcmVhdGVkLgo+IFRyYWNl
cyB3aWxsIGJlIHdyaXR0ZW4gaW4gL2hvbWUvbm9hbS9sdHRuZy10cmFjZXMvYXV0by0yMDE2MDgx
Ny0xMzIxMjMKPiBub2FtQG5vYW0tbnVjOn4vdG1wL2x0dG5nJCBsdHRuZyBlbmFibGUtZXZlbnQg
LS11c2Vyc3BhY2UKPiBoZWxsb193b3JsZDpteV9maXJzdF90cmFjZXBvaW50Cj4gRXJyb3I6IEV2
ZW50IGhlbGxvX3dvcmxkOm15X2ZpcnN0X3RyYWNlcG9pbnQ6IFVTVCBjcmVhdGUgY2hhbm5lbCBm
YWlsZWQKPiAoY2hhbm5lbCBjaGFubmVsMCwgc2Vzc2lvbiBhdXRvLTIwMTYwODE3LTEzMjEyMykK
VGhpcyBpcyBjbGVhcmx5IHVuZXhwZWN0ZWQsIGxvZ3Mgc2hvdWxkIHByb3ZpZGUgbW9yZSBpbmZv
cm1hdGlvbi4KPgo+IEhvdyBkbyBJIHNvbHZlIGl0Pwo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
IHN5c3RlbSBwcm9wZXJ0aWVzOgo+Cj4gbm9hbUBub2FtLW51Yzp+JCBwcyAtZWYgfCBncmVwIGx0
dG5nCj4gbm9hbSAgICAgMTc0MTAgMTczOTggIDAgMTM6MTggcHRzLzMgICAgMDA6MDA6MDAgbHR0
bmctc2Vzc2lvbmQgLXZ2dgoKU2luY2UgeW91IHBhc3NlZCB0aGUgLXZ2diBvcHRpb24gY291bGQg
d2Ugc2VlIHRoZSBsb2cgPwoKPiBub2FtICAgICAxNzQxMSAxNzQxMCAgMCAxMzoxOCBwdHMvMyAg
ICAwMDowMDowMCBsdHRuZy1ydW5hcyAgICAtdnZ2Cj4gbm9hbSAgICAgMTc0NDIgMTc0MTAgIDAg
MTM6MjEgcHRzLzMgICAgMDA6MDA6MDAgbHR0bmctY29uc3VtZXJkICAtdQo+IC0tY29uc3VtZXJk
LWNtZC1zb2NrIC9ob21lL25vYW0vLmx0dG5nL3VzdGNvbnN1bWVyZDY0L2NvbW1hbmQKPiAtLWNv
bnN1bWVyZC1lcnItc29jayAvaG9tZS9ub2FtLy5sdHRuZy91c3Rjb25zdW1lcmQ2NC9lcnJvciAt
LWdyb3VwIHRyYWNpbmcKPiBub2FtICAgICAxNzQ0NCAxNzQ0MiAgMCAxMzoyMSBwdHMvMyAgICAw
MDowMDowMCBsdHRuZy1ydW5hcyAgICAgIC11Cj4gLS1jb25zdW1lcmQtY21kLXNvY2sgL2hvbWUv
bm9hbS8ubHR0bmcvdXN0Y29uc3VtZXJkNjQvY29tbWFuZAo+IC0tY29uc3VtZXJkLWVyci1zb2Nr
IC9ob21lL25vYW0vLmx0dG5nL3VzdGNvbnN1bWVyZDY0L2Vycm9yIC0tZ3JvdXAgdHJhY2luZwo+
IG5vYW0gICAgIDE3NDgwIDE3NDY3ICAwIDEzOjIyIHB0cy83ICAgIDAwOjAwOjAwIGdyZXAgLS1j
b2xvcj1hdXRvIGx0dG5nCj4gbm9hbUBub2FtLW51Yzp+JCBsc2JfcmVsZWFzZSAtYQo+IE5vIExT
QiBtb2R1bGVzIGFyZSBhdmFpbGFibGUuCj4gRGlzdHJpYnV0b3IgSUQ6IFVidW50dQo+IERlc2Ny
aXB0aW9uOiBVYnVudHUgMTYuMDQuMSBMVFMKPiBSZWxlYXNlOiAxNi4wNAo+IENvZGVuYW1lOiB4
ZW5pYWwKPgo+Cj4gSW5zdGFsbGVkIGx0dG5nIHVzaW5nOgo+IHN1ZG8gYXB0LWdldCBpbnN0YWxs
IGx0dG5nLXRvb2xzIGx0dG5nLW1vZHVsZXMtZGttcyBsaWJsdHRuZy11c3QtZGV2Cj4KPgo+ICQg
bHR0bmcgLS12ZXJzaW9uCj4gbHR0bmcgKExUVG5nIFRyYWNlIENvbnRyb2wpIDIuNy4xIC0gSGVy
YmUgw6AgRMOpdG91cm5lCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKCi0tIApKb25hdGhhbiBSLiBKdWxpZW4KRWZmaWNpb3MKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
