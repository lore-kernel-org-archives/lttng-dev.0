Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4169C4829A
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Feb 2024 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707840203;
	bh=zfssnMcPLqsjRJ+B12xhKJx/k8477uNyMVysmTcRKYs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KjQD0YDx1SgLCjA5fnJk9CP+uFIOd58yNZqXEFcwvJqunx0AGrWuCCkYtukee4Ax8
	 VuCvF3SHMjDS7FLeVT3wHO3tA6Ah4QPYrcBgC1Ao6rrIMolo9zBJ6TfSVOBwx0ibAG
	 L0KrB/x4W/pKRJFagjBIYgD2VTnVqYA4Ix+faTiwgslE6WKIN0j34ykaOsazTsrQI3
	 uQwM+auA5cq6wuP+3jAVCg1R5ee+ef0kYpnKrU6jNCsznEjuYaYNaTQm0hfk2xXbbu
	 QCaqjoUwAxG99s6C/mciA7DSJ5iJXchWtV0w7RX82AFWxc4I6pAGnRn57czWuOdnwP
	 jf/uI5iYSPckA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TZ5hq0fRTz22dM;
	Tue, 13 Feb 2024 11:03:23 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2129.outbound.protection.outlook.com [40.107.115.129])
 by lists.lttng.org (Postfix) with ESMTPS id 4TZ5hm6Jy2z22Xb
 for <lttng-dev@lists.lttng.org>; Tue, 13 Feb 2024 11:03:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ3fi83aXX7Gq90wJJgSncCndcVXVEvDdvkEycXCPUIfDfrTjjah3Vcr8ckyWWnl03NhA59n384X2MWWenJI63UFRinoobNiF8SleYMjDR00xjmmfEJOZMkKYNerN/E9k2smi/Y7ySaTb88/r8DiXkwsY+jHN+6/PuXIYFJJpKP1M5px1IzZQqqULRkTiljgwktqHHXFypcuDVO2ag2xNCpfShCwHJflMULpejDfguYUKjcuvlzd+NNOKlrCmgZvR1qexIx4eeceq2Ez8HDHtyORRJxbRVh5WWI3R7/f49WilltfUuTpkfdMDHXUfzHOnuWcUqIk8MGcbOylhQNSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLBdYvdp56vFooNcbiEHIF00UxYT3NbSxU0m94ShEaI=;
 b=RLzt0qGCxsrXeAawv8rkUq0m6NRdKcPqclzQnu24wRXt0G2b8DlWCczuqMLxrYWsbD77uv2S268eP+e5eIpew4b43Ko+Higckk8JUjHyloU6H++owdb8ZGGeoVmsXtQKbeNTwrcMnDNlZRwdFRE6ULLUw2nfYNJztZwlHWTGgYdKB/6RZTyqmGJW7sbJEv+xFIYBJO8jFuJpZcvyD5aeKwHuf0lcJvazWHXXriyrAGAIUO9JQRnxth1kum6c6KEGdFwap1nBwYvbrBgpGYhXVJdMc5eqx/S3uNCUK628qQ/eeKMQgFPJPkYB+V2TPZWPq5dhT2NJviCPAvILlApi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:28::14)
 by YT2PR01MB10666.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 16:03:18 +0000
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e070:101b:efb0:1b7]) by YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e070:101b:efb0:1b7%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 16:03:18 +0000
Message-ID: <dd065a5c-6dc3-4ebd-aadf-f1edace9f3b1@efficios.com>
Date: Tue, 13 Feb 2024 11:03:15 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Lakshmi Deverkonda <laksd@nvidia.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <MW3PR12MB4555D9C015549D882B1FE87BD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
 <3f05e93b-f57e-4d93-be45-c779cd209f44@efficios.com>
 <MW3PR12MB4555080ACAE20ED17F263B8CD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4555080ACAE20ED17F263B8CD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::18) To YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:28::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT1PR01MB4153:EE_|YT2PR01MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: e9595c43-6a2a-4a38-2d28-08dc2cad4b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Gi+Nil6Hddq5W9x8SnIepTiBLAH9Ovz7AQbhoTJ/4NMVaAR4Fzodx5n9H27EBUPvbAifiwUuiA09pFzrP72sw092TXQO/HMzDHbJQUS8/wbpDKPGsm2/2FVc3sKI2FZp2hh/NM4QMYFaNliFQZJLLThjRtcnr6otvf0Cf2DQH+G84qbXXYrda73o1gBVzf63vnUw/cHyB40F56456sxvSZQeJ7TCQZLkZLVyXUNVVUS2bYr+U7+od921MUPep580SJAPlD/kX2hDwhL1BTxcGYmIfNnNS42yToCnV9/byyZ2UCi8zOTBSa+qlbyfpIaCsCudhiFqwN7pO59gbZ8SGHTtEZUbfazJPJfSAqUtp+35Aw+YPOzLGImaKjJBgmsKTYWL6cJM9+Rh/YuptcQEmsWwpoqXVEabdMIzUr95rMkKID57UkHD+cMhsYKWg16F7QH43hmuPt0vypHlbCX45/xMnGYqia0V4SHMr7/9UYOxi/Vm7eF+3yBagI/K4vqeEtsiK1r0HAB2pxPw9pGZ0R13AYjrdcM9GAA3xokr8pnnNRbG1kbzgkUWSDX6Pfx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39830400003)(346002)(376002)(396003)(366004)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(31696002)(86362001)(316002)(6666004)(2906002)(5660300002)(478600001)(6486002)(6512007)(966005)(53546011)(6506007)(8676002)(8936002)(66946007)(66476007)(45080400002)(66556008)(2616005)(41300700001)(83380400001)(26005)(110136005)(36756003)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cklnc3NTM0hjOVoyc3pHNEJ4cWRPYmNoTFJUcm04MHQ3N1hza1ErN0lhd0ZP?=
 =?utf-8?B?MlJ4aFYyVnplb254M3I5ZjZXZkw5a0Q5QjhsWENXeDA2aDZoSXRjeitMTGlr?=
 =?utf-8?B?MnBHOGZtZFRLcjBzbkIxbUtzUTdtQkFaSm9ydmxmSExFMCt5ZVFPQUc5K1Zx?=
 =?utf-8?B?ZVZVNk9ocUlGZEFLaS9EVEQ3MTVGSEVwNVo2WkNHVmFYQlBNZk9ONlZDeXVH?=
 =?utf-8?B?VVE4dzI5Nm9MVDE0dStFcndONVNEUzNIL0VNcHNDbCswb2w0b1Vzd0MxNG5T?=
 =?utf-8?B?SkM5bUpiMzJLdVcrMzk0NUNEYkt1THhRNzd3eThUVFNvMmN3Zzh1ZWM3S1hS?=
 =?utf-8?B?Qzl5ck15TVJXbnBUbkluSDh6MjlFSlVxM2lZVHJDeld5REZVeTNkSGU2dHNj?=
 =?utf-8?B?aU1Fbm9BL2xMUE9rN2drem9DeXo2RGdxOGtvQ3cycFQrQXpPZElJY1V3K0tC?=
 =?utf-8?B?SjBUT0N0R3IzZWRHWE84RkMrcGNCYlA4dkVPTDBVZ0pUNktQZUFsMWhqYXBy?=
 =?utf-8?B?ZWduQ1JQQkEreTk4dkdoY1NBQ2t2V1YzNVdlRUd5dTNaMFhXcy9SaU1vekxS?=
 =?utf-8?B?clhPSDg5ZTdxQmMrYWpCM2JBMGszSjlBbnAwMkR0aVpYV01UK0tQMnNINzBY?=
 =?utf-8?B?K25GcUhDQUYrZFk2VldzYTRlbzFpOUVBd3o3U2c1SHM4N1FCMnNNWStVUGtn?=
 =?utf-8?B?aC84WkZKcXd4QjF0RnJaZE9pTXJVUDhSZG1zRHkyckNJVy9NckVwdXNENmo0?=
 =?utf-8?B?ZWtZbkRwTUxOdVVYTFNJOUtIa0JiZ2d5R3RDOXlQU1UrVWtwcy9wN0ZjR3pN?=
 =?utf-8?B?Mi8yMnUzMHgvL3VlSEE4QW9jYWIxbEptbS9DckN5aHpPalh2UWJidm9Sa2xV?=
 =?utf-8?B?eFpoaVdOKzlYK2V2cU9XWHprVkZBZXN1YWg0SERSNkloaFlCR2RFNDgzcXVi?=
 =?utf-8?B?RitLamxRYlNEOEU0aXJ5eXRBOVFUZ200azZvOVJoK1FQYnZxVE4zM1U4akF2?=
 =?utf-8?B?Nis2NmJIN0lyT2k1cDloUnU5NGJyQ2dXYnM5SE1qOWlXaWlwRjVjM2x1N0pL?=
 =?utf-8?B?NWtjcHc0Y0pUUElocHBBTGtFVDNkSUtURTgzTGN3QnBIQzAxWldLcjNyMVk1?=
 =?utf-8?B?MS9ibUJwc1cwM1B3aTR4enlYa1haYVBvTko3aURaNk1WbUxmQThuTVNQYWdY?=
 =?utf-8?B?allGQXVTOUdpYk1XdEgySWp1djVOZTlmdmhoYVlJam1pMFhaQkFLTUppRDVy?=
 =?utf-8?B?R2I4bWFUZjdhVFpVTi84eUM0VFRwUXRQWjFKWllhSXRha2U1L3NZRWFGODNY?=
 =?utf-8?B?YjBWRFo4bHdwdjByVWJFQlYxTDJrUmc5ODhweUc0V1JGNUM5RnpJdnpSTlFh?=
 =?utf-8?B?U1Qvc3pKdloycjhTS0hqakFVMlJMNG5DMnB6dWE3cEp6VXk2NGhNLzMzb1BP?=
 =?utf-8?B?Yk1UR1U4OUVOT25jblZQd0pDWWhTdFRER0tXUHdhTnJ6TTZWR2c2TnQ5dGow?=
 =?utf-8?B?ZUhEWHVqOVhNczZLc0lKcUpCdHZHbks5TEFLSk9HSTJsRnhQVWluUnppRDZK?=
 =?utf-8?B?aEU2UXVrRVhzb2lxRDQ5WTFOM0x6OVFHUFdJYkp6aG9RVHZUait4QlNTL1RO?=
 =?utf-8?B?MVZYblRrYXRPU29VVUplKzhnNjlWWm1QeVdHRXZuOWpGcmZYTWxYWW8yajhU?=
 =?utf-8?B?UTNOLzNoZGRRNEYvQmEyL3BuU3FIZHZWc0Q1YTZocHZsQkVWc2FsQmxpRTFa?=
 =?utf-8?B?MENmME9CakdBTkdxdG10anlPRVFVeGx5YUtVb2g0M2JpbmlCZFVRdENzcHhU?=
 =?utf-8?B?YjlmV2Q4VExINHZrSGVjd3ZWSHdoNURUaTFic2lXUWpSc0dWNGx3N0hROER6?=
 =?utf-8?B?elBZNVlHOWozc0ZJdEtjMTgxQ3c5S0Yya3lhRFpZcFNqNlBNRWlOSkZRSm5j?=
 =?utf-8?B?RGdwa0NHQ3h4SGU1cTNXYmd0emR6MmFZTnpRZlZ5RDJjS2Z4MnJsTVFOMTZu?=
 =?utf-8?B?YVhtWnl4aEJKQTB4OEoySXlwYzRqNHd4VVBMQlFDMnIyc3U0NUUreHh1NGlZ?=
 =?utf-8?B?QnhHb0NLUGhBTlhXOUVnNUpoSytXK1pDMWlYeTlQczVBYmdwM1EySmk0UW1x?=
 =?utf-8?B?UHlzdWJJTTBuWUNlaUZlTElhMG01RmlKWk1MQ0hEZHlYUVpMRTZlT0Yra2dv?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9595c43-6a2a-4a38-2d28-08dc2cad4b04
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 16:03:18.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6NfRuFZDKvwecYVv3k8iTn/7HNS/y+oC+CipSEnpwnHFED/xrZ+r+WqkjHSgo2gFjj8T4GvTuUYnB6VtnSuag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10666
Subject: Re: [lttng-dev] Crash in application due to watchdog timeout with
 python3 lttng
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

