From: Khalid Elmously <khalid.elmously@canonical.com>
Subject: [PATCH lttng-modules v3] Update: kvm instrumentation
	for ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 13:28:03 -0400
Message-ID: <20180323172803.26196-1-khalid.elmously__3018.13740884445$1521825974$gmane$org@canonical.com>
References: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 4079VL2Nx6zxls
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 13:28:09 -0400 (EDT)
Received: from mail-qk0-f198.google.com ([209.85.220.198])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <khalid.elmously@canonical.com>)
 id 1ezQU4-0005HT-Hs
 for lttng-dev@lists.lttng.org; Fri, 23 Mar 2018 17:28:08 +0000
Received: by mail-qk0-f198.google.com with SMTP id e205so8081817qkb.8
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 10:28:08 -0700 (PDT)
In-Reply-To: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
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

U3RhcnRpbmcgZnJvbSA0LjEzLjAtMzggdGhlIHVidW50dSBrZXJuZWwgYmFja3BvcnQgYSBrdm0g
aW5zdHJ1bWVudGF0aW9uCmNoYW5nZSBpbnRyb2R1Y2VkIGluIDQuMTUgd2hpY2ggYWZmZWN0cyB0
aGUgcHJvdG90eXBlIG9mIHRoZSBrdm1fbW1pbyBldmVudC4KClNpZ25lZC1vZmYtYnk6IEtoYWxp
ZCBFbG1vdXNseSA8a2hhbGlkLmVsbW91c2x5QGNhbm9uaWNhbC5jb20+Ci0tLQogaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmct
bW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgK
aW5kZXggOGY5YTEzMi4uYTU5ODJjOSAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKQEAgLTkyLDYgKzkyLDcgQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChrdm1f
YWNrX2lycSwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoNCwxLDUwLCA0LDIsMCkgXAogCXx8IExU
VE5HX0tFUk5FTF9SQU5HRSgzLDE2LDUyLCAzLDE3LDApIFwKIAl8fCBMVFROR19LRVJORUxfUkFO
R0UoMywyLDk3LCAzLDMsMCkgXAorCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoNCwxMywx
NiwzOCwgNCwxNCwwLDApIFwKIAl8fCBMVFROR19ERUJJQU5fS0VSTkVMX1JBTkdFKDQsOSw2NSww
LDMsMCwgNCwxMCwwLDAsMCwwKSBcCiAJfHwgTFRUTkdfRkVET1JBX0tFUk5FTF9SQU5HRSg0LDE0
LDEzLDMwMCwgNCwxNSwwLDApKQogCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
