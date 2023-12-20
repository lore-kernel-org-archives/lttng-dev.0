Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AC9C3DA6E
	for <lttng-dev@archiver.kernel.org>; Wed, 20 Dec 2023 05:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1703049338;
	bh=WVVP1dvEhUbQu7McawrR2R/B9WzmuBWxouAvLKlHuBo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=gJ2W6fLF6n+94Kw+YTt9B/Z6/0P5XgffP+bLXAcZCzUa0s1TrDydQU1pqczrp8c9q
	 ce2rlTjKBAuH1HjKvgjTSv4a5cW9zWy4BGO9+GM95DrbriByHvTxmdGscCkZXIDNN/
	 RobytA2VKqMnvNRaTLZI0w0nsSYunDWyPz8W5Vdh1p5SL65jiEmd3aOfZKFta7DJ2Y
	 g+2/rY6gZgiuwlYyNaPSmFBsvKfkTavHkdFn1Q7f+s3GyzkFpT1JH5pYLLIMy5wGhs
	 o5czL84NCiaj6gQYIdicKTBxn+xqdWPPBK7opdnygcbK0KEWqk+QFAy39Du45t6NEJ
	 QzSttEqZRATJA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Sw1wn3qGRz18W7;
	Wed, 20 Dec 2023 00:15:37 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4Sw1wl1tyWz18W0
 for <lttng-dev@lists.lttng.org>; Wed, 20 Dec 2023 00:15:34 -0500 (EST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BK4vcDN012401
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 21:15:28 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1824kurk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 21:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQSNMlkzc/xMwY8Bc7sRmkT4B/viNUxxb6PxpL8k7CJFRt3HsV1NJFk0PDGvfQVc2a9AqJVBhNuHRdcFSV3kvCtIzf6M/6UMj8WlbWvM6L0re0+zc2pzY6SMp/ELjselB/z2sBggXbJpugrVS6U7GnIsHMEyDfdAKU3N3ZCYYfeyn+MMyCj8lVrlr6c2KYXfqaOMouLWJFWRXXNNcTOni+MHo3RFvXyK43kVj1Bh+buOb1Wl0FEnb58hS4sKnEGRzLpz64ax2cLCLleu8tXoSGCBQY7G0KaNOfNVLqUHBx8FUUXyGif2DDChEmjySZCW+UC6vPMRgZJsgJOQPxHo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNreQyx21cFDCIjGp/I/ZexmQQvuXqBKon3yYHCBRBI=;
 b=nyhx6F3RFE5ZKxYWALBNyUTrwaeM9NSgmUGj2Om7YALISG4h+FYA1th1lFu3tOGmwtc75lrOZZFQqMpt/pjoY1XhghJU+T6tcg4SdhIHy6eZ62HmWYv2tMMO2IJRb0az3bU3T68TpO044qTDc+76b5v6aeKUQ+JUAu10DnHvf9juFWQGiD4y5l/dqg+3wcXoZsMK0vOZQU6vgG8YNVYbRTyKV/gtb8vWcCtRXjJzqGt6bDn9mkmF1JF5UQB7ZqdDtzKM7BrGY3b/Iyz+72S1DJ2F+cR/kK4QLXA7ReqiAvB7KAkxYdjx+YeabnLwsiU1daUzckXsggnlLmKlu8s0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH8PR11MB6855.namprd11.prod.outlook.com (2603:10b6:510:22c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 05:15:22 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 05:15:21 +0000
To: lttng-dev@lists.lttng.org
Date: Wed, 20 Dec 2023 13:50:12 +0800
Message-Id: <20231220055012.1769681-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.35.5
X-ClientProxiedBy: TYAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:404:29::33) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH8PR11MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb87fd5-b890-442b-6123-08dc011aa9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSmjGLmhW9DC1kCyz9hfLyngsafS7suZEIPtEbFTxA0OkyBfKwRF3r/xa0HtfNuBtVxJwBAKs4O1ZVUbSiZhZ5Efcpv9pERx7/BKhTe9wn7h0UfzrnOBeXYEYDkEeBYGz7ilEPa+k8Vtx6b1+hU/JNd4MYKmcHRtZlm92gIg0YR3e7piBvB6+6y6F0+U6qcWhHBOUnZbYG5piIUSYM23H+4QUjmocHZRCISRkpyA+8IzdI6uYEQIJfSnmLcqkbgB9e4OQUEdkHwvaqyLLTwSqmOkrY2pUGuzVZJYrpFZyb2ryVb9ZZZC5ZO8VqQtvoWYg2tzV/jYbryL4KEom95VXX6y0movtcIjoFk8TTzb3BFY1inBsAFKo1mDTdpyP5p1sEgd1qXMk+jZUNz4N3TguzUPP0p4WAMCpUWOImDz4vg/oivUWRWWzYjEUi9+tkYOiK5VCytqVSRl9CVIHGPagxcIx1mCHwQXLugla0eJktGDb8XUyY3JkwaMYK7YJZRulRKJOILMbl2NKO+5WVRgdpM5tJTF3/cTInTZxnDCdF2LIl6wm2TtGdcsaiJmIfZHwzz4w750LhJrz32cHioTd/t39kBYwLK1msLi0xDCtOWV1Rb//LFrNdN9kW0FHmrP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39850400004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(6486002)(2616005)(1076003)(6666004)(6512007)(66476007)(66556008)(83380400001)(6916009)(66946007)(316002)(52116002)(5660300002)(44832011)(8676002)(8936002)(6506007)(26005)(30864003)(83170400001)(2906002)(38100700002)(41300700001)(38350700005)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WERDQCs6WXyRxKOGr8Ntr0zvpjWR6PYQJ6nIjB3KOOHWXS8cx1mf0fszRmiJ?=
 =?us-ascii?Q?oH5osqwTLhs5jVg0fAQVTUD2n5lfk8Bpl3SLtnVDQHYzb2/mJnYkkvmhT7rY?=
 =?us-ascii?Q?N4m5iKu2Pbh/PFFqBO56J/9SHsviuWD9ab4Q6YvPIyn/Gahe6o3tKAmP1s1t?=
 =?us-ascii?Q?gdA4lscLPk1jhCPfJ7/lHcOvtOio49vaaavhnR/1QTpdQt3squCiHTCzSrJy?=
 =?us-ascii?Q?/tn3DvP5SPbNm4WLxdKDPtdWndhosfTx1ojLFBSt8BxCNAcWviKGunXZ8Rcm?=
 =?us-ascii?Q?YY8nH4OeHFeFmHm9BdeHxGOoaX7ujx3hEoBrRZL56049LjHkeFxDDG4mqISr?=
 =?us-ascii?Q?spiA93Z5yjwr3VFMgCsxSMVD0cajWJwaUgGZvO22TrYlkckF4VZGK7YYxQB7?=
 =?us-ascii?Q?dLP+LTHCF25r4X1o5O+TgQJJnnaJLzz/5Jf7DjOsiHVwLm0icpMmL+5tp/M4?=
 =?us-ascii?Q?OHyPPFhPfC+xoBEV8nOtjTI7WvavoDuoFYr9oi3oBROIiZ8Kf2ApApNzhS0w?=
 =?us-ascii?Q?cMxOzJfOCB9O7yTVwnqd603hJWUnEpo6j0pJbbbaPW0y17KgojmPA/XXPMlh?=
 =?us-ascii?Q?z83egXlSBTCF8YMSw/g/Bd7zH4CO050o28r81O/I/fBvwWjaVR4LmD2yl+g7?=
 =?us-ascii?Q?RXYWFNr07taW1G57KySDrHwdHbr+ajGLHDDafg/ZhFfBd5vfqAIgvjyc2J8n?=
 =?us-ascii?Q?NsdbjpS6K8As0PI5tC0ETofGW7LqCJ3rNvcIelJeuv18o+g4pFgcJ+1+e6+Z?=
 =?us-ascii?Q?EgzCWki7V8NbjxG99AtwamN3MPlg+uuqWP5M+PIsJ3vSUG9KCgRINHqOelSu?=
 =?us-ascii?Q?IogmAlTO8+no1olneo+F2BfMjwcmmU9ywfmzmsybwJMNQcICR9xcvigkACTD?=
 =?us-ascii?Q?w3oKatRtUFa1TfQEN6tBCuJ4qtEfHE9vuTP4RG0PnK6DXiqicym9sgEWbYrR?=
 =?us-ascii?Q?fEdgctL7z81/J5XayvxK4hrtm4IpeLAEfvpNaifB4KbDqErx1Oz1e3b74EDs?=
 =?us-ascii?Q?x1FGkmFSmg5oKgxSdbqmyM3nU4vw+cIfwT8LXmqERoOvWj/PZ1dSLtp2Sb5x?=
 =?us-ascii?Q?CxoqsJoU4dMHznZ/T/DUgCIoeAl1BTaTC7lvQoaHX/qRgXS+wYCIKu2zzK2V?=
 =?us-ascii?Q?mJYwEgxSJLybrxHJeBgRpqujm+8gFdW3T/qJwWMN6YmoV1pUeUVCqJ2a6i2F?=
 =?us-ascii?Q?6PxHLsiHdElIk3yzRlFQFiLHbsqetK5Rgue+373h+FDsKjCbRlYXFQXE/c/F?=
 =?us-ascii?Q?db4Fx+ejCZXCh5XNT9TU9RhF5vV28wRQOAlF5MAU3JthaM2AZqFsMbgaBg5o?=
 =?us-ascii?Q?HTE3mb4mJMRJRIGCAqgVE91t/I4Cn+JuBBosp7MKZEqSQ292HUEHjHnikrCs?=
 =?us-ascii?Q?RBK461fnJcqAnwk5RZksNOoKqYa2rMbhhZFVQM/xzg+RTZ/D731cDb/W0VJx?=
 =?us-ascii?Q?bQWMsE84oKjefAPrhP8vFnWoApHbwyTBIvUSMcx5H4rsP1XoTry4ok5i8eto?=
 =?us-ascii?Q?WUqgvx7Yb/MsULLw8VvcTXQ8TyEEqQ1YDol/c1dHWBIWFqCGLlCe/Kt6Rsjx?=
 =?us-ascii?Q?HbS85fNRLKNGHTMkj5eXB2SGc/+gZm8wYJsquL967LNvM8RGabE6y4tJOsFD?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb87fd5-b890-442b-6123-08dc011aa9ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 05:15:21.0425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGTEZC7jyookeHGL+Bz4JmjToddiuC5WADAPe3kk21r16ql92JvWDZKR2NpBSlA1shdJUubnHSjEJLrS1wca4tPYfJ+gNEXYvr81JDyVsas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6855
X-Proofpoint-ORIG-GUID: tvdNEbMcWFB5d0X2DHL2dH802ZxaJVOy
X-Proofpoint-GUID: tvdNEbMcWFB5d0X2DHL2dH802ZxaJVOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200032
Subject: [lttng-dev] [PATCH v5 lttng-tools] tests: add
 check_skip_kernel_test to check root user and lttng kernel modules
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
an embedded device (e.g. userspace), so in this scenario,
the kernel modules might not install to target rootfs, the
test cases would be fail and exit.

Add LTTNG_TOOLS_DISABLE_KERNEL_TESTS to skip the lttng kernel
features test, this flag can be set via "make":

make check LTTNG_TOOLS_DISABLE_KERNEL_TESTS=1

When this flag was set, all kernel related testcases would be marked
as SKIP in result.

Since the the LTTNG_TOOLS_DISABLE_KERNEL_TESTS was checked in function
check_skip_kernel_test, lots of testcases also need to check root
permission, so merging the root permission checking into check_skip_kernel_test.

Change-Id: If6d6e7ff9b3599340e5b07cdee4e1f36a856f4a2
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tests/destructive/metadata-regeneration       |  8 +----
 tests/perf/test_perf_raw.in                   |  8 +----
 tests/regression/kernel/test_all_events       |  8 +----
 tests/regression/kernel/test_callstack        |  8 +----
 tests/regression/kernel/test_channel          |  8 +----
 tests/regression/kernel/test_clock_override   |  8 +----
 tests/regression/kernel/test_event_basic      |  8 +----
 tests/regression/kernel/test_kernel_function  |  8 +----
 tests/regression/kernel/test_lttng_logger     |  7 +---
 tests/regression/kernel/test_ns_contexts      |  8 +----
 .../regression/kernel/test_ns_contexts_change |  9 +----
 .../kernel/test_rotation_destroy_flush        |  8 +----
 .../regression/kernel/test_select_poll_epoll  |  8 +----
 tests/regression/kernel/test_syscall          |  8 +----
 tests/regression/kernel/test_userspace_probe  |  8 +----
 tests/regression/tools/clear/test_kernel      |  8 +----
 .../tools/filtering/test_invalid_filter       |  8 +----
 .../tools/filtering/test_unsupported_op       |  8 +----
 .../tools/filtering/test_valid_filter         |  8 +----
 tests/regression/tools/health/test_health.sh  | 10 ++----
 tests/regression/tools/health/test_thread_ok  | 10 ++----
 tests/regression/tools/live/test_kernel       | 10 +++---
 tests/regression/tools/live/test_lttng_kernel |  8 +----
 tests/regression/tools/metadata/test_kernel   |  8 +----
 .../test_notification_kernel_buffer_usage     | 15 ++++----
 .../test_notification_kernel_capture          | 12 +++----
 .../test_notification_kernel_error            | 10 +++---
 .../test_notification_kernel_instrumentation  | 12 +++----
 .../test_notification_kernel_syscall          | 12 +++----
 .../test_notification_kernel_userspace_probe  | 11 +++---
 .../notification/test_notification_multi_app  | 16 ++++-----
 ...test_notification_notifier_discarded_count | 36 +++++++++----------
 .../tools/regen-metadata/test_kernel          |  8 +----
 .../tools/regen-statedump/test_kernel         |  8 +----
 tests/regression/tools/rotation/test_kernel   |  8 +----
 .../regression/tools/rotation/test_ust_kernel |  8 +----
 tests/regression/tools/snapshots/test_kernel  |  9 +----
 .../tools/snapshots/test_kernel_streaming     |  8 +----
 .../tools/snapshots/test_ust_streaming        |  6 ----
 .../streaming/test_high_throughput_limits     |  8 +----
 tests/regression/tools/streaming/test_kernel  |  8 +----
 .../tools/tracker/test_event_tracker          |  8 +----
 .../tools/trigger/test_add_trigger_cli        | 12 ++-----
 .../tools/trigger/test_list_triggers_cli      |  6 ++++
 .../tools/wildcard/test_event_wildcard        |  8 +----
 .../test_relayd_working_directory             |  8 +----
 .../ust/namespaces/test_ns_contexts_change    |  7 +---
 tests/regression/ust/test_event_perf          |  8 +----
 tests/utils/utils.sh                          | 33 +++++++++++++++++
 49 files changed, 138 insertions(+), 345 deletions(-)

diff --git a/tests/destructive/metadata-regeneration b/tests/destructive/metadata-regeneration
index 048c601b6..457f0b9dd 100755
--- a/tests/destructive/metadata-regeneration
+++ b/tests/destructive/metadata-regeneration
@@ -189,12 +189,6 @@ function test_ust_streaming ()
 	rm -f "${file_sync_before_last}"
 }
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 if ! destructive_tests_enabled ; then
 	echo 'Please make sure that ntp is not running while executing this test'
 	skip 0 "You need to set the LTTNG_ENABLE_DESTRUCTIVE_TESTS environment variable to \"will-break-my-system\" to run this test" $NUM_TESTS
