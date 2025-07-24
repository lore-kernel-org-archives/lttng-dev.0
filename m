Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55DAC83F1A
	for <lttng-dev@archiver.kernel.org>; Thu, 24 Jul 2025 14:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bntqn12JKz2HkL
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1753367815;
	b=IfqVyPGU+/8ZhBLBYEhzUaHMpEi1h8a4MBaoS/BbL2Pq9cRyf4FSbLS6L7WwgBXLYu1w
	 TVk8SYyZeYQ1kA4t+byfH55DG8K16zxgRaz75FtTv0q38+Rpr0Os6snKf22SH0mHuucLm
	 THvuIcoG/qBCmifrU7bbV7Vfb86x/ExmiUDqzgIfKVipCX7CY/8FV6hg0m+el8r5XKKjF
	 v57vVqxNOSYDWUEA4EJs3pEPiWJQ/rQif8CmU7ITWp0gSaUrK4ek75uaEwyBUHr1zgN5m
	 TKoI5+saebTsDNDIEEOGvo6/SAirF0itqWauKPRCSm1GV77O5zyLzTWQ0/2loeaF/ug==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1753367815;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=T9z+ONrbRuRX1bZY0TAm4Gwes6pSV3AKZJjxS0dE5u0=;
	b=Rn7vS3ZfDmvXsy0EmiTn4IesvrlWDbmBzRm+h5lwaRcc4g44W76gY8ImqHWSBs0bpIC5
	 aUZdOq/dDRnVJXcaIeJIBC4TVM4X4+Bv9mnj7R8ybRauoy1SHEXB8HAaKAZ5txv0G2UlN
	 XUOY8wPSXoGZ1VKZuSVG5heTmx6Vb94fjElgPQauZV+QBwli1a2fjL0m2IcWoTfCFx/Gn
	 INwmUglEuxFQ6OPwnwYACq3n4ItmLP3RUQK/pzCmGxMJmEbQJFeP4GC0VJSA3DiEurazq
	 d9f+GE1hGTDqUKuQT95y7RToZVvYecTKji3aasLy15gA/fDcLMAivRsWqhbSs94uWJw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bntqn12JKz2HkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1753367815;
	bh=T9z+ONrbRuRX1bZY0TAm4Gwes6pSV3AKZJjxS0dE5u0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=NXYj4Sf302kald46yVW0cneoUDfcb90iBk6SpSRx+7PcmSHa6w4hOBZHpmSywpqFy
	 gub08ZZaAQW2Yq5KpyHs8xA2VeyKDiydyFiM4igbVtKMHFjUYaqIDLdTJh7Bk9gUbB
	 tL2J5j8BF+ikATHXQ14ayfcfeNGTNCOxj4P/ujX1+FamY+d+NJP70S750oufIXsdp1
	 kNhqw7omXJHCLeOdccQsuo6gT54AXkDPSv/b9XmjnrAjXfMErzIAVI2oSk/zZAufvf
	 P0Op7+GJd96VYr7cE/ZX6PAq03GSnZokKyXVOTiVoLn/ylNkqvPFTDSnOsgWEXRVc3
	 8+oouVbcn7vBQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bntqn12JKz2HkL;
	Thu, 24 Jul 2025 10:36:52 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bnh966vdsz2DNC
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bnh966vdsz2DNC
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4bnh966vdsz2DNC
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jul 2025 02:36:05 -0400 (EDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56O5eJUV277352
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jul 2025 06:35:59 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com
 [147.11.82.254])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 483duq02dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jul 2025 06:35:59 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 23 Jul 2025 23:36:12 -0700
Received: from pek-lpg-core4.wrs.com (128.224.153.44) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 23 Jul 2025 23:36:08 -0700
To: <lttng-dev@lists.lttng.org>
Subject: [PATCH] eventfd.cpp: Remove the scope resolution operator
Date: Thu, 24 Jul 2025 14:35:51 +0800
Message-ID: <20250724063551.2843528-1-mingli.yu@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=f/tIBPyM c=1 sm=1 tr=0 ts=6881d44f cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=Wb1JkmetP80A:10 a=t7CeM3EgAAAA:8 a=tg3DW_3IcU5mpAnmow8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: SNcQua3RVkWnpFUKMrXCxxd16L1XTcWr
X-Proofpoint-ORIG-GUID: SNcQua3RVkWnpFUKMrXCxxd16L1XTcWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0NCBTYWx0ZWRfX+mLrsi08D7kO
 8gzjEmd2gdUt06AezfhlYtCBhaxzEmqOHPAzD3ATIxD3ub1n2TheILQ0YYeAEhD7VTz+yVdtNxH
 FmwYoZjiT8RMnlHcOr8i55QoUsgcvv2+WmFJUrZeNcW1W+73cRrTEqSwnhD4OQppQVvfGwlXQct
 BP7p2/7JiuNKHH3g4WrE+cb/vN9cDk8WLzE0lErAp2APmW89rnPzp14wx+9lOg0Lc5F99SzLHJ7
 R6tw5IK0Fiti6rvVWz7u4a+Eo8cEFEgqw/nQH+9W8Q7HoP0HONyb5Y7j+CEM3AtXjARoOfvWY/z
 /d5906MVR5My6lA3Bz9jpXtizlNLABMPcOKPxC45THYO1XawzIUZZ2Ut4Fmfc6fNvlXn92Erhkn
 DPo0hCby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507240025
X-Mailman-Approved-At: Thu, 24 Jul 2025 10:36:51 -0400
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "mingli.yu--- via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: mingli.yu@eng.windriver.com
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Mingli Yu <mingli.yu@windriver.com>

Remove the scope resolution operator :: to fix the below build failure
with musl.
 | ../../../sources/lttng-tools-2.14.0/src/common/eventfd.cpp:18:31: error: expected id-expression before numeric constant
 |    18 |                 int flags = ::EFD_CLOEXEC;
 |       |                               ^~~~~~~~~~~
 | ../../../sources/lttng-tools-2.14.0/src/common/eventfd.cpp:21:36: error: expected id-expression before numeric constant
 |    21 |                         flags |= ::EFD_SEMAPHORE;
 |       |                                    ^~~~~~~~~~~~~

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 src/common/eventfd.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/eventfd.cpp b/src/common/eventfd.cpp
index d331bbe40..447520f25 100644
--- a/src/common/eventfd.cpp
+++ b/src/common/eventfd.cpp
@@ -15,10 +15,10 @@
 
 lttng::eventfd::eventfd(bool use_semaphore_semantics, std::uint64_t initial_value) :
 	file_descriptor([use_semaphore_semantics, initial_value]() {
-		int flags = ::EFD_CLOEXEC;
+		int flags = EFD_CLOEXEC;
 
 		if (use_semaphore_semantics) {
-			flags |= ::EFD_SEMAPHORE;
+			flags |= EFD_SEMAPHORE;
 		}
 
 		const auto raw_fd = ::eventfd(initial_value, flags);
-- 
2.34.1

