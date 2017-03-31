From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-modules 10/10] callstack context: bump
	number of entries to 128
Date: Fri, 31 Mar 2017 09:17:19 -0400
Message-ID: <1490966239-21284-11-git-send-email-mathieu.desnoyers__250.973625998263$1490966474$gmane$org@efficios.com>
References: <1490966239-21284-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3vvhrK4tj1zw3M
 for <lttng-dev@lists.lttng.org>; Fri, 31 Mar 2017 13:17:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 24D14340259
 for <lttng-dev@lists.lttng.org>; Fri, 31 Mar 2017 13:18:36 +0000 (UTC)
In-Reply-To: <1490966239-21284-1-git-send-email-mathieu.desnoyers@efficios.com>
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

VXNlIGEgbGltaXQgdGhhdCBmaXRzIGluIGEgNDA5NiBieXRlcyBwYWdlIG9uIGEgNjQtYml0IHN5
c3RlbS4gVGhlIG9ubHkKcmVhc29uIGZvciB0aGUgcHJpb3IgMjUgZW50cmllcyBsaW1pdGF0aW9u
IHdhcyBhIGJ1ZyBpbiB0aGUgaGVhZGVyIHNpemUKY2FsY3VsYXRpb24gKG5vdyBmaXhlZCkuCgpT
aWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNp
b3MuY29tPgotLS0KIGx0dG5nLWNvbnRleHQtY2FsbHN0YWNrLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbHR0
bmctY29udGV4dC1jYWxsc3RhY2suYyBiL2x0dG5nLWNvbnRleHQtY2FsbHN0YWNrLmMKaW5kZXgg
YmRjMTc2MS4uZmQ3MzBiYiAxMDA2NDQKLS0tIGEvbHR0bmctY29udGV4dC1jYWxsc3RhY2suYwor
KysgYi9sdHRuZy1jb250ZXh0LWNhbGxzdGFjay5jCkBAIC0zMiw3ICszMiw3IEBACiAgKgogICog
ICBzaXplID0gY3B1cyAqIG5lc3QgKiBkZXB0aCAqIHNpemVvZih1bnNpZ25lZCBsb25nKQogICoK
LSAqIFdoaWNoIGlzIGFib3V0IDgwMCBieXRlcyBwZXIgQ1BVIG9uIDY0LWJpdCBob3N0IGFuZCBh
IGRlcHRoIG9mIDI1LgorICogV2hpY2ggaXMgNDA5NiBieXRlcyBwZXIgQ1BVIG9uIDY0LWJpdCBo
b3N0IGFuZCBhIGRlcHRoIG9mIDEyOC4KICAqIFRoZSBhbGxvY2F0aW9uIGlzIGRvbmUgYXQgdGhl
IGluaXRpYWxpemF0aW9uIHRvIGF2b2lkIG1lbW9yeQogICogYWxsb2NhdGlvbiBvdmVyaGVhZCB3
aGlsZSB0cmFjaW5nLCB1c2luZyBhIHNoYWxsb3cgc3RhY2suCiAgKgpAQCAtNjIsNyArNjIsNyBA
QAogI2luY2x1ZGUgIndyYXBwZXIvdm1hbGxvYy5oIgogI2luY2x1ZGUgImx0dG5nLXRyYWNlci5o
IgogCi0jZGVmaW5lIE1BWF9FTlRSSUVTIDI1CisjZGVmaW5lIE1BWF9FTlRSSUVTIDEyOAogCiBl
bnVtIGx0dG5nX2NzX2N0eF9tb2RlcyB7CiAJQ0FMTFNUQUNLX0tFUk5FTCA9IDAsCi0tIAoyLjEu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
