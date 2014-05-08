From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Print an error message when a
	session fails to load
Date: Thu,  8 May 2014 12:13:05 -0400
Message-ID: <1399565585-25513-1-git-send-email-jeremie.galarneau__3227.79372004351$1399565667$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WiQwb-0006si-3O
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 12:13:17 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so3093634qgf.3
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 09:13:07 -0700 (PDT)
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

U2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uZmlnL2NvbmZpZy5jIHwgNSArKysrKwogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29u
ZmlnL2NvbmZpZy5jIGIvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKaW5kZXggZGY2ZjZhMy4u
YjhhMzJlNiAxMDA2NDQKLS0tIGEvc3JjL2NvbW1vbi9jb25maWcvY29uZmlnLmMKKysrIGIvc3Jj
L2NvbW1vbi9jb25maWcvY29uZmlnLmMKQEAgLTIzMDUsNiArMjMwNSwxMSBAQCBkb21haW5faW5p
dF9lcnJvcjoKIAkJfQogCX0KIGVuZDoKKwlpZiAocmV0IDwgMCkgeworCQlFUlIoIkZhaWxlZCB0
byBsb2FkIHNlc3Npb24gJXM6ICVzIiwgbmFtZSwgbHR0bmdfc3RyZXJyb3IocmV0KSk7CisJCWx0
dG5nX2Rlc3Ryb3lfc2Vzc2lvbihuYW1lKTsKKwl9CisKIAlmcmVlKGtlcm5lbF9kb21haW4pOwog
CWZyZWUodXN0X2RvbWFpbik7CiAJZnJlZShqdWxfZG9tYWluKTsKLS0gCjEuOS4yCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcv
Y2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
