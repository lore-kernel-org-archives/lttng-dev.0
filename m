Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB646C4167B
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Nov 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1701184824;
	bh=9pAn2stYPLBWAEPW+HwxNgG7JBGgpjzIxxaDkxhVrBA=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JQtGiq/yeWWyaVE6TQ6YNLClnA7zJfnwqYIbTJD9dNtRlVxf6KDHMXegiPAnkuZPP
	 LwpOODnlE1+f2OB/oFCSQz1iDLuhS1ChwKdNIZcrzIZIR7d2yov67zV/OMxfNLW0/t
	 0T6mvqsrUygpHjEOAtlq7BPuU1n/WRCRKFeqkctIiJOxpDEeeyBpTyVPCYZpFRhma1
	 zcqmhC63u9nKCRRanlsKv8GXJCiCUW6fJYDlNpKMudfoWjO+6cc7DdCeM5f7zpUe0i
	 oYToMdWU00xz0tH4xkS/ej1z0THX/DAAO4FpdUFP3B7mVMSF34XCW1u3q67/3bQpxf
	 Wieb31GzpquTQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SfmNl3wBDzN0Y;
	Tue, 28 Nov 2023 10:20:23 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::600])
 by lists.lttng.org (Postfix) with ESMTPS id 4SfmNj5MCnzMvQ
 for <lttng-dev@lists.lttng.org>; Tue, 28 Nov 2023 10:20:21 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfkYTnj6fxWvY6PUIWMe3Qi7OKTSOUzRctNKjqH+AJfYp9ff2stIyFLyjHV2MaR+aDSQylpkTXeLqWMl/2Ro3dnr6q9dDd+rhrcEAjZBTD7TWoyIkuyBQzp5fbElrRfsIhrxosNq+4B+AlTLSbW5xobhmRyWEdTp+aeFGdoy9dJdKjjs6edF9+EphEXAFiXJm6nkILb+m66xLvLiU0OqvNTtOqXuPBY+noXpIL0LKevNyAzLCnhZBrrkX9Vv5FoSD+7WP1B+B5AQg9daBwyycDaqiaVrLx2q4c7DSts1Y8zmCh4ZRFhf/sKOqocqIeZckcPAhSHUCJnG1pyJ8RYOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBY5SPXQ17o35FbTp7rhz6u+55JrTsW3S4jVqhyg1CU=;
 b=TQAWAFXYYwEld6TI1fz7Xr6kACh9RZJiSGrwc/6Dvny9w2gx/7d7ejbT7LaK+wOb65eHdDrfVhbyzVUKSFw3KDnIL+2gIu1VTCLpxgI1K7CtmTulkK/VKdmVdEfocGGLYvesl20fP6iYis5cBNBSajDy4w7DU1nWnSwZeFf4glAKtG0f49BJM59obsGs4s0zagVb/k2g3KQzbgBwQ2QUxD++yW4Es9k9hddpg8ZdyZtxBVq/eQkDDjXx/+IRWNVxQDLdq+koCBoBZaqKu2Ury5Xpz3aTAKz1sp19TI3ROAwb2KPswvY55sM0tu7TdQZSmHfSk6ZraFaOq6BcntFzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQBPR0101MB9198.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:20:18 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c37c:acd3:88f4:feab]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c37c:acd3:88f4:feab%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:20:18 +0000
