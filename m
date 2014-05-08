From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Possible out-of-bounds read
Date: Thu,  8 May 2014 17:05:55 -0400
Message-ID: <1399583155-32690-1-git-send-email-jeremie.galarneau__45643.0664090023$1399583235$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WiVW0-0008UG-2L
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 17:06:09 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so3094847qab.4
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 14:05:58 -0700 (PDT)
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

Rml4ZXMgY292ZXJpdHkgaXNzdWUgMTE5MTc1Ny4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBH
YWxhcm5lYXUgPGplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9u
L2NvbmZpZy9jb25maWcuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29uZmlnL2NvbmZpZy5jIGIv
c3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKaW5kZXggYjhhMzJlNi4uZTNmZTc0YSAxMDA2NDQK
LS0tIGEvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKKysrIGIvc3JjL2NvbW1vbi9jb25maWcv
Y29uZmlnLmMKQEAgLTI0MzYsNyArMjQzNiw3IEBAIGludCBsb2FkX3Nlc3Npb25fZnJvbV9wYXRo
KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnNlc3Npb25fbmFtZSwKIAkJCQljb250aW51
ZTsKIAkJCX0KIAotCQkJaWYgKHBhdGhfbGVuICsgZmlsZV9uYW1lX2xlbiA+IFBBVEhfTUFYKSB7
CisJCQlpZiAocGF0aF9sZW4gKyBmaWxlX25hbWVfbGVuID49IFBBVEhfTUFYKSB7CiAJCQkJY29u
dGludWU7CiAJCQl9CiAKLS0gCjEuOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
