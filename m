Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D6C25B74
	for <lttng-dev@archiver.kernel.org>; Thu, 16 May 2024 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715866661;
	bh=oA8L1KDl1F2cx4fq67j1axrDkkXZvR0XmKH0FXyVd9g=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=EqSefiqZFnq+Si1gIiobdnA/ONSpIC94+vbraWhFRmKx6PP+fyK0VPHNvywdTenA1
	 +1yJp5EgaG+hQNsHGZSu3X4GjxVDGYBjnVl9sVweCYo1ucCfaKWztuiyXqsbSXOfZj
	 kkITup/3OFIvi6YO2KlgoLE3jYJ/slHGe1BzFNS+ZRXvOs2C8xX9d+m6qGD35wQMrf
	 POkPKQwD+0eHJ8e37iNqUB/PiY2PRznqps7nfbXZQhAy6cxssh3V7eYQYn4ttMMLTG
	 LQQtgQDAuswBgMc0fohgi+AJY4v6aPBqCtLMVA7Z6fjzbB69MjCLt/hNBa85cI6vUw
	 2IHFNZPR3xE3g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VgB3m5ML4z2njV;
	Thu, 16 May 2024 09:37:40 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::701])
 by lists.lttng.org (Postfix) with ESMTPS id 4VgB3l0RlYz2njT
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2024 09:37:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFRu4gz69YkaLV1kpnVT4lKTw/0cT8ILneEjyookAk/E3mdRmLL5v48mzgSh4C1g6ZYxePsZrv2b2gyIAD8xk4svY3d+yf3MhvSTnQ62/3TpZfVZYFvjUy/Gi6PL7qX1T1PaFdphacLR46Aut06jHC1N8xhaCEzN1tr6X3gscfucQHCrOZAMpo1yy5HKEaeSNf22gSul9vLqPoZxkVQ5bT5m0WFsWMDGVkcCXqqVoX7aTzPizOJuZJab21rot1kOa4R5JzA1I6W3AcWXbAsCSZvjNyQjr4Zq7QCcVxWozZdifREJE2FyihcOb/MYkc/YmwjWw4mi7XppvewWNC5v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m6wDQ5AUlHruRMTFQHK4qAJpL11oJZ2mAZQrauF4Ig=;
 b=EkH17GIuPcL9eHEgvcuBM2R2lzYsqih8QNyZybQc4siVxymvnn2ToIKGVIRX68iHsIal8m8S5tRFTj8si5DK7GWRmrb6/IOLe2eU2uZsqD0cKlHGBW7cEXz8dG/sa6tXn0jJoLroRPMFFflHMmh2eA7DRoIIjQCGolWY4jdHzM/9a1kss7TCuslqdOVymoxHCuRLw7XrlWVe/SbcTtOeAo+FFYYivuq4K7S9fIrdwb7ad3SA9D9qkKkHYpODlO1womDZ+eRG0hWVQeul/MqMv0byabaG2f+GHNpY2Wh3ftXicuNG5WYILndk4/MH0NSuXgs2ZupTGv8Gn8zWEKW2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB6660.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 13:37:35 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 13:37:35 +0000
