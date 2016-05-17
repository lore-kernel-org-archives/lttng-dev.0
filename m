From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: Deference after null check in
	sessiond set_option
Date: Tue, 17 May 2016 09:32:46 -0400
Message-ID: <1463491966-25175-1-git-send-email-mathieu.desnoyers__37731.4607183964$1463491999$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A1C08A350E
 for <lttng-dev@lists.lttng.org>; Tue, 17 May 2016 13:32:51 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Rm91bmQgYnkgQ292ZXJpdHk6CgoyLiB2YXJfY29tcGFyZV9vcDogQ29tcGFyaW5nIGFyZyB0byBu
dWxsIGltcGxpZXMgdGhhdCBhcmcgbWlnaHQgYmUgbnVsbC4KCkNJRCAxMjU2MTM3ICgjMSBvZiA5
KTogRGVyZWZlcmVuY2UgYWZ0ZXIgbnVsbCBjaGVjayAoRk9SV0FSRF9OVUxMKTE0Lgp2YXJfZGVy
ZWZfbW9kZWw6IFBhc3NpbmcgbnVsbCBwb2ludGVyIGFyZyB0byBzdHJkdXAsIHdoaWNoIGRlcmVm
ZXJlbmNlcwppdC4KClsuLi4gc2FtZSBmb3IgIzIgdGhyb3VnaCAjOSBdCgpTaWduZWQtb2ZmLWJ5
OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgotLS0K
IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvbWFpbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9tYWluLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwppbmRleCA2MDgx
ZmIyLi5iZGYyYTc0IDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwor
KysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL21haW4uYwpAQCAtNDY3MSw3ICs0NjcxLDcgQEAg
c3RhdGljIGludCBzZXRfb3B0aW9uKGludCBvcHQsIGNvbnN0IGNoYXIgKmFyZywgY29uc3QgY2hh
ciAqb3B0bmFtZSkKIHsKIAlpbnQgcmV0ID0gMDsKIAotCWlmIChhcmcgJiYgYXJnWzBdID09ICdc
MCcpIHsKKwlpZiAoIWFyZyB8fCBhcmdbMF0gPT0gJ1wwJykgewogCQkvKgogCQkgKiBUaGlzIG9u
bHkgaGFwcGVucyBpZiB0aGUgdmFsdWUgaXMgcmVhZCBmcm9tIGRhZW1vbiBjb25maWcKIAkJICog
ZmlsZS4gVGhpcyBtZWFucyB0aGUgb3B0aW9uIHJlcXVpcmVzIGFuIGFyZ3VtZW50IGFuZCB0aGUK
LS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
