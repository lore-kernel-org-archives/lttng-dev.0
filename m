Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE73C48260
	for <lttng-dev@archiver.kernel.org>; Sat, 10 Feb 2024 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707552178;
	bh=HxC3wDkaHu9MzMFDBlFnVh0diy/sG2bSAKGwp4ZZxr4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=rhZADLIY/BVL7KNlD1S9FObMzZB4zOcvrmlpuKJdnN4AXmFomZX0Mfc3p0Av/Lx0N
	 Ba57m918pESf76IpLSKPMtXUoCx4Om3ScPqZrPG3nuzwCJiMmp3E/+rRuPt0GNiV7V
	 57Z/wk6HyzHcjMSAwhILYKpn2iBGCSbooOKK9aTYMCeop9v9G+qfp1UUVUQ4jrItG+
	 AAFQeNAcDhrKb5rcK0FcQ6lLQcMaeSr6iDPgYHGypcoyhokvsYXvn47r8SvDbCYdpE
	 4eE2brv5cB6ETK02TFeW0EZX/+GJJKWhO4ZZlmUx1Lq8f+gYEzaUbWrBUtC7hHu45i
	 PrLhPqC29Q0fQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TX39t1Rynz20wP;
	Sat, 10 Feb 2024 03:02:58 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4TX39q2zyBz2161
 for <lttng-dev@lists.lttng.org>; Sat, 10 Feb 2024 03:02:55 -0500 (EST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41A7v2lq009959
 for <lttng-dev@lists.lttng.org>; Sat, 10 Feb 2024 00:02:53 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w1nvm6mdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Sat, 10 Feb 2024 00:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImWkCQHar2dKe3wpuSBZU3PAIiiNe0wOZwHITkTwcTJA6QuHvh0Y0JYg7NWdIpdYVD3c17AOkO9ZQDO3XLD6aZBng3fqiiavTZ4RY2+39bNutjmSQRyPV2r8HMOue3YVKE0MH//T9q4X5Lm7ezGS2eQf7JLdricwUvbA/QJGPQjRb2DjWN+9bz333XD2ZzywF8p6cPebz6D5paPIU8qgvz/IWkhqCUtq+HttLKB6aMUVOQV/jKNWDCi9As6VaZe9XKFpC6v1wY1TQPLdP+D1fy6OI5llj1sQJC/pHCr1KIaJQ1PtuwSho6zdCmpaxvelDQ0uT1qVyH/rx4QcjajLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBVt6HE+6RgYxTuWui1U2qeZnNCotsnzgJWK0Zi5pg8=;
 b=nHoNrfcORG/nXUsx1h0amG+dE7l3gF1rEnjWiD39ypuR5FDysfsAS/5GwbbZTqXhORHFz4Cfxb6bh72TkfAtrdprQxeqF+jV28pblmw8gK3goV2bG/gETCeSkWp6H0b5hEUsJ9wszebrcI7juvNB63Al1/7uqFVpxXs6LM/HsU9XnrmP1MXQpZSQSPx1/BZdSjImqhACfJKyByehL5gM4B77hUAR10GfDU0KkYjyx5guPDflO5UWDy1yHkPUNiJfnM7TfKqz5XulgXZut95rXGmhr8DkQbq1tQX+1FqGZwptapZjw8ePI7vJVOm8jlIDaZUf64Gpp1xKbztsareU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41; Sat, 10 Feb
 2024 08:02:48 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f816:c534:1377:b673]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f816:c534:1377:b673%4]) with mapi id 15.20.7249.038; Sat, 10 Feb 2024
 08:02:48 +0000
