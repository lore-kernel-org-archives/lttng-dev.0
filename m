From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: ext3 was completely removed
	from the kernel in v4.3
Date: Tue, 23 May 2017 15:43:25 -0400
Message-ID: <1495568605-28541-1-git-send-email-mjeanson__607.830115086649$1495568951$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXR223DVTzyjM
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:49:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 53E2934025E
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:44:22 +0000 (UTC)
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

RG9uJ3QgZGlzcGxheSB0aGUgd2FybmluZyBhYm91dCBtaXNzaW5nIGV4dDMgaGVhZGVycyBvbiBr
ZXJuZWxzID49IDQuMwoKU2VlIHVwc3RyZWFtIGNvbW1pdCBlMzFmYjllMDA1NDNlNWQzYzViNjg2
NzQ3ZDNjODYyYmMwOWI1OWYzCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFu
c29uQGVmZmljaW9zLmNvbT4KLS0tCiBwcm9iZXMvS2J1aWxkIHwgMTQgKysrKysrKystLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvcHJvYmVzL0tidWlsZCBiL3Byb2Jlcy9LYnVpbGQKaW5kZXggNjY0NTk1ZC4uZmU4Njlk
MCAxMDA2NDQKLS0tIGEvcHJvYmVzL0tidWlsZAorKysgYi9wcm9iZXMvS2J1aWxkCkBAIC05Nywx
MyArOTcsMTUgQEAgaWZuZXEgKCQoQ09ORklHX0VYVDNfRlMpLCkKICAgZXh0M19kZXAgPSAkKHNy
Y3RyZWUpL2ZzL2V4dDMvKi5oCiAgIGV4dDNfZGVwX2NoZWNrID0gJCh3aWxkY2FyZCAkKGV4dDNf
ZGVwKSkKICAgZXh0MyA9ICQoc2hlbGwgXAotICAgIGlmIFsgJChWRVJTSU9OKSAtZ2UgNCAtbyBc
KCAkKFZFUlNJT04pIC1lcSAzIC1hICQoUEFUQ0hMRVZFTCkgLWdlIDEgXCkgXSA7IHRoZW4gXAot
ICAgICAgaWYgWyBcKCAkKFZFUlNJT04pIC1nZSA0IC1vIFwoICQoVkVSU0lPTikgLWVxIDMgLWEg
JChQQVRDSExFVkVMKSAtZ2UgNCBcKSBcKSAtYSBcCi0gICAgICAgIC16ICIkKGV4dDNfZGVwX2No
ZWNrKSIgXSA7IHRoZW4gXAotICAgICAgICBlY2hvICJ3YXJuIiA7IFwKLSAgICAgICAgZXhpdCA7
IFwKKyAgICBpZiBbICQoVkVSU0lPTikgLWx0IDQgLW8gXCggJChWRVJTSU9OKSAtZXEgNCAtYSAk
KFBBVENITEVWRUwpIC1sdCAzIFwpIF0gOyB0aGVuIFwKKyAgICAgIGlmIFsgJChWRVJTSU9OKSAt
Z2UgNCAtbyBcKCAkKFZFUlNJT04pIC1lcSAzIC1hICQoUEFUQ0hMRVZFTCkgLWdlIDEgXCkgXSA7
IHRoZW4gXAorICAgICAgICBpZiBbIFwoICQoVkVSU0lPTikgLWdlIDQgLW8gXCggJChWRVJTSU9O
KSAtZXEgMyAtYSAkKFBBVENITEVWRUwpIC1nZSA0IFwpIFwpIC1hIFwKKyAgICAgICAgICAteiAi
JChleHQzX2RlcF9jaGVjaykiIF0gOyB0aGVuIFwKKyAgICAgICAgICBlY2hvICJ3YXJuIiA7IFwK
KyAgICAgICAgICBleGl0IDsgXAorICAgICAgICBmaTsgXAorICAgICAgICBlY2hvICJsdHRuZy1w
cm9iZS1leHQzLm8iIDsgXAogICAgICAgZmk7IFwKLSAgICAgIGVjaG8gImx0dG5nLXByb2JlLWV4
dDMubyIgOyBcCiAgICAgZmk7KQogICBpZmVxICgkKGV4dDMpLHdhcm4pCiAgICAgJCh3YXJuaW5n
IEZpbGVzICQoZXh0M19kZXApIG5vdCBmb3VuZC4gUHJvYmUgImV4dDMiIGlzIGRpc2FibGVkLiBV
c2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0LikKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
