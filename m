From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: asoc instrumentation for
	RHEL 7.3
Date: Thu, 8 Dec 2016 01:27:42 +0000 (UTC)
Message-ID: <894378043.30525.1481160462382.JavaMail.zimbra__35736.58926548$1481160372$gmane$org@efficios.com>
References: <1481138253-2365-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tYyRK1ZzDzf7D
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 01:27:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DBB573401C5
 for <lttng-dev@lists.lttng.org>; Thu,  8 Dec 2016 01:27:46 +0000 (UTC)
In-Reply-To: <1481138253-2365-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyLCAyLjksIDIuOCwgdGhhbmtzIQoKTWF0aGlldQoKLS0tLS0gT24g
RGVjIDcsIDIwMTYsIGF0IDI6MTcgUE0sIE1pY2hhZWwgSmVhbnNvbiBtamVhbnNvbkBlZmZpY2lv
cy5jb20gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgo+IC0tLQo+IGluc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxl
L2Fzb2MuaCB8IDMgKystCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1v
ZHVsZS9hc29jLmgKPiBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2Fzb2Mu
aAo+IGluZGV4IDA5ZTFmZTIuLjI1MTM2ZWMgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0aW9u
L2V2ZW50cy9sdHRuZy1tb2R1bGUvYXNvYy5oCj4gKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9sdHRuZy1tb2R1bGUvYXNvYy5oCj4gQEAgLTIxLDcgKzIxLDggQEAgc3RydWN0IHNuZF9zb2Nf
Y2FyZDsKPiBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldDsKPiAjZW5kaWYKPiAKPiAtI2lmIChM
SU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywxNiwwKSkKPiArI2lmIChMSU5V
WF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywxNiwwKSBcCj4gKwl8fCBMVFROR19S
SEVMX0tFUk5FTF9SQU5HRSgzLDEwLDAsNTE0LDAsMCwgMywxMSwwLDAsMCwwKSkKPiAjZGVmaW5l
IENPREVDX05BTUVfRklFTEQgY29tcG9uZW50Lm5hbWUKPiAjZGVmaW5lIENPREVDX0lEX0ZJRUxE
IGNvbXBvbmVudC5pZAo+ICNlbHNlCj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJz
CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
