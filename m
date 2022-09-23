Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3495CC07E9D
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Sep 2022 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1663957434;
	bh=Sz3EGcH6k0u4s94Yynx1/seb9YIKVg5/H8iJovqFOVY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XBXdWV5DSw2X7wCpA9/h1IxQSl7QJuGw/BK2WT8uak/Q2bta9B59X3QYgiYjyTsXw
	 MbhCUsJ4ja/bHqcTiALT31gTjyrTPMNzTDWDOlKYFv7PXtU82ZIG9sfAiwxGr9Yhv0
	 MqSQDWCE+jLeNJ9PaOy6QrtIgCGbwWy/kLgDgr83NZRMyc2zHdAOsTWL/WMAaysi5P
	 pe7F7CUur3YSWI2sP1Mpo4c9ucVcIGlhI6pMMW2jGMX1Hr7pTt3z8CoBJsjLzGIBRY
	 qcfrXkWYPHdRPDLRDYBRvAIIuGRo3XdG3OoK1EyCRLavUeSx8yjSWIShDuB6uyiGQc
	 wBOqmLNJJqGGQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MZ0sP3PdBz24JH;
	Fri, 23 Sep 2022 14:23:53 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2083.outbound.protection.outlook.com [40.107.115.83])
 by lists.lttng.org (Postfix) with ESMTPS id 4MZ0sN3493z249V
 for <lttng-dev@lists.lttng.org>; Fri, 23 Sep 2022 14:23:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z17JbIXi2mTbQsbbBsDF/lHJpWsAEehZtBc/UkV/g0zEX8HCzVZ4AykmG7B81WLtQlxiTK8cjXhA8xGWMWISilrhgIRzknw2ldEJb40+yqzGtnJ2hhg+0ZhBHmBckT+prPkuq1O3mk7n0Zz3d8lDUMcGVPIC0KKy/+hdxhOr01WR2FW93CrobJgnPmbYVhS1JnCZ7DX4sosn2wiryGYAo91RG5VS0KaKZ5xMeeP5Nxe47kKVxTXg76CRKnqFtTs9MRg/uuaYim4N6g5o6xuT4z+DzhheGQA5LJeHqq9qgF0QSjU2Et63Mnp/n2vMOFDaK2FnIX+EneOYUBMZKAnApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvgMgImVO0hqHHrgSbRHlkrY3Ldjlwm1HnMHOiCFnH8=;
 b=mtRRjAC9sPJawkQm8Lv4mh4pJCngcCL5Az07pQpoPMrxPJU08JYlAXJXum2bXv6x0XNLB/SzbznNeYadn+CQb1QxwrGt3CBplx2NqToknmAsRZPW25OfPR0gE8iasRhtWjk5xKx74EcxiSsLmC35SFJZl+FS0wd1jKqz06GSklMS199/CsAsUItW79/FEbZsQPfjtejlWZRLz2zqx8waSg+9mzG4DfH/14PsFfmipJYeF1ziLfL2zorm8rJITGx5tGmy9LBKhucnl6bo9Ub38rwxudRDnfPSZxeakI2tOM/dvG4AbSGiUmRxbo3CXUQyDcSGE9w5fSSWXyN3nQGQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6640.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 18:23:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 18:23:49 +0000
Message-ID: <6db30f66-8237-fef3-d92a-2e36be9efdf6@efficios.com>
Date: Fri, 23 Sep 2022 14:24:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org
References: <20220922091536.GA4597@dcvr>
 <eb0bc02c-904d-1166-ddcc-39bbece70a67@efficios.com>
 <20220923175503.M564483@dcvr>
