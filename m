From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: RHEL kernel 3.10.0-327.13.1
	compat
Date: Wed, 20 Apr 2016 17:50:05 -0400
Message-ID: <1461189005-15862-1-git-send-email-mjeanson__12876.3958382935$1461189041$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 601F2A31E0
 for <lttng-dev@lists.lttng.org>; Wed, 20 Apr 2016 21:50:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6D75B34034F
 for <lttng-dev@lists.lttng.org>; Wed, 20 Apr 2016 21:50:18 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogbHR0bmctc3RhdGVkdW1wLWltcGwuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2x0dG5nLXN0YXRlZHVt
cC1pbXBsLmMgYi9sdHRuZy1zdGF0ZWR1bXAtaW1wbC5jCmluZGV4IDRjMWE5OWQuLmEyNTIwNDMg
MTAwNjQ0Ci0tLSBhL2x0dG5nLXN0YXRlZHVtcC1pbXBsLmMKKysrIGIvbHR0bmctc3RhdGVkdW1w
LWltcGwuYwpAQCAtNDAzLDcgKzQwMyw4IEBAIHZvaWQgbHR0bmdfc3RhdGVkdW1wX3Byb2Nlc3Nf
bnMoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24sCiAJICovCiAjaWYgKExJTlVYX1ZFUlNJ
T05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTigzLDE3LDApIHx8IFwKIAkJTFRUTkdfVUJVTlRVX0tF
Uk5FTF9SQU5HRSgzLDEzLDExLDM2LCAzLDE0LDAsMCkgfHwgXAotCQlMVFROR19VQlVOVFVfS0VS
TkVMX1JBTkdFKDMsMTYsMSwxMSwgMywxNywwLDApKQorCQlMVFROR19VQlVOVFVfS0VSTkVMX1JB
TkdFKDMsMTYsMSwxMSwgMywxNywwLDApIHx8IFwKKwkJTFRUTkdfUkhFTF9LRVJORUxfUkFOR0Uo
MywxMCwwLDIyOSwxMywwLCAzLDExLDAsMCwwLDApKQogCXByb3h5ID0gcC0+bnNwcm94eTsKICNl
bHNlCiAJcmN1X3JlYWRfbG9jaygpOwpAQCAtNDIyLDcgKzQyMyw4IEBAIHZvaWQgbHR0bmdfc3Rh
dGVkdW1wX3Byb2Nlc3NfbnMoc3RydWN0IGx0dG5nX3Nlc3Npb24gKnNlc3Npb24sCiAJfQogI2lm
IChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywxNywwKSB8fCBcCiAJCUxU
VE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoMywxMywxMSwzNiwgMywxNCwwLDApIHx8IFwKLQkJTFRU
TkdfVUJVTlRVX0tFUk5FTF9SQU5HRSgzLDE2LDEsMTEsIDMsMTcsMCwwKSkKKwkJTFRUTkdfVUJV
TlRVX0tFUk5FTF9SQU5HRSgzLDE2LDEsMTEsIDMsMTcsMCwwKSB8fCBcCisJCUxUVE5HX1JIRUxf
S0VSTkVMX1JBTkdFKDMsMTAsMCwyMjksMTMsMCwgMywxMSwwLDAsMCwwKSkKIAkvKiAobm90aGlu
ZykgKi8KICNlbHNlCiAJcmN1X3JlYWRfdW5sb2NrKCk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
