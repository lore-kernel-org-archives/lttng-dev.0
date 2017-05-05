From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: remove CONFIG_KALLSYMS_ALL
	warning on clean
Date: Fri,  5 May 2017 12:08:07 -0400
Message-ID: <1494000487-27369-1-git-send-email-mjeanson__16568.3270468891$1494000508$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wKGzj5n9fzDSv
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 16:09:05 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9690234034B
 for <lttng-dev@lists.lttng.org>; Fri,  5 May 2017 16:10:19 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogcHJvYmVzL0tidWlsZCB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Byb2Jlcy9LYnVpbGQgYi9wcm9iZXMvS2J1
aWxkCmluZGV4IGJmMTRjNzUuLmE0ZjZiMzIgMTAwNjQ0Ci0tLSBhL3Byb2Jlcy9LYnVpbGQKKysr
IGIvcHJvYmVzL0tidWlsZApAQCAtMjQzLDcgKzI0Myw5IEBAIGlmbmVxICgkKENPTkZJR19LQUxM
U1lNU19BTEwpLCkKICAgICAgIC1vIFwoICQoVkVSU0lPTikgLWVxIDIgLWEgJChQQVRDSExFVkVM
KSAtZXEgNiAtYSAkKFNVQkxFVkVMKSAtZ2UgMzYgXCkgXSA7IHRoZW4gXAogICAgICAgZWNobyAi
bHR0bmctcHJvYmUtd3JpdGViYWNrLm8iIDsgZmk7KQogZWxzZQotICAkKHdhcm5pbmcgQ09ORklH
X0tBTExTWU1TX0FMTCBpcyBkaXNhYmxlZCwgdGhlcmVmb3JlIHByb2JlICJ3cml0ZWJhY2siIGlz
IGRpc2FibGVkLiBSZWJ1aWxkIHlvdXIga2VybmVsIHdpdGggdGhpcyBjb25maWd1cmF0aW9uIG9w
dGlvbiBlbmFibGVkIGluIG9yZGVyIHRvIHRyYWNlIHRoaXMgc3Vic3lzdGVtLikKKyAgaWZkZWYg
Q09ORklHX0xPQ0FMVkVSU0lPTiAjIENoZWNrIGlmIGRvdC1jb25maWcgaXMgaW5jbHVkZWQuCisg
ICAgJCh3YXJuaW5nIENPTkZJR19LQUxMU1lNU19BTEwgaXMgZGlzYWJsZWQsIHRoZXJlZm9yZSBw
cm9iZSAid3JpdGViYWNrIiBpcyBkaXNhYmxlZC4gUmVidWlsZCB5b3VyIGtlcm5lbCB3aXRoIHRo
aXMgY29uZmlndXJhdGlvbiBvcHRpb24gZW5hYmxlZCBpbiBvcmRlciB0byB0cmFjZSB0aGlzIHN1
YnN5c3RlbS4pCisgIGVuZGlmCiBlbmRpZiAjIENPTkZJR19LQUxMU1lNU19BTEwKIAogaWZuZXEg
KCQoQ09ORklHX0tQUk9CRVMpLCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
