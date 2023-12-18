Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6C8C35274
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Dec 2023 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1702895604;
	bh=rJ21Yok4U0tW+1oarZhWLjS4dX2MSURmXy8slyHv6Ys=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Y5I6XjKTyv9w6elzv5OgO/n5TtochVhxjOFvOJSljd7KPdJOHq0ZchX7wQpOo13e6
	 M0Ru9v5aFxB4gNrNo0N0Fgg7JigrKfdH6fzJ8KCNBQq4yAfa3/ox+QpidsKC5A9dAk
	 ne9suIKBIIB6Z6G3kjW7/bNOpET+P7MwcCxtydcz0uEmmyb548iASKfeVsF/icVwi9
	 pDB3442gGXSEzHNGhdenic47Pe+5IqeWZvLzIwn9z+AhLAft3aJ2xzBNQVAgUCU2gm
	 Xeuiz8DQ98ApQU1ivcibx+jemrwq3p41Op7yIF2UecdZbczr+2PC4l7ARi8O//skxB
	 IIjI27XaAHt4A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Stx4M2wfnz17TV;
	Mon, 18 Dec 2023 05:33:23 -0500 (EST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by lists.lttng.org (Postfix) with ESMTP id 4Stx4L2L7Zz17cg
 for <lttng-dev@lists.lttng.org>; Mon, 18 Dec 2023 05:33:22 -0500 (EST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BI6uGJ5019617
 for <lttng-dev@lists.lttng.org>; Mon, 18 Dec 2023 10:16:37 GMT
Received: from aptaippmta02.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152qbyjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 18 Dec 2023 10:16:36 +0000 (GMT)
Received: from leiwan2-gv.qualcomm.com (leiwan2-gv.qualcomm.com
 [10.233.41.112])
 by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIAGYbB016992
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 18 Dec 2023 10:16:35 GMT
Received: by leiwan2-gv.qualcomm.com (Postfix, from userid 431743)
 id 9643520B9; Mon, 18 Dec 2023 18:16:33 +0800 (CST)
To: lttng-dev@lists.lttng.org
Date: Mon, 18 Dec 2023 18:16:33 +0800
Message-Id: <20231218101633.4188511-1-quic_leiwan@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: F6nGxYwT3JD2BVEaBgA6Z0-RZiqJhjOw
X-Proofpoint-GUID: F6nGxYwT3JD2BVEaBgA6Z0-RZiqJhjOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=621
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180073
Subject: [lttng-dev] [PATCH lttng-modules] Android: Import VFS namespace for
 android common kernel
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
From: Lei wang via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lei wang <quic_leiwan@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Android GKI kernel add limitation on fs interface usage.
Need to import VFS namespace explicitly to make it workable
for lttng-modules.

Signed-off-by: Lei wang <quic_leiwan@quicinc.com>
---
 src/wrapper/kallsyms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/wrapper/kallsyms.c b/src/wrapper/kallsyms.c
index 97897c4..9398c83 100644
--- a/src/wrapper/kallsyms.c
+++ b/src/wrapper/kallsyms.c
@@ -113,3 +113,7 @@ unsigned long wrapper_kallsyms_lookup_name(const char *name)
 EXPORT_SYMBOL_GPL(wrapper_kallsyms_lookup_name);
 
 #endif
+
+#ifdef CONFIG_ANDROID
+MODULE_IMPORT_NS(VFS_internal_I_am_really_a_filesystem_and_am_NOT_a_driver);
+#endif
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
