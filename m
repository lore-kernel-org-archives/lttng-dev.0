Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B59E7717D
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Dec 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733777102;
	bh=z47kwipq/h+W+xUgzCwau1DmW3hty3F+2MuHw62XnLc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=frlpNsYh7pz6Uu4vBUOa9del8mIVCWP1sTWQH5KhxzfZrhn1A5Grn6PpSfsgWemTN
	 HSPVUGVcqH5/4f6mqYYFMKuVyxe6+SxXFMYN851LY6NPxIey94ijl7iCXIvS6C7HO1
	 cnW54BRbPhoYbuzmuiZjOWWosbhDE7SWGsvzFKn+XUQvX8VJ6MPcuKAudbS1lPal6R
	 p2bpESz0E7B59YaFlM//bKf/UegTbb7138ScbOtfbrrQGdh/vBFvp4SCFvJs+hbmim
	 9pdLWHf0hLZ9HlWzJhQeoSqlXC2sAgCie5hQ/fxiXEstGDgkqJbgaRi6zeESHeBI5G
	 s9Gb00WuP846g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y6YlL1Sp5z1wFy;
	Mon,  9 Dec 2024 15:45:02 -0500 (EST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020080.outbound.protection.outlook.com [52.101.191.80])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y6YlJ6ffmz1wFw
 for <lttng-dev@lists.lttng.org>; Mon,  9 Dec 2024 15:45:00 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9IwnD9MrsrxLJGNJ7iPkjGC3XqR9Wk1+YaYagrnWxvvw+6VtR+FtgaSrgYbJEPw2LYKSi2H5eyOwnLlxRuxUdCqHKb32fhT9hOdwB0ji26Fj4SMvfQhL7+GM0v4RJuGQb9TFEWb+uu7KLVHzpKy7KDNA76/Peulc9IIT3exLEPu5hQYPk1Go5ooQFcCd4+CDM4vcM33ofWxNCv04bQ8j1Z+i+WUCmJrmRW9E/SUYReMUss1iXG4iYJqUAxLH+xD39wqYDO8tFqCCp/F1E6zswErR94Zlq1Q9L2MiOgVjtYrmy6S7PmGJFGOQtuh++OFoWefcTwkBesI5d0YwNxl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGkb5x2n0qWc0vfMTUcpkOvhragNgx9W/82CEwgMoLI=;
 b=BTk7lQOBrTCBrHNMnW5uwn1tjQdRkoicguYFWrqNHLZJ8PUSl07nPp/Gix/MLfeD4v9LKbr9Lnxi60xvvxPONCiWJ8n3FRq96mMGi0vhGvsFn8VuIT/h1LUUFQZPyML8mbjT+xGW7IP4aLUbKVm2onogqH0d63oFvrNUpbJOctMRpZ35w5lhtX51HgLkXNgVdSiiPAAycjDkZ4NhKd2nrQbmunW4l0P/ZDh8xbWyVT9fRV4KnLN4whree6hyqX34OkfDHyDQgbYih+r/e/QH50fSsKQ0u5CE9PYoSE/UPYDqqWoR2f/ASXPfIxz5693vf6tAlDSXruB9191t/b1Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT1PR01MB8617.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 20:44:59 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 20:44:59 +0000
