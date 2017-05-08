From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Set -Wall globally in AM_CFLAGS
Date: Mon, 8 May 2017 20:23:20 +0000 (UTC)
Message-ID: <541019984.30672.1494275000602.JavaMail.zimbra__14361.6800815382$1494274893$gmane$org@efficios.com>
References: <1494274522-28670-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMDSN3x9nzY5q
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 20:22:12 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A1FCE340357
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 20:23:24 +0000 (UTC)
In-Reply-To: <1494274522-28670-1-git-send-email-mjeanson@efficios.com>
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

TWVyZ2VkIGludG8gbWFzdGVyIChvbmx5KSwgYXMgaXQgaXMgbm90IGEgZml4LCB0aGFua3MhCgpN
YXRoaWV1CgotLS0tLSBPbiBNYXkgOCwgMjAxNywgYXQgNDoxNSBQTSwgTWljaGFlbCBKZWFuc29u
IG1qZWFuc29uQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBK
ZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gY29uZmlndXJlLmFjICAgIHwg
MSArCj4gc3JjL01ha2VmaWxlLmFtIHwgMSAtCj4gMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25m
aWd1cmUuYWMKPiBpbmRleCA3NTNiZWM1Li4wMjBhZGZjIDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3Vy
ZS5hYwo+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC0zNjksNiArMzY5LDcgQEAgQUNfQ0hFQ0tf
RlVOQ1MoW3NjaGVkX3NldGFmZmluaXR5XSxbCj4gQU1fQ1BQRkxBR1M9Ii1pbmNsdWRlIGNvbmZp
Zy5oIgo+IEFDX1NVQlNUKEFNX0NQUEZMQUdTKQo+IAo+ICtBTV9DRkxBR1M9Ii1XYWxsICRBTV9D
RkxBR1MiCj4gQUNfU1VCU1QoQU1fQ0ZMQUdTKQo+IAo+IEFDX0NPTkZJR19MSU5LUyhbCj4gZGlm
ZiAtLWdpdCBhL3NyYy9NYWtlZmlsZS5hbSBiL3NyYy9NYWtlZmlsZS5hbQo+IGluZGV4IDc3NmMy
YTMuLmE4MDEwMjAgMTAwNjQ0Cj4gLS0tIGEvc3JjL01ha2VmaWxlLmFtCj4gKysrIGIvc3JjL01h
a2VmaWxlLmFtCj4gQEAgLTYsNyArNiw2IEBAIEFNX0xERkxBR1M9LXZlcnNpb24taW5mbyAkKFVS
Q1VfTElCUkFSWV9WRVJTSU9OKQo+IGlmIFVTRV9DWUdXSU4KPiBBTV9MREZMQUdTKz0tbm8tdW5k
ZWZpbmVkCj4gZW5kaWYKPiAtQU1fQ0ZMQUdTKz0tV2FsbAo+IAo+IGluY2x1ZGVfSEVBREVSUyA9
IHVyY3UuaCB1cmN1LWJwLmggdXJjdS1jYWxsLXJjdS5oIHVyY3UtZGVmZXIuaCBcCj4gCQl1cmN1
LXBvaW50ZXIuaCB1cmN1LXFzYnIuaCB1cmN1LWZsYXZvci5oCj4gLS0KPiAyLjcuNAoKLS0gCk1h
dGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1h
aWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
