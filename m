From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] build: pass configure flags to
	cmake example
Date: Mon, 3 Oct 2016 15:11:02 +0000 (UTC)
Message-ID: <60134637.43630.1475507462650.JavaMail.zimbra__34046.8129179955$1475507432$gmane$org@efficios.com>
References: <1475505765-22557-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 20C07A4389
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 15:11:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 39173340237
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 15:11:06 +0000 (UTC)
In-Reply-To: <1475505765-22557-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGludG8gbWFzdGVyLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBPY3QgMywgMjAx
NiwgYXQgMTA6NDIgQU0sIEpvbmF0aGFuIFJham90dGUgam9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxq
b25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gZG9jL2V4YW1wbGVz
L01ha2VmaWxlLmFtIHwgOCArKysrKysrLQo+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZG9jL2V4YW1wbGVzL01ha2VmaWxl
LmFtIGIvZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtCj4gaW5kZXggYzdlNWI2OC4uNWQ2N2U3OSAx
MDA2NDQKPiAtLS0gYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0KPiArKysgYi9kb2MvZXhhbXBs
ZXMvTWFrZWZpbGUuYW0KPiBAQCAtMTQ5LDcgKzE0OSwxMyBAQCBhbGwtbG9jYWw6Cj4gCQkJCWNk
ICQoU1VCRElSU19DTUFLRSkgJiYgXAo+IAkJCQkkKE1LRElSX1ApIGJ1aWxkICYmIFwKPiAJCQkJ
Y2QgYnVpbGQgJiYgXAo+IC0JCQkJY21ha2UKPiAtRENNQUtFX0lOQ0xVREVfUEFUSD0iJChhYnNf
dG9wX3NyY2RpcikvaW5jbHVkZTskKGFic190b3BfYnVpbGRkaXIpL2luY2x1ZGUiCj4gLURDTUFL
RV9MSUJSQVJZX1BBVEg9IiQoYWJzX3RvcF9idWlsZGRpcikvbGlibHR0bmctdXN0Ly5saWJzIiAu
LiAmJiBcCj4gKwkJCQljbWFrZSBcCj4gKwo+IAkJCQktRENNQUtFX0lOQ0xVREVfUEFUSD0iJChh
YnNfdG9wX3NyY2RpcikvaW5jbHVkZTskKGFic190b3BfYnVpbGRkaXIpL2luY2x1ZGUiCj4gXAo+
ICsJCQkJLURDTUFLRV9MSUJSQVJZX1BBVEg9IiQoYWJzX3RvcF9idWlsZGRpcikvbGlibHR0bmct
dXN0Ly5saWJzIiBcCj4gKwkJCQktRENNQUtFX0NfRkxBR1M9IiQoQ0ZMQUdTKSAkKENQUEZMQUdT
KSIgXAo+ICsJCQkJLURDTUFLRV9DWFhfRkxBR1M9IiQoQ1hYRkxBR1MpICQoQ1BQRkxBR1MpIiBc
Cj4gKwkJCQktRENNQUtFX0VYRV9MSU5LRVJfRkxBR1M9IiQoTERGTEFHUykiIFwKPiArCQkJCS4u
ICYmIFwKPiAJCQkJJChNQUtFKSAmJiBcCj4gCQkJCWNkIC4uIFwKPiAJCQkpIHx8IGV4aXQgMTsg
XAo+IC0tCj4gMi43LjQKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
