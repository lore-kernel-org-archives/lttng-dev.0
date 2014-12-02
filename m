From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [BABELTRACE PATCH 2/2] Fix: sanity check in
	iterator creation
Date: Tue, 2 Dec 2014 11:16:28 -0500
Message-ID: <CA+jJMxs23mKHSBhtWR_OWf+MZXL10_6YLYhfm+_2eb70vHYY9w__40869.3830868744$1417537051$gmane$org@mail.gmail.com>
References: <1416333152-12536-1-git-send-email-jdesfossez@efficios.com>
 <1416333152-12536-2-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xvq7t-0003Ys-Ql
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 11:16:39 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so9593537qgd.15
 for <lttng-dev@lists.lttng.org>; Tue, 02 Dec 2014 08:16:28 -0800 (PST)
In-Reply-To: <1416333152-12536-2-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTEuMi4KClRoYW5r
cyEKSsOpcsOpbWllCgpPbiBUdWUsIE5vdiAxOCwgMjAxNCBhdCAxMjo1MiBQTSwgSnVsaWVuIERl
c2Zvc3Nlego8amRlc2Zvc3NlekBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFRoaXMgZnVuY3Rpb24g
aXMgcGFydCBvZiB0aGUgQVBJLCBzbyB3ZSBuZWVkIG1vcmUgc2FuaXR5IGNoZWNrcyBiZWZvcmUK
PiB1c2luZyB0aGUgc3RydWN0dXJlcyBwcm92aWRlZCBieSB0aGUgY2FsbGVyLgo+Cj4gUmVmczog
IzgyNwo+Cj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIERlc2Zvc3NleiA8amRlc2Zvc3NlekBlZmZp
Y2lvcy5jb20+Cj4gLS0tCj4gIGxpYi9pdGVyYXRvci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9saWIvaXRl
cmF0b3IuYyBiL2xpYi9pdGVyYXRvci5jCj4gaW5kZXggZDI0NjRhYi4uNTQwZDVlOSAxMDA2NDQK
PiAtLS0gYS9saWIvaXRlcmF0b3IuYwo+ICsrKyBiL2xpYi9pdGVyYXRvci5jCj4gQEAgLTcyMCw3
ICs3MjAsNyBAQCBpbnQgYnRfaXRlcl9pbml0KHN0cnVjdCBidF9pdGVyICppdGVyLAo+ICAgICAg
ICAgaW50IGk7Cj4gICAgICAgICBpbnQgcmV0ID0gMDsKPgo+IC0gICAgICAgaWYgKCFpdGVyIHx8
ICFjdHgpCj4gKyAgICAgICBpZiAoIWl0ZXIgfHwgIWN0eCB8fCAhY3R4LT50YyB8fCAhY3R4LT50
Yy0+YXJyYXkpCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Cj4gICAgICAgICBp
ZiAoY3R4LT5jdXJyZW50X2l0ZXJhdG9yKSB7Cj4gLS0KPiAxLjkuMQo+CgoKCi0tIApKw6lyw6lt
aWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