Message-ID: <479fa8db-6d40-49c3-bb4f-8c920ab291ac@efficios.com>
Date: Thu, 16 May 2024 09:37:33 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAA1MA5d-ah6bqoN8=_5PwTe-6h_2B0GsHzt=cVuwJANyiMDhGg@mail.gmail.com>
In-Reply-To: <CAA1MA5d-ah6bqoN8=_5PwTe-6h_2B0GsHzt=cVuwJANyiMDhGg@mail.gmail.com>
X-ClientProxiedBy: YQZPR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::14) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cf63f1-7b42-4976-e8fc-08dc75ad5868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJ2YjhoZ0wvVGVLSnJ1dUlnOGpYYnRCTjNqV1lhVlBpRFhZcWxKVXlhNnM5?=
 =?utf-8?B?OWFyREI5TGlXUDh4QWlENzdPTGJFQk13LzB2MFI2dHIyYUxnZmNPV1o3VFZ6?=
 =?utf-8?B?WjcxRXFFRVZOOC85aStrZEZMb3htR2pxTGpLODZtNTR5b2prdWZCYUh6S2Vr?=
 =?utf-8?B?UHVUbUgvMTlnVVUxME1ZZkRHR0FyTFNCcWNnMmIrS05xQ2JBZFdOTEVBNGRy?=
 =?utf-8?B?SVROUTZiLzdZd2xsRHp6WkxDZDVNV09uTEp6SGlzT1hWdXF4NDRlSDFhYmpP?=
 =?utf-8?B?cFMyVWh5TU0zOWVjT0N5K0ZTN09ZN1BRc2ZtdGIybzltZHltVmJRM1JNa1Zx?=
 =?utf-8?B?UWE5ZkxYU2x6VDJpYlpobERrbGVZZkR3T3ZWeGcxeXNiUm5POGVBS0tNa3VP?=
 =?utf-8?B?UGJJK2IxYlAyV2oxZ3h2L24ybzdTRkJCU2NUcW9tRER4cWZzbThzMkpRUTJs?=
 =?utf-8?B?TUQ3L2JBNDhBbGlnZzc1OUJEMzJtMFE3VEVDQjNZOWwyZFJjWVN6dnlsQjZl?=
 =?utf-8?B?cHQvdmMyaGpDSGdxdFplc20reFlyYzhXVlA3T294TDN2bDZXUENzTDNObG0v?=
 =?utf-8?B?QUE1Q2hTdmZjdE50TFB0R2kxNklxQzg0ZmxLRkNvQ05DcEZvTEhuWFJ6SkJa?=
 =?utf-8?B?dDZXSlhUNmlWM3M2dlkwU1h6NXJPTmlSWitDNnJ6eCtTLzYrS0Ezb3hTNG9y?=
 =?utf-8?B?TllwazQzWFJLdlRmaS9hVU9hbmx6cjcyODVGRU52czliTXpyTVBGajJHV0Vi?=
 =?utf-8?B?eFFsc2duYTNuTDFmYURvanQ4YkQyTGdONk5uZDBIRjFaV1MzWkgwSUF3dWla?=
 =?utf-8?B?RG0xaGpuUC8rV0VCMDR3aTg5Ri9IeEthb01ZaG16WWpDVHJONEU4NE9uQVZT?=
 =?utf-8?B?Ty8wREhQYlRSUC82N3YvV3UvNXRQSG5lL3NVSkdwVkM2dzRYRW5VWVBnL2I1?=
 =?utf-8?B?MkgyYnNFbDNBaDFkL0ZvSXo4ZXRrWHozNlcweUlDSEU3TzNYWWdlMDJ4QlNB?=
 =?utf-8?B?cFFNZnM4VFA1aXJsS1ZsdC9ORVdLajF1UmcyVWVyMnphTmxYYVQ5MFN4UmpK?=
 =?utf-8?B?b1JZZGR2YUlQNDF5VXl0TVhEdnVRK2lwTXpvSU1qU3dsZmx5b0t6c25nMUJq?=
 =?utf-8?B?YkhsWVBOVjZOdjZJOGlnOXhvbFRWK2JvMlJTeGNDK0xiNU9hVE4xdXVTenpu?=
 =?utf-8?B?ZEF5R1ZmZG13bkNDSEF0aWx1Umx3MFlUZzdDekg5Znd4eTNDMkgxdklLcFVP?=
 =?utf-8?B?TnN6cDluUy9ZQ1ZhTnpxbUNLdXJtY05BeE5VbVhaZXpqSmx0ZGZyZER5SEk4?=
 =?utf-8?B?WnNHbVJwWVpQQjc5dEwrRFVPNHdvVG0yeTJ6cnlUUkt3Q3BtdDcwQWgyZEJU?=
 =?utf-8?B?aGJCbHVMVjJvdUhCOW9hNDZNWWVwRFZGaGFwZm1TeGhsZUtBLzNqb05Xclds?=
 =?utf-8?B?dngyUWNKNWdHZjJhLzJEbjg0Q2gyYlRzTnNGM3BsbTJ0ZjNhMnY1dlRGTjhG?=
 =?utf-8?B?MVdYZWpTYjg2N2syTWliVFJCSWJObGswcnR4c2RZSXpTMk84NG43dzN0NkFt?=
 =?utf-8?B?djVyN0k0N2VwaWdYSlNzNXYwYmFnbXFTbjhLWERxRURDcnZ0ampQMk9tVTVx?=
 =?utf-8?Q?CM9jp4pyUOUcgoD0vwGp+DelvNdM3v4ACbIW+O0GjbRk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlNcXduNzJrcnJPMEwrKzFtbDhCTXN6YjJaZlU2WGRkVXArekIvN1RCMmNr?=
 =?utf-8?B?WmszbVEwN1F6bVZzWmtUUGpjdTdjcTRyWXZ3N3BzTGFFQms0d1pIa3NlZG5F?=
 =?utf-8?B?V1prS3pqNkFBcEdLZmxORFRkS2doOUVyRXBFRHdBVzFOSU5CL0I1cERrL3Vv?=
 =?utf-8?B?MUQwemovQk1PVkR3UXdpcGtsR0VjSWpObGo2aDV5THNHemtBc21vWWNuZGZC?=
 =?utf-8?B?LzBSdS9HYXM1eWc3eFRsYmtUZlVsODJ4OXNVZGZxWU84bDJianhKK0hDNmt3?=
 =?utf-8?B?TUt2eThwdUNkaUtVZWQ3SjNsLzZsRFMzZG8xQnNxUFVlbGdvUldHdUFLVytG?=
 =?utf-8?B?dUs1TDFrb1JDYUl2UHZYTTE1VUdyTlhFdlFjaElwNS90YzloV1ZxRmpkTEYy?=
 =?utf-8?B?VFE3azdxODhja1VYd2pKTXMrM3lGZmEwMlloSWt5U0tTZHVIdlNodUk3aHp3?=
 =?utf-8?B?UTc5Vmh2VTFSN0NGZm83WE8yUG1Tc3RkMkwvMGxnOHhWZVBWT1dpK3VxaWVC?=
 =?utf-8?B?b2U5QVp6eDdQZWpqK2xDV0d5VVVNT2Y2ajdHc25VL0tyOS9NRzhEUnBEN01W?=
 =?utf-8?B?UW1RL2llSVNGeGhmb2haM0V1dkxHSnNma3ZxOUZDd29VSVJJdmU2c1UzSUls?=
 =?utf-8?B?Yys4NGRCYmJkemRTSUdHb1laV3NOTUxhOTc4dVFtckhmOGlvb01tSUIxbkxl?=
 =?utf-8?B?c01Ranl4Zm43amxOa0I5TE01Q2VTUkg2QXRGQWRGaFdkWmJ0YjU4T2wrNHFH?=
 =?utf-8?B?SXphanArUUI1VmNXMGNVWmY5R3MvN05KS1Vxc3ladnUvWHVkZHptVHFJeGxn?=
 =?utf-8?B?MXpUekk2UGRxTnRnN3RoVlQ0OHFVQm1iTG9kdnpXRnlGb2E3RmliWFZCV0JY?=
 =?utf-8?B?WERERkRFUlg3SUw3dCtQclVsMmU5R0E2dEZhc3NBWldWM21DMTdNalpzZWU1?=
 =?utf-8?B?MGNWQ1RjaEZvL2FaQXYzREhsazFzRTRmaFFFdmkxdzNkTTgzclQ4dzljVnJM?=
 =?utf-8?B?eEUwaUVXWm02dkhnMjA1dXdyWUVpYXR3a2VSbTkzUFc4QTBOeFVJbGNRZGdY?=
 =?utf-8?B?cU5XNDVIb2lxVWFpNldtUFdvQmFxVGNvaTluOEpkN0RxTGJZS00xcExqS0R2?=
 =?utf-8?B?UXEzT0JZdkRMUDkzNFE3OUdBY3pYT01ING9PTjBxdzRhQ3BoaVNjUFo2RHQ1?=
 =?utf-8?B?cWdneWNxNUJwTENVR0Rjc2ppQVpOOWpHNzVVMDJOMUJqRTB5YUNhV3NqQ0xu?=
 =?utf-8?B?dHFXRjBYOS82NTYwb0p0cEU2bCtPZnkzWERHZzE4U0NURHVNRnozazJPaWlx?=
 =?utf-8?B?NFhSNVp4TU5zS1llS1lGaFYxSER0TDh4NEwzb0ZsVzhVNEZ0M1l1U3hodjd6?=
 =?utf-8?B?WldROEZqMWVJSEFZSXBNWUxyTVN0Z0RKVVU3VXRLRUdxSHI1U0plTWFodTB6?=
 =?utf-8?B?WjJISXFwM3VEbitCTGhuVy9CNzNUbHBOVUFhSDNWakd5SVFYQmJLa3JPVHNp?=
 =?utf-8?B?UHJXM3ZpbzB1cDlqOVhFYUZtU0NxSzNLaVRscjdlZklhUWJEV2p3SFlzYXEr?=
 =?utf-8?B?Z29zK2JheitRVjVhUWMyUW5CVkZPL0cySDRmdG96U01pNmUyZHAxOENsWmw2?=
 =?utf-8?B?Mk5YTExUbk54ZG5JTmtRYmlmNWZWSjNPb09jVGFXUWpsNS9PTURScUZmNFRI?=
 =?utf-8?B?WWVEdk5wQ1JYT3AvSUZ1WUwzMGs5azdpdDUzTDJ0NXlwMW5OVC9hRi95YWJr?=
 =?utf-8?B?cmRSNjFXNS96Rlk5NFlkTUJpNXFudDdkb012RWFkME5hQkMyUEFMVWFPelE1?=
 =?utf-8?B?dVdaQ25VYjlHR2lCdGVTVEpDcFlGYzQyTnlCaWpxUzNtWU4yRWFYNGoyNHFK?=
 =?utf-8?B?eWs2NGtNWTgwVEYvcTF2M091SlFhQnliNHNidEppRzlsbE1LbEp5UUVKMU4z?=
 =?utf-8?B?ZlJ3TWtJb2g5clVJeWdwZTE0UWVIdzk0bkFISEgzS3l0emRhWjZyYm5RMEVH?=
 =?utf-8?B?TTF2M20wUTlJSnhGQ0tyK29RbTh1eVdFTjRXbVlLblFGVmIwdTRkK3NtMXIy?=
 =?utf-8?B?ZjlTczdVN3hkUWhQL2l0ZndRbG1WVVdEcFpmcm50Z29DcnpqakNOL1llelRG?=
 =?utf-8?B?KzVVWTByOWc4WDRhWll2Y1VrVW51MjkwSksybzNidGIvYy9CMDYyd2RHajFI?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf63f1-7b42-4976-e8fc-08dc75ad5868
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:37:35.3919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsyOdnFIiYyc/lAYOHoewbbxJ2vlENrKeePR8FJe0T2cvCJ3EOMJOWgTuOvWvBwvgcvWQ4HMFa7TBrLZsajjRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6660
Subject: Re: [lttng-dev] Capturing snapshot on kernel panic
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

