Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8951BC4707B
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Jan 2024 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705565711;
	bh=G9uAFbn3mG5PBwKfztrMctgMMibvM18oBVGACyRYcjs=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LEtK8MwiyRuIsP38kpP7cgRXIXkVbCQ/zfCQtpva0eU3NjPRqIVHRZMGA6dU5UQK+
	 c0w8XOo2IFyJ+Dq6EkHA8tFYulm5JYJc4qaGcD+t9f/mqt+GnoJWNitgGiIiObi3N3
	 jj68DnV956DEZyb42d2RmYKzkd/nhfzipA6EGhy1+XshN3/CF0/R0xxURdeoIoPwyi
	 VM77P/tx3JpDx43s3+M/zTrQqpSHiYVphvrMIeEpsf++j7iDCxnVZ9ifoHyRmQTIKc
	 GIB1VA2G8yiD5Kc6shtlJ61wELkr7G8zgtWhzunpIje4Ge8tEHwme8K9/M+JVypGnm
	 iCEg/WhEhFqQw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TFwXZ1Tk6z1W0G;
	Thu, 18 Jan 2024 03:15:10 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4TFwXX21YWz1Vln
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jan 2024 03:15:07 -0500 (EST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40I60bVi018772
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jan 2024 23:34:35 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vktwkn3ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jan 2024 23:34:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byjFUJkgt3I4Sg+JanN4Yi+S2BOLBTihfBebtaZGoAKry5CX84CKUgRdZz87/n+rQ53Yp7MTdbV66SmXU+BSTmmehUmlzp4odxJQCPBa6LABsgOJrb7amo+7QmcyYwlWzaDCE3+0KahxqIBq798nUbtWsos1eBZT8dbIYbPFvwyrleFNrfamBkWIyrh5rjKAJj7JsWTKOPnxE75VVCNs2Hh+8YcAAheqRVjIRrVl+ZUQFuH5EpqbgQxPE7s7UnnJrECT0QkpUrQCVUZlK9nCTLQetkJN3nJ/BihYH+lAjRfp2o/4oq6wf47y8qMi+QD91Ms+XaFY6oJszScF04CjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2TMAa4pxIKP71SboiJu9FG44Rr00Zs3kroXb+kLjzg=;
 b=CD0mlS6GaOGqmSM9H+fWVyX7waZkcZuEoyjkFe9CIqZOHo60uelgTTdpR/TNdnVxbRIkJi5T1Y3VJfu76BOSel7j/ufBXxWk0U6GluFb0a0ArVNQLRxrfLlbzxZgDdxy68WhFrnE1ygj9umVkx65xJ8tjlyLCLSxivHrjM8/zkA1Ry7vIo7Q6wyY3Ziy5TaBKVBc7rp7duTeXjf1NVv3NMgxxBE2Ow97wsOFkL4tOCccZZy2m5qdkJi0NqiZR/QXLUymcy1NUxPzQFlz50unXoLGeKhMl+lwyDSXBLoz2OtI5IoY3pVhXSm0yVssYW1bRD15bvpt5P5mDnAulGvbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CH0PR11MB5691.namprd11.prod.outlook.com (2603:10b6:610:110::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:34:31 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::b585:4ce3:5d61:5b8e]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::b585:4ce3:5d61:5b8e%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 07:34:31 +0000
To: lttng-dev@lists.lttng.org
Date: Thu, 18 Jan 2024 16:13:21 +0800
Message-Id: <20240118081321.1669155-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: TYBP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::22) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CH0PR11MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 739f25e5-df7f-4120-60d3-08dc17f7e8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re4BHStGAf8M6+rMhC1nbqiLdy2zwfh5Zm7sEO9Ur2lSs4zwuw9ZvC/KsrP5QdYDOUdA6u0eW2hxrZRDkWGBkQ1IJPUIQBUXz1ESvZZ+DLijpq+g7lC1mr8CUww6A5k2ve5DT4tj2h29J1XMEP47PxNgPlaV3bRclOZyG5xUzsUfLN8/4VgQgWek8FwFj1Qd5mify41nUHrFzdXYfaYKZNJ/SJnSOYhmGvPDcG2FGeiOVEIyCUvPjHayDX/mYTimYGahNP9YwN9AIJiC60DbcsJEZV9MsV7dRt8PIFHWrAtacvNKWA5pqm70YKyfv/xRD19uEZm/HOUVMtwrdZeRwp0gblYV0dpW0WLRIua8oJLkvgAjCA2PraKXpDpSDd4wDO9GgzOzxlFH2PH6/9nnskY0q2bfKU9Lv7xYyM+jvZw68btIyisnAHQWv9pz2T/qW1fl+UHWJ79scVze06TSaiGpNsaIvzIwWeRXNiuZpLSyr3osR/8jEwR8x4n/t8tXt2jKAPsUdSgifsjPndHrd8vT7TVsDFl4M4CAoLfz1z9uyDSqUdunF3M88F9LY4pOchOFj+5eEq9yJRcTukVtnUUvL0KiX7jr0ZOb4bZdjAMzGWS+BC2WZvHxM315gTEY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(26005)(1076003)(6506007)(6666004)(6512007)(52116002)(83380400001)(316002)(6916009)(44832011)(8676002)(8936002)(478600001)(6486002)(66476007)(66556008)(66946007)(83170400001)(38100700002)(41300700001)(5660300002)(30864003)(38350700005)(2906002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yD14DKNqXGouiVs/5leggTDgdpySSnNjjiowE1La+Lb3yQa57BCY3v5gpdQ?=
 =?us-ascii?Q?8DXFvy4xL+n7U07oAAjWIOaCK5Pftsd86+ULxk2oXDqWoRAHbuCa4GeqrpXC?=
 =?us-ascii?Q?GFOUYG38TJDcSkOYK6TKD70v/omg0IBjti3RLGWGcKOFILFUBv7zeYN2HawU?=
 =?us-ascii?Q?sY2PPJgUE7lpm6PC8CggTDPGy69JOZ0VEXEXrD6v8UqdvlT9e3N5V0ORKBqH?=
 =?us-ascii?Q?u7FuZYJmNZjtB+MNwNUmPyHqhY4lWw3u5UAHVW6rxsdRuIVfjCUxuNjBZqEz?=
 =?us-ascii?Q?3g0U7TWJ5hvImsyusTAUtrQb3SPS/CC9BEhq/3Xh/ydTSDw94xmIlqT6cuHV?=
 =?us-ascii?Q?89fWtVTLDPa1yOFx4CFZcuHduinDFqf6e/E9OX9a/wahSzeIC8SK6v3+HCya?=
 =?us-ascii?Q?RFGtFg65vLJVsCTi0+qZAwnN48UjgDTKXs/CscA4DrK8x5hRsP/v4V3gW2Gb?=
 =?us-ascii?Q?FNf4Boed0x34jTyU91LmsGhpyO/u+hllIDgnFL0gryeEUExoJps1OvXznvcB?=
 =?us-ascii?Q?y/59tqQ3aekjEIXhkzme6u3x3VJ4JreKUUtcs1bgMg0YgljgHmtVc36NZUK4?=
 =?us-ascii?Q?HFrDjZSU+sl3YxxqOWAfAkM8yL/s+FS0CxtijZB5R2WX9yPZUlyooMFQkYJy?=
 =?us-ascii?Q?aXOA8NnIOWI6cRr30WRZKPlFWta0P5deK0SIYYv/kYF0x+x0tUGHVunxu3jC?=
 =?us-ascii?Q?92w+30JNXX5NNCfmnMriz1jUwlQxL6YO2ziH7UBSd+gzENu55Tut8wWipo6n?=
 =?us-ascii?Q?/NCZzt0JLSbDWUlsnss8GeyGNWp8pP9IcvqcoLB9DVZACzoklHYIwF1eaLfl?=
 =?us-ascii?Q?lllViemHUdz6ekrPVUJaa5w60/jR3CapTmqJp7y1D1MMZIBPXwN2E3u5tamf?=
 =?us-ascii?Q?R3vlF+FkbNH3o0vg4QgCEtOc2R4tIlgruqYewJyJpWyXUm353btmAe5lubwB?=
 =?us-ascii?Q?r2ftu7ZbajftInqKZL8VWQ333xpEbOM62qpBH7tm1jmgyxPNxCITFTvuq0Xx?=
 =?us-ascii?Q?wCnOFWJUPRBs9cZMP5NwtDbGG57FYqwnBNmMP1pBYj7kw69OzyNE++J5y80t?=
 =?us-ascii?Q?p6mQjFnrWRh4zdJUe8tLtdNcY0kOHqBGuny86swbUUEcYX/xy1sgE4Hjm2dA?=
 =?us-ascii?Q?Uxt7Qrh+Ob80fgI/qhGWJkY5oec04xLvmJA87WgNTmqYn4LRHMnsQe7EuKfK?=
 =?us-ascii?Q?OjGxEvSx/s9XOS2tJwswwIfyDQGjy580mGtuoTh1DWc8UfQ0+KideAmp0lH7?=
 =?us-ascii?Q?w3cnPaz0cHs9hpuiMH93QznAEuS8En/u9+V8STVbqHpG59dPGp+mgw37TcDz?=
 =?us-ascii?Q?dsm/UQdhMuTzeMTgqvT/PtuKwA8YtQotZGpj0fzaWDXC3XGXOa6bkVhg3yzw?=
 =?us-ascii?Q?DndIbzxvJwZAcxz3rXhvG43HXAn1z4SBYtpv34LnmW+Pq1e9vs7FZfXJn2ef?=
 =?us-ascii?Q?0Xayyw9tLKFuB/sqlU+tygkC6BimCkauL/nPxB2TJ1NBLNN4e2NDd1vipEF6?=
 =?us-ascii?Q?e0L2oU+bnMorWyYiLroeTfN0StCQyUWDeSvb/9f6jVBAD3LKPNLSHX1nfJyZ?=
 =?us-ascii?Q?46xo7AkFppnrGiRbL7cu35FELDIGmKJteixHIZXcxjjwWacdqHthtTSS4aPf?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f25e5-df7f-4120-60d3-08dc17f7e8d4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:34:31.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUF3RfR0lc/PcNC3BjevePJkPYBEg1BU4wIRIUft45HGSmlCYZRfX/E0H/g4uA7ye33cAsnwrNmb2jalEiv1mWtwgVrQZ8kR0er2SESA+Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5691
X-Proofpoint-ORIG-GUID: EF3-yRkYc5_BmP79N0mKsL8NG7hoCqW6
X-Proofpoint-GUID: EF3-yRkYc5_BmP79N0mKsL8NG7hoCqW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_03,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180053
Subject: [lttng-dev] [PATCH v6 lttng-tools] tests: add
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

Change-Id: Ic9e3ec6dffca23a67e596a929805b8378331c6b1
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tests/destructive/metadata-regeneration       |  8 +---
 tests/perf/test_perf_raw.in                   |  8 +---
 tests/regression/kernel/test_all_events       |  8 +---
 tests/regression/kernel/test_callstack        |  8 +---
 tests/regression/kernel/test_channel          |  8 +---
 tests/regression/kernel/test_clock_override   |  8 +---
 tests/regression/kernel/test_event_basic      |  8 +---
 tests/regression/kernel/test_kernel_function  |  8 +---
 tests/regression/kernel/test_lttng_logger     |  7 +---
 tests/regression/kernel/test_ns_contexts      |  8 +---
 .../regression/kernel/test_ns_contexts_change |  9 +---
 .../kernel/test_rotation_destroy_flush        |  8 +---
 .../regression/kernel/test_select_poll_epoll  |  8 +---
 tests/regression/kernel/test_syscall          |  8 +---
 tests/regression/kernel/test_userspace_probe  |  8 +---
 tests/regression/tools/clear/test_kernel      |  8 +---
 .../tools/filtering/test_invalid_filter       |  8 +---
 .../tools/filtering/test_unsupported_op       |  8 +---
 .../tools/filtering/test_valid_filter         |  8 +---
 tests/regression/tools/health/test_health.sh  | 10 +----
 tests/regression/tools/health/test_thread_ok  |  9 +---
 tests/regression/tools/live/test_kernel       | 10 ++---
 tests/regression/tools/live/test_lttng_kernel |  8 +---
 tests/regression/tools/metadata/test_kernel   |  8 +---
 .../test_notification_kernel_buffer_usage     | 15 +++----
 .../test_notification_kernel_capture          | 10 ++---
 .../test_notification_kernel_error            | 10 ++---
 .../test_notification_kernel_instrumentation  | 10 ++---
 .../test_notification_kernel_syscall          | 10 ++---
 .../test_notification_kernel_userspace_probe  |  9 ++--
 .../notification/test_notification_multi_app  | 41 +++++++++----------
 ...test_notification_notifier_discarded_count | 10 ++---
 .../tools/regen-metadata/test_kernel          |  8 +---
 .../tools/regen-statedump/test_kernel         |  8 +---
 tests/regression/tools/rotation/test_kernel   |  8 +---
 .../regression/tools/rotation/test_ust_kernel |  8 +---
 tests/regression/tools/snapshots/test_kernel  |  9 +---
 .../tools/snapshots/test_kernel_streaming     |  8 +---
 .../tools/snapshots/test_ust_streaming        |  6 ---
 .../streaming/test_high_throughput_limits     |  8 +---
 tests/regression/tools/streaming/test_kernel  |  8 +---
 .../tools/tracker/test_event_tracker          |  8 +---
 .../tools/trigger/test_add_trigger_cli        | 12 ++----
 .../tools/trigger/test_list_triggers_cli      | 21 ++++------
 .../tools/wildcard/test_event_wildcard        |  8 +---
 .../test_relayd_working_directory             |  4 +-
 .../ust/namespaces/test_ns_contexts_change    |  7 +---
 .../test_rotation_destroy_flush               | 17 ++++----
 tests/regression/ust/test_event_perf          |  8 +---
 tests/utils/utils.sh                          | 33 +++++++++++++++
 50 files changed, 140 insertions(+), 361 deletions(-)

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
index 0a451ce63..00cdebc55 100644
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
+check_skip_kernel_test 9 ||
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
index 663b7e4cb..475a319c7 100755
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
@@ -115,13 +115,6 @@ STDERR_PATH=$(mktemp -t tmp.test_thread_ok_stderr_path.XXXXXX)
 TRACE_PATH=$(mktemp -d -t tmp.test_thread_ok_trace_path.XXXXXX)
 HEALTH_PATH=$(mktemp -d -t tmp.test_thread_ok_trace_path.XXXXXX)
 
-# The manage kernel thread is only spawned if we are root
-if [ "$(id -u)" == "0" ]; then
-	isroot=1
-else
-	isroot=0
-fi
-
 test_thread_ok
 
 rm -rf ${HEALTH_PATH}
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index 1be703aac..df30fcf56 100755
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
+check_skip_kernel_test &&
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
index 88a3691eb..e8f338c50 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -31,7 +31,8 @@ function test_basic_error_path
 }
 
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test $NUM_TESTS ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -42,11 +43,6 @@ if [ "$(id -u)" == "0" ]; then
 
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
index 891146747..0d52bcf6e 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,8 +30,8 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
-
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test $NUM_TESTS ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -42,11 +42,7 @@ if [ "$(id -u)" == "0" ]; then
 
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
index b8f0c7eb8..930ee7ea6 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,7 +28,8 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test $NUM_TESTS ||
+{
 	validate_lttng_modules_present
 
 	modprobe lttng-test
@@ -39,11 +40,6 @@ if [ "$(id -u)" == "0" ]; then
 
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
index ba12716fd..24b2fe411 100755
--- a/tests/regression/tools/notification/test_notification_kernel_syscall
+++ b/tests/regression/tools/notification/test_notification_kernel_syscall
@@ -31,7 +31,8 @@ function test_kernel_syscall_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	start_lttng_sessiond_notap
@@ -39,11 +40,6 @@ if [ "$(id -u)" == "0" ]; then
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
index 065e66add..62d11b214 100755
--- a/tests/regression/tools/notification/test_notification_kernel_userspace_probe
+++ b/tests/regression/tools/notification/test_notification_kernel_userspace_probe
@@ -29,7 +29,8 @@ function test_kernel_userspace_probe_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$NUM_TESTS" ||
+{
 	validate_lttng_modules_present
 
 	start_lttng_sessiond_notap
@@ -37,10 +38,6 @@ if [ "$(id -u)" == "0" ]; then
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
index 85d863804..8f7dfd842 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -411,32 +411,31 @@ function test_on_register_evaluation ()
 	rm -rf "$output_dir"
 }
 
+check_skip_kernel_test "$NUM_TESTS" || {
+
+	TESTS=(
+		test_multi_app_ust
+		test_on_register_evaluation_ust
+	)
 
-TESTS=(
-	test_multi_app_ust
-	test_on_register_evaluation_ust
-)
 
-if [ "$(id -u)" == "0" ]; then
 	validate_lttng_modules_present
 	TESTS+=(
-	test_multi_app_kernel
-	test_on_register_evaluation_kernel
-)
-else
-        skip 0 "Root access is needed. Skipping all kernel multi-app notification tests." $NUM_TEST_KERNEL
-fi
+		test_multi_app_kernel
+		test_on_register_evaluation_kernel
+	)
 
 
-for fct_test in ${TESTS[@]};
-do
-	TRACE_PATH=$(mktemp -d -t tmp.test_notification_multi_app_trace_path.XXXXXX)
+	for fct_test in ${TESTS[@]};
+	do
+		TRACE_PATH=$(mktemp -d -t tmp.test_notification_multi_app_trace_path.XXXXXX)
 
-	${fct_test}
-	if [ $? -ne 0 ]; then
-		break;
-	fi
+		${fct_test}
+		if [ $? -ne 0 ]; then
+			break;
+		fi
 
-	# Only delete if successful
-	rm -rf $TRACE_PATH
-done
+		# Only delete if successful
+		rm -rf $TRACE_PATH
+	done
+}
diff --git a/tests/regression/tools/notification/test_notification_notifier_discarded_count b/tests/regression/tools/notification/test_notification_notifier_discarded_count
index 1eb960d02..bd3d388a4 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -394,7 +394,8 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$KERNEL_NUM_TESTS" || 
+{
 
 	validate_lttng_modules_present
 
@@ -416,9 +417,6 @@ if [ "$(id -u)" == "0" ]; then
 	modprobe --remove lttng-test
 
 	rm -rf "${sessiond_pipe[@]}" 2> /dev/null
-else
-	# Kernel tests are skipped.
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $KERNEL_NUM_TESTS
-fi
 
-rm -rf "$TEST_TMPDIR"
+	rm -rf "$TEST_TMPDIR"
+}
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
index 6194b8891..57ce440b0 100755
--- a/tests/regression/tools/trigger/test_list_triggers_cli
+++ b/tests/regression/tools/trigger/test_list_triggers_cli
@@ -38,20 +38,13 @@ register_some_triggers_bin=$(realpath "${CURDIR}/utils/register-some-triggers")
 uid=$(id --user)
 gid=$(id --group)
 
