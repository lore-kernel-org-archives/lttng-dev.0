From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH lttng-tools 2/5] Fix: should pass the
	reg_enum_lookup pointer directly
Date: Wed,  7 Feb 2018 14:36:56 -0500
Message-ID: <1518032219-28072-3-git-send-email-francis.deslauriers__7024.50822941518$1518032770$gmane$org@efficios.com>
References: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zcBfr0gPCzCDJ
 for <lttng-dev@lists.lttng.org>; Wed,  7 Feb 2018 19:47:00 +0000 (UTC)
In-Reply-To: <1518032219-28072-1-git-send-email-francis.deslauriers@efficios.com>
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

QXMgdGhlIGh0X2hhc2hfZW51bSBhbmQgaHRfbWF0Y2hfZW51bSBmdW5jdGlvbnMgYXJlIG5vdCBj
aGFuZ2luZyB0aGUKcG9pbnRlciB0aGVyZSBpcyBubyBuZWVkIHRvIHBhc3MgdGhlIGFkZHJlc3Mg
b2YgdGhlIHBvaW50ZXIuCgpTaWduZWQtb2ZmLWJ5OiBGcmFuY2lzIERlc2xhdXJpZXJzIDxmcmFu
Y2lzLmRlc2xhdXJpZXJzQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMvYmluL2x0dG5nLXNlc3Npb25k
L3VzdC1yZWdpc3RyeS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0
LXJlZ2lzdHJ5LmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1yZWdpc3RyeS5jCmluZGV4
IGUzMzZiOWUuLmNkNmZkYWMgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0
LXJlZ2lzdHJ5LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtcmVnaXN0cnkuYwpA
QCAtNTU4LDggKzU1OCw4IEBAIHN0cnVjdCB1c3RfcmVnaXN0cnlfZW51bSAqCiAJc3RydWN0IGx0
dG5nX2h0X2l0ZXIgaXRlcjsKIAogCWNkc19sZmh0X2xvb2t1cChzZXNzaW9uLT5lbnVtcy0+aHQs
Ci0JCQlodF9oYXNoX2VudW0oKHZvaWQgKikgJnJlZ19lbnVtX2xvb2t1cCwgbHR0bmdfaHRfc2Vl
ZCksCi0JCQlodF9tYXRjaF9lbnVtLCAmcmVnX2VudW1fbG9va3VwLCAmaXRlci5pdGVyKTsKKwkJ
CWh0X2hhc2hfZW51bSgodm9pZCAqKSByZWdfZW51bV9sb29rdXAsIGx0dG5nX2h0X3NlZWQpLAor
CQkJaHRfbWF0Y2hfZW51bSwgcmVnX2VudW1fbG9va3VwLCAmaXRlci5pdGVyKTsKIAlub2RlID0g
bHR0bmdfaHRfaXRlcl9nZXRfbm9kZV9zdHIoJml0ZXIpOwogCWlmICghbm9kZSkgewogCSAgICAg
ICAgZ290byBlbmQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
