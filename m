From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/3] Fix: disable all ust events
Date: Wed, 16 Sep 2015 16:32:03 -0400
Message-ID: <CA+jJMxtYBRAEfdGKwv3YzrwNHnds=8f5PXFr-OcS4Pm4tCPM4g__36724.5666719556$1442435598$gmane$org@mail.gmail.com>
References: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1441915857-1544-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZcJNB-0008Hd-SU
 for lttng-dev@lists.lttng.org; Wed, 16 Sep 2015 16:32:10 -0400
Received: by ykft14 with SMTP id t14so79791390ykf.0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Sep 2015 13:32:03 -0700 (PDT)
In-Reply-To: <1441915857-1544-2-git-send-email-jonathan.rajotte-julien@efficios.com>
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

T24gVGh1LCBTZXAgMTAsIDIwMTUgYXQgNDoxMCBQTSwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRo
YW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBIYW5kbGUgKiBldmVudCBj
b3JyZWN0bHkuCj4KPiBGaXhlcyAjOTM2Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpv
dHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgfCA2ICsrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC9jbWQuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKPiBpbmRleCAw
NThkYmFlLi40NzBmMjlkIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21k
LmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jCj4gQEAgLTEyOTAsNyArMTI5
MCwxMSBAQCBpbnQgY21kX2Rpc2FibGVfZXZlbnQoc3RydWN0IGx0dF9zZXNzaW9uICpzZXNzaW9u
LAo+Cj4gICAgICAgICAgICAgICAgIHN3aXRjaCAoZXZlbnQtPnR5cGUpIHsKPiAgICAgICAgICAg
ICAgICAgY2FzZSBMVFROR19FVkVOVF9BTEw6Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gZXZlbnRfdXN0X2Rpc2FibGVfdHJhY2Vwb2ludCh1c2VzcywgdWNoYW4sIGV2ZW50X25hbWUp
Owo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChzdHJuY21wKGV2ZW50LT5uYW1lLCAiKiIs
IDEpID09IDAgJiYgc3RybGVuKGV2ZW50LT5uYW1lKSA9PSAxKSB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSBldmVudF91c3RfZGlzYWJsZV9hbGxfdHJhY2Vwb2ludHMo
dXNlc3MsIHVjaGFuKTsKPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gZXZlbnRfdXN0X2Rpc2FibGVfdHJhY2Vw
b2ludCh1c2VzcywgdWNoYW4sIGV2ZW50X25hbWUpOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IH0KCk1lcmdlZCB3aXRoIGFkanVzdG1lbnRzIHRvIGZpdCB3aXRoaW4gODAgY29sdW1ucy4KClRo
YW5rcyEKSsOpcsOpbWllCgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgIT0gTFRU
TkdfT0spIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5s
b2NrOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrD
qXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
