From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unchecked return value in
	trace_clock_read64_monotonic
Date: Tue, 17 May 2016 12:06:45 -0400
Message-ID: <1463501205-5249-1-git-send-email-mathieu.desnoyers__49803.850396029$1463501227$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C8574A3530
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 16:06:49 +0000 (UTC)
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

Rm91bmQgYnkgQ292ZXJpdHk6CgpDSUQgMTMxMTQ5OCAoIzEgb2YgMSk6IFVuY2hlY2tlZCByZXR1
cm4gdmFsdWUgKENIRUNLRURfUkVUVVJOKTEuCmNoZWNrX3JldHVybjogQ2FsbGluZyBjbG9ja19n
ZXR0aW1lIHdpdGhvdXQgY2hlY2tpbmcgcmV0dXJuIHZhbHVlIChhcyBpcwpkb25lIGVsc2V3aGVy
ZSA4IG91dCBvZiA5IHRpbWVzKS4KClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC91c3QtY2xvY2suaCB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1j
bG9jay5oIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtY2xvY2suaAppbmRleCA4NDkzNzM3
Li4xNGJhNzFjIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1jbG9jay5o
CisrKyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWNsb2NrLmgKQEAgLTU3LDcgKzU3LDEw
IEBAIHVpbnQ2NF90IHRyYWNlX2Nsb2NrX3JlYWQ2NF9tb25vdG9uaWModm9pZCkKIHsKIAlzdHJ1
Y3QgdGltZXNwZWMgdHM7CiAKLQljbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKTsK
KwlpZiAoY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cykpIHsKKwkJdHMudHZfc2Vj
ID0gMDsKKwkJdHMudHZfbnNlYyA9IDA7CisJfQogCXJldHVybiAoKHVpbnQ2NF90KSB0cy50dl9z
ZWMgKiAxMDAwMDAwMDAwVUxMKSArIHRzLnR2X25zZWM7CiB9CiAKLS0gCjIuMS40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