Message-ID: <c1d6a91f-f30f-4494-8b31-91deb2aa5ca7@efficios.com>
Date: Tue, 28 Nov 2023 10:20:17 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: Yonghong Yan <yanyh15@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
References: <CACJEY877LAEbOY92+vFy2AdYdctw-Z7dVozTm_LF-u-Fzy4c0w@mail.gmail.com>
In-Reply-To: <CACJEY877LAEbOY92+vFy2AdYdctw-Z7dVozTm_LF-u-Fzy4c0w@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::23) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQBPR0101MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c9616c-478e-4697-7e91-08dbf0258786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esUnN0+QjmhKzgygYKUX+AlxAYK24bM/uquwXijQeS2ptbca7/f07gtjTy2COqfcs2xef9q8roSsYt23d5DL/5HtTm5ZKBN8PDjHy6SRljuLHULdtza6H4jbdb7z9GqeV44I9cL4YtqrtBJkYbD8liApaJtwPsboMLECHW3MZMIoUupC5aX0VaxuReqOrNSkzJw5WsFXMZAnU1Fut0IQuT+cdkJtchNxB5GuWhafCiUN+ftulfk0POQHavU64bqAWcjzFbFacE/cvzkyfj0SHtmbWXztct5sMMShJ21jCwEpHc7Z4nHYdSJdt8UDBhOrnrdPVwtcFbs4zmIdHUcFdKmfSEAeRHZDaVd/2kv32oW59qx1Ok7L1ORj+u4/zNNwKtUdD+QohVWy5e1fh/nQR1qJjd6uyUNZtxEpwK8ET907RbBvbYBdeik/rrPDbk44Rbv7QW54BrTIyL3A8KVmVjKGZpG0hYOHzUwcUHzT/1FGpOUPlc4P51EKzzqoMIiHtoE2lVQqcycWEIt9i5FXGvadTMf6Nwb4xGQOnVKaIS6Vp94ExIuN78WgbZjoFnHLnPOZ1S1p3rNRS5aWHT4NA/wZX8b68fatK7vjfAp/Gjz3BJaYqX+AlmWvFUsl4pHreQNfUFaD1iHwY2je8/jwQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39830400003)(376002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(478600001)(26005)(53546011)(2616005)(6506007)(6512007)(38100700002)(41300700001)(86362001)(31696002)(36756003)(5660300002)(4001150100001)(2906002)(83380400001)(110136005)(6486002)(66476007)(966005)(66556008)(66946007)(316002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3pzc2ZBMzVpUE4xMUxzeS9ob1VFOGpEcDB4SXQ2K1I4WitBcmx0eER0YVow?=
 =?utf-8?B?ZnpUdDZFbjZCTUprTzNqZE1mbGZkUDd4ZWdmem5NUk5hZ0VqM2Fmc3gxYXE0?=
 =?utf-8?B?K0RLVXR5Vzcra0hpN3pEMXZRTFNMQ05YSGxqRUN0NjA1a0V2Z3JaWDhxTjNC?=
 =?utf-8?B?ZVFMWVh1cEdZYTBHSDY0blVrckxuZjJFdWpVSGNRaHgvNGJPZkF1b2lxdmln?=
 =?utf-8?B?UlBGbmlhWndHWlNaVit3bzJQQXpxcTBzUnQ0U1dqYlQrU1ZwdFJaQ3QzU3Zl?=
 =?utf-8?B?RWdKV3kyKzFKUHJsRmNIU2lCdkR4ampiL0Era3RNc205eVVacExLQTA4QUpM?=
 =?utf-8?B?K1RFekdISkZ5empwTGlQajhjTXRTSkR0Q3J1dzNWY29aem5HNGNBQmxhSllI?=
 =?utf-8?B?MHFYSnVOTTdpV09qY1Jub2Vsa2FwSkJCSmZWdE9zc0ZKTWQrMGRtaHQyc1pJ?=
 =?utf-8?B?c2lreHZpYkUxSkZYMkQ3eUx2bFF6VFIva2xzVUthWkptVXdCWTh5LzhRbTRv?=
 =?utf-8?B?Z3FFQVRZSm5SZ0FNSzhkWjRjRzQ2Wkt6NGxHMXVnYmxYTkVBVEt0MTRvUnNn?=
 =?utf-8?B?SnhxNjllNHlveVR1YzdwMzlHVXRkVzdEVGFRSWhzK2QxR1R0UG95UldPR2JB?=
 =?utf-8?B?T213T0s0ODNINVdzWHlGa25lME1VTDM1dzdKQVgwL2Erd2VSK0licEdhT1lC?=
 =?utf-8?B?K1BwZHBrNWlvbFRYVFg4U0dHbE50OE9hM1FheDJPcEdUVzkxRi9Pa056N2FQ?=
 =?utf-8?B?ZFdtY3dyOVNCL2drcklvWW42bFo0T0VWOU1QVjVNemlCR0VLb3hjODZiRW54?=
 =?utf-8?B?ZzFlN25keURtaXdKWkl2U2wyYTNvRW9JSVJPc1Fkb05nL3QraW5kV2hQL1hn?=
 =?utf-8?B?dGdpUHQxa0FwNzNCUHVXNGVkMXpJWlVEVlNNVFp5VXZMU0ZRRVh2Nm10eDF6?=
 =?utf-8?B?MWgvd252OHJRVmZySGtNRENqYUJSeG1jenNYTnJnV3JTVzgvTGhyZnkrU29l?=
 =?utf-8?B?NWJWdFg3MFZjY2FpMDg5Vy9KQnREVFFlV0RXWFBaSmZnR2NLeVNxVmRYMkYy?=
 =?utf-8?B?WXcyT2U3djNTaFZjNFRKL0NRaWNGbzhyM0F3YXlxZE10OGZxcnZUQ1lPWlht?=
 =?utf-8?B?NEovK1laeVlQWUxiRFFhc2NJYnlYYmMyTnBVZ1BGZFJZOFhGNmFYOHpOeGho?=
 =?utf-8?B?SmZmLzNoMVdhSFZjVlg5QU9TUWtBOFNnL1JGSWxqTWJNQ3Z1VWVQZDJHQ0NH?=
 =?utf-8?B?eDIwdTFPazZ0WEo2VjBObHlnK29KRmh4d0VrL1VqQWh3eUdnWHJmTGhlMEZE?=
 =?utf-8?B?Z0k5MXVXdUFybkliN1A4M3l3Q3U0alQ1M0JVQitZY3pzVWNJUm1zc0loZUgx?=
 =?utf-8?B?UUk5eS9acWo0VUlQUHNIMWVrSGNsb3BSTjZQMWRyK1k4R1B5bGl0OW5ZUUpI?=
 =?utf-8?B?QWkvSnVUd2h0NktVMzBCbWVnMEc4N0xMTi93d3hNZXhIU3ZhWVBCenVNREY5?=
 =?utf-8?B?ZUJ0dEw1SkM1b0dicjNrL1JTajJLZW9waGlKYkd0ZHk4aFJyU0FEMWZjVjBk?=
 =?utf-8?B?VUkxakJ0dlJtaW83REhMTEZGMWNTOStoWC9yd3YvV0dBNU9HdWszN3VrTnht?=
 =?utf-8?B?cmVGYjF1dzBuWU9Sam1HazZ5ajAxMytyQ0RzSzhRRzFrWktBLzc0cFR1RHRk?=
 =?utf-8?B?NUZqN0dRVXllS0pnT1hnWVRPSHVVYytXYzlBaGI0eVoxZDVGQnV1Nngyb01a?=
 =?utf-8?B?eThPaitONDFQY2hURG11V0FGWkFpZkhHM09zUmNSeWlVaXl6MFhydWYxN0J0?=
 =?utf-8?B?eUluSldBNzhQeE9KcjQzT29DRUdtUndPZUdwNUUwQkFHazVOTUpLRURtMnFv?=
 =?utf-8?B?bFQ1TktONmlQK0t6RjM3bXRGR3dPUHNqeVloUlgrQ2VqS1hleWc1Z0ZsNFI1?=
 =?utf-8?B?TG0wY2JuZ2JVUGFqOTIrSmFFMFQ5aTVJUm9tOW9pVCtTNS9EUm1JSEd1ZDZ2?=
 =?utf-8?B?VVMvdys4R2tCM2c2QXRLN3dFVmR3cUpteTlNOHg1VEN0SWY2NXB2bmpBZmJY?=
 =?utf-8?B?SHI2aHpEaUdNb1M4dGRuTUw4TXNGb3pBSnQxMXBBTlBmVGZrR1VPWmZuQmVF?=
 =?utf-8?B?ZHp0cEVRU0U0SE15WXBET0F6NXNVT1RjbmZSekdsSittMml0OFl5MHQyQ3lH?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c9616c-478e-4697-7e91-08dbf0258786
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:20:18.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0LriBWrdh4OOzeSqS0dhQgFsyFuX+k+aNy+wzy+my2oN+zkfv0NywC1aM21wS/xzdZlIDuVmGfhOgn3eodhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9198
Subject: Re: [lttng-dev] Any particular reason that the
 LTTNG_UST_TRACEPOINT_EVENT args and fields are limited to max 10?
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Yonghong,

My understanding is that the limit of 10 trac epoint arguments was 
initially chosen because it matched with the argumente limit in SDT 
probe points and there is optional integration between LTTng trace 
points and SDT. More recent versions of SDT, as of 1.7+, support up to 
12 arguments for probe points.

Beyond that, there may be standards/compiler-specific limits for the 
number of parameters to macros and/or function calls, but I don't think 
we're close to hitting any of those.

Note that the LTTNG_UST_TRACEPOINT_FIELDS macro doesn't share the same 
10 field limit.

Therefore, one work-around that is possible to to pack the values into a 
custom structure to reduce the number of arguments that need to be set 
in the lTTNG_UST_TRACEPOINT_ARGS macro.

eg.

```
LTTNG_UST_TRACEPOINT_EVENT(
    tp,
    many,
    LTTNG_UST_TP_ARGS(
       const struct Sample*, mystruct
    ),
    LTTNG_UST_TP_FIELDS(
       lttng_ust_field_integer(int, a, mystruct->a)
       lttng_ust_field_integer(int, b, mystruct->b)
       lttng_ust_field_integer(int, c, mystruct->c)
       lttng_ust_field_integer(int, e, mystruct->d)
       lttng_ust_field_integer(int, f, mystruct->e)
       lttng_ust_field_float(double, g, mystruct->g)
       lttng_ust_field_float(double, h, mystruct->h)
       lttng_ust_field_float(double, i, mystruct->i)
       lttng_ust_field_float(double, j, mystruct->j)
       lttng_ust_field_float(double, k, mystruct->k)
       lttng_ust_field_string(string_field, mystruct->thing)
       lttng_ust_field_string(string_field2, mystruct->thing2)
    )
)

```

Hope this helps!

thanks,
kienan

On 2023-11-27 22:26, Yonghong Yan via lttng-dev wrote:
> I have a situation where I need to record more than 10 fields. If you 
> can extend it to support more, but not introduce overhead of handling 
> such rare cases, that will be great.
> 
> Thanks
> Yonghong
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
