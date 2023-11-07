Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD1FC4167D
	for <lttng-dev@archiver.kernel.org>; Tue,  7 Nov 2023 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1699372643;
	bh=W8R98zVD8Hrl3SHJSCWq9lln03ro1t5y05Ui0Eeo8mI=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=R6vNccmXDo7SQn8O8w6mFysW2PN8Zyg/Eac+g7F94aBC+hjkn5kDEHF5nU7/1RnD+
	 hreXHy1TAIrvlxFk39UOvMXdmO1U5XeUwLkdZCOgMozmy+RcaEbtVuEC/4y3gbJmEf
	 99ID6hNNC3cnjLmYG8W2BuRAn6gjXa175OsvetW9zHKnfVi4T9mBcUEOkuTv3d07kX
	 wTpC8VBnnzYJBkPdoOloapGyCcgp7x9zALzsMihlPeHSjeXAj6S3Y7w11UrWc265TQ
	 9mM+QwIUVGkxnUbEmbbiMn+IhQmb5/GupGXatXPY0tXFz+/YkZro8wZai2DkJKlACl
	 mzCVaiR76EqZw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SPtC65YLrzDj7;
	Tue,  7 Nov 2023 10:57:22 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2072.outbound.protection.outlook.com [40.107.115.72])
 by lists.lttng.org (Postfix) with ESMTPS id 4SPtC351mNzDj4
 for <lttng-dev@lists.lttng.org>; Tue,  7 Nov 2023 10:57:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjqTBlSycZmDeRwa/vqiXMKVqGv4iWLMZXwhwEJ2yMxamp0ZJJqOD9QZCBBs9FgATFw/nDwEDXHiodnUxRLYktvFE39LSXCSYOuyRH/NoiVQtxMYXrQRipL2sZtlW9dr0tEBQYx+ehmkjC14L9EtnWNWpX4vnHzCfI+KoDazN/x07LqPvIIvlk/M5hu+Tb0fhkNUtgkap3xj36nBM072kHj/NDswv47U3zishp60uS17oJpQ+Vb99z2Jcr7RUuMv/SiigrvfnN6TlsD8qLL7NZ/6WLHLl+RXXQQSy4kPAyW96qbKHGqIXVW6ewETdkrbWZROdHoP7Jx51VHVhn11EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dLIqsfw5sOiq/RaVLJ0dvkDjADwiWypwPO0GArxKn4=;
 b=MLjadZpagkFpdsVpwz61SqGnNs9GhGiNwM42NMtFFuW4dXYHvraR8IPbcAiHe8tLJuSORtkEdNjhECH7kBJLzMnpOkCpwHle+sLTYDSBpPETPSNltxeeloaszjlWGiZfy9FjhCmGlWsMgwdKZC3pXHkKynlF6TDu4ggBnGvJPmPOQmQPG7r0yOH5aKuhIg1M7SmRd11DbzKw7qTXa6v9pgG9s+ldS1DEZjIZINOWN/XNIkovyK5lACKyGG2rcEta4x0tZB7kHXJAXd8J2oFhekH42AktmQZXkkl1kv6a5rkK83QUHkpndjlfumxZjK/jrcY7rRrmtuwG716dWfqJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQBPR0101MB5343.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:41::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:57:17 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5b19:d4b2:5ca1:9fa1]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5b19:d4b2:5ca1:9fa1%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 15:57:17 +0000
