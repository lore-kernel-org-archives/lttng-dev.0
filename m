From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: macro compares unsigned to 0
	(no effect)
Date: Tue, 17 May 2016 09:01:51 -0400
Message-ID: <1463490111-13604-1-git-send-email-mathieu.desnoyers__13909.050616394$1463490148$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 87725A34DA
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 13:02:03 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTI2MjExNyAoIzEgb2YgMSk6IE1hY3JvIGNvbXBhcmVz
IHVuc2lnbmVkIHRvIDAKKE5PX0VGRkVDVCl1bnNpZ25lZF9jb21wYXJlOiBUaGlzIGdyZWF0ZXIt
dGhhbi1vci1lcXVhbC10by16ZXJvCmNvbXBhcmlzb24gb2YgYW4gdW5zaWduZWQgdmFsdWUgaXMg
YWx3YXlzIHRydWUuIGV2ZW50cy0+bmJfZmQgPj0gMFUuCgpTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1
IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0KIHNyYy9jb21t
b24vY29tcGF0L2NvbXBhdC1lcG9sbC5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29tcGF0L2NvbXBhdC1lcG9sbC5jIGIvc3Jj
L2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMKaW5kZXggNThmNTBjYy4uNjI1OWZkMyAxMDA2
NDQKLS0tIGEvc3JjL2NvbW1vbi9jb21wYXQvY29tcGF0LWVwb2xsLmMKKysrIGIvc3JjL2NvbW1v
bi9jb21wYXQvY29tcGF0LWVwb2xsLmMKQEAgLTIwOCw3ICsyMDgsNiBAQCBpbnQgY29tcGF0X2Vw
b2xsX3dhaXQoc3RydWN0IGx0dG5nX3BvbGxfZXZlbnQgKmV2ZW50cywgaW50IHRpbWVvdXQpCiAJ
CUVSUigiV3JvbmcgYXJndW1lbnRzIGluIGNvbXBhdF9lcG9sbF93YWl0Iik7CiAJCWdvdG8gZXJy
b3I7CiAJfQotCWFzc2VydChldmVudHMtPm5iX2ZkID49IDApOwogCiAJaWYgKGV2ZW50cy0+bmJf
ZmQgPT0gMCkgewogCQllcnJubyA9IEVJTlZBTDsKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
