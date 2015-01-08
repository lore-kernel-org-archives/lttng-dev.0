From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix: mi: snapshot: missing error handling
 for session name
Date: Thu, 8 Jan 2015 14:52:00 -0500
Message-ID: <CA+jJMxuKRchyekOwtf9Ahk6D_3otFR1m41t_P829DK_gJ=Aojg__48210.6736432344$1420746839$gmane$org@mail.gmail.com>
References: <1420559987-29062-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Y9J7r-0001sf-MU
 for lttng-dev@lists.lttng.org; Thu, 08 Jan 2015 14:52:13 -0500
Received: by mail-qg0-f46.google.com with SMTP id q107so4290023qgd.5
 for <lttng-dev@lists.lttng.org>; Thu, 08 Jan 2015 11:52:00 -0800 (PST)
In-Reply-To: <1420559987-29062-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNi4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBU
dWUsIEphbiA2LCAyMDE1IGF0IDEwOjU5IEFNLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5y
YWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0
aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgc3JjL2NvbW1vbi9taS1sdHRuZy5jIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vbWktbHR0bmcuYyBiL3NyYy9j
b21tb24vbWktbHR0bmcuYwo+IGluZGV4IDc1MmJjZWMuLmZlZDA5ODUgMTAwNjQ0Cj4gLS0tIGEv
c3JjL2NvbW1vbi9taS1sdHRuZy5jCj4gKysrIGIvc3JjL2NvbW1vbi9taS1sdHRuZy5jCj4gQEAg
LTEzNDEsNiArMTM0MSw5IEBAIGludCBtaV9sdHRuZ19zbmFwc2hvdF9vdXRwdXRfc2Vzc2lvbl9u
YW1lKHN0cnVjdCBtaV93cml0ZXIgKndyaXRlciwKPiAgICAgICAgIC8qIFNuYXBzaG90IG91dHB1
dCBsaXN0IGZvciBjdXJyZW50IHNlc3Npb24gbmFtZSAqLwo+ICAgICAgICAgcmV0ID0gbWlfbHR0
bmdfd3JpdGVyX3dyaXRlX2VsZW1lbnRfc3RyaW5nKHdyaXRlciwgY29uZmlnX2VsZW1lbnRfbmFt
ZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICBzZXNzaW9uX25hbWUpOwo+ICsgICAgICAgaWYg
KHJldCkgewo+ICsgICAgICAgICAgICAgICBnb3RvIGVuZDsKPiArICAgICAgIH0KPgo+ICAgICAg
ICAgLyogT3BlbiBlbGVtZW50IHNuYXBzaG90cyAoc2VxdWVuY2Ugb25lIHNuYXBzaG90KSAqLwo+
ICAgICAgICAgcmV0ID0gbWlfbHR0bmdfd3JpdGVyX29wZW5fZWxlbWVudCh3cml0ZXIsIG1pX2x0
dG5nX2VsZW1lbnRfc25hcHNob3RzKTsKPiAtLQo+IDEuOS4xCj4KPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlz
dAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5l
YXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
