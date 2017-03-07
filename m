From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-modules] Fix: section mismatch warning
	caused by __exit annotation
Date: Tue,  7 Mar 2017 09:12:31 -0500
Message-ID: <1488895951-12544-1-git-send-email-francis.deslauriers__11049.4827539243$1488896001$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vczCb0T26zl9F
 for <lttng-dev@lists.lttng.org>; Tue,  7 Mar 2017 14:13:30 +0000 (UTC)
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

bHR0bmdfbG9nZ2VyX2V4aXQgaXMgdXNlZCBpbiBhIG5vbi1leGl0IGZ1bmN0aW9uIHNvIGl0IGNh
biBub3QgYmUKYW5ub3RhdGVkIHdpdGggYF9fZXhpdGAKClNpZ25lZC1vZmYtYnk6IEZyYW5jaXMg
RGVzbGF1cmllcnMgPGZyYW5jaXMuZGVzbGF1cmllcnNAZWZmaWNpb3MuY29tPgotLS0KIHByb2Jl
cy9sdHRuZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcHJvYmVzL2x0dG5nLmMgYi9wcm9iZXMvbHR0bmcuYwppbmRl
eCA1OGFhNTE1Li44ODEwZmEyIDEwMDY0NAotLS0gYS9wcm9iZXMvbHR0bmcuYworKysgYi9wcm9i
ZXMvbHR0bmcuYwpAQCAtMTI5LDcgKzEyOSw3IEBAIGVycm9yOgogCXJldHVybiByZXQ7CiB9CiAK
LXZvaWQgX19leGl0IGx0dG5nX2xvZ2dlcl9leGl0KHZvaWQpCit2b2lkIGx0dG5nX2xvZ2dlcl9l
eGl0KHZvaWQpCiB7CiAJX19sdHRuZ19ldmVudHNfZXhpdF9fbHR0bmcoKTsKIAlpZiAobHR0bmdf
bG9nZ2VyX2RlbnRyeSkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
