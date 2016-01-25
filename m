From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test: append to
	LD_LIBRARY_PATH
Date: Mon, 25 Jan 2016 16:11:55 -0500
Message-ID: <CA+jJMxs+c+2Bnj811r_2ku+LfdyrF5qeYB2Nj6ogefUtM=7gHQ__42642.4984857023$1453756372$gmane$org@mail.gmail.com>
References: <1452802102-2706-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f194.google.com ([209.85.223.194])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aNoQb-0004Ag-1N
 for lttng-dev@lists.lttng.org; Mon, 25 Jan 2016 16:12:03 -0500
Received: by mail-io0-f194.google.com with SMTP id q21so14347068iod.3
 for <lttng-dev@lists.lttng.org>; Mon, 25 Jan 2016 13:12:01 -0800 (PST)
In-Reply-To: <1452802102-2706-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgSmFuIDE0LCAyMDE2IGF0IDM6MDgg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gVGhlIG92ZXJ3cml0aW5nIG9mIExEX0xJQlJBUllfUEFUSCBjYW4gY2F1c2Ug
ZmFpbHVyZSBvZiB0ZXN0cyB3aGVuIGx0dG5nLXVzdCBpcwo+IG5vdCBpbnN0YWxsZWQgaW4gdGhl
IGRlZmF1bHQgcGF0aCBhbmQgbG9jYXRpb24gaXMgcGFzc2VkIHZpYSBMRF9MSUJSQVJZX1BBVEgu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1
bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHRlc3RzL3JlZ3Jlc3Npb24vdXN0L3VzdC1kbC90
ZXN0X3VzdC1kbC5weSB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L3Vz
dC1kbC90ZXN0X3VzdC1kbC5weSBiL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L3VzdC1kbC90ZXN0X3Vz
dC1kbC5weQo+IGluZGV4IGRjNzMyNzAuLjcxMTdjYTEgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvcmVn
cmVzc2lvbi91c3QvdXN0LWRsL3Rlc3RfdXN0LWRsLnB5Cj4gKysrIGIvdGVzdHMvcmVncmVzc2lv
bi91c3QvdXN0LWRsL3Rlc3RfdXN0LWRsLnB5Cj4gQEAgLTQ2LDggKzQ2LDggQEAgZW5hYmxlX3Vz
dF90cmFjZXBvaW50X2V2ZW50KHNlc3Npb25faW5mbywgIioiKQo+ICBzdGFydF9zZXNzaW9uKHNl
c3Npb25faW5mbykKPgo+ICB0ZXN0X2VudiA9IG9zLmVudmlyb24uY29weSgpCj4gLXRlc3RfZW52
WyJMRF9QUkVMT0FEIl0gPSAibGlibHR0bmctdXN0LWRsLnNvIgo+IC10ZXN0X2VudlsiTERfTElC
UkFSWV9QQVRIIl0gPSB0ZXN0X3BhdGgKPiArdGVzdF9lbnZbIkxEX1BSRUxPQUQiXSArPSAiOmxp
Ymx0dG5nLXVzdC1kbC5zbyIKPiArdGVzdF9lbnZbIkxEX0xJQlJBUllfUEFUSCJdICs9ICI6IiAr
IHRlc3RfcGF0aAo+ICB0ZXN0X3Byb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHRlc3RfcGF0aCAr
ICJwcm9nIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGRvdXQ9c3VicHJv
Y2Vzcy5QSVBFLCBzdGRlcnI9c3VicHJvY2Vzcy5QSVBFLAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVudj10ZXN0X2VudikKPiAtLQo+IDIuNS4wCj4KCgoKLS0gCkrDqXLDqW1p
ZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
