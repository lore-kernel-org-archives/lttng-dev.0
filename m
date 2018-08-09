From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix: Allow alphanumeric
 characters in SLE version
Date: Thu, 9 Aug 2018 15:10:51 -0400 (EDT)
Message-ID: <476220740.474.1533841851513.JavaMail.zimbra__16832.8938344077$1533841775$gmane$org@efficios.com>
References: <20180809155532.7015-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 41mdBk1WDfz151f
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 15:10:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 7FFBC23AF18
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 15:10:52 -0400 (EDT)
In-Reply-To: <20180809155532.7015-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBtZXJnZWQgaW50byBtYXN0ZXIsIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9uIEF1ZyA5
LCAyMDE4LCBhdCAxMTo1NSBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9zLmNv
bSB3cm90ZToKCj4gQWxsb3cgYWxwaGFudW1lcmljIGNoYXJhY3RlcnMgaW4gdGhlIGxvbmcgdmVy
c2lvbiBzdHJpbmcgYmVmb3JlCj4gZXh0cmFjdGluZyBzcGVjaWZpYyB2ZXJzaW9uIG51bWJlcnMu
IFRoaXMgcHJldmVudHMgZmFpbHVyZSBpbiBkZXRlY3RpbmcKPiBhIFN1U0Uga2VybmVsIHdoZW4g
dGhlIHZlcnNpb24gc3RyaW5nIHdhcyBjdXN0b21pemVkIGJ5IHRoZSBlbmQgdXNlci4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAt
LS0KPiBzY3JpcHRzL2FiaS1zbGUtdmVyc2lvbi5zaCB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9h
Ymktc2xlLXZlcnNpb24uc2ggYi9zY3JpcHRzL2FiaS1zbGUtdmVyc2lvbi5zaAo+IGluZGV4IGJk
NmQ1ZjEuLmFhZmVkN2MgMTAwNzU1Cj4gLS0tIGEvc2NyaXB0cy9hYmktc2xlLXZlcnNpb24uc2gK
PiArKysgYi9zY3JpcHRzL2FiaS1zbGUtdmVyc2lvbi5zaAo+IEBAIC0yMyw3ICsyMyw3IEBAIGlm
IFsgISAtZiAiJHtLUEFUSH0vaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVsZWFzZS5oIiBdOyB0aGVu
Cj4gCWV4aXQgMAo+IGZpCj4gCj4gLVNMRV9SRUxFQVNFPSIkKHNlZCAtcm4gJ3MvXiNkZWZpbmUg
VVRTX1JFTEVBU0UgIiguKiktKFswLTlcLl0rKS0oLiopIi9cMi9wJwo+ICIke0tQQVRIfS9pbmNs
dWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgiKSIKPiArU0xFX1JFTEVBU0U9IiQoc2VkIC1ybiAn
cy9eI2RlZmluZSBVVFNfUkVMRUFTRQo+ICIoLiopLShbMC05YS16QS1aXC5dKyktKC4qKSIvXDIv
cCcgIiR7S1BBVEh9L2luY2x1ZGUvZ2VuZXJhdGVkL3V0c3JlbGVhc2UuaCIpIgo+IAo+IFNMRV9S
RUxFQVNFX01BSk9SPSIkKGVjaG8gIiR7U0xFX1JFTEVBU0V9IiB8IHNlZCAtcm4gJ3MvXihbMC05
XSspKC4qKSQvXDEvcCcpIgo+IFNMRV9SRUxFQVNFX01JTk9SPSIkKGVjaG8gIiR7U0xFX1JFTEVB
U0V9IiB8IHNlZCAtcm4KPiAncy9eKFswLTldKylcLihbMC05XSspKC4qKSQvXDIvcCcpIgo+IC0t
Cj4gMi4xNy4xCgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3
LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
