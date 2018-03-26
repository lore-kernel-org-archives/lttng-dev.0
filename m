From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: double similar condition
Date: Mon, 26 Mar 2018 16:27:11 -0400
Message-ID: <20180326202710.GA23189__30214.8025636145$1522095921$gmane$org@gmail.com>
References: <1521063305-14511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 4095Kb10Qwzy8n
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 16:27:14 -0400 (EDT)
Received: by mail-qk0-x242.google.com with SMTP id s9so21571542qke.12
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 13:27:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1521063305-14511-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

R29vZCBjYXRjaCEgTWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAuCgpUaGFua3MhCkrD
qXLDqW1pZQoKT24gV2VkLCBNYXIgMTQsIDIwMTggYXQgMDU6MzU6MDVQTSAtMDQwMCwgSm9uYXRo
YW4gUmFqb3R0ZSB3cm90ZToKPiBCYXNlZCBvbiB0aGUgcGF0dGVybiBvZiB0aGUgZnVuY3Rpb24s
IHRocmVzaG9sZF9ieXRlcyBzaG91bGQgYmUgdXNlZAo+IGluc2lkZSB0aGUgImVsc2UgaWYiIGNv
bmRpdGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5y
YWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIHNyYy9iaW4vbHR0bmctc2Vzc2lv
bmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYyBiL3NyYy9iaW4vbHR0
bmctc2Vzc2lvbmQvbm90aWZpY2F0aW9uLXRocmVhZC1ldmVudHMuYwo+IGluZGV4IDM5NDYyYjUu
LjZkNWU2MjUgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmljYXRp
b24tdGhyZWFkLWV2ZW50cy5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9ub3RpZmlj
YXRpb24tdGhyZWFkLWV2ZW50cy5jCj4gQEAgLTI5NSw3ICsyOTUsNyBAQCB1bnNpZ25lZCBsb25n
IGx0dG5nX2NvbmRpdGlvbl9idWZmZXJfdXNhZ2VfaGFzaCgKPiAgCj4gIAkJdmFsID0gY29uZGl0
aW9uLT50aHJlc2hvbGRfcmF0aW8udmFsdWUgKiAoZG91YmxlKSBVSU5UMzJfTUFYOwo+ICAJCWhh
c2ggXj0gaGFzaF9rZXlfdTY0KCZ2YWwsIGx0dG5nX2h0X3NlZWQpOwo+IC0JfSBlbHNlIGlmIChj
b25kaXRpb24tPnRocmVzaG9sZF9yYXRpby5zZXQpIHsKPiArCX0gZWxzZSBpZiAoY29uZGl0aW9u
LT50aHJlc2hvbGRfYnl0ZXMuc2V0KSB7Cj4gIAkJdWludDY0X3QgdmFsOwo+ICAKPiAgCQl2YWwg
PSBjb25kaXRpb24tPnRocmVzaG9sZF9ieXRlcy52YWx1ZTsKPiAtLSAKPiAyLjcuNAo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
