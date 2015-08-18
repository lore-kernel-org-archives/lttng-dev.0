From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix: 32bit values index_major/minor used as
	64bit
Date: Tue, 18 Aug 2015 17:36:15 -0400
Message-ID: <CA+jJMxt3EVUU5fKZKfZGFk1dACwiFfw8w+KX01STa5ta_VXvWQ__24672.7600497708$1439933839$gmane$org@mail.gmail.com>
References: <1439926781-19841-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZRoYO-0000vd-PD
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 17:36:22 -0400
Received: by ykfw73 with SMTP id w73so119117306ykf.3
 for <lttng-dev@lists.lttng.org>; Tue, 18 Aug 2015 14:36:15 -0700 (PDT)
In-Reply-To: <1439926781-19841-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIGJvdGggbWFzdGVyIGFuZCBzdGFibGUtMS4yLgoKVGhhbmtzIQpKw6lyw6ltaWUK
Ck9uIFR1ZSwgQXVnIDE4LCAyMDE1IGF0IDM6MzkgUE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5z
b25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBUaGlzIHBhdGNoIGZpeGVzIGNvbXBpbGVyIHdhcm5p
bmdzIG9uIGJpZyBlbmRpYW4gYXJjaGl0ZWN0dXJlcyB3aGVyZQo+IGJlNjR0b2goKSBpcyBhIG5v
cCBhbmQgcmV0dXJucyB0aGUgb3JpZ2luYWwgdHlwZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBmb3JtYXRzL2N0Zi9j
dGYuYyB8IDggKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9jdGYuYyBiL2Zvcm1hdHMv
Y3RmL2N0Zi5jCj4gaW5kZXggNTQzNmMyYS4uNzRmY2I1YiAxMDA2NDQKPiAtLS0gYS9mb3JtYXRz
L2N0Zi9jdGYuYwo+ICsrKyBiL2Zvcm1hdHMvY3RmL2N0Zi5jCj4gQEAgLTE4NTMsMTAgKzE4NTMs
MTAgQEAgaW50IGltcG9ydF9zdHJlYW1fcGFja2V0X2luZGV4KHN0cnVjdCBjdGZfdHJhY2UgKnRk
LAo+ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOwo+ICAgICAgICAgfQo+ICAgICAgICAgaWYg
KGJlMzJ0b2goaW5kZXhfaGRyLmluZGV4X21ham9yKSAhPSBDVEZfSU5ERVhfTUFKT1IpIHsKPiAt
ICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJbZXJyb3JdIEluY29tcGF0aWJsZSBpbmRl
eCBmaWxlICUiIFBSSXU2NAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIi4lIiBQ
Ukl1NjQgIiwgc3VwcG9ydGVkICVkLiVkXG4iLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYmU2NHRvaChpbmRleF9oZHIuaW5kZXhfbWFqb3IpLAo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYmU2NHRvaChpbmRleF9oZHIuaW5kZXhfbWlub3IpLCBDVEZfSU5ERVhf
TUFKT1IsCj4gKyAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiW2Vycm9yXSBJbmNvbXBh
dGlibGUgaW5kZXggZmlsZSAlIiBQUkl1MzIKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICIuJSIgUFJJdTMyICIsIHN1cHBvcnRlZCAlZC4lZFxuIiwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJlMzJ0b2goaW5kZXhfaGRyLmluZGV4X21ham9yKSwKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJlMzJ0b2goaW5kZXhfaGRyLmluZGV4X21pbm9yKSwg
Q1RGX0lOREVYX01BSk9SLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1RGX0lO
REVYX01JTk9SKTsKPiAgICAgICAgICAgICAgICAgcmV0ID0gLTE7Cj4gICAgICAgICAgICAgICAg
IGdvdG8gZXJyb3I7Cj4gLS0KPiAxLjkuMQo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVm
ZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
