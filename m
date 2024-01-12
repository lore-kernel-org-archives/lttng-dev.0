Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D7C4706C
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jan 2024 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705071724;
	bh=877R43c6zF95xgiyHHOjXNMHTFXCR711rRGxlYD/HOY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=tXU2tqq9lCRGrM+p6Wr8lijhPtIR1HSJrgjRVA14zp10yAV6bPiFpK0MDn4SmcCcZ
	 KX9DZtEUmINWl6CidBIYR/Rk3y8qSBOtmVWVpbNsZIeOV5JIt7Z8flGQwJYtcB5qW/
	 MyUL5Rr1RG9tBDacb9ZCTsDTFl7mvX8VmkuNVMNkxZ0bpko/l2u2nnqFH+A80dE8IY
	 3tFARg47zNgqpZgBlWP5HK62rom3LqbwH5Lpm1Yn5A5q7tndUVK8AhWpCLdmBuF6R1
	 hBEdYQKsPNwxYSY+jwW95wsF7Hcq/LSWGTGI7rcpLIU5fAWLUHTcOaWi0eKF0A7Tio
	 SE5mIA7hqhSlQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TBPrq496mz1LK4;
	Fri, 12 Jan 2024 10:02:03 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::601])
 by lists.lttng.org (Postfix) with ESMTPS id 4TBPrn3R2mz1Lm1
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 10:01:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/U2e6hGdChnLbd/6odmxwSJSNYj24IfMG//SZ78HzOrBjxi2djjLwe0qWgQTqjWihxVDsaR8p1S9WucQdYx2spjBa80Yee9NYwALoKS7RRzjm7zkGoLBG/gN+pTGxX1AUHE0kDKscBAEiKXrVX7aQUdI1znIGfBY/2ArI0jt2HxO2Io74PUVbk3Sq6p3lKBEq2p5q6VazC4rx4jnF5B6lVAUykCbTk39evQx/V8b2a9/rFDtNfHCKQ7o0cP1BxwKdvD1gwDl4/FWnC66NXCiYhKyFRmfjiK/8Jt9FK/AstPK/xhW4z8lkvzIYYGW9sjWrpK0NgscY9i7u4edE8pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZo1LQrG/iE0w8mjDO92Bq+PMl6xhWZO06wy/fO3wgU=;
 b=dGQXoah0M0fyyIJrxd9PLw+9o/qrLYYTaAe/G3gHeEer3+cc41NsFmCp6t0cMZBQk8JaPfT+JHOBGkktvzuGF9O0icdKooguaqUG8rJMW4URcHXpRFTguibbLA9UM+Je+kY3S6hMYjWiaBDhEM1SqKvfQPOvRFSiMaQ9WCorqx18DlOFDPd8RM/agy7agh+AhXMgpncBhaUdVQQ1HOw93lOEJ0IOW6fZ706zaz7XSI8cRc7Xifpkcb8aCwDY/dWYXsz8jL5lXc4YcgK99PfXGPaGKM72bp/dGiTNKlPHSRTPxREaX7CEPxwrcToH2BTt9MGRRecUV/JkPCikYtRDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:28::14)
 by YT4PR01MB10743.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 15:01:55 +0000
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb]) by YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 15:01:55 +0000
Message-ID: <0797f455-b051-405f-9814-294e6867241c@efficios.com>
Date: Fri, 12 Jan 2024 10:01:54 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CACJEY861mX+FerESW6O6pTU7CzadHGDSBF9HktNrXr_fGp-Hcw@mail.gmail.com>
In-Reply-To: <CACJEY861mX+FerESW6O6pTU7CzadHGDSBF9HktNrXr_fGp-Hcw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::30) To YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:28::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT1PR01MB4153:EE_|YT4PR01MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: 05038337-4498-4e19-600a-08dc137f6b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56zwP/jTcxyWPSean51NICxX/M6xoBfCBK4XMS7L88aiVLSlGQJqs+ezk07mFexE246JXhwxDFzlEI4sIa/kZqOhen6w5ac1QIJJs65fjTuj7+qnKFBkaf6ZFyRw9e3HXxxWqY3eps4UTJNKbAc9Xjqig63UE6Sbv4uvPgdHUdoYuloeB1vMPBO+TSRMb5YScfSLjEhJQwS2f1S9XHoTY7ZFrKz+ka7ziCkQh3rvmgyZyXnvozo9RNnyV5n0klu7k16Wm3tc2ZQweiHduDsjsbJd+FswOphqdEl3Gf3lehDxhVFqxoC0WnvxryXU+bhOIOhIEQ3GX7j8G47PJvb8tU0YFRwVUEgBGSAe1i/+Bu4qgH2WFQ+Kc0xXwfl2tyowAelcFQbJQZnyuqtPdD9s2E+VffOdn/GGUQKqE9a6AxzBoVDlou3V3F4C4gNaRHu/b41sPfyu6tnRcTCv3lgdYtfcECIaD48DoWsv0g7jsDlYMV6SN95FdS0y6vG9pRCUJzi19ppvisQmxraV7JVtTsLv5xYsGMkCDoQZN35Hlo3UGY1VhS+4FLWOLchPQqhvJqtwJabSsbkVLo16pTVj0F9PJUOgS+UgtOBp2z2KA89chvLEFmZ7MuZn/pxkOlNS9XLvYvDvuv7Z6jQ+8ojANQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39830400003)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(478600001)(6512007)(6506007)(53546011)(4326008)(966005)(83380400001)(5660300002)(41300700001)(2906002)(6486002)(6916009)(8676002)(66476007)(316002)(66556008)(66946007)(8936002)(86362001)(31696002)(38100700002)(36756003)(31686004)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1YrejZvQVJ2Q2JYYXdoeG8yZGdxUXMwTXRLK3NmMjczTkhoajJYVGlvR25y?=
 =?utf-8?B?ajZSdkVMVDRsWjFScW9JNzVyQm9MaERwK3g3ZzlNNnFFZ0RKVTFyVnRXdC9S?=
 =?utf-8?B?NzRBdGJzOGtQVW52RlI2UkM0L0ZmT3YwUEFIa0xwQWpxNEZaSCtUTEJLcEZC?=
 =?utf-8?B?T2tVYWp6MWlQeEhGdnVBZkoraDB1Z0MvUVJLWU5EQWQ0YVlKdm9RRVlEaWg1?=
 =?utf-8?B?RmIvNjJ3QUc0VVUyODFUdWdnYzJ1ZW5JZWtEbUFEZm5KVnF5M2ZrdXJnSDlx?=
 =?utf-8?B?TG5EN2s5WU40WUJzaXVyTWNOdUVFQ3NMNCtqeTZBMStDWHExTXl2V1hZaWRX?=
 =?utf-8?B?VGx6cXdIZkFTRmRoZUJOUEJxdG5NM1RWS3hlZGtQTGZtM3I5aExzMytmbmlw?=
 =?utf-8?B?T0l1WE9QZmNEd20yNnN0akdVb05IbTNRd2JDN3dtTGRWbjFYaEVEakd0R2hL?=
 =?utf-8?B?NUxWM2pOVEJkaWhmbmJwNTJKRnhpRUhqL3ZVZGcrUUFzcUk1Ri9UVnhFY0E5?=
 =?utf-8?B?Y25NeTVhcGhUOERLOFpOUmREbnFldmRQREZmeGVpeWJIOXZTcnIvRHRjSGRL?=
 =?utf-8?B?d2JJM1NwM0tYTGZGaFlaREc0ZXBMMUwwRkhWdzU3S1h0YXJ4bUVwS20xbEZJ?=
 =?utf-8?B?Mm04a2ZpVE9tVk9tMGNMNE1yNEhaUGlYMlVTMnhISlZ3dXFtSlE3Z0ZDK3VU?=
 =?utf-8?B?RzFMZkgrR0dMQzlQc0JLU2FsUTVKWFlReTlQUjNFNDd4SDc3bzN0dHlPUldn?=
 =?utf-8?B?MkIrR3ZmQ2xqNEp0UEFFcCtaWXdXcm4rczk0clNrNFpDWmt6QzdMR09PbXo5?=
 =?utf-8?B?WW5WeEk0TnNPaWRPT3VNU1YwYnZXN0oyN2tsZ3F2djdsSGEybnM3T2oyblZT?=
 =?utf-8?B?VkdYTFZxdmJybjRNOFEzdTAvWkUwTk1kbTdid3Z6V2hWY0Z5OXh0dmRubVJD?=
 =?utf-8?B?SVFFa05Kckh1ZEFnVitmb0IrVnB0QkI3dTU1WU1lRlBHRUhlYU1od1hFdGs3?=
 =?utf-8?B?WXlpUERMb241Wkg3MjdLcVN4V2NybUZQanhHemNaNVpkNEpZbnl2UFdTQmho?=
 =?utf-8?B?OUYrUXhYa05neFlZdm1FdWNVNmtWRUxybzlQSnMrbFpYcHg5Q1NOSkg1Rm1H?=
 =?utf-8?B?NjBhckZ0bWZ0MjgwRVRBYkVtRVFIWXhNTFpJTUtqV01neERTbnF3cFg3Mkhq?=
 =?utf-8?B?eFU2ZDZYUUt0Y3kxU2pqcG1sWWxBQXlaVExydkg0QVFHRVlnQ3Nxa3RXTDRH?=
 =?utf-8?B?T2Z2N2NKb1VSUy9NNUJQSFRpcHh0L0NZdEtTMFlsMmU2QmxHQ2I2dnBzWkZH?=
 =?utf-8?B?WXBxdXJrMm16RmZKSGVob0dkUUpvNlRDVHBTQkI1SEpoT1lnTXpBTDRxa1NI?=
 =?utf-8?B?THF3RFpaOUh5b2k5c1F0NFBlcUp0eXRpNGZOK1pLOG92SWN2djdVRy8vSnBw?=
 =?utf-8?B?cVNJL01YeXc4NU9vVU95aElPd3pNK1ZESzdvaGhEZVg3cXREbzdFa2o3RHQy?=
 =?utf-8?B?UWZvUzY2SXN6Y3lLUjBCUm1tZWM1V3I1c1ZTUy9haUFiV2pHU1ZPbUNhWlRs?=
 =?utf-8?B?dTJWbjBoLzA0amhtTDBMS01LWW84dXZKUXN1M1F0NlNKc3NHamlyMHhtV0Z1?=
 =?utf-8?B?Z0w1SW5JakZuOHk2SDRNWGU1N3pNRDRtTGE5dDVWT2txY0tWQXd5MjFQV01Q?=
 =?utf-8?B?b28zY1AwbXp5bFhaYXZtZC9vNUY3UkdmeW8veG16L0NnTklaK0NURDhxZVNw?=
 =?utf-8?B?QWJ3eDhxUGFja0lOYThEMmYvU0RkM3JuZTArV1ZzckxqZDZsUkM3T2F6MnUy?=
 =?utf-8?B?VkFCNWd2enl0YWNmdzA0YmhXVHovMTBrMnJ2WVc3MlRTTTFwblBsTTdBMlN2?=
 =?utf-8?B?bnhwVGllMmFiMEZlbHBFakc0dGNHMmswY0dxR25vbjM4dGZCTjN5czZOaHJt?=
 =?utf-8?B?L0NlclJOME5hb1hYdWU0Ti9hR3JjYVNQRDJ1RnRiWkRwRE9qemJBOVVZY1M1?=
 =?utf-8?B?dWt5d2Q1bVpEcUZLVDAyMGhOYUhERVJaTzlZS2VrS0ZaUlJiSHFUOFZWT2J6?=
 =?utf-8?B?eVdoVXBTZ1c3NGwrN0pGa1ZXT1EybnBYdWQyenI1bkxNNkRUMVhheEFLVlVq?=
 =?utf-8?B?VW5pMWRsMkxqS1I3WXMzZ1oyZ3BnRkhHMXJuenU0elVpSWl0eVF2b3ZMUTlN?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05038337-4498-4e19-600a-08dc137f6b03
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 15:01:55.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYIAalJl1kf1ZW9KqDP/6w9aYvtdRyG22cnwAmrXpQHSvoeMJlSdPq4NTDiK+tZx6NHa7Ae8nwsiPB1vH3sYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10743
Subject: Re: [lttng-dev] LTTng sessiond daemon Assertion `buf' failed and
 killed
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

SGkgWW9uZ2hvbmcsCgppbiBhIGJyaWVmIHRlc3QgSSdtIHVuYWJsZSB0byByZXByb2R1Y2UgdGhl
IGVycm9yIHlvdSBzZWUgYnkgcnVubmluZyB0aGUgCmZvbGxvd2luZyBjb21tYW5kcyBvbiBhbiBV
YnVudHUgMjIuMDQgaW5zdGFsbGF0aW9uIHdpdGggbHR0bmctdG9vbHMgCjIuMTMuMTAsIGx0dG5n
LXVzdCAyLjEzLjYsIHVyY3Ugc3RhYmxlLTAuMTIsIGFuZCBiYWJlbHRyYWNlIHN0YWJsZS0yLjAu
CmBgYAokIHVuYW1lIC1yIC12CjYuNS4wLTE0LWdlbmVyaWMgIzE0fjIyLjA0LjEtVWJ1bnR1IFNN
UCBQUkVFTVBUX0RZTkFNSUMgTW9uIE5vdiAyMCAKMTg6MTU6MzAgVVRDIDIKCiQgbHR0bmctcmVs
YXlkIC12IC1iCiQgbHR0bmctc2Vzc2lvbmQgLXYgLWIKJCBsdHRuZyBjcmVhdGUKJCBsdHRuZyBl
bmFibGUtZXZlbnQgLXUgLS1hbGwKYGBgCgpDb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGUgYnVn
IHJlcG9ydGluZyBndWlkZWxpbmVzIGF0IApodHRwczovL2x0dG5nLm9yZy9jb21tdW5pdHkvIGFu
ZCBlbGFib3JhdGUgb24gdGhlIHN0ZXBzIHRha2VuIHRvIApyZXByb2R1Y2UgdGhlIGlzc3VlPwoK
dGhhbmtzLApraWVuYW4KCk9uIDEvMTIvMjQgMDg6MTIsIFlvbmdob25nIFlhbiB2aWEgbHR0bmct
ZGV2IHdyb3RlOgo+IEkgYW0gbm90IHN1cmXCoHdoZXRoZXLCoHRoaXMgaXMgbXkgc2V0dGluZyBw
cm9ibGVtIG9yIGEgYnVnIHdpdGggYSAKPiBtb3JlwqByZWNlbnTCoGtlcm5lbC4gbHR0bmctc2Vz
c2lvbmQgd2FzIGtpbGxlZCB3aGVuIEkgdHJpZWQgdG8gImVuYWJsZSAKPiBldmVudCIgYWZ0ZXIg
YSBzZXNzaW9uIHdhcyBjcmVhdGVkLiBTZWUgYmVsb3cgcGFydCBvZiB0aGUgdmVyYm9zZSBvdXRw
dXQgCj4gb2YgdGhlIHNlc3Npb25kLiBJdCBpcyBvYnNlcnZlZCBvbiBVYnVudHUgMjIuMDQsIGtl
cm5lbCA2LjUuMC0xNC1nZW5lcmljIAo+ICMxNH4yMi4wNC4xLVVidW50dSBTTVAgUFJFRU1QVF9E
WU5BTUlDLCBsdHRuZyAoTFRUbmcgVHJhY2UgQ29udHJvbCkgCj4gMi4xMy4xMCAtIE5vcmRpY2l0
w6kuCj4gCj4gCj4gVGhlIHNhbWUgdmVyc2lvbiBvZiBMVFRuZyB3b3JrcyBvbiBhbm90aGVyIFVi
dW50dSAyMi4wNCBtYWNoaW5lLCBidXQgCj4gd2l0aCBrZXJuZWwgNi4yLjAtMzMtZ2VuZXJpYy4g
QW55IHN1Z2dlc3Rpb24gb24gd2hhdCBJIHNob3VsZCB0cnk/Cj4gCj4gCj4gVGhhbmsgeW91Cj4g
Cj4gWW9uZ2hvbmcKPiAKPiAKPiAKPiBjOjEwMTYpCj4gCj4gREJHMSAtIDAwOjI0OjI1LjEzNDEz
ODQzMyBbQ2xpZW50IG1hbmFnZW1lbnRdOiBHZXR0aW5nIHNlc3Npb24gCj4gYXV0by0yMDI0MDEx
Mi0wMDI0MTcgYnkgbmFtZSAoaW4gcHJvY2Vzc19jbGllbnRfbXNnKCkgYXQgY2xpZW50LmM6MTEz
MykKPiAKPiBEQkcxIC0gMDA6MjQ6MjUuMTM0MTQ4ODk0IFtDbGllbnQgbWFuYWdlbWVudF06IENy
ZWF0aW5nIFVTVCBzZXNzaW9uIChpbiAKPiBjcmVhdGVfdXN0X3Nlc3Npb24oKSBhdCBjbGllbnQu
Yzo1MTApCj4gCj4gREJHMSAtIDAwOjI0OjI1LjEzNDI2Nzk1OCBbQ2xpZW50IG1hbmFnZW1lbnRd
OiBTcGF3bmluZyBjb25zdW1lcmQgKGluIAo+IHNwYXduX2NvbnN1bWVyZCgpIGF0IGNsaWVudC5j
OjIwNCkKPiAKPiBEQkcxIC0gMDA6MjQ6MjUuMTM1MTU1ODIzIFtDbGllbnQgbWFuYWdlbWVudF06
IFdhaXRpbmcgZm9yIGNvbnN1bWVyIAo+IG1hbmFnZW1lbnQgdGhyZWFkIHRvIGJlIHJlYWR5IChp
biB3YWl0X3VudGlsX3RocmVhZF9pc19yZWFkeSgpIGF0IAo+IG1hbmFnZS1jb25zdW1lci5jOjQ2
KQo+IAo+IERCRzEgLSAwMDoyNDoyNS4xMzUyNDc1NTIgW0NvbnN1bWVyIG1hbmFnZW1lbnRdOiBF
bnRlcmluZyB0aHJlYWQgZW50cnkgCj4gcG9pbnQgKGluIGxhdW5jaF90aHJlYWQoKSBhdCB0aHJl
YWQuYzo2NSkKPiAKPiBEQkcxIC0gMDA6MjQ6MjUuMTM1MjkzNTQyIFtDb25zdW1lciBtYW5hZ2Vt
ZW50XTogW3RocmVhZF0gTWFuYWdlIAo+IGNvbnN1bWVyIHN0YXJ0ZWQgKGluIHRocmVhZF9jb25z
dW1lcl9tYW5hZ2VtZW50KCkgYXQgbWFuYWdlLWNvbnN1bWVyLmM6NjUpCj4gCj4gREJHMSAtIDAw
OjI0OjI1LjEzNTMzNTc3NiBbQ2xpZW50IG1hbmFnZW1lbnRdOiBVc2luZyA2NC1iaXQgVVNUIGNv
bnN1bWVyIAo+IGF0OiAvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2x0dG5nL2xpYmV4ZWMvbHR0
bmctY29uc3VtZXJkIChpbiAKPiBzcGF3bl9jb25zdW1lcmQoKSBhdCBjbGllbnQuYzoyODQpCj4g
Cj4gREJHMSAtIDAwOjI0OjI1LjI0MDcyNTg4MyBbQ29uc3VtZXIgbWFuYWdlbWVudF06IENvbnN1
bWVyIGNvbW1hbmQgc29ja2V0IAo+IHJlYWR5IChmZDogNjEpIChpbiB0aHJlYWRfY29uc3VtZXJf
bWFuYWdlbWVudCgpIGF0IG1hbmFnZS1jb25zdW1lci5jOjIwNCkKPiAKPiBEQkcxIC0gMDA6MjQ6
MjUuMjQwNzQ2ODAyIFtDb25zdW1lciBtYW5hZ2VtZW50XTogQ29uc3VtZXIgbWV0YWRhdGEgCj4g
c29ja2V0IHJlYWR5IChmZDogNjIpIChpbiB0aHJlYWRfY29uc3VtZXJfbWFuYWdlbWVudCgpIGF0
IAo+IG1hbmFnZS1jb25zdW1lci5jOjIwNSkKPiAKPiBEQkcxIC0gMDA6MjQ6MjUuMjQwNzc1MzE4
IFtDb25zdW1lciBtYW5hZ2VtZW50XTogU2VuZGluZyBjb25zdW1lciAKPiBpbml0aWFsaXphdGlv
biBjb21tYW5kIChpbiBjb25zdW1lcl9pbml0KCkgYXQgY29uc3VtZXIuYzoxNzkxKQo+IAo+IERC
RzEgLSAwMDoyNDoyNS4yNDEwNjY3NjIgW0NvbnN1bWVyIG1hbmFnZW1lbnRdOiBNYXJraW5nIGNv
bnN1bWVyIAo+IG1hbmFnZW1lbnQgdGhyZWFkIGFzIHJlYWR5IChpbiBtYXJrX3RocmVhZF9hc19y
ZWFkeSgpIGF0IAo+IG1hbmFnZS1jb25zdW1lci5jOjMxKQo+IAo+IERCRzEgLSAwMDoyNDoyNS4y
NDExMDA0ODEgW0NsaWVudCBtYW5hZ2VtZW50XTogQ29uc3VtZXIgbWFuYWdlbWVudCAKPiB0aHJl
YWQgaXMgcmVhZHkgKGluIHdhaXRfdW50aWxfdGhyZWFkX2lzX3JlYWR5KCkgYXQgbWFuYWdlLWNv
bnN1bWVyLmM6NDgpCj4gCj4gREJHMSAtIDAwOjI0OjI1LjI0MTEzODM4NiBbQ2xpZW50IG1hbmFn
ZW1lbnRdOiBTZXR0aW5nIHJlbGF5ZCBmb3IgCj4gc2Vzc2lvbiBhdXRvLTIwMjQwMTEyLTAwMjQx
NyAoaW4gY21kX3NldHVwX3JlbGF5ZCgpIGF0IGNtZC5jOjEwMDQpCj4gCj4gbHR0bmctc2Vzc2lv
bmQ6IHVuaXguYzoxODU6IGx0dGNvbW1fcmVjdl91bml4X3NvY2s6IEFzc2VydGlvbiBgYnVmJyBm
YWlsZWQuCj4gCj4gRXJyb3I6IEV2ZW50czogTm8gc2Vzc2lvbiBkYWVtb24gaXMgYXZhaWxhYmxl
IChjaGFubmVsIGNoYW5uZWwwLCBzZXNzaW9uIAo+IGF1dG8tMjAyNDAxMTItMDAyNDE3KQo+IAo+
IFsxXStBYm9ydGVkIChjb3JlIGR1bXBlZCkgbHR0bmctc2Vzc2lvbmQgLS12ZXJib3NlCj4gCj4g
REJHMSAtIDAwOjI0OjI2LjM1Nzc2OTEwNiBbUnVuLWFzIHdvcmtlcl06IHJ1bl9hcyB3b3JrZXIg
ZXhpdGluZyAocmV0ID0gCj4gMCkgKGluIHJ1bl9hc19jcmVhdGVfd29ya2VyX25vX2xvY2soKSBh
dCBydW5hcy5jOjE1MjYpCj4gCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
