From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 2/3] Port: Use glib g_mkdir
Date: Thu, 15 Sep 2016 12:14:42 -0400
Message-ID: <1473956083-25901-2-git-send-email-mjeanson__22876.3097934008$1473956193$gmane$org@efficios.com>
References: <1473956083-25901-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6E46CA42C5
 for <lttng-dev@lists.lttng.org>; Thu, 15 Sep 2016 16:17:04 +0000 (UTC)
In-Reply-To: <1473956083-25901-1-git-send-email-mjeanson@efficios.com>
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
LQogY29udmVydGVyL2JhYmVsdHJhY2UtbG9nLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb252ZXJ0ZXIv
YmFiZWx0cmFjZS1sb2cuYyBiL2NvbnZlcnRlci9iYWJlbHRyYWNlLWxvZy5jCmluZGV4IDhjYjM1
ZDEuLjNkZTJkYmMgMTAwNjQ0Ci0tLSBhL2NvbnZlcnRlci9iYWJlbHRyYWNlLWxvZy5jCisrKyBi
L2NvbnZlcnRlci9iYWJlbHRyYWNlLWxvZy5jCkBAIC0zOCw2ICszOCw4IEBACiAjaW5jbHVkZSA8
ZXJybm8uaD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxpbnR0eXBlcy5oPgorI2lu
Y2x1ZGUgPGdsaWIuaD4KKyNpbmNsdWRlIDxnbGliL2dzdGRpby5oPgogCiAjaW5jbHVkZSA8YmFi
ZWx0cmFjZS9iYWJlbHRyYWNlLWludGVybmFsLmg+CiAjaW5jbHVkZSA8YmFiZWx0cmFjZS9jdGYv
dHlwZXMuaD4KQEAgLTQwMSw5ICs0MDMsOSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpCiAJCWV4aXQoRVhJVF9TVUNDRVNTKTsKIAl9CiAKLQlyZXQgPSBta2RpcihzX291dHB1dG5h
bWUsIFNfSVJXWFV8U19JUldYRyk7CisJcmV0ID0gZ19ta2RpcihzX291dHB1dG5hbWUsIFNfSVJX
WFV8U19JUldYRyk7CiAJaWYgKHJldCkgewotCQlwZXJyb3IoIm1rZGlyIik7CisJCXBlcnJvcigi
Z19ta2RpciIpOwogCQlnb3RvIGVycm9yOwogCX0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QK
bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmlu
L21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
