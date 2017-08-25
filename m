From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: wrong use of the
 relay_streams_sent in snapshot
Date: Fri, 25 Aug 2017 15:47:34 -0400
Message-ID: <8cbd4059-f68b-ced2-2ed2-29a94f562887__3503.31908925927$1503690483$gmane$org@efficios.com>
References: <1503521333-4905-1-git-send-email-jdesfossez@efficios.com>
 <165346610.15437.1503587759926.JavaMail.zimbra@efficios.com>
 <516484ad-49e6-d89f-f8c1-6a1326c4def2@efficios.com>
 <1348147249.16120.1503679655259.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xfBXF6sL3zspW
 for <lttng-dev@lists.lttng.org>; Fri, 25 Aug 2017 19:47:41 +0000 (UTC)
In-Reply-To: <1348147249.16120.1503679655259.JavaMail.zimbra@efficios.com>
Content-Language: fr-classic
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Pj4+IElmIHlvdSByZW1vdmUgdGhpcywgSSB0aGluayB0aGUgc3RyZWFtcyB3aWxsIG5ldmVyIGdl
dCBwdWJsaXNoZWQKPj4+IHdpdGhpbiB0aGUgcmVsYXlkLiAocHVibGlzaF9jb25uZWN0aW9uX2xv
Y2FsX3N0cmVhbXMoKSkuIElzIHRoaXMKPj4+IGFuIGV4cGVjdGVkIHNpZGUtZWZmZWN0ID8gSXQg
c2hvdWxkIGJlIGRvY3VtZW50ZWQgaW4gdGhlIGNoYW5nZWxvZy4KPj4+IE15IGd1ZXNzIGlzIHRo
YXQgd2UgaW5kZWVkIGRvbid0IHdhbnQgdG8gcHVibGlzaCB0aGUgc25hcHNob3QKPj4+IHN0cmVh
bXMgdG8gdGhlIHZpZXdlcnMuCj4+IEluZGVlZCwgYSBzbmFwc2hvdCBzZXNzaW9uIGNhbm5vdCBi
ZSBhIGxpdmUgc2Vzc2lvbiwgc28gd2UgZG9uJ3QKPj4gd2FudC9uZWVkIHRvIHB1Ymxpc2ggdGhv
c2Ugc3RyZWFtcy4gQWxzbywgc2VuZGluZyB0aGlzIG1lc3NhZ2UgZXZlcnkKPj4gdGltZSB3ZSBz
ZW5kIGEgc3RyZWFtIGlzIGEgd3JvbmcgdXNhZ2Ugb2YgdGhlIGNvbW1hbmQuCj4gCj4gWW91J2xs
IG5lZWQgdG8gZW5zdXJlIHRoYXQgd2UgYXJlIG5vdCBmcmVlaW5nIHRoZSBzdHJlYW1zIHRvbwo+
IHF1aWNrbHkgb3IgbGVha2luZyB0aGVtIGluIHJlbGF5ZCBhZnRlciB5b3VyIGNoYW5nZS4KClB1
Ymxpc2hpbmcgdGhlIHN0cmVhbSBkb2VzIG5vdCB0YWtlIGEgbmV3IHJlZmVyZW5jZSBvbiB0aGUg
c3RyZWFtLCBpdApqdXN0IGFkZHMgaXQgaW4gdGhlIHN0cmVhbV9saXN0IHNvIGl0IGJlY29tZXMg
dmlzaWJsZSBpbiB0aGUgdmlld2VyCnRocmVhZC4gU28gaXQgZG9lcyBub3QgY2hhbmdlIHRoZSBs
aWZldGltZSBvZiB0aGUgc3RyZWFtLiBBbmQgaWYgdGhlCnN0cmVhbSBpcyBub3QgcHVibGlzaGVk
IHdoZW4gd2UgcmVtb3ZlIGl0IHdlIGRvbid0IHRyeSB0byB1bnB1Ymxpc2ggaXQuCgo+Pj4gVGhl
IHJlYXNvbiBmb3IgZG9pbmcgdGhpcyBjaGFuZ2Ugc2hvdWxkIGFsc28gYmUgZG9jdW1lbnRlZC4g
V2hhdAo+Pj4gYmVoYXZpb3IgaXMgdW53YW50ZWQgaGVyZSBmcm9tIGEgcmVsYXlkIHBlcnNwZWN0
aXZlID8KPj4gV2UgYXJlIHNlbmRpbmcgdGhpcyBtZXNzYWdlIHRvIHRoZSByZWxheSAoYW5kIHdh
aXRpbmcgZm9yIHRoZQo+PiBjb25maXJtYXRpb24pIGJlZm9yZSB0YWtpbmcgdGhlIHNuYXBzaG90
IG9mIGVhY2ggc3RyZWFtLiBTbywgaW4gYWRkaXRpb24KPj4gdG8gYmVpbmcgd3JvbmcgYW5kIHVz
ZWxlc3MsIGl0IGFkZHMgYSBjb25zaWRlcmFibGUgZGVsYXkgYmVmb3JlIHRha2luZwo+PiB0aGUg
c25hcHNob3Qgb2YgZWFjaCBzdHJlYW0uCj4+Cj4+IERvIHlvdSBhZ3JlZSA/Cj4gCj4gSXQgbG9v
a3MgbGlrZSBhIGdvb2QgaWRlYSB0byByZW1vdmUgaXQuIEkganVzdCB3YW50IHVzIHRvIG1ha2Ug
c3VyZSB0aGUKPiBzbmFwc2hvdCBtb2RlIGRvZXMgbm90IHNvbWVob3cgZXhwZWN0IHRoZSBzdHJl
YW1zIHRvIGJlIHB1Ymxpc2hlZAo+IHdpdGhpbiBvdGhlciBwYXJ0cyBvZiB0aGUgcmVsYXlkIGNv
ZGUuCgpJdCBsb29rcyBnb29kLgoKVGhhbmtzLAoKSnVsaWVuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
