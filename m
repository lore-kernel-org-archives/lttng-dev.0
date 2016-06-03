From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH userspace-rcu 1/2] Port: fix
	compatibility	header for Cygwin
Date: Fri, 3 Jun 2016 06:28:41 +0000 (UTC)
Message-ID: <278023320.26578.1464935321566.JavaMail.zimbra__29978.6981115632$1464935352$gmane$org@efficios.com>
References: <574FA191.8030609@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 0AD33A3674
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 06:28:47 +0000 (UTC)
In-Reply-To: <574FA191.8030609@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIG1lcmdlZCBpbnRvIG1hc3RlciBhbmQgc3RhYmxlLTAuOSwgdGhhbmtzIQoK
TWF0aGlldQoKLS0tLS0gT24gSnVuIDIsIDIwMTYsIGF0IDU6MDEgQU0sIFNlYmFzdGllbiBCb2lz
dmVydCBzYm9pc3ZlcnRAZ3lkbGUuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3Rp
ZW4gQm9pc3ZlcnQgPHNib2lzdmVydEBneWRsZS5jb20+Cj4gLS0tCj4gdXJjdS9zeXNjYWxsLWNv
bXBhdC5oIHwgNCArKysrCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS91cmN1L3N5c2NhbGwtY29tcGF0LmggYi91cmN1L3N5c2NhbGwtY29tcGF0LmgK
PiBpbmRleCA5YjlhZmVjLi5kNjAzZGIyIDEwMDY0NAo+IC0tLSBhL3VyY3Uvc3lzY2FsbC1jb21w
YXQuaAo+ICsrKyBiL3VyY3Uvc3lzY2FsbC1jb21wYXQuaAo+IEBAIC0zMSw2ICszMSwxMCBAQAo+
ICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgo+ICNlbGlmIGRlZmluZWQoX19saW51eF9fKSB8fCBk
ZWZpbmVkKF9fR0xJQkNfXykKPiAjaW5jbHVkZSA8c3lzY2FsbC5oPgo+ICsKPiArI2VsaWYgZGVm
aW5lZChfX0NZR1dJTl9fKQo+ICsvKiBEb24ndCBpbmNsdWRlIGFueXRoaW5nIG9uIEN5Z3dpbi4g
Ki8KPiArCj4gI2Vsc2UKPiAjZXJyb3IgIkFkZCBwbGF0Zm9ybSBzdXBwb3J0IHRvIHVyY3Uvc3lz
Y2FsbC1jb21wYXQuaCIKPiAjZW5kaWYKPiAtLQo+IDIuOC4zCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4g
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZp
Y2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
