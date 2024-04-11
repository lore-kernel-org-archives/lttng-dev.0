Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0368DC4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Apr 2024 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712857541;
	bh=r9Rad5ovTsttRqCL/LfBg4d9PjJA7VfUCa6KFNXbuLk=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CSIaIbSNaFvfta7pRCjSzI1GMqiKWygaiNF8XpYBTZrpeHy7Pyr1czVoxFs80GhAv
	 JxbgztUX+Fd+BpyozwanTurLUc0jbS/YKBWw6kKdmLB7umbNyV4D4cHsY8E4ZnBCQj
	 D5x3Mnf3E0MMdZaLoaZJ66fsWoB3Q+30aQmE6J5wu4adwsIfOqgX9aUuUIbqdaapzW
	 zAMW6JKthEWVJhzl3CcnyTn5Fz5bR6BZ6S3qj+5oYrfoVZhH/JTkVJROpaBc9pPw1t
	 9XYERARmoAHQTqV1mzQFQTfU/3KIosf1esoQyYEo2kaR5rxtimfOtBN1eHXfjJaNZd
	 r0todGK6H/+sw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VFnD46YPkz2fS6;
	Thu, 11 Apr 2024 13:45:40 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2109.outbound.protection.outlook.com [40.107.115.109])
 by lists.lttng.org (Postfix) with ESMTPS id 4VFnD345xfz2fS4
 for <lttng-dev@lists.lttng.org>; Thu, 11 Apr 2024 13:45:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh3mMohn4YDhE+7BwJXG6XE1O2Prpq8jqQ34e+GfQBtgCfhXVfoMnFsrDTxwhFJN64zFL02YBtBeObaXOgvr7tkyJHgx8q1nsdSqAchGee2/lRyOkNPRIRfQDljQ0rSDmy4F9YYuyfdWu1dUqKSMZ6pqlQxYCF8CI1J9zV/iNKokeWhazh7l/TkFIgfQc84UFm7OkzMogWug/yUHkpNBuRVvIiN70Fl3f3F4Sb8SR2RcpA1TjpUiil1DegW7LJmmxQv3yMeyhw+wxpkzCyesROJs4KJznEiixF55sQVTwzc2N5+plxdaah4k5xzF7rLW5k/Gt7uyXXXV+h81BxS0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAp3cZgdkKnhaXHif3PGvM941UoPbCWuf2hBFelKBTY=;
 b=XrgsXqvmdDCMPbJq8y4vyjgYw+FyXwyn988HVifiwIwCDAHq+aEguDf/fT4JOjtCKMhSPYRnBLld0E/NvMZbNQi73QPU77Y8JEdGjdaHbaIK/EiHaBxCYTaxz30aEkN7NvgFSkw4rntCm09TDYqvp1ANOeUllDWoCWigMxUzp/6o05yFrYLrzhRpkOQ8FWRX70Kgu6O4wV28tEPOsgf+qooIP7ulu/KhsWIwVUqBREE4B7ru6dVCKDpgd4L/Ky/q4k58jZ5gZ9KfEzOGDfiXvclx+M7vDVfyGSRZHtPA5Oh7l9w45GhP5XX/aDSWaHjvqaxPXK4qPkR/H41niGhiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT3PR01MB10672.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:45:37 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a41:c476:7b73:99ec%5]) with mapi id 15.20.7472.025; Thu, 11 Apr 2024
 17:45:37 +0000
Message-ID: <7bacc8ff-c7b8-43ac-89e0-c3036131e1c8@efficios.com>
Date: Thu, 11 Apr 2024 13:45:36 -0400
User-Agent: Mozilla Thunderbird
To: add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org, 
 Software Heritage Archival Moderators <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