To: lttng-dev@lists.lttng.org
Date: Sat, 10 Feb 2024 16:41:59 +0800
Message-Id: <20240210084159.2562530-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a5f5d-c175-472f-815f-08dc2a0eaba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeOA8ls/0TAHE+DGIAK7pnySmBUDJbY12CSJFqlGfp2MqjlG146eU6GG1YpsXe+Wuzx/0svPJTGjE1aXqPuhvrkv6sMtGR1rQcU+rDZH1C9+/TGh6R0B+4YXbc+/j/BGEOMs3IYpBByuPe1gHPGBFM4yTMRbfl1C0pwfKpqO1p8RRLU7OSmeyQxBkIWv5WGEnLU/+UTqf5A1SM7Vgg2yLRqlRRoLKdGbB0K+cs2wqlBhvkiG2yWV8TdP93uDMyArv4IaoTSgkhAhI0ydtf/EN/GMMnNooPa9vTPQYAmP9hdqf+L0SuX6xhj7DQBipqvHtCehW+ER0KJsfEdDkw8ODwCl951Q6SXXgflFXwcdRoTbvMcmy9bec2W80h9FgSPSPSME4mD57QXscDg71cjxQ43Nj9ocwFThN9gUUDNDX/Nbl4bGGvnxH+qMgQd3U/mJQ9r2757TuN46Bjv0hI7Ugh3ovpEHqvsdIf9SE17qwAC4AqGUpg2cPaZVcc1Iist4xLEdk376EmdV9Ej51okNxAsyKuO5IBSw3EoSRnCrmHnIDj4yLiE7lcUm9ghG35AhbBQIPRaz71WS4pBJIl2z3zVvNa9EPLx1HkNSveh3tR6OpgrAqRI5MfJCoOq4bvRR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39850400004)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(41300700001)(8676002)(8936002)(44832011)(5660300002)(30864003)(83380400001)(83170400001)(38350700005)(2616005)(6666004)(6916009)(6512007)(316002)(1076003)(26005)(66556008)(38100700002)(6486002)(66946007)(478600001)(66476007)(6506007)(52116002)(579004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUGRg0nzuZMfmnbG0hcA+cOCQbGAyGapdCkt+tz7J7ycm1Jjc1Fov6BrGr1E?=
 =?us-ascii?Q?nklZ+cIrAYY8wKRHNyJgZTU7sNansJTw3NBLLvXJXYuR7Xj4L6uo0kTCAj7T?=
 =?us-ascii?Q?vznECvcs0dVpcq3WmZu+I74TzRhw2b+cwJGq7KVj0Sp8+CzKcwYGggpvbhUi?=
 =?us-ascii?Q?jb/O24gI84qGMRWfsjDX/00RdNLHavUm5IAEgXOC877xKOLl956QqbRvIJ3h?=
 =?us-ascii?Q?y+LQU12n06ICtOykLaw80GOfE9n7sHs5CSLcJSrUtZKPUhiSvcolcNUGJnY1?=
 =?us-ascii?Q?fHeBfGap7DwS9dnBRWxyLwp4+2g4/gi9dXlI6lN3MHEJsoO4kWGZU93P4+Za?=
 =?us-ascii?Q?wQkTQFTh9R1MVa173ovA/3iiPvpOZniXNjxLPbjMTFnvlrHsPKdv6wDv2is1?=
 =?us-ascii?Q?ug1UwO6nLkhaJ/ZlYt6M+CTQDmh8MOrahRVOb6GNJYLd6J29LmdH5MPYG1Yo?=
 =?us-ascii?Q?4u8P+Vo+g+q/sGZE8zXMdUdh03VkbdRYYPJfihG9oHXdGe4O2ktKOQssRRgg?=
 =?us-ascii?Q?7CW32qYgtQaZ1526NHn9Grl1E5X8KtTjZ6+MZRxs23/n0tLOEC6N6vRCT2B1?=
 =?us-ascii?Q?1ccucpQ8N5DZtuvLZbs3G7Dw5YBFktp0Fj8cR0NxSw4lvenvWlFtPlkVK5Mc?=
 =?us-ascii?Q?H6oLVXFQvsAzBBRUK+jvCz6LsteLN9mu4VROaMooTS/RigIk0+QZqyEKW/Gt?=
 =?us-ascii?Q?9b4eUw3e3RdtQtioNHisxscUAuTU7IYTQXKzQ+JNdiNJeeGpxtrVQ8540TiQ?=
 =?us-ascii?Q?I6lv6yA4q6vUMNTt3+EkfoG3/U4x5DHar8WvduviA3sSakYzhyPNH2ggaWtO?=
 =?us-ascii?Q?thvoHZVxHlRNuvhrwmVxDK94gd3g/WQ7TM3MpulbZC4GXjxP6GvCFLbujxDr?=
 =?us-ascii?Q?5hCvvKOEcHWM5kMi+BFED8R0jRO0Z6g1dDkJ7r+RegxNTFRPIOUoK3eNRrVc?=
 =?us-ascii?Q?qMCCCAYy48VB6nw5FB4B1Z1/uqJWNFBqd7GkHinNBDM13Jlr/bZBYEdHsCUN?=
 =?us-ascii?Q?B3cbpY0m+Q3LzXHxkOLhUCp9ApPGqHK6a3klIEkL27VosTymFsUCw04ZM6Wy?=
 =?us-ascii?Q?sCSaTj3fTKx575sH1eCaOxwaZp8KHqEYQfMDT/Dt/Z+RxxRJMm7ifgmNObdq?=
 =?us-ascii?Q?pQFexoyIJpZmUDWy8kCZEsKATUkGqTOpizGtQUe5C3A7T4gpLKzwM/KO9xL3?=
 =?us-ascii?Q?2XfzVQuM2zhd2OlEX9BVd+bhoqmuH+rKprtMYGW2LBrbgkJCkgs+jgaFxJf1?=
 =?us-ascii?Q?FTLvWzoUvGMpFPy6KX5VRdwKt2quw2dbr6phF21NhMl0Svlarc4m9QRlZmfS?=
 =?us-ascii?Q?xsRaflYCaEP1x/jkUpFt6cy3NXeNp2H5OlKIwkfscs6E2W3BE/fRHw22GQaf?=
 =?us-ascii?Q?FOkyjDBtF4hncD6NGQnd0QvZJAve6marBWc7J77AUuP24/sVFp2HVxJuPvs7?=
 =?us-ascii?Q?cl0QKa/zqXDJH4uJAXuT1izEXoHIz/FDg1ACu6b+OyKy5PUcdBGqnZNtIK2k?=
 =?us-ascii?Q?sWt6b35r8S9PT5hDIG0vygAkjryhDtzMUFCDPmkCEJKEbSfnBXg/dtSe7ENj?=
 =?us-ascii?Q?cM/hBIzmDm5X0c3pK9uqDUirExjdhL+JAxH/8JlBkqZiDKUzr5DJ+mclgh+X?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a5f5d-c175-472f-815f-08dc2a0eaba5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 08:02:48.1580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUIka8jau5jCD597cfbBx7A7cWrVvxZXwOYqBSa9gg1O8eS4vlYWJsgeppxlv9S8Syp9bOh4PeHpicfycBNGbv/BYZxbxhYjrymZCoFlaZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-Proofpoint-GUID: Nms46qfwfNYahtwIRKo1V6lfKpspe_rx
X-Proofpoint-ORIG-GUID: Nms46qfwfNYahtwIRKo1V6lfKpspe_rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_06,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100066
Subject: [lttng-dev] [PATCH v8 lttng-tools] tests: add
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

Change-Id: I0ced8d6bd3c0e496f0ac71b8b84f64e04ea60730
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
 .../test_notification_kernel_buffer_usage     | 36 ++++++++--------
 .../test_notification_kernel_capture          | 23 +++++------
 .../test_notification_kernel_error            | 23 +++++------
 .../test_notification_kernel_instrumentation  | 23 +++++------
 .../test_notification_kernel_syscall          | 19 ++++-----
 .../test_notification_kernel_userspace_probe  | 20 ++++-----
 .../notification/test_notification_multi_app  | 41 +++++++++----------
 ...test_notification_notifier_discarded_count |  9 ++--
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
 tests/regression/ust/test_event_perf          |  8 +---
 tests/utils/utils.sh                          | 33 +++++++++++++++
 49 files changed, 178 insertions(+), 385 deletions(-)

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
index 5a87583dc..fe92c7337 100755
--- a/tests/regression/tools/notification/test_notification_kernel_buffer_usage
+++ b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
@@ -63,29 +63,27 @@ function test_buffer_usage_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
-
-	validate_lttng_modules_present
-
+check_skip_kernel_test && 
+{
+	plan_skip_all "Skipping all tests."
+	rm -rf "$TEST_TMPDIR"
+	exit 0
+}
 
-	modprobe lttng-test
+validate_lttng_modules_present
 
-	# Used on sessiond launch.
-	LTTNG_SESSIOND_ENV_VARS="LTTNG_TESTPOINT_ENABLE=1 \
-		CONSUMER_PAUSE_PIPE_PATH=${TESTPOINT_PIPE_PATH} \
-		LD_PRELOAD=${TESTPOINT}"
-	start_lttng_sessiond_notap
+modprobe lttng-test
 
-	test_buffer_usage_notification
+# Used on sessiond launch.
+LTTNG_SESSIOND_ENV_VARS="LTTNG_TESTPOINT_ENABLE=1 \
+	CONSUMER_PAUSE_PIPE_PATH=${TESTPOINT_PIPE_PATH} \
+	LD_PRELOAD=${TESTPOINT}"
+start_lttng_sessiond_notap
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+test_buffer_usage_notification
 
-	rm -rf "${consumerd_pipe[@]}" 2> /dev/null
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
+rm -rf "${consumerd_pipe[@]}" 2> /dev/null
 rm -rf "$TEST_TMPDIR"
diff --git a/tests/regression/tools/notification/test_notification_kernel_capture b/tests/regression/tools/notification/test_notification_kernel_capture
index 88a3691eb..b65310d88 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -31,22 +31,21 @@ function test_basic_error_path
 }
 
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+check_skip_kernel_test &&
+{
+	plan_skip_all "Skipping all tests."
+	exit 0
+}
 
