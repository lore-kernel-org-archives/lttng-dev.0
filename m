From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools stable-2.6 1/3] Tests: Introduce
	conf_proc_count()
Date: Tue, 15 Mar 2016 16:48:45 -0400
Message-ID: <CA+jJMxtbBBc0Ev0QwRVaVaU8z1b2z-KrixYO9_2pHMdgk5Bg1w__14363.1135616035$1458074956$gmane$org@mail.gmail.com>
References: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D038DA09AF
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 20:48:46 +0000 (UTC)
Received: by mail-io0-f173.google.com with SMTP id n190so39564168iof.0
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 13:48:46 -0700 (PDT)
In-Reply-To: <1458072806-19932-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

QWxsIHRocmVlIGZpeGVzIGhhdmUgYmVlbiBtZXJnZWQgdG8gc3RhYmxlLTIuNiwgdGhhbmtzIQoK
T24gVHVlLCBNYXIgMTUsIDIwMTYgYXQgNDoxMyBQTSwgTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IEZyb206IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVt
aWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KPgo+IFRlc3RzIGFyZSB1c2luZyB0aGUgbnByb2Mg
dXRpbGl0eSB3aGljaCByZXR1cm4gdGhlIG51bWJlciBvZgo+IF9hdmFpbGFibGVfIENQVXMuIFRo
ZSBkaXN0aW5jdGlvbiBiZXR3ZWVuIG9ubGluZSwgYXZhaWxhYmxlIGFuZAo+IGNvbmZpZ3VyZWQg
Q1BVcyBpcyBzdWJ0bGUsIGJ1dCBpbXBvcnRhbnQuCj4KPiBUaGUgbnVtYmVyIG9mICJvbmxpbmUi
IENQVXMgY2FuIGNoYW5nZSBhdCBydW50aW1lIGFzIENQVXMgYXJlCj4gaG90LXBsdWdnZWQuIFRo
aXMgY291bGQgaGFwcGVuIGR1cmluZyBhIHRlc3QgYW5kIHJlc3VsdCBpbgo+IHVuZXhwZWN0ZWQg
cmVzdWx0cy4KPgo+IFRoZSBudW1iZXIgb2YgImNvbmZpZ3VyZWQiIENQVXMgaW5jbHVkZXMgYW55
IENQVSB3aGljaCBtYXkgYmUKPiBvZmZsaW5lIGF0IHRoZSB0aW1lLgo+Cj4gVGhlIG51bWJlciBv
ZiAiYXZhaWxhYmxlIiBDUFVzLCB3aGljaCBpcyB3aGF0IGlzIHJldHVybmVkIGJ5IHRoZQo+IG5w
cm9jIHV0aWxpdHksIG1heSBkaWZmZXIgZnJvbSBib3RoICJvbmxpbmUiIGFuZCAiY29uZmlndXJl
ZCIKPiBjb3VudHMuIFRoaXMgaXMgdGhlIGNhc2UgaW4gY29udGFpbmVycyB3aGljaCBhcmUgYXNz
aWduZWQgdG8gYQo+IHN1YnNldCBvZiBjb25maWd1cmVkIENQVXMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4g
LS0tCj4gIHRlc3RzL3V0aWxzL3V0aWxzLnNoIHwgMTAgKysrKysrKysrKwo+ICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3V0aWxzL3V0aWxz
LnNoIGIvdGVzdHMvdXRpbHMvdXRpbHMuc2gKPiBpbmRleCA5ZTc4ZGMyLi4xZjExNmE2IDEwMDY0
NAo+IC0tLSBhL3Rlc3RzL3V0aWxzL3V0aWxzLnNoCj4gKysrIGIvdGVzdHMvdXRpbHMvdXRpbHMu
c2gKPiBAQCAtOTIsNiArOTIsMTYgQEAgZnVuY3Rpb24gcmFuZHN0cmluZygpCj4gICAgICAgICBl
Y2hvCj4gIH0KPgo+ICsjIFJldHVybiB0aGUgbnVtYmVyIG9mIF9jb25maWd1cmVkXyBDUFVzLgo+
ICtmdW5jdGlvbiBjb25mX3Byb2NfY291bnQoKQo+ICt7Cj4gKyAgICAgICBnZXRjb25mIF9OUFJP
Q0VTU09SU19DT05GCj4gKyAgICAgICBpZiBbICQ/IC1uZSAwIF07IHRoZW4KPiArICAgICAgICAg
ICAgICAgZGlhZyAiRmFpbGVkIHRvIGdldCB0aGUgbnVtYmVyIG9mIGNvbmZpZ3VyZWQgQ1BVcyIK
PiArICAgICAgIGZpCj4gKyAgICAgICBlY2hvCj4gK30KPiArCj4gIGZ1bmN0aW9uIGx0dG5nX2Vu
YWJsZV9rZXJuZWxfZXZlbnQKPiAgewo+ICAgICAgICAgbG9jYWwgc2Vzc19uYW1lPSQxCj4gLS0K
PiAyLjcuMAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
