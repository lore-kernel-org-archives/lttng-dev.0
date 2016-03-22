From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools v2 1/5] Fix: do not return error on
	LTTNG_ERR_SNAPSHOT_NODATA
Date: Tue, 22 Mar 2016 14:12:04 -0400
Message-ID: <1458670328-17521-2-git-send-email-jonathan.rajotte-julien__35741.3269616247$1458670398$gmane$org@efficios.com>
References: <367304197.32343.1458596988829.JavaMail.zimbra@efficios.com>
 <1458670328-17521-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 31B35A084F
 for <lttng-dev@lists.lttng.org>; Tue, 22 Mar 2016 18:12:24 +0000 (UTC)
In-Reply-To: <1458670328-17521-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

QSB3YXJuaW5nIGlzIGZpbmUgc2luY2UgdGhlIHVzZXIgaGFzIG5vIGNvbnRyb2wgb24Kd2hldGhl
ciBvciBub3QgYXBwbGljYXRpb25zIChvciB0aGUga2VybmVsKSBoYXZlCnByb2R1Y2VkIGFueSBl
dmVudCBiZXR3ZWVuIHRoZSBzdGFydCBvZiB0aGUgdHJhY2luZwpzZXNzaW9uIGFuZCB0aGUgcmVj
b3JkaW5nIG9mIHRoZSBzbmFwc2hvdC4KCk1JIHdpc2UgdGhlIGNvbW1hbmQgaXMgbm90IGEgc3Vj
Y2VzcyBzaW5jZSBub3RoaW5nIHdhcwpyZWNvcmRlZC4gVGhlIGNvbW1hbmQgbGluZSByZXR1cm4g
Y29kZSBpcyBDTURfU1VDQ0VTUy4KCnJlZnMgIzEwMDIKClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KLS0tCiBzcmMv
YmluL2x0dG5nL2NvbW1hbmRzL3NuYXBzaG90LmMgfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMv
c25hcHNob3QuYyBiL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvc25hcHNob3QuYwppbmRleCBhYmRm
MTg5Li4yOThiYzZlIDEwMDY0NAotLS0gYS9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL3NuYXBzaG90
LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9zbmFwc2hvdC5jCkBAIC03MjUsNiArNzI1
LDE1IEBAIGludCBjbWRfc25hcHNob3QoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCQkJ
YnJlYWs7CiAJCWNhc2UgTFRUTkdfRVJSX1NOQVBTSE9UX05PREFUQToKIAkJCVdBUk4oIiVzIiwg
bHR0bmdfc3RyZXJyb3IoY29tbWFuZF9yZXQpKTsKKworCQkJLyogIEEgd2FybmluZyBpcyBmaW5l
IHNpbmNlIHRoZSB1c2VyIGhhcyBubyBjb250cm9sIG9uCisJCQkgKiAgd2hldGhlciBvciBub3Qg
YXBwbGljYXRpb25zIChvciB0aGUga2VybmVsKSBoYXZlCisJCQkgKiAgcHJvZHVjZWQgYW55IGV2
ZW50IGJldHdlZW4gdGhlIHN0YXJ0IG9mIHRoZSB0cmFjaW5nCisJCQkgKiAgc2Vzc2lvbiBhbmQg
dGhlIHJlY29yZGluZyBvZiB0aGUgc25hcHNob3QuIE1JIHdpc2UKKwkJCSAqICB0aGUgY29tbWFu
ZCBpcyBub3QgYSBzdWNjZXNzIHNpbmNlIG5vdGhpbmcgd2FzCisJCQkgKiAgcmVjb3JkZWQuCisJ
CQkgKi8KKwkJCWNvbW1hbmRfcmV0ID0gMDsKIAkJCWJyZWFrOwogCQlkZWZhdWx0OgogCQkJRVJS
KCIlcyIsIGx0dG5nX3N0cmVycm9yKGNvbW1hbmRfcmV0KSk7Ci0tIAoyLjcuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcg
bGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2Nn
aS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
