From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: null pointer dereference
Date: Tue, 10 Apr 2018 16:33:32 -0400
Message-ID: <1523392412-1379-1-git-send-email-jonathan.rajotte-julien__9247.25610898367$1523392309$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40LJm43sMBzy5w
 for <lttng-dev@lists.lttng.org>; Tue, 10 Apr 2018 16:33:40 -0400 (EDT)
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

U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9saWIvbHR0bmctY3RsL3JvdGF0ZS5jIHwgNyArKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NyYy9saWIvbHR0bmctY3RsL3JvdGF0ZS5jIGIvc3JjL2xpYi9sdHRuZy1jdGwvcm90
YXRlLmMKaW5kZXggYmRjZThkOC4uZTM0MDQyOSAxMDA2NDQKLS0tIGEvc3JjL2xpYi9sdHRuZy1j
dGwvcm90YXRlLmMKKysrIGIvc3JjL2xpYi9sdHRuZy1jdGwvcm90YXRlLmMKQEAgLTI2OCw4ICsy
NjgsMTEgQEAgZW5kOgogdm9pZCBsdHRuZ19yb3RhdGlvbl9oYW5kbGVfZGVzdHJveSgKIAkJc3Ry
dWN0IGx0dG5nX3JvdGF0aW9uX2hhbmRsZSAqcm90YXRpb25faGFuZGxlKQogewotCWx0dG5nX3Ry
YWNlX2FyY2hpdmVfbG9jYXRpb25fZGVzdHJveShyb3RhdGlvbl9oYW5kbGUtPmFyY2hpdmVfbG9j
YXRpb24pOwotCWZyZWUocm90YXRpb25faGFuZGxlKTsKKwlpZiAocm90YXRpb25faGFuZGxlKSB7
CisJCWx0dG5nX3RyYWNlX2FyY2hpdmVfbG9jYXRpb25fZGVzdHJveShyb3RhdGlvbl9oYW5kbGUt
PmFyY2hpdmVfbG9jYXRpb24pOworCQlmcmVlKHJvdGF0aW9uX2hhbmRsZSk7CisJCXJvdGF0aW9u
X2hhbmRsZSA9IE5VTEw7CisJfQogfQogCiBzdGF0aWMKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0
Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
