From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: mark generated python
 bindings files as nodist
Date: Mon, 11 Mar 2013 13:43:20 -0400
Message-ID: <513E17B8.3010400__15330.6809174412$1363023859$gmane$org@efficios.com>
References: <1360979205-20346-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UF6ku-0006x2-9L
	for lttng-dev@lists.lttng.org; Mon, 11 Mar 2013 13:43:24 -0400
In-Reply-To: <1360979205-20346-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?B?SsOpcsOpbWllIEdhbGFybmVhdQ==?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIQoKVGhhbmtzIQoKSsOpcsOpbWllIEdhbGFybmVhdToKPiBtYWtlIGRpc3Qgd291bGQg
ZmFpbCBpZiAuL2NvbmZpZ3VyZSBoYWQgbm90IGJlZW4gaW52b2tlZCB3aXRoCj4gdGhlIC0tZW5h
YmxlLXB5dGhvbi1iaW5kaW5ncyBzd2l0Y2guCj4gCj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbWll
IEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBleHRy
YXMvYmluZGluZ3Mvc3dpZy9weXRob24vTWFrZWZpbGUuYW0gfCA4ICsrKy0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2V4dHJhcy9iaW5kaW5ncy9zd2lnL3B5dGhvbi9NYWtlZmlsZS5hbSBiL2V4dHJhcy9iaW5k
aW5ncy9zd2lnL3B5dGhvbi9NYWtlZmlsZS5hbQo+IGluZGV4IGM2YTY5MDEuLjZlN2JhYTYgMTAw
NjQ0Cj4gLS0tIGEvZXh0cmFzL2JpbmRpbmdzL3N3aWcvcHl0aG9uL01ha2VmaWxlLmFtCj4gKysr
IGIvZXh0cmFzL2JpbmRpbmdzL3N3aWcvcHl0aG9uL01ha2VmaWxlLmFtCj4gQEAgLTQsMTYgKzQs
MTQgQEAgbHR0bmcuaTogbHR0bmcuaS5pbgo+ICBBTV9DRkxBR1MgPSAtSSQoUFlUSE9OX0lOQ0xV
REUpIC1JJCh0b3Bfc3JjZGlyKS9saWIvbHR0bmctY3RsIC1JLi4vY29tbW9uIFwKPiAgICAgICAg
ICAgICAgICAkKEJVRERZX0NGTEFHUykKPiAgCj4gLUVYVFJBX0RJU1QgPSBsdHRuZy5pCj4gLXB5
dGhvbl9QWVRIT04gPSBsdHRuZy5weQo+ICtFWFRSQV9ESVNUID0gbHR0bmcuaS5pbgo+ICtub2Rp
c3RfcHl0aG9uX1BZVEhPTiA9IGx0dG5nLnB5Cj4gIHB5ZXhlY19MVExJQlJBUklFUyA9IF9sdHRu
Zy5sYQo+ICAKPiAgTUFJTlRBSU5FUkNMRUFORklMRVMgPSBsdHRuZ193cmFwLmMgbHR0bmcucHkK
PiAgCj4gLV9sdHRuZ19sYV9TT1VSQ0VTID0gbHR0bmdfd3JhcC5jCj4gLQo+ICtub2Rpc3RfX2x0
dG5nX2xhX1NPVVJDRVMgPSBsdHRuZ193cmFwLmMKPiAgX2x0dG5nX2xhX0xERkxBR1MgPSAtbW9k
dWxlCj4gLQo+ICBfbHR0bmdfbGFfTElCQUREID0gCSQodG9wX3NyY2Rpcikvc3JjL2xpYi9sdHRu
Zy1jdGwvbGlibHR0bmctY3RsLmxhIAkJXAo+ICAJCQkkKHRvcF9zcmNkaXIpL3NyYy9jb21tb24v
c2Vzc2lvbmQtY29tbS9saWJzZXNzaW9uZC1jb21tLmxhCj4gIAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
