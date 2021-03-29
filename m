Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB25C433C1
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:30:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14599617C9
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14599617C9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F89PQ0zNfzPy2;
	Mon, 29 Mar 2021 07:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617017451;
	bh=/cRj0EABYV+B90WsAAldD967MHm0VDaLXxwRmuPqoLs=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=I0XpdWF/m2Z7pcZKCwcEuEZcfgP79fYO8DdDPGJQ59WIjDZuGYvbtHPsPm4KJfdc0
	 HHqoqCC0NaluqVOAG0l8SjqtPtk22CupQcsVzsqjUCX++rE2W/859YSsRBS9tU1pQ3
	 OVtM0eUUFAj6fb0Jz2A12JtdolEGY0DSbZ6XN3HAeDOFWHTzkIwOuusFA6BxBTMRhe
	 b8Ea3uLIqaukakUzJKB2Fy/PE1exVzi3E4QMuAmkQezVA+LeRuDrboChnHE6oQNc9r
	 RCRrhcyc4O0ii8kz3Pwl3J1laFVYkac/73uwQ4QHgmFymtpPBvkYr2/NkoDVny8n6y
	 Xr6gBIGL99o6w==
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
 by lists.lttng.org (Postfix) with ESMTPS id 4F89PM1Rj3zQDx
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 07:30:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP7LJb6f5sbxO6FlWywTkHa9id234vlLncekyeSG+7H0q5npP7YetnWr//jdn1w7Xo8u5oa43CSSCsE5AnE+sIutMehVx7Qtp+EcybrnPalQUosjC0FynPa5MgIFrYwXlx9ahKG0R32VQ3QFHxZRoVb1j8FBV/TSOR0lO2NqSixZiDDcKniODZB796uod72fry5N0gwbstSoCzcNOUM0Y8AzQ36/PH70n1pFsN69hJMPJgzDC1Xjj1QmxYD/zpGSmtOy/9kBlCxBVCu0TchjA+v9hMuwp4BAcBi6mZbMSWX8sg2G71D360HPLtsannwCJQ+3DR8z3iSfJPwjGp0czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTRmySM6mWRxJKtYQQyqptizm2/la235PsDwy5vVyuo=;
 b=ZRBL8fsXUdPcWY2uVDSeXKq8zAaounZ0os6YH+pYb39bgU4KtJn4LTKU8koVRuXqhTt7yaagrcnlIga/N5rmTWRmCQBlKoH4/S9wxPa5Dus5C7wFl2A7BISm/d2piVineVkdWyBpmKchiJcWXfIi2tIy61fioE9LrX/1soOe1lnAdmCCtTJPdPFGH9ffFQbSHs1RZaWrksdxKYz0mVhtF4stAB9/wYPnwqmqGmM6rgc6ely7SVSkBPsX1wiq7TvMuEO/ZDnofeKIh7zHYnk6/o9XEkdXLukR+YCoAYY21arXimE3KYs4Q9b3q6RXxNpH+omBXE3J64ArByMT9PX8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Mon, 29 Mar
 2021 11:30:45 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 11:30:45 +0000
