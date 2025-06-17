Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E9DC71136
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM83X1rW2z21s3
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1750169594;
	b=EHPHGwPQXhowCINSLylcZoo2lLo0HTiqlrL1kbdawH/SD6dkHOT02ce2bt+87dnobId3
	 FfA8Q9co3P7K0U/ojyP4yP1WynSbOyiM6pSyLjdGuVxaUCNuUc46WV33HZ6Bbb31gKLX8
	 IC9+KoGQpbS/G5eJ5eMbfCfk4hVM2ZOiFy7E4hQHcrYp3EFjlwG7VgjgRviihXpViKzGT
	 nRcL6OibFatHg1xm2K7NC1z7NpCP+v2v4peaZQ1NeVf9AYV39WPbNxiiZ7Gs3EvD4YsBZ
	 L0hNRVd2Gq5Luc6uIMmTUM94P1/qtk1smifERpfHhO8NpS+CKYGbjLOe5PYypniuN7w==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750169594;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=cFQUaUw4Vmi2OSi5LxgNZe68+GXtzm0q1nAbitRaf/k=;
	b=UfkqkYJDXKTxvMkYotCYDdmlkcJKtLcAN1cFqqpFiHB8q07BRDEWwetyhFQZDR9haCSu
	 VyXcUI/ndMN1dYlZ0eyMaXd+ubo++JwgmlT7R47pG5cOVmbYMn88AfORQYrxSQ+F7rGwu
	 CDucwzcZ/WGoNhFKCAVuVO1ZTSjELchqrO8cWIm1YsJHE7ig+UdTAlDTIVjvcjPY6PWTb
	 fTinS9XsQUhLrDLLZ+0eeasLOz3sUjaHucJQ31aaD0XIVSTKb5EhxmP+GHnfSS33oVSk3
	 MlFaNB+3YT6tuaDi1mjlEsJgqQ3YspoCAmXnjo3FJnsxdINn/+PiV8buqr7GpwanAPg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM83X1rW2z21s3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750169594;
	bh=cFQUaUw4Vmi2OSi5LxgNZe68+GXtzm0q1nAbitRaf/k=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SIfZsVZb4xx+jkpcxL6uKgNPIQ6zNGQOhBm7OIS6SfCjqU5RQqG3S/Xhx0FfcnYlV
	 uUJEw50LcHrre9ctv8N+TdV7GqdyTQadFkREGO07whRuxA/3Zt2JxJNmQemS5/IXrG
	 IndsrXcpCLPAIPWO1vlCgr6WX4+cSMeamW6pOG/YTZZ0TWMPivG5d2ewphD0neomIM
	 aDlpP1Dry7P5AQe1+1W5+Bo8D67SJjhPt5962hGtZNWznt9eN+FsTehA7z1fa87ewQ
	 cDRu4XJo3amLNJisp79kr9Y0DvExS2WaplkVE6rqs5BZSaQ99UiA05b1XSvmnajs5Y
	 y7Zd0nzu1M3lg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM83X1rW2z21s3;
	Tue, 17 Jun 2025 10:13:12 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM83V0th2z22H3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM83V0th2z22H3
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::716])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM83V0th2z22H3
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:13:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWMxUGCQFn/l7/5QooPAvYF0Ndg9jevcxHyBgotEWwvkpA8LlXrxy58fXiV5D/EumpSWZ6fZd4XINXwKaimdojLvyEzU3wDmj+2Sn/I+Ju2AhbFWwVggjEHSUZMWJxLlWmTacj7ZtEkAE4YrlnKYEFZATXqYlfv1JyGoDDs18JUYF5+knuZpSgplDKTIRsVrFEJHtyDYCLP0QsZQZgJnxkZQrtMxdllmBiop7iXOSYUq03Hgv8zAuqWj0TdX3NFRELD7cRkDzJWhhCnrIMncNnD7CZANGsCkVgSC0GGc2t7ohTiQsyBCmYImkiF9iu1U5zuP3KlU/8VyXLEKKW352Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZb6NDvtRq2QdJ5/bSW6q9ijMA6SsusoHpgLrWTJGxw=;
 b=j6S7SVp3aJInUcb6y9Smh43tBI2Jko8++h2P06WJLhTNhkvWG1G8Eog63OJdgSmaHF9jpDJ8n6y8VMNcAiwkwVQUl08N8trkFNUCUJ6/zWCg3gspAoHVxDlTif2dPrnXO2d8LYrnw1VTuGcPUDhRe7w/Fd22fTYEtuD9KwpKeJs33w6Rpf22Ns2Cn7JZTSx36ZWIrgrX6yj5GvSP/q4jrm/yKBKV6IyxYC23vLiyAFlUT4IG0yRU2q/vZ+3i9JuALwA6AUYJX+U2edlve6AR43fb8KXT3PehLwmyvVc8ddDGXqB2pJe0zaK/LLJ60jIxbuPgMtae+Nq+CpN8nNcUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::22)
 by YT3PR01MB10265.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 14:13:05 +0000