SGkgRGFtaWVuLAoKCk9uIDUvMTUvMjQgNjoyNCBQTSwgRGFtaWVuIEJlcmdldCB2aWEgbHR0bmct
ZGV2IHdyb3RlOgo+IEdvb2QgZGF5LAo+IHdlIGhhdmUgYmVlbiB1c2luZyBMVFRuZyBzdWNjZXNz
ZnVsbHnCoHRvIGNhcHR1cmUgc25hcHNob3RzIG9uIHVzZXIgCj4gZGVmaW5lZCB0cmFjZXBvaW50
cyBhbmQgaXQgZGlkIHByb3ZpZGUgaW52YWx1YWJsZSB0byBkZWJ1ZyBvdXIgaXNzdWVzLiAKPiBU
aGFua3MgdG8gYWxsIHRoZSBjb250cmlidXRvcnMgb2YgdGhpcyBwcm9qZWN0IQo+IAo+IFdlJ2Qg
bGlrZSB0byBrbm93IGlmIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIHRyaWdnZXIgb24gYSBrZXJu
ZWwgcGFuaWM/IAo+IEkgbWlnaHQgYmUgZHViaW91c2x5IHBvc3NpYmxlIGFzIHlvdSB3b3VsZCBz
dGlsbCBuZWVkIHRvIGhhdmUgdGhlIAo+IGZpbGUtc3lzdGVtIHdvcmtpbmcgdG8gd3JpdGUgdGhl
IHJlc3VsdHMgYnV0IEkgc2hvdWxkIGFzay4KPiAKCkZvciB1c2Vyc3BhY2UgdHJhY2luZywgSSB0
aGluayB0aGUgcmVjb21tZW5kYXRpb24gaXMgdXN1YWxseSB0byB1c2UgYSAKZGF4L3BtZW0gZGV2
aWNlIGFuZCBoYXZlIHRoZSBidWZmZXJzIGZvciB0aGUgc2Vzc2lvbiBtYXBwZWQgdGhlcmUuIEFm
dGVyIAphIHBhbmljLCB0aGUgY29udGVudHMgb2YgdGhlIGJ1ZmZlcnMgY2FuIGJlIHJlc3RvcmVk
IHVzaW5nIGx0dG5nLWNyYXNoWzFdLgoKTm90ZSB0aGF0IGRheC9wZW0gaXNuJ3Qgc3VwcG9ydGVk
IGJ5IHRoZSBrZXJuZWwgc3BhY2UgdHJhY2VyIGF0IHRoaXMgdGltZS4KCklmIEkgcmVjYWxsLCB0
aGVyZSBhcmUgb3RoZXIgd2F5cyB0byB0aGluZ3MgaW4gdGhlIHBhbmljIHNlcXVlbmNlICh0aGF0
IAphcmVuJ3QgbHR0bmcgc3BlY2lmaWMpLCBidXQgSSdtIHBlcnNvbmFsbHkgbm90IGFzIGZhbWls
aWFyIHdpdGggdGhlIApkZXRhaWxzIG9mIHRoYXQgc3RhZ2Ugb2YgbGludXguCgo+IExvb2tpbmcg
YXQgYXZhaWxhYmxlIGtlcm5lbCBzeXNjYWxsLCB0aGUgInJlYm9vdCIgb25lIHNlZW1zIGxpa2Ug
YSBnb29kIAo+IGNhbmRpZGF0ZSwgaG93ZXZlciBJIHdhcyBub3QgYWJsZSB0byBjYXB0dXJlIGEg
c25hcHNob3Qgb24gaXQuIEkgaGF2ZSAKPiB0ZXN0ZWQgdGhlIHNldHVwIGJlbG93IHdpdGggIi0t
bmFtZT1jaGRpciIgc3lzY2FsbCBhbmQgaXQgd29ya3MswqAiY2QiIHRvIAo+IGEgZGlyZWN0b3J5
IHdpbGzCoGNyZWF0ZSBhIHRyYWNlLiBCdXQgbm8gZGljZSB3aXRoIHJlYm9vdC4KPiAKClRoZSBk
ZXRhaWxzIG9mIGhvdyB0aGlzIHdvcmsgd2lsbCBkZXBlbmQgb24geW91ciBzeXN0ZW0uIEZvciBl
eGFtcGxlLCBteSAKaW5zdGFsbGF0aW9ucyB0ZW5kIHRvIHVzZSBzeXN0ZW1kIGFzIFBJRCAxLiBU
aGUgYnJvYWQgc3Ryb2tlcyBzZWVtIHRvIApiZTogYC91c3Ivc2Jpbi9yZWJvb3RgIGlzIGFjdHVh
bGx5IGEgbGluayB0byBgc3lzdGVtY3RsYCwgd2hpY2ggSSAKYmVsaWV2ZSB0aGVuIGtpY2tzIG9m
ZiB0aGUgcmVib290LnNlcnZpY2UsIHRoZSBQSUQgMSBpcyBzd2FwcGVkIHRvIAovdXNyL2xpYi9z
eXN0ZW1kL3N5c3RlbWQtc2h1dGRvd24sIHNpZ3Rlcm0gdGhlbiBzaWdraWxsIGFyZSBzZW50IHRv
IGFsbCAKcHJvY2Vzc2VzLCB1bm1vdW50cywgc3luY3MsIGNhbGxzIHRoZSByZWJvb3Qgc3lzdGVt
IGNhbGwgWzIsM10uCgpBcyBib3RoIHRoZSBzaWd0ZXJtIGFuZCB0aGUgdW5tb3VudHMgYXJlIGRv
bmUgYmVmb3JlIHRoZSBzeXNjYWxsLCAKbHR0bmctc2Vzc2lvbmQgYW5kIHRoZSBjb25zdW1lcnMg
d2lsbCBoYXZlIGFscmVhZHkgc2h1dGRvd24gYnkgdGhlIHRpbWUgCml0IGVudGVycy4KCldoaWxl
IHRoaXMgZG9lc24ndCBuZWNlc3NhcmlseSBoZWxwIHlvdXIgb3JpZ2luYWwgcXVlc3Rpb24gb2Yg
cGFuaWNzLCBpZiAKeW91IHdhbnQgdG8gc25hcHNob3QgYmVmb3JlIHNodXRkb3duIG9yIHJlYm9v
dCBhbmQgYXJlIHVzaW5nIHN5c3RlbWQsIAppdCdzIHBvc3NpYmxlIHRvIGxlYXZlIGEgc2NyaXB0
IG9yIGJpbmFyeSBpbiBhIGtub3duIGRpcmVjdG9yeSBzbyB0aGF0IAppdCdzIGludm9rZWQgcHJp
b3IgdG8gdGhlIHJlc3Qgb2YgdGhlIHNodXRkb3duIHNlcXVlbmNlWzRdLgoKWzFdOiBodHRwczov
L2x0dG5nLm9yZy9kb2NzL3YyLjEzLyNkb2MtcGVyc2lzdGVudC1tZW1vcnktZmlsZS1zeXN0ZW1z
ClsyXTogCmh0dHBzOi8vZ2l0aHViLmNvbS9zeXN0ZW1kL3N5c3RlbWQvYmxvYi82NTMzYzE0OTk3
NzAwZjc0ZTllYTQyMTIxMzAzZmMxZjVjNjNlNjJiL3NyYy9zaHV0ZG93bi9zaHV0ZG93bi5jClsz
XTogCmh0dHBzOi8vZ2l0aHViLmNvbS9zeXN0ZW1kL3N5c3RlbWQvYmxvYi9tYWluL3NyYy9zaGFy
ZWQvcmVib290LXV0aWwuYyNMNzcKWzRdOiBodHRwczovL3d3dy5zeXN0dXRvcmlhbHMuY29tL2Rv
Y3MvbGludXgvbWFuLzgtc3lzdGVtZC1yZWJvb3QvCgpob3BlIHRoaXMgaGVscHMsCmtpZW5hbgoK
PiBXb3VsZCB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnM/Cj4gVGhhbmtzIGZvciB5b3VyIGhlbHAs
Cj4gQ2hlZXJzCj4gRGFtaWVuCj4gCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IAo+
ICMgUHJlcCBvdXRwdXQgZGlyCj4gbWtkaXIgL2FwcGxpY2F0aW9uL3RyYWNlLwo+IHJtIC1yZiAv
YXBwbGljYXRpb24vdHJhY2UvKgo+IAo+ICMgQ3JlYXRlIHNlc3Npb24KPiBzdWRvIGx0dG5nIGRl
c3Ryb3kgc25hcHNob3QtdHJhY2Utc2Vzc2lvbgo+IHN1ZG8gbHR0bmcgY3JlYXRlIHNuYXBzaG90
LXRyYWNlLXNlc3Npb24gLS1zbmFwc2hvdCAKPiAtLW91dHB1dD0iL2FwcGxpY2F0aW9uL3RyYWNl
LyIKPiBzdWRvIGx0dG5nIGVuYWJsZS1jaGFubmVsIC0ta2VybmVsIC0tbnVtLXN1YmJ1Zj04IGNo
YW5uZWxrCj4gc3VkbyBsdHRuZyBlbmFibGUtY2hhbm5lbCAtLXVzZXJzcGFjZSAtLW51bS1zdWJi
dWY9OCBjaGFubmVsdQo+IAo+ICMgQ29uZmlndXJlIHNlc3Npb24KPiBzdWRvIGx0dG5nIGVuYWJs
ZS1ldmVudCAtLWtlcm5lbCAtLXN5c2NhbGwgLS1hbGwgLS1jaGFubmVsIGNoYW5uZWxrCj4gc3Vk
byBsdHRuZyBlbmFibGUtZXZlbnQgLS1rZXJuZWwgLS10cmFjZXBvaW50ICJzY2hlZCoiIC0tY2hh
bm5lbCBjaGFubmVsawo+IHN1ZG8gbHR0bmcgZW5hYmxlLWV2ZW50IC0tdXNlcnNwYWNlIC0tYWxs
IC0tY2hhbm5lbCBjaGFubmVsdQo+IHN1ZG8gbHR0bmcgYWRkLWNvbnRleHQgLXUgLXQgdnRpZCAt
dCBwcm9jbmFtZQo+IHN1ZG8gbHR0bmcgcmVtb3ZlLXRyaWdnZXIgdHJpZ19yZWJvb3QKPiBzdWRv
IGx0dG5nIGFkZC10cmlnZ2VyIC0tbmFtZT10cmlnX3JlYm9vdCBcCj4gIMKgIMKgIMKgIMKgIC0t
Y29uZGl0aW9uPWV2ZW50LXJ1bGUtbWF0Y2hlcyAtLXR5cGU9a2VybmVsOnN5c2NhbGw6ZW50cnkg
XAo+ICDCoCDCoCDCoCDCoCAtLW5hbWU9cmVib290XAo+ICDCoCDCoCDCoCDCoCAtLWFjdGlvbj1z
bmFwc2hvdC1zZXNzaW9uIHNuYXBzaG90LXRyYWNlLXNlc3Npb24gXAo+ICDCoCDCoCDCoCDCoCAt
LXJhdGUtcG9saWN5PW9uY2UtYWZ0ZXI6MQo+IAo+ICMgc3RhcnQgJiBsaXN0IGluZm8KPiBzdWRv
IGx0dG5nIHN0YXJ0Cj4gc3VkbyBsdHRuZyBsaXN0IHNuYXBzaG90LXRyYWNlLXNlc3Npb24KPiBz
dWRvIGx0dG5nIGxpc3QtdHJpZ2dlcnMKPiAKPiAjPT09PT09PT0gdGVzdCBpdC4uLgo+IHN1ZG8g
cmVib290Cj4gCj4gIz09PT09PT0gcmVjb25uZWN0IGFuZMKgTm90aGluZyA6KAo+ICQgbHMgLWFs
dSAvYXBwbGljYXRpb24vdHJhY2UvCj4gZHJ3eHIteHIteCDCoCDCoDIgdSDCoHUgwqAgwqAgwqAg
NDA5NiBNYXkgMTUgwqAyMDI0IC4KPiBkcnd4ci14ci14IMKgIDEwIHUgwqB1IMKgIMKgIMKgIDQw
OTYgTWF5IDE1IMKgMjAyNCAuLgo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
