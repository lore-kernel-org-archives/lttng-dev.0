From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: relayd viewer stream:
 unhandled out of memory error
Date: Thu, 27 Nov 2014 17:31:45 -0500
Message-ID: <CA+jJMxvuRZfkrN+mPikh3bxkY5LLugRzVt6rJQceb7FFPmR1=Q__30504.9359835268$1417127543$gmane$org@mail.gmail.com>
References: <1416592148-12723-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7bL-0002lc-BR
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:31:53 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so4053140qcx.26
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:31:46 -0800 (PST)
In-Reply-To: <1416592148-12723-1-git-send-email-mathieu.desnoyers@efficios.com>
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

TWVyZ2VkIGFsbCB0aGUgd2F5IHRvIDIuNCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBGcmksIE5v
diAyMSwgMjAxNCBhdCAxMjo0OSBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3ll
cnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jpbi9sdHRu
Zy1yZWxheWQvdmlld2VyLXN0cmVhbS5jIHwgOCArKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1yZWxheWQvdmll
d2VyLXN0cmVhbS5jIGIvc3JjL2Jpbi9sdHRuZy1yZWxheWQvdmlld2VyLXN0cmVhbS5jCj4gaW5k
ZXggMmY1ZDZmNy4uMzc0ODYyOSAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXJlbGF5ZC92
aWV3ZXItc3RyZWFtLmMKPiArKysgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC92aWV3ZXItc3RyZWFt
LmMKPiBAQCAtNTgsOCArNTgsMTYgQEAgc3RydWN0IHJlbGF5X3ZpZXdlcl9zdHJlYW0gKnZpZXdl
cl9zdHJlYW1fY3JlYXRlKHN0cnVjdCByZWxheV9zdHJlYW0gKnN0cmVhbSwKPiAgICAgICAgIHZz
dHJlYW0tPnNlc3Npb25faWQgPSBzdHJlYW0tPnNlc3Npb25faWQ7Cj4gICAgICAgICB2c3RyZWFt
LT5zdHJlYW1faGFuZGxlID0gc3RyZWFtLT5zdHJlYW1faGFuZGxlOwo+ICAgICAgICAgdnN0cmVh
bS0+cGF0aF9uYW1lID0gc3RybmR1cChzdHJlYW0tPnBhdGhfbmFtZSwgTFRUTkdfVklFV0VSX1BB
VEhfTUFYKTsKPiArICAgICAgIGlmICh2c3RyZWFtLT5wYXRoX25hbWUgPT0gTlVMTCkgewo+ICsg
ICAgICAgICAgICAgICBQRVJST1IoInJlbGF5IHZpZXdlciBwYXRoX25hbWUgYWxsb2MiKTsKPiAr
ICAgICAgICAgICAgICAgZ290byBlcnJvcjsKPiArICAgICAgIH0KPiAgICAgICAgIHZzdHJlYW0t
PmNoYW5uZWxfbmFtZSA9IHN0cm5kdXAoc3RyZWFtLT5jaGFubmVsX25hbWUsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgTFRUTkdfVklFV0VSX05BTUVfTUFYKTsKPiArICAgICAgIGlmICh2c3Ry
ZWFtLT5jaGFubmVsX25hbWUgPT0gTlVMTCkgewo+ICsgICAgICAgICAgICAgICBQRVJST1IoInJl
bGF5IHZpZXdlciBjaGFubmVsX25hbWUgYWxsb2MiKTsKPiArICAgICAgICAgICAgICAgZ290byBl
cnJvcjsKPiArICAgICAgIH0KPiAgICAgICAgIHZzdHJlYW0tPnRyYWNlZmlsZV9jb3VudCA9IHN0
cmVhbS0+dHJhY2VmaWxlX2NvdW50Owo+ICAgICAgICAgdnN0cmVhbS0+bWV0YWRhdGFfZmxhZyA9
IHN0cmVhbS0+bWV0YWRhdGFfZmxhZzsKPiAgICAgICAgIHZzdHJlYW0tPnRyYWNlZmlsZV9jb3Vu
dF9sYXN0ID0gLTFVTEw7Cj4gLS0KPiAyLjEuMQo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
