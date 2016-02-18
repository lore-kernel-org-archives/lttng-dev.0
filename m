From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test: handle env variables
	undefined
Date: Thu, 18 Feb 2016 11:24:04 -0500
Message-ID: <CA+jJMxuVft-4YCRCVBtUmXJY7TXoBgS0vaBL+QydtkE-SCpTSw__21416.7360835292$1455812732$gmane$org@mail.gmail.com>
References: <1455744780-2527-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aWRNC-0006n4-2G
 for lttng-dev@lists.lttng.org; Thu, 18 Feb 2016 11:24:11 -0500
Received: by mail-ig0-f170.google.com with SMTP id 5so16585848igt.0
 for <lttng-dev@lists.lttng.org>; Thu, 18 Feb 2016 08:24:10 -0800 (PST)
In-Reply-To: <1455744780-2527-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFdlZCwgRmViIDE3LCAyMDE2IGF0IDQ6MzMg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gUHJldmVudCBlcnJvcnMgb24gbm9uLWV4aXN0ZW50IGtleSBmZXRjaGluZyBl
LmcgTERfUFJFTE9BRCAmIExEX0xJQlJBUllfUEFUSC4KPiBVc2VzIC5nZXQoKSB3aXRoIGEgZGVm
YXVsdCBlbXB0eSBzdHJpbmcgdG8gcHJldmVudCB0aGlzIGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+
Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vdXN0L3VzdC1kbC90ZXN0X3VzdC1kbC5weSB8IDQg
KystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L3VzdC1kbC90ZXN0X3VzdC1kbC5w
eSBiL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L3VzdC1kbC90ZXN0X3VzdC1kbC5weQo+IGluZGV4IDcx
MTdjYTEuLjk4MDEwMTIgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvcmVncmVzc2lvbi91c3QvdXN0LWRs
L3Rlc3RfdXN0LWRsLnB5Cj4gKysrIGIvdGVzdHMvcmVncmVzc2lvbi91c3QvdXN0LWRsL3Rlc3Rf
dXN0LWRsLnB5Cj4gQEAgLTQ2LDggKzQ2LDggQEAgZW5hYmxlX3VzdF90cmFjZXBvaW50X2V2ZW50
KHNlc3Npb25faW5mbywgIioiKQo+ICBzdGFydF9zZXNzaW9uKHNlc3Npb25faW5mbykKPgo+ICB0
ZXN0X2VudiA9IG9zLmVudmlyb24uY29weSgpCj4gLXRlc3RfZW52WyJMRF9QUkVMT0FEIl0gKz0g
IjpsaWJsdHRuZy11c3QtZGwuc28iCj4gLXRlc3RfZW52WyJMRF9MSUJSQVJZX1BBVEgiXSArPSAi
OiIgKyB0ZXN0X3BhdGgKPiArdGVzdF9lbnZbIkxEX1BSRUxPQUQiXSA9IHRlc3RfZW52LmdldCgi
TERfUFJFTE9BRCIsICIiKSArICI6bGlibHR0bmctdXN0LWRsLnNvIgo+ICt0ZXN0X2VudlsiTERf
TElCUkFSWV9QQVRIIl0gPSB0ZXN0X2Vudi5nZXQoIkxEX0xJQlJBUllfUEFUSCIsICIiKSArICI6
IiArIHRlc3RfcGF0aAo+ICB0ZXN0X3Byb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHRlc3RfcGF0
aCArICJwcm9nIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGRvdXQ9c3Vi
cHJvY2Vzcy5QSVBFLCBzdGRlcnI9c3VicHJvY2Vzcy5QSVBFLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudj10ZXN0X2VudikKPiAtLQo+IDIuNS4wCj4KCgoKLS0gCkrDqXLD
qW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