To: lttng-dev@lists.lttng.org
Date: Mon, 29 Mar 2021 19:30:32 +0800
Message-Id: <20210329113032.1560900-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:c9::7) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by
 HKAPR03CA0020.apcprd03.prod.outlook.com (2603:1096:203:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.14 via Frontend Transport; Mon, 29 Mar 2021 11:30:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca556258-146a-4689-3326-08d8f2a6178a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3398A4B031E8F841F56A57E4E47E9@BYAPR11MB3398.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7xXS70x4C/U3ish7JnEjbJPPfKXkcGCYWYIwnmJVVp4KojNaF+QBasqEHzalegQwp4AxBTaIG6Ax8vEiLggCqn5Fy2agWlqcWfNdwPBvlvCha3ZOa+KkmQ0t9QwzAYn1ngxFbvG9T5Zbvngz8sGD3coO6kuSWFuOOkuGXAFr7oM5j0VPbsIHFbCAYPCEUxx0l+zB/N1Wq6UIJ5et6OINwuO3A51phkqY0bZ+JCAI+hMX4p7L6CdJlpMDfo5Q8zW7+VwsbuReBSRgXsDrPr/SMMzgueqEZjYXtrzpcTWiPk97RYVnDywje1VgD4R5cGL5/V0Uo//JibGVPm7eVMfuwqfEvtpqj56ymURpY2xS1GwerID4JXv44dX0JKVx55L+07etBCyLCi9ByVdvw91fw81w2ZKGEWsxr59tOnfkcXUjktM0p36HdQCtb55MPHHMxDhpo6YVbb+mwqDlZcgAPB7lokkAvPFnleUEacVH0yo2KpuJjHxYOKgLO23UNdQem1tYm+r/Al2uGsHmdt1qYm89+92vG9ikimq18vF4KO5UykDoUh9y2AcX7+MCaerJRlMHbESKyhCYDOeu3/Q6QaGtx7wLP4TkRd1nK65WTUi48lRZZeOge9rXk8lTu+C5lZXG6Of8SGcwbJJbMqdkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39840400004)(366004)(38100700001)(2616005)(5660300002)(956004)(36756003)(6916009)(6512007)(9686003)(2906002)(83380400001)(66946007)(66556008)(66476007)(316002)(6506007)(8676002)(16526019)(26005)(8936002)(186003)(478600001)(6486002)(6666004)(86362001)(52116002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fMdm1IRsEGkP2JTomQ8rZr2NuX5i9Hgsf9d4k8+UqG12bVDgPWe+004PUJpR?=
 =?us-ascii?Q?pCIn/3ZcbfAyyA7XEYLQXbLWjTyql1+Ddd4eNMQEeOmXIY07aDo517okt055?=
 =?us-ascii?Q?BBmJyao9bAHcF9UsxEGRPbcw2bdpKmekdiPNk+xDO+lHwEsMm++ugKjVaTPg?=
 =?us-ascii?Q?DoRhkn/rZ42+OAx1BH6TjLqj1npGV+d6fxnCfiP/+pqwjbpl/UIMLZ8Qeyzj?=
 =?us-ascii?Q?XyNkFWdRb0jG9wotZzRusTBvtuONORXG1bj4B6cF4amP64s+nJxr13u0+xMX?=
 =?us-ascii?Q?x6C75HPmpbseloktA6VmxiLThCQPGjLOVo0qNHrQswNBlhGXQ7s2NlsmiKgS?=
 =?us-ascii?Q?haDVIHMs/7/Pq0gkdvOG2JZvOzjEbYKiLCllom+mwOJeA7AePEudwwt5IetE?=
 =?us-ascii?Q?GUbhZDytP9b0ZZG72IyBYB98aTogZEFyZ1X7/pGgB5PlWqZqIeHgyVGXSbuc?=
 =?us-ascii?Q?OYd6Qg1o/NMwk9bgWrLvJZssviOpd4hZ4DurUtrkT0B9IGY16A3ELCNgvKWg?=
 =?us-ascii?Q?/jcrXHcdsFN7Kz/Nc4aZMOh0RWCACuCl7wGr38fS1R0KrCGS5ZEW3DBWJoVv?=
 =?us-ascii?Q?jvcqe7/TEAJZWIIveXdxGE+xO2G9NSjyX+dEL3Qd2RKwo/di7qSrXPDv5vgs?=
 =?us-ascii?Q?QK8g2KHV519WhAIAIK4dC5gJaHkqCxgHxjKeQaFWUFZiDtjY/X9RdJrORczh?=
 =?us-ascii?Q?/Tp0Mvo8m5OJ1RUlqMYwNRBEQ6RBiJ/B1/Re/QLMO9H4JZp2bw33MXxEM+lH?=
 =?us-ascii?Q?gjD/JjGN5zNLa21XzqPEI40ybs7B/GUr0pf4Vh+CgcxNqesDU3eirW0Ellk1?=
 =?us-ascii?Q?hH+8FajN0bkMdbTXZYqSmNZNGy54tw8GeBFDmrhqsdIXo+aPHb2+h3HamZK8?=
 =?us-ascii?Q?rgy7DRuyMt7+C1dE+y0nx4T9XgvE6hcQBSvyPxalC73mk3LVqImnJX91qJbq?=
 =?us-ascii?Q?WILPN6xm8oEKC4wLJlKMYE435B8heQwowKZl7BH4xauEDvinKN66WZpu7Ycg?=
 =?us-ascii?Q?NFIckgWEItXwS2yjv0aVX/81R/WiRo4/tyUso3QTPgSA1QECg4GxiF/8KNvx?=
 =?us-ascii?Q?XPN4Rh5Y5ctkdgJCEXAVgu28l01rm7kdxvXnHFqQGEin+isqEr8jLygYwuWa?=
 =?us-ascii?Q?pvQVg7s/3G+F9W7WP0l5wFDkPmxup/NjDbIPtSCGgKM1WAWMFEngCp26F/Ey?=
 =?us-ascii?Q?e6GOJhyadXFPMSYK6TXrJvBfYSbv8TjO56CbnFoSapC7p0Q+DMdPWnXKLIJd?=
 =?us-ascii?Q?BlJ5201Ddxia0mrrA6KfGENwX9/TThBvaEm0Mq6A+1NWKaST6kh9rb4jvaC1?=
 =?us-ascii?Q?VuNVLz8Z8PcVVUc+JKBSNLBa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca556258-146a-4689-3326-08d8f2a6178a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 11:30:44.9429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFZU1lc97UFpQcmeAN379c/j4NNNjI5udpp+g2fqqdoOuCLmFZqON5aEFOeLGALEvuEAY8fwy8RAPTrx/tcpYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3398
Subject: [lttng-dev] [PATCH lttng-modules] Fix: lttng-statedump-impl: wrap
 some helpers unexported in kernel
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Yanfei Xu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: yanfei.xu@windriver.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Yanfei Xu <yanfei.xu@windriver.com>

disk_part_iter_* helpers were unexported in the v5.11 kernel
by 'commit bc359d03c7ec("block: add a disk_uevent helper")'.
Thus we make some wrappers for them to avoid compile failed.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 include/wrapper/genhd.h    | 104 +++++++++++++++++++++++++++++++++++++
 src/lttng-statedump-impl.c |   9 ++--
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/include/wrapper/genhd.h b/include/wrapper/genhd.h
index 68980388..91159daf 100644
--- a/include/wrapper/genhd.h
+++ b/include/wrapper/genhd.h
@@ -94,4 +94,108 @@ struct device_type *wrapper_get_disk_type(void)
 
 #endif
 
+
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,11,0))
+
+/**
+ * disk_part_iter_exit - finish up partition iteration
+ * @piter: iter of interest
+ *
+ * Called when iteration is over.  Cleans up @piter.
+ *
+ * CONTEXT:
+ * Don't care.
+ */
+static
+void wrapper_disk_part_iter_exit(struct disk_part_iter *piter)
+{
+        if (piter->part)
+                bdput(piter->part);
+        piter->part = NULL;
+}
+
+/**
+ * disk_part_iter_init - initialize partition iterator
+ * @piter: iterator to initialize
+ * @disk: disk to iterate over
+ * @flags: DISK_PITER_* flags
+ *
+ * Initialize @piter so that it iterates over partitions of @disk.
+ *
+ * CONTEXT:
+ * Don't care.
+ */
+static
+void wrapper_disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
+		                                          unsigned int flags)
+{
+        piter->disk = disk;
+        piter->part = NULL;
+        if (flags & (DISK_PITER_INCL_PART0 | DISK_PITER_INCL_EMPTY_PART0))
+                piter->idx = 0;
+        else
+                piter->idx = 1;
+        piter->flags = flags;
+}
+
+/**
+ * disk_part_iter_next - proceed iterator to the next partition and return it
+ * @piter: iterator of interest
+ *
+ * Proceed @piter to the next partition and return it.
+ *
+ * CONTEXT:
+ * Don't care.
+ */
+static
+struct block_device *wrapper_disk_part_iter_next(struct disk_part_iter *piter)
+{
+        struct block_device *part;
+        unsigned long idx;
+
+        /* put the last partition */
+        wrapper_disk_part_iter_exit(piter);
+
+        rcu_read_lock();
+        xa_for_each_start(&piter->disk->part_tbl, idx, part, piter->idx) {
+                if (!bdev_nr_sectors(part) &&
+                    !(piter->flags & DISK_PITER_INCL_EMPTY) &&
+                    !(piter->flags & DISK_PITER_INCL_EMPTY_PART0 &&
+                      piter->idx == 0))
+                        continue;
+
+                piter->part = bdgrab(part);
+                if (!piter->part)
+                        continue;
+                piter->idx = idx + 1;
+                break;
+        }
+        rcu_read_unlock();
+
+        return piter->part;
+}
+
+#else
+
+static
+void wrapper_disk_part_iter_exit(struct disk_part_iter *piter)
+{
+        disk_part_iter_exit(piter);
+}
+
+static
+void wrapper_disk_part_iter_init(struct disk_part_iter *piter, struct gendisk *disk,
+		                                                          unsigned int flags)
+{
+        disk_part_iter_init(piter, disk, flags);
+}
+
+static
+struct block_device *wrapper_disk_part_iter_next(struct disk_part_iter *piter)
+{
+	return disk_part_iter_next(piter);
+}
+
+#endif
+
 #endif /* _LTTNG_WRAPPER_GENHD_H */
