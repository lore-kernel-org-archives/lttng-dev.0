From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Live tracing does not
 honor live timer after first tracefile with tracefile rotation
Date: Thu, 27 Nov 2014 17:29:39 -0500
Message-ID: <CA+jJMxtNZZpWpQbw1RywC=BvsJSXpt_0zcvo2ycbb+NOgMUtww__17979.3558469557$1417127424$gmane$org@mail.gmail.com>
References: <1416591099-1920-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xu7ZJ-0002g6-6p
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 17:29:47 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so4177687qcv.29
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 14:29:39 -0800 (PST)
In-Reply-To: <1416591099-1920-1-git-send-email-mathieu.desnoyers@efficios.com>
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
diAyMSwgMjAxNCBhdCAxMjozMSBQTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gV2hlbiB3ZSBwYXNzIHRvIHRoZSAybmQgc3ViLWZp
bGUgKG9yIGZvbGxvd2luZyBzdWItZmlsZXMpIG9mIGEgc3RyZWFtIGluCj4gcmVsYXlkLCB0aGUg
bGl2ZSB0aW1lciBoYXMgbm8gdmlzaWJsZSBlZmZlY3QgZnJvbSBhIGxpdmUgcmVhZGVyCj4gcGVy
c3BlY3RpdmUsIGFuZCB0aGVuIGV2ZXJ5dGhpbmcgaXMgZmx1c2hlZCB3aGVuIHdlIHJlYWNoIHRo
ZSBmb2xsb3dpbmcKPiBzdWItZmlsZS4KPgo+IFRoaXMgaXMgY2F1c2VkIGJ5IHRoZSByZXNldCBv
ZiBzdHJlYW0tPnRvdGFsX2luZGV4X3JlY2VpdmVkIGFmdGVyIGVhY2gKPiB0cmFjZWZpbGUgcm90
YXRpb24uIEl0IHNob3VsZCBrZWVwIG9uIGluY3JlbWVudGluZyB0byBtYXRjaCB3aGF0IGlzCj4g
ZXhwZWN0ZWQgYnkgY2hlY2sgaW4gY2hlY2tfaW5kZXhfc3RhdHVzKCk6Cj4KPiAgIChyc3RyZWFt
LT50b3RhbF9pbmRleF9yZWNlaXZlZCA8PSB2c3RyZWFtLT5sYXN0X3NlbnRfaW5kZXgpCj4KPiBG
aXhlcyAjODYzCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5k
ZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWlu
LmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9zcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWluLmMgYi9zcmMvYmluL2x0dG5nLXJlbGF5ZC9tYWlu
LmMKPiBpbmRleCAwMGI4NzM1Li4wM2VhMTA4IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmct
cmVsYXlkL21haW4uYwo+ICsrKyBiL3NyYy9iaW4vbHR0bmctcmVsYXlkL21haW4uYwo+IEBAIC0y
MzMzLDcgKzIzMzMsNiBAQCBpbnQgcmVsYXlfcHJvY2Vzc19kYXRhKHN0cnVjdCByZWxheV9jb25u
ZWN0aW9uICpjb25uKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyZWFtLT50
cmFjZWZpbGVfc2l6ZSwgc3RyZWFtLT50cmFjZWZpbGVfY291bnQsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZWxheWRfdWlkLCByZWxheWRfZ2lkLCBzdHJlYW0tPmZkLAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJihzdHJlYW0tPnRyYWNlZmlsZV9jb3VudF9j
dXJyZW50KSwgJnN0cmVhbS0+ZmQpOwo+IC0gICAgICAgICAgICAgICBzdHJlYW0tPnRvdGFsX2lu
ZGV4X3JlY2VpdmVkID0gMDsKPiAgICAgICAgICAgICAgICAgcHRocmVhZF9tdXRleF91bmxvY2so
JnN0cmVhbS0+dmlld2VyX3N0cmVhbV9yb3RhdGlvbl9sb2NrKTsKPiAgICAgICAgICAgICAgICAg
aWYgKHJldCA8IDApIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBFUlIoIlJvdGF0aW5nIHN0
cmVhbSBvdXRwdXQgZmlsZSIpOwo+IC0tCj4gMi4xLjEKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFy
bmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
