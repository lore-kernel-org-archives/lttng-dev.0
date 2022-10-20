Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237AEC4332F
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Oct 2022 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666277688;
	bh=YWu7Rw4hcrE7GXRbLqJCFWOiwUNrqHTGwQiLQipXRwc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=IuqIThhtsgja6LckO71GhESV3PrR4Mrfd1BzDCyMkL6qbMCdEyWy2tJu+7jlmswza
	 Y82H1qu8NpwZJuLUXuVReWcggt2/4Tv8FBYbTO/FUbOoqXOBjIqsZ5CKotPE1iUAAO
	 KqQjfNZ5Ihm4omQwSxJo7vL2xoksFkxK396h8IZ67X11pfZYgzfqOgBt7+dBqTaFKh
	 DeqRuW2mbsh5Q2XQnOAAJURXm9QpsvZP9Ud5GU0UMKNkAnaSM6ioGqSJ0PvGYH2qeS
	 C6ZyLcPzouyhnZtLPEeQHofciCmo/cnWp2OciTC3NkFhWwgDmvhCYu3gnSvkEQHIit
	 KJ84x+U6nxQCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MtVxh1Vx5z9l4;
	Thu, 20 Oct 2022 10:54:48 -0400 (EDT)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4MtMpw1HrCz9g5
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 05:33:27 -0400 (EDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 29K99nBe025301
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 09:13:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kavusrd5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 09:13:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAOdoe9NgAhcssKRJj/1YImynWLX+rX9sZfJECRpmyWF6ug792vESA6X8FastnTYCQiek96eNensMexj3EsYL8ahQiFvaer+fNekQk8xCIArqUZpuOzpbXS7e6wMAXDTDsh3lqZij5g5UHCtUg5o7CNJy8PvwMuarzeEsBS93qG/xmg1PcaczIUge8XwdqxcKvMpTv5tIISwnWmp3rKFMpBkPx8dgpEJ0VvyitXRwAOTEk/Ntl/g3GXoLskGS1J9E7AdIUHxog3EefEVdRa1RoB1LPC4fRarwJN2ve4PgOyKNEli1lKYrsedLDeGCHxU0cJszGHB2cAU6XFwRxGBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ791CcKjPcv6SDTMyelq03UNUwZlvbm9KG/yGp+96g=;
 b=jR2yeWef5/OTtjDv4L/ho+u2P1njKXN4kBlTjdbGWvd1l4df5/rJRHZEr5D/YkRXDV53CUfuJvXpY4n+VllZFZEZIJGScBHoF6quyUi8J5dcDl9cQvmSfTU5LPJ+ErQVk2dfoI8b0kXYp2WyLxUKTiTaJo/dppCQcUkbJa8YF7xUAJ6Fyj1qguS4PtaJHki+D0jHWDddF0OTxjwINr79BZAVvTfofcwWn2jBAAH5+LebD3/aHbud9cyGYLxDtH1B3A22fEM4mazlD4MISrLuJsZww3ozEU68RBPC7sNsXnCFTE0Z6uvw27smy/aNPwfRFDOvhrQKH4F+wcWL2yEDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 09:13:37 +0000
Received: from CO1PR11MB4900.namprd11.prod.outlook.com
 ([fe80::dbb0:c503:a8bb:effb]) by CO1PR11MB4900.namprd11.prod.outlook.com
 ([fe80::dbb0:c503:a8bb:effb%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 09:13:37 +0000
To: lttng-dev@lists.lttng.org
Date: Thu, 20 Oct 2022 11:13:21 +0200
Message-Id: <20221020091321.27945-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To CO1PR11MB4900.namprd11.prod.outlook.com
 (2603:10b6:303:9e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4900:EE_|DM6PR11MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d6fc1d-13d0-437b-fca2-08dab27b5f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzIULhu0RxSfiYk4KUmtmSOteoeyyQBTd8SfPDwyzJYlBgDCR8VGQqKwi9hBIEIXCmGxPjpT6qk0CTuhhSDQMiIFXXpqouXfREg32MuuF2RXmhwp8MRsV59EoZqhKK/ElanjOodBjKGmUHkT+atYiJWu6Pcoigi9lC4YZi0N1fDQglSbSnXC0zh7iXAr0AaEYHmCv6Q4ic49Pf99+Lmi85rRCjGHu/Rcdn14xo9gzTyIQsznupbA6+gDKE/nLQ7TrMzI6MwH1laC3Agk9rJHuwv6a3j+KyVuG/opx1sN5m2Fzaj8V2VT4GFBlucHXNftCaested+e80bto23YLiCq48+LllHyqTpKMO/t3dUqZ1V2C3dYDvYCv47unEoj/wxF2DzHYfyplPw7kqPQj9LdZ/m/p3v1y/8WZwKqKRLPsDjaGZ6w5zgYUCT7/5u5AGvVH16ShP3WUudTTlUOjLYSs74jgozVnjrQzuW/ku+imT0Jjb830lUvS+So8xvJe8qFmT5G0PhJmJpER2CsJGAioRPKs2CSwAl4eGMjBz7OAWa2FlIn95Me90E8XtxilCixEy5xIe3lbDyOkp3WMO04akEYOeJueybEuTqRjmYqhQY2iSV1CUmyMRb6ebLLqb9x3L1F1056UYgs/g4bDSuk0BGtNl2zO9DFTIqcMm2X5l1akOafJq+U/KPffmxm2XWm20GmTfQFnYCCVi9tgCEojqjEZi4dWOZIZT+Dr8V0aCPjfVNzXruKPWm2mkTnRkpN41z93YlsIpPbLsICJI7ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4900.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(451199015)(38350700002)(2906002)(83380400001)(86362001)(6666004)(44832011)(36756003)(52116002)(2616005)(1076003)(8936002)(5660300002)(26005)(186003)(6506007)(41300700001)(6512007)(316002)(38100700002)(6916009)(66476007)(66556008)(6486002)(478600001)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHLQrGLZRfjTaB1lnNDmS8W5TSXwsqowQP/ITvGUPIzns7v4gpjswSSx/zgm?=
 =?us-ascii?Q?onNKAszYv05VKgAWH+f+WNGKb++mYPxfJcVMgjUhHi8CJCp4Ier5fvSXyZSH?=
 =?us-ascii?Q?TIM4KJF+kSCPjuz1IDnerNLpuolRlxjO9NLgw9skWSiMhWsbttSrbni/VSlt?=
 =?us-ascii?Q?mvOG76ci2SaPLCIMCqppg+/ZED9HMv5HBCWEPlZBprLEFTNw6Ju0tXdXA0fW?=
 =?us-ascii?Q?XtUopn/OqI3jt15Pv3RxKFQemXr4T5F/uaU5lQoVyYE8NCsqlUNRoMvgmMm8?=
 =?us-ascii?Q?eqpI9CYgkTrHVNwaEGMXOGa+ahTXFNI5TXk4NlZmfYRQ0r9tEH2qZwwapiJA?=
 =?us-ascii?Q?NECrZZPPMRFpqUT2zIaRmpK0tazJpLUIJ2YQGeSX5iYpMP+DywqMx5KB8N82?=
 =?us-ascii?Q?br4USnuC7Ht1Uihhd3KEmUEJZ3dYa/szC73lQL+FEvNU5DJAloCs8IaXyiGK?=
 =?us-ascii?Q?WGFEMsxsJ+XXQ0Vk+gO2Z2AtEZ0CYe5oNQnD1saCAIx3H0a0Mb4e1SUz6ur8?=
 =?us-ascii?Q?jC/ueucBCgN7Be2hv04oxdJLVqBJIbZ7TtU6r3GGyMbXmrs2cXtEArX3eE7H?=
 =?us-ascii?Q?71Z4YkQtElJNVQc9FICcOuHEwoQtPxrAZ8HS3/BKGOTxWFRFe5UhzapgWzTb?=
 =?us-ascii?Q?DCq7k/g2Y+Zfty0BuWUE6tTrOzN9GHQU7a7WQOxzQyP6qP+TYQxzi4MWhl+K?=
 =?us-ascii?Q?DhEW9VutrPOUTRF16jTZL4rC2ztuuW6FUjDqLNbyCDBsJWpLA9r+0uaNxy/+?=
 =?us-ascii?Q?MU0I6MaSe3+wFFLR29PemWdz7yWEEA+S8juvkKPjYeqxjuFpHF4J0QuUWia3?=
 =?us-ascii?Q?o1BaqMdiu/B2rPjOD7gPTd+O9c2T8qJaPq1RHvNdqlmS2dDvvPpj+UP02B8P?=
 =?us-ascii?Q?6at5uJqsZUrwjj6F1LREuqih4LuS0Xj3OOZlRgIpdtA7R56tj/kUum/xrbtI?=
 =?us-ascii?Q?jfy+gNjCJCA4AiQjZeqm4IFdENtiEIbDx9ZuGQPXT8GXiQz6ubTGWoUv5+HB?=
 =?us-ascii?Q?WnRkhhV4F3hs3LXl3OMWPUgvNtMPn6afgTT+75doKzK/lOflm6e5upK2wOrB?=
 =?us-ascii?Q?+e6JWVhwIp9Nm0iyM6SUTFfo9UYjDHMcsnxq0Qy8Tsibi5uSiVrqpUv/H1vR?=
 =?us-ascii?Q?0Gp3L1K/XRjPDibESVz/xpdwwRXVjNR3noDzfmXZU0f6OTxLRG9c5GEOibQk?=
 =?us-ascii?Q?QnS1ytilOPRN4RNGUgkxMFxk5pcAOjcmJ6i33CpkQZX5+b0Z7FqnNcToguCF?=
 =?us-ascii?Q?HtzRIzrsU21+mlbn0zM/z019XzzhkqbitCkDE/pacm+PUe/ZVI+7mTB1BGGj?=
 =?us-ascii?Q?Zc1K27W7xZpyqjRhsKsiyAta3kK0V8ixsJcVZ5M/OyV57HZCA6TPTQTxSn/v?=
 =?us-ascii?Q?LYzW1jlyNlMKEJYjuzsinP0da0Q8ir/oCy/66cs1N0M67xNcFIJoKN6URPp4?=
 =?us-ascii?Q?m6Pups3P7TeWSAt7DrObdoxQ1UJtlE0AMJ27FaxUbr0ImVjAftmB33Z+JK7/?=
 =?us-ascii?Q?hvbpEO5TaRirpLKaum6S/upw8D/pnfvORQVmwtyhKrqgXhK6AnUhRXgS2QbX?=
 =?us-ascii?Q?wlli7gGpHfvwbq4iyv7eXBu7g+T2lagp31tQlNWNA07rUz5q37Zml7W55HsQ?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6fc1d-13d0-437b-fca2-08dab27b5f00
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:13:37.3467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvx5Ao//Anq98y0qAzXU016oxAFfWWtiPAg94SFDmIUvD/DwNKAH+N7JlEtKwgpRc5uGxU0z3eZcbf/kW/nXhksl6/a4M8OF0K9Ko82BH2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-Proofpoint-GUID: zc-gm2VuE84tn11Wr5_BDvZjiHnaSz7k
X-Proofpoint-ORIG-GUID: zc-gm2VuE84tn11Wr5_BDvZjiHnaSz7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=730
 suspectscore=0 spamscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200054
X-Mailman-Approved-At: Thu, 20 Oct 2022 10:54:46 -0400
Subject: [lttng-dev] [PATCH] lttng: Add CONFIG_PREEMPTIRQ_TRACEPOINTS as a
 preemptirq condition
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
From: Mikael Beckius via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mikael Beckius <mikael.beckius@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
---
 include/instrumentation/events/preemptirq.h | 8 +++++---
 src/probes/Kbuild                           | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/instrumentation/events/preemptirq.h b/include/instrumentation/events/preemptirq.h
index 80bbbac6..2b991dee 100644
--- a/include/instrumentation/events/preemptirq.h
+++ b/include/instrumentation/events/preemptirq.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifdef CONFIG_PREEMPTIRQ_EVENTS
+#if defined(CONFIG_PREEMPTIRQ_TRACEPOINTS) || (CONFIG_PREEMPTIRQ_EVENTS)
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM preemptirq
@@ -13,7 +13,9 @@
 #include <lttng/tracepoint-event.h>
 
 /*
- * The preemptirq probe is built when CONFIG_PREEMPTIRQ_EVENTS is defined.
+ * The preemptirq probe is built when CONFIG_PREEMPTIRQ_TRACEPOINTS
+ * is defined or when CONFIG_PREEMPTIRQ_EVENTS is defined on kernels
+ * older than 4.19.
  */
 
 LTTNG_TRACEPOINT_EVENT_CLASS(preemptirq_template,
@@ -97,4 +99,4 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(preemptirq_template, preempt_enable,
 /* This part must be outside protection */
 #include <lttng/define_trace.h>
 
-#endif /* CONFIG_PREEMPTIRQ_EVENTS */
+#endif /* CONFIG_PREEMPTIRQ_TRACEPOINTS */
diff --git a/src/probes/Kbuild b/src/probes/Kbuild
index aa002534..03468d16 100644
--- a/src/probes/Kbuild
+++ b/src/probes/Kbuild
@@ -284,8 +284,8 @@ ifneq ($(CONFIG_KRETPROBES),)
   obj-$(CONFIG_LTTNG) += lttng-kretprobes.o
 endif # CONFIG_KRETPROBES
 
-ifneq ($(CONFIG_PREEMPTIRQ_EVENTS),)
+ifneq ($(or $(CONFIG_PREEMPTIRQ_TRACEPOINTS),$(CONFIG_PREEMPTIRQ_EVENTS)),)
   obj-$(CONFIG_LTTNG) += lttng-probe-preemptirq.o
-endif # CONFIG_PREEMPTIRQ_EVENTS
+endif # CONFIG_PREEMPTIRQ_TRACEPOINTS
 
 # vim:syntax=make
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
