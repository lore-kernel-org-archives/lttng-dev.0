From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/2] Port: add cygwin support to
	endian compat
Date: Thu, 26 Jan 2017 15:09:21 -0500
Message-ID: <1485461362-31301-1-git-send-email-mjeanson__31993.9709654593$1485461408$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v8Y3w5QG1zjvl
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jan 2017 20:12:12 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogc3JjL2NvbW1vbi9jb21wYXQvZW5kaWFuLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvY29tbW9uL2NvbXBh
dC9lbmRpYW4uaCBiL3NyYy9jb21tb24vY29tcGF0L2VuZGlhbi5oCmluZGV4IDRlZGMxMjQuLjY0
MjdmZWIgMTAwNjQ0Ci0tLSBhL3NyYy9jb21tb24vY29tcGF0L2VuZGlhbi5oCisrKyBiL3NyYy9j
b21tb24vY29tcGF0L2VuZGlhbi5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaWZuZGVmIF9DT01QQVRf
RU5ESUFOX0gKICNkZWZpbmUgX0NPTVBBVF9FTkRJQU5fSAogCi0jaWZkZWYgX19saW51eF9fCisj
aWYgZGVmaW5lZChfX2xpbnV4X18pIHx8IGRlZmluZWQoX19DWUdXSU5fXykKICNpbmNsdWRlIDxl
bmRpYW4uaD4KIAogLyoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