@@ -202,7 +196,7 @@ if ! destructive_tests_enabled ; then
 	exit 0
 fi
 
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test $NUM_TESTS ||
 {
 	original_date=$(date)
 	start_lttng_relayd "-o $TRACE_PATH"
diff --git a/tests/perf/test_perf_raw.in b/tests/perf/test_perf_raw.in
index 0a451ce63..f02a103cc 100644
--- a/tests/perf/test_perf_raw.in
+++ b/tests/perf/test_perf_raw.in
@@ -137,12 +137,6 @@ function test_kernel_raw()
 	rm -rf $TRACE_PATH
 }
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 # MUST set TESTDIR before calling those functions
 plan_tests $NUM_TESTS
 
@@ -154,7 +148,7 @@ have_libpfm
 
 test_ust_raw
 
-skip $isroot "Root access is needed for kernel testing, skipping." 9 ||
+check_skip_kernel_test $NUM_TESTS ||
 {
 	modprobe lttng-test
 	test_kernel_raw
diff --git a/tests/regression/kernel/test_all_events b/tests/regression/kernel/test_all_events
index 2fb2f611d..636469dea 100755
--- a/tests/regression/kernel/test_all_events
+++ b/tests/regression/kernel/test_all_events
@@ -43,13 +43,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_callstack b/tests/regression/kernel/test_callstack
index cf39089af..1467e7942 100755
--- a/tests/regression/kernel/test_callstack
+++ b/tests/regression/kernel/test_callstack
@@ -136,13 +136,7 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_channel b/tests/regression/kernel/test_channel
index 5525564d2..f399f5038 100755
--- a/tests/regression/kernel/test_channel
+++ b/tests/regression/kernel/test_channel
@@ -47,13 +47,7 @@ function test_channel_buffer_too_large()
 plan_tests $NUM_TESTS
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	start_lttng_sessiond
 
diff --git a/tests/regression/kernel/test_clock_override b/tests/regression/kernel/test_clock_override
index 524c3c3bb..53c75d3a5 100755
--- a/tests/regression/kernel/test_clock_override
+++ b/tests/regression/kernel/test_clock_override
@@ -174,13 +174,7 @@ TESTS=(
 TEST_COUNT=${#TESTS[@]}
 i=0
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	trap signal_cleanup SIGTERM SIGINT
diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
index 9f22d7db8..20215a11f 100755
--- a/tests/regression/kernel/test_event_basic
+++ b/tests/regression/kernel/test_event_basic
@@ -73,13 +73,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test $NUM_TESTS ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_kernel_function b/tests/regression/kernel/test_kernel_function
index 131c1c70b..bfdf0091a 100755
--- a/tests/regression/kernel/test_kernel_function
+++ b/tests/regression/kernel/test_kernel_function
@@ -43,13 +43,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	start_lttng_sessiond_notap
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_lttng_logger b/tests/regression/kernel/test_lttng_logger
index 849428807..d1b9567ee 100755
--- a/tests/regression/kernel/test_lttng_logger
+++ b/tests/regression/kernel/test_lttng_logger
@@ -110,13 +110,8 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
 
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_ns_contexts b/tests/regression/kernel/test_ns_contexts
index 98b673c98..9ada1655a 100755
--- a/tests/regression/kernel/test_ns_contexts
+++ b/tests/regression/kernel/test_ns_contexts
@@ -108,13 +108,7 @@ plan_tests $NUM_TESTS
 print_test_banner "$TEST_DESC"
 
 
-isroot=0
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
-
+check_skip_kernel_test "$NUM_TESTS" && exit 0
 
 system_has_ns=0
 if [ -d "/proc/$$/ns" ]; then
diff --git a/tests/regression/kernel/test_ns_contexts_change b/tests/regression/kernel/test_ns_contexts_change
index 715c67cc8..d2826ba88 100755
--- a/tests/regression/kernel/test_ns_contexts_change
+++ b/tests/regression/kernel/test_ns_contexts_change
@@ -162,14 +162,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-
-isroot=0
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
-
+check_skip_kernel_test "$NUM_TESTS" && exit 0
 
 system_has_ns=0
 if [ -d "/proc/$$/ns" ]; then
diff --git a/tests/regression/kernel/test_rotation_destroy_flush b/tests/regression/kernel/test_rotation_destroy_flush
index 6e568afda..b2df95811 100755
--- a/tests/regression/kernel/test_rotation_destroy_flush
+++ b/tests/regression/kernel/test_rotation_destroy_flush
@@ -120,13 +120,7 @@ TESTS=(
 TEST_COUNT=${#TESTS[@]}
 i=0
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	trap signal_cleanup SIGTERM SIGINT
diff --git a/tests/regression/kernel/test_select_poll_epoll b/tests/regression/kernel/test_select_poll_epoll
index cdde1ea4f..1f457be21 100755
--- a/tests/regression/kernel/test_select_poll_epoll
+++ b/tests/regression/kernel/test_select_poll_epoll
@@ -363,15 +363,9 @@ if test $? != 0; then
 	exit 0
 fi
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 diag "Supported syscalls are $SUPPORTED_SYSCALLS_LIST"
 
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/kernel/test_syscall b/tests/regression/kernel/test_syscall
index f9b490858..20130dde9 100755
--- a/tests/regression/kernel/test_syscall
+++ b/tests/regression/kernel/test_syscall
@@ -664,13 +664,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_userspace_probe b/tests/regression/kernel/test_userspace_probe
index bfa260e47..8e9002e2b 100755
--- a/tests/regression/kernel/test_userspace_probe
+++ b/tests/regression/kernel/test_userspace_probe
@@ -815,13 +815,7 @@ fi
 plan_tests $NUM_TESTS
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/tools/clear/test_kernel b/tests/regression/tools/clear/test_kernel
index ce76f85d2..5f86ae386 100755
--- a/tests/regression/tools/clear/test_kernel
+++ b/tests/regression/tools/clear/test_kernel
@@ -538,12 +538,6 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 streaming_tests=(test_kernel_streaming
 	test_kernel_streaming_rotate_clear
 	test_kernel_streaming_clear_rotate
@@ -565,7 +559,7 @@ snapshot_tests=(test_kernel_streaming_snapshot
 	test_kernel_local_snapshot
 )
 
-skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	trap signal_cleanup SIGTERM SIGINT
 
diff --git a/tests/regression/tools/filtering/test_invalid_filter b/tests/regression/tools/filtering/test_invalid_filter
index 8dfbe9eb5..839d6aff8 100755
--- a/tests/regression/tools/filtering/test_invalid_filter
+++ b/tests/regression/tools/filtering/test_invalid_filter
@@ -170,13 +170,7 @@ done
 
 test_bytecode_limit -u
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel invalid filter tests." $NUM_KERNEL_TESTS ||
+check_skip_kernel_test "$NUM_KERNEL_TESTS" ||
 {
 	diag "Test kernel filters"
 	i=0
diff --git a/tests/regression/tools/filtering/test_unsupported_op b/tests/regression/tools/filtering/test_unsupported_op
index dc76f99a6..e8101bdda 100755
--- a/tests/regression/tools/filtering/test_unsupported_op
+++ b/tests/regression/tools/filtering/test_unsupported_op
@@ -103,13 +103,7 @@ while [ "$i" -lt "$OP_COUNT" ]; do
 	let "i++"
 done
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel unsupported filter operations tests." $NUM_KERNEL_TESTS ||
+check_skip_kernel_test $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel unsupported filter operations"
 
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index cd5b1a3b9..f8d3abc0b 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -1454,13 +1454,7 @@ KERNEL_FILTERS=(
 
 IFS=$OLDIFS
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel valid filter tests." $NUM_KERNEL_TESTS ||
+check_skip_kernel_test "$NUM_KERNEL_TESTS" ||
 {
 	diag "Test kernel valid filters"
 
diff --git a/tests/regression/tools/health/test_health.sh b/tests/regression/tools/health/test_health.sh
index b4b416f92..85810d8e9 100644
--- a/tests/regression/tools/health/test_health.sh
+++ b/tests/regression/tools/health/test_health.sh
@@ -82,7 +82,7 @@ function test_health
 		diag "With UST consumer daemons"
 		enable_ust_lttng_event_ok $SESSION_NAME $UST_EVENT_NAME $CHANNEL_NAME
 
-		skip $isroot "Root access is needed. Skipping kernel consumer health check test." "1" ||
+		check_skip_kernel_test "1" ||
 		{
 			diag "With kernel consumer daemon"
 			lttng_enable_kernel_event $SESSION_NAME $KERNEL_EVENT_NAME $CHANNEL_NAME
@@ -113,7 +113,7 @@ function test_health
 
 
 	if [ ${test_needs_root} -eq 1 ]; then
-		skip ${isroot} "Root access needed for test \"${test_thread_name}\"." "1" ||
+		check_skip_kernel_test "1" ||
 		{
 			report_errors "${test_thread_error_string}" "${test_relayd}"
 		}
@@ -271,12 +271,6 @@ STDERR_PATH=$(mktemp -t tmp.test_health_stderr_path.XXXXXX)
 TRACE_PATH=$(mktemp -d -t tmp.test_health_trace_path.XXXXXX)
 HEALTH_PATH=$(mktemp -d -t tmp.test_health_trace_path.XXXXXX)
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 THREAD_COUNT=${#THREAD[@]}
 i=0
 while [ "$i" -lt "$THREAD_COUNT" ]; do
diff --git a/tests/regression/tools/health/test_thread_ok b/tests/regression/tools/health/test_thread_ok
index 663b7e4cb..21aab0133 100755
--- a/tests/regression/tools/health/test_thread_ok
+++ b/tests/regression/tools/health/test_thread_ok
@@ -67,7 +67,7 @@ function test_thread_ok
 	$CURDIR/$HEALTH_CHECK_BIN > ${STDOUT_PATH} 2> ${STDERR_PATH}
 	report_errors
 
-	skip $isroot "Root access is needed. Skipping kernel consumer health check test." "5" ||
+	check_skip_kernel_test "5" ||
 	{
 		diag "With kernel consumer daemon"
 		create_lttng_session_no_output $SESSION_NAME
@@ -115,13 +115,7 @@ STDERR_PATH=$(mktemp -t tmp.test_thread_ok_stderr_path.XXXXXX)
 TRACE_PATH=$(mktemp -d -t tmp.test_thread_ok_trace_path.XXXXXX)
 HEALTH_PATH=$(mktemp -d -t tmp.test_thread_ok_trace_path.XXXXXX)
 
-# The manage kernel thread is only spawned if we are root
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
+check_skip_kernel_test "$NUM_TESTS" ||
 test_thread_ok
 
 rm -rf ${HEALTH_PATH}
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index 1be703aac..6d8909d09 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -39,13 +39,11 @@ function clean_live_tracing()
 	rm -rf $TRACE_PATH
 }
 
-# Need root access for kernel tracing.
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	plan_skip_all "Root access is needed. Skipping all tests."
+check_skip_kernel_test ||
+{
+	plan_skip_all "Skipping all tests."
 	exit 0
-fi
+}
 
 modprobe lttng-test
 
diff --git a/tests/regression/tools/live/test_lttng_kernel b/tests/regression/tools/live/test_lttng_kernel
index ae8c57e6b..91f526ceb 100755
--- a/tests/regression/tools/live/test_lttng_kernel
+++ b/tests/regression/tools/live/test_lttng_kernel
@@ -45,13 +45,7 @@ function clean_live_tracing()
 }
 
 # Need root access for kernel tracing.
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	modprobe lttng-test
 
diff --git a/tests/regression/tools/metadata/test_kernel b/tests/regression/tools/metadata/test_kernel
index 9e1e81232..01053541d 100755
--- a/tests/regression/tools/metadata/test_kernel
+++ b/tests/regression/tools/metadata/test_kernel
@@ -98,13 +98,7 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel metadata tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	modprobe lttng-test
diff --git a/tests/regression/tools/notification/test_notification_kernel_buffer_usage b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
index 5a87583dc..88f05eff8 100755
--- a/tests/regression/tools/notification/test_notification_kernel_buffer_usage
+++ b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
@@ -63,10 +63,12 @@ function test_buffer_usage_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+plan_tests "$NUM_TESTS"
 
-	validate_lttng_modules_present
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 
+	validate_lttng_modules_present
 
 	modprobe lttng-test
 
@@ -80,12 +82,7 @@ if [ "$(id -u)" == "0" ]; then
 
 	stop_lttng_sessiond_notap
 	rmmod lttng-test
+}
 
-	rm -rf "${consumerd_pipe[@]}" 2> /dev/null
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
-
+rm -rf "${consumerd_pipe[@]}" 2> /dev/null
 rm -rf "$TEST_TMPDIR"
diff --git a/tests/regression/tools/notification/test_notification_kernel_capture b/tests/regression/tools/notification/test_notification_kernel_capture
index 88a3691eb..808bf1f51 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -31,7 +31,10 @@ function test_basic_error_path
 }
 
 
-if [ "$(id -u)" == "0" ]; then
+plan_tests "$NUM_TESTS"
+
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -42,11 +45,6 @@ if [ "$(id -u)" == "0" ]; then
 
 	stop_lttng_sessiond_notap
 	rmmod lttng-test
-
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+}
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_error b/tests/regression/tools/notification/test_notification_kernel_error
index 891146747..a9fa65cab 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,8 +30,10 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+plan_tests $NUM_TESTS
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -42,11 +44,7 @@ if [ "$(id -u)" == "0" ]; then
 
 	stop_lttng_sessiond_notap
 	rmmod lttng-test
+}
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_instrumentation b/tests/regression/tools/notification/test_notification_kernel_instrumentation
index b8f0c7eb8..31cbc7794 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,7 +28,10 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+plan_tests "$NUM_TESTS"
+
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -39,11 +42,6 @@ if [ "$(id -u)" == "0" ]; then
 
 	stop_lttng_sessiond_notap
 	rmmod lttng-test
-
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+}
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_syscall b/tests/regression/tools/notification/test_notification_kernel_syscall
index ba12716fd..5dbbe5c2a 100755
--- a/tests/regression/tools/notification/test_notification_kernel_syscall
+++ b/tests/regression/tools/notification/test_notification_kernel_syscall
@@ -31,7 +31,10 @@ function test_kernel_syscall_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+plan_tests $NUM_TESTS
+
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	start_lttng_sessiond_notap
@@ -39,11 +42,6 @@ if [ "$(id -u)" == "0" ]; then
 	test_kernel_syscall_notification
 
 	stop_lttng_sessiond_notap
-
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+}
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_userspace_probe b/tests/regression/tools/notification/test_notification_kernel_userspace_probe
index 065e66add..25fb09f0d 100755
--- a/tests/regression/tools/notification/test_notification_kernel_userspace_probe
+++ b/tests/regression/tools/notification/test_notification_kernel_userspace_probe
@@ -29,7 +29,10 @@ function test_kernel_userspace_probe_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+plan_tests "$NUM_TESTS"
+
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	start_lttng_sessiond_notap
@@ -37,10 +40,6 @@ if [ "$(id -u)" == "0" ]; then
 	test_kernel_userspace_probe_notification
 
 	stop_lttng_sessiond_notap
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+}
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_multi_app b/tests/regression/tools/notification/test_notification_multi_app
index 85d863804..32482eeaa 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -417,15 +417,15 @@ TESTS=(
 	test_on_register_evaluation_ust
 )
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
-	TESTS+=(
-	test_multi_app_kernel
-	test_on_register_evaluation_kernel
+plan_tests "$NUM_TESTS"
+
+check_skip_kernel_test "$NUM_TESTS" && exit 0
+
+validate_lttng_modules_present
+TESTS+=(
+test_multi_app_kernel
+test_on_register_evaluation_kernel
 )
-else
-        skip 0 "Root access is needed. Skipping all kernel multi-app notification tests." $NUM_TEST_KERNEL
-fi
 
 
 for fct_test in ${TESTS[@]};
diff --git a/tests/regression/tools/notification/test_notification_notifier_discarded_count b/tests/regression/tools/notification/test_notification_notifier_discarded_count
index 1eb960d02..ed1c310d3 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -394,31 +394,27 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$KERNEL_NUM_TESTS" && exit 0
 
-	validate_lttng_modules_present
+validate_lttng_modules_present
 
-	modprobe lttng-test
+modprobe lttng-test
 
-	test_kernel_notifier_discarded_count
-	test_kernel_notifier_discarded_count_max_bucket
+test_kernel_notifier_discarded_count
+test_kernel_notifier_discarded_count_max_bucket
 
-	if destructive_tests_enabled ; then
-		# Those tests add a new user on the system. Since it's a quite
-		# intrusive change to the system, we decide to only run it when
-		# the user knows what they are doing.
-		test_ust_notifier_discarded_count_multi_uid
-		test_ust_notifier_discarded_regardless_trigger_owner
-	else
-		skip 0 "You need to set the LTTNG_ENABLE_DESTRUCTIVE_TESTS environment variable to \"will-break-my-system\" to run this test" $DESTRUCTIVE_TESTS_NUM
-	fi
-
-	modprobe --remove lttng-test
-
-	rm -rf "${sessiond_pipe[@]}" 2> /dev/null
+if destructive_tests_enabled ; then
+	# Those tests add a new user on the system. Since it's a quite
+	# intrusive change to the system, we decide to only run it when
+	# the user knows what they are doing.
+	test_ust_notifier_discarded_count_multi_uid
+	test_ust_notifier_discarded_regardless_trigger_owner
 else
-	# Kernel tests are skipped.
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $KERNEL_NUM_TESTS
+	skip 0 "You need to set the LTTNG_ENABLE_DESTRUCTIVE_TESTS environment variable to \"will-break-my-system\" to run this test" $DESTRUCTIVE_TESTS_NUM
 fi
 
+modprobe --remove lttng-test
+
+rm -rf "${sessiond_pipe[@]}" 2> /dev/null
+
 rm -rf "$TEST_TMPDIR"
diff --git a/tests/regression/tools/regen-metadata/test_kernel b/tests/regression/tools/regen-metadata/test_kernel
index 7c4191a47..eb37783d2 100755
--- a/tests/regression/tools/regen-metadata/test_kernel
+++ b/tests/regression/tools/regen-metadata/test_kernel
@@ -99,13 +99,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/tools/regen-statedump/test_kernel b/tests/regression/tools/regen-statedump/test_kernel
index cb0c0ad5e..d33bdf478 100755
--- a/tests/regression/tools/regen-statedump/test_kernel
+++ b/tests/regression/tools/regen-statedump/test_kernel
@@ -39,13 +39,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 	start_lttng_sessiond
diff --git a/tests/regression/tools/rotation/test_kernel b/tests/regression/tools/rotation/test_kernel
index 817019036..92903c3cc 100755
--- a/tests/regression/tools/rotation/test_kernel
+++ b/tests/regression/tools/rotation/test_kernel
@@ -107,13 +107,7 @@ plan_tests $NUM_TESTS
 print_test_banner "$TEST_DESC"
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/tools/rotation/test_ust_kernel b/tests/regression/tools/rotation/test_ust_kernel
index 2f19e807a..c6d9373e7 100755
--- a/tests/regression/tools/rotation/test_ust_kernel
+++ b/tests/regression/tools/rotation/test_ust_kernel
@@ -85,13 +85,7 @@ plan_tests $NUM_TESTS
 print_test_banner "$TEST_DESC"
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/tools/snapshots/test_kernel b/tests/regression/tools/snapshots/test_kernel
index 870c437b2..f30ead382 100755
--- a/tests/regression/tools/snapshots/test_kernel
+++ b/tests/regression/tools/snapshots/test_kernel
@@ -221,14 +221,7 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel snapshot tests" $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/snapshots/test_kernel_streaming b/tests/regression/tools/snapshots/test_kernel_streaming
index 2abd838e7..5a1eb3a42 100755
--- a/tests/regression/tools/snapshots/test_kernel_streaming
+++ b/tests/regression/tools/snapshots/test_kernel_streaming
@@ -145,13 +145,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel streaming tests" $NUM_TESTS ||
+check_skip_kernel_test $NUM_TESTS ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/tools/snapshots/test_ust_streaming b/tests/regression/tools/snapshots/test_ust_streaming
index 3104afb3b..1278605dc 100755
--- a/tests/regression/tools/snapshots/test_ust_streaming
+++ b/tests/regression/tools/snapshots/test_ust_streaming
@@ -234,12 +234,6 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 start_lttng_relayd "-o $TRACE_PATH"
 start_lttng_sessiond
 
diff --git a/tests/regression/tools/streaming/test_high_throughput_limits b/tests/regression/tools/streaming/test_high_throughput_limits
index 50c21df4d..a7d4317b4 100755
--- a/tests/regression/tools/streaming/test_high_throughput_limits
+++ b/tests/regression/tools/streaming/test_high_throughput_limits
@@ -174,13 +174,7 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed to set bandwith limits. Skipping all tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 
 	# Catch sigint and try to cleanup limits
diff --git a/tests/regression/tools/streaming/test_kernel b/tests/regression/tools/streaming/test_kernel
index aef1e11bc..2beb4b015 100755
--- a/tests/regression/tools/streaming/test_kernel
+++ b/tests/regression/tools/streaming/test_kernel
@@ -47,13 +47,7 @@ plan_tests $NUM_TESTS
 
 print_test_banner "$TEST_DESC"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
+check_skip_kernel_test "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
 
diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 98ca990fc..3840b4676 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -468,13 +468,7 @@ test_event_track_untrack ust 0 "${EVENT_NAME}" "--pid --all"	# backward compat
 test_event_tracker ust 1 "${EVENT_NAME}" "--pid --all"	# backward compat
 test_event_pid_tracker ust 1 "${EVENT_NAME}"
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel tracker tests." $NUM_KERNEL_TESTS ||
+check_skip_kernel_test "$NUM_KERNEL_TESTS" ||
 {
 	diag "Test kernel tracker"
 
diff --git a/tests/regression/tools/trigger/test_add_trigger_cli b/tests/regression/tools/trigger/test_add_trigger_cli
index 9ba8c22f0..0dc4c6b2f 100755
--- a/tests/regression/tools/trigger/test_add_trigger_cli
+++ b/tests/regression/tools/trigger/test_add_trigger_cli
@@ -34,12 +34,6 @@ tmp_stdout=$(mktemp -t test_parse_cli_trigger_stdout.XXXXXX)
 tmp_stderr=$(mktemp -t test_parse_cli_trigger_stderr.XXXXXX)
 uprobe_elf_binary="${TESTDIR}/utils/testapp/userspace-probe-elf-binary/.libs/userspace-probe-elf-binary"
 
-if [ "$(id -u)" == "0" ]; then
-	ist_root=1
-else
-	ist_root=0
-fi
-
 function test_success ()
 {
 	local test_name="$1"
@@ -223,7 +217,7 @@ test_success "--exclude-name two" "trigger5" \
 	--condition event-rule-matches --type=user --name='jean-*' --exclude-name jean-chretien -x jean-charest \
 	--action notify
 
-skip $ist_root "non-root user: skipping kprobe tests" 18 || {
+check_skip_kernel_test 18 || {
 	i=0
 
 	for type in kprobe kernel:kprobe; do
@@ -262,7 +256,7 @@ skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	done
 }
 
-skip $ist_root "non-root user: skipping uprobe tests" 6 || {
+check_skip_kernel_test 6 || {
 	test_success "--condition event-rule-matches uprobe" "uprobe-trigger-0" \
 		--name="uprobe-trigger-0" \
 		--condition event-rule-matches --type=kernel:uprobe --location=${uprobe_elf_binary}:test_function --event-name=ma-probe \
@@ -274,7 +268,7 @@ skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 		--action notify
 }
 
-skip $ist_root "non-root user: skipping syscall tests" 30 || {
+check_skip_kernel_test 30 || {
 	test_success "--condition event-rule-matches one syscall" "syscall-trigger-0" \
 		--name="syscall-trigger-0" \
 		--condition event-rule-matches --type=syscall --name=open \
diff --git a/tests/regression/tools/trigger/test_list_triggers_cli b/tests/regression/tools/trigger/test_list_triggers_cli
index 6194b8891..6b61df206 100755
--- a/tests/regression/tools/trigger/test_list_triggers_cli
+++ b/tests/regression/tools/trigger/test_list_triggers_cli
@@ -51,6 +51,8 @@ else
 	hast_sdt_binary=0
 fi
 
+check_skip_kernel_test
+ist_kernel=$?
 
 test_top_level_options ()
 {
@@ -2695,9 +2697,13 @@ start_lttng_sessiond_notap
 
 test_top_level_options
 test_event_rule_matches_tracepoint
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 13 ||
 skip $ist_root "non-root user: skipping kprobe tests" 13 || test_event_rule_matches_probe
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 9 ||
 skip $ist_root "non-root user: skipping uprobe tests" 9 || test_event_rule_matches_userspace_probe_elf
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 9 ||
 skip $(($ist_root && $hast_sdt_binary)) "skipping userspace probe SDT tests" 9 || test_event_rule_matches_userspace_probe_sdt
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 17 ||
 skip $ist_root "non-root user: skipping syscall tests" 17 || test_event_rule_matches_syscall
 test_session_consumed_size_condition
 test_buffer_usage_conditions
diff --git a/tests/regression/tools/wildcard/test_event_wildcard b/tests/regression/tools/wildcard/test_event_wildcard
index 36e669b32..1bc61991d 100755
--- a/tests/regression/tools/wildcard/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -126,13 +126,7 @@ test_event_wildcard ust 1 'tp*tptest'
 test_event_wildcard ust 1 'tp**tptest'
 test_event_wildcard ust 1 'tp*test'
 
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
-skip $isroot "Root access is needed. Skipping all kernel wildcard tests." $NUM_KERNEL_TESTS ||
+check_skip_kernel_test "$NUM_KERNEL_TESTS" ||
 {
 	diag "Test kernel wildcards"
 
diff --git a/tests/regression/tools/working-directory/test_relayd_working_directory b/tests/regression/tools/working-directory/test_relayd_working_directory
index c196a059e..248547b82 100755
--- a/tests/regression/tools/working-directory/test_relayd_working_directory
+++ b/tests/regression/tools/working-directory/test_relayd_working_directory
@@ -144,13 +144,7 @@ function test_relayd_debug_permission()
 
 	diag "Test lttng-relayd change working directory on non writable directory"
 
-	if [ "$(id -u)" == "0" ]; then
-	    is_user=0
-	else
-	    is_user=1
-	fi
-
-	skip $is_user "Skipping permission debug output test; operation can't fail as root" 6 ||
+	check_skip_kernel_test 6 ||
 	{
 		local output_pattern='Working directory \".*\" is not writable'
 		local cwd
diff --git a/tests/regression/ust/namespaces/test_ns_contexts_change b/tests/regression/ust/namespaces/test_ns_contexts_change
index fd1621630..e2c30659a 100755
--- a/tests/regression/ust/namespaces/test_ns_contexts_change
+++ b/tests/regression/ust/namespaces/test_ns_contexts_change
@@ -103,12 +103,7 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-isroot=0
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-fi
-
-skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
+check_skip_kernel_test "$NUM_TESTS" && exit 0
 
 system_has_ns=0
 if [ -d "/proc/$$/ns" ]; then
diff --git a/tests/regression/ust/test_event_perf b/tests/regression/ust/test_event_perf
index 9b2de4de2..551ea407c 100755
--- a/tests/regression/ust/test_event_perf
+++ b/tests/regression/ust/test_event_perf
@@ -121,17 +121,11 @@ print_test_banner "$TEST_DESC"
 
 bail_out_if_no_babeltrace
 
-if [ "$(id -u)" == "0" ]; then
-        isroot=1
-else
-        isroot=0
-fi
-
 start_lttng_sessiond
 
 test_parsing_raw
 
-skip $isroot "Root access is needed. Skipping UST perf tests." 8 ||
+check_skip_kernel_test 8 ||
 {
 	test_event_basic
 }
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 44b3f167a..758db8bdd 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -323,6 +323,39 @@ function conf_proc_count()
 	echo
 }
 
+# Usage:
+# check_skip_kernel_test [NB_TESTS]
+# Return 0 if disable kernel test was set or current user is not a root user
+# If NB_TESTS passes to function, it would call the skip() to skip number of tests.
+# If NB_TESTS is empty, function just output a reason
+
+function check_skip_kernel_test ()
+{
+	local num_tests="$1"
+
+	# Check for skip test kernel flag
+	if [ "$LTTNG_TOOLS_DISABLE_KERNEL_TESTS" == "1" ]; then
+		if ! test -z "$num_tests"; then
+			skip 0 "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." "$num_tests"
+		else
+			diag "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set"
+		fi
+		return 0
+	fi
+
+	# Check if we are running as root
+	if [ "$(id -u)" != "0" ]; then
+		if ! test -z "$num_tests"; then
+			skip 0 "Root access is needed for kernel testing, skipping." "$num_tests"
+		else
+			diag "Root access is needed for kernel testing"
+		fi
+		return 0
+	fi
+
+	return 1
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
