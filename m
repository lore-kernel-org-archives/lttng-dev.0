From: <rongqing.li@windriver.com>
Subject: [PATCH] FIX: Align buffers on 4 bytes for 64bit access
Date: Thu, 15 May 2014 16:57:30 +0800
Message-ID: <1400144250-26852-1-git-send-email-rongqing.li__27272.7630603642$1400160531$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Rongqing.Li@windriver.com>) id 1WkrTs-00005L-Re
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 04:57:37 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
 [147.11.189.41])
 by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s4F8vVqF023128
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Thu, 15 May 2014 01:57:31 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

RnJvbTogRnJlZHJpayBNYXJrc3Ryw7ZtIDxmcmVkcmlrLm1hcmtzdHJvbUBnbWFpbC5jb20+CgpT
aWduZWQtb2ZmLWJ5OiBGcmVkcmlrIE1hcmtzdHLmnpptIDxmcmVkcmlrLm1hcmtzdHJvbUBnbWFp
bC5jb20+Ci0tLQogZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYyB8ICAgIDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mb3JtYXRzL2N0Zi9t
ZXRhZGF0YS9vYmpzdGFjay5jIGIvZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jqc3RhY2suYwppbmRl
eCA5ZTI2NGE0Li45NjQzYjliIDEwMDY0NAotLS0gYS9mb3JtYXRzL2N0Zi9tZXRhZGF0YS9vYmpz
dGFjay5jCisrKyBiL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMKQEAgLTExOCw2ICsx
MTgsOCBAQCB2b2lkICpvYmpzdGFja19hbGxvYyhzdHJ1Y3Qgb2Jqc3RhY2sgKm9ianN0YWNrLCBz
aXplX3QgbGVuKQogCXN0cnVjdCBvYmpzdGFja19ub2RlICpsYXN0X25vZGU7CiAJdm9pZCAqcDsK
IAorCWxlbiA9IChsZW4gKyAzKSAmIH4zOworCiAJLyogR2V0IGxhc3Qgbm9kZSAqLwogCWxhc3Rf
bm9kZSA9IGJ0X2xpc3RfZW50cnkob2Jqc3RhY2stPmhlYWQucHJldiwKIAkJCXN0cnVjdCBvYmpz
dGFja19ub2RlLCBub2RlKTsKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldgo=
