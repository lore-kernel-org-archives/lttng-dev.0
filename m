From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Ressource leak, missing fclose
Date: Thu,  8 May 2014 17:06:22 -0400
Message-ID: <1399583182-32742-1-git-send-email-jeremie.galarneau__6629.37945821813$1399583333$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WiVWQ-0008Us-4P
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 17:06:35 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so3470004qcy.8
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 14:06:24 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rml4ZXMgY292ZXJpdHkgaXNzdWUgMTEzOTUzNi4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBH
YWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9u
L2NvbmZpZy9jb25maWcuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMgYi9zcmMvY29tbW9uL2NvbmZp
Zy9jb25maWcuYwppbmRleCBlM2ZlNzRhLi44MjlhNjQ1IDEwMDY0NAotLS0gYS9zcmMvY29tbW9u
L2NvbmZpZy9jb25maWcuYworKysgYi9zcmMvY29tbW9uL2NvbmZpZy9jb25maWcuYwpAQCAtMjM4
LDYgKzIzOCw3IEBAIGludCBjb25maWdfZ2V0X3NlY3Rpb25fZW50cmllcyhjb25zdCBjaGFyICpv
dmVycmlkZV9wYXRoLCBjb25zdCBjaGFyICpzZWN0aW9uLAogCXJldCA9IGluaV9wYXJzZV9maWxl
KGNvbmZpZ19maWxlLAogCQkJKGluaV9lbnRyeV9oYW5kbGVyKSBjb25maWdfZW50cnlfaGFuZGxl
cl9maWx0ZXIsICh2b2lkICopICZmaWx0ZXIpOwogCisJZmNsb3NlKGNvbmZpZ19maWxlKTsKIGVu
ZDoKIAlyZXR1cm4gcmV0OwogfQotLSAKMS45LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
