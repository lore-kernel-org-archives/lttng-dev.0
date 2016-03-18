From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Use get_domain_str on add
	context
Date: Fri, 18 Mar 2016 18:47:53 -0400
Message-ID: <56EC8599.3090205__42842.1999830336$1458341298$gmane$org@efficios.com>
References: <1458339923-7955-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 32AD0A2D68
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2016 22:47:56 +0000 (UTC)
In-Reply-To: <1458339923-7955-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U29ycnkgZG91YmxlIHNlbmQuCgpDaGVlcnMKCk9uIDIwMTYtMDMtMTggMDY6MjUgUE0sIEpvbmF0
aGFuIFJham90dGUgd3JvdGU6Cj4gRml4ZXMgIzEwMDYKPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0
aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiAgIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRkX2NvbnRleHQuYyB8IDQgKystLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2FkZF9jb250ZXh0LmMgYi9zcmMvYmluL2x0dG5n
L2NvbW1hbmRzL2FkZF9jb250ZXh0LmMKPiBpbmRleCBhNmQ3M2EwLi5mNzdlZGIxIDEwMDY0NAo+
IC0tLSBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvYWRkX2NvbnRleHQuYwo+ICsrKyBiL3NyYy9i
aW4vbHR0bmcvY29tbWFuZHMvYWRkX2NvbnRleHQuYwo+IEBAIC02NjEsMTEgKzY2MSwxMSBAQCBz
dGF0aWMgaW50IGFkZF9jb250ZXh0KGNoYXIgKnNlc3Npb25fbmFtZSkKPiAgIAkJfSBlbHNlIHsK
PiAgIAkJCWlmIChvcHRfY2hhbm5lbF9uYW1lKSB7Cj4gICAJCQkJTVNHKCIlcyBjb250ZXh0ICVz
IGFkZGVkIHRvIGNoYW5uZWwgJXMiLAo+IC0JCQkJCQlvcHRfa2VybmVsID8gImtlcm5lbCIgOiAi
VVNUIiwgdHlwZS0+b3B0LT5zeW1ib2wsCj4gKwkJCQkJCWdldF9kb21haW5fc3RyKGRvbS50eXBl
KSwgdHlwZS0+b3B0LT5zeW1ib2wsCj4gICAJCQkJCQlvcHRfY2hhbm5lbF9uYW1lKTsKPiAgIAkJ
CX0gZWxzZSB7Cj4gICAJCQkJTVNHKCIlcyBjb250ZXh0ICVzIGFkZGVkIHRvIGFsbCBjaGFubmVs
cyIsCj4gLQkJCQkJCW9wdF9rZXJuZWwgPyAia2VybmVsIiA6ICJVU1QiLCB0eXBlLT5vcHQtPnN5
bWJvbCkKPiArCQkJCQkJZ2V0X2RvbWFpbl9zdHIoZG9tLnR5cGUpLCB0eXBlLT5vcHQtPnN5bWJv
bCkKPiAgIAkJCX0KPiAgIAkJCXN1Y2Nlc3MgPSAxOwo+ICAgCQl9CgotLSAKSm9uYXRoYW4gUi4g
SnVsaWVuCkVmZmljaW9zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
