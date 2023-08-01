Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD797C00528
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Aug 2023 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1690917013;
	bh=kDJKnOyaAazJb0vRJU+erTQwffaTjZJvghtzQF/g2ho=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sIV90hXuJja0Q3NauCtm6TnheTPREh7DYN2SIuEm2OT9RkK/Ox2/FRWGxG1jYTMqW
	 iUHeIz3RmGAPiLlNbGF1h5qq4BGvGYyTk+LpCmfo1tJ2Fz2FszB4PV6A6vhA4myE8E
	 83DWOqwy18z8J8tdfvaHhcztwS9nRBRa7tkWtkzM97IQSv8vXwaPgCb+f0HVjylEG5
	 ThgdcCllmT6wVNCHgchqghllnNWwoVGT1bOH7Q/vBLnOMPXW16VynYREua7+PTlGR9
	 580SQNBkL4tRMYIPh5xNc4dSNZvnyl2mjm8TW7IvvLiQc4M4SeoFIjMMaDDS6zSw5F
	 FS3UP9nyyp7Uw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RFl6r3D8pz2Gnd;
	Tue,  1 Aug 2023 15:10:12 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7052::625])
 by lists.lttng.org (Postfix) with ESMTPS id 4RFl6n0884z2GXv
 for <lttng-dev@lists.lttng.org>; Tue,  1 Aug 2023 15:10:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1cjv3RPHQahu0m6RGBBUHawZ7YLItnw7yC6sQ3+pARs7eaBakOy1z58QLD/co5pTTGw9hi5gDcJbVC6X9MQacWpUsIykC+qouJy9Ipzkz0JUC+dqLl7OuG5fEWYrZUBXv16B9YxXD8PVC7cWqTIuGkhzz2sMyAPO56ZytK2OTvKHhXmFaXjxY3zp06D1WdmmNDe90b056PIVW3DhVvMHqzXX2Dt9pojYYwcdxRvXHjgihQQ/L5DkkgL25Pgj28fNZZfgwL4x6Y4n8+suZCW+WJtnMyE+rPLm6r9fAPjnZnY+AbKFP7kMn+709YKFOoawrIHtExw1c7MSm1jXwosfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCmq8lFt6edh/3w6M/5PAEiMbUAQdqIr2MkEPliM++o=;
 b=Khn2fFs5TF7cvC+3CCN9wHeHsRj0IAhA/YImGWrNGr26zsqTHG7fbkjsujcjVWkXIFUi2kOcuDYYjz6JOWdTlynA9LBEwsQ3yZrgbXPvHCac7zCazmkolOGiE+HJAgcPHXMB3gr2tJ+F0wSzlItq2r0K9W4mT+XSeWPSIuDbXrKbNXzIXYdfEITbnfIXisDKP31fYYBcq/T3Cxl21c1nHTGkbj1OepIA/aTrvIx2yMIgAzEEGetl0LV5eYxo47fl/zeTLrJPr6jeaiEIIHJkvbdsXS2sZpdogOIb94YSiojhV97iq/nCMPOskLARY6D9zR9xbjn1KbjVcgI1eS8dQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8d::21)
 by YT3PR01MB9123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 19:10:07 +0000
