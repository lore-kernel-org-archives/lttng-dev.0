From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: vmalloc wrapper on kernel <
	2.6.38
Date: Tue, 26 Sep 2017 14:16:47 -0400
Message-ID: <1506449807-5880-1-git-send-email-mjeanson__18911.5373920233$1506449836$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y1q0h6Mk9zC5K
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 18:16:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 99CC73403B7
 for <lttng-dev@lists.lttng.org>; Tue, 26 Sep 2017 18:18:00 +0000 (UTC)
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

RW5zdXJlIHRoYXQgYWxsIHByb2JlcyBlbmQgdXAgaW5jbHVkaW5nIHRoZSB2bWFsbG9jIHdyYXBw
ZXIgdGhyb3VnaCB0aGUKbHR0bmctdHJhY2VyLmggaGVhZGVyIHNvIHRoZSB0cmFjZV8qKCkgc3Rh
dGljIGlubGluZXMgYXJlIGdlbmVyYXRlZAp0aHJvdWdoIGluY2x1c2lvbiBvZiBpbmNsdWRlL3Ry
YWNlL2V2ZW50cy9rbWVtLmggYmVmb3JlIHdlIGRlZmluZQpDUkVBVEVfVFJBQ0VfUE9JTlRTLgoK
U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogbHR0bmctdHJhY2VyLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL2x0dG5nLXRyYWNlci5oIGIvbHR0bmctdHJhY2VyLmgKaW5kZXggZmI3MGJh
ZC4uNTIzOWVmNyAxMDA2NDQKLS0tIGEvbHR0bmctdHJhY2VyLmgKKysrIGIvbHR0bmctdHJhY2Vy
LmgKQEAgLTM2LDYgKzM2LDcgQEAKIAogI2luY2x1ZGUgPHdyYXBwZXIvdHJhY2UtY2xvY2suaD4K
ICNpbmNsdWRlIDx3cmFwcGVyL2NvbXBpbGVyLmg+CisjaW5jbHVkZSA8d3JhcHBlci92bWFsbG9j
Lmg+CiAjaW5jbHVkZSA8bHR0bmctdHJhY2VyLWNvcmUuaD4KICNpbmNsdWRlIDxsdHRuZy1ldmVu
dHMuaD4KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
