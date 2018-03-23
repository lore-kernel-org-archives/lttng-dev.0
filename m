From: Khalid Elmously <khalid.elmously@canonical.com>
Subject: [PATCH lttng-modules] Update: kvm instrumentation for
	ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 11:03:48 -0400
Message-ID: <20180323150348.25137-1-khalid.elmously__34722.0698990442$1521818405$gmane$org@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 4076hl2gTBzxMS
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 11:21:59 -0400 (EDT)
Received: from mail-qt0-f199.google.com ([209.85.216.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <khalid.elmously@canonical.com>)
 id 1ezOEZ-0002z9-Ka
 for lttng-dev@lists.lttng.org; Fri, 23 Mar 2018 15:03:59 +0000
Received: by mail-qt0-f199.google.com with SMTP id j8so8037936qti.23
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 08:03:59 -0700 (PDT)
Received: from kbuntu.fuzzbuzz.org (ool-43524215.dyn.optonline.net.
 [67.82.66.21])
 by smtp.gmail.com with ESMTPSA id n30sm6698926qtb.93.2018.03.23.08.03.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Mar 2018 08:03:55 -0700 (PDT)
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
aW5kZXggOGY5YTEzMi4uYWJhNmY5MyAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50
cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKQEAgLTkyLDYgKzkyLDcgQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChrdm1f
YWNrX2lycSwKIAl8fCBMVFROR19LRVJORUxfUkFOR0UoNCwxLDUwLCA0LDIsMCkgXAogCXx8IExU
VE5HX0tFUk5FTF9SQU5HRSgzLDE2LDUyLCAzLDE3LDApIFwKIAl8fCBMVFROR19LRVJORUxfUkFO
R0UoMywyLDk3LCAzLDMsMCkgXAorCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoNCwxMywx
NiwzOCwgNCwxNCwyNTUsMjU1KSBcCiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0LDks
NjUsMCwzLDAsIDQsMTAsMCwwLDAsMCkgXAogCXx8IExUVE5HX0ZFRE9SQV9LRVJORUxfUkFOR0Uo
NCwxNCwxMywzMDAsIDQsMTUsMCwwKSkKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
