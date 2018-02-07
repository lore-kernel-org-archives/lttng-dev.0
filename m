From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 5/8] Fix: missing enum removal
 from the enum hashtable
Date: Wed, 7 Feb 2018 20:55:00 +0000 (UTC)
Message-ID: <271937624.17827.1518036900541.JavaMail.zimbra__49696.2791112766$1518036758$gmane$org@efficios.com>
References: <1517600891-23632-1-git-send-email-francis.deslauriers@efficios.com>
 <1517600891-23632-6-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcD8P2yYdzCgr
 for <lttng-dev@lists.lttng.org>; Wed,  7 Feb 2018 20:54:13 +0000 (UTC)
In-Reply-To: <1517600891-23632-6-git-send-email-francis.deslauriers@efficios.com>
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

LS0tLS0gT24gRmViIDIsIDIwMTgsIGF0IDI6NDggUE0sIEZyYW5jaXMgRGVzbGF1cmllcnMgZnJh
bmNpcy5kZXNsYXVyaWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6CgpJcyBpdCBhIGZpeCBvciBhIHBy
ZXBhcmF0aW9uIHN0ZXAgZm9yIGEgbmV3IGZlYXR1cmUgPwoKVGhhbmtzLAoKTWF0aGlldQoKPiBT
aWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFuY2lzLmRlc2xhdXJpZXJzQGVm
ZmljaW9zLmNvbT4KPiAtLS0KPiBsaWJsdHRuZy11c3QvbHR0bmctZXZlbnRzLmMgfCAxICsKPiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvbGlibHR0bmct
dXN0L2x0dG5nLWV2ZW50cy5jIGIvbGlibHR0bmctdXN0L2x0dG5nLWV2ZW50cy5jCj4gaW5kZXgg
ZThkNDg1Ny4uMmI2NzliNSAxMDA2NDQKPiAtLS0gYS9saWJsdHRuZy11c3QvbHR0bmctZXZlbnRz
LmMKPiArKysgYi9saWJsdHRuZy11c3QvbHR0bmctZXZlbnRzLmMKPiBAQCAtOTkwLDYgKzk5MCw3
IEBAIHN0YXRpYwo+IHZvaWQgX2x0dG5nX2VudW1fZGVzdHJveShzdHJ1Y3QgbHR0bmdfZW51bSAq
X2VudW0pCj4gewo+IAljZHNfbGlzdF9kZWwoJl9lbnVtLT5ub2RlKTsKPiArCWNkc19obGlzdF9k
ZWwoJl9lbnVtLT5obGlzdCk7Cj4gCWZyZWUoX2VudW0pOwo+IH0KPiAKPiAtLQo+IDIuNy40Cgot
LSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
