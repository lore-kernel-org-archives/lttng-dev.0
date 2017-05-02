From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH urcu v3] Fix: Don't override user variables
 within the build system
Date: Tue, 2 May 2017 17:43:07 -0400
Message-ID: <0cfa2bd5-919f-804b-ea39-5400f22f4a22__2419.24892548031$1493761398$gmane$org@efficios.com>
References: <1493761245-1251-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wHZYT3xjJzC7D
 for <lttng-dev@lists.lttng.org>; Tue,  2 May 2017 21:43:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 70721340187
 for <lttng-dev@lists.lttng.org>; Tue,  2 May 2017 21:45:09 +0000 (UTC)
In-Reply-To: <1493761245-1251-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wNS0wMiAxNzo0MCwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IEluc3RlYWQgdXNl
IHRoZSBhcHByb3ByaWF0bHkgcHJlZml4ZWQgQU1fKiB2YXJpYWJsZXMgYXMgdG8gbm90IGludGVy
ZmVyZQo+IHdoZW4gYSB1c2VyIHZhcmlhYmxlIGlzIHBhc3NlZCB0byBhIG1ha2UgY29tbWFuZC4g
VGhlIHByb3BlciB1c2Ugb2YgZmxhZwo+IHZhcmlhYmxlcyBpcyBkb2N1bWVudGVkIGF0IDoKPiAK
PiBodHRwczovL3d3dy5nbnUub3JnL3NvZnR3YXJlL2F1dG9tYWtlL21hbnVhbC9hdXRvbWFrZS5o
dG1sI0ZsYWctVmFyaWFibGVzLU9yZGVyaW5nCj4gCj4gRml4ZXMgIzEwOTUKPiAKPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAg
Y29uZmlndXJlLmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKystLS0tLS0K
PiAgZG9jL2V4YW1wbGVzL01ha2VmaWxlLmFtICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZG9j
L2V4YW1wbGVzL01ha2VmaWxlLmV4YW1wbGVzLnRlbXBsYXRlIHwgIDkgKysrLS0tLS0tCj4gIHNy
Yy9NYWtlZmlsZS5hbSAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKystLS0tCj4gIHRl
c3RzL2JlbmNobWFyay9NYWtlZmlsZS5hbSAgICAgICAgICAgICB8ICAyICstCj4gIHRlc3RzL2Nv
bW1vbi9NYWtlZmlsZS5hbSAgICAgICAgICAgICAgICB8ICAyICstCj4gIHRlc3RzL3JlZ3Jlc3Np
b24vTWFrZWZpbGUuYW0gICAgICAgICAgICB8ICAyICstCj4gIHRlc3RzL3VuaXQvTWFrZWZpbGUu
YW0gICAgICAgICAgICAgICAgICB8ICAyICstCj4gIHRlc3RzL3V0aWxzL01ha2VmaWxlLmFtICAg
ICAgICAgICAgICAgICB8ICAyICstCj4gIDkgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMjIgZGVsZXRpb25zKC0pCgpUaGlzIHBhdGNoIGRlcHJlY2F0ZXMgOgoKICBbUEFUQ0ggdXJj
dSB2Ml0gRml4OiBEb24ndCB1c2UgQ0ZMQUdTIGluIGNvbmZpZ3VyZSBzY3JpcHQKCgpJdCBub3cg
aGFzIGEgYnJvYWRlciBzY29wZSB0aGFuIGp1c3QgQ0ZMQUdTLgoKTWljaGFlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