diff --git a/src/lttng-statedump-impl.c b/src/lttng-statedump-impl.c
index b3453bf5..90efe086 100644
--- a/src/lttng-statedump-impl.c
+++ b/src/lttng-statedump-impl.c
@@ -194,7 +194,6 @@ enum lttng_process_status {
 	LTTNG_DEAD = 7,
 };
 
-
 #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,11,0))
 
 #define LTTNG_PART_STRUCT_TYPE struct block_device
@@ -278,19 +277,19 @@ int lttng_enumerate_block_devices(struct lttng_session *session)
 		    (disk->flags & GENHD_FL_SUPPRESS_PARTITION_INFO))
 			continue;
 
-		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
-		while ((part = disk_part_iter_next(&piter))) {
+		wrapper_disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
+		while ((part = wrapper_disk_part_iter_next(&piter))) {
 			char name_buf[BDEVNAME_SIZE];
 
 			if (lttng_get_part_name(disk, part, name_buf) == -ENOSYS) {
-				disk_part_iter_exit(&piter);
+				wrapper_disk_part_iter_exit(&piter);
 				class_dev_iter_exit(&iter);
 				return -ENOSYS;
 			}
 			trace_lttng_statedump_block_device(session,
 					lttng_get_part_devt(part), name_buf);
 		}
-		disk_part_iter_exit(&piter);
+		wrapper_disk_part_iter_exit(&piter);
 	}
 	class_dev_iter_exit(&iter);
 	return 0;
-- 
2.27.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