-if [ "$uid" == "0" ]; then
-	ist_root=1
-	ls "$uprobe_sdt_binary" >/dev/null 2>&1
-	if test $? == 0; then
-		hast_sdt_binary=1
-	else
-		hast_sdt_binary=0
-	fi
+ls "$uprobe_sdt_binary" >/dev/null 2>&1
+if test $? == 0; then
+	hast_sdt_binary=1
 else
-	ist_root=0
 	hast_sdt_binary=0
 fi
 
-
 test_top_level_options ()
 {
 	diag "Listing top level options"
@@ -2695,10 +2688,10 @@ start_lttng_sessiond_notap
 
 test_top_level_options
 test_event_rule_matches_tracepoint
-skip $ist_root "non-root user: skipping kprobe tests" 13 || test_event_rule_matches_probe
-skip $ist_root "non-root user: skipping uprobe tests" 9 || test_event_rule_matches_userspace_probe_elf
-skip $(($ist_root && $hast_sdt_binary)) "skipping userspace probe SDT tests" 9 || test_event_rule_matches_userspace_probe_sdt
-skip $ist_root "non-root user: skipping syscall tests" 17 || test_event_rule_matches_syscall
+check_skip_kernel_test 13 || test_event_rule_matches_probe
+check_skip_kernel_test 9 || test_event_rule_matches_userspace_probe_elf
+check_skip_kernel_test 9 || skip $hast_sdt_binary "skipping userspace probe SDT tests" 9 || test_event_rule_matches_userspace_probe_sdt
+check_skip_kernel_test 17 || test_event_rule_matches_syscall
 test_session_consumed_size_condition
 test_buffer_usage_conditions
 test_session_rotation_conditions
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
index c196a059e..db44120e7 100755
--- a/tests/regression/tools/working-directory/test_relayd_working_directory
+++ b/tests/regression/tools/working-directory/test_relayd_working_directory
@@ -145,9 +145,9 @@ function test_relayd_debug_permission()
 	diag "Test lttng-relayd change working directory on non writable directory"
 
 	if [ "$(id -u)" == "0" ]; then
-	    is_user=0
+		is_user=0
 	else
-	    is_user=1
+		is_user=1
 	fi
 
 	skip $is_user "Skipping permission debug output test; operation can't fail as root" 6 ||
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
diff --git a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
index 669bcbc43..cee1a2489 100755
--- a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
+++ b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
@@ -126,14 +126,17 @@ TESTS=(
 TEST_COUNT=${#TESTS[@]}
 i=0
 
-while [ "$i" -lt "$TEST_COUNT" ]; do
+check_skip_kernel_test $NUM_TESTS ||
+{
+	while [ "$i" -lt "$TEST_COUNT" ]; do
 
-	trap signal_cleanup SIGTERM SIGINT
+		trap signal_cleanup SIGTERM SIGINT
 
-	TRACE_PATH=$(mktemp -d -t tmp.test_rotation_destroy_flush.XXXXXX)
+		TRACE_PATH=$(mktemp -d -t tmp.test_rotation_destroy_flush.XXXXXX)
 
-	# Execute test
-	${TESTS[$i]}
+		# Execute test
+		${TESTS[$i]}
 
-	let "i++"
-done
+		let "i++"
+	done
+}
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
2.25.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
