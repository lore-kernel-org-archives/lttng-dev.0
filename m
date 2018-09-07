From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: added test_autoload to
 noinst_SCRIPTS
Date: Fri, 7 Sep 2018 11:29:19 -0400
Message-ID: <20180907152917.GA27203__36115.186502184$1536334049$gmane$org@gmail.com>
References: <20180726074628.4405-1-wallinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by lists.lttng.org (Postfix) with ESMTPS id 426Lvl4ZJGztr0
 for <lttng-dev@lists.lttng.org>; Fri,  7 Sep 2018 11:29:23 -0400 (EDT)
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so16604770qtc.8
 for <lttng-dev@lists.lttng.org>; Fri, 07 Sep 2018 08:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180726074628.4405-1-wallinux@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Wallin <wallinux@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuMTEsIHN0YWJsZS0yLjEwIGFuZCBzdGFibGUtMi45
LgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIFRodSwgSnVsIDI2LCAyMDE4IGF0IDA5OjQ2OjI4QU0g
KzAyMDAsIEFuZGVycyBXYWxsaW4gd3JvdGU6Cj4gRnJvbTogQW5kZXJzIFdhbGxpbiA8YW5kZXJz
LndhbGxpbkB3aW5kcml2ZXIuY29tPgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBXYWxsaW4g
PHdhbGxpbnV4QGdtYWlsLmNvbT4KPiAtLS0KPiAgdGVzdHMvcmVncmVzc2lvbi90b29scy9zYXZl
LWxvYWQvTWFrZWZpbGUuYW0gfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9yZWdyZXNzaW9uL3Rvb2xz
L3NhdmUtbG9hZC9NYWtlZmlsZS5hbSBiL3Rlc3RzL3JlZ3Jlc3Npb24vdG9vbHMvc2F2ZS1sb2Fk
L01ha2VmaWxlLmFtCj4gaW5kZXggNWNkNjc3NjIuLmExMDgwMDJkIDEwMDY0NAo+IC0tLSBhL3Rl
c3RzL3JlZ3Jlc3Npb24vdG9vbHMvc2F2ZS1sb2FkL01ha2VmaWxlLmFtCj4gKysrIGIvdGVzdHMv
cmVncmVzc2lvbi90b29scy9zYXZlLWxvYWQvTWFrZWZpbGUuYW0KPiBAQCAtMSw0ICsxLDQgQEAK
PiAtbm9pbnN0X1NDUklQVFMgPSB0ZXN0X3NhdmUgdGVzdF9sb2FkCj4gK25vaW5zdF9TQ1JJUFRT
ID0gdGVzdF9zYXZlIHRlc3RfbG9hZCB0ZXN0X2F1dG9sb2FkCj4gIEVYVFJBX0RJU1QgPSAkKG5v
aW5zdF9TQ1JJUFRTKSBsb2FkLTQyLmx0dG5nIGxvYWQtNDItY29tcGxleC5sdHRuZyBcCj4gIAls
b2FkLTQyLXRyYWNrZXJzLmx0dG5nCj4gIAo+IC0tIAo+IDIuMTguMAo+IAo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcg
bGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