Message-ID: <191bdafa-e05e-4925-91a6-62c511d10744@efficios.com>
Date: Tue, 7 Nov 2023 10:57:13 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Seidl, Aron" <aron.seidl@zeiss.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <AS8P190MB10771A3EB2AFC92E4540399E88A5A@AS8P190MB1077.EURP190.PROD.OUTLOOK.COM>
 <a822b4bf-47a8-4396-a82e-af8589e165b8@efficios.com>
 <AM9P190MB10759C317F92C6DF8CE429B688AAA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P190MB10759C317F92C6DF8CE429B688AAA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: YQBPR0101CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::23) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQBPR0101MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9e06bd-4315-46b4-800b-08dbdfaa375a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUBzJBQ7rz1ubHzeWAUIauWWN4N4p8h3zCrdb8pnO5gDS4qLMhbl4ec3dh0jLLiRElASQOMTeTecJRBgYu/JDvC5fnBHe4WutEMqAGBzIqJMGbcvHn8PTvBngUUP+YZNqEIlnImajgseU3xAi5NbJGfw419C0mxdjYP43XiM7zrZHJXBuGkS/DVQjkf8IZlxEZb2LBU6raVOxGr/VY0MLRyiPPoIryGMGfDkXndDJwXtp+qbX52ODt549ytAiOkW+HXXWoE6cq7iWkuR6t1cuMiim4LBo8IGvt+scyJ0IfLufD/4GYNMPxrfAemWTAKcJl8xbzeeszit8hBnmmUtRjBSBUuTgxmALWCdXeizx0K831qnFefSK1WINC5EyKNhBrZ4o1bJwATi/cxGaF2iwqSbdQ67xXBXX/9FpZ2Tqp3Pza1eQgpMEGbXObaXNkMgKCJatQtaIo1KfCbVX6K6IVBSikIRO4J12yNhoqFeeCrZTk2In9uN84IrNt9vn0zdG3hjSIl/DcOIJD6DFPbFBCinh3Kmn/um+4UIssaLlAsKrkKg8w9C2WlCp2iqjeP9WcM2NFQMuornL0nQ8v4O3HrpvdlXT7nvT1jOZO0/M40tChizX94puL17EllLq6halrtEiUHU5wf3EzTixeckVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39830400003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(53546011)(110136005)(478600001)(6666004)(6506007)(6486002)(6512007)(26005)(66946007)(2616005)(66476007)(38100700002)(66556008)(5660300002)(86362001)(2906002)(8676002)(4744005)(36756003)(31696002)(41300700001)(8936002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBpTGZRQTU5WmYzc1YzYWJaZ1dxYjUwWkxQVTZJV2MvOGF5OS9uZUN2S3dV?=
 =?utf-8?B?YUpKWjlzdmFQSHJYNyttNE9zMjY0VkphS3pnTmRzdW5UR3JEL2M5K3Nrcytr?=
 =?utf-8?B?U3FiZWY3THVobm5vVy9Gc1Jlb2V3SHdGZzdMOGtmN1Y5KzF3MjNOYnlhb0k4?=
 =?utf-8?B?UlF3dXFlU09BT1RFSVpWV0VHMmpaaVA1bkRNbXlkTy80TjNiQ0wyRThuRGts?=
 =?utf-8?B?NVlUeTRIN1hwd0hieUw2OWQrMWJsOFArd0NhY3pTTVo0N3RHM1RYL1I3Tlda?=
 =?utf-8?B?SkdvN2w0TkIxU25ITUJZdk53bU9IZ2MrWnhOZk1YclF0Q2lsb2Q1NndQK25U?=
 =?utf-8?B?cWNBTlBzUGFraEQyNDBKVkEwSkJXbXVUZWFPc2RaMkZtME14eGVnMHlxU1B1?=
 =?utf-8?B?TmwzOFh2TUJKM01kK3VMZHp5TUtBRUF3RHZ6V21Ua25hZjI3WGowUnh4SVBQ?=
 =?utf-8?B?a09vYzlmdHBlNk83UjRRdlQ4QUJieStULzNhcGFCL2VwNGg3YXlzRlc5WWdB?=
 =?utf-8?B?YmsrS0haUHBNR1VGVTEraTVhTmplMU9kbzBpU3luVHJXR0dqblR0WGRBSXpo?=
 =?utf-8?B?Szd0c043MGVqY1ZIT0xQWGxIVXEvT2JPY0FPNFRVV1g3aTBoVmlpL3V2ZG8y?=
 =?utf-8?B?ZVRPekljWXJTVUFkM3EvdzN1YVJUSlY0NlJsTEFCSUtXcnFMTXFMV0RPNDlx?=
 =?utf-8?B?cFBsTWc4Vm5vemgxQUY2WnZVNkE2RHF4a3Q0Njl3MHZjRy9LU1EyN1BGZDNI?=
 =?utf-8?B?YkNSY0JHK0EwU0g1bWY2MEdSNUx1a2FpN0NDYnZzbGRFMm9HcjRIOWpURG9v?=
 =?utf-8?B?WEgzNVRHdzVVUTlVRnVyZXdmRlF6Skl4RDdLcGV0WlRwYkpYSW9GQzJEQUpX?=
 =?utf-8?B?RHJ6M1R5QnVzb2VybjF5OFE1YmJoTVpycUdIOFJIeDZKYU03ZUtmc0pvditx?=
 =?utf-8?B?cG9YbWJpS2JXbS90TndSbkV1b1d5VHRib2FSbWM3azQvelNTVEhpWTN0QVhn?=
 =?utf-8?B?S1U3QnlLQ1hhVmdwNGdXOGVLUHlXcmJwMlpST0lkRkRWdCs2dGVrYlUvekZr?=
 =?utf-8?B?M3FyYlRtOWRIZTBPMDV0NmJqOXZVYkVSZlZqU2kxZjRpRFhsK0tCQWVmM1Ju?=
 =?utf-8?B?WnI3RndHbmdVTGRHYk1vODVhTmFwSGNlUWc5N0dRODFPcDdFNWduc0R0ZlZB?=
 =?utf-8?B?c0N6bE94V3hFUHlsSVQ3cUJRdlViTUI1WUVxQXkyZ2tkMG1Nb1h4aFAxU2VS?=
 =?utf-8?B?cWMrakRUTHQ4dWVwUGxCS2QxNUpDbys0RDR1emk3WGhUZjRsT2hBOWxpYWlz?=
 =?utf-8?B?a0VrTENOeHpIZ1E4NHFXaGxmdk9VWEE4Z0ZmR1Z0ZnpnaTJmZklXRzhrb1lz?=
 =?utf-8?B?TDlUYlN4VHl0N2VScmk4ZG53S2V4Ykt0YVRSNHp3UDh0Q0VhTWFRZDBnRTJa?=
 =?utf-8?B?d2pSZEEvK2kwNlpnM09UelN2WE43cG9jSlU2eXF5RHJubW1weEpqaDYvWTB4?=
 =?utf-8?B?Qk1kSDVCR2RxM2pHamYwRHJlbXkrVEIrdi84TWlDSjlFL3BBS2hvRXBWOEto?=
 =?utf-8?B?d250OURiSmNpa2hRMnUwU2M1M1JTcHpjY0RjQStRSlB0dkMxNmNvZUlOV0dy?=
 =?utf-8?B?ejM2YitEQWVqcjFvNDgxVnd0bjl2WW93ZjMySnZTK0RQSHdHYldoK1hKREpD?=
 =?utf-8?B?SERtTnVwRnFFcHpGRHkyU2p6OVltK3diOVpTRElBRWlLMTVmNUIyK3FneTln?=
 =?utf-8?B?eUZpek1uaHVOOTNSRERvN0poMXJKUGlWSHJSVEJqazRocFlOR0pndHJNNXRP?=
 =?utf-8?B?cUdrQkVJckI3eXZBZ2ZyMEo1T2l3cDcwWDhWVGE5cHJiOFZOUXRpR1gzNGlT?=
 =?utf-8?B?S3U3MEJkVlM0ZVJMZlJWelBRWlZMd2EvTGNOU3VJYWtVdFcyVDk2aXNoZDdR?=
 =?utf-8?B?SnhRSTVhTVIwWUxFUTRTOWN0cDFuMkpXKzBidm9HSjNRWkt0cER2TkF2UHNr?=
 =?utf-8?B?RnZCRDZHNWRCZnNyemEzanA1KzJsZy9JMVlvTzBQZHhoMWw3WklxbkQ1TGJX?=
 =?utf-8?B?Y1ZFVkVIejQzZ0dHbk1ENks4NmhhU2FacGcxaG13TmUzU1hXcVVDK2Vrd2xV?=
 =?utf-8?B?MEJFQkpnNDc3dTRFS3dVN1RYTFdxZ3dLZWxhbmJkWVFmMFNreVJ0V3dSYldn?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9e06bd-4315-46b4-800b-08dbdfaa375a
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:57:17.0928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLO/xVyfpFL6SfC2nBSaxGtdM15x4D3XpHyd856mI0DmCOdNQBXLjFUA3v1BtA8VuQ0MIcxDHKW9XFaplMHRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5343
Subject: Re: [lttng-dev] Building the Babeltrace-Libary for Windows?
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

On 2023-11-06 02:43, Seidl, Aron wrote:
> Hi Michael,
> 
> Thank you a lot for your answer! I think I can work with that.
> 
> I set up the msys64 environment with all the packages that I need to build, except for glibc. I ran the script and as always does the build process fail because I can't install glibc in this environment.
> Even building glibc from source fails, because the system is not compatible.
> 
> Do you guys link babeltrace to a different C library when building on windows, or is there a way for a possible workaround?
> I'd be super grateful for a little more help!
> 
> I wish you a nice day
> 
> Sincerely,
> Aron

Hi Aron,

I would need a lot more details on what your are doing and what the failure is 
to be able to help you. As for the libc, it is provided in the base MSYS2 
environment, you shouldn't need to install it.

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