-	modprobe lttng-test
+validate_lttng_modules_present
 
-	start_lttng_sessiond_notap
+modprobe lttng-test
 
-	test_basic_error_path
+start_lttng_sessiond_notap
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+test_basic_error_path
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_error b/tests/regression/tools/notification/test_notification_kernel_error
index 891146747..dac70ad27 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,23 +30,22 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+check_skip_kernel_test && 
+{
+	plan_skip_all "Skipping all tests."
+	exit 0
+}
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+validate_lttng_modules_present
 
-	modprobe lttng-test
+modprobe lttng-test
 
-	start_lttng_sessiond_notap
+start_lttng_sessiond_notap
 
-	test_basic_error_path
+test_basic_error_path
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_instrumentation b/tests/regression/tools/notification/test_notification_kernel_instrumentation
index b8f0c7eb8..599cc9aa3 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,22 +28,21 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+check_skip_kernel_test && 
+{
+	plan_skip_all "Skipping all tests."
+	exit 0
+}
 
-	modprobe lttng-test
+validate_lttng_modules_present
 
-	start_lttng_sessiond_notap
+modprobe lttng-test
 
-	test_kernel_instrumentation_notification
+start_lttng_sessiond_notap
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+test_kernel_instrumentation_notification
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_syscall b/tests/regression/tools/notification/test_notification_kernel_syscall
index ba12716fd..c9a40d077 100755
--- a/tests/regression/tools/notification/test_notification_kernel_syscall
+++ b/tests/regression/tools/notification/test_notification_kernel_syscall
@@ -31,19 +31,18 @@ function test_kernel_syscall_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+check_skip_kernel_test &&
+{
+	plan_skip_all "Skipping all tests."
+	exit 0
+}
 
