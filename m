From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules stable-2.x 1/2] Fix: Allow
 alphanumeric characters in SLE version
Date: Thu, 9 Aug 2018 15:11:02 -0400 (EDT)
Message-ID: <600696930.475.1533841862736.JavaMail.zimbra__12323.3237224214$1533841804$gmane$org@efficios.com>
References: <20180809155656.7287-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41mdBv4KHqz151w
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 15:11:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 2414B23AF30
 for <lttng-dev@lists.lttng.org>; Thu,  9 Aug 2018 15:11:03 -0400 (EDT)
In-Reply-To: <20180809155656.7287-1-mjeanson@efficios.com>
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

Qm90aCBtZXJnZWQgaW50byAyLjksIDIuMTAsIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9uIEF1
ZyA5LCAyMDE4LCBhdCAxMTo1NiBBTSwgTWljaGFlbCBKZWFuc29uIG1qZWFuc29uQGVmZmljaW9z
LmNvbSB3cm90ZToKCj4gQWxsb3cgYWxwaGFudW1lcmljIGNoYXJhY3RlcnMgaW4gdGhlIGxvbmcg
dmVyc2lvbiBzdHJpbmcgYmVmb3JlCj4gZXh0cmFjdGluZyBzcGVjaWZpYyB2ZXJzaW9uIG51bWJl
cnMuIFRoaXMgcHJldmVudHMgZmFpbHVyZSBpbiBkZXRlY3RpbmcKPiBhIFN1U0Uga2VybmVsIHdo
ZW4gdGhlIHZlcnNpb24gc3RyaW5nIHdhcyBjdXN0b21pemVkIGJ5IHRoZSBlbmQgdXNlci4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4K
PiAtLS0KPiBhYmktc2xlLXZlcnNpb24uc2ggfCAyICstCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FiaS1zbGUtdmVyc2lv
bi5zaCBiL2FiaS1zbGUtdmVyc2lvbi5zaAo+IGluZGV4IDBiZDY1YjEuLjU5ZTdkNjcgMTAwNzU1
Cj4gLS0tIGEvYWJpLXNsZS12ZXJzaW9uLnNoCj4gKysrIGIvYWJpLXNsZS12ZXJzaW9uLnNoCj4g
QEAgLTIyLDcgKzIyLDcgQEAgaWYgWyAhIC1mICIke0tQQVRIfS9pbmNsdWRlL2dlbmVyYXRlZC91
dHNyZWxlYXNlLmgiIF07IHRoZW4KPiAJZXhpdCAwCj4gZmkKPiAKPiAtU0xFX1JFTEVBU0U9IiQo
c2VkIC1ybiAncy9eI2RlZmluZSBVVFNfUkVMRUFTRSAiKC4qKS0oWzAtOVwuXSspLSguKikiL1wy
L3AnCj4gIiR7S1BBVEh9L2luY2x1ZGUvZ2VuZXJhdGVkL3V0c3JlbGVhc2UuaCIpIgo+ICtTTEVf
UkVMRUFTRT0iJChzZWQgLXJuICdzL14jZGVmaW5lIFVUU19SRUxFQVNFCj4gIiguKiktKFswLTlh
LXpBLVpcLl0rKS0oLiopIi9cMi9wJyAiJHtLUEFUSH0vaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVs
ZWFzZS5oIikiCj4gCj4gU0xFX1JFTEVBU0VfTUFKT1I9IiQoZWNobyAiJHtTTEVfUkVMRUFTRX0i
IHwgc2VkIC1ybiAncy9eKFswLTldKykoLiopJC9cMS9wJykiCj4gU0xFX1JFTEVBU0VfTUlOT1I9
IiQoZWNobyAiJHtTTEVfUkVMRUFTRX0iIHwgc2VkIC1ybgo+ICdzL14oWzAtOV0rKVwuKFswLTld
KykoLiopJC9cMi9wJykiCj4gLS0KPiAyLjE3LjEKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZp
Y2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
