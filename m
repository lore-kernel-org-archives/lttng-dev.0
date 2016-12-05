From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Add missing pthread.h
	include
Date: Mon, 5 Dec 2016 15:40:37 -0500
Message-ID: <46f050c2-1571-2cb8-f105-ec0c26234d75__26961.6241836504$1480970454$gmane$org@efficios.com>
References: <1480970366-14140-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tXcBs2JgGztrd
 for <lttng-dev@lists.lttng.org>; Mon,  5 Dec 2016 20:42:29 +0000 (UTC)
In-Reply-To: <1480970366-14140-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

VGhpcyBzaG91bGQgYmUgYmFja3BvcnRlZCB0byBzdGFibGUtMi45LgoKT24gMjAxNi0xMi0wNSAx
NTozOSwgTWljaGFlbCBKZWFuc29uIHdyb3RlOgo+IFNvbWUgbGliYyBsaWtlIG11c2wgYW5kIHVD
bGliYyByZXF1aXJlcyBleHBsaWNpdCBpbmNsdWRlcyBvZiBwdGhyZWFkLmgKPiAKPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAg
c3JjL2NvbW1vbi9kZWZhdWx0cy5oIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+IAo+IGRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2RlZmF1bHRzLmggYi9zcmMvY29tbW9u
L2RlZmF1bHRzLmgKPiBpbmRleCAyN2YxZGRjLi4zN2QyMjJhIDEwMDY0NAo+IC0tLSBhL3NyYy9j
b21tb24vZGVmYXVsdHMuaAo+ICsrKyBiL3NyYy9jb21tb24vZGVmYXVsdHMuaAo+IEBAIC0yMCw2
ICsyMCw3IEBACj4gICNpZm5kZWYgX0RFRkFVTFRTX0gKPiAgI2RlZmluZSBfREVGQVVMVFNfSAo+
ICAKPiArI2luY2x1ZGUgPHB0aHJlYWQuaD4KPiAgI2luY2x1ZGUgPHNyYy9jb21tb24vbWFjcm9z
Lmg+Cj4gIAo+ICAvKiBEZWZhdWx0IHVuaXggZ3JvdXAgbmFtZSBmb3IgdHJhY2luZy4gKi8KPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
