Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96317E77188
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Jan 2025 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1736181196;
	bh=q/1ebpJHvZuPa8NgZCWEkUuE/Hv5qmEDwAFv++HhUEU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=OwxKx0S2M4p6NgscyY2awKUeX0UzuYqlOJ9vpCyK1+nvdjxpvTXEuqGnuyc7y0oNt
	 VCyytwWAOlnqrAgVqx9E4qvclRIfiAi0jkJulXpnCj/XIOz/TKhOWEEFLIyhORSCvs
	 Oi8siPNIP9m3HU+0VKHNQRrZH92uiJAvYqggNg/wfZqQlEOUen+v2or2MMcdmYYkXa
	 eZ0i0icE5Ks8OVv+eu65s9y8rAhqo/58mYFejmjJUAHWwrgc/mvxU6mQOQNoIy835H
	 z6vRGzxrRiXie3xKVnBI0cNKwxVKF4hZgnG8uphTS4iyPkL9f2AFppomQKDzn7/TOE
	 67f/VdTifZv4Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YRfqw3cHXz1P9T;
	Mon,  6 Jan 2025 11:33:16 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4YRfqt5bqPz1P9R
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jan 2025 11:33:14 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXN7NlsV72GxcsqRbU9OWKQA2xmWnle7EjA3jdS4eDU1suWe2lIoXfVcax4dRWn9T+2EzI5VDUr7YTZoIAx7WOIK0eslK5N94+Bys/xrlfLjejQawHAKdU2g9wHEE+6tGHXAF0+hp8tfcFICVRf/MSHJXjkYIQx9lx2TM4aUj2qrxt+G57d5bi9QahW+/iopOpZyfe6ULicFPPbH2xXelTyUE9S1Wea5voyRj64ZIMuBOicmUjg70kC1bFsXTCaJPI0dJTmp30oOuNBHW56AVWTqODcv0Fk6r+OGVwhAp5FFU3NQU3QcDZuLd5t7HZjQ1GsCAEnuJ89yea+YfYccyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/1rOyUKZFYG8ad0AE2VIhrZeEXTmgKZaogZ0BNFt1Q=;
 b=AjzrDeWEaNb5MyxpbBtLFGzjJjSL5ILT83UtHIZvbbe2YT2NZwm/is8NPqid0GeoERP8iiZQSIsW08sX70RgOznMzQ3vxVPuS+zYXruY9dHOiqIktKC3mEkKQ0ZPLb0XYsOYqd1Tm2R66CKeO8reao7ePsBafo6w/g31gX+A0p9lpySWErZe0e2lIPFIh4ABTSKerc15pSICAec7zDNq33lujhN3Kow/F+sOlkJZfNrmM3YtdhhLJDBVv7R9laQ04Ju6awjyflgOMTYflFWHBQCJLeAP7GHNfWRmWL18ssDxwydha7vyIX6w1fm93B2R8+nAACidVW783WeNy7e2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB8357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 16:33:12 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:33:11 +0000
