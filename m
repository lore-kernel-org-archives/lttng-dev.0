From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 1/3] Clarify that unlisted enum values
 are implementation-defined
Date: Thu, 23 Apr 2020 16:52:24 -0400
Message-ID: <20200423205226.496-2-mathieu.desnoyers@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497Tyd0j89z1jcp
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 16:52:40 -0400 (EDT)
In-Reply-To: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: gbastien+lttng@versatic.net, matthew.khouzam@ericsson.com, diamon-discuss@linuxfoundation.org, pproulx@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogR2VuZXZpw6h2ZSBCYXN0aWVuIDxnYmFzdGllbitsdHRuZ0B2ZXJzYXRpYy5uZXQ+CgpT
aWduZWQtb2ZmLWJ5OiBHZW5ldmnDqHZlIEJhc3RpZW4gPGdiYXN0aWVuK2x0dG5nQHZlcnNhdGlj
Lm5ldD4KU2lnbmVkLW9mZi1ieTogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4KLS0tCiBjb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQg
fCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Nv
bW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZCBiL2NvbW1vbi10cmFjZS1mb3JtYXQt
c3BlY2lmaWNhdGlvbi5tZAppbmRleCBmZDQ5ZTU5Li5mNWZlYTUxIDEwMDY0NAotLS0gYS9jb21t
b24tdHJhY2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQKKysrIGIvY29tbW9uLXRyYWNlLWZvcm1h
dC1zcGVjaWZpY2F0aW9uLm1kCkBAIC00NjQsNiArNDY0LDkgQEAgZW51bSB7CiB9CiB+fn4KIAor
VGhlIG1hcHBpbmdzIGluIHRoZSBlbnVtZXJhdGlvbiB0eXBlIGRvIG5vdCBoYXZlIHRvIGJlIGV4
aGF1c3RpdmUuCitVbmxpc3RlZCB2YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9uIGRlZmluZWQuCisK
ICMjIyA0LjIgQ29tcG91bmQgdHlwZXMKIAogQ29tcG91bmQgYXJlIGFnZ3JlZ2F0aW9uIG9mIHR5
cGUgZGVjbGFyYXRpb25zLiBDb21wb3VuZCB0eXBlcyBpbmNsdWRlCi0tIAoyLjExLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
