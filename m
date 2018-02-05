From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Document add-context limitation
	for started session
Date: Mon,  5 Feb 2018 18:19:01 -0500
Message-ID: <1517872741-18065-2-git-send-email-jonathan.rajotte-julien__10943.7168729075$1517872653$gmane$org@efficios.com>
References: <1517872741-18065-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zb3Sd0sNHzpLh
 for <lttng-dev@lists.lttng.org>; Mon,  5 Feb 2018 23:19:12 +0000 (UTC)
In-Reply-To: <1517872741-18065-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
ZWZmaWNpb3MuY29tPgotLS0KIGRvYy9tYW4vbHR0bmctYWRkLWNvbnRleHQuMS50eHQgfCAxMSAr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kb2MvbWFuL2x0dG5nLWFkZC1jb250ZXh0LjEudHh0IGIvZG9jL21hbi9sdHRuZy1hZGQtY29u
dGV4dC4xLnR4dAppbmRleCBlM2M4ODEzLi5mYWIxNTc1IDEwMDY0NAotLS0gYS9kb2MvbWFuL2x0
dG5nLWFkZC1jb250ZXh0LjEudHh0CisrKyBiL2RvYy9tYW4vbHR0bmctYWRkLWNvbnRleHQuMS50
eHQKQEAgLTc5LDYgKzc5LDkgQEAgbW9zdCBzaGVsbHMuCiBVc2UgdGhlIG9wdGlvbjotLWxpc3Qg
b3B0aW9uIHdpdGhvdXQgb3RoZXIgYXJndW1lbnRzIHRvIGxpc3QgdGhlCiBhdmFpbGFibGUgY29u
dGV4dCBmaWVsZCBuYW1lcy4KIAorU2VlIHRoZSA8PGxpbWl0YXRpb25zLExJTUlUQVRJT05TPj4g
c2VjdGlvbiBiZWxvdyBmb3IgYSBsaXN0IG9mCitsaW1pdGF0aW9ucyBvZiB0aGlzIGNvbW1hbmQg
dG8gY29uc2lkZXIuCisKIAogaW5jbHVkZTo6Y29tbW9uLWNtZC1vcHRpb25zLWhlYWQudHh0W10K
IApAQCAtMTIzLDYgKzEyNiwxNCBAQCBvcHRpb246LXQgJ1RZUEUnLCBvcHRpb246LS10eXBlPSdU
WVBFJzo6CiAKIGluY2x1ZGU6OmNvbW1vbi1jbWQtaGVscC1vcHRpb25zLnR4dFtdCiAKK1tbbGlt
aXRhdGlvbnNdXQorTElNSVRBVElPTlMKKy0tLS0tLS0tLS0tCitBcyBvZiB0aGlzIHZlcnNpb24g
b2YgTFRUbmcsIGl0IGlzIG5vdCBwb3NzaWJsZSB0byBwZXJmb3JtIHRoZSBmb2xsb3dpbmcKK2Fj
dGlvbnMgd2l0aCB0aGUgYGx0dG5nIGFkZC1jb250ZXh0YCBjb21tYW5kOgorCisqIEFkZCBhIGNv
bnRleHQgb25jZSBpdHMgdHJhY2luZyBzZXNzaW9uIGhhcyBiZWVuIGFjdGl2ZQorICBhdCBsZWFz
dCBvbmNlLgogCiBpbmNsdWRlOjpjb21tb24tY21kLWZvb3Rlci50eHRbXQogCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
