Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C10E81E19
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Oct 2023 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696608776;
	bh=VVSyH8VsAVtObgGwbVm75dt5vwID0ZybMmVXTN3q9Hw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=eZ7Au/gs7WIHjRmLNBMv1kJ+990DSkVO6Ha7f/J567F2ib9cUAubuyfkHnTNBLTsW
	 RQdJTEsEWvt6w5F7TAawuYRgGDc8ZereBJ06jbh/LPFHGfXKpYmMM/Z9KWYegq52tn
	 4GKFtaIdEJKUJ9ZsN+uC2ou3S/mOcqXBI+E6941uLhncxc7ma2molvVDYCfxWWIRLH
	 Il/SHgvb2ZKlqKuFNWqIlcySKkohILlHZ69iwvEL3jkmRs4NQI9hxp+pKA5Zm5bXtx
	 aYRGH8vwNnCCstpN/7ETQBLmLYULr2f9AAqqq9AInXqFYlRXkmOgMFy0Avh4XF+GsU
	 lvBb3Rn+dEBVw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S2D3q2LFNz2tQk;
	Fri,  6 Oct 2023 12:12:55 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2057.outbound.protection.outlook.com [40.107.116.57])
 by lists.lttng.org (Postfix) with ESMTPS id 4S2D3p4Vlyz2tNH
 for <lttng-dev@lists.lttng.org>; Fri,  6 Oct 2023 12:12:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZgfOxrcUIYI+o6A/ffqk9LmW2JZ1OYSstpBbp0dONK9s5NPfrGIB4ufwGsGdRNkTKEhhaX8Z60jF59FJAzfo7BBPBwIj5so9K66XxucrInG4ZXqO+QPlth553SjVL+r5xwXMRlEtcF1OpA/xHfjqs+cFJtOV+OJ7kGrU1jOsnLbd85E4SogEGxuFlOYtNV0+vjqjVcrT5NuhfJlraFHzFygSHJOQ3k+r+k1AiBq88RctCUSi/c8d52mlypOhpJ5Fw14K5TJMG0SPoEH7fJm7x+84N6YnNJcxNKsSdkYkCG0Nle3XDfbBjR1nYK/Tsiz9+ffEWGTbnhElLhan0AZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gljo4xplVGbgvFgRE6iTkxLIZBX9vwupWBx5vvx3ywU=;
 b=NQNB/jb+lPrMCSkR9mGbP9h4lkucAQIct8G4XBzavWtnMH/CwNJKc/nHWw+KZSeWYXPgjm7JZau1y6n1+OFvNWPTQYZdrixHHPNDX0I71SpqceYrHpJgltffF72G/S3WNZ1ta8To2Md7fMjSM26Lj5uqwf/UxOa87XcsYo6y2f+aGSvrCNVYkwqg3Zdefh1fBoeztfVZ0YCh0008LM+IcNbiLDC5F53ceGStXB6WthHyBEv4RKgBw4/ng9mzLmIP+cNwiC8T1ram/IbrqauJfdEG1xN8z2gqPOWP/PyFTTO9XhFoAm+ezShIX78v4OHjI4M6yvN4M6oiBXLWiZDDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQBPR0101MB5720.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 16:12:52 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd%7]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 16:12:52 +0000
Message-ID: <c24c1489-c3a4-46e8-b91f-9da212081065@efficios.com>
Date: Fri, 6 Oct 2023 12:12:51 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: lttng-dev@lists.lttng.org, Zach.Kramer@cognex.com
References: <SN6PR06MB426922F9DBACE81D0C6B66A591C3A@SN6PR06MB4269.namprd06.prod.outlook.com>
 <f0437833-964c-4aee-a52b-e79fd89540fc@efficios.com>
