Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE7C27C4F
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Jun 2024 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718719207;
	bh=t2m9vV12rddPCZX0Mcei1T6Q70IGby+wWD2Y6hV+Mmg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=UTKCgcPnU9InaQQ4AIqnQbJWQQ5k0M5lSTSDyXUJL7GcLWCYp6YGXhlIjskF3vPBo
	 IgEDHEsfBiUdvBNIzpgUhULLDSlhNMakuPLEJ8B3jzK8ghLVR7z0ER4zKEJNquBP6b
	 S/dEaBLixE+pJK/C5r40H1rwTNRQvPejMC115M/LaZ24SwOw0B6cTVDO4MAzJLCPVu
	 CJPK2RFWlg14KLtXE9EJqs60dMO4OVniD/HPC1tqdMlXs3/0icJTm6Hzcab25piYyB
	 2Itqw8MFoU16g0iKYNOb3CpVWRm0N3hajqrrVubSN7yWUca+tXhhsdjCOm1B6RqNmL
	 5EOe2uUbNFOeA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W3T0R3sc7z43R;
	Tue, 18 Jun 2024 10:00:07 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2112.outbound.protection.outlook.com [40.107.115.112])
 by lists.lttng.org (Postfix) with ESMTPS id 4W3T0N07whz47c
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jun 2024 10:00:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZtJijBHO8hiH2t40roni++iLkvskKsEBtFI0DsRsvmATq5S3m1U5Lv0Hhn0WSCRxoWTP1PiuoZNjTrEBDPGnRIum4jrSZ6x77333YGSFC12kSloueG+54Gnk+FDwJ+Z4GW4/iqYSh9fcmXkbUr3qJ1Qem8WamFGFF2AMh5t/OBcNSbe3SNGHTRy+Zhqjb2+9Fu09+lSA/8oXR+5yZnVBiMKhYFVxQ95+TtsDCa5kV7sw02R4a7UB1zF/YguLMoh5h17EPIP7hqNc5Jkv9SRdjE2zycwxzXxx0fBYNaqPeYrqSww4GCAIXSYnldKAmFtrRwX5wfbh78RSMMIwf6a3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/RW2r9gSZFX3AmzBpdOG7t53W0NY1eG59VN4WQxhJA=;
 b=MOqgFLKvfobcg/zOSBM6D3mKtWmbKlJTh2qqNIOathqEOqRxIOnSrMKXSfyGn79+0FzQW6xwZg0NbZXnYbCK+BFya0aNryTmk2Buj6pD2HSVjg9I2QJeQ8oZJXzqyGAG9fl1SLGb92zO2gjjPmJQfqEInJ6xs7s/jM/SJ+TZ32ZTo8OmFlosn/UaMYT7wtFnUGJ8y0fGR8bTnqlDy1b3c5OQRWRWTbFeVe+BEP2RGZJUJSv9Yw1NItXdCiHm6PhL9kz+191eEsaxK1rSnlK+UduHIENUlg1WGJ40SH9ebbhcvoi9F8uaHUaV0Re9wyHM+PJFurtge5SIA0fRqHMHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB8970.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 14:00:02 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 14:00:02 +0000
