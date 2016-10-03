From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: lttng-tools backport request: Fix: error.h ->
 common/error.h
Date: Mon, 3 Oct 2016 15:42:56 -0500
Message-ID: <90905ba7-d102-c9f3-6fb3-67eb630b6558__42315.7475343489$1475527408$gmane$org@mentor.com>
References: <4f48032d-049c-5e3a-f635-f7978a5ad783@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3CB9EA43EB
 for <lttng-dev@lists.lttng.org>; Mon,  3 Oct 2016 20:44:30 +0000 (UTC)
Received: from svr-orw-fem-02x.mgc.mentorg.com ([147.34.96.206]
 helo=SVR-ORW-FEM-02.mgc.mentorg.com)
 by relay1.mentorg.com with esmtp
 id 1brA4g-00009K-72 from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Mon, 03 Oct 2016 13:42:58 -0700
In-Reply-To: <4f48032d-049c-5e3a-f635-f7978a5ad783@mentor.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMTAvMDMvMjAxNiAxMDozNiBBTSwgTmF0aGFuIEx5bmNoIHdyb3RlOgo+IENhbiB0aGlzIGJl
IGJhY2twb3J0ZWQgdG8gdGhlIHN0YWJsZS0yLjggYnJhbmNoPwo+IAo+IGNvbW1pdCA2NzEyZGI2
MTdmZTkKPiBBdXRob3I6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25AZWZmaWNpb3MuY29tPgo+
IERhdGU6ICAgV2VkIEp1biAxNSAxNzoxODowMyAyMDE2IC0wNDAwCj4gCj4gICAgIEZpeDogZXJy
b3IuaCAtPiBjb21tb24vZXJyb3IuaAo+IAo+IE9FIGlzIGNhcnJ5aW5nIHRoaXMgcGF0Y2ggZm9y
IGl0cyBsdHRuZy10b29scyAyLjggcGFja2FnZSBpbiBvcmRlciB0bwo+IGJ1aWxkIGFnYWluc3Qg
bXVzbCBsaWJjOgo+IAo+IGh0dHA6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL3BpcGVybWFpbC9v
cGVuZW1iZWRkZWQtY29yZS8yMDE2LVNlcHRlbWJlci8xMjY4NTEuaHRtbAo+IAo+IEkgaGF2ZW4n
dCBwZXJzb25hbGx5IHZlcmlmaWVkIHRoZSBwcm9ibGVtIG9yIHRoZSBwYXRjaCwgYnV0IGl0IHNl
ZW1zCj4gbGlrZSBhbiBvYnZpb3VzLCBsb3ctcmlzayBmaXg/CgpJJ3ZlIG5vdyB2ZXJpZmllZCB0
aGF0IHRoZSBwYXRjaCBpcyBuZWNlc3NhcnkgZm9yIGNyb3NzLWNvbXBpbGluZyB3aXRoIGEKbXVz
bCB0b29sY2hhaW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0
cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
