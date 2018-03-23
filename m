From: Khalid Elmously <khalid.elmously@canonical.com>
Subject: [PATCH lttng-modules v2] Update: kvm instrumentation
	for ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 11:55:02 -0400
Message-ID: <20180323155502.25625-1-khalid.elmously__43198.8915698186$1521820463$gmane$org@canonical.com>
References: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 4077R6263vzxTR
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 11:55:14 -0400 (EDT)
Received: from mail-qk0-f200.google.com ([209.85.220.200])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <khalid.elmously@canonical.com>)
 id 1ezP28-0006Rd-Fp
 for lttng-dev@lists.lttng.org; Fri, 23 Mar 2018 15:55:12 +0000
Received: by mail-qk0-f200.google.com with SMTP id x188so7928024qkc.12
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 08:55:12 -0700 (PDT)
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
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRu
Zy1tb2R1bGUva3ZtLmggYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0u
aAppbmRleCA4ZjlhMTMyLi5jNDE5ZjljIDEwMDY0NAotLS0gYS9pbnN0cnVtZW50YXRpb24vZXZl
bnRzL2x0dG5nLW1vZHVsZS9rdm0uaAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5n
LW1vZHVsZS9rdm0uaApAQCAtOTIsNiArOTIsOCBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKGt2
bV9hY2tfaXJxLAogCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDEsNTAsIDQsMiwwKSBcCiAJfHwg
TFRUTkdfS0VSTkVMX1JBTkdFKDMsMTYsNTIsIDMsMTcsMCkgXAogCXx8IExUVE5HX0tFUk5FTF9S
QU5HRSgzLDIsOTcsIDMsMywwKSBcCisJfHwgTFRUTkdfVUJVTlRVX0tFUk5FTF9SQU5HRSg0LDEz
LDE2LDM4LCA0LDE0LDAsMCkgXAorCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoNCwxNCww
LDAsIDQsMTUsMCwwKSBcCiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0LDksNjUsMCwz
LDAsIDQsMTAsMCwwLDAsMCkgXAogCXx8IExUVE5HX0ZFRE9SQV9LRVJORUxfUkFOR0UoNCwxNCwx
MywzMDAsIDQsMTUsMCwwKSkKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
