Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC31C27C40
	for <lttng-dev@archiver.kernel.org>; Wed, 23 Aug 2023 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692820987;
	bh=PLQlu8vIVO9xFn//IB7otpkkdBfs/Ht3FqMFnOvGe9M=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Inkawyki1P31Bw6iwqEgY52nTT6hZxJeM9v+howN8LYzWc7DAqeunuN+2vnrASAjv
	 VLS7HT5Ieu0motvDqraLzINlQbzERhrlNu54bUgFJq19FTG1JB3tymuRlDcDwmAbIw
	 51fbpFdXucaKEHE4f5mmXr5UxgBSy4FrdM9XhiQ4E31LjExrL6PoHnq04Fg6D5Qor+
	 RruuNtmvCztDh6qBFxUiXBfS/d4FGhRQrWQPB/5KemmQAgiGlpFBsvNHsZV0NX2Lsb
	 dyo2PCvP2YoVfw1B3l9Ev3ix2llGXUqHRwgw1SoXOt/58fuGLehrHpUKp4Q6EDaIWV
	 VHON+OsGciqhg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RWHFk5dWmz2QBV;
	Wed, 23 Aug 2023 16:03:06 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7052::621])
 by lists.lttng.org (Postfix) with ESMTPS id 4RWHFh6T9Jz2QBT
 for <lttng-dev@lists.lttng.org>; Wed, 23 Aug 2023 16:03:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9ivPTWuV+g9DW2M8xDn7yDGpAEVjiBCtzktOGS3B/E2o7o/p+OWzUhJ+Hi1PzNCZ339QppcAAiXzfUTTYxBkrsixS+KI2RXVw1XDxV9PBkGXCkYpHjngk+RjBOLZ1CtiNLeBf2xPDL10RPPByOWxyBxX/wYBTOIcb2uz2+cjYqz/0AH/ZiZJpuQ87IfTdnbNe0VnOwFMI5fN0wTEPqRJE/KZW/QvYZye9zDwWEWw0t5kiqH86KJo+HgrViFOLIJAd96p3YuIgrSoIM81FOPrzgvjVwKkYP0pUey6fbXOZKLWyHi0+nAFmMulOFrM/Yn+V1CdsQ0QjUqXEaHWokMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a//mX8mT4bh7QmDXbR5HvnAq/++LsS6fUpp8z8blHg8=;
 b=Mg9p6e8PJ06wio96ZRArITZwXY3c2kzApLxa3ItGH5/kS68UGZ99W6T03fREyclYk4EKcki1d44cjh9NE2zwX40MobxZBCYUo7jeJSEWGFB4ADD3SvMwYtIGcF+A6Mf8hnWVUFCqlTnIKZNtzWHaS3WwoZgXZKNKLT4MV0kN715/LLE6f3Fc7NPEOCfNACLTzH7Xk/Yk6g5qASdXum70pEGME2n2p2FRP4AdKHtbx8a+71ic4ucE0RDMkOUHaflVacfui/a0oy1K0KBIRROdze1D/ZwbNJ3AtIQtur5v5X1GLvgydNaWzdK/bz2iJMZuWKOXdNbrnEL2d3acMRm1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e3::15)
 by YT2PR01MB5345.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 20:03:03 +0000
Received: from YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d63:1c62:5a0:6e31]) by YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3d63:1c62:5a0:6e31%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 20:03:02 +0000
Message-ID: <6e91125c-fe9a-0a89-9912-a34cfa62d024@efficios.com>
Date: Wed, 23 Aug 2023 16:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Milian Wolff <milian.wolff@kdab.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Bala Gundeboina <Bala.Gundeboina@kpit.com>
References: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
 <2693785.mvXUDI8C0e@agathemoarbauer>