Received: from YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e334:f8e0:b2af:f5e]) by YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e334:f8e0:b2af:f5e%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 19:10:06 +0000
Message-ID: <2e581c21-6a85-2c2a-668c-8acdfd67a22d@efficios.com>
Date: Tue, 1 Aug 2023 15:10:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US, fr-CA, en-CA
To: Bala Gundeboina <Bala.Gundeboina@kpit.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <MA0PR01MB6987337231830A85B736F2538505A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA0PR01MB6987337231830A85B736F2538505A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
X-ClientProxiedBy: YQZPR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::26) To YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9804:EE_|YT3PR01MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: adeeb4a2-bdfa-48c3-c418-08db92c2eae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f21huAHUiHioorOg5Hy1kRtj8mHqMxCvsGTwW2ZCFs/dhsd2rxG+TAYJoHt8X5FJo4i0pRL5P/vZ2mey4rUGlTDVUUv5ryURcvfP8//EwK7B8Z4VxAwovWxqWi7aM+E0MciOlDwmkZAqOzHvnWwTfYRk9C+/2PlXRNWvNfk9Y/r2XLotFbrHZm7MzMqBwAjsnJ9wFCtTtMx6oPam6lVeTmyT9ccKjG71mXo70QXu5T6c3SqthUHFJoeh9+VzPFNl9qPmpx/xS9EVBZI6YmbV6PL0cUtfz3nbrdSnJTYTmtEeRdEQIcjSMGYkbDlqfxIR/tflrOWphwJYYNK1Rg/qj9bgK1/X/EKM+LTs3NLAydik15YL1jsTPBMguLb+Qxjnj3wGar5vjE6DNx5BphbpQEouyFcaLOiSOnrYap04l1e2WTeNa85SDhyO/MOGnHj7TZY2LrUUiQtmN74bnTSVCohEY+hfA55oN/aAxMSDYRWJnPfLDs/yQM0bxOMpfdsUlxBvkujvMFPzFhygLNoU+X4+dJ7G75dVyYqaHVK7u0RgnifkqWJXo9ykMrVhviolREyyAat7wsMfrj6JU4fCZ4SN8KLfMPJD8vMWD44Uu2+CoJjzhZ37ywuTYm5Ee249D97bXZ3zwW/GarbBdHn09S2gPOI1pMGkri/hiNrrqn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(346002)(39830400003)(366004)(451199021)(31686004)(66574015)(66476007)(66556008)(66946007)(2616005)(38100700002)(41300700001)(36756003)(86362001)(31696002)(8936002)(8676002)(5660300002)(6486002)(478600001)(6512007)(110136005)(966005)(316002)(83380400001)(26005)(2906002)(53546011)(186003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pBWU9CNjlVWklBb0hsZjZmak53d1dYSVBLbW9nVVBkNVBNNitHMkhrdU80?=
 =?utf-8?B?NjZRa1QzVmM0a1JsMU9HallGczJyZWJKalEwVkd1cjhKV2VldGxwblF2dFM5?=
 =?utf-8?B?YjdrUDRwcTVtTFFTbXE0TkNqNTVzZWhpM2VDYkEyRFF1OFVteFFyV0FQTW1x?=
 =?utf-8?B?T1hmdzNoeEpLZCtYQWdWeWwwQWhQSVh3d2JXbEgzSmlGQVJ4U3F0NDltY3k5?=
 =?utf-8?B?MmlCZDdWT0ZvMGtidEFpZlBzVXR0dmtUVkw5SlRmTWdDbTJObUVwMlpkYUEx?=
 =?utf-8?B?eURiQTRDQ280NnFkT1dMZDZEVGhOTjdQTnIvUWR4OGtMRW1sWkhIR0NSQ00y?=
 =?utf-8?B?SndNZzFTNVJDcCtOUXhuMlU5cTdpaXNLNWpCWnd5RVhHNlZ4T25FNThmakg3?=
 =?utf-8?B?MDZxVUR3cXQzK0wvZHh4R1RDTSttajBZNldhRWJEY2grcS9XUks1R01xbEUy?=
 =?utf-8?B?UWlTRHlxcElPa0t2enJCbHNxemlkZ2YwTDFoN1JrbHplYUhJeUljL1NlMks4?=
 =?utf-8?B?ZjNaQlZGMHpCTDRJakZKZ2laU0U4UG1hN3Z0aDB1czJIaVhpN29NZzJjOC9l?=
 =?utf-8?B?NEoxTXR4MElJZ2xYajl0WGw0cFVzdHFmdE9tamw0a2szNTlqMThHRGxJOUZN?=
 =?utf-8?B?TVBrbDBhVVFjUklWaGxPeTJOY3ZXOHlZWExVeGgxQUJVbnRmeG45ckhPME5Y?=
 =?utf-8?B?Q1F1QXlub0hUTnRqbnhwdEs4dlBadXdORzFzMHpKQ0VSdVgzS3RTN0duSkNX?=
 =?utf-8?B?bmp3ZUZ1OVRsUXUxSzJ1eTFWbzVKd1lJUXI1U3B6Tk9EbC9ScldSMUp2bXBo?=
 =?utf-8?B?L05BaXI2emNBVzVST1haUUM0RStiRjBvV2MrcFF5TG4ySVBCelYyMmZNSVc3?=
 =?utf-8?B?S00zbUxrUVMzU3hUMEpJaytCcWprL0VES3dnZUlQNnZPNU4zZjlsVTBKRHdY?=
 =?utf-8?B?cng0L09SMm1KaTlGSy9jZTBrc2laTUpla2NUamRhejZNekt6UWJheVptVEpN?=
 =?utf-8?B?RFlXN3p6dDBrVm92T1dMcnJuMGZWb0pNMG9HamI1QTlXS0g1WVF0T3hRQmVh?=
 =?utf-8?B?TlpqTG1LTXp1LzAvVmVMdHRlaHg0UVVTcTRDWWhzUTcwY2M2Q0NDSXpETXp4?=
 =?utf-8?B?STNMQWxiU000UmIxOUxETUFGZTcyNDhQRDlsZFA5d2U2UTVZelFndWpBMCt0?=
 =?utf-8?B?VERIcmxrUXNJUklBMXZVNmxwSy9rbWVXMGxLbjVyZi9lMmdEckZxaU9LWUIv?=
 =?utf-8?B?M2piQ3RYV1c0WXBNWHVBcFpmSm9rSzNwMEZiWkd4djFwWWcwOEcxSmszQldh?=
 =?utf-8?B?dWhnclN5M0xXTEkrUHk4MU9vTVlSNDBseXNmSDVIUkd3djMwS2pNRkphaTBM?=
 =?utf-8?B?dzhZRFVUdTdTM0w4U01JUWd3SFFsOWZodlRtZS9ZaVdybkV0SUlIRGF2Yko3?=
 =?utf-8?B?L3ZBQnVvTys2UkRwNlJodWpPbnFxamh2TFN5QXBIMDUvN0I2aEZzV0NOSTF6?=
 =?utf-8?B?d1BabTBud3VrRjlGRC8xNjFrTHlqZ2VCWEFwTU8yZnhHUnc1Q3VqREUraHZz?=
 =?utf-8?B?VVZwYUk0MWJMSGRRSzljR3R1ZGp0dWd5RERmSGhzdWZDL1FCc2FOTFlQWEpk?=
 =?utf-8?B?VnVDYlRkSDV6UjVxNmxEVVAxdTM0cG1vWjRIOUxnaWdCQmE1ZGRsczFhanNZ?=
 =?utf-8?B?aS9DL3E3OXp1VnhFVGF4R29YS1d1M3BWWW9PWmtTaTF5M1FURktFOHIxZ0Ux?=
 =?utf-8?B?ZmVaMmRWaTNPNmE3RHlmSWJaZVdUT3h5TmkvRG1ra0tHQVVISUtqMFhRN1lT?=
 =?utf-8?B?dGdFYzFhTXhLV1d5V3dNbGdZQm9MTkxuYXNhbmJwQW1iTU8yblVnMEZlc1lB?=
 =?utf-8?B?STdKTlZEVXAxdXNzSWlQTHhJSDVjeUk1dmR6WEttR0pBcU00emU1NU9id1Q0?=
 =?utf-8?B?bXQ2M01FTThLRWFVL0I4V0FXUnhUUUx3ZHp1N0RtUkgyYVl6dWJ4czJ6cFpY?=
 =?utf-8?B?R2hJcHlIa1krcUI5dVNDOTNsZzVXZmNNTmFrYXA2NUQyeWN2cmc1OEx4eDhT?=
 =?utf-8?B?S3IvUlV3cWNPWXBSM0F3S1o3bGswZVBJWDZMS080UFlVOHBya1Vrd1YrK0FS?=
 =?utf-8?B?blBUa3hheTZ1Q2VjMmR1eURLQm1ON1NlQzhDcHg0TUk5alJHNWNwK2huWFMv?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adeeb4a2-bdfa-48c3-c418-08db92c2eae3
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9804.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 19:10:06.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRXFhFxtmAqPCLsLh4UaaAUMBOXGU5gjisNmCin0LswlFoJke1W5Fba/ihiGmjgPEQbTNt+VK2Pbh+/cXIu/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9123
Subject: Re: [lttng-dev] profiling areas of LTTng
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgQmFsYSwKCgpPbiAyMDIzLTA3LTMxIDA3OjAxLCBCYWxhIEd1bmRlYm9pbmEgdmlhIGx0dG5n
LWRldiB3cm90ZToKPiBIaSBhbGwsCj4gIMKgIMKgIMKgIMKgIMKgSSBhcmUgd29ya2luZyBpbiBh
IFRpIHByb2plY3QsIEkgYWxyZWFkeSBpbnN0YWxsZWQgTFRUbmcgYW5kIGkgCj4gYW0gYWJsZSB0
byB0cmFjZSB1c2Vyc3BhY2UuSSBoYXZlIGEgZG91YnQgcmVnYXJkaW5nIHByb2ZpbGluZyBhcmVh
cyBvZiAKPiBMVFRuZy4gSW4gdGhlIHByb2plY3Qgd2UgYXJlIHVzaW5nIElTUCBhbmQgUkdCIGdz
dHJlYW1lci4gKmNhbiB3ZSAKPiBwcm9maWxlIGV4YWN0bHkgaG93IG11Y2ggdGltZSB0YWtlbiBi
eSBJU1AgYW5kIFJHQiBnc3RyZWFtZXIgdG8gcHJvY2VzcyAKPiBlYWNoIGZyYW1lcyrCoGJ5IHVz
aW5nIExUVG5nIHVzZXJzcGFjZSB0cmFjaW5nLgoKSWYgdGhlIHdvcmsgYmVpbmcgZG9uZSB0byBw
cm9jZXNzIGVhY2ggZnJhbWUgaXMgYmVpbmcgZG9uZSB2aWEgbGlicmFyeSAKY2FsbHMsIGl0IHdv
dWxkIGJlIHBvc3NpYmxlIHRvIHVzZSBhIGN1c3RvbSB1c2Vyc3BhY2UgdHJhY2luZyBoZWxwZXIg
CndoaWNoIGluc3RydW1lbnRzIHRoZSBuZWNlc3NhcnkgZnVuY3Rpb24gY2FsbHMsIHNpbWlsYXIg
dG8gdGhvc2UgZm91bmQgCltoZXJlXVsxXSB3aGljaCBhcmUgbG9hZGVkIHZpYSBMRF9QUkVMT0FE
LgoKT3RoZXJ3aXNlIHlvdSB3aWxsIG5lZWQgdG8gbW9kaWZ5IGFuZCByZWNvbXBpbGUgeW91ciBh
cHBsaWNhdGlvbiB0byBbYWRkIAp0cmFjZXBvaW50c11bMl0sIG9yIHVzZSBhIHRvb2wgdGhhdCBk
b2VzIGR5bmFtaWMgcHJvZmlsaW5nLgoKPiBpIHdhbnQgdG8ga25vdyBpcyB0aGlzIAo+IHBvc3Np
YmxlIHRvIHByb2ZpbGUgYnkgTFRUbmcsIHdoYXQgYXJlIHRoZSBzdXBwb3J0ZWQgcHJvZmlsaW5n
IGFyZWFzIGFuZCAKPiBwZXJpcGhlcmFscyBvZiBMVFRuZywgU29ycnkgaWYgYW55IGdyYW1tYXRp
Y2FsIG1pc3Rha2VzIG1hZGUuCj4gCgpJdCBpcyBwb3NzaWJsZSB0byBhZGQgc3RhdGljICh1c2Vy
LWRlZmluZWQpIGluc3RydW1lbnRhdGlvbiB0byAKYXBwbGljYXRpb25zIHVzaW5nIFtsaWJsdHRu
Zy11c3RdWzNdIGluIEMvQysrLiBbSGVscGVyc11bNF0gYXJlIGFsc28gCmF2YWlsYWJsZSBmb3Ig
SmF2YSAoSlVML0xvZzRqKSBhbmQgUHl0aG9uIGFwcGxpY2F0aW9ucy4KClRyYWNpbmcgb2YgdGhl
IGxpbnV4IGtlcm5lbCBhbmQgdmFyaW91cyBzeXN0ZW0gaW5mb3JtYXRpb24gaXMgcG9zc2libGUg
CndpdGgga2VybmVsIG1vZHVsZXMgcHJvdmlkZWQgYnkgW2x0dG5nLW1vZHVsZXNdWzVdLgoKWzFd
OiBodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtcHJlYnVpbHQtdXN0LWhlbHBlcnMK
WzJdOiBodHRwczovL2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtYy1hcHBsaWNhdGlvbgpbM106
IGh0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1sdHRuZy11c3QKWzRdOiBodHRwczov
L2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtbHR0bmctdXN0LWFnZW50cwpbNV06IGh0dHBzOi8v
bHR0bmcub3JnL2RvY3MvdjIuMTMvI2RvYy1sdHRuZy1tb2R1bGVzCgp0aGFua3MsCmtpZW5hbgoK
PiBUaGFua3MgJiBSZWdhcmRzCj4gCj4gQmFsYSBHdW5kZWJvaW5hCj4gVGhpcyBtZXNzYWdlIGNv
bnRhaW5zIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFs
IAo+IGFuZCBpcyB0aGUgcHJvcGVydHkgb2YgdGhlIEtQSVQgVGVjaG5vbG9naWVzIEx0ZC4gSXQg
aXMgaW50ZW5kZWQgb25seSAKPiBmb3IgdGhlIHBlcnNvbiB0byB3aG9tIGl0IGlzIGFkZHJlc3Nl
ZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIAo+IHJlY2lwaWVudCwgeW91IGFyZSBub3Qg
YXV0aG9yaXplZCB0byByZWFkLCBwcmludCwgcmV0YWluIGNvcHksIAo+IGRpc3NlbWluYXRlLCBk
aXN0cmlidXRlLCBvciB1c2UgdGhpcyBtZXNzYWdlIG9yIGFueSBwYXJ0IHRoZXJlb2YuIElmIHlv
dSAKPiByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCAKPiBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2Uu
IEtQSVQgVGVjaG5vbG9naWVzIEx0ZC4gZG9lcyBub3QgCj4gYWNjZXB0IGFueSBsaWFiaWxpdHkg
Zm9yIHZpcnVzIGluZmVjdGVkIG1haWxzLgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
