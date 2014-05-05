From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?=
 <jeremie.galarneau@efficios.com>
Subject: [PATCH lttng-tools] Fix: Out of tree build fails in
	libconfig
Date: Mon,  5 May 2014 10:41:46 -0400
Message-ID: <1399300906-14530-1-git-send-email-jeremie.galarneau__16295.3683328398$1399403069$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WhK5Z-0001pI-VE
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 10:41:59 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so6329776qgf.7
 for <lttng-dev@lists.lttng.org>; Mon, 05 May 2014 07:41:48 -0700 (PDT)
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

bGliY29uZmlnX2xhX0NQUEZMQUdTIHNob3VsZCBhbHNvIGluY2x1ZGUgdGhlIHRvcC1sZXZlbCBB
TV9DUFBGTEFHUy4KClNpZ25lZC1vZmYtYnk6IErDqXLDqW1pZSBHYWxhcm5lYXUgPGplcmVtaWUu
Z2FsYXJuZWF1QGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvY29tbW9uL2NvbmZpZy9NYWtlZmlsZS5h
bSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3NyYy9jb21tb24vY29uZmlnL01ha2VmaWxlLmFtIGIvc3JjL2NvbW1vbi9j
b25maWcvTWFrZWZpbGUuYW0KaW5kZXggZThlYWFjYS4uMDAxNGRmZCAxMDA2NDQKLS0tIGEvc3Jj
L2NvbW1vbi9jb25maWcvTWFrZWZpbGUuYW0KKysrIGIvc3JjL2NvbW1vbi9jb25maWcvTWFrZWZp
bGUuYW0KQEAgLTMsNyArMyw3IEBAIEFNX0NQUEZMQUdTID0gLUkkKHRvcF9zcmNkaXIpL2luY2x1
ZGUgLUkkKHRvcF9zcmNkaXIpL3NyYwogbm9pbnN0X0xUTElCUkFSSUVTID0gbGliY29uZmlnLmxh
CiAKIGxpYmNvbmZpZ19sYV9TT1VSQ0VTID0gaW5pLmMgaW5pLmggY29uZmlnLmMgY29uZmlnLmgK
LWxpYmNvbmZpZ19sYV9DUFBGTEFHUyA9ICQoWE1MX0NQUEZMQUdTKQorbGliY29uZmlnX2xhX0NQ
UEZMQUdTID0gJChYTUxfQ1BQRkxBR1MpICQoQU1fQ1BQRkxBR1MpCiBsaWJjb25maWdfbGFfTElC
QUREID0gJChYTUxfTElCUykKIAogeG1sZGlyID0gJChkYXRhZGlyKS94bWwvbHR0bmcKLS0gCjEu
OS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0
cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
