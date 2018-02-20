From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 2/2] Update: kvm
 instrumentation for fedora 4.14.13-300
Date: Tue, 20 Feb 2018 12:34:00 -0500 (EST)
Message-ID: <37095227.30980.1519148040460.JavaMail.zimbra__41945.2598238879$1519147932$gmane$org@efficios.com>
References: <1519146605-24297-1-git-send-email-mjeanson@efficios.com>
 <1519146605-24297-2-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zm75P0z61zqvX
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:34:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B5C1C4127E7
 for <lttng-dev@lists.lttng.org>; Tue, 20 Feb 2018 12:34:00 -0500 (EST)
In-Reply-To: <1519146605-24297-2-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0tIE9u
IEZlYiAyMCwgMjAxOCwgYXQgMTI6MTAgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZp
Y2lvcy5jb20gd3JvdGU6Cgo+IFN0YXJ0aW5nIGZyb20gNC4xNC4xMy0zMDAgdGhlIGZlZG9yYSBr
ZXJuZWwgYmFja3BvcnQgYSBrdm0gaW5zdHJ1bWVudGF0aW9uCj4gY2hhbmdlIGludHJvZHVjZWQg
aW4gNC4xNSB3aGljaCBhZmZlY3RzIHRoZSBwcm90b3R5cGUgb2YgdGhlIGt2bV9tbWlvIGV2ZW50
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3Mu
Y29tPgo+IC0tLQo+IGluc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIHwg
MyArKy0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5o
Cj4gYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaAo+IGluZGV4IDli
YmY5NWYuLjc2ZWFhNjkgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRu
Zy1tb2R1bGUva3ZtLmgKPiArKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVs
ZS9rdm0uaAo+IEBAIC05MSw3ICs5MSw4IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQoa3ZtX2Fj
a19pcnEsCj4gCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDQsMTEyLCA0LDUsMCkgXAo+IAl8fCBM
VFROR19LRVJORUxfUkFOR0UoMywxNiw1MiwgMywxNywwKSBcCj4gCXx8IExUVE5HX0tFUk5FTF9S
QU5HRSgzLDIsOTcsIDMsMywwKSBcCj4gLQl8fCBMVFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDQs
OSw2NSwwLDMsMCwgNCwxMCwwLDAsMCwwKSkKPiArCXx8IExUVE5HX0RFQklBTl9LRVJORUxfUkFO
R0UoNCw5LDY1LDAsMywwLCA0LDEwLDAsMCwwLDApIFwKPiArCXx8IExUVE5HX0ZFRE9SQV9LRVJO
RUxfUkFOR0UoNCwxNCwxMywzMDAsIDQsMTUsMCwwKSkKPiAKPiBMVFROR19UUkFDRVBPSU5UX0VW
RU5UKGt2bV9tbWlvLAo+IAlUUF9QUk9UTyhpbnQgdHlwZSwgaW50IGxlbiwgdTY0IGdwYSwgdm9p
ZCAqdmFsKSwKPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