References: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
Content-Language: en-US
In-Reply-To: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
X-ClientProxiedBy: YQBPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::32) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT3PR01MB10672:EE_
X-MS-Office365-Filtering-Correlation-Id: 547787cc-f990-4c04-a983-08dc5a4f325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvMAK12pJHwJRXH+MLevc1iJshjR4kSthFRtT8d5MCTNtIZk9X7QIUFaSN62KoCDQPBkZKA5QAF2Mf0tm9qsJedXg0Q/dtZ+F3NwVmYqgZpiWeYZG/bF4qkkuSakv8hxDjRaoEO9GG6mnAl7QcZAILnziunDMI7Ky9pEaItLFLV/jx3u2eJAzo1h13yQAh+aEmQV8hCq/fiQmc9ANguklpfzdPUqBNR1Fh8761QYJI20ZGW3wxhqmdN9LXUM5JRTKekeuFUqsoRyVsOKnu9XFHdtg4v+hLpdy6Kyd8JotfZT9TMBCu3X5iC1Efb9yCQQLE6twYtmy/siW2XYkBsYV9ZnXpRacEGFbig5r79mQyFUqSZYoVWWHIghQpQ0iZNxeUicIaUS1O9Nx2JUiAkTvmUBr+D1ngecIFDwOyRl/EMUeLvn/dMGR+hBcfIfI1gSR3LfMdBMiji5fqRCJohRxvQPzBlcFy8QZ+RCTkJai77Q7fOwBAsAMoqiAQRmvTsJOiAuj4sNqjtu+60P7EMBs3B+FYnOHrukkvi3IBJBWWFwvxXmk5mxMtB82GkqcJXbEUt/LUs+IKNkF+8jXaHeBYH2D4cERQLeWvqi/Fk8eYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdON25JT2U5SjhkSXppbFJWWktoMEFCVlNEN0JXV3JrSWlvVk1JWnoxWGEx?=
 =?utf-8?B?VVgvRmlWMmR2UHdtamxBUGtZNFlJTWVGWmpRcWpuTXlhNU8vWll5RHUvczFQ?=
 =?utf-8?B?bDhlY1hqM3dMS0ZsZFZWUTdtdHRnYkxCa3ZBVFNnTlN0WnRxSXhCUUJ3aGFI?=
 =?utf-8?B?NlJBKytpQXAzNk9hMis1V1htUHIxNWpUTDY2YkRvUzBNVlBEdVh2d1p3S2Zq?=
 =?utf-8?B?MFp2OGRZRUZNandQRkdEMjRIOU9VcUdSZFQ3NzNaU2ZVdm92WWQ0WGptVUtn?=
 =?utf-8?B?TjV6QlZRNFlQOVBPTkFDTFNBM3VqNTdvNFUrOXcybGVhTXJxVngrTDNETmNN?=
 =?utf-8?B?azRsZUR1Rmw2ajVLNEtVVU8rZk1QUWo0bTBsbEgyRG11a0FVeTRZTy9hNXlO?=
 =?utf-8?B?Mms2bVFTR3ZCSGF6djVReDZjZ05aQ3JWZXRwYmJKdWR1Ty9wWXpiYm9RSHhm?=
 =?utf-8?B?OE04Sy90TGV2R0tDZmFGUGhBcDlnZUtYaEFoMDRwSWNCL3dvMXExc2NTOUVK?=
 =?utf-8?B?S3R2RGxTczVsRVNQY1NsRUFhb3pyU2tyZGo4SDZVcGYyTExlWktoZmRZZTFi?=
 =?utf-8?B?bDREMHJGWGs3ZlNnUW9janpuMXF5eHBlSUt6Y3BYOTh0cEFrZzYxTXhxVDl4?=
 =?utf-8?B?bExmQUdUQWxxUVFZS0NBSERPMXRTOGVjT21iT05nbDY2MDdaRWNmTk9sUEhr?=
 =?utf-8?B?OXpyODdrYnBlK1h6SlhoV0hhWjVFcGZIY1RxQlF0UWlqc2NsM0llMHo2K2Rw?=
 =?utf-8?B?VHlZenVxanBQaXFlc01NMEc1bUR1VC9rcTFzN0RCNU16ZUJ3anBla010RXJN?=
 =?utf-8?B?ZHhoMWxuYlFlZ0NPd0U0OGVZMzN6L0IxdWdQby9GbzI5aTFFT0I5WnVZYUZr?=
 =?utf-8?B?YTZzT2t4dVVhaFhHekNGRTEvWHZ0bUgxc09PN2FqN3VzTGJ6Qk8vdGE3aTlK?=
 =?utf-8?B?blE4L1dOUG13cHVJRlF2Y1pzSS9IVDhTdzkyYlhXR1ZZWFZCMUtydW1lMWdp?=
 =?utf-8?B?NzhjSlVCa3ZxNWgrOUFONTdoZUw3YlBxVjVwS3ZubWhmb3lUZFhueU8zVHU5?=
 =?utf-8?B?Wk5yc3dkK0QrTi9KellnQ0FiRzZYQ3JUSUpyeGFpQmhhTkE4VzdiRHl0Y0pk?=
 =?utf-8?B?NWN4T0ZwSC9DTjJCRlRnSTdnaG1mbGFnb1VFYmVIZXR0N2JBeGw5aDNqaDhW?=
 =?utf-8?B?bzg3QWY2Y0ZHVW5DRjVOay9keTI3ZWRZZVRJOThiZEZQQWJGS2R2TnNnUlNY?=
 =?utf-8?B?M3lmaEM1T0tFQ2tYOFh6TlJwK292MG9vUWxZWUhiSEUyRURpeTdYYk45ekxr?=
 =?utf-8?B?UGYrQUZmeE9oNUNTUURNeTJHZno5eFV2MnhEZXF0RDNiU3Q5eFlmbzgzZE8x?=
 =?utf-8?B?SmgvN2FQVjhNVVNvUHpVbkZBcXZqRlYwY05TRHo3U0NqNGt4V2JtWnBrdWtF?=
 =?utf-8?B?V2N4VzdSemV0RWdIci9sbFpacStQa09aSXc2Njlkc0hpb3QwQW1IRnE2RXhJ?=
 =?utf-8?B?WW9TbHZaNmx4QmhmeS9IUlJsd3R1NUJuTjBuV05vYkZiVHFua3RDWUgzY2gx?=
 =?utf-8?B?M1YwSGxNQWRVRjlsRk0zNUlGQzlYemw1SDEvOHFkWkRBVGlETWFJNUk0Yzgr?=
 =?utf-8?B?SDhtUFIvanY1MmhwM1prYXFseC83aDJrNlcwbCtGdW1SVzVIcVNoN0p4SlQ3?=
 =?utf-8?B?MytwT2xyc3ZFaG9kSnM5NnNwczQ2UHNGV3V0M2VmMFVXRXBqZkNSVmV4bkR5?=
 =?utf-8?B?UW5aUGhkZFVnTWNjdEtWMWRhVmo1SXhPd1drZGNEWnZMYU9sYlJRYUxmck5F?=
 =?utf-8?B?dUFUdW5qR3FUUmpXRUc2Z0YxcEREdEMybFJZVWxpUnNORUNaT1hxeEJ0cEpE?=
 =?utf-8?B?N3h0SDVlZFA1Zy9YOVFkQWREeUJqQ3RiclpPaEE4N2c1akJlOWk5dHJ2b2cv?=
 =?utf-8?B?UkF1MGZ4QTBFN0svaGk3VnZsSnRITnVuZTh5ZWFPMEtBdWNqeFpaTTQxOGlY?=
 =?utf-8?B?NUZtSFlOK0JSQTFIMzk3dnZnMUpEakhzUmRPdEhVaWVFc3lrWDc2THkxbU1T?=
 =?utf-8?B?MDl6OHE5WVA4bzYramlpN2pNZG5hTWdRbVRxSGRMd3hJV05ZREFoU0taWXBX?=
 =?utf-8?B?eGh2RlpmNUZRTzlDOWE4RWF0emVWWGxIYUhwZmpVTzVXVDlyWHArMEtIZjBW?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547787cc-f990-4c04-a983-08dc5a4f325a
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:45:37.4821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bIQxVL6DjJefdOV2u7xAupuGeyF1He3Fnj7sU4A+Qmbxw34Ce6zuyea4VFP0IZzDuDRmZHF5A3xjMtNw6QVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10672
Subject: Re: [lttng-dev] Software Heritage archival notification for
 git.liburcu.org
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

On 2024-04-10 22:37, Paul Wise via lttng-dev wrote:
> Hello liburcu developers,
> 
> The mission of Software Heritage is to collect, preserve and share all
> the publicly available source code: https://www.softwareheritage.org
> 
> We have received a request to add the forge hosted at the URL below
> to the list of software origins that are archived, and it is our
> understanding that you are or know the contact person for this forge.
> 
> https://git.liburcu.org/
> 
> In order to archive the forge contents, we will have to periodically
> pull the public repositories it contains and clone them into the
> Software Heritage archive. FAQs for our processes are available:
> 
> https://docs.softwareheritage.org/user/faq/#add-forge-now
> https://www.softwareheritage.org/faq/
> 
> Please let us know if there are any issues to consider before
> we launch the archival of the public repositories hosted on your
> infrastructure. Please use "Reply all" to ensure our system will
> process your answer properly.
> 
> In the absence of an answer to this message, we will start to archive
> your forge in the coming weeks. Only the publicly accessible
> repositories will be archived.
> 
> Thank you in advance for your help.
> 
> Kind regards,
> The Software Heritage team
> 

Hi,

I see no issues with this, thanks for the heads-up.

Michael
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
