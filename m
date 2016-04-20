From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: RHEL kernel
	3.10.0-327.13.1 compat
Date: Wed, 20 Apr 2016 22:24:56 +0000 (UTC)
Message-ID: <1374501110.65365.1461191096781.JavaMail.zimbra__46925.8080157035$1461191127$gmane$org@efficios.com>
References: <1461189005-15862-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 987ACA31EE
 for <lttng-dev@lists.lttng.org>; Wed, 20 Apr 2016 22:25:01 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A61DE34034F
 for <lttng-dev@lists.lttng.org>; Wed, 20 Apr 2016 22:25:01 +0000 (UTC)
In-Reply-To: <1461189005-15862-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

bWVyZ2VkIGludG8gbWFzdGVyLCAyLjggYW5kIDIuNywgdGhhbmtzIQoKTWF0aGlldQoKLS0tLS0g
T24gQXByIDIwLCAyMDE2LCBhdCA1OjUwIFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZm
aWNpb3MuY29tIHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFu
c29uQGVmZmljaW9zLmNvbT4KPiAtLS0KPiBsdHRuZy1zdGF0ZWR1bXAtaW1wbC5jIHwgNiArKysr
LS0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9sdHRuZy1zdGF0ZWR1bXAtaW1wbC5jIGIvbHR0bmctc3RhdGVkdW1wLWlt
cGwuYwo+IGluZGV4IDRjMWE5OWQuLmEyNTIwNDMgMTAwNjQ0Cj4gLS0tIGEvbHR0bmctc3RhdGVk
dW1wLWltcGwuYwo+ICsrKyBiL2x0dG5nLXN0YXRlZHVtcC1pbXBsLmMKPiBAQCAtNDAzLDcgKzQw
Myw4IEBAIHZvaWQgbHR0bmdfc3RhdGVkdW1wX3Byb2Nlc3NfbnMoc3RydWN0IGx0dG5nX3Nlc3Np
b24KPiAqc2Vzc2lvbiwKPiAJICovCj4gI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVM
X1ZFUlNJT04oMywxNywwKSB8fCBcCj4gCQlMVFROR19VQlVOVFVfS0VSTkVMX1JBTkdFKDMsMTMs
MTEsMzYsIDMsMTQsMCwwKSB8fCBcCj4gLQkJTFRUTkdfVUJVTlRVX0tFUk5FTF9SQU5HRSgzLDE2
LDEsMTEsIDMsMTcsMCwwKSkKPiArCQlMVFROR19VQlVOVFVfS0VSTkVMX1JBTkdFKDMsMTYsMSwx
MSwgMywxNywwLDApIHx8IFwKPiArCQlMVFROR19SSEVMX0tFUk5FTF9SQU5HRSgzLDEwLDAsMjI5
LDEzLDAsIDMsMTEsMCwwLDAsMCkpCj4gCXByb3h5ID0gcC0+bnNwcm94eTsKPiAjZWxzZQo+IAly
Y3VfcmVhZF9sb2NrKCk7Cj4gQEAgLTQyMiw3ICs0MjMsOCBAQCB2b2lkIGx0dG5nX3N0YXRlZHVt
cF9wcm9jZXNzX25zKHN0cnVjdCBsdHRuZ19zZXNzaW9uCj4gKnNlc3Npb24sCj4gCX0KPiAjaWYg
KExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTigzLDE3LDApIHx8IFwKPiAJCUxU
VE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoMywxMywxMSwzNiwgMywxNCwwLDApIHx8IFwKPiAtCQlM
VFROR19VQlVOVFVfS0VSTkVMX1JBTkdFKDMsMTYsMSwxMSwgMywxNywwLDApKQo+ICsJCUxUVE5H
X1VCVU5UVV9LRVJORUxfUkFOR0UoMywxNiwxLDExLCAzLDE3LDAsMCkgfHwgXAo+ICsJCUxUVE5H
X1JIRUxfS0VSTkVMX1JBTkdFKDMsMTAsMCwyMjksMTMsMCwgMywxMSwwLDAsMCwwKSkKPiAJLyog
KG5vdGhpbmcpICovCj4gI2Vsc2UKPiAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gLS0KPiAyLjcuNAoK
LS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMu
bHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
