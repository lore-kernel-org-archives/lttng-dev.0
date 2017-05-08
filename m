From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Re-add PTHREAD_CFLAGS to global CFLAGS
Date: Mon,  8 May 2017 15:54:56 -0400
Message-ID: <1494273296-19686-1-git-send-email-mjeanson__28185.6630616405$1494273342$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wMCt71xNQzDW5
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 19:55:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1995B340358
 for <lttng-dev@lists.lttng.org>; Mon,  8 May 2017 19:57:15 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Rml4ZXMgYSBidWlsZCBmYWlsdXJlIG9uIFNvbGFyaXMgYW5kIG1heWJlIG90aGVyIGVzb3Rlcmlj
IGFyY2hpdGVjdHVyZXMuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29u
QGVmZmljaW9zLmNvbT4KLS0tCiBjb25maWd1cmUuYWMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFj
CmluZGV4IDVhYTM0MzMuLjc1M2JlYzUgMTAwNjQ0Ci0tLSBhL2NvbmZpZ3VyZS5hYworKysgYi9j
b25maWd1cmUuYWMKQEAgLTkwLDYgKzkwLDggQEAgQVNfSUYoW3Rlc3QgIngkYXhfY3ZfX19hdHRy
aWJ1dGVfXyIgPSAieHllcyJdLAogCiBBWF9QVEhSRUFEKCxbQUNfTVNHX0VSUk9SKFtDb3VsZCBu
b3QgY29uZmlndXJlIHB0aHJlYWRzIHN1cHBvcnRdKV0pCiAKK0FNX0NGTEFHUz0iJEFNX0NGTEFH
UyAkUFRIUkVBRF9DRkxBR1MiCisKICMgQ2hlY2tzIGZvciBsaWJyYXJ5IGZ1bmN0aW9ucy4KIEFD
X0ZVTkNfTU1BUAogQUNfRlVOQ19GT1JLCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