In-Reply-To: <f0437833-964c-4aee-a52b-e79fd89540fc@efficios.com>
X-ClientProxiedBy: YQXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::44) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQBPR0101MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 333111ba-5c20-4969-56b1-08dbc68717c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qp+68izHO8veGrePI9hzZWb4sTmESgmw8fbFiZrFHN42aXxem/OaZUbNfXyXzY0RQC6+Zg1SHmKRnZeN2tTZxOJxIq9nA70Tflaf4y7ThwJ2eNIcqGJJ/bO4dKuPpYHxBkYSt/Uk/T3G4lMc9JzX+YXlOBSrA79C8EiI2R/cybYk1XIhcFyLF6ngYmW7QEgEeZedQ/wqPGE09v3xwQOJWfREzplplwn7+exn70W17Xr6UZU/yExz4vw7tDvm1Tdv8CIS9TspnUUFNN+8Fabgs+ZbS+sy8QDb94PLck0AvSbdY1/v5VZnX/P8x4uFzdZgKF2Tkui3zBkGfXYGhcmx+Lc7cIt7CKDTQUxRAsFabisbn28+2M4CJfeMwCOPEmxpnFwoULtpq+WZfzyKiTbTrS62ExLhOGBnq6oHDPDNNIYa2x4o/PylTXJbGLP8uBWpTEIaduxfuKRJ2BnpwFufyzW3AwT+NvGh9JGMX45DSAgIMwv0EhQD3rCpUw1F2jvRgJVqY8RbdChw89v16bYs6vYRTUoOuX8T9LXiL05dKckECAuhkrDV6L8IOCCxmdRIZSgF4vo0JnnRZ3+gIa1lUWbh//pnW80rxR+lngT1bNfSBAEUGSEXv1AqWVKnh71RyQ+HofO0PxTsgo81ONJjA/1usBhUheTpXW/MxhSZaJmbWLdL7NDi2c7fmvRhGdDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39830400003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(5660300002)(8676002)(2906002)(8936002)(41300700001)(316002)(66946007)(66476007)(66556008)(36756003)(26005)(6506007)(53546011)(2616005)(6512007)(38100700002)(966005)(86362001)(83380400001)(6486002)(478600001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vko0ZUJNcXNrRGVvRW92OEIwVU9nOGZBZDNxei9qY09iR0Y0Y2l1WTNTSzR6?=
 =?utf-8?B?TE1kbE1zTDNNTi9vYmcyK21FWHFSQ3FFV2tSWGFXT2N1aldJOFpKOVM1YmE5?=
 =?utf-8?B?WitsZXVwQ241d215RWZNbElQbVNGOHhIMURxeHdzRVVTdDYrOE9EYUg2bk1I?=
 =?utf-8?B?d3JSdlBTVWlIc0d2RGwrTktlKzFQenhZbjZ1ejBPZlUwa1M0YUVzTVlJRzJY?=
 =?utf-8?B?NWxHcktUWnZORUxXUzBTcXpmYnM2bXhyNG5HRW9TU25ta0hvZ2RvajlhQzdw?=
 =?utf-8?B?R01EOEVlVHpSWDczSUl1YmRncEFPcmZDRlM5SXk2a1lYREw5djViREZ0TW1O?=
 =?utf-8?B?MGx5VURUdHhvR1oxaEJGaytuOUNtYUkvdmtCWmI1N3A1aCtkNU9sN21US1hE?=
 =?utf-8?B?ajdpczlNYkhjWkdEQlZpVlAyUzBwd2lPdzRkclczcXhwYUxqVU00TEdlZWpV?=
 =?utf-8?B?ZzhRVklhdmJFTzB0RElta1ZieVRlSzMxM09VdkpOV3JKcmhKelRHYWxLODZM?=
 =?utf-8?B?WFVsVGNPbjNqdDJCSnBzNHg3UTBkYnRFQlRkaW13NU9vTFdCYmcvblRmT2dw?=
 =?utf-8?B?MjRPcmkzbDFLYm9BQWpGZjJHYmkyUEpDZ2RJTDNaM3FzZlNNaS9xcmxqSEJP?=
 =?utf-8?B?TzIzcWtSVDUwa3IzaWZqQ1VDTTV6VXhwQ0piVjMxWWFRRUg5MjVTQ0F1YTF6?=
 =?utf-8?B?NE1RVzkwWVoveUJjekliR0pCbzBDenNRQUV6cjNXUE9kSEZwNldTdEJMSXBz?=
 =?utf-8?B?VFdhL1cyZVhFTzVKL2RZNEV0N0lVd2JMODI4T2dUcjdMWGdFdC92TkxHUWNw?=
 =?utf-8?B?L2IrcForOHozck1yS2drTmJOcnJHN0JzM1dJL2E2OG5uS28yOU1rNnNncUs1?=
 =?utf-8?B?T0N0YjhMbWxZU0haRkZsSXlsanVNckFURzBCQzYzaXpGS0h1d2VXdjAxMFRY?=
 =?utf-8?B?dEl6V0QzNGZ6ZXU5TzFuZW54K2Q4VzJ4bTRGRW5CeXBHNTRwVkc5bnJiUkpy?=
 =?utf-8?B?d0FNS0FSRGVCMkE4dU8zSWlaODVhQWNGa0hYbnI0ckdwekNEUDAxcHZSRUZp?=
 =?utf-8?B?MTFheEQvUG1BdnZ1VzNXQTN2UEtNYzFwWTNkNlo4YkVhM2RZbkRna0pnSGls?=
 =?utf-8?B?NXF6WmpEQTJsQzFlMlVYUnVBVHRKczhqVHRYdmlaUGkxWjNlK0RaNUpTT2Ix?=
 =?utf-8?B?Tm9sSXNXQnJtYXpnbWZxcHBaQ1k3TGhHZU5ocXV0Ylc0MHNZWHhNc1B6Lytn?=
 =?utf-8?B?U0ZTejVteXgvaElMd0h3QnExckgvYW1HQ0hWUG1ZY25xWDlldzB0eENmSUhR?=
 =?utf-8?B?MGQ5cnUxZGtzUTFIdmp5b1BTdjZPd1p2TnhIRGlQVEhqVm9Dc2tjdWMrbTdo?=
 =?utf-8?B?NzZva0J0UEw1Y0hjRCtWbnVUSVFnblN3L2s2dUtMUTFYYjhNVUZPRHZtSXhm?=
 =?utf-8?B?Z25NaEkyZ25ydEk3cFBKZmZ1V0szVEZPSDZWT2NjdFBaRUJzNTlYN1BnV21j?=
 =?utf-8?B?dG1sRXlERTVVMlYxeUU1bHBKeW9BdEhTUVpPQ1cxc29NSjRXbUJ6ellvKzk4?=
 =?utf-8?B?UTJKUFBXRE9obzNNMzYrcWFDeFplUUJRUzNEbm9OQlplZUFzd0RBanBVemVv?=
 =?utf-8?B?VHFNZ0ZpWDJTUkJ5TVpjelRmN3BuTFQwSmwzNVo4Q3NuQ0REWFY3bjc4aU12?=
 =?utf-8?B?Zmp2VGo3dHd3MDdzWlFXVktSeXgxcnZLVkJVaVRDblJXUXJLaUdZd0E0NnFv?=
 =?utf-8?B?NlN6RklQNlJBaXBta0lGWlJzOE5Da2dRTkl2dkNWVFFhVi9yL1FVQXhIMU9l?=
 =?utf-8?B?Tm1vZGlVN2NkMURpK21NdlNTcFhaNXhNaG1vRDNMb1B4QXFtVHF2TWF5VWM4?=
 =?utf-8?B?MmFPYld2UmpzZEpnMVE0dmZscVhoVi84N0o2cFhJckxXSW5zRmUvcmhqSXgr?=
 =?utf-8?B?VFUvVDBCNUxyeVNTT1JBanNSS3JISDZkMTZnbk9QYXJXR21VYmZKclExdVV1?=
 =?utf-8?B?bjZaOWJxV0hvU0s3V1IyRUFKcVBDUUtIcnFORjhZcXlYSzBaOHA3NUQ0Rk5Z?=
 =?utf-8?B?Q0lBY3NhMTBjZ3JFb2RMLzR6UkE2R0Jld1pPTHd2MTBiMWZSeFo4clcxU0Fi?=
 =?utf-8?B?OGc3cTI4VG9BaFJCWCtRa0dVeSt0UVo4YXl2SGJzMHhab2F1UWkvN0FISXBL?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333111ba-5c20-4969-56b1-08dbc68717c3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:12:52.5669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9sttXt/Z3wW4Q/Rm8CcCUsWbIf2jOltkFA/+8jFOGn8IXzAr6rCsw3jRd9fQnVI/hBksNohFQfkhTd7CH2XTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5720