Message-ID: <023def9c-ff2a-421c-8e89-b6036fb14668@efficios.com>
Date: Mon, 6 Jan 2025 11:33:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Tracing Ceph with LTTng-UST issue
To: Lina SADI <kl_sadi@esi.dz>, lttng-dev@lists.lttng.org
References: <CAOYL4NkHoS1PBhmC7uHu-oX1hZjAZBWbTTCaJCZg8QBGhg8X5Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOYL4NkHoS1PBhmC7uHu-oX1hZjAZBWbTTCaJCZg8QBGhg8X5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::13) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e07bf1-b6f7-4442-f9ba-08dd2e6fcf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUlZbEErYXJuSmcrdTVTVjIvMTBkRTcwZXZ0RFpXS0NoTmczNXdhZHA5QnB5?=
 =?utf-8?B?Z0ozK0xWa09kUm9DWlc1UXpQUHFwdlBaUFRKSDJmRmd3YTduOEl0VzYrVkYv?=
 =?utf-8?B?Q3BOeUJ3QmU1aVZNbFRwY1IwREZJQXlEYXlBZzRNU09pbS9ZK1hybEQ2anpv?=
 =?utf-8?B?VEVrZDN6cUJITzlSaW45ckRldytwZVJjWnUycW5YWUtLT1pqMzNyRWVhV2lT?=
 =?utf-8?B?cFdsY3I5RmZGd3Ixbk1RQThhdFJMaUlqS2kycUE0dnc4eCtuYjlSQmVOZ0M2?=
 =?utf-8?B?S1JuRmpJK2R2NFZQNFZOcmtzbC9FamFSNWFheEIrQVI1ckpsR0ZRL3UvZjRq?=
 =?utf-8?B?OVRKT3cyWHUzSG1EamQ3eFMwelIrcDdjREJERVJCWXZXczU5ZkJYTUx1OHNB?=
 =?utf-8?B?WjJkRmZTdUV2NFZNdTRzMUZrcllZbHJDVXIzakZ1UWJ3eW1IV3JLME5kdFlK?=
 =?utf-8?B?Wi9ubEFEM1ExRmt4NlRFUXlnSlZIOFZlTlBJcDlNVWJ2Q3lwcG5sQUVkbE5N?=
 =?utf-8?B?aXBGbzRHZXJJVXlvbEluMFpLTi96T2ZraTRtQmI4VUlxRWwzK3EvdnZVREZF?=
 =?utf-8?B?MldJRkdoOUpVT1pOcXgzKzNGeHhsaWllUDg0SGxuMDM4ZEZ2bklyWnFvTzEz?=
 =?utf-8?B?cWpZUTE3ZUN0aUNYVzZYUWxXbThBdjdLd1M5V1d2M2plS2g2dE1oY3FuVGth?=
 =?utf-8?B?YWh1VlIrVFNMamNtT0ZEVTArVWY2bG5jYWRsbU9TRklLamVtM2Nqa3RQZFMz?=
 =?utf-8?B?cHNUQXdnOFNTZER6dFN0SzZsNktmbk5BeW1jaGU4aXEzV0JzZ25nZDNVeVMz?=
 =?utf-8?B?dk4rbzNGWXpQR21pQk4vZVVpNmNXM3YyTG9XZ3JnS2kyVG9kYUhhcnpQVmNX?=
 =?utf-8?B?QTRPOGNIbHFQS2lQVjNZZzBZN21VSCtMRTExT1dNaHZ0enpweGVOeEhGWE9H?=
 =?utf-8?B?Y1h2am1Sc2RRSVJNZFk3Wit3bERtR2JCQnF0dlNpMXNBckl0VkRUalppakpG?=
 =?utf-8?B?ODFXYkM1WTRtcGtUN2lCNGNkZnVlY1B3cGQ5Y3A5Ry9COFg3M1F6WDJVTncx?=
 =?utf-8?B?QmI2M2h0TmtQeEJpMWRhb2wvNVhlcGtUMVBGZTBVbGlIWkgwclhTSHd6Tm1n?=
 =?utf-8?B?SDRtcnF4MklSZkNwWmlRQTdpWDhjeTNueVY1N2FpWlBFK2svTmZMNFAyZWF5?=
 =?utf-8?B?My9VaUUxeEFlL3FjdVMvZ0tPZ3pKZm9pekgvUERxZ3phc3A5dm5vZWFPQi9h?=
 =?utf-8?B?eUh4c1k4Z0xIRWdmei9oazJhS1ZHMDdnMTFMbU5zdG1qZTREajVGdVZ5eTFZ?=
 =?utf-8?B?SldJWXRiYkNPNjB2bCtmUHF5RlZ3TTlXcWZLbkJ3ZHVhVnRGVk9qRE5jVWtN?=
 =?utf-8?B?MmlLekZjM1ZrN0ZXdWtTUWcrNVlTMng0N1hhd3RabEF6VC84ajZRcEpDbkdj?=
 =?utf-8?B?d1NoNmtwWHFpTThGTEZRRlVFTGRHS0Q0YzJGSElFM2VQTTF3ZUxneGV5d3Fh?=
 =?utf-8?B?YzFqN2pjWkxzZFh6TVV1c3lvVk0zbTVwOTZvNmNZOHdpNytnTC9JNmYydFpV?=
 =?utf-8?B?d3dOWGErblp2U0YzcWtLNUtZdmtvWHVPWjNyNlMydWhCbVFzV0o5NWI2b3JW?=
 =?utf-8?B?Y0tleEpyV2ZDOFl1MlJpRFZFbkE0OEJWbkdJN3F6aHZPdnlIaE1ZWk9LOVFC?=
 =?utf-8?B?WWNDVjZValpYdDFiemYvV3pyV2ljLzVzclFSV052ejNwV1VVT1lyNnhyZk5V?=
 =?utf-8?B?MXpUKzEwRVN3VFE0S2VvR29YWUlRZG5FUzViUHc1MXJsMU1HckRkc0YvMzFh?=
 =?utf-8?B?L2JLNHREbkVBNWhYV1JiZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExkSSs3dFVvMXZ3VDM4ZjBISnJvVFhnby9LRVZVUVB2RXpPTFVFcGVqWXBu?=
 =?utf-8?B?TWc3eXdGNWxqZWxoNmVjWkhsdk5TdFdMUUVycFFjbmtwTzdzQmRSeXd3WmRP?=
 =?utf-8?B?SS9uMmd6dzR6WTlhSGgzc0ZrU1dueDMwT0FJQ1dtNm41aFVad1ZOajNJanNU?=
 =?utf-8?B?QUtmd3RPZjR2V1Zjb0tvNGRKOWdLUTBtckRXQkNvZnhzdk1aY1RVSE9JY0Yy?=
 =?utf-8?B?MWNXR3oralJCeHdnbVBmdEF4ZmNVanlaZHREM0JzcEUrUVVPanJVaVFqMU5r?=
 =?utf-8?B?aE1FaS92N1dwVU85VTZtbmx1aVNEaS9GVExEOTdCc2wxNVh3a3pPZWZTb3dr?=
 =?utf-8?B?MmI2a0FoajMzblFNb1NveHNVejBqcEJiVEpLSkVmK2lybUMvZ0h2MFVlZExN?=
 =?utf-8?B?NEVVajl2Uy9aZEhQT0oxcmtXVGtuNHVCWlZWTHBvQm5PZDFNYmtjMFgwVk5K?=
 =?utf-8?B?VUdBaFJDcDJuWnc4dXRTcGR2bmRVbE1KQUNSbFA4clRUVGF1ZlNsUFE2eDdi?=
 =?utf-8?B?TGcvWGhkS1ZJS2Nvc3lBSWJVZWlpUnlOQ3RhaDJnTUVQbko2NnVTa2g1dUZS?=
 =?utf-8?B?L1g4SjR4OUlSTDRRMTdqK1c2TXFFcEc4Z29uM1ZtS0pJTWdLWTdzQyt5RnJH?=
 =?utf-8?B?MjR3SFJBT21GbHpuRTZTb3ZQbGc3amZSdkdoTEE5TDJWcTBJL2M1alZYS1ls?=
 =?utf-8?B?M0ZkZjhjMWVhZ1RXQVpUWTVwWXlndE45VEVtZ0pucnhlT0t0SzE3L0NsUHpU?=
 =?utf-8?B?Vzdrai9JQnVLVWtuVStRaEtmUjBLL214Ty9oVjYzOGJSbk1PTVg2Q1hxOTFx?=
 =?utf-8?B?cW9DQk1MSWJEdTNaS1JyNENwd3Z0VVYwUFZEMlRLT2gwOTk2QnJjTUxPUnU2?=
 =?utf-8?B?aWRzSWY3aW1IQ2FuR1FpNWgyeWlpVlNNa0pZZ1hFTGFlV1MzZnFEZmR1LzZL?=
 =?utf-8?B?ZWVOWUFUaUtmQVFvVnFqcWRCaFZZaXVzYk1xN3htOFdldVYyak1IRmh5ZmMx?=
 =?utf-8?B?UEhObTJMZ2pWcmFFNC9GSTMrM3lWcGpnb2EvRnVjWjhHU1NqbFhtVEUvNmtX?=
 =?utf-8?B?QjZZTDloWUpBMld3a2dVdTh1eFpTUUt5ZlBXN1hKN0xCVkNHUDEwdlQzYURM?=
 =?utf-8?B?Qm9hcXExMzdTSHNhYVgzdDRhUmU5WnFMdUZINmZjSDNvc2U4eFpQNWRQNnZ5?=
 =?utf-8?B?dkxVRmVWVFd2OGdPc3dJa3FkbGI3SHNYR09DeHdqNXZxQk95ZWN4Nm1YWDhX?=
 =?utf-8?B?QlZHNEc5MCtDeWE0REVuWGJETi9lS1A2T1ZSZGwvb0dSYW5XcXZvZTdGVkpV?=
 =?utf-8?B?N1JxM3JJbDRac1JkZDlBcDJzbVl5SXF1L3hYelFSOHZSMFZUMlp2MzhydHRl?=
 =?utf-8?B?TUYyY01xWTJvSzVBbFQrWWVKZHNaSS9jRGs1dmFhSHdZYUk4eTc1ZHQ5bjV3?=
 =?utf-8?B?dXY0TktRaWZWSWdZVW9FblE5V1A4T1Nqczd1NjUxWmpHTi9DOVN2MGs3UUVr?=
 =?utf-8?B?SnJya21nQStYSHJ6dmY1QnY5Ny9LZWF6LzZwOXJOa2VwVUpKSUg4VStyZjdw?=
 =?utf-8?B?NFRCS0U0RmRqU3JJUFNFNkVBUDhUZDFxRXNaV3JhMFVlb0pOMWVucWtObTNk?=
 =?utf-8?B?b081TUEwajQzdGQ4Umg1MjhPQ2dtUUR6UzYySWtaTk5VRlBDdzljRnhkMFZa?=
 =?utf-8?B?eHJPVkFibHFoTzkzVVFrMkVHRFp6dDVsOS84cSt4Mjdub251MkFxNjdsUnlH?=
 =?utf-8?B?WlhNMDgwN0xDRnkvYWZCejJtYjBlYmlhV1g0djFXbDB2WU41UGJxOVl3UVpa?=
 =?utf-8?B?aGpIdG5kemRKWE5XMmxiN09WaW0wWndMRUdWTXo0Ky92eDk2cnV2aFFwRFRj?=
 =?utf-8?B?d25iMHFrTHcxQ1Z3MG1PUFhyRmxaQjFZZVlGMEtXd05qSDFJRHVPK0VzZ0hD?=
 =?utf-8?B?NjdnaW9WdG1oN05aSjJLV2ZLU2d0bTVQOFZKTktoOWwrSnpmNXltNWFjUWFR?=
 =?utf-8?B?T2VZaXlxNFdEZEJVLys5MDMwVTNNQlpsRDVmVllCaDBBUlZyVlBuTkJ2djBw?=
 =?utf-8?B?b1pXK043SVNKREc2cmlLNC9CNUFoa0Z1K2IwUEhpeWJFbFZpZDVjUDREak0z?=
 =?utf-8?B?TTB1Vk1TamVadnpLUStqbGxXS2tjM09XWThHZmhjS2g2Q2FmSUpYNGtmblNU?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e07bf1-b6f7-4442-f9ba-08dd2e6fcf6e
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:33:11.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Di6KMJYWPATQJI8+boafWMVDIlbl2GOcMMuU1iHTeiTOkk1uQxcvt4ajdyKol8Aj+2AXAE13tZ7aTumbPFntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8357
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Lina,

