Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180BCC46CA2
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Dec 2023 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1703006987;
	bh=ehH0n1xPwTSQSTypZjiMdjA1L8cEdjGlIpD8dF3td2w=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=P1EH14bDVsXdX9GxBwvoYSWbBhOWX9Vs5z0u2PaexH9wRRKqMhdRGkEU+K0ZoCafb
	 oY6sSAkdakbtRpX2BDMOL9znrlYLCYjABl33n3zNpORjtmOl4XpcHn7sGTs4+jjM83
	 bZ36BD2gYqGlyU33s9WWu0CUlzYQXkWhhc6m4OsJ3thEXeH1A8u0TzaMSxBV1OommU
	 Pejnjk3woBh0zH675zt+b9WfX6VcckUAsM8OnXRsWmCfu1z7xmazN/BrnqJ68+nTOe
	 LC2Emy5uYXpLOPXtJGJriiIrbG8dzCRJ/tq4lyjNUHR90Hm++XO93h9lJogMtuF6Uj
	 cPgLBndfx9LIQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SvkGL24m5z18K5;
	Tue, 19 Dec 2023 12:29:46 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4SvkGH453Bz182T
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 12:29:43 -0500 (EST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BJCV9XX025557
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 09:29:41 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1c9kk6dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 09:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDbadMhMxUCPIRVPE43zR4L6nP3iUTRuoUDE7XrBcQrlbdvLpO9GABks1JvvX6jrXhx8Mq6tuXfVLwDEVU4UvKv+nY0LzGMcx0sk3O/MTk4dIBUIBFUm9mC+0cEFAHWWDLyxmB5GjRx+agmxmqJhpCPUx5YY/LjTMSfHmCZ6pt4ii2j9FksFnmXJU2LLi/c2ZzfDffn1G13JgjTrJ0gQqaB4atzleQeHIkx5Pv2+dV9/Vz4AoWSRQOyKtFh96EgMGPYaDst8bslBggRONxPuJ9DZVMGHKW9T8mYXdDb2XKTKUCJU4pkPpkOtQqRC1qcYQ3nbR5DddH7zBj2dgEIe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyM0z/qEI5B16utP6V33CTIm3NZ0kMcPD8QjtI9RmWU=;
 b=Z9g82SpRmGW7qn6jwf2fRIi24QQQJpyo400Gvh8siSt2Qstwj5HLPkn6Gh8MP9VTRg30kkTdi9iTExUeLleJZKtL0NJTJeCTgXIQ8n2qmQ46l3pUVGnb48TRO4hh8JRFnonPRGjkAIzzgBfJshkTFrLWjeFZCakygbILhM3Ey1VOBtpcG9JhDtcJEn22wPwRzp+xKIVMBPhS9c3fONKJOP+y9A3REzSEEWIfYxKkHgctWnCBk5mMkkpaPvvE1SzKZ3b1HrjD3LA4f9j/Jot+pPWgNMa4nvFGRmmowSTyXERM6GIItIpqV76YQgQYkz7Sdv3LpoqWaWcmwO53XXsfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB6867.namprd11.prod.outlook.com (2603:10b6:930:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 17:29:37 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::6162:ed58:51f5:efd%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 17:29:37 +0000
To: lttng-dev@lists.lttng.org
Date: Wed, 20 Dec 2023 02:04:27 +0800
Message-Id: <20231219180427.597841-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f9b27b-fec5-4c09-319f-08dc00b812df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9vGXBhlT9BCgoCg4i5x72yL6j0ELYVyXyj5k08cJpXSGkaS3xy5Ds8HbLJ4txARpJWanumT3j6asiLlm1kbNILKFE3eSL9JxNc+WkZifvdDABM1hwDkD1paSvzgz4eu73GcUTW4n8v/NbvqkCnYNZW7cZ8zsYLoKWhz7K6AkBUfMn37OUElDUiM+BnkB6WUYHLtYXXZb+Xo5e0MuG6Qmy4OrInywtCR4WdrA4sP6JjrtBDKgOxompXVocsZaGzBC852bPyiYyxzYfeETnnAMM0uzxA5TskLY6OzF9XJNRrXCDBBNahgyg9XGAlheiABwdbB+2H1kwWlATE15NQhMXNkdwdlfqd4iklJjbskt110Uc1sD9xaH+iY0tjbK9F3pV+foyQqJ3CCAjasINB5pZ5w4JvEZ0645mMQ+Vl/ZCtjZ139ApyKT9BCyD4C1WXO0Htdr0zOuj2Y3ZvvZGuz1gxbtS/RO2/gM8Qptx4MnAe7Il4zSlyR9Wjf71Ee6nDzeuBtrnyBvx4bOBOiZf04fTfes2q/myGp22lfPI/XxpBhnMxsFkqsF1r9zUsLzKw7NBQfHXsn2ccVPbdFhm55cZAIIrqhtaUwjgu23zBZMgWTUhay/lrG2rS++TzvBaY6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5824.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(30864003)(2906002)(5660300002)(38350700005)(41300700001)(83170400001)(38100700002)(478600001)(1076003)(26005)(6486002)(2616005)(66556008)(66946007)(83380400001)(66476007)(316002)(6916009)(52116002)(6506007)(6666004)(6512007)(44832011)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/hfD2CtUdDgf9WmxkdIY0fNHGxZfqOsSgEIN77zPgT8/esP1jYRKsmkEScg?=
 =?us-ascii?Q?ZIPWMUCH+JnmXJ5AkRwRIewQDkMOOd/+KxbGEYbRIG0exHmtUI5NS/UOrHjc?=
 =?us-ascii?Q?srPORdKIY5tzHhGiNu6Yec/4bUf4tdtFfDzeK4qlohCwf395VpODEqPjBfrx?=
 =?us-ascii?Q?xKTdcOcnncckiFvLu0Yb1quHyhLPwo0zykCt5PKX3UItEellxO1v99HZeriC?=
 =?us-ascii?Q?Uk7RfjcmZBGSYXIj7LY11AHVszS1xF5y4oSfVF1t+r3qM/XXnjRYEGhKtwKk?=
 =?us-ascii?Q?1L8QwpYacOwMrs2l9SyM0qC8OE1E6848MVUPWF4DhEcFuj80mLXUeQB4yb9P?=
 =?us-ascii?Q?01iVDVatW9pZ92OpOALzCmFWNA763YJA2IsLASl/1FIPkJnFjm8+kntn8XFb?=
 =?us-ascii?Q?GlCzbHuDYgN6v8/gSRuHwnhtKcKIgy9jxALPae2YH9q5Ck/D0LZX7PnA9KL7?=
 =?us-ascii?Q?4dVEEiQBJvYPyWDSkS2CjsO6ayoaO6VVHjsys9xwtRKIdiAzvUV8RR/4HzGC?=
 =?us-ascii?Q?HeyKuxHqz3xDXu9rHQOUSZ/Uq9BawE1ljrEgINoJk6kGzdl8iLFwqjvIwqk6?=
 =?us-ascii?Q?uPom7iW32kUxYAJlxT6EnGGb2j98AyIMYa8PXoNR/dpsvDllQyounaoOuyhA?=
 =?us-ascii?Q?504iGbjsLLXYrZWhJfBw4j+JM0elJbfgyPW4IuJHodnURLdIxMfxz7SyOSSd?=
 =?us-ascii?Q?BMWjzOeTjKDBt13EFXFf/5xcAfBzWAacCz57DYcEP9+RlHYilzlhPF+8qck6?=
 =?us-ascii?Q?zCVlzUbJrBwHgnSU9XQclS5U9keexdQG5Yo53gkArtY3As6bhHztFRIiCrOg?=
 =?us-ascii?Q?A2r5sU+bgXlVtgXElf3vE4zafzOs4K039FKG5FkPKaWHUieB+l2q3bLoVgGN?=
 =?us-ascii?Q?N27fb+9ZonA8aHMpZOQ8cf46ErpSd2gEfFIt09ffmdaY4UQEPaO1+c3HDhOF?=
 =?us-ascii?Q?n7EU8ygEB2C3gGLmhaL6+jp2UmBnUpduMIVUuZCSivuYq1clRhbI/P30Fa8z?=
 =?us-ascii?Q?p+yOvK8lbwGA2w5NU2SPDIRTUbKCT83c1frg/iacV9LAH8Ehd48X7yzO4O5y?=
 =?us-ascii?Q?y1KwGbOAN4pzf1i6PLe1FQvYj7olx6Z8N1vyxObukceNM9Bxkm1MRr/DFOED?=
 =?us-ascii?Q?tNHFa8/xvVbYsX/6a7rrb9ONW2Z1e1Ok62QbKorEk1c3aUp7I/npiIex1oO2?=
 =?us-ascii?Q?wztHFHJBE8Sk6hUtRTpMdOSxy18IzW65Dz1ikRl5IGp9Pz2ZHc1nOjYjzsR1?=
 =?us-ascii?Q?UiYX8TbGW/18nAaJkKvuBR/L6hUvR0Dg9bc8dNlX+pwaGYdWlBflvz+1rIs/?=
 =?us-ascii?Q?hdOWIudsp63vHrd//rC/aTQ2S3ORmcGkz0xFzGh8jtyKMscr/ghNQNwhOK0F?=
 =?us-ascii?Q?ZMt4rhz0Zp9vY+GXVwQEbrSBPUDvwyxYpVMjpkWlNh8nLJZxLlmTKYYFboRa?=
 =?us-ascii?Q?Ja4tGJbNwJgODIFfSLSpqwJuMaAwdixz2m617VGEVPMJ6aeks2JIhnHBep3e?=
 =?us-ascii?Q?hb/mdXSNwa1CJdt0kqkS7JcdT10R6LfgrzbjjQdkw9mReoceJocVSU6OagaA?=
 =?us-ascii?Q?XVidQArMJAB2Y5E1XTEb7zfi5t+tuRIoqIfUw1nlcLZaKnUZ8urDFNFJkqti?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f9b27b-fec5-4c09-319f-08dc00b812df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 17:29:37.4177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZyyHwr+F7dFvPCE3J7vG+4/BiSSkdHfcvZyfrxFp3sd08rMglg1dQJyVEunAeG/xm5CiCqUGJykQYob2yVPVryTCeQPUQyXLSgq9sqmTB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6867
X-Proofpoint-GUID: 6Cb85xjfR21eu_t4LGu3om5Hpyzj0K54
X-Proofpoint-ORIG-GUID: 6Cb85xjfR21eu_t4LGu3om5Hpyzj0K54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190131
Subject: [lttng-dev] [PATCH v4 lttng-tools] tests: Add
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

Change-Id: I6618161c7b07f759aed7d205a716943346e7536c
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 tests/destructive/metadata-regeneration       |  3 ++
 tests/perf/test_perf_raw.in                   |  3 ++
 tests/regression/kernel/test_all_events       |  3 ++
 tests/regression/kernel/test_callstack        |  3 ++
 tests/regression/kernel/test_channel          |  3 ++
 tests/regression/kernel/test_clock_override   |  3 ++
 tests/regression/kernel/test_event_basic      |  3 ++
 tests/regression/kernel/test_kernel_function  |  3 ++
 tests/regression/kernel/test_lttng_logger     |  3 ++
 tests/regression/kernel/test_ns_contexts      |  3 ++
 .../regression/kernel/test_ns_contexts_change |  3 ++
 .../kernel/test_rotation_destroy_flush        |  3 ++
 .../regression/kernel/test_select_poll_epoll  |  3 ++
 tests/regression/kernel/test_syscall          |  3 ++
 tests/regression/kernel/test_userspace_probe  |  3 ++
 tests/regression/tools/clear/test_kernel      |  3 ++
 .../tools/filtering/test_valid_filter         |  3 ++
 tests/regression/tools/health/test_thread_ok  |  2 +
 tests/regression/tools/live/test_kernel       |  8 ++++
 tests/regression/tools/live/test_lttng_kernel |  3 ++
 tests/regression/tools/metadata/test_kernel   |  3 ++
 .../test_notification_kernel_buffer_usage     | 37 ++++++++--------
 .../test_notification_kernel_capture          | 30 +++++++------
 .../test_notification_kernel_error            | 29 +++++++------
 .../test_notification_kernel_instrumentation  | 29 +++++++------
 .../notification/test_notification_multi_app  | 24 +++++++----
 ...test_notification_notifier_discarded_count | 42 +++++++++++--------
 .../tools/regen-metadata/test_kernel          |  3 ++
 .../tools/regen-statedump/test_kernel         |  3 ++
 tests/regression/tools/rotation/test_kernel   |  3 ++
 tests/regression/tools/snapshots/test_kernel  |  3 ++
 .../tools/tracker/test_event_tracker          |  3 ++
 .../tools/trigger/test_add_trigger_cli        |  6 +++
 .../tools/trigger/test_list_triggers_cli      |  6 +++
 .../tools/wildcard/test_event_wildcard        |  3 ++
 tests/utils/utils.sh                          | 11 +++++
 36 files changed, 220 insertions(+), 79 deletions(-)

diff --git a/tests/destructive/metadata-regeneration b/tests/destructive/metadata-regeneration
index 048c601b6..6b5e58a4f 100755
--- a/tests/destructive/metadata-regeneration
+++ b/tests/destructive/metadata-regeneration
@@ -202,6 +202,9 @@ if ! destructive_tests_enabled ; then
 	exit 0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	original_date=$(date)
diff --git a/tests/perf/test_perf_raw.in b/tests/perf/test_perf_raw.in
index 0a451ce63..cf0a15a6a 100644
--- a/tests/perf/test_perf_raw.in
+++ b/tests/perf/test_perf_raw.in
@@ -154,6 +154,9 @@ have_libpfm
 
 test_ust_raw
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 9 ||
 skip $isroot "Root access is needed for kernel testing, skipping." 9 ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/kernel/test_all_events b/tests/regression/kernel/test_all_events
index 2fb2f611d..1c2e6fa0a 100755
--- a/tests/regression/kernel/test_all_events
+++ b/tests/regression/kernel/test_all_events
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_callstack b/tests/regression/kernel/test_callstack
index cf39089af..1e17acc45 100755
--- a/tests/regression/kernel/test_callstack
+++ b/tests/regression/kernel/test_callstack
@@ -142,6 +142,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_channel b/tests/regression/kernel/test_channel
index 5525564d2..7589bcaed 100755
--- a/tests/regression/kernel/test_channel
+++ b/tests/regression/kernel/test_channel
@@ -53,6 +53,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond
diff --git a/tests/regression/kernel/test_clock_override b/tests/regression/kernel/test_clock_override
index 524c3c3bb..4e7ee38d7 100755
--- a/tests/regression/kernel/test_clock_override
+++ b/tests/regression/kernel/test_clock_override
@@ -180,6 +180,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_event_basic b/tests/regression/kernel/test_event_basic
index 9f22d7db8..d1246fdc1 100755
--- a/tests/regression/kernel/test_event_basic
+++ b/tests/regression/kernel/test_event_basic
@@ -79,6 +79,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_kernel_function b/tests/regression/kernel/test_kernel_function
index 131c1c70b..eb8f278fc 100755
--- a/tests/regression/kernel/test_kernel_function
+++ b/tests/regression/kernel/test_kernel_function
@@ -49,6 +49,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	start_lttng_sessiond_notap
diff --git a/tests/regression/kernel/test_lttng_logger b/tests/regression/kernel/test_lttng_logger
index 849428807..59936761d 100755
--- a/tests/regression/kernel/test_lttng_logger
+++ b/tests/regression/kernel/test_lttng_logger
@@ -116,6 +116,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_ns_contexts b/tests/regression/kernel/test_ns_contexts
index 98b673c98..4b0986dc7 100755
--- a/tests/regression/kernel/test_ns_contexts
+++ b/tests/regression/kernel/test_ns_contexts
@@ -113,6 +113,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_ns_contexts_change b/tests/regression/kernel/test_ns_contexts_change
index 715c67cc8..90ce78750 100755
--- a/tests/regression/kernel/test_ns_contexts_change
+++ b/tests/regression/kernel/test_ns_contexts_change
@@ -168,6 +168,9 @@ if [ "$(id -u)" == "0" ]; then
 	isroot=1
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." "$NUM_TESTS" && exit 0
 
 
diff --git a/tests/regression/kernel/test_rotation_destroy_flush b/tests/regression/kernel/test_rotation_destroy_flush
index 6e568afda..e4ebc8b49 100755
--- a/tests/regression/kernel/test_rotation_destroy_flush
+++ b/tests/regression/kernel/test_rotation_destroy_flush
@@ -126,6 +126,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_select_poll_epoll b/tests/regression/kernel/test_select_poll_epoll
index cdde1ea4f..c9c4a4975 100755
--- a/tests/regression/kernel/test_select_poll_epoll
+++ b/tests/regression/kernel/test_select_poll_epoll
@@ -371,6 +371,9 @@ fi
 
 diag "Supported syscalls are $SUPPORTED_SYSCALLS_LIST"
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_syscall b/tests/regression/kernel/test_syscall
index f9b490858..054cd428c 100755
--- a/tests/regression/kernel/test_syscall
+++ b/tests/regression/kernel/test_syscall
@@ -670,6 +670,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/kernel/test_userspace_probe b/tests/regression/kernel/test_userspace_probe
index bfa260e47..e505266d1 100755
--- a/tests/regression/kernel/test_userspace_probe
+++ b/tests/regression/kernel/test_userspace_probe
@@ -821,6 +821,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/clear/test_kernel b/tests/regression/tools/clear/test_kernel
index ce76f85d2..6611701f5 100755
--- a/tests/regression/tools/clear/test_kernel
+++ b/tests/regression/tools/clear/test_kernel
@@ -565,6 +565,9 @@ snapshot_tests=(test_kernel_streaming_snapshot
 	test_kernel_local_snapshot
 )
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	trap signal_cleanup SIGTERM SIGINT
diff --git a/tests/regression/tools/filtering/test_valid_filter b/tests/regression/tools/filtering/test_valid_filter
index cd5b1a3b9..ebab40372 100755
--- a/tests/regression/tools/filtering/test_valid_filter
+++ b/tests/regression/tools/filtering/test_valid_filter
@@ -1460,6 +1460,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel valid filter tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel valid filters"
diff --git a/tests/regression/tools/health/test_thread_ok b/tests/regression/tools/health/test_thread_ok
index 663b7e4cb..26a13b2cc 100755
--- a/tests/regression/tools/health/test_thread_ok
+++ b/tests/regression/tools/health/test_thread_ok
@@ -122,6 +122,8 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 test_thread_ok
 
 rm -rf ${HEALTH_PATH}
diff --git a/tests/regression/tools/live/test_kernel b/tests/regression/tools/live/test_kernel
index 1be703aac..6fda45f2c 100755
--- a/tests/regression/tools/live/test_kernel
+++ b/tests/regression/tools/live/test_kernel
@@ -47,6 +47,14 @@ else
 	exit 0
 fi
 
+check_skip_kernel_test
+
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
+fi
+
+
 modprobe lttng-test
 
 start_lttng_sessiond_notap
diff --git a/tests/regression/tools/live/test_lttng_kernel b/tests/regression/tools/live/test_lttng_kernel
index ae8c57e6b..513a632be 100755
--- a/tests/regression/tools/live/test_lttng_kernel
+++ b/tests/regression/tools/live/test_lttng_kernel
@@ -51,6 +51,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all tests." $NUM_TESTS ||
 {
 	modprobe lttng-test
diff --git a/tests/regression/tools/metadata/test_kernel b/tests/regression/tools/metadata/test_kernel
index 9e1e81232..88b98d6a5 100755
--- a/tests/regression/tools/metadata/test_kernel
+++ b/tests/regression/tools/metadata/test_kernel
@@ -104,6 +104,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel metadata tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/notification/test_notification_kernel_buffer_usage b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
index 5a87583dc..2f38e7422 100755
--- a/tests/regression/tools/notification/test_notification_kernel_buffer_usage
+++ b/tests/regression/tools/notification/test_notification_kernel_buffer_usage
@@ -63,29 +63,32 @@ function test_buffer_usage_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
+if [ "$(id -u)" != "0" ]; then
+	plan_skip_all "Root access is needed. Skipping all tests."
+	exit 0
+fi
 
-	validate_lttng_modules_present
+check_skip_kernel_test
 
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
+fi
 
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
index 88a3691eb..34cb4d3d5 100755
--- a/tests/regression/tools/notification/test_notification_kernel_capture
+++ b/tests/regression/tools/notification/test_notification_kernel_capture
@@ -31,22 +31,28 @@ function test_basic_error_path
 }
 
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+if [ "$(id -u)" != "0" ]; then
+	plan_skip_all "Root access is needed. Skipping all tests."
+	exit 0
+fi
 
-	modprobe lttng-test
+check_skip_kernel_test
 
-	start_lttng_sessiond_notap
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
+fi
 
-	test_basic_error_path
+validate_lttng_modules_present
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+modprobe lttng-test
+
+start_lttng_sessiond_notap
+
+test_basic_error_path
+
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_error b/tests/regression/tools/notification/test_notification_kernel_error
index 891146747..895e35838 100755
--- a/tests/regression/tools/notification/test_notification_kernel_error
+++ b/tests/regression/tools/notification/test_notification_kernel_error
@@ -30,23 +30,28 @@ function test_basic_error_path
 	wait $APP_PID 2> /dev/null
 }
 
+if [ "$(id -u)" != "0" ]; then
+	plan_skip_all "Root access is needed. Skipping all tests."
+	exit 0
+fi
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+check_skip_kernel_test
 
-	modprobe lttng-test
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
+fi
 
-	start_lttng_sessiond_notap
+validate_lttng_modules_present
 
-	test_basic_error_path
+modprobe lttng-test
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+start_lttng_sessiond_notap
+
+test_basic_error_path
+
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_kernel_instrumentation b/tests/regression/tools/notification/test_notification_kernel_instrumentation
index b8f0c7eb8..9658fb0d3 100755
--- a/tests/regression/tools/notification/test_notification_kernel_instrumentation
+++ b/tests/regression/tools/notification/test_notification_kernel_instrumentation
@@ -28,22 +28,27 @@ function test_kernel_instrumentation_notification
 	wait $APP_PID 2> /dev/null
 }
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
+if [ "$(id -u)" != "0" ]; then
+	plan_skip_all "Root access is needed. Skipping all tests."
+	exit 0
+fi
 
