From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: leak on error in
	lttng-crash
Date: Fri, 27 Mar 2015 16:20:45 -0400
Message-ID: <CA+jJMxttkdm9bwcCWMirM0YtxpJ+VZ6T+TLtaA5DVdD6sZfEmQ__5160.61488674513$1427487706$gmane$org@mail.gmail.com>
References: <1427485920-31975-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YbakM-0005K8-Jy
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 16:20:51 -0400
Received: by qgh3 with SMTP id 3so128245015qgh.2
 for <lttng-dev@lists.lttng.org>; Fri, 27 Mar 2015 13:20:45 -0700 (PDT)
In-Reply-To: <1427485920-31975-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTWFyIDI3LCAyMDE1IGF0IDM6NTIg
UE0sIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdy
b3RlOgo+IEZvdW5kIGJ5IENvdmVyaXR5Ogo+ICoqIENJRCAxMjkxOTQ1OiAgUmVzb3VyY2UgbGVh
a3MgIChSRVNPVVJDRV9MRUFLKQo+IC9zcmMvYmluL2x0dG5nLWNyYXNoL2x0dG5nLWNyYXNoLmM6
IDc2OSBpbiBjb3B5X2NyYXNoX2RhdGEoKQo+Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNu
b3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9s
dHRuZy1jcmFzaC9sdHRuZy1jcmFzaC5jIHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmct
Y3Jhc2gvbHR0bmctY3Jhc2guYyBiL3NyYy9iaW4vbHR0bmctY3Jhc2gvbHR0bmctY3Jhc2guYwo+
IGluZGV4IDc5Mzg3N2QuLjRmMWVmZTkgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1jcmFz
aC9sdHRuZy1jcmFzaC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1jcmFzaC9sdHRuZy1jcmFzaC5j
Cj4gQEAgLTc2Niw3ICs3NjYsOCBAQCBpbnQgY29weV9jcmFzaF9kYXRhKGNvbnN0IHN0cnVjdCBs
dHRuZ19jcmFzaF9sYXlvdXQgKmxheW91dCwgaW50IGZkX2Rlc3QsCj4gICAgICAgICByZWFkbGVu
ID0gbHR0bmdfcmVhZChmZF9zcmMsIGJ1Ziwgc3JjX2ZpbGVfbGVuKTsKPiAgICAgICAgIGlmIChy
ZWFkbGVuIDwgMCkgewo+ICAgICAgICAgICAgICAgICBQRVJST1IoIkVycm9yIHJlYWRpbmcgaW5w
dXQgZmlsZSIpOwo+IC0gICAgICAgICAgICAgICByZXR1cm4gLTE7Cj4gKyAgICAgICAgICAgICAg
IHJldCA9IC0xOwo+ICsgICAgICAgICAgICAgICBnb3RvIGVuZDsKPiAgICAgICAgIH0KPgo+ICAg
ICAgICAgcHJvZF9vZmZzZXQgPSBjcmFzaF9nZXRfZmllbGQobGF5b3V0LCBidWYsIHByb2Rfb2Zm
c2V0KTsKPiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1Mg
SW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3Rp
bmZvL2x0dG5nLWRldgo=
