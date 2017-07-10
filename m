From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: sched for v4.11.5-rt1
Date: Mon, 10 Jul 2017 22:20:26 +0000 (UTC)
Message-ID: <460832083.12496.1499725226732.JavaMail.zimbra__46380.6517691866$1499725173$gmane$org@efficios.com>
References: <1499724791-17165-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3x606Q2PWwz1423
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 22:21:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7B62D3401B0
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 22:20:27 +0000 (UTC)
In-Reply-To: <1499724791-17165-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjEwLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0t
LS0gT24gSnVsIDEwLCAyMDE3LCBhdCA2OjEzIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25A
ZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1q
ZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5n
LW1vZHVsZS9zY2hlZC5oIHwgMyArKy0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMv
bHR0bmctbW9kdWxlL3NjaGVkLmgKPiBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9k
dWxlL3NjaGVkLmgKPiBpbmRleCBlNmYzNmIxLi5jYjViNWIyIDEwMDY0NAo+IC0tLSBhL2luc3Ry
dW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3NjaGVkLmgKPiArKysgYi9pbnN0cnVtZW50
YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5oCj4gQEAgLTU0MSw3ICs1NDEsOCBAQCBM
VFROR19UUkFDRVBPSU5UX0VWRU5UKHNjaGVkX3N0YXRfcnVudGltZSwKPiAjZW5kaWYKPiAKPiAj
aWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEyLDApIHx8IFwKPiAt
CUxUVE5HX1JUX0tFUk5FTF9SQU5HRSg0LDksMjcsMTgsIDQsMTAsMCwwKSkKPiArCUxUVE5HX1JU
X0tFUk5FTF9SQU5HRSg0LDksMjcsMTgsIDQsMTAsMCwwKSB8fCBcCj4gKwlMVFROR19SVF9LRVJO
RUxfUkFOR0UoNCwxMSw1LDEsIDQsMTIsMCwwKSkKPiAvKgo+ICAqIFRyYWNlcG9pbnQgZm9yIHNo
b3dpbmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9kaWZ5aW5nIGEgdGFza3MKPiAgKiBwcmlvcml0
eS4KPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRw
Oi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