-	start_lttng_sessiond_notap
+validate_lttng_modules_present
 
-	test_kernel_syscall_notification
+start_lttng_sessiond_notap
 
-	stop_lttng_sessiond_notap
+test_kernel_syscall_notification
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+stop_lttng_sessiond_notap
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_userspace_probe b/tests/regression/tools/notification/test_notification_kernel_userspace_probe
index 065e66add..38f5a5f41 100755
--- a/tests/regression/tools/notification/test_notification_kernel_userspace_probe
+++ b/tests/regression/tools/notification/test_notification_kernel_userspace_probe
@@ -29,18 +29,18 @@ function test_kernel_userspace_probe_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+check_skip_kernel_test &&
+{
+	plan_skip_all "Skipping all tests."
+	exit 0
+}
+
+validate_lttng_modules_present
 
-	start_lttng_sessiond_notap
+start_lttng_sessiond_notap
 
-	test_kernel_userspace_probe_notification
+test_kernel_userspace_probe_notification
 
-	stop_lttng_sessiond_notap
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+stop_lttng_sessiond_notap
 
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
index 1eb960d02..73dfa831f 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -394,7 +394,8 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
 
-if [ "$(id -u)" == "0" ]; then
+check_skip_kernel_test "$KERNEL_NUM_TESTS" || 
+{
 
 	validate_lttng_modules_present
 
@@ -416,9 +417,7 @@ if [ "$(id -u)" == "0" ]; then
 	modprobe --remove lttng-test
 
 	rm -rf "${sessiond_pipe[@]}" 2> /dev/null
-else
-	# Kernel tests are skipped.
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $KERNEL_NUM_TESTS
-fi
+
+}
 
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