In-Reply-To: <20220923175503.M564483@dcvr>
X-ClientProxiedBy: YQBPR0101CA0233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 93714a2c-ac07-4ce6-a70a-08da9d90c2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRK6gDWCXiAQ2qTPZotZHYfGqSmbCO+RzM2mLBGXIXvG11lcmydBOUV5q9NJ5XM+oSn2xQ7XAa/M4aXme/3xrWHqGlSO5/jEt2wUaod+th3jRbCVxGH4lnwByWp2DT5oWlCtC62mEBgVitAQetSUP1SXDbkx15jQ1roP3r2NqbnJwDR5Yi0pWTxchiqWVMf9R0gs7XiCp2JhAPfBqrpH4KBsLfVsw0xj1JVijpooVaBc2qHkrtHhJwyIAlhs0X8+4kyeZ8AoxHrAS+fyh5vpBSeRGjeoyQ9adbfa7NHMoYW+mLy0H0OECAG2lR5MtpfpwY2SWh8B8luhUALfi0Nx35Mo3R9PXsGr0FN9V2J9FPTAWWVwpv/H0nYDKG5dRUOj+/yF+jXMnHSHkH1cbtdLuSOLvmqtjRPmmBIL9bhHcOboWgB3oISNKsBnVpC7pMs7nyBOF/QC5MA9KpVNkIeKiZp0u8o+xMNCyRm3Fxm+08DGxS52l4LgyC3hi6b7VXDE03q1x5ONLWI/s6wtF0g/MAgxPMtguqB0dTDq2kQJ0VyPp12V18DAhA9miJGIFvfMykX7x0O2RFAdpKTYDwvMpNPL3XE6oghavmNgysPc0LVdlv2qBv4trtdVVZitxbnszYEp2hEx/a5qQv/FVx04kZHoWw/BY2qBCcwBpf0R+MsOFtKMDxbC11BQGtsbRvkcljaOcubyBFp/YDFYTd/zyIcagRwHBJ11T0mUkjnYi0GKvpYnl2cndQavRw/SElLGK65GH5uYj3gE4jIQ2bTUqJK5VqNcC11rytjUd1s8YgvvGGWq33zmbtwRSoIAGYaX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(34096005)(136003)(346002)(34036004)(376002)(396003)(366004)(39830400003)(451199015)(6916009)(66476007)(2906002)(4326008)(8936002)(66556008)(66946007)(38100700002)(5660300002)(36756003)(86362001)(31696002)(44832011)(6512007)(83380400001)(26005)(186003)(2616005)(498600001)(53546011)(6506007)(6486002)(38610400001)(586005)(8676002)(966005)(41300700001)(6666004)(41320700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FCWVpGS0FHbDR6UVJmVkIweW9KZVhmTUgxWkd1RUR3OW9yblprMy9HNW5N?=
 =?utf-8?B?OSt0a0RNSklPRFFKazI0YVpxam14QVhCZEt3RDN4QnVsZnVhRzlVVWdDZEpO?=
 =?utf-8?B?Q3owN1dvL3lpNjFWTHhLM0RaM1dwTXp1Q0wvMUp2cEdKY3lJaW8wdmNaWEJF?=
 =?utf-8?B?R0RycWl1VnlYWFh6MUlYUjdQYVlPUVVtRklqUVRDY1lWWG91Qk1MZXBWbUpB?=
 =?utf-8?B?NWtGeDFlRkUxRk9BWGlqeGJpYmtOZ2VVaUdZYUhmbHYwZjhmVklrVW9Qc0pn?=
 =?utf-8?B?NGN0Smdid3BacFcrVG1NWjNNMmE0MUk2U0hhV0pzU0ErVXNCbzU2ZGFFNWxr?=
 =?utf-8?B?bHNMRWEzKy9pRnlYS2VPa0doMnZZaE1iaHpnK3IvWVRMZ3FNbmpaZHJtVEVK?=
 =?utf-8?B?aC9zUUhYdnZiVHlRWFczNm9TbCs5UmV2WVhPUmdPUzZCb2ZyeTZRTVZDc3E5?=
 =?utf-8?B?YkhCbnF0V3N3aWNsRmR6eUNuQXlud295N3RFMTgwZkhXTmhMcFB6SG9xbDBm?=
 =?utf-8?B?RWowNDRobVFGT2VTQlRkdU1vc3VjU0FBODdoWjd6ZVBja2d4RUxjeURXNlFY?=
 =?utf-8?B?RFIxOXRUb3pGL0FndGZWNGJzMDhBRXJNbGM3bjlFbUlXTnRjMSsxQlordkRt?=
 =?utf-8?B?WjRIM0MzVjlmNmtsT2g3R2FrUFRGNERadk1NYVI3UDBBMEFDUk5aWEdHKzg5?=
 =?utf-8?B?aUxjVlkrU0praTN5dklaVmkyazgyamd3WGhMR3A2YS9udXJkV3l6Q3htdVFK?=
 =?utf-8?B?K1RPQ3ZSVVJMeUJOWmprWTZmS1VaN29YbkdONVFzclUvRVl0b21JbHByVmNL?=
 =?utf-8?B?Rjl2RXJMeEhNekNrcUR0VGVKZzhJMzExRnR4WEN4ckR6ZlVlN1MrSVMwbmtK?=
 =?utf-8?B?OUxVTGI5WGJMbkJ5TVljTGtsa1VEaXlIY2p1S1Z6RG9oUjJQUEdVczIvbXBs?=
 =?utf-8?B?UklubjVxSEFVOERDL28rWlIwZFJrRFI3TVJlQi9BYWdKbzVkTFRKZWN3cE82?=
 =?utf-8?B?MEtCUDBoZ0lieS9tSTFocERmRUdjMXRObzIxYjZGT05PRWNqTmZVTVovME1q?=
 =?utf-8?B?WkttVHR2SDFlMWswZFlWVFdVVzB5UUE5WFlZbzdFUUtkSHFZeG8yTGFYSkpy?=
 =?utf-8?B?cjZqRGVTaW8wU3dlYVozK2Y3akRwdmtPYUpDT21VMjAyaC8wNm11eS9NNnNo?=
 =?utf-8?B?bUVBVVJ6SGZKdWloV1NOb0wrVDdJTXlhNm5Wa0JiUkRZbXplMHhsaEg2S2NS?=
 =?utf-8?B?dWU2UjYyN0hyek9aWlNZY0htRzRiaE9jNy84SHA4UGpPcEtnQ1RkYzZXdFlm?=
 =?utf-8?B?NlM0a242Q2pQanZqMjRDK1dFOGY1RVZKSml4OVhGam02NnFXcWpZbVN5L29U?=
 =?utf-8?B?UE5HOU5mSGdIbjEwUVlnYjRRbHJ0Vm56TUwrdnRjVWNka05QeWp0UkJDN0tL?=
 =?utf-8?B?R2dMNkR2OGF0UlB2RkVZOXlCVVNjZWdVajl5QytPRnVvTzFxdkwxbkQ1TzRV?=
 =?utf-8?B?bEVGVkxEUHM2SkJSTjVleW5vc1E4bmhxQVRMZldjeGdDNkhWaVhYdmdMejVj?=
 =?utf-8?B?VHN2T096QjJ2WGxIRzBpOU1PSjhkK29lcTU2emZvQ0pkcTZQczlNRVZWcCtr?=
 =?utf-8?B?RGhjRWNCdnUvMGl2UGIwc0d0bmxZT3dqTE5JZS92cksxTUMyRXhEcXdHS2pl?=
 =?utf-8?B?WEUrT0djZ1pNUmpYMHJlc2NFWVJ5R1l4YVJtaDVMa0xqdFE3Vm9KaCtGYXdR?=
 =?utf-8?B?c0NYYi9YcnM4dkdnOEQ0V09zQWNnamExNzlCT2liZm1CVzV5dGR3allYYzE4?=
 =?utf-8?B?R2RnVS9xeWJETmF2eXRJUmRxS01kL09SUkxlTUhQSWJlVG9kdGNnbkZidk9V?=
 =?utf-8?B?UlVnaXI4QmI1Si9JZzRVaW9EazNuYkpaTnB3b21lcTlodXhlR25RaE5JTi9l?=
 =?utf-8?B?dTVDYlRyR0prUkl3eURrY0JGZW9tNFp4eHkraXpVWUNBVU5VNm1PUEk0SGFw?=
 =?utf-8?B?bUYyRU5FTXZXK1BPRUtNWUE1T3N1U0pia3JaQ1YvbUM0bHduUVhrdEg5dXhw?=
 =?utf-8?B?MXpiVU8wMzFKV21yMnFnV25JZWRiV2RidVRFSDdJZGo0d1NCelp4TElaalNH?=
 =?utf-8?B?ZG1qZkZyNGg1VXRySlNZWnMySXpmNFhIQkMxMjdQNkxNRU5yV0Nla0VEMnBX?=
 =?utf-8?Q?Bm+NsiUS7xn/T17/hH4fOiI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93714a2c-ac07-4ce6-a70a-08da9d90c2d0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 18:23:49.6901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLyibDVrEWgjjuzdO5VioDcrXAdJ/pIVE+rFQ4EfIsJfM8QxwmJmKuBVYa58zLFWFjLzMAH1/XwHiLJSCUGODkdSRrg82HM0r+6SDTYkSTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6640
Subject: Re: [lttng-dev] URCU background threads vs signalfd
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-09-23 13:55, Eric Wong wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> On 2022-09-22 05:15, Eric Wong via lttng-dev wrote:
>>> Hello, I'm using urcu-bp + rculfhash + call_rcu to implement
>>> malloc instrumentation (via LD_PRELOAD) on an existing
>>> single-threaded Perl codebase which uses Linux signalfd.
>>>
>>> signalfd depends on signals being blocked in all threads
>>> of the process, otherwise threads with unblocked signals
>>> can receive them and starve the signalfd.
>>>
>>> While some threads in URCU do block signals (e.g. workqueue
>>> worker for rculfhash), the call_rcu thread and rculfhash
>>> partition_resize_helper threads do not...
>>>
>>> Should all threads URCU creates block signals (aside from SIGRCU)?
>>
>> Yes, I think you are right. The SIGRCU signal is only needed for the
>> urcu-signal flavor though.
>>
>> Would you like to submit a patch ?
> 
> Sure.
> 
> Is there a way to detect at runtime when urcu-signal is in use
> so SIGRCU (SIGUSR1) doesn't get unblocked when using other flavors?
> 
> I actually use SIGUSR1 in my signalfd-using codebase.
> 
> I also want to remove cds_lfht_worker_init entirely since it's racy.
> Signal blocking needs to be done in the parent before pthread_create
> to avoid a window where the child has unblocked signals.
> 
> Thanks.  Anyways, this is my work-in-progress:
> 

Perhaps with this on top of your wip patch ? The idea is to always block 
all signals before creating threads, and only unblock SIGRCU when 
registering a urcu-signal thread. (compile-tested only)

diff --git a/src/rculfhash.c b/src/rculfhash.c
index 5f455af3..a41cac83 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -2174,29 +2174,6 @@ static struct urcu_atfork cds_lfht_atfork = {
  	.after_fork_child = cds_lfht_after_fork_child,
  };

-/*
- * Block all signals for the workqueue worker thread to ensure we don't
- * disturb the application. The SIGRCU signal needs to be unblocked for
- * the urcu-signal flavor.
- */
-static void cds_lfht_worker_init(
-		struct urcu_workqueue *workqueue __attribute__((unused)),
-		void *priv __attribute__((unused)))
-{
-	int ret;
-	sigset_t mask;
-
-	ret = sigfillset(&mask);
-	if (ret)
-		urcu_die(errno);
-	ret = sigdelset(&mask, SIGRCU);
-	if (ret)
-		urcu_die(errno);
-	ret = pthread_sigmask(SIG_SETMASK, &mask, NULL);
-	if (ret)
-		urcu_die(ret);
-}
-
  static void cds_lfht_init_worker(const struct rcu_flavor_struct *flavor)
  {
  	flavor->register_rculfhash_atfork(&cds_lfht_atfork);
@@ -2205,7 +2182,7 @@ static void cds_lfht_init_worker(const struct 
rcu_flavor_struct *flavor)
  	if (cds_lfht_workqueue_user_count++)
  		goto end;
  	cds_lfht_workqueue = urcu_workqueue_create(0, -1, NULL,
-		NULL, cds_lfht_worker_init, NULL, NULL, NULL, NULL, NULL);
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  end:
  	mutex_unlock(&cds_lfht_fork_mutex);
  }
diff --git a/src/urcu.c b/src/urcu.c
index 59f2e8f1..cf4d6d03 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -110,6 +110,8 @@ static int init_done;

  void __attribute__((constructor)) rcu_init(void);
  void __attribute__((destructor)) rcu_exit(void);
+
+static DEFINE_URCU_TLS(int, rcu_signal_was_blocked);
  #endif

  /*
@@ -537,8 +539,52 @@ int rcu_read_ongoing(void)
  	return _rcu_read_ongoing();
  }

+#ifdef RCU_SIGNAL
+/*
+ * Make sure the signal used by the urcu-signal flavor is unblocked
+ * while the thread is registered.
+ */
+static
+void urcu_signal_unblock(void)
+{
+	sigset_t mask, oldmask;
+	int ret;
+
+	ret = sigemptyset(&mask);
+	urcu_posix_assert(!ret);
+	ret = sigaddset(&mask, SIGRCU);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_UNBLOCK, &mask, &oldmask);
+	urcu_posix_assert(!ret);
+	URCU_TLS(rcu_signal_was_blocked) = sigismember(&oldmask, SIGRCU);
+}
+
+static
+void urcu_signal_restore(void)
+{
+	sigset_t mask;
+	int ret;
+
+	if (!URCU_TLS(rcu_signal_was_blocked))
+		return;
+	ret = sigemptyset(&mask);
+	urcu_posix_assert(!ret);
+	ret = sigaddset(&mask, SIGRCU);
+	urcu_posix_assert(!ret);
+	ret = pthread_sigmask(SIG_BLOCK, &mask, NULL);
+	urcu_posix_assert(!ret);
+}
+#else
+static
+void urcu_signal_unblock(void) { }
+static
+void urcu_signal_restore(void) { }
+#endif
+
  void rcu_register_thread(void)
  {
+	urcu_signal_unblock();
+
  	URCU_TLS(rcu_reader).tid = pthread_self();
  	urcu_posix_assert(URCU_TLS(rcu_reader).need_mb == 0);
  	urcu_posix_assert(!(URCU_TLS(rcu_reader).ctr & URCU_GP_CTR_NEST_MASK));
@@ -558,6 +604,8 @@ void rcu_unregister_thread(void)
  	URCU_TLS(rcu_reader).registered = 0;
  	cds_list_del(&URCU_TLS(rcu_reader).node);
  	mutex_unlock(&rcu_registry_lock);
+
+	urcu_signal_restore();
  }

  #ifdef RCU_MEMBARRIER



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
