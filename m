From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: lttng-tools 2.9.0 build failures
Date: Sun, 4 Dec 2016 23:08:46 +0100
Message-ID: <20161204230846.71049716__7870.25876711613$1480889872$gmane$org@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3tX2PF181tztF2
 for <lttng-dev@lists.lttng.org>; Sun,  4 Dec 2016 22:19:27 +0000 (UTC)
Received: from localhost (LFbn-1-6691-76.w90-120.abo.wanadoo.fr
 [90.120.129.76])
 by mail.free-electrons.com (Postfix) with ESMTPSA id 2456A209CC
 for <lttng-dev@lists.lttng.org>; Sun,  4 Dec 2016 23:08:46 +0100 (CET)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGVsbG8sCgpJbiB0aGUgQnVpbGRyb290IHByb2plY3QsIHdlIHJlY2VudGx5IHVwZGF0ZWQgdG8g
bHR0bmctdG9vbHMgMi45LjAsIGFuZAp3ZSdyZSBleHBlcmllbmNpbmcgdHdvIGJ1aWxkIGZhaWx1
cmVzOgoKICogV2l0aCBhIHVDbGliYyBiYXNlZCB0b29sY2hhaW46Cgpwcm9nLmM6MjQ6MTU6IGVy
cm9yOiAnTE1fSURfQkFTRScgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24p
CiAgaDEgPSBkbG1vcGVuKExNX0lEX0JBU0UsICJsaWJmb28uc28iLCBSVExEX0xBWlkpOwoKICAg
SSBiZWxpZXZlIGRsbW9wZW4oKSBpcyBub3QgaW1wbGVtZW50ZWQgaW4gdUNsaWJjIGFuZCBtdXNs
LCBzbwogICBwZXJoYXBzIHRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgaW4gbHR0bmctdG9vbHMgYnkg
bWFraW5nIHRoZSBjb2RlCiAgIGNvbmRpdGlvbmFsLgoKICAgU2VlCiAgIGh0dHA6Ly9hdXRvYnVp
bGQuYnVpbGRyb290Lm5ldC9yZXN1bHRzL2Q4Ny9kODc0NWVmNWM4YzdkNzFmOTkzZWRmMmE4ZjNm
MTA3ZDJkMWIzNWZjL2J1aWxkLWVuZC5sb2cKICAgZm9yIHRoZSBmdWxsIGJ1aWxkIGxvZy4KCiAq
IFdpdGggYSBtdXNsIGJhc2VkIHRvb2xjaGFpbjoKCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBoZWFs
dGguYzoyNjowOgouLi8uLi8uLi9zcmMvY29tbW9uL2RlZmF1bHRzLmg6MzcwOjE6IGVycm9yOiB1
bmtub3duIHR5cGUgbmFtZSAncHRocmVhZF9hdHRyX3QnCiBwdGhyZWFkX2F0dHJfdCAqZGVmYXVs
dF9wdGhyZWFkX2F0dHIodm9pZCk7CgogICBTZWUKICAgaHR0cDovL2F1dG9idWlsZC5idWlsZHJv
b3QubmV0L3Jlc3VsdHMvMjU1LzI1NTZiMzI2NmI5MTM5NjRiZWEyNWMyMWQwMTRmNGIxYjI1YjY4
MDgvYnVpbGQtZW5kLmxvZwogICBmb3IgdGhlIGZ1bGwgYnVpbGQgbG9nLgoKQmVzdCByZWdhcmRz
LAoKVGhvbWFzCi0tIApUaG9tYXMgUGV0YXp6b25pLCBDVE8sIEZyZWUgRWxlY3Ryb25zCkVtYmVk
ZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2ZyZWUtZWxlY3Ryb25zLmNv
bQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1k
ZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