Message-ID: <e55ebc81-d19c-405a-9c7d-26f266ecfffa@efficios.com>
Date: Tue, 18 Jun 2024 10:00:00 -0400
User-Agent: Mozilla Thunderbird
To: Aditya Kurdunkar <adityakurdunkar2@gmail.com>, lttng-dev@lists.lttng.org
References: <CAFV=bv=hp9n8fCxxWjHn_wKQZHyAizDzVbSkVhvjNJSE_LrmEQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFV=bv=hp9n8fCxxWjHn_wKQZHyAizDzVbSkVhvjNJSE_LrmEQ@mail.gmail.com>
X-ClientProxiedBy: YQZPR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::19) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: e661d65d-73e5-49d3-3ec2-08dc8f9ef2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHAwQ3F3UWVaVEE5WVkvTnJ2dXh6U2U2T3ZzcXV1RVd6ZVlTMVV0d3JzWlhX?=
 =?utf-8?B?cFZBQnI2ZVFQMkZEVHFXWWZhZjBJU2lucXdoRmxLS1BhekhaRzlRaVdtTnYr?=
 =?utf-8?B?STBVNDY5WkRJcVVXV21FblVycU0xTkgwU2F2QitnWDhDWi94K2lFZTF2WUR6?=
 =?utf-8?B?dC9pcksxNGJNYWRYNk41TW9SaDI0citkakZrcGZrWW0xVVRyaDB5TFJnejRV?=
 =?utf-8?B?eDVBT1NORXdseXZUdmhkVWVxenQrOUVMVWFYOW9XTmF3cGRmWVRmZTljeDV2?=
 =?utf-8?B?SGJEMjJEZExFZTRDRGw5NjNKMG9VNnRXSE9KWEdCZElvem5mUW12T1B4bjBQ?=
 =?utf-8?B?STRsUzZYSjlNMk1jc2wwOTEwTjFzTVljaTBFeDhUK0tMdWRWaVVUNS9kL3I1?=
 =?utf-8?B?RmFYd3FhM1hzK0x4dSsxV3ZWcEFjQWNXRlNpQlRBak8xMGh2WTVHbDYxZWpF?=
 =?utf-8?B?TDIySXVZSm8zZmsrb1R6eTVzUkhDcWxCazE4UkRjclE3NFdTM3RsTUlrRlhu?=
 =?utf-8?B?aFp5TVJMczN3UzBmSFFTUEp6YmJTT0JLek5waXMxaWxyTmhBbXFJcDIrQlpQ?=
 =?utf-8?B?eFAySElUK0VCaDFmWUJ3UXJ5TDM5WWdXKy94RkZOSlJwaEhpRHRsR2I2bEdj?=
 =?utf-8?B?RGdzU2kxS0VzaHljendzTmJiTFZWVUl0QjJSVkJHbU83eHJoalNLa1NmSldD?=
 =?utf-8?B?YmpwU1hrOSt1V2MwWDBreDljTDdrUThHdkdxQ1M5ckM2TmVOQmI0allNMlVL?=
 =?utf-8?B?RWk1NXJlY3pwTXlvUU5JL2lQV3hYMC9zUGp3enZWZXpVMEFadVVWcUlLTTAy?=
 =?utf-8?B?VG14d2JYdm1YM01xYzlzQ0hIRG9RM243NFBBZHVpaUNPam5iU1ZPKzFhVnpx?=
 =?utf-8?B?SHlaYlh4UU9JTXVkWjZ4cEpZS09tYWEwVlRlRmozYzFDWUNLWlZUengzSnEv?=
 =?utf-8?B?UmtaYVdjbUcyL1loZ2RDSUhER3cyUE51azlYQ0NlYU9hSWUxUEgyeXI0TjUw?=
 =?utf-8?B?UFlQd3J0cGpPM2V1OEhSSmIyTGFNemFvMjlHcTJOaHRGYUoxTkFCVVRCejRh?=
 =?utf-8?B?Q0lnQjJPaUczZVUvNDUxSHJYQjI0RmFFVlk5aGphVktHNVFNcnNSWGxObmp3?=
 =?utf-8?B?dHVhSjBGVXZhMy80V25wVll3UUx2bUF3VFUxTGMveWlDVHJoNDYxS3RhVno5?=
 =?utf-8?B?SjJYbFBUak5FMEEzd2pLaHByMW5qVjU3MndTc0dkSzNjbFZCZGp1cVp2VDYv?=
 =?utf-8?B?MVk5c09RdGFhQytrRGovRC9STTZXSDBxQ2UzWFRNVEJsMnpVTFdyMVNXMWlE?=
 =?utf-8?B?VkhCdXdERk5SQm4yNTE5QlZPY0pkZnlYSU1BMnRkS05PYWpkMU0xVklkc2dC?=
 =?utf-8?B?L2p4MEZXN3pyOWdjOHhseGxJallFSzMvNGZONlFiR1VwRk0yajlkSVVTaXNv?=
 =?utf-8?B?MFlRMk5Fa2w4Q0QwOFl2TGF5N0U4cWxoVlFmOEFLQXdEQlZ5aUs3Tm5Wa3Qz?=
 =?utf-8?B?bkc3STFmempvTzBsSDZjQmNEcEorU0VSYUhlQytxOVlNa0JqN3IyMWhZdTBR?=
 =?utf-8?B?RzJxU0tYRURYc1d1b0swbVVzaHBVeFdCTjZvQ2xyRFBOcjRTR21OWFFvdVdN?=
 =?utf-8?B?cUVxNjg2NXpYclR3Mkt5QVBoRzhDRUdhc3pVNENFTnNQSVM2b3Eram9jbVFM?=
 =?utf-8?Q?zWTJM0n3SDqt4Qi2/Sw/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVF6VjZzWWxzWldrc0JOeDhFK0VxWHpaTlJsbmZjME5FbFkrRmdieldzRk9Q?=
 =?utf-8?B?MDkrS3puclZHd2N3c255L0oydXA2dzAySWxQL3BvMGxpcU5iV0UzbDVEU0Ew?=
 =?utf-8?B?NFlSSExRSjZlZUx6eDRzeGgvV3RlN0FOdzdkMzZ0NEhtRC9PVDVhWkE1cTJu?=
 =?utf-8?B?V1Y1dzFBbXRwUU0rS0V2bmlBSTlXSDYzeks2V3gzYXIxNVEydWpEWnl4Wjdl?=
 =?utf-8?B?WkFLVHpEclVMTXlmMlViVWhOTXRTZHYxUGFyUUorYng2WFA3YlJlNzYxTlhs?=
 =?utf-8?B?SVR3cWVydVUxS1U2WUtvMGU1WGNFN0Zqd3owZGhHN2FvSUdIT1F5YWFuMDBt?=
 =?utf-8?B?dEZKNGFPbEpGdDllV0ZPUEFGUVF5S3owa0ZILzA2SkVDZ1ZhK09hZTNpc1dp?=
 =?utf-8?B?NE9obzl1ZHdJNU5oUWhPRHkvTllIeHl4WW54T2FoWVFXRktWNitkZmZ6cnJv?=
 =?utf-8?B?aVNEa3NNNDlhUHhKOWdxREo5LzlvS2kyQWJVR1RnWHFUYTZsSlhXZExpVU9v?=
 =?utf-8?B?SWJVNTFxZDltSjNqWEQvenZjYnludllNemVIR2h2Y2ZBa2wvYWNJTGZSaUk1?=
 =?utf-8?B?dkFVWEhMZDM1TmJBWmhkcUorZlpjWGNoOTNobzJrM2lSTEJ0WkVZeWZhTlhW?=
 =?utf-8?B?SWNVMUhvbVZwQWRtZ1NFNklGOC9oQ3YwWVFTaDhyaUtZWXY0c3ArRXBaYU5q?=
 =?utf-8?B?L3NiV1FkN1BaK2I4S1JnY0crYkNINmR6QkJUcGRJZDFKbmhkRXpDUVFwY2Qr?=
 =?utf-8?B?N1dpaEpTOHZySkJhcnp3aUh5WkxZZVJrZTJQYmFSVlBzem5zMW5UajVkaG1B?=
 =?utf-8?B?ODVhZ2dHc3NvcGxJa0d0cHBvcmVNWDVOYkxlQjBnc0hhdVlEYjJnT1Q0dlJN?=
 =?utf-8?B?SDIySXdkOGtTK1lIWFNUdzgwVngzckpoUnJpeWU5SjBUQ0JyMm83TDlzZFdo?=
 =?utf-8?B?T0dIdjdydWNJUytMb1pQWGZyYzhoTC9IdXpMdm1rVTRPVXg5VzlYbzUyQkZW?=
 =?utf-8?B?SGdWZHJSTDlPNGhVUmdNV3AvMmRjUXZpZE82TTdUbVVLMC9RWk1hS3l3Uklz?=
 =?utf-8?B?TG43V0FiNm1RN2lZMjBScjQ1Sm9zUTMzczRCOWo2ZDk0b0dSU3EwUnNIU2l6?=
 =?utf-8?B?dnhkRWRaK3VHTnpyYlJpOFBtaFc5ektTejQwTFBIVnBNWmZpRWxPOXExaHNP?=
 =?utf-8?B?TjNnaElUcy9tak50dlNXZ1orY1JvMjdYRVpWVWhlVFp5RFRMVGRYUDV3WTdl?=
 =?utf-8?B?RDE3ZC9PcXArbk5YRnhPa0cyV3VKa2pXQi9taEZpb0c3NGNwVHZMMDJmRHJy?=
 =?utf-8?B?eGNUMUhuMHpOSkhjWkJuQ29JaTdrYXBCbWhVZnVDczZDODhPR1NueURiVG5q?=
 =?utf-8?B?L2JJeGRyOU1DMlpFbnMwQjVmVlFQM2ViYnlMSzRiNUdzZ1ppQTNQa0tNdDhs?=
 =?utf-8?B?dmRMZUova0JyRkhkV2UwQTVqSnhjbDltUE0vclQ1Q2wrSG9IYkRUelZKQ0VP?=
 =?utf-8?B?YVhaaXVBSE42UWE2cGl5WnVxZXNuYmJ5WFVoSmFESmluNG5GNEVFa0x1SVVR?=
 =?utf-8?B?UkE0OTI1NWw1THZHc2drOWJBZXBoTzlwaGVFc0NFRVBWWDViTVp4N3V1ZXZk?=
 =?utf-8?B?cUFhRzdaQnlyd2taMmtUbU90dHR2bStiRzZ4NnF2NlVxaWVLUjNreTBDRWdS?=
 =?utf-8?B?Zi9FVk9JUks2UzNRakVzTWFQUWZWdjJyTExrYVoxaURBRDZPV2Jhc2pmc0I2?=
 =?utf-8?B?NHY4WnRmSVJCZkpsb0lVRkFkV2gyYmdaTUhIajk5K1Nnd2Z4bFVjV3RSMmgv?=
 =?utf-8?B?VkQwdnQvYzJmL2FCL0pPdG5JWkFNQ0tmcHJSTmFQOUlHODMwR3duaGV1WDVX?=
 =?utf-8?B?K0lud3ZNR2lla3N1TkFENDVxVlRpcFptZ3dqQStHUUJNTWRtZGtXYmxKWFFq?=
 =?utf-8?B?TmYrdmtETlNwSlgySVIvUEN3SGZrK1JtUFdqd1Nma1c4eXI1UHRDbGl3MTh4?=
 =?utf-8?B?M3RWQVFWTnZNWWZKZE80dGNsbVZGaVpGVlJ1V3c0b2s2YWdSOU9FWjFsbkht?=
 =?utf-8?B?SHVnMW1WaVJYdmxyQUUvc0JsSlNxWDE1RkhyS0JBbzFJRzI1cGtvWGJnMERE?=
 =?utf-8?B?aUtKWXJSNXMwaXh3Ty9CMm54UlZSWXdVdXB1WWZzYkdGMTJWcytKUDJaMnBn?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e661d65d-73e5-49d3-3ec2-08dc8f9ef2a0
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 14:00:01.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZz04UXwmMcZqorlZYI2HcF00bBG4Mb4o3lYJ/9WKoVxP5Qw5Z+tmMsEtmfrEkftanWptcDUvPL7XtW4WMkd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8970
Subject: Re: [lttng-dev] Is it possible to disable recording the CPU id for
 USTs?
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

