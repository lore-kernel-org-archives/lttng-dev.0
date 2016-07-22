From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: the clock plugin must
	be	initiated before first use of the clock
Date: Fri, 22 Jul 2016 14:40:10 +0000 (UTC)
Message-ID: <789075972.78339.1469198410297.JavaMail.zimbra__29765.5479786501$1469198442$gmane$org@efficios.com>
References: <20160722135659.28595-1-wallinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 52172A3BE5
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2016 14:40:12 +0000 (UTC)
In-Reply-To: <20160722135659.28595-1-wallinux@gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbHR0bmctbW9kdWxlcyBtYXN0ZXIgYW5kIHN0YWJsZS0yLjgsIHRoYW5rcyEK
Ck1hdGhpZXUKCi0tLS0tIE9uIEp1bCAyMiwgMjAxNiwgYXQgOTo1NiBBTSwgQW5kZXJzIFdhbGxp
biB3YWxsaW51eEBnbWFpbC5jb20gd3JvdGU6Cgo+IFdoZW4gYnVpbGRpbmcgbHR0bmcgaW5zaWRl
IHRoZSBrZXJuZWwgdGhlIGNsb2NrIHBsdWdpbiBtdXN0IGJlIGluaXRhdGVkCj4gYmVmb3JlIHRo
ZSByZXN0IG9mIHRoZSBsdHRuZyBjb2RlLiBNb3ZlZCB0aGUgbW9kdWxlX2luaXQgdG8KPiByb290
ZnNfaW5pdGNhbGwuIFRoZSBmdW5jdGlvbmFsaXR5IHdpbGwgbm90IGNoYW5nZSB3aGVuIGJ1aWx0
IGFzIGEKPiBtb2R1bGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kZXJzIFdhbGxpbiA8d2FsbGlu
dXhAZ21haWwuY29tPgo+IC0tLQo+IHRlc3RzL2Nsb2NrLXBsdWdpbi9sdHRuZy1jbG9jay1wbHVn
aW4tdGVzdC5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9jbG9jay1wbHVnaW4vbHR0bmctY2xvY2st
cGx1Z2luLXRlc3QuYwo+IGIvdGVzdHMvY2xvY2stcGx1Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10
ZXN0LmMKPiBpbmRleCBmMTZlYTY0Li5iZjgxOTMyIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL2Nsb2Nr
LXBsdWdpbi9sdHRuZy1jbG9jay1wbHVnaW4tdGVzdC5jCj4gKysrIGIvdGVzdHMvY2xvY2stcGx1
Z2luL2x0dG5nLWNsb2NrLXBsdWdpbi10ZXN0LmMKPiBAQCAtNjcsNyArNjcsNyBAQCBpbnQgbHR0
bmdfY2xvY2tfcGx1Z2luX2luaXQodm9pZCkKPiB7Cj4gCXJldHVybiBsdHRuZ19jbG9ja19yZWdp
c3Rlcl9wbHVnaW4oJmx0YywgVEhJU19NT0RVTEUpOwo+IH0KPiAtbW9kdWxlX2luaXQobHR0bmdf
Y2xvY2tfcGx1Z2luX2luaXQpOwo+ICtyb290ZnNfaW5pdGNhbGwobHR0bmdfY2xvY2tfcGx1Z2lu
X2luaXQpOwo+IAo+IHN0YXRpYyBfX2V4aXQKPiB2b2lkIGx0dG5nX2Nsb2NrX3BsdWdpbl9leGl0
KHZvaWQpCj4gLS0KPiAyLjkuMgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0
cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRw
Oi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