Subject: Re: [lttng-dev] LTTng enable-event performance issue during active
 session
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

SGkgWmFjaCwKCnRoZXJlJ3MgYSBwcm9wb3NlZCBjaGFuZ2UgdG8gbHR0bmctdXN0IHdoaWNoIGFk
ZHJlc3NlcyB0aGUgaXNzdWUgeW91IGFyZSAKc2VlaW5nLCBidXQgaXQgaGFzbid0IGZpbmlzaGVk
IGNsZWFyaW5nIHJldmlldyAmIHRlc3RpbmcgeWV0LiAKaHR0cHM6Ly9yZXZpZXcubHR0bmcub3Jn
L2MvbHR0bmctdXN0LysvMTEwMDYKCnRoYW5rcywKa2llbmFuCgpPbiAyMDIzLTEwLTA1IDE4OjA0
LCBLaWVuYW4gU3Rld2FydCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+IEhpIFphY2gKPiAKPiBhcG9s
b2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXBseWluZyB0byB5b3VyIHF1ZXN0aW9uLgo+IAo+IE9u
IDIwMjMtMDktMjYgMDg6MjcsIEtyYW1lciwgWmFjaCB2aWEgbHR0bmctZGV2IHdyb3RlOgo+PiBI
aSwKPj4KPj4gSSBhbSBvYnNlcnZpbmcgYSBwZXJmb3JtYW5jZSBpc3N1ZSB3aXRoIHJlZ2FyZHMg
dG8gZW5hYmxpbmcgZXZlbnRzIAo+PiB3aGlsZSBhIHNlc3Npb24gaXMgYWN0aXZlIGFuZCB3YXMg
d29uZGVyaW5nIGlmIHRoaXMgaXMgZXhwZWN0ZWQuCj4+Cj4+IExUVG5nIHZlcnNpb25zOgo+Pgo+
PiDCoCAqIGx0dG5nLXRvb2xzOiAyLjEzLjkKPj4gwqAgKiBsdHRuZy11c3Q6IDIuMTMuNgo+PiBT
dGVwcyB0byByZXByb2R1Y2U6Cj4+Cj4+IMKgMS4gRW5zdXJlIG1hbnkgdXNlcnNwYWNlIHRyYWNl
cG9pbnRzIGFyZSBhdmFpbGFibGUgaW4gYGx0dG5nIGxpc3QgLXVgCj4+IMKgwqDCoCBlLmcuIDEw
MAo+PiDCoDIuIENyZWF0ZSBhIG5ldyBzZXNzaW9uCj4+IMKgMy4gU3RhcnQgc2Vzc2lvbgo+PiDC
oDQuIEVuYWJsZSBuZXcgZXZlbnRzIG9uIHNlc3Npb24KPj4KPj4gVGhlIHRpbWUgaXQgdGFrZXMg
dG8gZW5hYmxlIGVhY2ggbmV3IGV2ZW50IGhhcyBpbmNyZWFzaW5nIGNvc3QgZS5nLgo+Pgo+PiDC
oDEuIEV2ZW50IDE6IDFtcwo+PiDCoDIuIEV2ZW50IDEwMDogMTVtcwo+PiDCoDMuIEV2ZW50IDEw
MDA6IDE1MG1zCj4+IMKgNC4gw6BpbiB0b3RhbCBhYm91dCAxLjUgbWludXRlcyB0byBlbmFibGUg
MTAwMCBldmVudHMKPj4KPj4gSWYgZWl0aGVyOgo+Pgo+PiDCoDEuIE5vIHVzZXJzcGFjZSB0cmFj
ZXBvaW50cyBhcmUgYXZhaWxhYmxlCj4+IMKgMi4gT3Igc2Vzc2lvbiBpcyBub3Qgc3RhcnRlZCB1
bnRpbCAvYWZ0ZXIgL3RoZSBldmVudHMgYXJlIGVuYWJsZWQKPj4KPj4gVGhlbiB0aGUgdGltZSBp
dCB0YWtlcyB0byBlbmFibGUgbmV3IGV2ZW50cyBpcyBjb25zdGFudCAoZS5nLiAxbXMpLgo+Pgo+
PiBCZWxvdyBpcyBhIGJhc2ggc2NyaXB0IGRlbW9uc3RyYXRpbmcgdGhpcyBiZWhhdmlvcjoKPj4K
Pj4gIyBQcmUtcmVxdWlzaXRlOiBoYXZlIG1hbnkgdXNlcnNwYWNlIHRyYWNlcG9pbnRzIGF2YWls
YWJsZQo+Pgo+PiBsdHRuZyBjcmVhdGUgZm9vCj4+Cj4+IGx0dG5nIGVuYWJsZS1jaGFubmVsIC11
IC1zIGZvbyBiYXIKPj4KPj4gbHR0bmcgc3RhcnQgZm9vCj4+Cj4+IHRvdGFsX3QxPSQoZGF0ZSAr
JXMlM04pOwo+Pgo+PiBmb3IgaSBpbiB7MS4uMTAwfQo+Pgo+PiBkbwo+Pgo+PiDCoMKgwqDCoMKg
wqDCoMKgIHQxPSQoZGF0ZSArJXMlM04pOwo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIGx0dG5nIGVu
YWJsZS1ldmVudCAtdSBsdHRuZ19pdGVyXyRpIC1zIGZvbyAtYyBiYXIgPiAvZGV2L251bGwKPj4K
Pj4gwqDCoMKgwqDCoMKgwqDCoCB0Mj0kKGRhdGUgKyVzJTNOKTsKPj4KPj4gwqDCoMKgwqDCoMKg
wqDCoCBlY2hvICJFdmVudCAjJGkgdG9vayAkKCh0Mi10MSkpIG1zIgo+Pgo+PiBkb25lCj4+Cj4+
IHRvdGFsX3QyPSQoZGF0ZSArJXMlM04pOwo+Pgo+PiBlY2hvICItLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgo+Pgo+PiBlY2hvICJFbmFibGluZyBl
dmVudHMgb24gYWN0aXZlIHNlc3Npb24gdG9vayAkKCh0b3RhbF90Mi10b3RhbF90MSkpIG1zIgo+
Pgo+PiBlY2hvICItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tIgo+Pgo+PiBsdHRuZyBkZXN0cm95IGZvbwo+Pgo+PiBsdHRuZyBjcmVhdGUgZm9vCj4+
Cj4+IGx0dG5nIGVuYWJsZS1jaGFubmVsIC11IC1zIGZvbyBiYXIKPj4KPj4gdG90YWxfdDE9JChk
YXRlICslcyUzTik7Cj4+Cj4+IGZvciBpIGluIHsxLi4xMDB9Cj4+Cj4+IGRvCj4+Cj4+IMKgwqDC
oMKgwqDCoMKgwqAgdDE9JChkYXRlICslcyUzTik7Cj4+Cj4+IMKgwqDCoMKgwqDCoMKgwqAgbHR0
bmcgZW5hYmxlLWV2ZW50IC11IGx0dG5nX2l0ZXJfJGkgLXMgZm9vIC1jIGJhciA+IC9kZXYvbnVs
bAo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIHQyPSQoZGF0ZSArJXMlM04pOwo+Pgo+PiDCoMKgwqDC
oMKgwqDCoMKgIGVjaG8gIkV2ZW50ICMkaSB0b29rICQoKHQyLXQxKSkgbXMiCj4+Cj4+IGRvbmUK
Pj4KPj4gdG90YWxfdDI9JChkYXRlICslcyUzTik7Cj4+Cj4+IGVjaG8gIi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0iCj4+Cj4+IGVjaG8gIkVuYWJs
aW5nIGV2ZW50cyBvbiBpbmFjdGl2ZSBzZXNzaW9uIHRvb2sgJCgodG90YWxfdDItdG90YWxfdDEp
KSBtcyIKPj4KPj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSIKPj4KPj4gbHR0bmcgZGVzdHJveSBmb28KPj4KPj4gSXMgdGhpcyByZXBy
b2R1Y2libGUgZm9yIHlvdT8gQW55IGluc2lnaHQgaXMgYXBwcmVjaWF0ZWQuCj4+Cj4gCj4gSSdt
IGFibGUgdG8gcmVwcm9kdWNlIHdoYXQgeW91J3JlIHNlZWluZywgYW5kIGl0J3Mgbm90IGNvbXBs
ZXRlbHkgCj4gdW5leHBlY3RlZCBiYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBhcmNo
aXRlY3R1cmUgb2YgbHR0bmcuCj4gCj4gV2hlbiBhIHNlc3Npb24gaXMgYWN0aXZlIGFuZCBhbiBl
dmVudCBydWxlIGlzIGVuYWJsZWQvZGlzYWJsZWQsIHRoZSAKPiBzZXNzaW9uZCB3aWxsIG5vdGlm
eSBlYWNoIG9mIHRoZSByZWdpc3RlcmVkIGFwcGxpY2F0aW9ucyBvZiB0aGUgZXZlbnQgCj4gcnVs
ZSBzdGF0ZSBjaGFuZ2VzLiBUaGlzIGNvbW11bmljYXRpb24gaXMgZ29pbmcgdGhyb3VnaCBlaXRo
ZXIgdW5peCBvciAKPiB0Y3Agc29ja2V0cywgYW5kIHRoYXQgcG9ydGlvbiBvZiB0aGUgcHJvdG9j
b2wgc2VlbXMgdG8gc3RydWdnbGUgd2l0aCAKPiBtYW55IHNtYWxsIGNoYW5nZXMgYXMgdGhlIHBy
b3RvY29sIHRvIGNvbW11bmljYXRlIHRoZSBjaGFuZ2VzIGRvZXNuJ3QgCj4gc3VwcG9ydCBiYXRj
aGluZy4KPiAKPiBFbmFibGluZyBtdWx0aXBsZSBldmVudHMgaW4gYSBzaW5nbGUgY2FsbCByZWR1
Y2VzIHNvbWUgb2YgdGhlIG92ZXJoZWFkLCAKPiBidXQgdGhlIGNoYW5nZXMgd2lsbCBzdGlsbCBi
ZSBjb21tdW5pY2F0ZWQgc2VyaWFsbHkuIFRoaXMgbWVhbnMgYSBzaW5nbGUgCj4gY2FsbCBhY3Rp
dmF0aW5nIHRob3VzYW5kcyBldmVudHMgY2FuIHN0aWxsIHRha2UgYSBsb25nIHRpbWUgdG8gcHJv
Y2VzcyAKPiAoZWcuIGBsdHRuZyBlbmFibGUtZXZlbnQgLXMgZm9vIC1jIGJhciAtdSB0cDAsdHAx
LC4uLix0cE5gKQo+IAo+IFVzaW5nIGdsb2IgcGF0dGVybnMgb3IgYC0tYWxsYCB3aWxsIGJlIHNp
Z25pZmljYW50bHkgZmFzdGVyIGFzIHRoZSBVU1QgCj4gYXBwbGljYXRpb25zIGNhbiBkaWdlc3Qg
dGhvc2UgdHlwZXMgb2YgZXZlbnQgcnVsZSBjaGFuZ2VzIHdpdGggYSBzaW5nbGUgCj4gc2V0IG9m
IG1lc3NhZ2VzLiBJbiBjYXNlcyB3aGVyZSB5b3Ugd2FudCBtb3N0IGJ1dCBub3QgYWxsIGV2ZW50
cywgCj4gZmxpcHBpbmcgdGhlIGxvZ2ljIHRvIGVuYWJsZSAiKiIgYnV0IGFkZCBldmVudHMgb3Ig
cGF0dGVybnMgdG8gb21pdCB3aXRoIAo+ICItLWV4Y2x1ZGUiIGlzIGdvaW5nIHRvIGJlIGEgYmV0
dGVyIHN0cmF0ZWd5Lgo+IAo+IERvIHlvdSBoYXZlIGNhc2VzIHdoZXJlIHlvdSBuZWVkIHRvIGFj
dGl2YXRlIG1hbnkgb2YgZXZlbnRzIGJ1dCB3aGljaCAKPiBjb3VsZG4ndCBiZSBjb3ZlcmVkIGJ5
IHVzaW5nIGdsb2IgcGF0dGVybnMgYW5kL29yIGV4Y2x1c2lvbnM/Cj4gCj4gdGhhbmtzLAo+IGtp
ZW5hbgo+IAo+PiBNYW55IHRoYW5rcywKPj4KPj4gWmFjaAo+Pgo+Pgo+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cj4+IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlz
dGluZm8vbHR0bmctZGV2Cg==