SGkgQWRpdHlhLAoKT24gNi8xOC8yNCA4OjU1IEFNLCBBZGl0eWEgS3VyZHVua2FyIHZpYSBsdHRu
Zy1kZXYgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gUGxlYXNlIGJlYXIgd2l0aCBtZSBpZiB0aGlzIGlz
IGEgbmFpdmUgcXVlc3Rpb24uIEkgYW0gd29ya2luZyBvbiBhbiAKPiBlbWJlZGRlZCBBUk0gY2hp
cCAoMUdCIHJhbSwgMkNQVXMpIHdoZXJlIEkgd2FudCB0byBjb2xsZWN0IHRyYWNlIGV2ZW50cyAK
PiBmb3IgYSBsb25nIGR1cmF0aW9uIG9mIHRpbWUuIEZyb20gdGhlIHJlc2VhcmNoIHRoYXQgSSBo
YXZlIGRvbmUgKG1vc3RseSAKPiByZWFkaW5nIHBhcGVycyBvbiBMVFRuZyB0cmFjaW5nLCBjb25m
ZXJlbmNlIHRhbGtzIGFuZCBkb2N1bWVudGF0aW9uKSBJIAo+IGhhdmUgc2VlbiBpdCBtZW50aW9u
ZWQgdGhhdCBmb3IgQVJNIHRoZSBvdmVyaGVhZCBpcyBncmVhdGVyIGJlY2F1c2UgdGhlIAo+IHN5
c3RlbSBjYWxsIHRvIGdldCB0aGUgQ1BVIGlzIHF1aXRlIHNsb3cuIEluIG15IHVzZSBjYXNlIEkg
YW0gb2theSB3aXRoIAo+IG5vdCBoYXZpbmfCoCB0aGlzIGluZm9ybWF0aW9uLiBUaGUgY3VycmVu
dCBiZW5jaG1hcmtzIHNob3cgYSAzIAo+IG1pY3Jvc2Vjb25kIG92ZXJoZWFkIG9mIGEgc2luZ2xl
IHRyYWNlcG9pbnQgb24gQVJNIGluIGNvbXBhcmlzb24gdG8gCgpJcyB0aGVyZSBhIHNwZWNpZmlj
IGRldGFpbCB0aGF0IGxlYWRzIHlvdSB0byBiZWxpZXZlIHRoYXQgZ2V0Y3B1IGlzIAp0YWtpbmcg
dGhlIGJ1bGsgb2YgdGhlIHRpbWU/CgpBcmUgdGhlIHBlcmZvcm1hbmNlIG9mIHlvdXIgZW1iZWRk
ZWQgYXJtIGNoaXAgYW5kIHRoZSB4ODZfNjQgc3lzdGVtIHlvdSAKYXJlIGNvbXBhcmluZyBhdCBh
bGwgc2ltaWxhciBvdGhlcndpc2U/CgpSZWdhcmRsZXNzIEkgdGhpbmsgdGhpcyBjb21wYXJpc29u
IG1heSBtaXNsZWFkaW5nLiBJdCBzb3VuZHMgbGlrZSB3YW50IAp5b3Ugd2FudCB0byBtZWFzdXJl
IGlzIHRoZSB0aW1lICsgcmVzb3VyY2VzIHJlcXVpcmVkIHRvIHJ1biB5b3VyIAphcHBsaWNhdGlv
biB3aXRoIGFuZCB3aXRob3V0IHRyYWNpbmcgb24gdGhlIHNhbWUgcGxhdGZvcm0sIHJhdGhlciB0
aGFuIApjb21wYXJpbmcgdHdvIGRpc3NpbWlsYXIgcGxhdGZvcm1zPwoKUGxlYXNlIG5vdGUgdGhh
dCB0aGUgVVNUIG92ZXJoZWFkIChlLmcuIHNwYXduIGFuIGFwcGxpY2F0aW9uLCBsYXVuY2ggdGhl
IApVU1QgdGhyZWFkLCBjb25uZWN0IHRvIHRoZSBzZXNzaW9uZCwgdHJhbnNmZXIgY29uZmlndXJh
dGlvbiBhbmQgYnVmZmVyIApwb2ludGVycykgaXMgY29tcGFyYXRpdmVseSBsYXJnZSBmb3IgYSBz
aW5nbGUgZXZlbnQsIHJhdGhlciB0aGFuIG92ZXIgCnRoZSBjb3Vyc2Ugb2YgYSAnbG9uZycgcnVu
bmluZyBhcHBsaWNhdGlvbi4KClRoZSBkZWZhdWx0IGJlaGF2aW91ciBpcyB0byBibG9jayBtYWlu
IHByb2dyYW0gZXhlY3V0aW9uIHVudGlsIHRoZSAKcmVnaXN0cmF0aW9uIGNvbXBsZXRlcyBvciB0
aW1lcyBvdXQuIEluIG1hbnkgY2FzZXMgeW91IG1heSB3YW50IHRvIApkaXNhYmxlIHRoYXQgdGlt
ZW91dCBmb3IgcXVpY2tlciBzdGFydHVwIGF0IHRoZSBjb3N0IG9mIHBvdGVudGlhbGx5IApsb3Np
bmcgZXZlbnQocykgcmlnaHQgYXQgdGhlIGJlZ2lubmluZy4gQy5mLiBMVFROR19VU1RfUkVHSVNU
RVJfVElNRU9VVCAKaW4gaHR0cHM6Ly9sdHRuZy5vcmcvbWFuLzMvbHR0bmctdXN0L3YyLjEzLyNk
b2MtX2Vudmlyb25tZW50X3ZhcmlhYmxlcwoKPiAxNTBucyBvbiBhIHg4NiBtYWNoaW5lLiBIZW5j
ZSwgbXkgcXVlc3Rpb24gaXM6IElzIGl0IHBvc3NpYmxlIHRvIGRpc2FibGUgCj4gcmVjb3JkaW5n
IHRoZSBDUFUgc29tZWhvdz8gQW55IHN1Z2dlc3Rpb25zIGZvciBkZWNyZWFzaW5nIHRoZSBvdmVy
aGVhZCAKPiBvdGhlciB0aGFuIHRoaXMgYXJlIHdlbGNvbWUuCgpJdCBpcyBhbHdheXMgZW5hYmxl
ZCBjLmYuIApodHRwczovL2x0dG5nLm9yZy9tYW4vMy9sdHRuZy11c3QvdjIuMTMvI2RvYy1fY29u
dGV4dF9pbmZvcm1hdGlvbgoKSG93ZXZlciwgSSBzdXBwb3NlIHlvdSBjb3VsZCB0cnkgdG8gdXNl
IGEgY3VzdG9tIGdldGNwdSBwbHVnaW4sIGUuZy4gCmh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9s
dHRuZy11c3QvdHJlZS9tYXN0ZXIvZG9jL2V4YW1wbGVzL2dldGNwdS1vdmVycmlkZSAKdG8gcmV0
dXJuIGEgZHVtbXkgdmFsdWUuCgpJZiB5b3UgZGV0YWlsZWQgeW91ciB0cmFjaW5nIGFuZCBiZW5j
aG1hcmsgc2V0dXAgaXQgbWlnaHQgYmUgcG9zc2libGUgdG8gCnByb3ZpZGUgYWRkaXRpb25hbCBn
dWlkYW5jZS4KCj4gCj4gUmVnYXJkcywKPiBBZGl0eWEKPiAKPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBs
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgoKdGhhbmtzLApraWVuYW4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
