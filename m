From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: lttng-live: send HUP reply
 when per-PID streams are gone
Date: Sat, 6 May 2017 15:50:02 -0400
Message-ID: <CA+jJMxsVm-OwdmUvqH6jDzZRq3svGF0YTR3imv3KzK4U43Cc4w__26861.2737687819$1494100212$gmane$org@mail.gmail.com>
References: <1493735848-32743-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKzs71MYkzDX9
 for <lttng-dev@lists.lttng.org>; Sat,  6 May 2017 19:50:50 +0000 (UTC)
Received: by mail-yw0-x241.google.com with SMTP id 203so2681613ywe.0
 for <lttng-dev@lists.lttng.org>; Sat, 06 May 2017 12:50:03 -0700 (PDT)
In-Reply-To: <1493735848-32743-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIDIgTWF5IDIwMTcgYXQgMTA6MzcsIE1hdGhp
ZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+IEN1
cnJlbnRseSwgdGhlICJIVVAiIHJlcGx5IChodW5nIHVwKSBpcyBvbmx5IHNlbnQgd2hlbiBhIHNl
c3Npb24gZGVzdHJveQo+IGlzIHBlcmZvcm1lZCBhbmQgYWxsIGRhdGEgaGFzIGJlZW4gc2VudC4g
SG93ZXZlciwgd2l0aCBwZXItcGlkIGJ1ZmZlcnMsCj4gYXBwbGljYXRpb24gY2FuIGNvbWUgYW5k
IGdvIGR1cmluZyB0aGUgdHJhY2luZyBzZXNzaW9uLCBzbyB3ZSBuZWVkIHRvCj4gc2VuZCB0aGUg
SFVQIHJlcGx5IGZvciBlYWNoIGluZGl2aWR1YWwgc3RyZWFtIHRoYXQgaXMgZ29uZS4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lv
cy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyB8IDcgKysrKystLQo+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctcmVsYXlkL2xpdmUuYyBiL3NyYy9iaW4vbHR0bmctcmVs
YXlkL2xpdmUuYwo+IGluZGV4IDllMTA4NWYuLjYxYWNhZmUgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jp
bi9sdHRuZy1yZWxheWQvbGl2ZS5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvbGl2ZS5j
Cj4gQEAgLTExNzQsMTAgKzExNzQsMTMgQEAgc3RhdGljIGludCBjaGVja19pbmRleF9zdGF0dXMo
c3RydWN0IHJlbGF5X3ZpZXdlcl9zdHJlYW0gKnZzdHJlYW0sCj4gIHsKPiAgICAgICAgIGludCBy
ZXQ7Cj4KPiAtICAgICAgIGlmICh0cmFjZS0+c2Vzc2lvbi0+Y29ubmVjdGlvbl9jbG9zZWQKPiAr
ICAgICAgIGlmICgodHJhY2UtPnNlc3Npb24tPmNvbm5lY3Rpb25fY2xvc2VkIHx8IHJzdHJlYW0t
PmNsb3NlZCkKPiAgICAgICAgICAgICAgICAgICAgICAgICAmJiByc3RyZWFtLT5pbmRleF9yZWNl
aXZlZF9zZXFjb3VudAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPT0gdnN0cmVh
bS0+aW5kZXhfc2VudF9zZXFjb3VudCkgewo+IC0gICAgICAgICAgICAgICAvKiBMYXN0IGluZGV4
IHNlbnQgYW5kIHNlc3Npb24gY29ubmVjdGlvbiBpcyBjbG9zZWQuICovCj4gKyAgICAgICAgICAg
ICAgIC8qCj4gKyAgICAgICAgICAgICAgICAqIExhc3QgaW5kZXggc2VudCBhbmQgc2Vzc2lvbiBj
b25uZWN0aW9uIG9yIHJlbGF5Cj4gKyAgICAgICAgICAgICAgICAqIHN0cmVhbSBhcmUgY2xvc2Vk
Lgo+ICsgICAgICAgICAgICAgICAgKi8KPiAgICAgICAgICAgICAgICAgaW5kZXgtPnN0YXR1cyA9
IGh0b2JlMzIoTFRUTkdfVklFV0VSX0lOREVYX0hVUCk7Cj4gICAgICAgICAgICAgICAgIGdvdG8g
aHVwOwo+ICAgICAgICAgfSBlbHNlIGlmIChyc3RyZWFtLT5iZWFjb25fdHNfZW5kICE9IC0xVUxM
ICYmCj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIElu
Yy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
