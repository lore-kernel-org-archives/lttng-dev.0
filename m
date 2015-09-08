From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: unbalanced RCU
 read-side lock in enable event command
Date: Tue, 8 Sep 2015 08:25:12 -0400
Message-ID: <CA+jJMxtsHZWVz=aCXt4SYgvgQGdQS5GaLvL_gsjG+5iEVtv_fw__21410.2436825216$1441715179$gmane$org@mail.gmail.com>
References: <1441636569-3488-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1441636569-3488-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZZHxe-0006Zo-65
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 08:25:19 -0400
Received: by ykdu9 with SMTP id u9so39596506ykd.2
 for <lttng-dev@lists.lttng.org>; Tue, 08 Sep 2015 05:25:12 -0700 (PDT)
In-Reply-To: <1441636569-3488-2-git-send-email-mathieu.desnoyers@efficios.com>
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

R29vZCBjYXRjaCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBNb24sIFNlcCA3LCAyMDE1IGF0IDEw
OjM2IEFNLCBNYXRoaWV1IERlc25veWVycwo8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
PiB3cm90ZToKPiBUaGUgZXZlbnQgdmFsaWRhdGlvbiBmYWlscywgYW4gdW5wYWlyZWQgUkNVIHVu
bG9jayBpcyBwZXJmb3JtZWQsIHRodXMKPiB1bmRlcmZsb3dpbmcgdGhlIFJDVSBuZXN0aW5nIGNv
dW50ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5j
IHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQuYyBiL3NyYy9i
aW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKPiBpbmRleCA2MjM3ZDY3Li5hYzViOGVjIDEwMDY0NAo+
IC0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKPiArKysgYi9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NtZC5jCj4gQEAgLTE1MzUsMTMgKzE1MzUsMTMgQEAgc3RhdGljIGludCBfY21k
X2VuYWJsZV9ldmVudChzdHJ1Y3QgbHR0X3Nlc3Npb24gKnNlc3Npb24sCj4KPiAgICAgICAgIERC
RygiRW5hYmxlIGV2ZW50IGNvbW1hbmQgZm9yIGV2ZW50IFwnJXNcJyIsIGV2ZW50LT5uYW1lKTsK
Pgo+ICsgICAgICAgcmN1X3JlYWRfbG9jaygpOwo+ICsKPiAgICAgICAgIHJldCA9IHZhbGlkYXRl
X2V2ZW50X25hbWUoZXZlbnQtPm5hbWUpOwo+ICAgICAgICAgaWYgKHJldCkgewo+ICAgICAgICAg
ICAgICAgICBnb3RvIGVycm9yOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICByY3VfcmVhZF9sb2Nr
KCk7Cj4gLQo+ICAgICAgICAgc3dpdGNoIChkb21haW4tPnR5cGUpIHsKPiAgICAgICAgIGNhc2Ug
TFRUTkdfRE9NQUlOX0tFUk5FTDoKPiAgICAgICAgIHsKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrD
qXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
