From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: [PATCH babeltrace python/bindings] Python-bindings fix:
	outdated dist target babeltrace.i
Date: Sat, 23 Nov 2013 16:30:59 -0500
Message-ID: <1385242259-11854-1-git-send-email-jeremie.galarneau__6837.14710544354$1385242323$gmane$org@efficios.com>
References: <696349360.74184.1385220360428.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VkKnD-0004ji-H1
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 16:31:10 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so2313587qeb.30
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 13:31:01 -0800 (PST)
In-Reply-To: <696349360.74184.1385220360428.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

VGhpcyBmaXhlcyB0aGUgZGlzdCB0YXJnZXQgZm9yIHRoZSBweXRob24gYmluZGluZ3MuIFRoZQpw
eXRob24tY29tcGxlbWVudHMuaC8uYyBmaWxlcyBtdXN0IGJlIGRpc3RyaWJ1dGVkLCBidXQgbm90
IGluc3RhbGxlZCwKaW4gb3JkZXIgdG8gYnVpbGQgdGhlIHB5dGhvbiBiaW5kaW5ncy4KClNpZ25l
ZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9z
LmNvbT4KLS0tCiBiaW5kaW5ncy9weXRob24vTWFrZWZpbGUuYW0gfCA4ICsrKystLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5hbSBiL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZS5h
bQppbmRleCBiMjVjZTkyLi4yOTUyNDU0IDEwMDY0NAotLS0gYS9iaW5kaW5ncy9weXRob24vTWFr
ZWZpbGUuYW0KKysrIGIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlLmFtCkBAIC0zLDE0ICszLDE0
IEBAIGJhYmVsdHJhY2UuaTogYmFiZWx0cmFjZS5pLmluCiAKIEFNX0NGTEFHUyA9ICQoUFlUSE9O
X0lOQ0xVREUpIC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlLwogCi1FWFRSQV9ESVNUID0gYmFiZWx0
cmFjZS5pCi1weXRob25fUFlUSE9OID0gYmFiZWx0cmFjZS5weQorRVhUUkFfRElTVCA9IGJhYmVs
dHJhY2UuaS5pbgorbm9kaXN0X3B5dGhvbl9QWVRIT04gPSBiYWJlbHRyYWNlLnB5CiBweWV4ZWNf
TFRMSUJSQVJJRVMgPSBfYmFiZWx0cmFjZS5sYQogCiBNQUlOVEFJTkVSQ0xFQU5GSUxFUyA9IGJh
YmVsdHJhY2Vfd3JhcC5jIGJhYmVsdHJhY2UucHkKIAotX2JhYmVsdHJhY2VfbGFfU09VUkNFUyA9
IGJhYmVsdHJhY2Vfd3JhcC5jIHB5dGhvbi1jb21wbGVtZW50cy5jCi0KK25vZGlzdF9fYmFiZWx0
cmFjZV9sYV9TT1VSQ0VTID0gYmFiZWx0cmFjZV93cmFwLmMKK19iYWJlbHRyYWNlX2xhX1NPVVJD
RVMgPSBweXRob24tY29tcGxlbWVudHMuaCBweXRob24tY29tcGxlbWVudHMuYwogX2JhYmVsdHJh
Y2VfbGFfTERGTEFHUyA9IC1tb2R1bGUKIAogX2JhYmVsdHJhY2VfbGFfQ0ZMQUdTID0gJChHTElC
X0NGTEFHUykgJChBTV9DRkxBR1MpCi0tIAoxLjguNC4yCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
