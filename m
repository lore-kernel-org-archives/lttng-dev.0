From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Build ftrace probe on
 kernels prior to 4.12
Date: Tue, 30 May 2017 14:58:30 +0000 (UTC)
Message-ID: <1657654750.1443.1496156310853.JavaMail.zimbra__16327.0086436116$1496156544$gmane$org@efficios.com>
References: <1496151391-26076-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wccDm5bhFz12K1
 for <lttng-dev@lists.lttng.org>; Tue, 30 May 2017 14:58:32 +0000 (UTC)
In-Reply-To: <1496151391-26076-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciwgMi4xMCwgMi45LCAyLjgsIHRoYW5rcyEKCk1hdGhpZXUKCi0tLS0t
IE9uIE1heSAzMCwgMjAxNywgYXQgOTozNiBBTSwgRnJhbmNpcyBEZXNsYXVyaWVycyBmcmFuY2lz
LmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbSB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogRnJhbmNp
cyBEZXNsYXVyaWVycyA8ZnJhbmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20+Cj4gLS0tCj4g
cHJvYmVzL0tidWlsZCB8IDUgKysrLS0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9wcm9iZXMvS2J1aWxkIGIvcHJvYmVz
L0tidWlsZAo+IGluZGV4IGZlODY5ZDAuLjc4YmYzZmIgMTAwNjQ0Cj4gLS0tIGEvcHJvYmVzL0ti
dWlsZAo+ICsrKyBiL3Byb2Jlcy9LYnVpbGQKPiBAQCAtMjY3LDggKzI2Nyw5IEBAIGlmbmVxICgk
KENPTkZJR19EWU5BTUlDX0ZUUkFDRSksKQo+ICAgICAgICAgZWNobyAid2FybiIgOyBcCj4gICAg
ICAgICBleGl0IDsgXAo+ICAgICAgIGZpOyBcCj4gLSAgICAgIGVjaG8gImx0dG5nLWZ0cmFjZS5v
IiA7IFwKPiAtICAgIGZpOykKPiArICAgIGZpOyBcCj4gKyAgICBlY2hvICJsdHRuZy1mdHJhY2Uu
byIgOyBcCj4gKyAgICApCj4gICBpZmVxICgkKGZ0cmFjZSksd2FybikKPiAgICAgJCh3YXJuaW5n
IEZpbGVzICQoZnRyYWNlX2RlcCkgbm90IGZvdW5kLiBQcm9iZSAiZnRyYWNlIiBpcyBkaXNhYmxl
ZC4gVXNlIGZ1bGwKPiAgICAga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4pCj4gICAg
IGZ0cmFjZSA9Cj4gLS0KPiAyLjcuNAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIElu
Yy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