I have a couple of questions about your tracing setup.

On 1/2/25 5:14 PM, Lina SADI via lttng-dev wrote:
> Hello,
> 
> We are writing to you regarding an issue we encountered while attempting to
> trace Ceph with LTTng-UST. Below are the steps we have followed so far:
> 
>     1.
> 
>     *Compiling Ceph with LTTng Support*:
>     - We modified the debian/rules file to enable LTTng support using the
>        following flags: -DWITH_LTTNG=ON and
>        -DWITH_OSD_INSTRUMENT_FUNCTIONS=ON.
>        - The compilation process took approximately 7 hours on a virtual
>        machine running Debian 12 with a kernel version 6.1.0-27-amd64, 8 GB of
>        RAM, and 2 CPU cores.
>        - The build steps can be found in our GitHub
>        <https://github.com/KedadsaChakib/ceph-configuration/blob/main/build/README.md>
>         repository.
>     2.
> 
>     *Deploying a Ceph Cluster*:
>     - We deployed the cluster manually (1MON,1MGR,2OSDs). Please find the
>        script here
>        <https://github.com/KedadsaChakib/ceph-configuration/blob/main/cluster/cluster-dep-script.sh>
>        .

With which user a running lttng-sessiond?

When you run `lttng list -u`, what user are you using?