Received: from YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4]) by YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b5fa:c0e6:e5b7:54a4%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:13:04 +0000
Message-ID: <52a0f346-47d4-454a-8696-c5f0be73b43b@efficios.com>
Date: Tue, 17 Jun 2025 10:13:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: lttng-tools-2.14.0-rc1: Not possible to disable babeltrace2
 dependency
To: lttng-dev@lists.lttng.org
References: <CADYdroN6cD9sLE-8QMqFQiVB=RzPFav8owkuihZ-o7JxyK5uuQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADYdroN6cD9sLE-8QMqFQiVB=RzPFav8owkuihZ-o7JxyK5uuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:ee::6) To YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6319:EE_|YT3PR01MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d95743-2201-498a-204b-08ddada9136b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RitqTUs3WjhpNitMeVVhR3lHSXpGSmdZbU5LUEJZNmU0NVdnbk0rQXRFdXdt?=
 =?utf-8?B?T0RocVc4Qk94dWxjWERFS1RzZWNoMFJmV2Frc0lpUkxVVktIak5pYTBaNGov?=
 =?utf-8?B?QW5OZjhLa1pFRGg2VTVjbEs0YkN3RmYrYkF3RUdhaXVKNitITldvbVhwcU9t?=
 =?utf-8?B?SkhiVHNzbjU5bktqM3BTbjIyUDFxUFk3RWhTYTA4MmVlWlExeHpLVjhHSlVK?=
 =?utf-8?B?TFpBZVFkUXc0TUxPTVNIeFZ4TGx2U2YrS1BFT1dGR2ZoSHBxWGFUTkxJL3BK?=
 =?utf-8?B?NUZxS1RKMlNwcGdaV1owWnJFRU5DZmRtNWh3cW5jUDhGRFFqMzNNbEtWVkxO?=
 =?utf-8?B?VDU2TGVHdnMvRmdvWk1jKzVsYnV3UWN6dkxWcUUzbyswWE1mVVlVdXRLejFO?=
 =?utf-8?B?RDhucHp4eC9wNnFvRkpGalJWanBtRjZaNzRERWFTM0FtRTh2SXVWZDhNSGxr?=
 =?utf-8?B?NW1nMzZrY2docnZUeUVVV3VWNjV5VWpnS3FvRWlQQ0tsY2I0bTdaUHBiaDVQ?=
 =?utf-8?B?a2hGL1p4L2ErcktXOHF6VjFGNVVYUmM2Q1kvd1NRRmU0TFdyclN1dkNVbmlt?=
 =?utf-8?B?MVg4V3M2aVUzTE1weHcwK2N6M0l4c2ZjZDBoa1hXNmFReXFwRi9vSlZZVjU5?=
 =?utf-8?B?RDFMRlpjYWZmTTQ1U2ZqV1I0OTkrTW5NUTdFcGJ6cHRsMk16d2srSHRrNkRa?=
 =?utf-8?B?ZEpXSlZoNFpCQ3JzSUtKY0F4NFhmRHBmM1J2dDh6Q3RBdE85WU5pMG1UNWJK?=
 =?utf-8?B?VGxTMmI5azJ0alEzN1lrZFFkZGd5d05JSmwvVFBTanp1dk1EeVJ2MjVvMDJO?=
 =?utf-8?B?eGRqanR5VDVObnlNQUgyTUtQelJWelJXVnM3bGZDR2wwMHVPMkJSLzVJMEc2?=
 =?utf-8?B?SXI5bGZTdWpjV3RiQVhQUGZtdXNvTEhiamN4WEZ4Q09wQmJzMkFvanJhVHZO?=
 =?utf-8?B?M1JWNk9FaDhpa2NWZVZvQ0RySzBzSTlNWEdLVmM0N1diUXVsT0xMMEIwSHJj?=
 =?utf-8?B?SFBLMUhBUnovTjByZnRZbythNGVOdS9TYWZRYzdJemJFcjFUdTQrdXN2aDJi?=
 =?utf-8?B?K215aCtsRFdvTzBRSFFPK1ZjR2N3bVBnMzBFbUlrcHNwU2Rqemx2OHJQS3NR?=
 =?utf-8?B?NEJ1OW5yQjVoRXdsbzJHcDVudTA3d0pYa0l5N0lJQStSa1NmaUIvQXJEdC9a?=
 =?utf-8?B?cWNnMDI1ZUNZU201YmQ0TllRYW1kQ21NSHFnSGtycDFleGlmdzloZnh4b2Rs?=
 =?utf-8?B?Z3B1TytwTmxyMm96SG9xcUM2SVhNSDlYV1RBUElha1owaVM5ZTk5YTlyUHcw?=
 =?utf-8?B?S3Y4NjlIN2RhT3BaSjJzV0xxaEpWR0NOVldPZmNSRkxzODV1bjV2QVQydVJ2?=
 =?utf-8?B?K0ZGS1p6bUM3N3RzT3ZqQnIxejZFNkhPQmVPbHlYeFh3TStjWjdSb0JibWtj?=
 =?utf-8?B?OW0rUlVBYm1rU0hZdExlR2UrTHFUQ1QxOG9ENllncE00ajBuMllybEw3VVVn?=
 =?utf-8?B?VDVzb1M5TTFxMFloKzBtaDhQb3NrSkhqSHJ0MW5oVitzVGtlL1FYVlkvcWZa?=
 =?utf-8?B?c20xeHpFYWUxcmRxdHRvTEMyRmZMWnZPdWhSWE9HcUJGdmIvWHB0QjU0MFls?=
 =?utf-8?B?bnI2T3JnSURKQ2M1MDNiSUVUb2FObmJ1dUluTXVKZ3JIQjMwemVtUkFiWUtY?=
 =?utf-8?B?bHRIT3ovekw3MnJJeER5Ukt3bmtxVVp2bmhxK1ZEeVQ1NXl3WEVkMURkc3pp?=
 =?utf-8?B?cU5oTS9JV0RwRTRvWkwrSHd4RzFkUDl1UHFtSkRnajEySHhCVnhRRCt4WkhZ?=
 =?utf-8?B?bm1HNHZKcmlKdm9EenBobE9QM1FyalhzS1ZwUlRMcU11SmpWNDFCMklMU1Ev?=
 =?utf-8?B?K1VzdmVTUGpiM0hpaFBoR2h6UmV1S016TWY4bThzR250UUNXQVlnT0czRm51?=
 =?utf-8?Q?UeU7cap5mnw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURwK1Q0b202MUJ1Mkk5MEp5ZWtPVVl0TUJBbEVqZkljdjlSMzVXelFLb1lo?=
 =?utf-8?B?cmFDa2V5aElHWThmMnFqcWUwT1dkd2pYazg0cFk3NHpQcDJhU3NMRkxNM1o5?=
 =?utf-8?B?eVY1aTF3Y0FmZmllYWtmaHZxbDJJUnBSSnFxNmY5ZUwyVWJyZ1BnVVR0SThP?=
 =?utf-8?B?UXg2Tlh1TnlwYVVYdloweDEyNm5rdk9LSkxHaVI5MDIzZ1cxNnBBaDVtV25a?=
 =?utf-8?B?TWsxaVVBMmFvOEx2U1VIUUdCMmEzYnlzRmtpUmJ3bllUQmtyQ2ZzVHJwbU5I?=
 =?utf-8?B?eTFHZm5NUThnaVdQSnp5V3BlNkZSUEFXcFVZQ2NpcVQxNDNLMENyTVc0eXdn?=
 =?utf-8?B?T0dDM3k4a0ZPRDBLTTIvaUJpbUp6T2NycXd2MnZEcW16SlRoNWNDRzU4NHZw?=
 =?utf-8?B?T2VBajhsaktGdE5kZ3ZDNmNxcGxmUFBqRm4yQjl3WXRsM3A4b2NhcGdqbzNn?=
 =?utf-8?B?MU1Nc0tvdHNuS0wyNUZQMy93UTUrSW5nYS9FRFl6enNJVDZKTVRRSVB4eGxI?=
 =?utf-8?B?S25aazRXN1FvMzZOeGZSUG12RktkYzNWeUhtUndIS2lxcDVtcWJXUGFCcnZG?=
 =?utf-8?B?RkZnTnNmUnlDL285UXY3czF4ekdGeTl2cjRFanhDY3hSZERmaDlHSmJuWFhY?=
 =?utf-8?B?MVBwUklVN25QdXRrR0F4UDdvSTVEVTBTKzhQYWFBdVo0M0RyNUYxclh5MFBO?=
 =?utf-8?B?dXI2VlQ3TENLTVdSbGlFekFOQ1p6RDFKL0kxeDFoTS9zblVwbFdzU1E1K2sw?=
 =?utf-8?B?eVhabmhhaTRTOElqMW4yQXA5NSttWCtlbDNiSUI5YTlRTStIbGxxVGpOaTBD?=
 =?utf-8?B?S1FIbEJ4dFdBdDJJQ2VWUWx0NXZ0YTYvSVdpY3ViZnZFVStSZ0NZcTh4cU5Y?=
 =?utf-8?B?Y3pLSXd1QVc0Z1c5YU1Vd3lBVmZ5Wm5EcnRuMk1zL25Wclo2MXUxU1F4V3pl?=
 =?utf-8?B?YXBqZGdxMzhRMHFMN0NNdmhPdGczK01NRk0yOEw3ZlVvTC95eloycXpjS01N?=
 =?utf-8?B?UFZ3M2d3VjIzWHhmS1BZVmY4dGRoeXNlZ3hkN2FWa3RFOVlacmVmSC9sMnhK?=
 =?utf-8?B?L01wTXVScHRuRlpLTFlHVzdyYlVxMGkxLy82U1hQTFE2dXVBYWVtVFBGOFNS?=
 =?utf-8?B?SG1hckhML2NMbkFTMEVtSGRRdTI3ZkdyOURkQkExaEkwWmdYeCtJRVhYZDcy?=
 =?utf-8?B?MG40dzZuWjJ3dXNtbmpjUmVqaVA0a3ZubDFKWUtZTm9JMTc3SXQrMDZjdVBk?=
 =?utf-8?B?K3AvaCs2UFZIWDZRWG4rVCtNVGQ1bjJJaTZCdXlTYnVTK1FCU2FhM3NUTUVQ?=
 =?utf-8?B?bkdNNjYzNFlvdnNRVk1NbnJvRHo5eDJheUt3UmYxSzRRajUwcHJLUXdXYkQ0?=
 =?utf-8?B?OGFRUThDQmpDTE5hOFJzNEJMQldWdGVvVGY0WW0yN1hWSHV0Z056SklRTmFU?=
 =?utf-8?B?SlJYdmFiRTFPemUxTHRBVHBSTWlFaDZ2TEZkZnZ1YzlRMU5MQ0JKa05CY2VO?=
 =?utf-8?B?a0ZMOXdoSnFORDMvM1QwZEhqc2JSd0Z6bGlxcFdha0YrWlhNbVN4NVQ4MWQ4?=
 =?utf-8?B?MHZFMDcrMnFVZ0FMTFZDNkF4RzgyZXE0cDdUOThpcVVEVjh6RU9ORGlveERq?=
 =?utf-8?B?dFJmb1gyK0lOMVcrWUQvaDdEdGVZLzVleCtUT01UWjJCc1g5Mmc0dEFDU3d1?=
 =?utf-8?B?MXV6OUlnM0N4Z2lpOVVHRE83M3pqODNja0ZYWmRheTViRlpMc3pScnBkZktk?=
 =?utf-8?B?c3BNUFczUXU0RDhERjlFYjI4d0RlcDFXcHJyZFM2ZlVpZlpNVnhLVFFWaGJH?=
 =?utf-8?B?M290bnFXWXZIcVJKL00rWjdYNkRTWWdOUnZDUjJkTkpBa0s3Y3Jaa0NQTkgz?=
 =?utf-8?B?T3pMZHBvd0VSbzZiUkNJaktjWDVHdXlaVFRXMmgzeUJ0S004Z0wwczBhcFZI?=
 =?utf-8?B?cFZWOWEvRWRvNHJZaEQxdzhSNHkyV3g3THc4S3JPSHQ1VXo5dmhub2tvTmRC?=
 =?utf-8?B?TWwyMTFKTkRlZCtwcktuQjhVMzNaYmtHdWtMSi9tZEZsRHNRUVR2eEV4V3J1?=
 =?utf-8?B?YTBLTjRScGRJWS9YZ2lKOFNkT3pmc3YzYXR3amM0WHhiUjE0NjFTdTR1Rlhx?=
 =?utf-8?Q?EY2yQKCc4osv8u5h82rO7IW3G?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d95743-2201-498a-204b-08ddada9136b
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6319.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:13:04.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9h52rOQtKU9lDOXRnKb08mQrHn8K6aHjQ1MawgFrwZin92kw+8lWNo2ApiNJuzPa9XkQQUOuJgv/LLkAehSpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10265
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

Hi Norbert,

could you describe more about the context of the system you were 
building on, and which version of babeltrace you had installed?

thanks,
kienan

On 6/17/25 6:54 AM, Norbert Lange via lttng-dev wrote:
> Hello,
> 
> I had to add babeltrace2_CFLAGS="-DA" babeltrace2_LIBS="-lm" to the
> configure line
> to be able to build.
> 
> There should be a --without-babeltrace2 switch and possible automatic detection.
> 
> Regards, Norbert

