From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Clean-up: remove unused variables
 to silence gcc warning
Date: Fri, 5 May 2017 16:03:30 +0000 (UTC)
Message-ID: <1019916252.29021.1494000210509.JavaMail.zimbra__4202.16742572865$1494000104$gmane$org@efficios.com>
References: <20170505155207.22687-1-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKGqy2yxDzDS2
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 16:02:22 +0000 (UTC)
In-Reply-To: <20170505155207.22687-1-jeremie.galarneau@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBNYXkgNSwgMjAxNywgYXQgMTE6NTIg
QU0sIEplcmVtaWUgR2FsYXJuZWF1IGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSB3cm90
ZToKCj4gR0NDIDYuMy4xIHdhcm5zIHRoYXQgdHdvIHZhcmlhYmxlcyAod3JpdGVfb2Zmc2V0IGFu
ZCBjb25zdW1lZF9jdXIpCj4gaW4gbGliX3JpbmdfYnVmZmVyX3NuYXBzaG90X3NhbXBsZV9wb3Np
dGlvbnMoKSBhcmUgdW51c2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5l
YXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KPiAtLS0KPiBsaWJyaW5nYnVmZmVy
L3JpbmdfYnVmZmVyX2Zyb250ZW5kLmMgfCAxIC0KPiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQo+IAo+IGRpZmYgLS1naXQgYS9saWJyaW5nYnVmZmVyL3JpbmdfYnVmZmVyX2Zyb250ZW5k
LmMKPiBiL2xpYnJpbmdidWZmZXIvcmluZ19idWZmZXJfZnJvbnRlbmQuYwo+IGluZGV4IDliMTY2
ODUyLi45ZWNkYzE1NyAxMDA2NDQKPiAtLS0gYS9saWJyaW5nYnVmZmVyL3JpbmdfYnVmZmVyX2Zy
b250ZW5kLmMKPiArKysgYi9saWJyaW5nYnVmZmVyL3JpbmdfYnVmZmVyX2Zyb250ZW5kLmMKPiBA
QCAtMTMyMyw3ICsxMzIzLDYgQEAgaW50IGxpYl9yaW5nX2J1ZmZlcl9zbmFwc2hvdF9zYW1wbGVf
cG9zaXRpb25zKAo+IHsKPiAJc3RydWN0IGNoYW5uZWwgKmNoYW47Cj4gCWNvbnN0IHN0cnVjdCBs
dHRuZ191c3RfbGliX3JpbmdfYnVmZmVyX2NvbmZpZyAqY29uZmlnOwo+IC0JdW5zaWduZWQgbG9u
ZyBjb25zdW1lZF9jdXIsIHdyaXRlX29mZnNldDsKPiAKPiAJY2hhbiA9IHNobXAoaGFuZGxlLCBi
dWYtPmJhY2tlbmQuY2hhbik7Cj4gCWlmICghY2hhbikKPiAtLQo+IDIuMTIuMgoKLS0gCk1hdGhp
ZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
