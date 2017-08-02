From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/1] Fix: uninitialized return value
	on error path
Date: Wed,  2 Aug 2017 11:34:43 -0400
Message-ID: <20170802153443.29581-1-mathieu.desnoyers__32604.4477908455$1501688104$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xMy162Grfzf5g
 for <lttng-dev@lists.lttng.org>; Wed,  2 Aug 2017 15:34:49 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CgoqKiogQ0lEIDEzNzg4MTA6ICBVbmluaXRpYWxpemVkIHZhcmlh
YmxlcyAgKFVOSU5JVCkKL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY29udGV4dC5jOiA3MyBpbiBh
ZGRfa2N0eF9hbGxfY2hhbm5lbHMoKQoKU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMg
PG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Np
b25kL2NvbnRleHQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jb250ZXh0LmMgYi9zcmMvYmluL2x0dG5n
LXNlc3Npb25kL2NvbnRleHQuYwppbmRleCBhMmYwMjI4OC4uMWU2OGJkOGIgMTAwNjQ0Ci0tLSBh
L3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY29udGV4dC5jCisrKyBiL3NyYy9iaW4vbHR0bmctc2Vz
c2lvbmQvY29udGV4dC5jCkBAIC01NSw2ICs1NSw3IEBAIHN0YXRpYyBpbnQgYWRkX2tjdHhfYWxs
X2NoYW5uZWxzKHN0cnVjdCBsdHRfa2VybmVsX3Nlc3Npb24gKmtzZXNzaW9uLAogCQlrY3R4X2Nv
cHkgPSB0cmFjZV9rZXJuZWxfY29weV9jb250ZXh0KGtjdHgpOwogCQlpZiAoIWtjdHhfY29weSkg
ewogCQkJUEVSUk9SKCJ6bWFsbG9jIGx0dF9rZXJuZWxfY29udGV4dCIpOworCQkJcmV0ID0gLUVO
T01FTTsKIAkJCWdvdG8gZXJyb3I7CiAJCX0KIAotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
