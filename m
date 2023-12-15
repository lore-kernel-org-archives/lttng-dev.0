Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF327C35274
	for <lttng-dev@archiver.kernel.org>; Fri, 15 Dec 2023 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1702650791;
	bh=5cC6s3NBiqrqwqcP457KFAED/NjX1HLwoxD/KNIZ730=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cMMtGfh8u4agkxnpVGmTQH7FWxNvU4k24wZeDOR2NJ8YMXZg+9chtw3P4Me5hIFE+
	 p/+9BiRcMyvcH/plPBIUNJmpUJ+CB6UgAKtf4rBNztq2sJAX9dDzqaWD/ZK2ZWIdUd
	 /SqTLKKSR2h2uwrMYBuPEy9wh+D/LD+krxFW5E7HUuqSOnHTCl55K2KafY1SBkJ86A
	 d17lMMe1H23OOgFGdfcaJL/fSy2rKFyWSZreOW6tLit+r8NnzJv/y7OBMuPH1qdtZS
	 yoy5rycDK0JPit2DWpek4x9Jz3E3XMI+vaH0nEBrDbFC97K/Ba/a/WPQA2FqinxydW
	 fxTjHPlmKDYJw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SsBXQ6vl5z16CL;
	Fri, 15 Dec 2023 09:33:10 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4SsBXN5y6dz15xv
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2023 09:33:08 -0500 (EST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BFBm71V011627
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2023 06:24:32 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr9k1ntn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Fri, 15 Dec 2023 06:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqOPbrksJopa2aiy9UWxjpz3VqqdUf7rI55EX8krvR3KSGIDTPKYwX1sPTdc3/5CoAUXYOqEWKjkLcVA/Coad2Rq2M6GMrRTFnYZsRHR7N9NyA292f7rVdd5Lw/Iqh6DcRCoFu6FrEB3WQaghSdb6wqfFPrj74ikESozMeRFyjflHIvPnER7VHNtf7QJ1V8jB3en+trIuqL1/MB3ovXeqsOZCmgnhfGs6613VXlS0jTXd+/nLAhqXGoBiW4YCdp/Czud+n45zikUUMpevYareGPTynXsRiCDWMJB7O1TSnbfNSF0MQWBPOxQsGL8MkIQ/uihXKabWXJs47/PmhLYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUyvbE4s5Gg6OY7CicjcLDB9aUl2rrd5H4MBcIhI/iI=;
 b=UK98jWvZkxXYyACTaFE3edPLzb6AP1GGbEgqIR3KWnWb+n5PHV3yAe11fJnfmYU3XTdoH+srC7YJDkKCCjnR9Wq6fEO9uMIQ79NbSzrSvo/j0IJSuayJsQIigZ6QWRQG/1kbBCBqNicqksDRqcUGiv5DRZj+N4uexCSa4g6gV4is61vitki/hsuN7N3A/Ux64zBJHHJWqSvd6CB9snZy1fvdNG1uiNOUWhjmhlDur+5ciZ7phVCTRvtPuYPOuNBLj2kjOW2zfKnvEkDXduStcTqmbpNYMNXfOuNlqG3zubWOpMZRnMyKFQs4cS9VaK67L4LNuZMTbd4A+IsLJ0ApKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BY1PR11MB8128.namprd11.prod.outlook.com (2603:10b6:a03:52c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:24:27 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 14:24:22 +0000
To: lttng-dev@lists.lttng.org
Date: Fri, 15 Dec 2023 22:59:01 +0800
Message-Id: <20231215145901.586633-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.35.5
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BY1PR11MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 494adfe5-549f-4acd-4793-08dbfd7987fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCb4vvHzRM2vVr1/N3OpH7MxL8CZXvAaxeCg7hKKKNPlwxDqi0a22cyKWWstFLgWDr2jUMgEyS97RSSNT0AfhboFR0B/P2RE6MpSvdjg5Eg1+NOhYVK/9feUnqetavONJ5YVRxr7G0qlmzAaGhGK7NcnPnLNPIIE6by/849/zmx5nXnExRkzILKMX57e2LAFJ1atp57WKZgEllcoMdVITxbUR/XltRIVM5KAHGvq+M0B7d5eSELkExre9gGHxonUgf2S9njdg8U9TtgiI1As73FfnuuKUGpoHLvRiyhIgmhRfh7nu5i5zTybPh99gBs76TJlealGn5Gm+k7oE/00iH+9QqeL/NHF6N34HENdND8r0VJ+WsSZgaUCu4dgCW18zjPLThFHCHe4aSotrECoZGUmllS5uVOhpntuTTf8ZwI6XZUFk7uneDQPD32/QRlE95FG4aNAPUekwlaBxX3zCPqtBGlBWLS/AwiCDQwxrACam0zfp/G/Kwnlpu6I0sA86YGUtVv2CxYBn2u50NN/tKCIHr9ZUUKjO7e5R5oXB0hk4tiqqEGat41SGKJmMKYqWEN4jEYjolo/+oGh+w6/gGGiBCC/P6Jqd+jLuu4QyrNQSrIFKES8XFo4Bd9UpR4f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39850400004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(30864003)(38350700005)(5660300002)(83380400001)(6666004)(6506007)(83170400001)(38100700002)(1076003)(52116002)(26005)(2616005)(6512007)(478600001)(6916009)(66476007)(66556008)(66946007)(6486002)(41300700001)(8676002)(8936002)(316002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCw8jOZxbLEfFJovZLN4D9yBOTmq7Wp3LUS+JjvVSGbkRWP+tlKA1OHqPsqa?=
 =?us-ascii?Q?zfxgzVQMjV3kJNhx5Ppi4mywCubDr40ed3I64pAYPMHl+tsVXTC7UwfK+TTu?=
 =?us-ascii?Q?Kjt2ChjHQg6qEsOrt/RbyJfQEF76Z6IEgq/2wEieU6i4gL2m9lymPKVHoTY/?=
 =?us-ascii?Q?m07eNUzTZ2u7dJIhl7Yy5VpuBH7WBF5onTFf/jDKnsMK+b65sliEcCaRukh9?=
 =?us-ascii?Q?rRkWdDQC+dzOWe57QkdRvcdZ87XMMWQvkULjORK7u9G52BbyxHiTFhiZ3Uro?=
 =?us-ascii?Q?XNNp+fQrh0zpuhcuhZjhb69JCx3LQ/E0v50SdT+wQjQQwg7Q+hd71GPAQzHr?=
 =?us-ascii?Q?02zV2IXd+tN/VzslWhLgS3Zh8r4clXNLq2MDYdam9+u0N3lqOkonc+rK/SmU?=
 =?us-ascii?Q?w9ZXQuLxqMoiOb751QnP+r/DMezgohnFrH+HYf3RfGkdGQM7E1oczNv72aDE?=
 =?us-ascii?Q?2UR+SiPEH5V+KHZ4sbNAL3Y79Q/CZarswLu91ZU8Sxi9HwfAGhnJSO6+P1WR?=
 =?us-ascii?Q?ol16uDms/nqf2dmL2g8RnjOgbs02/aFrHEAu6jFaYXNAlpzhoqJ43aUITgxa?=
 =?us-ascii?Q?oxRTu3ddP7YscaEzZwdAnA6fC8a64YEZ7p6/tDoUjqkpt0VE7r3sJFhTC2Km?=
 =?us-ascii?Q?lGzi93LvO6C56D0MZQGbfMHdjh4RiByUT1S+SyC4DZ2b/MFGwuBkPtjmLRax?=
 =?us-ascii?Q?tOMXXRAT5XuDUldIwNiaNgriaPpJXlHjOjSU9OxJLIgPH5ZHNlYUZKOIaDXh?=
 =?us-ascii?Q?T1JXDEBU8DfbqExT4kxcqD4JZ2XlNLkhnzutRHf0+btwsWT3hArLv36KT+zZ?=
 =?us-ascii?Q?dGrNwYAg7rA+1OJydBVh24KpS/Q6Sd+qnrCESftrmwIHWIxHKecggQKzHiu4?=
 =?us-ascii?Q?AB+WyhBNJmYlYsVMu9cD7IYWmPRUhyvvOnsxO0HCrQswSvXjXaUVZtlSGVHU?=
 =?us-ascii?Q?GFx29DykyR9JF+/1CQZuWKV3fpgrU48sM3waJJqhxeefgFjn7sDNU8MRDDXj?=
 =?us-ascii?Q?Y6QAE5UKSq5eXakMs7b4TkaqNUflnDYIrLfCMtbrWQiGt/VZ0yhiNIZ//ouH?=
 =?us-ascii?Q?FTJXvxfgm6+2pO6fniRQqDQbQuQvhoZCFpDfeFN9mzzCs4XyrL5hMzS/ySdE?=
 =?us-ascii?Q?e1ioKDkGGqmYtuZ/cYCLooODzsVQe1svNG5kr4zyUKf7wHDunQsA6GVSF+bV?=
 =?us-ascii?Q?NbXlzXxqHJbzys+Trmv77RBKO77rALOzCgR8qsXYuo7GojpJu0oqf8UXx88n?=
 =?us-ascii?Q?rR5VEH1qfuDlUXHPYaHsCgd3YDncGhwEYj5uQZDVmRpxuM18bGDMzLrh+8V1?=
 =?us-ascii?Q?QIRp2qGjEo6P/+JGSK9nY4HbgKNoEmTJakGaobXzxAA4m52Cb4+PlgARg4Tc?=
 =?us-ascii?Q?kAPGXYe9JcpJpIEKVlH95kIy/RpIVQS19tADEQTzR/HhvttYEIXR86zy/PVf?=
 =?us-ascii?Q?ANDN+B+vt8s/uew4qL2dCyCrDKQ9OqJXsOBc3MqjQBM2pBon3XnJO4GOmx/S?=
 =?us-ascii?Q?ZZXuu60a2NYxlDapQ8fKfTfbBmmixGkjztRzo7BTvn8srgcHn3FMSeext/by?=
 =?us-ascii?Q?XChA6JZ4FIaExITjGdCPOHkugN9ILfTS3AI3OGjSkSi37zrTpyS3HvWPHa37?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494adfe5-549f-4acd-4793-08dbfd7987fb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:24:22.0956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H+XpBaX4ytAt5Vl13vavbChDOWPLF0QhEYnYKT9suZWtUQQHDxrSFuxKnxPbKl2mpc1sDQubHmJOmMPTvOpSwjMU0detNzxs03Sv4O+1Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8128
X-Proofpoint-ORIG-GUID: pxAmspxP7XdG6YqEShWNt2GhwIC2h7mL
X-Proofpoint-GUID: pxAmspxP7XdG6YqEShWNt2GhwIC2h7mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150098
Subject: [lttng-dev] [PATCH lttng-tools] tests: skip kernel test when lttng
 driver not install on target rootfs
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
From: Xiangyu Chen via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Xiangyu Chen <xiangyu.chen@windriver.com>

The current tests will run both userspace and kernel testing.
Some of use cases only use lttng for one kind of tracing on
an embedded device (e.g. userspace).
If the lttng modules(.ko files) is not present during the test,
it would end up with lots of failing.

Adding a function in utils.sh to detect whether lttng modules are
installed to target rootfs.
Also applied this function to test scripts, if modules not exist,
skip the test case instead of end up whole testing.

Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tests/destructive/metadata-regeneration             |  3 +++
 tests/perf/test_perf_raw.in                         |  3 +++
 tests/regression/kernel/test_all_events             |  3 +++
 tests/regression/kernel/test_callstack              |  3 +++
 tests/regression/kernel/test_channel                |  3 +++
 tests/regression/kernel/test_clock_override         |  3 +++
 tests/regression/kernel/test_event_basic            |  3 +++
 tests/regression/kernel/test_kernel_function        |  3 +++
 tests/regression/kernel/test_lttng_logger           |  3 +++
 tests/regression/kernel/test_ns_contexts            |  3 +++
 tests/regression/kernel/test_ns_contexts_change     |  3 +++
 tests/regression/kernel/test_rotation_destroy_flush |  3 +++
 tests/regression/kernel/test_select_poll_epoll      |  3 +++
 tests/regression/kernel/test_syscall                |  3 +++
 tests/regression/kernel/test_userspace_probe        |  3 +++
 tests/regression/tools/clear/test_kernel            |  3 +++
 tests/regression/tools/filtering/test_valid_filter  |  3 +++
 tests/regression/tools/health/test_thread_ok        |  2 ++
 tests/regression/tools/live/test_kernel             |  8 ++++++++
 tests/regression/tools/live/test_lttng_kernel       |  3 +++
 tests/regression/tools/metadata/test_kernel         |  3 +++
 .../test_notification_kernel_buffer_usage           |  9 +++++++++
 .../notification/test_notification_kernel_capture   |  8 ++++++++
 .../notification/test_notification_kernel_error     |  8 ++++++++
 .../test_notification_kernel_instrumentation        |  9 +++++++++
 .../tools/notification/test_notification_multi_app  |  7 +++++++
 .../test_notification_notifier_discarded_count      |  7 +++++++
 tests/regression/tools/regen-metadata/test_kernel   |  3 +++
 tests/regression/tools/regen-statedump/test_kernel  |  3 +++
 tests/regression/tools/rotation/test_kernel         |  3 +++
 tests/regression/tools/snapshots/test_kernel        |  3 +++
 tests/regression/tools/tracker/test_event_tracker   |  3 +++
 tests/regression/tools/trigger/test_add_trigger_cli |  3 +++
 .../regression/tools/trigger/test_list_triggers_cli |  6 ++++++
 tests/regression/tools/wildcard/test_event_wildcard |  3 +++
 .../test_rotation_destroy_flush                     |  7 +++++++
 tests/utils/utils.sh                                | 13 +++++++++++++
 37 files changed, 162 insertions(+)

diff --git a/tests/destructive/metadata-regeneration b/tests/destructive/metadata-regeneration
index 048c601b6..d5ae0592a 100755
--- a/tests/destructive/metadata-regeneration
+++ b/tests/destructive/metadata-regeneration
@@ -202,6 +202,9 @@ if ! destructive_tests_enabled ; then
 	exit 0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	original_date=$(date)
diff --git a/tests/perf/test_perf_raw.in b/tests/perf/test_perf_raw.in
index 0a451ce63..4a5a33235 100644
--- a/tests/perf/test_perf_raw.in
+++ b/tests/perf/test_perf_raw.in
@@ -154,6 +154,9 @@ have_libpfm
 
 test_ust_raw
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." 9 ||
 skip $isroot "Root access is needed for kernel testing, skipping." 9 ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/kernel/test_all_events b/tests/regression/kernel/test_all_events
index 2fb2f611d..b7cc100d6 100755
--- a/tests/regression/kernel/test_all_events
+++ b/tests/regression/kernel/test_all_events
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_callstack b/tests/regression/kernel/test_callstack
index cf39089af..0e0ec094b 100755
--- a/tests/regression/kernel/test_callstack
+++ b/tests/regression/kernel/test_callstack
@@ -142,6 +142,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_channel b/tests/regression/kernel/test_channel
index 5525564d2..46e4d228c 100755
--- a/tests/regression/kernel/test_channel
+++ b/tests/regression/kernel/test_channel
@@ -53,6 +53,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_clock_override b/tests/regression/kernel/test_clock_override
index 524c3c3bb..bc80a0f16 100755
--- a/tests/regression/kernel/test_clock_override
+++ b/tests/regression/kernel/test_clock_override
@@ -180,6 +180,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
index 9f22d7db8..fa7066bab 100755
--- a/tests/regression/kernel/test_event_basic
+++ b/tests/regression/kernel/test_event_basic
@@ -79,6 +79,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_kernel_function b/tests/regression/kernel/test_kernel_function
index 131c1c70b..ed83c081a 100755
--- a/tests/regression/kernel/test_kernel_function
+++ b/tests/regression/kernel/test_kernel_function
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond_notap
diff --git a/tests/regression/kernel/test_lttng_logger b/tests/regression/kernel/test_lttng_logger
index 849428807..5842f4d13 100755
--- a/tests/regression/kernel/test_lttng_logger
+++ b/tests/regression/kernel/test_lttng_logger
@@ -116,6 +116,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_ns_contexts b/tests/regression/kernel/test_ns_contexts
index 98b673c98..19d308272 100755
--- a/tests/regression/kernel/test_ns_contexts
+++ b/tests/regression/kernel/test_ns_contexts
@@ -113,6 +113,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_ns_contexts_change b/tests/regression/kernel/test_ns_contexts_change
index 715c67cc8..43df40c68 100755
--- a/tests/regression/kernel/test_ns_contexts_change
+++ b/tests/regression/kernel/test_ns_contexts_change
@@ -168,6 +168,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_rotation_destroy_flush b/tests/regression/kernel/test_rotation_destroy_flush
index 6e568afda..1a9dd6c1f 100755
--- a/tests/regression/kernel/test_rotation_destroy_flush
+++ b/tests/regression/kernel/test_rotation_destroy_flush
@@ -126,6 +126,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_select_poll_epoll b/tests/regression/kernel/test_select_poll_epoll
index cdde1ea4f..72fae27ec 100755
--- a/tests/regression/kernel/test_select_poll_epoll
+++ b/tests/regression/kernel/test_select_poll_epoll
@@ -371,6 +371,9 @@ fi
 
 diag "Supported syscalls are $SUPPORTED_SYSCALLS_LIST"
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_syscall b/tests/regression/kernel/test_syscall
index f9b490858..e43a4a9d0 100755
--- a/tests/regression/kernel/test_syscall
+++ b/tests/regression/kernel/test_syscall
@@ -670,6 +670,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_userspace_probe b/tests/regression/kernel/test_userspace_probe
index bfa260e47..a5d34c52a 100755
--- a/tests/regression/kernel/test_userspace_probe
+++ b/tests/regression/kernel/test_userspace_probe
@@ -821,6 +821,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/clear/test_kernel b/tests/regression/tools/clear/test_kernel
index ce76f85d2..33e375ea2 100755
--- a/tests/regression/tools/clear/test_kernel
+++ b/tests/regression/tools/clear/test_kernel
@@ -565,6 +565,9 @@ snapshot_tests=(test_kernel_streaming_snapshot
 	test_kernel_local_snapshot
 )
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	trap signal_cleanup SIGTERM SIGINT
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index cd5b1a3b9..35e8542c2 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -1460,6 +1460,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel valid filter tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel valid filters"
diff --git a/tests/regression/tools/health/test_thread_ok b/tests/regression/tools/health/test_thread_ok
index 663b7e4cb..a7c964d40 100755
--- a/tests/regression/tools/health/test_thread_ok
+++ b/tests/regression/tools/health/test_thread_ok
@@ -122,6 +122,8 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 test_thread_ok
 
 rm -rf ${HEALTH_PATH}
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index 1be703aac..6d2b2c1b5 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -47,6 +47,14 @@ else
 	exit 0
 fi
 
+detect_lttng_modules_installed
+
+if [ $? == 0 ]; then
+	plan_skip_all "LTTng modules not detected. Skipping all tests."
+	exit 0
+fi
+
+
 modprobe lttng-test
 
 start_lttng_sessiond_notap
diff --git a/tests/regression/tools/live/test_lttng_kernel b/tests/regression/tools/live/test_lttng_kernel
index ae8c57e6b..2b0ddb2f7 100755
--- a/tests/regression/tools/live/test_lttng_kernel
+++ b/tests/regression/tools/live/test_lttng_kernel
@@ -51,6 +51,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/tools/metadata/test_kernel b/tests/regression/tools/metadata/test_kernel
index 9e1e81232..fabedc799 100755
--- a/tests/regression/tools/metadata/test_kernel
+++ b/tests/regression/tools/metadata/test_kernel
@@ -104,6 +104,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel metadata tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/notification/test_notification_kernel_buffer_usage b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
index 5a87583dc..ec4dc3255 100755
--- a/tests/regression/tools/notification/test_notification_kernel_buffer_usage
+++ b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
@@ -63,8 +63,17 @@ function test_buffer_usage_notification
 	wait $APP_PID 2> /dev/null
 }
 
+detect_lttng_modules_installed
+ismodready=$?
+
 if [ "$(id -u)" == "0" ]; then
 
+	if [ $ismodready == 0 ];then
+		plan_tests $NUM_TESTS
+		skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+		exit 0
+	fi
+
 	validate_lttng_modules_present
 
 
diff --git a/tests/regression/tools/notification/test_notification_kernel_capture b/tests/regression/tools/notification/test_notification_kernel_capture
index 88a3691eb..cdb07bb77 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -30,8 +30,16 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+detect_lttng_modules_installed
+ismodready=$?
 
 if [ "$(id -u)" == "0" ]; then
+	if [ $ismodready == 0 ];then
+		plan_tests $NUM_TESTS
+		skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+		exit 0
+	fi
+
 	validate_lttng_modules_present
 
 	modprobe lttng-test
diff --git a/tests/regression/tools/notification/test_notification_kernel_error b/tests/regression/tools/notification/test_notification_kernel_error
index 891146747..2a5454c47 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,8 +30,16 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+detect_lttng_modules_installed
+ismodready=$?
 
 if [ "$(id -u)" == "0" ]; then
+	if [ $ismodready == 0 ]; then
+		plan_tests $NUM_TESTS
+		skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+		exit 0
+	fi
+
 	validate_lttng_modules_present
 
 	modprobe lttng-test
diff --git a/tests/regression/tools/notification/test_notification_kernel_instrumentation b/tests/regression/tools/notification/test_notification_kernel_instrumentation
index b8f0c7eb8..1979a10b9 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,7 +28,16 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
+detect_lttng_modules_installed
+ismodready=$?
+
 if [ "$(id -u)" == "0" ]; then
+	if [ $ismodready == 0 ]; then
+		plan_tests $NUM_TESTS
+		skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+		exit 0
+	fi
+
 	validate_lttng_modules_present
 
 	modprobe lttng-test
diff --git a/tests/regression/tools/notification/test_notification_multi_app b/tests/regression/tools/notification/test_notification_multi_app
index 85d863804..3fc191ca6 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -417,7 +417,14 @@ TESTS=(
 	test_on_register_evaluation_ust
 )
 
+detect_lttng_modules_installed
+ismodready=$?
+
 if [ "$(id -u)" == "0" ]; then
+	if [ ismodready == 0 ]; then
+		skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TEST_KERNEL
+		exit 0
+	fi
 	validate_lttng_modules_present
 	TESTS+=(
 	test_multi_app_kernel
diff --git a/tests/regression/tools/notification/test_notification_notifier_discarded_count b/tests/regression/tools/notification/test_notification_notifier_discarded_count
index 1eb960d02..ffe159931 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -393,9 +393,16 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
+detect_lttng_modules_installed
+ismodready=$?
 
 if [ "$(id -u)" == "0" ]; then
 
+	if [ $ismodready == 0 ]; then
+		skip 0 "LTTng modules not detected. Skipping all tests." $KERNEL_NUM_TESTS
+		exit 1
+	fi
+
 	validate_lttng_modules_present
 
 	modprobe lttng-test
diff --git a/tests/regression/tools/regen-metadata/test_kernel b/tests/regression/tools/regen-metadata/test_kernel
index 7c4191a47..1ef048038 100755
--- a/tests/regression/tools/regen-metadata/test_kernel
+++ b/tests/regression/tools/regen-metadata/test_kernel
@@ -105,6 +105,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/regen-statedump/test_kernel b/tests/regression/tools/regen-statedump/test_kernel
index cb0c0ad5e..7e412774c 100755
--- a/tests/regression/tools/regen-statedump/test_kernel
+++ b/tests/regression/tools/regen-statedump/test_kernel
@@ -45,6 +45,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/rotation/test_kernel b/tests/regression/tools/rotation/test_kernel
index 817019036..c3118981c 100755
--- a/tests/regression/tools/rotation/test_kernel
+++ b/tests/regression/tools/rotation/test_kernel
@@ -113,6 +113,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/snapshots/test_kernel b/tests/regression/tools/snapshots/test_kernel
index 870c437b2..44f4b315d 100755
--- a/tests/regression/tools/snapshots/test_kernel
+++ b/tests/regression/tools/snapshots/test_kernel
@@ -228,6 +228,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel snapshot tests" $NUM_TESTS ||
 {
 
diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 98ca990fc..1efc2209d 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -474,6 +474,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel tracker tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel tracker"
diff --git a/tests/regression/tools/trigger/test_add_trigger_cli b/tests/regression/tools/trigger/test_add_trigger_cli
index 9ba8c22f0..4e7fe54d5 100755
--- a/tests/regression/tools/trigger/test_add_trigger_cli
+++ b/tests/regression/tools/trigger/test_add_trigger_cli
@@ -223,6 +223,7 @@ test_success "--exclude-name two" "trigger5" \
 	--condition event-rule-matches --type=user --name='jean-*' --exclude-name jean-chretien -x jean-charest \
 	--action notify
 
+skip detect_lttng_modules_installed "LTTng modules not detected. Skipping all tests." 18 ||
 skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	i=0
 
@@ -262,6 +263,7 @@ skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	done
 }
 
+skip detect_lttng_modules_installed "LTTng modules not detected. Skipping all tests." 6 ||
 skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 	test_success "--condition event-rule-matches uprobe" "uprobe-trigger-0" \
 		--name="uprobe-trigger-0" \
@@ -274,6 +276,7 @@ skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 		--action notify
 }
 
+skip detect_lttng_modules_installed "LTTng modules not detected. Skipping all tests." 30 ||
 skip $ist_root "non-root user: skipping syscall tests" 30 || {
 	test_success "--condition event-rule-matches one syscall" "syscall-trigger-0" \
 		--name="syscall-trigger-0" \
diff --git a/tests/regression/tools/trigger/test_list_triggers_cli b/tests/regression/tools/trigger/test_list_triggers_cli
index 6194b8891..0567eef41 100755
--- a/tests/regression/tools/trigger/test_list_triggers_cli
+++ b/tests/regression/tools/trigger/test_list_triggers_cli
@@ -2689,15 +2689,21 @@ test_notify_action ()
 }
 
 plan_tests $NUM_TESTS
+detect_lttng_modules_installed
+ismodready=$?
 
 # shellcheck disable=SC2119
 start_lttng_sessiond_notap
 
 test_top_level_options
 test_event_rule_matches_tracepoint
+skip $ismodready "LTTng modules not detected. Skipping all tests." 13 ||
 skip $ist_root "non-root user: skipping kprobe tests" 13 || test_event_rule_matches_probe
+skip $ismodready "LTTng modules not detected. Skipping all tests." 9 ||
 skip $ist_root "non-root user: skipping uprobe tests" 9 || test_event_rule_matches_userspace_probe_elf
+skip $ismodready "LTTng modules not detected. Skipping all tests." 9 ||
 skip $(($ist_root && $hast_sdt_binary)) "skipping userspace probe SDT tests" 9 || test_event_rule_matches_userspace_probe_sdt
+skip $ismodready "LTTng modules not detected. Skipping all tests." 17 ||
 skip $ist_root "non-root user: skipping syscall tests" 17 || test_event_rule_matches_syscall
 test_session_consumed_size_condition
 test_buffer_usage_conditions
diff --git a/tests/regression/tools/wildcard/test_event_wildcard b/tests/regression/tools/wildcard/test_event_wildcard
index 36e669b32..fbc4db958 100755
--- a/tests/regression/tools/wildcard/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -132,6 +132,9 @@ else
 	isroot=0
 fi
 
+detect_lttng_modules_installed
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel wildcard tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel wildcards"
diff --git a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
index 669bcbc43..a9772ecf9 100755
--- a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
+++ b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
@@ -117,6 +117,13 @@ function test_rotation_destroy_flush()
 
 plan_tests $NUM_TESTS
 
+detect_lttng_modules_installed
+
+if [ $? == 0 ]; then
+	skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+	exit 0
+fi
+
 print_test_banner "$TEST_DESC"
 
 TESTS=(
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 44b3f167a..f5cb23056 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -323,6 +323,19 @@ function conf_proc_count()
 	echo
 }
 
+# Check if target rootfs have installed lttng modules.
+# Return 0 if target rootfs don't have lttng module
+function detect_lttng_modules_installed ()
+{
+	# Check for modules
+	KMOD_PATH=`modprobe lttng-tracer -n -v |cut -d ' ' -f2`
+	if [ -f $KMOD_PATH ]; then
+		return 1
+	fi
+
+	return 0
+}
+
 # Check if base lttng-modules are present.
 # Bail out on failure
 function validate_lttng_modules_present ()
-- 
2.35.5

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
