From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Add support for
	4.9.27-rt18 kernel
Date: Wed, 24 May 2017 15:39:32 +0000 (UTC)
Message-ID: <663932083.23714.1495640372922.JavaMail.zimbra__18998.2203337879$1495640334$gmane$org@efficios.com>
References: <1495639190-29926-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXxQt6hFWz10xj
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 15:39:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D7DE8340378
 for <lttng-dev@lists.lttng.org>; Wed, 24 May 2017 15:39:33 +0000 (UTC)
In-Reply-To: <1495639190-29926-1-git-send-email-mjeanson@efficios.com>
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

LS0tLS0gT24gTWF5IDI0LCAyMDE3LCBhdCA1OjE5IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5z
b25AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24g
PG1qZWFuc29uQGVmZmljaW9zLmNvbT4KCkl0IGRvZXMgbm90IGFwcGVhciB0byBhcHBseSBjbGVh
bmx5IHRvIGx0dG5nLW1vZHVsZXMgbWFzdGVyIGJyYW5jaCwKY2FuIHlvdSBkb3VibGUtY2hlY2sg
PwoKVGhhbmtzLAoKTWF0aGlldQoKCj4gLS0tCj4gaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRu
Zy1tb2R1bGUvc2NoZWQuaCB8IDMgKystCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9pbnN0cnVtZW50YXRpb24vZXZlbnRz
L2x0dG5nLW1vZHVsZS9zY2hlZC5oCj4gYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1v
ZHVsZS9zY2hlZC5oCj4gaW5kZXggYzY4ZGQyNy4uZTZmMzZiMSAxMDA2NDQKPiAtLS0gYS9pbnN0
cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5oCj4gKysrIGIvaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaAo+IEBAIC01NDAsNyArNTQwLDggQEAg
TFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChzY2hlZF9zdGF0X3J1bnRpbWUsCj4gKQo+ICNlbmRpZgo+
IAo+IC0jaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEyLDApKQo+
ICsjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEyLDApIHx8IFwK
PiArCUxUVE5HX1JUX0tFUk5FTF9SQU5HRSg0LDksMjcsMTgsIDQsMTAsMCwwKSkKPiAvKgo+ICAq
IFRyYWNlcG9pbnQgZm9yIHNob3dpbmcgcHJpb3JpdHkgaW5oZXJpdGFuY2UgbW9kaWZ5aW5nIGEg
dGFza3MKPiAgKiBwcmlvcml0eS4KPiAtLQo+IDIuNy40CgotLSAKTWF0aGlldSBEZXNub3llcnMK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
