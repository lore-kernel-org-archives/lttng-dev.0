From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Static build on OS X
Date: Wed, 4 May 2016 15:57:20 +0000 (UTC)
Message-ID: <1502003478.731.1462377440298.JavaMail.zimbra__46660.6525624686$1462377465$gmane$org@efficios.com>
References: <1462373695-15432-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 48E39A0A23
 for <lttng-dev@lists.lttng.org>; Wed,  4 May 2016 15:57:25 +0000 (UTC)
In-Reply-To: <1462373695-15432-1-git-send-email-mjeanson@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWF5IDQsIDIwMTYsIGF0IDEwOjU0IEFNLCBNaWNoYWVsIEplYW5zb24gbWplYW5z
b25AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBUaGUgT1MgWCBsaW5rZXIgZmFpbHMgdG8gcmVzb2x2
ZSBjb21tb24gc3ltYm9scyBpbiBhIHN0YXRpYwo+IGxpYnJhcnkgZm9yIHNvbWUgdW5leHBsYWlu
ZWQgcmVhc29uLiBJbml0aWFsaXppbmcgdGhlIHZhcmlhYmxlcwo+IHRvIHplcm8gbWFrZXMgdGhl
IHN5bWJvbCBiZWNvbWUgdW5pbml0aWFsaXplZCBkYXRhIGFuZCBmaXhlcwo+IHRoZSBsaW5raW5n
LgoKV2UgZG9uJ3QgaW5pdGlhbGl6ZSBzdGF0aWMvZ2xvYmFsIHZhcmlhYmxlcyB0byAwL05VTEwg
ZXZlciBpbiBvdXIKY29kaW5nIHN0eWxlLCBwcmVzdW1pbmcgdGhleSBhcmUgemVyb2VkIChzaW1p
bGFybHkgdG8gdGhlIGtlcm5lbApjb2Rpbmcgc3R5bGUpLgoKV2h5IHNob3VsZCB3ZSBkaXZlcmdl
IGZyb20gdGhpcyBjb2Rpbmcgc3R5bGUgaW4gdGhpcyBzcGVjaWZpYyBpbnN0YW5jZSA/CldoeSBu
b3QgZWxzZXdoZXJlID8KClRoYW5rcywKCk1hdGhpZXUKCj4gCj4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gbGliL2JhYmVsdHJh
Y2UuYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGliL2JhYmVsdHJhY2UuYyBiL2xpYi9iYWJlbHRyYWNlLmMK
PiBpbmRleCAwYmNmZDFkLi5mMDU4MDhkIDEwMDY0NAo+IC0tLSBhL2xpYi9iYWJlbHRyYWNlLmMK
PiArKysgYi9saWIvYmFiZWx0cmFjZS5jCj4gQEAgLTMxLDcgKzMxLDcgQEAKPiAjaW5jbHVkZSA8
YmFiZWx0cmFjZS9jdGYtdGV4dC90eXBlcy5oPgo+ICNpbmNsdWRlIDxzdGRsaWIuaD4KPiAKPiAt
aW50IGJhYmVsdHJhY2VfdmVyYm9zZSwgYmFiZWx0cmFjZV9kZWJ1ZzsKPiAraW50IGJhYmVsdHJh
Y2VfdmVyYm9zZSA9IDAsIGJhYmVsdHJhY2VfZGVidWcgPSAwOwo+IAo+IHN0YXRpYwo+IHZvaWQg
X19hdHRyaWJ1dGVfXygoY29uc3RydWN0b3IpKSBpbml0X2JhYmVsdHJhY2VfbGliKHZvaWQpCj4g
LS0KPiAyLjcuNAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVm
ZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
