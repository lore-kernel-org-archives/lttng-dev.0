From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH 1/3] tests/lib/Makefile.am: Remove
 test_seek_empty_packet and test_seek_big_trace from SCRIPT_LIST
Date: Thu, 28 Apr 2016 18:28:49 +0000 (UTC)
Message-ID: <808373029.72582.1461868129007.JavaMail.zimbra__25675.5649847493$1461868160$gmane$org@efficios.com>
References: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
 <e2a89f7d42d3628541f53cae8ca478ac@simark.ca>
 <1804225761.72412.1461860179512.JavaMail.zimbra@efficios.com>
 <1d03bf34bd523c31ab8d32e7abda56ec@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 645E3A3315
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 18:28:53 +0000 (UTC)
In-Reply-To: <1d03bf34bd523c31ab8d32e7abda56ec@simark.ca>
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
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gQXByIDI4LCAyMDE2LCBhdCAxMjo0NCBQTSwgU2ltb24gTWFyY2hpIHNpbW9uLm1h
cmNoaUBwb2x5bXRsLmNhIHdyb3RlOgo+IAo+IE9rIHRoYW5rcy4KPiAKPiBKdXN0IGFuIGlkZWE6
IEkgZmluZCBpdCBxdWl0ZSBjdW1iZXJzb21lIHRvIGFkZCBhIG5ldyBlbnRyeSBpbgo+IGNvbmZp
Z3VyZS5hYyBmb3IgZWFjaCB0ZXN0IHNjcmlwdCB0aGF0IHdlIHdhbnQgYXV0b2NvbmYgdG8gcHJv
Y2VzcyAoc3VjaAo+IGFzIGluIHBhdGNoIDMvMykuICBJIHRoaW5rIGl0IGNvdWxkIGJlIGVhc2ll
ciB0byBoYXZlIGEgc2luZ2xlIGZpbGUKPiAoZS5nLiB2YXJzLnNoKSBhbmQgaGF2ZSBpdCBjb250
YWluIGRlZmluaXRpb25zIG9mIHZhcmlvdXMgZGlyZWN0b3JpZXM6Cj4gCj4gICBzcmNkaXI9QHNy
Y2RpckAKPiAgIHRvcF9zcmNkaXI9QHRvcF9zcmNkaXJACj4gICBhYnNfdG9wX3NyY2Rpcj1AYWJz
X3RvcF9zcmNkaXJACj4gICBidWlsZGRpcj1AYnVpbGRkaXJACj4gICAuLi4KPiAKPiBUaGlzIHdh
eSwgeW91IGNvdWxkIGhhdmUgb25seSBhIHNpbmdsZSBnZW5lcmF0ZWQgZmlsZSAodmFycy5zaC5p
biAtPgo+IHZhcnMuc2gpLCBhbmQgZWFjaCB0ZXN0IHNjcmlwdCB3b3VsZCBqdXN0IGhhdmUgdG8g
c291cmNlIHRoYXQgZmlsZSB0bwo+IHVzZSB0aGUgdmFsdWVzLgoKQXMgZGlzY3Vzc2VkIG9uICNs
dHRuZywgaGVyZSBpcyB0aGUgUFIgcmVzdWx0aW5nIGZyb20gbXkgdXBkYXRlcyB0byB5b3VyCnBh
dGNoZXMgOgoKICBodHRwczovL2dpdGh1Yi5jb20vZWZmaWNpb3MvYmFiZWx0cmFjZS9wdWxsLzQz
CgoKQ29uY2VybmluZyB0aGUgaW5jbHVkZSBmaWxlLCBJJ20gbm90IGNvbnZpbmNlZCBpdCB3b3Vs
ZCBiZSBzaW1wbGVyLCB3ZSB3b3VsZAplbmQgdXAgd2l0aCBzdGF0aWMgc2NyaXB0cyBpbiB0aGUg
c291cmNlIGRpciBpbmNsdWRpbmcgYSBnZW5lcmF0ZWQgZmlsZSBpbgp0aGUgYnVpbGRkaXIuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