-	modprobe lttng-test
+check_skip_kernel_test
 
-	start_lttng_sessiond_notap
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
+fi
 
-	test_kernel_instrumentation_notification
+validate_lttng_modules_present
 
-	stop_lttng_sessiond_notap
-	rmmod lttng-test
+modprobe lttng-test
 
-else
-	# Kernel tests are skipped.
-	plan_tests $NUM_TESTS
-	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
-fi
+start_lttng_sessiond_notap
+
+test_kernel_instrumentation_notification
+
+stop_lttng_sessiond_notap
+rmmod lttng-test
 
 rm -f "$TESTAPP_STATE_PATH"
diff --git a/tests/regression/tools/notification/test_notification_multi_app b/tests/regression/tools/notification/test_notification_multi_app
index 85d863804..3d2fe5b94 100755
--- a/tests/regression/tools/notification/test_notification_multi_app
+++ b/tests/regression/tools/notification/test_notification_multi_app
@@ -417,16 +417,24 @@ TESTS=(
 	test_on_register_evaluation_ust
 )
 
-if [ "$(id -u)" == "0" ]; then
-	validate_lttng_modules_present
-	TESTS+=(
-	test_multi_app_kernel
-	test_on_register_evaluation_kernel
-)
-else
-        skip 0 "Root access is needed. Skipping all kernel multi-app notification tests." $NUM_TEST_KERNEL
+if [ "$(id -u)" != "0" ]; then
+	plan_skip_all "Root access is needed. Skipping all tests."
+	exit 0
+fi
+
+check_skip_kernel_test
+
+if [ $? == 0 ]; then
+	plan_skip_all "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests."
+	exit 0
 fi
 