Is that user a member of the `tracing` group?

If you are running lttng-sessiond with verbose logs and/or verbose 
consumers - do you see the traced application(s) connecting?

>     3.
> 
>     *Attempting to Trace with LTTng-UST*:
>     - We tried listing the tracepoints using the following command :
> 
>        # lttng list -u
> 
>        - This command did not return any Ceph-related tracepoints:
> 
>        UST events:
>        -------------
>        NONE
> 
>        4.
> 
>     *Preloading liblttng-ust-fork.so*:
>     - We attempted to preload liblttng-ust-fork.so before starting the Ceph
>        daemons (MON, OSD, MGR) as follows:
> 
>        # systemctl edit ceph-mon@debian
> 
>        - We added the following configuration:
> 
>        [Service]
>        Environment="LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so
> 
> 
> 

Does adding `LTTNG_UST_DEBUG=1` to the environment variables add 
information to the service logs that are relevant?


>     - After restarting the daemons, we executed lttng list -u, which
>        displayed tracepoints related to the libraries (lttng_ust_lib:*),
>        trace logs (lttng_ust_tracelog:*), and state dump events (
>        lttng_ust_statedump:*), instead of the expected Ceph-related
>        tracepoints.
> 
> *Expected Result*:
> 
>     UST events:
>     -------------
>     PID: 100859 - Name: /path/to/ceph-osd
>         pg:queue_op (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
>         osd:do_osd_op_post (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
>         osd:do_osd_op_pre_unknown (loglevel: TRACE_DEBUG_LINE (13))
> (type: tracepoint)
>         osd:do_osd_op_pre_copy_from (loglevel: TRACE_DEBUG_LINE (13))
> (type: tracepoint)
>         osd:do_osd_op_pre_copy_get (loglevel: TRACE_DEBUG_LINE (13))
> (type: tracepoint)
>         ...
> 
> 
> *Actual Result*:
> 
>     UST events:
>     -------------
>     lttng_ust_lib:*
>     lttng_ust_tracelog:*
>     lttng_ust_statedump:*
> 
> 
> We would greatly appreciate any help  you could provide to resolve this problem.
> 

thanks,
kienan
