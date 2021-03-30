Return-Path: <SRS0=+kpx=I4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDCC433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Mar 2021 02:53:28 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2B961920
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Mar 2021 02:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2B961920
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F8Ysx5yNnzQZc;
	Mon, 29 Mar 2021 22:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617072806;
	bh=y3xnHjQcSTDhKGSgyWuQXbtI51vSQUKvX5x7YcK0scg=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=rvFwO2y3UWL7vVauEupswwi18XlddsOPJDwjzVmpmu5tE0bBHAa+p1fmBfAaODliy
	 uGwfTM8AOKdU6ij1L/rrrQ06KGRvTfk6f7sVmRN2A5szA78lYO2dIHIsxvD+zR5Wqk
	 jBZVr2IHxFxHp4sTpjLrxEozDBz6ygNNdXabZ3YbMobUILvlU4zk4PvdILOXoftpAL
	 +Rfy57XlM+zGXxtt8krhaIEQpVXOz2QRJmF+KAUCIWKlf4V3uBt8mIVJ69/YSkaVn+
	 8tFY+IiVtV7fcidKDERMYTgcQnBX8ifp0CtZOfQRfwvbMwOt9qPOtOlXJWV+d2VeN5
	 9s3hSExtqZN6g==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by lists.lttng.org (Postfix) with ESMTPS id 4F8Ysv48w7zQZT
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 22:53:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odPuE+zCUeVlkvLhwgqVODj/q8jQPWDCOCDHSFDF5ghgzY1RIbT4EO+aLbPsl1DuR6WU/t4zwsWaGj4FqIrrpyif2Xy9GAR8MYvnudxfeTBb6kgbEZFkbd/W36JVxMUzJ16ikAkuROdJ/qNT5cLkAlZ+iyNXkhjds00tr4zgfZCXTXJhnL3K3cUOZmYC6G1Ve3w47OqYSlIgWCaZU0a/db/+cSWU2mHfD7AnEuNCULyHhbEs9t9oj7r4tAIPDXRypLNllj4ZJwGkR1WfeJpaTL2+lGr+vgVhnxt9lyMb9SQHU6Jqgf+BIVjEuXtNdotrL1Q5fI4UQwcBH4yHid3W1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuQyVdydj+eligOBrmOqvGjg8ra5XZuY7h8tSqgtGPo=;
 b=hsn312buapwFVIigJ8GlVK+GwZi3JilX0bGyhVByszqg5tPFhEUKmW7xQc9G76inaks0DCK2HCU0WMldbw6vf6LSx3cpL6ffts5TbsPVuJAqfPiZWJKJH4p6ql/K9D5dZ60j9yhTsBLN0Q7eWoWpKf5++dNLZJ23QWtbfTnd/4dGA3qGQj4BDlZYA7RWAI25qIKEB2AzazBoSBcCFbBmQcpVt40igTtS364zQrnFD9TR6YasEORbIpjP9qlFzoWjleVabV7KoN762K8JS9xzcqcS/X6EXHtkib8HqTPxe3swSvR58HFzaytznkdjuGkrJt+JoDXhyyihKnkp1rY8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4418.namprd11.prod.outlook.com (2603:10b6:a03:1cc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 02:53:15 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 02:53:15 +0000
To: Michael Jeanson <mjeanson@efficios.com>, lttng-dev@lists.lttng.org
References: <18f8e21c-f82a-8a63-fd30-4acbd843cc68@windriver.com>
 <da06aa44-d0fa-76df-607c-9713d4799cb4@efficios.com>
Message-ID: <2a3eaaa3-ec56-8b6f-2e30-904e912b7493@windriver.com>
Date: Tue, 30 Mar 2021 10:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <da06aa44-d0fa-76df-607c-9713d4799cb4@efficios.com>
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by
 BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend
 Transport; Tue, 30 Mar 2021 02:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3a107de-dbc0-4ad8-45e1-08d8f326f700
X-MS-TrafficTypeDiagnostic: BY5PR11MB4418:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4418D004DF30DF4AC4BD5022E47D9@BY5PR11MB4418.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfn9N7LrbXueep828RcHt4mqqNo3IWWc32fNf9TxRjhykfswfpMf5o/FFSInaOpZPWhNzZu9zq9oUR8judUteL2BdrLDG882oyeqV0zoS0HjLyxZpNbLjEZh7Gd4ij0gmOmTSJWXSE2ANH9EsTCJanuCeGGTE3Rk+7EzFGp6C6m8nztZepllbiGvgAH7I4pAE+mhth/s2UYHqDd+tcxArKsqo5ADuYt/SSgym6pdDeDKMdN40W3X1VKHaVr7qhLapM8S6GS+5HeeQunipHPIYjRk8YoR2e1TxGuWIkGnfjOwraWJLUafcDUhm0RVkyEaieVpCk/ZAziS2v3/xtHDurQQetBPkDjrL0e85UeuSjNiRx3MO5lIbgzwiF3+qs7J5KY1Nuts6gr6jCQT9D7U2Qgi0EDLWFucy1fk7d/aRUnkRjEhBupM9NsG+iDxCxCRd2z4GuBqJ5FzW9G4I/rOVpvlKTbsO3H8Vhda8sMbB59BbUWemCWCyT8i2Oc8T8+T5ybjvL+BEuWr/zgZAS54oZasrnQJuQD7awZamLCG9OhkSwmybyL0OsEdjBZX3ZV1eqKm1f67bJp7DVkc/zJUa1Wcrwz5XtKTi41ZAHJE8sRcw+a1jAkI75J4Y9Xt7uHdXTRg0CrQ9CglRdO/0MbwlCny1rKKwN9lJzxNj7Puufz5G5BtQ8nHdwJmAP5feXpl203NgNR0eROFNQXgdfvXxU68IncO7eb2M1p9/Uiqj24P0MFX7twKhThjvZid6hnFDacf5pPPXMN09PwEmkbC/z9LqP8y65sUD55HxTQdB65n8zAeD/LqBrC+ZX84gBep
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(396003)(366004)(346002)(36756003)(38100700001)(316002)(478600001)(6486002)(66476007)(26005)(956004)(31696002)(86362001)(186003)(5660300002)(83380400001)(8676002)(31686004)(16576012)(8936002)(66556008)(2616005)(6706004)(966005)(66946007)(52116002)(53546011)(2906002)(16526019)(6666004)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEt0Q3I0U2Z1V002MVN3SGdmMHZITmo5My94OUdyVWZ6MkhaUkVTS1dpbEtM?=
 =?utf-8?B?RzdMdHc2SmZmWGl1NzJGMGVpT1VvaHdxQ2lYNU1tRFFGekZGbWk2MWJoSXEw?=
 =?utf-8?B?OGh3Y1U4UkN3TG5yTkxtTTVQWlJldlVCemdXMUNsUFRGUFdRcEl0VitRMVZz?=
 =?utf-8?B?MnNwRkJzY1g2K2paa25Kem42ZGM2MlprV3dkMFNhcmhXMitubWVhMGRzRnYx?=
 =?utf-8?B?NEUwL1pPTnBzZXlEb1R0aW9XVmNLcGNxS2pTTkViTDZibFU0N2lHUncwckE4?=
 =?utf-8?B?czJuYUFzVVZaaHArRGs1VUh2QjNYendOTXpiYkdHTi83dnZVMXhXK2xGa3Bi?=
 =?utf-8?B?SWdvcGhiOHRhUkE5OUJHdkJrS0FXMUNmZnJ4d0xDMEFPRVN2TzVJdUVlZEF2?=
 =?utf-8?B?Si9MZFcxOWtVcXVUSS9XS0g2NjBOZDFRelZsRGZyb1RpamRiQWhKRW5CbGRq?=
 =?utf-8?B?RGhnQnYyUS9XNlZmeXoreCtoK1RiNlB2VS90SnJZWnlyTVhHbFBpb2RmUmMr?=
 =?utf-8?B?SFF6aXlnemp0Qkxqd21ILzZFRWlFNGpBM0hDNmF4RkFOcDN2TGpZZHhQSlZG?=
 =?utf-8?B?VHppeFZXK1Q1Z3IzVFF0WndOOXg4VXMzRVpJMzYxVDdrQlFobHJDT3pGOWU0?=
 =?utf-8?B?WUl1MHBpQUtna3lWTkJYTDVpMlM0S2ZFQ1oyNVc4c2FhczRyekxIZXVxWXpv?=
 =?utf-8?B?ZWFSamZMb0N4R2hOdHl5b3VNZGxVTVZHem9IVzlNMWZBYnhlVmRUcWh4ZlA0?=
 =?utf-8?B?bWZzSi8wdW51Z1RadFA5K0dFVmpKd2drNklrSVFWUXJtWXp4TFFOSGFvS0xr?=
 =?utf-8?B?M1dJUjE0bXBhamhBeTA3WUEvNTN3L3VBQWJWc2c3LytnMVQ3dmpKTzNoSXdk?=
 =?utf-8?B?ajR6c1dwajVDOXFyalFueXh4WStOZE9RN2hzVi9kSWtjZFJvaUZqaWw2TUhC?=
 =?utf-8?B?M3VWeFVlMnJueEtTMHdOdlJlMGFpWGM2YUpUSzVyS0ExSXVaUU8xOXJpVjdO?=
 =?utf-8?B?bDh6UUUya3pOUFkyUUo0dWswUzVPOTNabXRYUzcvVFVocGJtRlBKaTNQYy9n?=
 =?utf-8?B?dTFnNkNHb3lJaWE3N2F6OUNsUmlqOG1LVTNBRTd5S25DcG4wL2o4M2tnZTQ0?=
 =?utf-8?B?TEYvTXc0aGthYXVaYWZuY292aDhzUmdxOWZ3Mnl5N2ZQL0w2VFhTVkhPUXhJ?=
 =?utf-8?B?S2hEWjlGeldUTi9HTHhIemRTcURmcmhqTHlSaytyMzdNdnExNkJnTDl5TnRs?=
 =?utf-8?B?R1FsZEdwNkdyZjVXb1FMRWJCL3FLckRnUHNUSTR1SytNWFQrZ1Iva0ZCY1N4?=
 =?utf-8?B?UUJlOFUyT1llZWhrTFpDN2lqMmsxNytPQVl0enJmcmNxWHNHNk51QXU0QVBD?=
 =?utf-8?B?SWVrQzh2ZTNwbVNENURMcnZpY0R0Z2hKdWQ1dHpYTWd1ZVgrQTNlZElvQm92?=
 =?utf-8?B?VWIxaUZTSHBCQnJVTDJMTzdZalRJbTBTUnhzcXA1TFp3bHQxazluTFBFeUR3?=
 =?utf-8?B?bHRiQlpoZGpNRDlwWjJpNUNhQndxWkN4bDZ3WG52ZkZseTd5RFJUa05ZVXpz?=
 =?utf-8?B?YlcvdUw5RlVIOGliaUdBUmxCVytaNVdGUmtMWFNKWTMvNkJyamRsQVNzZlZI?=
 =?utf-8?B?dEJWQ1FZUHJzd29XRktkK3JoTEpxcmMwWkh3b081TEdXMDNzVUhKdE9hTDBH?=
 =?utf-8?B?RTBSN0o5akZzVy82cm1UYkpKZExJajRGSTdRZjNWNjR4VDVncHZ2c0FFcmZS?=
 =?utf-8?Q?N6eDgYG/uoEeOcvF3vhCy7zxrY1IHMJCUuH/Aac?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a107de-dbc0-4ad8-45e1-08d8f326f700
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 02:53:15.3760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QrfLK0ikdQSbxyxVhb7RhhhUYwUsX0bOHCQUsBp0ftwItlSA25b/i4bFb70+V3n2LV9H9vb3RECWbvVeYiCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4418
Subject: Re: [lttng-dev] [BUG lttng-modules] lttng-module compile failed
 with the v5.12 kernel
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
From: "Xu, Yanfei via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Xu, Yanfei" <yanfei.xu@windriver.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



On 3/29/21 9:54 PM, Michael Jeanson via lttng-dev wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 2021-03-29 02 h 34, Xu, Yanfei via lttng-dev wrote:
>> Hi experts,
>>
>> I found a file named lttng-statedump-impl.c in lttng-module is always
>> compiled failed. The file use some functions which were export from
>> kernel. But the v5.12 kernel unexport them by 'commit bc359d03c7ec
>> ("block: add a disk_uevent helper")'.
>>
>> The function are disk_part_iter_init()\disk_part_iter_next()
>> \disk_part_iter_exit()
>>
>> Thanks,
>> Yanfei
> 
> Hi,
> 
> Can you have a look at this patch, it needs more testing :
> 
> https://review.lttng.org/c/lttng-modules/+/5050

Thanks, I have applied it to my project and it can perfectly solve the 
compile failure. Just a minor typo 'arounf' in src/wrapper/genhd.c

Regards,
Yanfei

> 
> Thanks,
> 
> Michael
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