In-Reply-To: <2693785.mvXUDI8C0e@agathemoarbauer>
X-ClientProxiedBy: YQBPR0101CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::12) To YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9879:EE_|YT2PR01MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8903b4-9d0a-47b3-a2c5-08dba413f523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E36bhDiiLzCAPfaNZ1w65d1QMZZzwtjBNh3KGIimCWxkimZM3L6+HXaeQ+9jzcg7D+a1y7bNEWVU3Bn9FtDXNgmcU6TdEiodDyDicAVHix1ierRldOROpEZGow+rGmQrictH17zMUHmN/3aegbH5WGzeDJd/A2/EZqzXzIMjVVEuLEXTPOku54rmxdtUF5L9AcbVfoxyqBBY1j4vxMHq5KvrxMkAwBhHoUAdKtCvD9pdTmTy4+g1ljdSRwtZjMl4ew7iaTb9HNPIHOhqwivblDfzL3/OoXL8tiq8ZQIWmxdFRknBkJ4YZtCIydPpn5LvfTMbs2JaNhhWNb0JX9HcAizWTU5c1A218uQZ1ZoS6GQvuvPfCHVPNlSkoqKiruIbVlPNFwA8wQvrXCUHvIwweHiZT4kf8gylj/QqhrrK/KqqQ4S5nUm2EZ0VjWjJGBEL57sSFIMRb7+K46sOSlv6kc8bGx+Veo6puZ32VT0R7ejJFcw6Zbztm21hRUC/+yt6b3cMROZRPhWUVNdC2mV646eVLm5Aa+0jicui+KVwlAYLsfWGXfISKR9j4kdS85Itr2nYOBfDkREvgRs63jyQ8XJRN9C/9TAW1y/RsjMvT+tyFTcFxWKgwPJCX34QoCtWbZwnYG6LysRfIx2tivtHjVGaBPhg+ibRdA0DPOI04v/DNLdqSd6EyBqXRSXQvtVO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39830400003)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(53546011)(8936002)(8676002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(5660300002)(966005)(478600001)(31686004)(83380400001)(66574015)(36756003)(31696002)(86362001)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajdQRXRUN2JzcXAwUFA0akFHeUtsMWNlOUxERHlpc1RNbnY1eExyNEY1RHIr?=
 =?utf-8?B?WmRVdWk5cHNuMUtmQ1ZYS3hLMGo3M2x1ZU8xWUNzY05kS3ZvMVVMbG8zWmp5?=
 =?utf-8?B?ckR3ekRrRkZGcSs4UkhScmhhR3F3ZHJ6eThhMU1rSXR5M3FvWU9NNnFiOWxV?=
 =?utf-8?B?SDlhbkczWVlDS0UzZHpCNlpBKzhPN1VLRHR3eFNQTTRRQThGdGhGSStCYlRZ?=
 =?utf-8?B?eFJaa0hNbHB3eVY2Uk04VTUrU09adU1meUpVbHRtWEg3K0R6MDdLRWlib3B0?=
 =?utf-8?B?TDByL0xnWUxuY3ZGRUtHbloxM1dSM2ZOd0orTmRVOS9RaU9Mem5CVlFwb1pL?=
 =?utf-8?B?V3NPandqODBsTVJzRlhVSk9mTmx0a3k0eFYxcy80akR1c2NQcEJqUkpqc2Qw?=
 =?utf-8?B?VmRsaEl4UUY3MXlJR3pGb0hlYnZ1MG4xRVdOTHppbWdKSGdLZDlSRG9aQ3o4?=
 =?utf-8?B?WVU4NnJMWmZhZHkrb2w2ZURvckI1bnlnek83WkFnRDY0VWFHci96R1lmQjg5?=
 =?utf-8?B?c3dzRVUrTWFoZkFPZTI2dXpIQ3JJMzJIRXllQ2ZteDltSlFHcHVMMVhrdENP?=
 =?utf-8?B?eFA4MURFR01HV3NmamxBRkExb2hUWjlBbDZyZnFrc0JlSFZMZE5xS2kvZERO?=
 =?utf-8?B?SGNzc0NCNmdjbkluUlQ3ekFtMlFHTXZxUEZrck1iclBhYTQ2MjByanlRSm9k?=
 =?utf-8?B?N0o0Sm1hM0R6Q1pycW42NTU0ZXJHa2Ewak5oT0xBRVBmYjZ3Uml2bW9YblNN?=
 =?utf-8?B?SUsvb1k5VGExNGZSdUl6K3NISWNDc3IyOWh3MGdUSFVGOVVKSDcwSzJ5YkRI?=
 =?utf-8?B?K2pvVzlUR1NyTTlzcC9qdytrdTdKUGlFcllZbkRyNXpmeVFYVDgxdkZ1YktW?=
 =?utf-8?B?VDBuZkMwdE1FeVpFaVl5REw2d2FlWEJrbWx4YlZFVzltK080MDJpQk1hUlBI?=
 =?utf-8?B?TXBGUSs3QUdrK3lwUEFEODdGZjZaODlHOHV5ZkRQVm1nZ2xvTDFIamNnTVBE?=
 =?utf-8?B?YnFUTjhldFlFL2taS0NRcGpYUTNhQWtjM043UVV4bVA1WmI4NTJvZUNsUDZo?=
 =?utf-8?B?TEMvNGEyWk5UWVBIUWJRbU9WTHFITXlDMDEyOFJsaVJEVjNpanRkaGRacTZt?=
 =?utf-8?B?YkhaN29aR0xWSzJ0Q25WamtEeVBBaWFtUWRJaU9leXFjdEtYenJEdHJMTmk5?=
 =?utf-8?B?Y0lYNkl5VXhHb3d6bmluc2RweHhFWUtuemZHMVllQTJSQklxUHJsS3E3Ymp6?=
 =?utf-8?B?Nkt3K05lR0gxUUhuVlRSOHFlQm16M0EwOWNLbVhBY2U2a1BTcXJQbUNZOUUr?=
 =?utf-8?B?WFAzWHZtYXpKUGtFY3grRjlicFlyMi9nWGFIb1NhY0ZQOEJpUXYza3dJbnF3?=
 =?utf-8?B?MEc2anlneHdrRUxCSVMzZEZsd1Uzbm9kOW1NN0V5R1pSWGZ2TWI3UzNMcXph?=
 =?utf-8?B?WGpqcFFiUVJrWERPc0xPWm5oKzVzMlI0clZjUkFjVUdsZ2R2emNaeDhDcHlH?=
 =?utf-8?B?czJ2b29iYzd2QWc2SC9IQzRpOGxxR2ZZS2hRRE95ckJrV0l5aFpnbTJ1RE00?=
 =?utf-8?B?emNiOUYwVWdjMmhBYnVOT1NLSXVKWDJiaHpmS2hqZWd2bWppYnkzem1sMFp3?=
 =?utf-8?B?Qnp1bHdqNWpkK0hPYVFyV1Rya2paR1cwenZGcFRrYSswNSsyZ0NPZFFVV0hP?=
 =?utf-8?B?bEQvVzNUL3ErMHdzTUVpK3dWeDdzN3owSUw5NnhkWllBTFhYVUlocWFiVFZ0?=
 =?utf-8?B?Q1kxeTk3WWVRM2pRZDdxK2o0QjgxM2NYUGkyZVBUZExIL3BIUWxwbDNYcTBt?=
 =?utf-8?B?MUY1VTB4SXRXS2JKLzQrTEJUM1VybE1CVkFlV0ZuRjArUWQ3S294elJyUklP?=
 =?utf-8?B?TVhXNFoyZXM4SVlOWm01Z2NkdW9YSkp0aWxhSTBFZkxrWGR0aHVFbGhEU3Vp?=
 =?utf-8?B?MXNPeW5USDRjMXdMMm1XR0RQZEpjeG81RWlHMUptMkxFcnRmbm5sYUdTeWhO?=
 =?utf-8?B?L3pabnRxUTNGMGQ2ak1FVGFZRktEK0tZSmFjZ001QUU4Z2VHczBjTGlhUllT?=
 =?utf-8?B?TlhyYXZyL040M0RTekNMaTJLSmkyR2FGdFdJR0NWOGNNdmdwc1ZGdjZUdDVk?=
 =?utf-8?B?Q2psZUJPTFVqMGFqVUF5emlRQTRBd3ZMVnI5U0dUcUVqbmdOQU43Y0oxWmFZ?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8903b4-9d0a-47b3-a2c5-08dba413f523
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9879.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 20:03:02.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rP7R952wYDdyJSCi0JhsAPG6rsxk0qduxrCodEZMcsngtbP65FE8UoQzW8eZwBSPZ+MHCSpFDRjyExshWss8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5345
Subject: Re: [lttng-dev] Discarded events
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
From: Erica Bugden via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Erica Bugden <ebugden@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Bala,

If you'd like more information about which event types (tracepoints) are 
practical for investigating which areas, the `ltting-utils` [1] project 
could be useful! The repository contains scripts that record LTTng 
traces. Each script is focused on a different investigation area (e.g. 
network, interrupts, disk, etc).

You could use the scripts themselves and/or read the `*.profile` files 
[2] to see the event types enabled by the different profiles. For 
example, in the disk analysis profile (disk.profile), the following 
event types are enabled:

     - block_rq_complete
     - block_rq_insert
     - block_rq_issue
     - block_bio_frontmerge

As Millian suggested, it is often best to only trace the event types you 
need for the type of issue you are investigating since this increases 
the accuracy of the data collected (less tracing overhead, fewer dropped 
events) and also makes the trace easier to understand (less data volume, 
less data noise).

Best,

Erica

----

LINKS

[1] lttng-utils: https://github.com/tahini/lttng-utils/tree/master
[2] Tracing Profiles: 
https://github.com/tahini/lttng-utils/tree/master/lttngutils/profiles

On 2023-08-15 01:24, Milian Wolff via lttng-dev wrote:
> On Sonntag, 13. August 2023 16:58:17 CEST Bala Gundeboina via lttng-dev wrote:
>> Hi,
>>
>> I am Using LTTng in my project , I am recording a kernel session for long
>> duration (eg more than 15minutes) I am enabling all the events for
>> recording but some events discarding after stopping the session, if i run
>> more than 5 minutes only some events are discarding. I have tried to change
>> in the .ltttngrc file also to increase buffer-size.
> 
> While not directly related to your question, I strongly encourage you to
> review the list of events and only enable those that are actually required for
> the specific issue you are investigating. Some kernel events are _extremely_
> high frequency but have often no practical use for many (at least in my
> experience and for my own purposes). Examples for the latter are esp. the
> kmalloc tracepoints.
> 
>> lttng destroy
>> Destroying session `my-kernel-session`...
>> Session `my-kernel-session` destroyed
>> Warning: 94424667 events were discarded, please refer to the documentation
>> on channel configuration
>>
>> actually when i am running below command i am getting below warning i am
>> thinking this is the issue because sometimes this warning is not coming
>> that i didn't seen discarded events.  how to overcome this problem can you
>> provide some detailed lttng-sessiond --daemonize
>> Warning: Failed to produce a random seed using getrandom(), falling back to
>> pseudo-random device seed generation which will block until its pool is
>> initialized: Failed to get true random data using getre
>>
>> Thanks & Regards
>> Bala Gundeboina
>> This message contains information that may be privileged or confidential and
>> is the property of the KPIT Technologies Ltd. It is intended only for the
>> person to whom it is addressed. If you are not the intended recipient, you
>> are not authorized to read, print, retain copy, disseminate, distribute, or
>> use this message or any part thereof. If you receive this message in error,
>> please notify the sender immediately and delete all copies of this message.
>> KPIT Technologies Ltd. does not accept any liability for virus infected
>> mails.
> 
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