SGkgTGFrc2htaSwKCk9uIDIvMTMvMjQgMTA6MzUsIExha3NobWkgRGV2ZXJrb25kYSB3cm90ZToK
PiBZZXMuIFdlIGFyZSB0cnlpbmcgdG8gam9pbiBvbmx5IHRoZSB0aHJlYWRzIHJlbGF0ZWQgdG8g
dGhlIGFwcGxpY2F0aW9uLiAKPiBUaGUgdGltZW91dCBpcyBoYXBwZW5pbmcgd2hpbGUgdHJ5aW5n
IHRvIGpvaW4gdGhlIHRocmVhZHMgc3RhcnRlZCBieSB0aGUgCj4gYXBwbGljYXRpb24uCgpJbiB0
aGF0IGNhc2UsIEkgc3VzcGVjdCB0aGF0IHRoZSBpc3N1ZSBpcyBub3QgcmVsYXRlZCB0byBsdHRu
Z3VzdC4gSSAKY2FuJ3QgaGVscCB3aXRoIHlvdXIgaW50ZXJuYWwgYXBwbGljYXRpb24gY29kZS4K
CklmIHlvdSdyZSBhYmxlIHRvIHByb2R1Y2UgYSBtaW5pbWFsIGV4YW1wbGUgdGhhdCByZXByb2R1
Y2VzIGFuIGlzc3VlIAp3aGVyZWluIHlvdSBoYXZlIGRlYWRsb2NrIHdoZW4gbHR0bmd1c3QgaXMg
aW1wb3J0ZWQsIGJ1dCBub3Qgd2hlbiBpdCdzIApvbWl0dGVkIEkgdGhpbmsgdGhhdCB3b3VsZCBi
ZSB2ZXJ5IGludGVyZXN0aW5nLgoKSSB3b3VsZCBhbHNvIHJlY29tbWVuZCByZXZpZXdpbmcgdGhl
IGJ1ZyByZXBvcnRpbmcgZ3VpZGVsaW5lcyBhdCAKaHR0cHM6Ly9sdHRuZy5vcmcvY29tbXVuaXR5
LyB0byBlbnN1cmUgdGhhdCBhbGwgdGhlIG5lY2Vzc2FyeSAKaW5mb3JtYXRpb24gaXMgcHJlc2Vu
dC4KCnRoYW5rcywKa2llbmFuCgo+IAo+IFJlZ2FyZHMsCj4gTGFrc2htaQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+ICpGcm9tOiogS2llbmFuIFN0ZXdhcnQgPGtzdGV3YXJ0QGVmZmljaW9zLmNvbT4KPiAq
U2VudDoqIDEzIEZlYnJ1YXJ5IDIwMjQgMjA6NTAKPiAqVG86KiBMYWtzaG1pIERldmVya29uZGEg
PGxha3NkQG52aWRpYS5jb20+OyBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIAo+IDxsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnPgo+ICpTdWJqZWN0OiogUmU6IFtsdHRuZy1kZXZdIENyYXNoIGlu
IGFwcGxpY2F0aW9uIGR1ZSB0byB3YXRjaGRvZyB0aW1lb3V0IAo+IHdpdGggcHl0aG9uMyBsdHRu
Zwo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1l
bnRzCj4gCj4gCj4gSGkgTGFrc2htaSwKPiAKPiB3aGVuIHRoZSBsdHRuZ3VzdCBweXRob24gYWdl
bnQgc3RhcnRzLCBpdCBhdHRlbXB0cyB0byBjb25uZWN0IHRvIG9uZSBvcgo+IG1vcmUgc2Vzc2lv
biBkYWVtb25zWzFdLgo+IAo+IEVhY2ggY29ubmVjdGlvbiBzdGFydHMgYSB0aHJlYWQgdGhhdCBs
b29wcyBmb3JldmVyLCByZXRyeWluZyB0aGUKPiByZWdpc3RyYXRpb24gaW4gY2FzZSBhbiBleGNl
cHRpb24gb2NjdXJzWzJdLgo+IAo+IEkgZG9uJ3QgdGhpbmsgdGhlIGl0J3MgZGVzaWduZWQgdG8g
aGF2ZSBgam9pbigpYCBjYWxsZWQgb24gdGhvc2UKPiB0aHJlYWRzLCB3aGljaCBJIGFzc3VtZSBp
cyBoYXBwZW5pbmcgaW4gc29tZSBvZiB0aGUgY29kZSB5b3Ugb3IgeW91cgo+IHRlYW0gaGF2ZSB3
cml0dGVuLgo+IAo+IE15IGluaXRpYWwgdGhvdWdodCBpcyB0aGF0IHlvdSBzaG91bGQgYGpvaW4o
KWAgb25seSB0aGUgdGhyZWFkcyB0aGF0Cj4gcGVydGluZW50IHRvIHlvdXIgYXBwbGljYXRpb24s
IGlnbm9yaW5nIHRoZSBsdHRuZ3VzdCBhZ2VudCB0aHJlYWRzIGFuZAo+IHRoZW4gZXhpdCB0aGUg
YXBwbGljYXRpb24gYXMgbm9ybWFsLgo+IAo+IFsxXToKPiBodHRwczovL2dpdGh1Yi5jb20vbHR0
bmcvbHR0bmctdXN0L2Jsb2IvMzI4N2Y0OGJlNjFlZjM0OTFhZmYwYTgwYjcxODVhYzU3YjNkOGE1
ZC9zcmMvcHl0aG9uLWx0dG5ndXN0L2x0dG5ndXN0L2FnZW50LnB5I0wzMzQgPGh0dHBzOi8vZ2l0
aHViLmNvbS9sdHRuZy9sdHRuZy11c3QvYmxvYi8zMjg3ZjQ4YmU2MWVmMzQ5MWFmZjBhODBiNzE4
NWFjNTdiM2Q4YTVkL3NyYy9weXRob24tbHR0bmd1c3QvbHR0bmd1c3QvYWdlbnQucHkjTDMzND4K
PiBbMl06Cj4gaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLXVzdC9ibG9iLzMyODdmNDhi
ZTYxZWYzNDkxYWZmMGE4MGI3MTg1YWM1N2IzZDhhNWQvc3JjL3B5dGhvbi1sdHRuZ3VzdC9sdHRu
Z3VzdC9hZ2VudC5weSNMODMgPGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRuZy11c3QvYmxv
Yi8zMjg3ZjQ4YmU2MWVmMzQ5MWFmZjBhODBiNzE4NWFjNTdiM2Q4YTVkL3NyYy9weXRob24tbHR0
bmd1c3QvbHR0bmd1c3QvYWdlbnQucHkjTDgzPgo+IAo+IHRoYW5rcywKPiBraWVuYW4KPiAKPiBP
biAyLzEzLzI0IDA5OjIzLCBMYWtzaG1pIERldmVya29uZGEgdmlhIGx0dG5nLWRldiB3cm90ZToK
Pj4gSGksCj4+Cj4+IFdlIGFyZSBhYmxlIHRvIGludGVncmF0ZSBweXRob24zIGx0dG5nIG1vZHVs
ZSBpbiBvdXIgYXBwbGljYXRpb24ocHl0aG9uMwo+PiBiYXNlZCkuIEhvd2V2ZXIsIHdlIGFyZSBz
ZWVpbmcgdGhhdCB3aGVuZXZlciB0aGUgYXBwbGljYXRpb24gdGVybWluYXRlcywKPj4gdGhlcmUg
aXMgd2F0Y2hkb2cgdGltZW91dCBkdWUgdG8gdGltZW91dCBpbiBqb2luaW5nIHRoZSB0aHJlYWRz
LiBXaGF0Cj4+IGNvdWxkIGJlIHRoZSByZWFzb24gZm9yIHRoaXMgPyBEb2VzIGx0dG5nIG1vZHVs
ZSBob2xkIGFueSB0aHJlYWQgZXZlbnQKPj4gbG9ja3MgPwo+PiBXZSBhcmUgY29tcGxldGVseSBi
bG9ja2VkIG9uIHRoaXMgaXNzdWUuIENvdWxkIHlvdSBwbGVhc2UgaGVscCA/Cj4+Cj4+IEhlcmUg
aXMgdGhlIHNuaXBwZXQgb2YgdGhlIGNvcmUgZHVtcAo+Pgo+PiAoZ2RiKSBweS1idAo+PiBUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgZmlyc3QpOgo+PsKgwqDCoCBGaWxlICIvdXNyL2xpYi9w
eXRob24zLjcvdGhyZWFkaW5nLnB5IiwgbGluZSAxMDQ4LCBpbgo+PiBfd2FpdF9mb3JfdHN0YXRl
X2xvY2sKPj7CoMKgwqDCoMKgIGVsaWYgbG9jay5hY3F1aXJlKGJsb2NrLCB0aW1lb3V0KToKPj7C
oMKgwqAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy43L3RocmVhZGluZy5weSIsIGxpbmUgMTAzMiwg
aW4gam9pbgo+PsKgwqDCoMKgwqAgc2VsZi5fd2FpdF9mb3JfdHN0YXRlX2xvY2soKQo+PsKgwqDC
oCBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvaC5weSIsIGxpbmUgMjMxLCBp
biBKb2luVGhyZWFkcwo+PsKgwqDCoMKgwqAgc2VsZi5UVC5qb2luKCkKPj7CoMKgwqAgRmlsZSAi
L3Vzci9zYmluL2MiLCBsaW5lIDE0NjYsIGluIGRvX2V4aXQKPj7CoMKgwqDCoMKgIEguSm9pblRo
cmVhZHMoKQo+PsKgwqDCoCBGaWxlICIvdXNyL3NiaW4vYyIsIGxpbmUgNzIwMSwgaW4gbWFpbgo+
PsKgwqDCoMKgwqAgZG9fZXhpdChubG0sIHN0YXR1cykKPj7CoMKgwqAgRmlsZSAiL3Vzci9zYmlu
L2MiLCBsaW5lIDcyMzMsIGluIDxtb2R1bGU+Cj4+wqDCoMKgwqDCoCBtYWluKCkKPj4gKGdkYikK
Pj4KPj4gT24gYSBwYXJhbGxlbCBub3RlLCB0aGFua3MgdG8gS2llbmFuIHdobyBoYXMgYmVlbiB0
cnlpbmcgdG8gcHJvdmlkZQo+PiBwb2ludGVycyBvbiB2YXJpb3VzIGlzc3VlcyByZXBvcnRlZCBz
byBmYXIuCj4+Cj4+IE5lZWQgaGVscCBvbiB0aGlzIGlzc3VlIGFzIHdlbGwuCj4+IFRoYW5rcyBp
biBhZHZhbmNlLAo+Pgo+PiBSZWdhcmRzLAo+PiBMYWtzaG1pCj4+Cj4+Cj4+Cj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGx0dG5nLWRldiBtYWls
aW5nIGxpc3QKPj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+PiBodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2IDxodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