Message-ID: <7338127c-5f0f-4bcb-aeb9-ed29459e2424@efficios.com>
Date: Mon, 9 Dec 2024 15:44:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [babeltrace2] Integration with Wireshark
To: Gige Atanasoaie <Gige.Atanasoaie@bc-s.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <KL1PR0601MB3987E8EC377E357825D82546C2312@KL1PR0601MB3987.apcprd06.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <KL1PR0601MB3987E8EC377E357825D82546C2312@KL1PR0601MB3987.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::26) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT1PR01MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed74364-5209-48da-1be6-08dd189258a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC8zZ0NleW53R3d5Z3dxVU5LSUdRUUVhOHhLOVR1VUhiNnpvZXN2NlI5eGhi?=
 =?utf-8?B?Zy9TdldpOUNKN1VCUUMrS3VaNWhGMkZ0RnpqL1ltczhGdWl2THRsUXBTbjBP?=
 =?utf-8?B?OVhxSU9xcytzT3BkL1hnaVhFejVBYks3T0lHREtlUytYNlkvOGRqd2F0d0Nt?=
 =?utf-8?B?Y2tKMzlWODZRUkZOZkJ2R2IrNEd5bnNtMXN5eU02bW9qMXZIQURXQnFZR3Vl?=
 =?utf-8?B?cEZINmZCUERJQmtSSnJJa212N1Q1ekhCT2IrZ0N2WXlxUjZFcUZwcFhEMUNQ?=
 =?utf-8?B?QmY2VUdFSlM0UE5id1V2ZGZOejM5ZlZYSDlWN2Y1eWovVnY5TU91dllKTlpm?=
 =?utf-8?B?SWZwcDhBMGY5RzNsS3lvSGJZY0xpbHkzV0tBYjVubTF0UWNNaFcvUHZrVzhz?=
 =?utf-8?B?U0JieHFrclNWZE9LNkMwdDBnc1FuUEpMbGF2aDZWNnFvdlJwbHNjMTZCdkRP?=
 =?utf-8?B?S24wbTZJY1VJYlJKeW1OUk5ReDdOUkRWamc4VXhUTGk1RWFreUUwNWlla2hH?=
 =?utf-8?B?MWtnU0dQSHQveEZGb3BtQU1SeTdXNjFNZ1hHZ0Q1cTI4a1JmRFdUdzMxaGdO?=
 =?utf-8?B?YXNwYk9GVkRsS2ZpZ1BnVllGaDlXY1phVERiUm5IekhnQmtUVkhxRmYyRFVs?=
 =?utf-8?B?Wk5UZTJ3UGdLVlpvOVBGQjl3ZjJ1dHlqUmZ2UnZZZ0doc01Wc0RmN0s5dXVZ?=
 =?utf-8?B?akVwSTIxcVhocmE2cCtVQjl5WEtjV3JKQlNtcStURHY4dXAxeldNTEtDaXJ0?=
 =?utf-8?B?U1NlbUZaeStxWCtFdWlpZENxa3BXRGYxcXJxM0dMRzZRNWlvOTF2bHZ4M0U5?=
 =?utf-8?B?eWhCdURYNjFWUzZDYWx0aVNYNm04akZYUC84U1JqUU9Dc0RLL2Z4TGNqZmlM?=
 =?utf-8?B?WVB4TzZCZEtRSEMyUElxSnZqODZuLzJNUWZyT0pOZENyYmIvZ2dGZDZ1UkRU?=
 =?utf-8?B?VDgwenhKWExDMjU5dVEvZEladnVhekZOdXFhcGcyVElWRTFEaE9WL1BRcWh5?=
 =?utf-8?B?aWdaUGwzRnFXSU4xdnBCcWVRcFl6TE12M0VWNDZDUHgvV0tzSUNkNWtFZEow?=
 =?utf-8?B?RG9WSm92MGlMRXV3ZFFjbEsrOGN4b3FhSWF2ZnZYdS8xRkRHeDgxb2hGT3RD?=
 =?utf-8?B?TEFkbG02dEtIK0o3Q0NWTmQ2MGhFM2xNNUlNSktjVXZFOURBNXdzTlowM0VP?=
 =?utf-8?B?anVZRjVvZG9MbWNoWGNud2duc1h0MzUyTHpaalpHbDA1Qk5WREhDNXVRa3VO?=
 =?utf-8?B?VUlabUo4ZDFnNHkvakZJeDZrVGNmemwyalRERFVPTFNuRWNLKzdYaThXeGlD?=
 =?utf-8?B?d01YcjNuY2p0WnMzZ0RGTXVjeTFzNjB4dk84N3dqOVlrR2hPVXN1WGNLT3Rr?=
 =?utf-8?B?NURIdm1rbWpKQURWQUtpeTFjYytyNldXOFM0TWtkcnRvTlFyWDVBNG0wV0x0?=
 =?utf-8?B?TW1UK3Bha0RKUEUyVlhNZXZiTmtyWUU2djRVazRPV01LMHRidHVZSFJLMEdr?=
 =?utf-8?B?Q1N2ekptOGNCZHZPa1Voc2V3TXdUY0ZvQUFwRXpqZ0FzL2VSazd1clU1TFc5?=
 =?utf-8?B?NUk1TEVWZTRtT1RkUEF4Rm5yM2JZaEhSdmM5dFl5KzFGWm9xU2llSlZhZEY3?=
 =?utf-8?B?UDhxQ3Y3RWhZaWhjbEI5TmJMZ0VMRkt0Y2tBSnJucTRXN0tWZHpkbFZOdVNr?=
 =?utf-8?B?K2NlanRuOGpuOWsrU1VKNVRwYm1iY0tzR294RDBqZjZuZ0hkSkhsUTNrQnlP?=
 =?utf-8?B?TnBvdVMzOXYvSWpwQUFTaXdEZDhmcUZkbFl4UWphNGVpL2ZMVTN2WVZEem9i?=
 =?utf-8?B?UjcwY2IxYm15bWd5NnVjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdHUmpnQmNENCtybUJ0TWNlanloSlVQdkg2MWRVNldxbE93NTJZdGRsY09W?=
 =?utf-8?B?SnlRMlR0WFpSUVBGS3FXczE5YjJiZ25DaWo3bm9iMm9YdHhVa0JPSUZ3clFJ?=
 =?utf-8?B?dThsQlNoUG5PaUltOWlGclh3SloxbTNNWmRZTmdpeDh5VmxzeXJWQW54bFZ6?=
 =?utf-8?B?TGN3c0FsMTZDSVJrRXRFano1UG9GbC9zS2g1WEoyU1JqZUJoOXJQQzc4SDMv?=
 =?utf-8?B?MVI0UTh0dFljVE1JWEdyd1dDcE54ODBLblk5UVBVcllUaHh2c1MvVitpNGdO?=
 =?utf-8?B?c2JTbVdpUndyYUxIRXJ1Wkk2VUhZRDEyK1JFYVpST2FMQmhWU2VPeU54Z2Rn?=
 =?utf-8?B?Y2dpMVBXT0JMTkFIUzUvb3pRa3l5dkZIODUyRXEyZVFlOW1ISDFDV2U1VDVR?=
 =?utf-8?B?NmN2czY0cDlwZHh3eUpKYVZieHIwalZlUXdaNFFzQXI5cXJBMWZWMzNhSEIw?=
 =?utf-8?B?THJ6RGE5RHdDeUMvd1hKR3FrcUhrRjNoZjFpUjVwWEx5Zm4yRXF1K2d1ZWRU?=
 =?utf-8?B?SWpNQ0VSdCtMeEQ3bWQ2QkdvcmRKN0FMejVDTTZSaW1DbzVXL0FXUzFaZ0tC?=
 =?utf-8?B?NFdibFowY1htdE1QcEpzVGEycGhJeWVRTFJud3FVdVBXUTRObDFoV3FZWGtR?=
 =?utf-8?B?ME5HQkp6TC9XTjFIbU5lbVFjRVcvaVg3UDdLeGNLTVF0a0FmNHNXNWRLTGhY?=
 =?utf-8?B?WUUrSXFTSGJIWHBSU0xVcmxwSElNQlJBcFVHZDFTUk5lb295Y0dENW1QSjU5?=
 =?utf-8?B?VmU5SzlvMVUyYndENGN4aUUzdzdJQ1hGd2NiVFpyZ0pNTnRSeHBPS3FyS0Q5?=
 =?utf-8?B?bHJoY1llcG03SVJlMUxONmNPbktxT3BSUno2eUlOYzliOGlvRUpzSzJGQkdm?=
 =?utf-8?B?aUx6NVhkZHFGSnp2MThQTkRjRExBVjA0NVhSdXFvVU93K0JqbURZOEp6NlhP?=
 =?utf-8?B?d2doaFBrcmw2OXRtcjBXK0RrNWlLc3hxOWNlUUJ1ZHpIWlEzUkRBdWptR1l4?=
 =?utf-8?B?UlpkbXdSV2hiV0lRcG9scC95MEhrdkdFbFJNUmpzZE5EejZDVEtUVXlJTE9B?=
 =?utf-8?B?enFlK2JYQ1ltSWYwMW00Smg5YVQvaXRrMEtMSnovN2tYL1NjZlNJU2MvbjBD?=
 =?utf-8?B?dWpoTU5qU3ZLV2hnTEFicEVIamhFY241SkVVWnRHUFE5Y2h3aC9vdUcwRXor?=
 =?utf-8?B?L1kyeUhxQVM1aFAxcDdOd0FtRUQyc3FOUE1TYm9kTURZS3NZbmFraURqZ1pt?=
 =?utf-8?B?cHVwNVgwQW1FVC9LS2dXZnkzV2ZPOXNoNDJ1RkJuMmUxS01CTnM2eWh1M25i?=
 =?utf-8?B?Wkt3eXAvR3g4QU9LQUZqSXA3azJ3b05ncG44U3RIZlFFMkNUbDUremhNczFm?=
 =?utf-8?B?bDlUWDFSczFLUiszWGRONzFRd3pNVXFsVWt2Sm8zRzZlN0hpYktkaDh6TDlT?=
 =?utf-8?B?NjlxbVBnb2piaDVWdUpOTVovWDFjQ2V3STZnaUpTVnV3ZWc3SEw4Q0cxVXVz?=
 =?utf-8?B?RjErK3U4WTVGV3FmaGtuQVY5MkhyQnNvMk1RbHplOFJuT1RsNmpibzU1dExW?=
 =?utf-8?B?UmlqWkZleVVVN3MvT21xTnl4SG1WeCtUL3ZWNUtPMHp0MEdMYXgzZFpIbkt1?=
 =?utf-8?B?ZWt5b3VQSmx2WW50ZTI1dG1UbXBFMVM2cmg0L214THI1L05lYzYyMzNmN3po?=
 =?utf-8?B?ZmNrcWJ3MHBmMUFLZnNlZ2FtWWx5aW9HUk9JTUJrYjM0SHlOb09VUFRBcmRI?=
 =?utf-8?B?dVdheEwzWCs0QSt1ZVRja0xjMWJaZ08vQ2RRd3pBTnhkU2hnS3V4c2NsSUpo?=
 =?utf-8?B?MEZhcS9XMXpUbXNXQ3VPK3Zja3VxdnhOODJ5WFE0VWo5SEU5SlFQWTV4VUtq?=
 =?utf-8?B?Z1hxYWZ4amYzZ2ZxQ1ZzZVFqRm43K1ZDU3pFRVA0NFljWUhZcVdKa24zK3FI?=
 =?utf-8?B?MEZQd2hJYVF5VXk5amY2dWplYVhuMDA5V0Q4bmkwZS9QNSt2M05NZkRwNEwy?=
 =?utf-8?B?VGlwVm5yRno1ZTJpSmxpVGJOUEdMRUM4OXVINXR2NzBJUHpORXhFTkhRVTJY?=
 =?utf-8?B?L0dEdnVxdStuK0Z5KzhMRXd0eUc4MHVkWHZkcmVEQlN6cDdlNGtOaE9VK0Nu?=
 =?utf-8?Q?Z2XOpMT+hnrgv7vqMIXB+6faM?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed74364-5209-48da-1be6-08dd189258a5
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 20:44:58.9383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUUwKCH/uv6Fq7+diaJ8TnYvCyxkvmdnJxzbegGyByjB0uAMLb19KxzBd1YwY+gBc+ksnnTCRMbhNKJA6LB6fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8617
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

Hi Gige,

On 12/6/24 1:48 AM, Gige Atanasoaie via lttng-dev wrote:
> Hi,
> 
> First, I’d like to thank you for the CTF, barectf and babeltrace2 projects.
> 

On behalf of the contributors, thanks :)

> We’d like to use CTF in one of our projects (traces generated by barectf and lttng).
> 
> Wondering if someone tried to integrate libbabeltrace2 in Wireshark plugins (wiretap, epan), to get the CTF traces decoded together with other packet types by Wireshark.
> Is any project of this type known by community?
> 

I'm not aware of any project that does this.

In the use-case you imagine, are you thinking of using Wireshark to 
analyze network packets that contain trace data (e.g., from lttng-live), 
or are you thinking more about opening a whole CTF trace with Wireshark?

thanks,
kienan

> Thank you and best regards,
> Gige
> 
> Confidentiality: This e-mail and any attachments are confidential and may also be privileged. If you are not the named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose, or store or copy the information in any medium.

