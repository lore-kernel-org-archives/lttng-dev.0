From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: tests: skip UST perf tests
	if not root
Date: Mon, 21 Sep 2015 12:19:45 -0400
Message-ID: <CA+jJMxuewpOdRPxZCSdWJNOVqTWk_e1bHhyJuT7QG2DnV_NFfQ__25841.9658210643$1442852621$gmane$org@mail.gmail.com>
References: <1442513450-8013-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ze3ol-0001Aj-9g
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 12:20:00 -0400
Received: by ykdg206 with SMTP id g206so107224028ykd.1
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 09:19:46 -0700 (PDT)
In-Reply-To: <1442513450-8013-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuNy4KSSBoYXZlIGFsc28gbW92ZWQgdGhlIHRl
c3QgZnJvbSB0aGUgImZhc3RfcmVncmVzc2lvbiIgdG8KInJvb3RfcmVncmVzc2lvbiIgdGVzdCBs
aXN0LgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIFRodSwgU2VwIDE3LCAyMDE1IGF0IDI6MTAgUE0s
IE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3Rl
Ogo+IFNvbWUgZGlzdHJpYnV0aW9ucyBsaWtlIERlYmlhbiAoZS5nLiBEZWJpYW4ga2VybmVsIDQu
MS4wLTItYW1kNjQpIGhhdmUKPiBzb21lIGdyc2VjdXJpdHkgb3B0aW9ucyBlbmFibGVkLCBzdWNo
IGFzIENPTkZJR19HUktFUk5TRUNfUEVSRl9IQVJERU4uCj4KPiBVbmZvcnR1bmF0ZWx5LCB0aGlz
IG9wdGlvbiBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIHVzZSB0aGUgU1cgcGFnZS1mYXVsdAo+IHBl
cmYgZXZlbnQgYXMgYSBub3JtYWwgdXNlci4gSXQgb25seSBsZWF2ZXMgc29tZSBIVyBldmVudHMu
IEhvd2V2ZXIsIHdlCj4gY2FuIG9ubHkgdXNlIFNXIGV2ZW50cyB3aXRoaW4gdmlydHVhbCBtYWNo
aW5lcy4KPgo+IFRoZXJlZm9yZSwgb25seSBydW4gdGhpcyB0ZXN0IGFzIHJvb3QgZm9yIG5vdyB1
bnRpbCB3ZSBmaW5kIGEgYmV0dGVyCj4gYXBwcm9hY2guCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRo
aWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0
ZXN0cy9yZWdyZXNzaW9uL3VzdC90ZXN0X2V2ZW50X3BlcmYgfCAxNSArKysrKysrKysrKystLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcmVncmVzc2lvbi91c3QvdGVzdF9ldmVudF9wZXJmIGIvdGVzdHMv
cmVncmVzc2lvbi91c3QvdGVzdF9ldmVudF9wZXJmCj4gaW5kZXggN2ZiMzdlZC4uN2RjMjE2OCAx
MDA3NTUKPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9uL3VzdC90ZXN0X2V2ZW50X3BlcmYKPiArKysg
Yi90ZXN0cy9yZWdyZXNzaW9uL3VzdC90ZXN0X2V2ZW50X3BlcmYKPiBAQCAtOTAsOCArOTAsMTcg
QEAgcGxhbl90ZXN0cyAkTlVNX1RFU1RTCj4KPiAgcHJpbnRfdGVzdF9iYW5uZXIgIiRURVNUX0RF
U0MiCj4KPiAtc3RhcnRfbHR0bmdfc2Vzc2lvbmQKPiAraWYgWyAiJChpZCAtdSkiID09ICIwIiBd
OyB0aGVuCj4gKyAgICAgICAgaXNyb290PTEKPiArZWxzZQo+ICsgICAgICAgIGlzcm9vdD0wCj4g
K2ZpCj4gKwo+ICtza2lwICRpc3Jvb3QgIlJvb3QgYWNjZXNzIGlzIG5lZWRlZC4gU2tpcHBpbmcg
VVNUIHBlcmYgdGVzdHMuIiAke05VTV9URVNUU30gfHwKPiArewo+ICsgICAgICAgc3RhcnRfbHR0
bmdfc2Vzc2lvbmQKPgo+IC10ZXN0X2V2ZW50X2Jhc2ljCj4gKyAgICAgICB0ZXN0X2V2ZW50X2Jh
c2ljCj4KPiAtc3RvcF9sdHRuZ19zZXNzaW9uZAo+ICsgICAgICAgc3RvcF9sdHRuZ19zZXNzaW9u
ZAo+ICt9Cj4gLS0KPiAyLjEuNAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
