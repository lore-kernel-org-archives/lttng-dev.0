From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: include config.h to resolve
	HAVE_DLMOPEN
Date: Wed, 22 Feb 2017 10:32:05 +0000 (UTC)
Message-ID: <1016807544.195958.1487759525434.JavaMail.zimbra__30923.3296233744$1487759326$gmane$org@efficios.com>
References: <842296836.195814.1487712447723.JavaMail.zimbra@efficios.com>
 <1487718611-28222-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vStrZ1gGfzl4r
 for <lttng-dev@lists.lttng.org>; Wed, 22 Feb 2017 10:29:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A706340300
 for <lttng-dev@lists.lttng.org>; Wed, 22 Feb 2017 10:32:06 +0000 (UTC)
In-Reply-To: <1487718611-28222-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

bWVyZ2VkIGludG8gbWFzdGVyIGFuZCBzdGFibGUtMi45LCB0aGFua3MhCgpNYXRoaWV1CgotLS0t
LSBPbiBGZWIgMjIsIDIwMTcsIGF0IDEyOjEwIEFNLCBKb25hdGhhbiBSYWpvdHRlIGpvbmF0aGFu
LnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gRml4ZXMgY29tbWl0IDQyMzMw
YWRjZWZjZDE4MzBkYWQ4OWUyYTk2MGM5M2Q4ZGQxZGExMjUKPiAKPiBTaWduZWQtb2ZmLWJ5OiBK
b25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Cj4g
LS0tCj4gbGlibHR0bmctdXN0LWRsL3VzdF9kbC5oIHwgMSArCj4gMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL2xpYmx0dG5nLXVzdC1kbC91c3RfZGwuaCBi
L2xpYmx0dG5nLXVzdC1kbC91c3RfZGwuaAo+IGluZGV4IGFmYThlODQuLmM4YTA2OTUgMTAwNjQ0
Cj4gLS0tIGEvbGlibHR0bmctdXN0LWRsL3VzdF9kbC5oCj4gKysrIGIvbGlibHR0bmctdXN0LWRs
L3VzdF9kbC5oCj4gQEAgLTMzLDYgKzMzLDcgQEAgZXh0ZXJuICJDIiB7Cj4gCj4gI2luY2x1ZGUg
PHN0ZGludC5oPgo+ICNpbmNsdWRlIDx1bmlzdGQuaD4KPiArI2luY2x1ZGUgPGNvbmZpZy5oPgo+
IAo+ICNkZWZpbmUgTFRUTkdfVVNUX0RMX1BST1ZJREVSCj4gI2luY2x1ZGUgPGx0dG5nL3RyYWNl
cG9pbnQuaD4KPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
