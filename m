Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089F8C3DA6E
	for <lttng-dev@archiver.kernel.org>; Sun, 17 Dec 2023 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1702816885;
	bh=s66/zRfYcIbUtD2mH2UzdpJJea3sRuHjVpXglbcZUu0=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=EuJRXRZrNlpGQ9Rnatu9TqSfNj7TV1MYprpKWwvyKCwoByPYWpWv9L8/AT7ivJ6SW
	 5rsQrg0zfFzJxDQZ1hftC4HWDjekqpUsq3DCGbpXWXwI6NyRf45x/oAE0M1lEOO/dF
	 LI4oyJgcHJThwWrT7la5EaZmQ/8VyazEiEZiNWLs9aRoWDLWxGJfd519neaoMPtK6s
	 EkLXwJV55jiv2RWopWfcod5ynzEFZEw3v5RUw//SKx7e+TVa2+zGHNaJ+WJw4Ob3ia
	 yvTaIpMUs5l69+vIdEPcz/0N9ZJVamGS+CKrkLk3y+B62aAmEhu3TxHPMtNH/B3Lz6
	 SSYaHNrEKMjwA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4StMyY0zyWz17Q4;
	Sun, 17 Dec 2023 07:41:25 -0500 (EST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4StMyW0nJcz17MN
 for <lttng-dev@lists.lttng.org>; Sun, 17 Dec 2023 07:41:22 -0500 (EST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BHCB6FG003234
 for <lttng-dev@lists.lttng.org>; Sun, 17 Dec 2023 12:21:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v113x93hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Sun, 17 Dec 2023 12:21:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L040qbmYb8H0NYhQCwA3RExe/cDLEDPeFDvYIJHCqr8r1NomypRgKzk+d3bUnwAkhlPpBOSyJZchzesM84SoGvqpzgHMpkTc0uLTDtBHGYekSRcwmA+RvWgJXY0DVJjdlDvk8QyzqdWdisbyBUWKegeFwqFQNJotkpt1isRJiRU1T31/wK8kyIbuRRHQV3NtKPcI1VFsvpGiKeNzrgPGyz9jZrOFKC04BGvtyes+2o2wH9RKCKSTVhurQJX0ZvJCKrRiq2KCKcBbMC1YeU1alHKiHrzOo/mPubn0HQVCt7Age12og27w9tlHVfG/mUcdFA7pV4ruKbcLw9cwWvMbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a60v30N+R0dqxgXz1vtahjgLmu8TzSJ60H4SH8OaktI=;
 b=IVw8HtQWQSYZ65w+ffAnBm3FepT6dG5qKreeKrCsrMTxOAfp+NknEJ8OfBPSi0eBMldq+4fdJAMF5NAtj0R9d3vnMqF0FZnAyQhSRxYq/LoKqaZt2c8EFyskdFiLENOOnZC3WGNBPPdCMFKuF4R3mpFHF9E7DfWoNMUyofzko4M0vJN3zPC0w/wtAwtCXPN0xcXrTrLmEofzmYlcfOq2LRhuxCNGZHW4+FHxD3sBU0zFp5oAERaQNcVHI+kxnrVtN5PUB6ab7XklCFVlxZpj5g2C6T6LzDIgGM78HlwWpEmQGzK4GhPcGLjX20k1ohusxRd2fY3J3qPRnUK7rHSkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL1PR11MB5414.namprd11.prod.outlook.com (2603:10b6:208:31e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 12:21:24 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd%4]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 12:21:23 +0000
To: lttng-dev@lists.lttng.org
Date: Sun, 17 Dec 2023 20:56:13 +0800
Message-Id: <20231217125613.368115-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BL1PR11MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6a91c7-6c51-43a0-f80e-08dbfefaaebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB+PhD1Xb9a85k68z/MefAAC5U/I4TK8VZ70bn0eyGuqxzRKfA3BJfyHMHwLYfoWWziqVPN7jruhPcYRP8Z+zjXDYUp8mk7ZSvHWBdARJcg8WLXbdizKcLQnjj+XyVASrgia5tJn959yVcylhrlugFUozWYWReeoj+iCilyiCAO9gt9ANbjCixskZf1s6gNbuQCJAxZvdZfHmFsuatybKh2fUz7t5tUAg9zyo73uO/vhShe9qWxrW0EGQhKWvnUmL2DVbC9jFckIcP1UR31WX9t7r4x6BO9Y+rx1WT5pBI+zGX8oHJ0Ep9b+1PV5iPOra0cevLAU55ZlKczC233pEgJkb2Jt9nnGMNTMssosQsl5hrf/9ol0nE6ZpTLFBaQ1KYUAB0dEtfVehN8hEb+BMFDCO58qIpVQC2N/hfls29HxhrJj7DEa0bFRXf137eTQHt0oWwfgePvRUeLwlxK3PRgWvPeWd2Le0zFnswDHq8wLFaPxyFSLjoHu9ZKLNbGaatiXYXpDmYVyOl4gtDbLlk8GrXgz6xlxh6l6mj3tk8cK3QWHJ+5NZ9SgMGM3lp/KtcrP3icDHkzU4XqRylcBBlHguuHDNLmUB25W6xYnpxSGH62A2JfW/+rcMyvTuwxN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(52116002)(2616005)(1076003)(26005)(38100700002)(8936002)(5660300002)(8676002)(44832011)(41300700001)(2906002)(66946007)(478600001)(316002)(6486002)(6506007)(6512007)(6666004)(30864003)(66476007)(66556008)(6916009)(83170400001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRMdwnGcEB1Eu/iVZtP4O1SAl6IVHTpaNY2I6c7GoF39fS6vqZMImwC2f0R+?=
 =?us-ascii?Q?U1Cx49FqCsrIGVUpzPAl5JCQYfZKtvHzMBLOm/XcNR8hcZpoL7mQ6wb1X3EZ?=
 =?us-ascii?Q?7gxqKQLtsnzWWqmVb9cUZL/NFQXnzuWDvqY3+Ydq8SUytn8mb+MlBRfWcgGr?=
 =?us-ascii?Q?FvOu9aJQa7VnXTJisEB4KJwipsZkVD2U1Htdrdv8hPnp4Ui8x6Lc1sLymqoJ?=
 =?us-ascii?Q?Z0GysBOva1bDwY5C48yBvuSxmxnXo5VC+UXiluTvNJhOO4Fk3+koTWBeATJM?=
 =?us-ascii?Q?UC3WC5xgMYFaPGot09GURhvPunhMcrN+tsKgrGDWAphgjW1iLLoyii82Crwi?=
 =?us-ascii?Q?mYGlmMARkwB7GHhNZ5cqiaKIW3b6mPFCa8OovyKajfo81hgxI+0a7bYf0PjM?=
 =?us-ascii?Q?NpOGqX4JB6j00jbPX3uqPnBMRkNQ95zZD/19e1PeOcbdIW9RmLeu04JW/CLF?=
 =?us-ascii?Q?TdeW/afmaevTLFHwLh02NDldX3lk2i5PIOpEEPPBoq2vvJnPYJLnnmOHbX+G?=
 =?us-ascii?Q?ckFGPNpOhQF1eAgvmlbPRYbK9CDI0H5a+dyKsxj5HaFO7Az5Rjehy4ljzvVn?=
 =?us-ascii?Q?Y6Q/X1Exdplrwdh8yT5KPDUHDAkLm3CAZXPIyL4frPPxi8NynADcfd/PRdC7?=
 =?us-ascii?Q?RNOvQ3BptYmLT4ujvdCJnxxD6rxzjIo+P033+ChJnXhcNjExoeqBq6YTdaD+?=
 =?us-ascii?Q?460QqviAzqJWNaqN1dhcR6vPDYkMr/CRBd2W1q6cWY6Kkaz+EMQtahd36mky?=
 =?us-ascii?Q?KwOCCL5It/Fi9oI+6OQxBr9o2QtUBaky7WINZly40vHZvrORj466nG2HOLX3?=
 =?us-ascii?Q?HpFg/8qKZl8uwPrrikoxMjDz5KCLkWqwx8vlHbXU+V/t8rx5aeaqnYRbGCa/?=
 =?us-ascii?Q?LTntKIhs34zDt01V8QTTSmMepU9n0wRnEifeFxvdRaSLvqcXHtkgwuY+K7E/?=
 =?us-ascii?Q?iOteSZ78P+f86o8490W8CSKSU/zYOaifnzEpDQu7nDUnlvUV/nw0DvrfnVd8?=
 =?us-ascii?Q?/2ObFSLC+puC72sxzCFBNiOv4ULeHnlMRn21ncLFMsTVnsFJuZv0tVw3Tsnj?=
 =?us-ascii?Q?Y+yvhs//PgIH429n3HIZ/NKCsl0OiE6GD4ZkszMlYc6FPeinz/xAivGuyOIH?=
 =?us-ascii?Q?Ql1CzPbs/u0C53Tk2w3Dp+LlnojjGBGhc+yx68QNtHVsifNH3ACeeYLmO8RD?=
 =?us-ascii?Q?6RvNwd7t6LXQ+w802gVobqztrumaXaU4iUEMLk3RKTvXTDo3oeX2+gS7fLNw?=
 =?us-ascii?Q?mCvjJCzS6Ad+iTyLsKINLDoXHgxlUiu+um6ADA1YFijV/U2po0SpXX0ClvpR?=
 =?us-ascii?Q?9fQpFaVgojLwGxaDfmxQVp9okX8WiykHSjo3jKRV/Xd8Mw9QBf4cXaaFBmEz?=
 =?us-ascii?Q?yH9buXnFeB/ZFty2dTD9/B7moaAzvQzQLLvORJwAygevnzAuux8qlQ/xYNvl?=
 =?us-ascii?Q?AVOuSsmul+A6RhpU/QWrrI1d3jiH+GqXjP2souWzELqnPwRzP+1/LtK1oInW?=
 =?us-ascii?Q?HkXV8pjSeHb6ViDyCkzNWSZZ1KY/77YBjdcFi/d0J3bMjYOw1mUCE3G4pq/X?=
 =?us-ascii?Q?rrwKGSLgml5BD7dh13Uyhf1lYkkQqImkwea+smW+Bwe3J7C2V0klD9lwtfye?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6a91c7-6c51-43a0-f80e-08dbfefaaebc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 12:21:23.3577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rEPddyP1uJtVhW5IDVH2d9s3kSAmCJ4ziDUckq4kyPQk8UdXtOcRY3RlcBdLcxgXtL1aQay+WchqERweu7Y4eP+XPIfoKe5NAf4UC/u+Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5414
X-Proofpoint-ORIG-GUID: eEe3JWugpUJ0FxdMBh6u2_h_M0yG9fk_
X-Proofpoint-GUID: eEe3JWugpUJ0FxdMBh6u2_h_M0yG9fk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 mlxlogscore=927 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312170091
Subject: [lttng-dev] [PATCH v2 lttng-tools] tests: Add
 LTTNG_TOOLS_DISABLE_KERNEL_TESTS flags to skip kernel test
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

Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tests/destructive/metadata-regeneration               |  3 +++
 tests/perf/test_perf_raw.in                           |  3 +++
 tests/regression/kernel/test_all_events               |  3 +++
 tests/regression/kernel/test_callstack                |  3 +++
 tests/regression/kernel/test_channel                  |  3 +++
 tests/regression/kernel/test_clock_override           |  3 +++
 tests/regression/kernel/test_event_basic              |  3 +++
 tests/regression/kernel/test_kernel_function          |  3 +++
 tests/regression/kernel/test_lttng_logger             |  3 +++
 tests/regression/kernel/test_ns_contexts              |  3 +++
 tests/regression/kernel/test_ns_contexts_change       |  3 +++
 tests/regression/kernel/test_rotation_destroy_flush   |  3 +++
 tests/regression/kernel/test_select_poll_epoll        |  3 +++
 tests/regression/kernel/test_syscall                  |  3 +++
 tests/regression/kernel/test_userspace_probe          |  3 +++
 tests/regression/tools/clear/test_kernel              |  3 +++
 tests/regression/tools/filtering/test_valid_filter    |  3 +++
 tests/regression/tools/health/test_thread_ok          |  2 ++
 tests/regression/tools/live/test_kernel               |  8 ++++++++
 tests/regression/tools/live/test_lttng_kernel         |  3 +++
 tests/regression/tools/metadata/test_kernel           |  3 +++
 .../test_notification_kernel_buffer_usage             |  9 +++++++++
 .../notification/test_notification_kernel_capture     |  8 ++++++++
 .../tools/notification/test_notification_kernel_error |  8 ++++++++
 .../test_notification_kernel_instrumentation          |  9 +++++++++
 .../tools/notification/test_notification_multi_app    |  7 +++++++
 .../test_notification_notifier_discarded_count        |  7 +++++++
 tests/regression/tools/regen-metadata/test_kernel     |  3 +++
 tests/regression/tools/regen-statedump/test_kernel    |  3 +++
 tests/regression/tools/rotation/test_kernel           |  3 +++
 tests/regression/tools/snapshots/test_kernel          |  3 +++
 tests/regression/tools/tracker/test_event_tracker     |  3 +++
 tests/regression/tools/trigger/test_add_trigger_cli   |  3 +++
 tests/regression/tools/trigger/test_list_triggers_cli |  6 ++++++
 tests/regression/tools/wildcard/test_event_wildcard   |  3 +++
 .../test_rotation_destroy_flush                       |  7 +++++++
 tests/utils/utils.sh                                  | 11 +++++++++++
 37 files changed, 160 insertions(+)

diff --git a/tests/destructive/metadata-regeneration b/tests/destructive/metadata-regeneration
index 048c601b6..49dddf6db 100755
--- a/tests/destructive/metadata-regeneration
+++ b/tests/destructive/metadata-regeneration
@@ -202,6 +202,9 @@ if ! destructive_tests_enabled ; then
 	exit 0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	original_date=$(date)
diff --git a/tests/perf/test_perf_raw.in b/tests/perf/test_perf_raw.in
index 0a451ce63..961889177 100644
--- a/tests/perf/test_perf_raw.in
+++ b/tests/perf/test_perf_raw.in
@@ -154,6 +154,9 @@ have_libpfm
 
 test_ust_raw
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." 9 ||
 skip $isroot "Root access is needed for kernel testing, skipping." 9 ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/kernel/test_all_events b/tests/regression/kernel/test_all_events
index 2fb2f611d..c07335025 100755
--- a/tests/regression/kernel/test_all_events
+++ b/tests/regression/kernel/test_all_events
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_callstack b/tests/regression/kernel/test_callstack
index cf39089af..9f388f050 100755
--- a/tests/regression/kernel/test_callstack
+++ b/tests/regression/kernel/test_callstack
@@ -142,6 +142,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_channel b/tests/regression/kernel/test_channel
index 5525564d2..d172d75ec 100755
--- a/tests/regression/kernel/test_channel
+++ b/tests/regression/kernel/test_channel
@@ -53,6 +53,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_clock_override b/tests/regression/kernel/test_clock_override
index 524c3c3bb..3540240a1 100755
--- a/tests/regression/kernel/test_clock_override
+++ b/tests/regression/kernel/test_clock_override
@@ -180,6 +180,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
index 9f22d7db8..f5941020d 100755
--- a/tests/regression/kernel/test_event_basic
+++ b/tests/regression/kernel/test_event_basic
@@ -79,6 +79,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_kernel_function b/tests/regression/kernel/test_kernel_function
index 131c1c70b..d3eeb63b8 100755
--- a/tests/regression/kernel/test_kernel_function
+++ b/tests/regression/kernel/test_kernel_function
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond_notap
diff --git a/tests/regression/kernel/test_lttng_logger b/tests/regression/kernel/test_lttng_logger
index 849428807..eba61b86b 100755
--- a/tests/regression/kernel/test_lttng_logger
+++ b/tests/regression/kernel/test_lttng_logger
@@ -116,6 +116,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_ns_contexts b/tests/regression/kernel/test_ns_contexts
index 98b673c98..bd2775c4e 100755
--- a/tests/regression/kernel/test_ns_contexts
+++ b/tests/regression/kernel/test_ns_contexts
@@ -113,6 +113,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_ns_contexts_change b/tests/regression/kernel/test_ns_contexts_change
index 715c67cc8..468c777bd 100755
--- a/tests/regression/kernel/test_ns_contexts_change
+++ b/tests/regression/kernel/test_ns_contexts_change
@@ -168,6 +168,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_rotation_destroy_flush b/tests/regression/kernel/test_rotation_destroy_flush
index 6e568afda..f24d203a6 100755
--- a/tests/regression/kernel/test_rotation_destroy_flush
+++ b/tests/regression/kernel/test_rotation_destroy_flush
@@ -126,6 +126,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_select_poll_epoll b/tests/regression/kernel/test_select_poll_epoll
index cdde1ea4f..1f6efa321 100755
--- a/tests/regression/kernel/test_select_poll_epoll
+++ b/tests/regression/kernel/test_select_poll_epoll
@@ -371,6 +371,9 @@ fi
 
 diag "Supported syscalls are $SUPPORTED_SYSCALLS_LIST"
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_syscall b/tests/regression/kernel/test_syscall
index f9b490858..5ce6c1e81 100755
--- a/tests/regression/kernel/test_syscall
+++ b/tests/regression/kernel/test_syscall
@@ -670,6 +670,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_userspace_probe b/tests/regression/kernel/test_userspace_probe
index bfa260e47..a3c6cef51 100755
--- a/tests/regression/kernel/test_userspace_probe
+++ b/tests/regression/kernel/test_userspace_probe
@@ -821,6 +821,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/clear/test_kernel b/tests/regression/tools/clear/test_kernel
index ce76f85d2..f1099f2a1 100755
--- a/tests/regression/tools/clear/test_kernel
+++ b/tests/regression/tools/clear/test_kernel
@@ -565,6 +565,9 @@ snapshot_tests=(test_kernel_streaming_snapshot
 	test_kernel_local_snapshot
 )
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	trap signal_cleanup SIGTERM SIGINT
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index cd5b1a3b9..2f85d9bb8 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -1460,6 +1460,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel valid filter tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel valid filters"
diff --git a/tests/regression/tools/health/test_thread_ok b/tests/regression/tools/health/test_thread_ok
index 663b7e4cb..7863520a4 100755
--- a/tests/regression/tools/health/test_thread_ok
+++ b/tests/regression/tools/health/test_thread_ok
@@ -122,6 +122,8 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 test_thread_ok
 
 rm -rf ${HEALTH_PATH}
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index 1be703aac..d353a6f39 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -47,6 +47,14 @@ else
 	exit 0
 fi
 
+check_skip_kernel_test
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
index ae8c57e6b..33c522f24 100755
--- a/tests/regression/tools/live/test_lttng_kernel
+++ b/tests/regression/tools/live/test_lttng_kernel
@@ -51,6 +51,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/tools/metadata/test_kernel b/tests/regression/tools/metadata/test_kernel
index 9e1e81232..40e595660 100755
--- a/tests/regression/tools/metadata/test_kernel
+++ b/tests/regression/tools/metadata/test_kernel
@@ -104,6 +104,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel metadata tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/notification/test_notification_kernel_buffer_usage b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
index 5a87583dc..81c27a2cf 100755
--- a/tests/regression/tools/notification/test_notification_kernel_buffer_usage
+++ b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
@@ -63,8 +63,17 @@ function test_buffer_usage_notification
 	wait $APP_PID 2> /dev/null
 }
 
+check_skip_kernel_test
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
index 88a3691eb..0a72674c4 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -30,8 +30,16 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+check_skip_kernel_test
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
index 891146747..7ee6e4389 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,8 +30,16 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+check_skip_kernel_test
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
index b8f0c7eb8..752c34a86 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,7 +28,16 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
+check_skip_kernel_test
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
index 85d863804..3471ba836 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -417,7 +417,14 @@ TESTS=(
 	test_on_register_evaluation_ust
 )
 
+check_skip_kernel_test
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
index 1eb960d02..dae3ab07d 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -393,9 +393,16 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
+check_skip_kernel_test
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
index 7c4191a47..a01d752ed 100755
--- a/tests/regression/tools/regen-metadata/test_kernel
+++ b/tests/regression/tools/regen-metadata/test_kernel
@@ -105,6 +105,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/regen-statedump/test_kernel b/tests/regression/tools/regen-statedump/test_kernel
index cb0c0ad5e..313582d33 100755
--- a/tests/regression/tools/regen-statedump/test_kernel
+++ b/tests/regression/tools/regen-statedump/test_kernel
@@ -45,6 +45,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/rotation/test_kernel b/tests/regression/tools/rotation/test_kernel
index 817019036..0c43a3240 100755
--- a/tests/regression/tools/rotation/test_kernel
+++ b/tests/regression/tools/rotation/test_kernel
@@ -113,6 +113,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/snapshots/test_kernel b/tests/regression/tools/snapshots/test_kernel
index 870c437b2..8db470f60 100755
--- a/tests/regression/tools/snapshots/test_kernel
+++ b/tests/regression/tools/snapshots/test_kernel
@@ -228,6 +228,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel snapshot tests" $NUM_TESTS ||
 {
 
diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 98ca990fc..8abd06ea9 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -474,6 +474,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel tracker tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel tracker"
diff --git a/tests/regression/tools/trigger/test_add_trigger_cli b/tests/regression/tools/trigger/test_add_trigger_cli
index 9ba8c22f0..4b38b890b 100755
--- a/tests/regression/tools/trigger/test_add_trigger_cli
+++ b/tests/regression/tools/trigger/test_add_trigger_cli
@@ -223,6 +223,7 @@ test_success "--exclude-name two" "trigger5" \
 	--condition event-rule-matches --type=user --name='jean-*' --exclude-name jean-chretien -x jean-charest \
 	--action notify
 
+skip check_skip_kernel_test "LTTng modules not detected. Skipping all tests." 18 ||
 skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	i=0
 
@@ -262,6 +263,7 @@ skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	done
 }
 
+skip check_skip_kernel_test "LTTng modules not detected. Skipping all tests." 6 ||
 skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 	test_success "--condition event-rule-matches uprobe" "uprobe-trigger-0" \
 		--name="uprobe-trigger-0" \
@@ -274,6 +276,7 @@ skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 		--action notify
 }
 
+skip check_skip_kernel_test "LTTng modules not detected. Skipping all tests." 30 ||
 skip $ist_root "non-root user: skipping syscall tests" 30 || {
 	test_success "--condition event-rule-matches one syscall" "syscall-trigger-0" \
 		--name="syscall-trigger-0" \
diff --git a/tests/regression/tools/trigger/test_list_triggers_cli b/tests/regression/tools/trigger/test_list_triggers_cli
index 6194b8891..a5089651d 100755
--- a/tests/regression/tools/trigger/test_list_triggers_cli
+++ b/tests/regression/tools/trigger/test_list_triggers_cli
@@ -2689,15 +2689,21 @@ test_notify_action ()
 }
 
 plan_tests $NUM_TESTS
+check_skip_kernel_test
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
index 36e669b32..de7cb63f4 100755
--- a/tests/regression/tools/wildcard/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -132,6 +132,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTng modules not detected. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel wildcard tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel wildcards"
diff --git a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
index 669bcbc43..486700cfc 100755
--- a/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
+++ b/tests/regression/ust/rotation-destroy-flush/test_rotation_destroy_flush
@@ -117,6 +117,13 @@ function test_rotation_destroy_flush()
 
 plan_tests $NUM_TESTS
 
+check_skip_kernel_test
+
+if [ $? == 0 ]; then
+	skip 0 "LTTng modules not detected. Skipping all tests." $NUM_TESTS
+	exit 0
+fi
+
 print_test_banner "$TEST_DESC"
 
 TESTS=(
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 44b3f167a..10866a9aa 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -323,6 +323,17 @@ function conf_proc_count()
 	echo
 }
 
+# Return 0 if disable kernel test was set
+function check_skip_kernel_test ()
+{
+	# Check for skip test kernel flag
+	if [ $LTTNG_TOOLS_DISABLE_KERNEL_TESTS == 1 ]; then
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