+validate_lttng_modules_present
+TESTS+=(
+test_multi_app_kernel
+test_on_register_evaluation_kernel
+)
+
 
 for fct_test in ${TESTS[@]};
 do
diff --git a/tests/regression/tools/notification/test_notification_notifier_discarded_count b/tests/regression/tools/notification/test_notification_notifier_discarded_count
index 1eb960d02..6751625c0 100755
--- a/tests/regression/tools/notification/test_notification_notifier_discarded_count
+++ b/tests/regression/tools/notification/test_notification_notifier_discarded_count
@@ -394,31 +394,37 @@ function test_ust_notifier_discarded_regardless_trigger_owner
 test_ust_notifier_discarded_count
 test_ust_notifier_discarded_count_max_bucket
 
-if [ "$(id -u)" == "0" ]; then
+if [ "$(id -u)" != "0" ]; then
+	skip 0 "Root access is needed. Skipping all kernel notification tests." $KERNEL_NUM_TESTS
+	exit 0
+fi
 
-	validate_lttng_modules_present
+check_skip_kernel_test
 
-	modprobe lttng-test
+if [ $? == 0 ]; then
+	skip 0 "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $KERNEL_NUM_TESTS
+	exit 0
+fi
 
-	test_kernel_notifier_discarded_count
-	test_kernel_notifier_discarded_count_max_bucket
+validate_lttng_modules_present
 
