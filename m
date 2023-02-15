Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ACAC636D7
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Feb 2023 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1676482883;
	bh=ihBvwNMk66wSp8FJD9hnH9pMjcdIOHJOM/c/qbFroF4=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TYlu1tmItmQKO34Zai/g+UNsVyR8LOuJoHzBg1WcAw44lfOXktKjbvwzgYMqfgvHz
	 8VCVroo6lxNxgeeWxGN2p315lA88y6XxOxclBy8Zy8+eoe5+nsGCePnHrZyWtNBRqB
	 6gLQs+56e1PyHem8DNdYnda60Wt2Yf1gPEWzGGkmw91KB4gjdQgXiuQgk0YYJ+RCFf
	 mQDjGYrnGpIWsJZ0lxOiuwNEsSgMaSrHTGQ0kNbbFb/pe/4l5Y1oJlM/EqsScnfZOA
	 7YhFk6XaTzo+yEWPtkS0Maa+Ein4fOs2capVcm0rCp0olz5U8/fRsdan7bjFwogHAg
	 WoJU6xK2GuWkQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PH53Q2hL4z1fGh;
	Wed, 15 Feb 2023 12:41:22 -0500 (EST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4PH53N3WXCz1drn
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 12:41:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAxPDrBDnWytpeG+0c/2LcbpX088Z/+6pSs5KYyBxjwe883w3vrtdwqn2QxKpUble5M6q1W3GcQsvxZtNAGWXqOYknUY+0s/fZKE3OMOJx2Nj2SatWi8ojZNURflABRaIAStxFhV3MNH2HagRtm0MKK4Lu3W3/2ouz/kd+uWFPTXde87QgS9bChpB3j8Ee4DOOKx9cSHhwl9THN5rTfTiRQl6YKqe0miXj6lUdGjWVJQrQDR35JiZU+N+Hm2THj5tSHeF4Cr80vay+cHKcXIdi9EK9w/z2l0rULD7O+fsoz3kDY0I9urkYDo7+OM/eRKeQR53sI85dPGR9baB+sCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ffc2uEQPN3fxPd8F9zfVmD7aTXb2RUpj9f6XEtRPNg=;
 b=mxnb8U8SdSFs4Ki4Ew7IZttMW7KHAwIG9NJbJ+ixfXiWO3QGLAXdE3Sdkarn5EL0dK03z8zGTW0Yi8dmf+iR1EG7ArdPnFLXHuMAqpnKRK7scKnPylgFGhgjMt3lDXb5Wxi/6jPQctzfUUZi8ouWKcWhaLVhRXNgav4xlk440E1+rKIkh9Fxpv4lt7dGtUm/k00+ssfbDfl9caPbJQgW3ph04SIATl2VbsLCSksCz99JkhyZspGkTBtFuHhaNH11hj7YjUSBMVZoY5KGfJ9JBtf3jamdzOjo+UtmIZ+KwH38LNEpnIFYZ6bS4giNNpzSWVc8CxplDGFW3x29UwULSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1b::15)
 by YT3PR01MB9123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 16:07:11 +0000
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2056:3189:23c3:4219]) by YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2056:3189:23c3:4219%4]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 16:07:11 +0000
Message-ID: <23e57074-486a-6986-c682-a5953091e5f7@efficios.com>
Date: Wed, 15 Feb 2023 11:07:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: "Rus, Sani" <Sani.Rus@windriver.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <BYAPR11MB3765008946045C0150271D6E94A39@BYAPR11MB3765.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3765008946045C0150271D6E94A39@BYAPR11MB3765.namprd11.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::33) To YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB5082:EE_|YT3PR01MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 801d6ced-27f0-405d-c74b-08db0f6eb245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeNRtCtLqfPCFSOT/xyVpoiCJvR2Pf1uI/xAff2es4uwtsiKQKiCBbT5RWS9ePFeLLIEfeQZ9BFyLMpBuRHkPv+rjmRpZig6SF+yCE6e4ufxDpV0mGN8gbpMeGRX1KFWY3JDlL6+fUSKzzNXzW1u53a50QFkoFzgWR26bwPsWC9xw7TzYxYhMFBVYDlCDXsK70Xm6S2mVRfzNxAwHvGQN+tnrVGc50hvaS9OqVDQLLzlM8JbbA0VcKOJMksB24DYuYGSmm4PKSYnNGz6ILcSoWyECqVZZHAKAH2T1iFGm887Hfj7XsUkmlzKx/rKStQg1CA7yppoM54x5lKLV8s283JTiiKFSk1BglhwZpfMH5qzLBTT0RR/tWNFGidXtu9xqLw+VaVt+VCu4RmTdTc9CRWaIEDzyZlMgtPjUFuty4fHagd34WnmlQcbRLYxsjLZzC17C5huaCxr/yNhp6uyI1SNWCJYJoCdFyK5mhpcnwmfxMCvCYfaEwz4M+nVnVftfk0yDgochhBxbDx+JfkcwVBgjkQaFTrjcd8pOGTRwHjwgjRha8dqGm+DNAjrTiHNZiYwu5jf/AKS0IZiCHXqYnbGVarIFu9XE7eBviC+yNPenw23Vh1SBCwVY1N4OIp/DWPBKALtbiuDGewl8tUzETGKdeo6zGfvdw7c1CWyKLYb8Jbq2AsMSCieF96dFQJ5beuKxflynFW8T+p0KSJzn3pBIGp2iv6259GANUlyWfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199018)(4744005)(31686004)(83380400001)(38100700002)(36756003)(478600001)(6486002)(966005)(86362001)(31696002)(2906002)(2616005)(6512007)(6506007)(26005)(186003)(66476007)(66556008)(66946007)(316002)(41300700001)(53546011)(110136005)(8936002)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFTSXZIeHQzNlp3NmZxeHYrOHloZzFra1dYczBwbnhXNWVZRnlEcVFGMUlx?=
 =?utf-8?B?YXBlN1pLM1B6TGRVT0Y4RmVDa25KMnRQa2gzMFByMEh5K2huK2p0NXNlR2Fv?=
 =?utf-8?B?RCtwcUdvaElleG0zWEpsV2IzTlZ4SUpaK3NPbjVQZUp3UlR4N3orcjVxd29y?=
 =?utf-8?B?bjNydkVXVm9LYlFib1ZuSjRiWXlsY2hMaERJZ3pnZE9NY3dIMjNsbURBUE1K?=
 =?utf-8?B?Z040MkxTbm9IRkQ5Yk9ERHhZelhhZnlsYkthV2dxU0J6OCtNUkd4MGVxTGQv?=
 =?utf-8?B?dmRHSkI1dHpvTlJXbkF4N1NJdC92S3NJRHNWSTZsY2h2TUxsa0s4VGtTUnpQ?=
 =?utf-8?B?ekF1TXhLaWFMejF0MGlmVDkwU2hwSXlYcjV6OGpodXVRTzZPYURzZzdUbWR1?=
 =?utf-8?B?Nm5ENDRqYWNxNHNycUEyeGNuYmxFSHl6em1nVzJJMmg3NFpHTnRWMzY1UVU3?=
 =?utf-8?B?ZTdiVXJkV095SlR3Q1l0S0hoQmFFTUF4R2IvbERKTlNzbVBLSUdLSUhRU1Bt?=
 =?utf-8?B?SHpqQjJPbm42L3F2eENVRklveWJxYWdIL05iU0FWY3FTV1QxN2pjWE1kMTlL?=
 =?utf-8?B?SWlzanhjK29RVVFMVWNPU1p6d3djOEM3QWtlTmFVVzR4UXVKQit2T2o1OXVh?=
 =?utf-8?B?NjZNM1ZLK1VtREVsU1g1MVlXSFgyaUViNW9KeWUyMUtEb2xOZmpqVFppbUhs?=
 =?utf-8?B?RUN0R243MGsyaFl5YmlXK2t0SDFJNkVUdGVGaUNERXFvbDRpUTJUb2tQM2tn?=
 =?utf-8?B?RFRkSUVoUXFGdVNES3l3dGlkcng2ZDRKcFQ0cE55VElUM1lFTzk5SE1OeWp4?=
 =?utf-8?B?RllYcDZyWTlUM2hPK0xNYWRMLzg2ejFhblVIN0NUUEErbWZMU1ZWUjk5T01k?=
 =?utf-8?B?aSs2YjN3dEo5dFd5djByZXk2OXNKQ0hXZTJ2QlIzdTBRV2lWd2YvREdxNWMz?=
 =?utf-8?B?MTlodGx3cWNNYWZNN0gzRXlYU0xoZXlRcHl1ZmVQQTZEOGdTVC9EMEkydnZN?=
 =?utf-8?B?eG41N2NHSGtlc0JoQzZkZ01nZWNYK3VKS2lxL1BsUmhZbmtIQUdkVlppdFBj?=
 =?utf-8?B?NFFQZ0NOSFdwa2tLNkpNUmRIUnBqVXVUZFI4YWNEMHJadzBZaERKQ2krTTZi?=
 =?utf-8?B?K2ltSHh6TFgyUGx3c0REcXJIUjJ0ZDVVL210NTBpY0dGWk1uNWx3ZlpjcEVq?=
 =?utf-8?B?V0N2UENpbHBYWHRUR29LQnYweW9oYnRqQ3A3ME5aZlhQanBOODlKWE9hWEky?=
 =?utf-8?B?Z2ZUSkVHZDh6NVZwL3hZU0gxSzZlZlRPUFd2a2REYUc0RlNWeG9tOFJzbDE5?=
 =?utf-8?B?c2hiN2htWEY1eC9HYm5oWlFjN3FoQnZ1OXhwWmRyMGVRUWw0WlU0dC9UeE93?=
 =?utf-8?B?MFJPM1JmdXRQdHpNV09NWEowOXBnYWR5Q1ZhUlQ4cW5kcXJOakMxSEx0d1h3?=
 =?utf-8?B?eWVRTDBpeGNDYUUyRWc5ZkNCakEwdStwUE81aVYwM29Ba1hqbHJNWUhTNVRW?=
 =?utf-8?B?QVlPam9XV3h3bGRvOUJvZktENnNtMUZMbnhRcitpNHVjNG12TldlU0o2djRp?=
 =?utf-8?B?cmF6QS9ZMUtDZWp3dzhwZlJpaVJvQXlEaFRWNmQ0L2JmN3ZxQkUyRDZkK0h5?=
 =?utf-8?B?RHpoa0l5Tk9NbHdnR0I4eEdxS25OM0ltbUxkdUdVUjFBWnR1Wm1IdTBPT0w1?=
 =?utf-8?B?czFSNnJPa0ErNXN5N3ZaZDZDd2ZsYlU0K2YxRGdKZkRwdWxGVnFKa29KZStM?=
 =?utf-8?B?ekptd0lLV3A4OTJYMmN4TEdHeVVUZmpSWUUwUEV0b09hcUM4RGV3aXdpaG5v?=
 =?utf-8?B?V0RHQVFQV0M3ZzZhT3oxblJ5bDhYYU01YlhzZE1CSG5PcitFRjk5M09hZEEr?=
 =?utf-8?B?TDhrc2lPZU80bnB0c0REUHFwTnFqMXhBTmFBTXJnbWZrSFcvdXptOTVqY083?=
 =?utf-8?B?WnYvZkNqWHZQWkN0cm15L2lxblRpd2I1TnVEZ1YvQTdueUpHY090TkNzVFF4?=
 =?utf-8?B?aXZZYmI4dWFNRit0aDdOU3NhOUQ4MDZVUVh5ZFNUQlJyeUNvZVBIMDBXMTNz?=
 =?utf-8?B?Qk1nYWhXYnhBQkVZZ3RXT29JR2ozZDNpaFdzemZ5M2JRWXI3Z0srMUYxMmFJ?=
 =?utf-8?B?aFlKbU5YUGxuS2piVWVkWnQvdVZkTFlqdU5obWRrSzl5eFZkb0R5ZkhrMzZw?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801d6ced-27f0-405d-c74b-08db0f6eb245
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:07:11.6199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CapLlJ+CfZCnKOLoBam64kJQMka3V0id+Iu3AoiMAhfjfgz4AJYh/qTXD1PuJXm4FK6hEn65mCttz9hXsiGbaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9123
Subject: Re: [lttng-dev] LTTng bugs repository - pending administrator
 approval
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-02-15 09:56, Rus, Sani via lttng-dev wrote:
> Hi,
> 
> a couple of days ago I registered at LTTng bugs repository - 
> https://bugs.lttng.org/ <https://bugs.lttng.org/>, but I still can not sign 
> in. At the login I get the "Your account was created and is now pending 
> administrator approval." message.
> 
> Do you know when the registration request will be approved? Should I contact 
> someone in addition?
> 
> Sani

I approved your account.

Cheers,

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
