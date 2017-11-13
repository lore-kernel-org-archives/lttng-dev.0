From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace stable-1.5] Fix: timegm compat on
	Solaris
Date: Mon, 13 Nov 2017 15:06:29 -0500
Message-ID: <1510603589-9901-1-git-send-email-mjeanson__37108.3261365586$1510603610$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybM9F0hskz13yd
 for <lttng-dev@lists.lttng.org>; Mon, 13 Nov 2017 20:06:40 +0000 (UTC)
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

T24gU29sYXJpcyAxMSBzZXR0aW5nIFRaIHRvIGFuIGVtcHR5IHN0cmluZyBiZWZvcmUgY2FsbGlu
ZyBta3RpbWUgd2lsbAppbiBzb21lIGNpcmN1bXN0YW5jZXMgZG8gdGhlIGNvbnZlcnNpb24gaW4g
bG9jYWx0aW1lIGluc3RlYWQgb2YgVVRDIGFzCmV4cGVjdGVkLgoKUmVwbGFjZSB0aGUgZW1wdHkg
c3RyaW5nIGJ5ICJVVEMiLgoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNv
bkBlZmZpY2lvcy5jb20+Ci0tLQogaW5jbHVkZS9iYWJlbHRyYWNlL2NvbXBhdC91dGMuaCB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3V0Yy5oIGIvaW5jbHVkZS9iYWJl
bHRyYWNlL2NvbXBhdC91dGMuaAppbmRleCBkNTlkODU2Li5hYjA4MGYyIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2JhYmVsdHJhY2UvY29tcGF0L3V0Yy5oCisrKyBiL2luY2x1ZGUvYmFiZWx0cmFjZS9j
b21wYXQvdXRjLmgKQEAgLTY3LDggKzY3LDggQEAgdGltZV90IGJhYmVsdHJhY2VfdGltZWdtKHN0
cnVjdCB0bSAqdG0pCiAJCX0KIAl9CiAKLQkvKiBUZW1wb3JhcmlseSBzZXR0aW5nIFRaIHRvIDEg
Zm9yIFVUQyAqLwotCXNldGVudigiVFoiLCAiIiwgMSk7CisJLyogVGVtcG9yYXJpbHkgc2V0dGlu
ZyBUWiB0byBVVEMgKi8KKwlzZXRlbnYoIlRaIiwgIlVUQyIsIDEpOwogCXR6c2V0KCk7CiAJcmV0
ID0gbWt0aW1lKHRtKTsKIAlpZiAodHopIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