-	if destructive_tests_enabled ; then
-		# Those tests add a new user on the system. Since it's a quite
-		# intrusive change to the system, we decide to only run it when
-		# the user knows what they are doing.
-		test_ust_notifier_discarded_count_multi_uid
-		test_ust_notifier_discarded_regardless_trigger_owner
-	else
-		skip 0 "You need to set the LTTNG_ENABLE_DESTRUCTIVE_TESTS environment variable to \"will-break-my-system\" to run this test" $DESTRUCTIVE_TESTS_NUM
-	fi
+modprobe lttng-test
 
-	modprobe --remove lttng-test
+test_kernel_notifier_discarded_count
+test_kernel_notifier_discarded_count_max_bucket
 
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
index 7c4191a47..a7a4f421b 100755
--- a/tests/regression/tools/regen-metadata/test_kernel
+++ b/tests/regression/tools/regen-metadata/test_kernel
@@ -105,6 +105,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/regen-statedump/test_kernel b/tests/regression/tools/regen-statedump/test_kernel
index cb0c0ad5e..935424f30 100755
--- a/tests/regression/tools/regen-statedump/test_kernel
+++ b/tests/regression/tools/regen-statedump/test_kernel
@@ -45,6 +45,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/rotation/test_kernel b/tests/regression/tools/rotation/test_kernel
index 817019036..0fc3178a6 100755
--- a/tests/regression/tools/rotation/test_kernel
+++ b/tests/regression/tools/rotation/test_kernel
@@ -113,6 +113,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel streaming tests." $NUM_TESTS ||
 {
 	validate_lttng_modules_present
diff --git a/tests/regression/tools/snapshots/test_kernel b/tests/regression/tools/snapshots/test_kernel
index 870c437b2..f6b22c7aa 100755
--- a/tests/regression/tools/snapshots/test_kernel
+++ b/tests/regression/tools/snapshots/test_kernel
@@ -228,6 +228,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel snapshot tests" $NUM_TESTS ||
 {
 
diff --git a/tests/regression/tools/tracker/test_event_tracker b/tests/regression/tools/tracker/test_event_tracker
index 98ca990fc..16e2ea20a 100755
--- a/tests/regression/tools/tracker/test_event_tracker
+++ b/tests/regression/tools/tracker/test_event_tracker
@@ -474,6 +474,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel tracker tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel tracker"
diff --git a/tests/regression/tools/trigger/test_add_trigger_cli b/tests/regression/tools/trigger/test_add_trigger_cli
index 9ba8c22f0..938801239 100755
--- a/tests/regression/tools/trigger/test_add_trigger_cli
+++ b/tests/regression/tools/trigger/test_add_trigger_cli
@@ -40,6 +40,9 @@ else
 	ist_root=0
 fi
 
+check_skip_kernel_test
+ist_kernel=$?
+
 function test_success ()
 {
 	local test_name="$1"
@@ -223,6 +226,7 @@ test_success "--exclude-name two" "trigger5" \
 	--condition event-rule-matches --type=user --name='jean-*' --exclude-name jean-chretien -x jean-charest \
 	--action notify
 
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 18 ||
 skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	i=0
 
@@ -262,6 +266,7 @@ skip $ist_root "non-root user: skipping kprobe tests" 18 || {
 	done
 }
 
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 6 ||
 skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 	test_success "--condition event-rule-matches uprobe" "uprobe-trigger-0" \
 		--name="uprobe-trigger-0" \
@@ -274,6 +279,7 @@ skip $ist_root "non-root user: skipping uprobe tests" 6 || {
 		--action notify
 }
 
+skip $ist_kernel "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." 30 ||
 skip $ist_root "non-root user: skipping syscall tests" 30 || {
 	test_success "--condition event-rule-matches one syscall" "syscall-trigger-0" \
 		--name="syscall-trigger-0" \
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
index 36e669b32..e14f4f450 100755
--- a/tests/regression/tools/wildcard/test_event_wildcard
+++ b/tests/regression/tools/wildcard/test_event_wildcard
@@ -132,6 +132,9 @@ else
 	isroot=0
 fi
 
+check_skip_kernel_test
+
+skip $? "LTTNG_TOOLS_DISABLE_KERNEL_TESTS was set. Skipping all tests." $NUM_KERNEL_TESTS ||
 skip $isroot "Root access is needed. Skipping all kernel wildcard tests." $NUM_KERNEL_TESTS ||
 {
 	diag "Test kernel wildcards"
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index 44b3f167a..006a516c7 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -323,6 +323,17 @@ function conf_proc_count()
 	echo
 }
 
+# Return 0 if disable kernel test was set
+function check_skip_kernel_test ()
+{
+	# Check for skip test kernel flag
+	if [ "$LTTNG_TOOLS_DISABLE_KERNEL_TESTS" == "1" ]; then
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
