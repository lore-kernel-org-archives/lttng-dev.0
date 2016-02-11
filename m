From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: check for socket lib before
	function checks
Date: Thu, 11 Feb 2016 14:17:06 -0500
Message-ID: <CA+jJMxsgQP1549v9=HdCoYSks7utVmUvNJVE8+aDQeLEt4wAxQ__11639.0236690224$1455218295$gmane$org@mail.gmail.com>
References: <1444941539-15017-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f196.google.com ([209.85.223.196])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aTwjn-0001zS-LL
 for lttng-dev@lists.lttng.org; Thu, 11 Feb 2016 14:17:13 -0500
Received: by mail-io0-f196.google.com with SMTP id z135so5176297iof.2
 for <lttng-dev@lists.lttng.org>; Thu, 11 Feb 2016 11:17:11 -0800 (PST)
In-Reply-To: <1444941539-15017-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgT2N0IDE1LCAyMDE1IGF0IDQ6Mzgg
UE0sIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBPbiBw
bGF0Zm9ybXMgdGhhdCByZXF1aXJlIGV4dHJhIGxpYnJhcmllcyB0byBsaW5rIHNvY2tldCBhcHBz
LAo+IHJ1bm5pbmcgdGhpcyBtYWNybyBiZWZvcmUgdGhlIGZ1bmN0aW9uIGNoZWNrcyB3aWxsIGxl
YWQgdG8KPiBzb2NrZXQgZnVuY3Rpb25zIGJlaW5nIGNvcnJlY3RseSBkZXRlY3RlZC4KPgo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+IC0t
LQo+ICBjb25maWd1cmUuYWMgfCA3ICsrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9j
b25maWd1cmUuYWMKPiBpbmRleCAzMWJjNzZhLi41NWEzNTdiIDEwMDY0NAo+IC0tLSBhL2NvbmZp
Z3VyZS5hYwo+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC04MSw5ICs4MSwxMSBAQCBpZiB0ZXN0
ICEgLWYgIiRzcmNkaXIvZm9ybWF0cy9jdGYvbWV0YWRhdGEvY3RmLWxleGVyLmMiOyB0aGVuCj4g
ICAgICAgICAgXSkKPiAgZmkKPgo+IC0KPiAgQU1fUEFUSF9HTElCXzJfMCgyLjIyLjAsICxBQ19N
U0dfRVJST1IoW2dsaWIgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gY29tcGlsZSBCYWJlbFRyYWNl
IC0gZG93bmxvYWQgaXQgZnJvbSBmdHA6Ly9mdHAuZ3RrLm9yZy9wdWIvZ3RrXSkgLCBnbW9kdWxl
KQo+Cj4gKyMgQ2hlY2sgd2hhdCBsaWJyYXJpZXMgYXJlIHJlcXVpcmVkIG9uIHRoaXMgcGxhdGZv
cm0gdG8gbGluayBzb2NrZXRzIHByb2dyYW1zLgo+ICtBWF9MSUJfU09DS0VUX05TTAo+ICsKPiAg
IyBDaGVja3MgZm9yIHR5cGVkZWZzLCBzdHJ1Y3R1cmVzLCBhbmQgY29tcGlsZXIgY2hhcmFjdGVy
aXN0aWNzLgo+ICBBQ19DX0lOTElORQo+ICBBQ19UWVBFX1BJRF9UCj4gQEAgLTE0NSw5ICsxNDcs
NiBAQCBlc2FjCj4KPiAgQU1fQ09ORElUSU9OQUwoW0JBQkVMVFJBQ0VfQlVJTERfV0lUSF9NSU5H
V10sIFt0ZXN0ICJ4JE1JTkdXMzIiID0gInh5ZXMiXSkKPgo+IC0jIENoZWNrIHdoYXQgbGlicmFy
aWVzIGFyZSByZXF1aXJlZCBvbiB0aGlzIHBsYXRmb3JtIHRvIGxpbmsgc29ja2V0cyBwcm9ncmFt
cy4KPiAtQVhfTElCX1NPQ0tFVF9OU0wKPiAtCj4gICMgQ2hlY2sgZm9yIGxpYnV1aWQKPiAgQUNf
Q0hFQ0tfTElCKFt1dWlkXSwgW3V1aWRfZ2VuZXJhdGVdLAo+ICBbCj4gLS0KPiAxLjkuMQo+CgoK
Ci0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lv
cy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
