Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5587BC3DA42
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Jul 2024 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721228127;
	bh=ws2h8vZ4RHOR2WDb0Xvu0FWmJmLx06i8obhvRRqUL6Q=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rOKp/mnyzpbtG2CTYB3OycQWbYKghP8vjZa1q7grUFfyWBzowXESt2Ah0uA+VIcbS
	 mjB8DEpGR+xGsW6EpHL7DFf7wtcihnRdHXeBbzucxCI/JI1peS91vLm2w542gi/art
	 g46eG/389u6nENnlffkEu6vRIscLUe9nqnGnfZSmqpOo9Wge5TaX8VidyHRsLoFAbC
	 D/2iCF/5F2eGQi5jEfufZrIZvDKCf+cQZv9yTO/vAoWG3/MQUQ5EjPKII/raNGEVGB
	 7g7nG7suakDyne/C5KmGMCly+KsA/QQCsFfrYXPGl02onHnXWpGRSRdodCnIza9sS8
	 MoYHuJkCxyaBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WPJrt5hBVz122Q;
	Wed, 17 Jul 2024 10:55:26 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022112.outbound.protection.outlook.com
 [40.107.193.112])
 by lists.lttng.org (Postfix) with ESMTPS id 4WPJrs4m8Zz122N
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 10:55:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xspKlRz6eBJzA8I0S2qzovQRDDZRTnM0MFjRDFECCRnEKSbaD0Sm7UQ1Npyfr5MrBm9t2x5AOa9modhWLFD4R6VXghFN4KlG1oir7Qo5jOF1C7Y56SkaHnRPACU2VSJDIndr2rCK4YgrMGZp6ccApRTiPIdT3yTfM0zFgQH8bFU34se8MBwzL9XXZsl5CGE2CCHOPT4mdhUQ0txMnfsX6/fSkilaSeVEa6i8SEdlSiz3sARKlKf5LQs9Q3i6QR+UqUYeQC95OeknBeoiozKBaJdvXnJEvz2o5KY/+YIe+GLO2nNZXtRsjL7xcR/tkpXWwqOgG8MUHUlnpjT4szP6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y311jJk9pE/jijK1PrHQJYHDj/HX5UGXi2UgmYw03cY=;
 b=PGRCJ7Y27ilC4ckoUNeP+ooBM+MuVWCZ9sQo9W3ewLM7xt/SrT9NjlXqYupWdC7i8Kzqa7s1u2UCHIN+1Os3oMRd2vlS0Fgbf7w3wA0HxuiRbKKB4+fIYYXfpfc1wdpxuMaB7TrSR1JwzCjPHUWizsLuowVkeAExv3KIXd4t8sOOb7JGHCn8cTUdlqBtDVg1pS7yAXn8MPeBXCz07qF6Nq4wihXPTnlxjl9pZ7XmAgQkRMUMsH2ra8kTdZV1op5Qt5gLoyfXhVoKb+/Qno0WIkgGXsn2kPOG/mlU9m4+tAmzUaRkUwhWcJPbcPwiJyxPZsRgP9DWuZKnHqfZJhUoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR0101MB9647.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 14:55:22 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.030; Wed, 17 Jul 2024
 14:55:22 +0000
Message-ID: <5b7fc307-a52a-4e54-84df-294600454686@efficios.com>
Date: Wed, 17 Jul 2024 10:55:20 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
 <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
 <CAHD10Ui_JkP9hRirGUvKBgHhWX48r26+M2_zTyOD_cMLnSDGCg@mail.gmail.com>
 <211e6d9f-834d-4511-b315-7844a5c04824@efficios.com>
 <CAHD10Ugvtu+wKGeRjujGgXbXrEqH-6OKHurJgMyf7CmUVjzRRQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10Ugvtu+wKGeRjujGgXbXrEqH-6OKHurJgMyf7CmUVjzRRQ@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR0101MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbe6e11-2181-407a-d9f7-08dca6707bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnBieFJRbG5ZMFI0RWU3ZW1HazM1ajlkcXNQTkxncW9aTDQ0YURORG1sT3JL?=
 =?utf-8?B?dks4QkdVclhGRWpVcytHMEErbytqZ0svaGRpR1NWcCs5U0Q2N3d2VGc3UFdY?=
 =?utf-8?B?L3ZjVnFHTzArZWQ2dk5TL1RsbFZXU3RIckwyaWYva0EvY1l0QjVJYWFCS2la?=
 =?utf-8?B?VFJBaCtBSS8vUDVOM3VKOW12aGd0VDhRWENBYnJaZTJwN0U2QUVFNCtJakVD?=
 =?utf-8?B?UkxpVUpCNW84cGp4ci9XNWkyU0J3Q1hBUE5zOFMwOSs2R214RzFra0xuMUN1?=
 =?utf-8?B?aTY2SEZFeDhmWnE5aXQwa2tkRkk4djh3by9tVG81VDFNQjFwcmNJbzFmamFS?=
 =?utf-8?B?K0pVL0JPQ3gxZGxxK3hXckZkTjlOOEhsNDFZNVk5QysweTEzdGI0cU9ldTNn?=
 =?utf-8?B?WVdjQThhRWpOM1lRMkVzczZseURxRmFkc0RKaHNIUUxUeS9MWmVTZzJVU3hB?=
 =?utf-8?B?RjF6QTRBcHJpTThwMk9ubEJFNi9MTVZZTEVHS2hQWFp3NGZjR3RSUjdhbkkw?=
 =?utf-8?B?RnJYTEcwM2pzRnU4eHprT0VIQlgyNTlnMkU3QVlyZzhVVVloSUhjVGo0QS9v?=
 =?utf-8?B?VjA3WjJFNlhVemlUWHN0a3Z6VVI4RTE2VE9sWjA5TDdZYlhBTTRyQ0QwKzhE?=
 =?utf-8?B?UUptWDdMQ2FJVG1DZWUydER1WWNKeXV1VFQrajRYOTNKaHdQU0VJOFAwWGYx?=
 =?utf-8?B?cXczdG1POUpmOU9OQVdMTDFQTy96U05ONk9iSFdUczlCdkNDMkw3bDl1UEhK?=
 =?utf-8?B?YXFxVVR2eEQvWTMzTGZpNzduQisyTG52S3RnMC93ZWFnODBydGZiWUFpRUZn?=
 =?utf-8?B?bnFZMEgyWnFSdFk2QS9MYStoU0xwMVJ1NkkvUDlEYVZvME5iTzFtNEM2cmhE?=
 =?utf-8?B?RlRzUTNNeU9haHhkRVh5bVNwV0Z1TWNQR042Sll5bnRXSVptYkRnL0pHdHJu?=
 =?utf-8?B?bVFRSWZBc2pWamJic3pxQVFKYVBWK2NHN0JvM1hnSlVQN21qaWtEb2ZrTlNC?=
 =?utf-8?B?Sm5iTFFBdVZ5TndTelo0aWVBelNUZy85UExiNDR1TjRtd3g1VmY3bFJqWXoz?=
 =?utf-8?B?cDAwZm8wQy81YWJYamluSjJ6NExkQ0RqM3VaUk4vM1R6TmhvVXpFMHc2NlBp?=
 =?utf-8?B?WGVpdTNRUHhmcDV0V2UrR3JINXpsSDd6YW1kZFBSNXBEQmx5UFNOZE0zdnl4?=
 =?utf-8?B?b2o2alN6Q050Z20welZ2bmk1U1NVQUhVUm5Xb0RtREVMU3VOclJrbUxwMWRI?=
 =?utf-8?B?Y0JMK3Y3QkNBeU9xb04wYWFTVzN6dmtBMHZIYTk5aGpRTnpHV05MZDBjS2Zp?=
 =?utf-8?B?UjlLd2RKZEMrY1ZoVXN6YWd0eFdiWjZmK2Fqc3VnUUpPaG5XY1V5Yk5oK1FG?=
 =?utf-8?B?YkYzTkdRZVpuOURtL0pVelhlcUpJdDVSTDMvZ0hlMEZaSklyKzhNUG84Szhm?=
 =?utf-8?B?d3dGODZUbWorb2lUaVRlckVsd1BWMDJKRGhwU2hOTlF1RndERUp5blQxVWp1?=
 =?utf-8?B?NmVPUUhsVFJZTWx0NWY1bHlBekNYMlRjdzVuS3gzb1k1R2JkU0ZHVmZMenNt?=
 =?utf-8?B?L0N6YmdrSGlYM1J3QW9CSHBQa2tnZzdRcVJZM1hETWhiNFZCbmRJV0FuL1lr?=
 =?utf-8?B?ZWN1OTV3WGwzLzFPeVA1Um9pbitvMlF1aXNNL0NZekg5aldUUjFiR0hLNFcv?=
 =?utf-8?B?aDJqNlN5ZHpGZ0ZxT2JyTW9yeTEwQXBxT25rS0pYdW13ZnZNaWk0YmgyN1VJ?=
 =?utf-8?Q?OrHvRDpoNCwADUcDXI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFBcVJYRXlsTERUay8yUk1tV2J6RWdBUys2NDIwcUhRV0g0ZlRJRHdtMENz?=
 =?utf-8?B?ZytuRlRrS1c4SkRYbTZZK00rSmhPdXozeGpNQllrcmwzUXdIYzlMMHF1WVpu?=
 =?utf-8?B?Y1NlQUliTkZOM2ZvTmtLMmN5a1FtdTVyWUVVV2QzMGRkSDMwa0lzVlFyZ2M2?=
 =?utf-8?B?YUd4TFFsbVBYVnpDNmZUOWlKeTJTSWNWSGlTNXQ0VUNqc0tBVHhJbDBac0F1?=
 =?utf-8?B?TnFETWNLN3dBeUNDdk9pTzZoUU9zVVgvbWptbGR0Tk5Tc3Jad05INVBOVFJJ?=
 =?utf-8?B?NGVvVTZUTkVFMXN2NkhUM0tqb1IrZTlWNGJ2TFZTdmVNMVlwcVNxYlV6Rm9M?=
 =?utf-8?B?a2prTlQySVZGb0UzRGRnd3dybGswTitnb09GNS9WVDNaOStVREt2ZkZVa3VX?=
 =?utf-8?B?MHdXc0U1WlA1QUk1V29INFJ6VkdUdWhSYlE4c1c5TitOUEJidjRMcGozdEJZ?=
 =?utf-8?B?MVdyT1I5WE1mT3lheDdLaWlOaTNGSTU1Smh2NFQ4dVNlcW0ydkU0cVhKRXlo?=
 =?utf-8?B?YTlDVW1xa1VneTFSbHZTbmYrZXFGRmoydVJIVjV5elEwQzRoMldPNlF2WGZQ?=
 =?utf-8?B?bWhWaE9EQXdFK00rZnYrTElpbnREQ2JYS05SbmJsZ2E2OUhlQVFuaHlZUFFx?=
 =?utf-8?B?SHhmWTVTUXZGbXBUSzUvRFhndDJQWHFEb0tvNTNKa1g2N1UyK2ZRQnRVY1Zo?=
 =?utf-8?B?Z0ptK0J0czVFN3FtUGxhZm5TcFNqbGxKamdwUG9HYXdBLzZBcUZyK0RWb051?=
 =?utf-8?B?OCtXY0ZKQlNpYnRCZS9jam5saDZHZ3NWeWVGMGFxUUdWUWFMbWpMTmpTWFhN?=
 =?utf-8?B?cFc1T00yWmp2K0tqaDFSWVhmMFU4TTZzLzdQWWgxRlZoQk9JVFoyN2pxcG9T?=
 =?utf-8?B?YzlqTVBXZXVYOE41UGw5QWRrNkRuRWdkbGVGaDhlOWkvd01iZHVsVE5ZZzdD?=
 =?utf-8?B?TFFGZnpmMVJ6dEhWNVdVRExDenpaY0poNHY4eFpVaW5hVUNxUGpJRXdyMk5I?=
 =?utf-8?B?S0k0QUs2ZjdUMkhJWVhkeGF6c3NGK2g3d3podlNSN04rSnAvcUNLVjVWbTBJ?=
 =?utf-8?B?V0NPWndoNkpYVzd1dTRUTVd0MEtxWTB3MitVVTZ1a2Q4YnV6NFp6cllQTU5m?=
 =?utf-8?B?NUNDYzEzejlaa2xtOWZBRGJHdWtCallXTWM5a2h6MW1sTzNCL0hINCtZSEg2?=
 =?utf-8?B?cDBPYXdUcU9ZUTVaUW13bWZSbjl4a0E4WlkrTms5UFdpcEo4VFR5RW5wZUNx?=
 =?utf-8?B?MEt3R2FFdlJlRTZhVmR5alhwbUNGSFFjNnB6ZkU3eWtGQm4zTC9VUjJYZGN3?=
 =?utf-8?B?STAzYkJGaE5JQzBnSGdwMnVDSy9DQkZJeWROSVpiY01NMkxDNXpxaDJsZ2dT?=
 =?utf-8?B?a0hhR0o5Uno1a1lpd01YRkVNNUtMMjIwM1BCd3dkeWhJRjJJOXBLa2xsenhE?=
 =?utf-8?B?NzFWMmwrMWpocnh1ZXFST2FObzl3L1B2SytoZnp0VHkwZmdRK2FoQ3VxcWIv?=
 =?utf-8?B?ZlhxdXB2MkxYbllQQ1hiemsydU1OZy9lcmZHK1FBeW9PandXRGRPMitXUkxw?=
 =?utf-8?B?clUrSDNoTmc5NitTNENlL0FtRkdFREJUSk1MeEZKUExFMHRYZ1pDVDhSYUZ0?=
 =?utf-8?B?WENUekc0NzlNK0pCWHBiMXJJUmFHbkNvS0xpY2xxRjVnNkpocDVhZHN1cGZu?=
 =?utf-8?B?SkFvMGxsa25DcjYzVzI5ZzhoNWtTWFUxdTZkbVNraGxXN01ZZEtPdUlYSkJI?=
 =?utf-8?B?WGs5OVhEaWNKS0ZNZEtKL1l6ZWdVUTRZRWlUTGVWcTJUWCtsSW52bE5RY3Zy?=
 =?utf-8?B?eEFSSEtHNnpBdCs5ZUdoMlhvMlNVUE1zdlkwYnV4MVBEdEtCaG9PQWNFekVr?=
 =?utf-8?B?amdZSjlIOFQ1VzhTVFIzekk3ZWJyRzIzWFdpZDk0cGpIbG4waFNzSkdQUUds?=
 =?utf-8?B?TWkzc3RZR0VSdmVVM2hHcUQ5R25PNWg3TzhKYmkxajhHeHFkajN0VzV1Ym5I?=
 =?utf-8?B?RXQ0RmNhYXMvdUg3U3FaRnBJTXNRZFBZNTZkMSttNXBXUnVUUHkybXozTHhN?=
 =?utf-8?B?VUs2UlA1WmxYSEx5N044NE1hSGNMa2NzSUw2SWF6ZnlUbXM0WXpUeEt3eWJJ?=
 =?utf-8?B?Z2ZsaGJuRFF4KzJUVno5c3Zxc0VFMzB1TzhGZVd3NWM4NlBHU2g4VUFmVlBt?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe6e11-2181-407a-d9f7-08dca6707bdd
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:55:22.5230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI+ntqv5fFNlnChTRxEgwbRTsHkYTGM4Bf/kH1JZggnBc+wbYlbPxM1xWV5vWYJi8im6dDM0iVezKazouErPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9647
Subject: Re: [lttng-dev] loading modules with modprobe
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

SGkgRnJhbsOnb2lzLAoKT24gNy8xNi8yNCA0OjM0IFBNLCBGcmFuw6dvaXMgQmVsaWFzIHdyb3Rl
Ogo+IEhlbGxvIEtpZW5hbiwKPiAKPiBXaGVuIEkgcHJvY2VlZCB3aXRoIHRoZSBmb2xsb3dpbmcg
c3RlcHM6Cj4gCj4gYGBgCj4gIyBXYXJuaW5nOiB0aGlzIHJlbW92ZXMgYWxsIHVudHJhY2tlZCBj
b250ZW50IGZyb20gdGhlIGx0dG5nLW1vZHVsZXMgCj4gZGlyZWN0b3J5Cj4gY2QgL3BhdGgvdG8v
bHR0bmctbW9kdWxlcy1zb3VyY2UKPiBnaXQgY2xlYW4gLWR4Zgo+IAo+IG1ha2UKPiBzdWRvIG1h
a2UgbW9kdWxlc19pbnN0YWxsCj4gc3VkbyBkZXBtb2QgLWEKPiBgYGAKPiAKPiBJIGVuY291bnRl
ciBhIHdhcm5pbmcgaW4gCj4gYC9ob21lL3BoaWxpcHBlL2x0dG5nLW1vZHVsZXMvc3JjL3Byb2Jl
cy9LYnVpbGQ6NzlgIHN0YXRpbmcgIkZpbGUgCj4gLi9hcmNoL3g4Ni9rdm0vbGFwaWMuaCBub3Qg
Zm91bmQuIFByb2JlICdrdm0nIHg4Ni1zcGVjaWZpYyBpcyBkaXNhYmxlZC4gCj4gVXNlIGZ1bGwg
a2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4iIEFsdGhvdWdoIGV2ZXJ5dGhpbmcgY29t
cGlsZXMgCj4gZmluZSBhbmQgSSdtIGFibGUgdG8gbG9hZCBtb2R1bGVzLCB3aGVuIEkgZXhlY3V0
ZSBgc3VkbyBsdHRuZyBsaXN0IC1rYCwgCj4gSSBkb24ndCBzZWUgdGhlIHRyYWNlcG9pbnRzIGBr
dm1fZW50cnlgIGFuZCBga3ZtX2V4aXRgLCB3aGljaCBJIGJlbGlldmUgCj4gc2hvdWxkIGJlIGF2
YWlsYWJsZS4gQ291bGQgdGhpcyBiZSBkdWUgdG8gbm90IHVzaW5nIG15IGZ1bGwga2VybmVsIHRy
ZWUgCj4gZHVyaW5nIGNvbXBpbGF0aW9uPwoKCkV4YWN0bHkuIFRob3NlIHByb2JlcyBkZXBlbmQg
b24gaGF2aW5nIHRoZSBmdWxsIGtlcm5lbCBzb3VyY2UgYXMgdGhleSAKcmVxdWlyZSBwcml2YXRl
IGhlYWRlcnMgd2hpY2ggYXJlbid0IHNoaXBwZWQgYXMgcGFydCBvZiB0aGUgCmBsaW51eC1oZWFk
ZXJzYCBwYWNrYWdlLgoKPiAKPiBIZXJlIGFyZSB0aGUgYW5zd2VycyB0byB5b3VyIHF1ZXN0aW9u
czoKPiAKPiAtICpXaGVyZSBkaWQgYC91c3Ivc3JjL2xpbnV4LXNvdXJjZS02LjUuMGAgY29tZSBm
cm9tPyoKPiAgwqAgSSBpbml0aWFsbHkgYXR0ZW1wdGVkIGBzdWRvIGFwdC1nZXQgdXBkYXRlICYm
IHN1ZG8gYXB0LWdldCBpbnN0YWxsIAo+IGxpbnV4LXNvdXJjZWAsIGJ1dCBpdCBnYXZlIG1lIHRo
aXMgYW5zd2VyICovbGludXgtc291cmNlIGlzIGFscmVhZHkgdGhlIAo+IG5ld2VzdCB2ZXJzaW9u
ICg1LjE1LjAuMTE2LjExNikvKmAsIHdoaWNoIGRvZXNuJ3QgbWF0Y2ggbXkgY3VycmVudCAKPiBr
ZXJuZWwgdmVyc2lvbi4gU28sIEkgZG93bmxvYWRlZCBpdCBkaXJlY3RseSBmcm9tIGtlcm5lbC5v
cmcgCj4gPGh0dHA6Ly9rZXJuZWwub3JnPiB1c2luZyB0aGlzIGNvbW1hbmQ6IGB3Z2V0IAo+IGh0
dHBzOi8vY2RuLmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L2xpbnV4LTYuNS50YXIu
eHpgIAo+IDxodHRwczovL2Nkbi5rZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvdjYueC9saW51
eC02LjUudGFyLnh6YD4uCj4gCgpSaWdodC4gV2hpY2gga2VybmVsIGFyZSB5b3UgYWN0dWFsbHkg
cnVubmluZyBhdCB0aGlzIHRpbWU/IFlvdSBjYW4gY2hlY2sgCnVzaW5nOiBgdW5hbWUgLWFgCgpJ
biBhbnkgY2FzZSwgTGludXggdXBzdHJlYW0gNi41IGlzIG5vdCB0aGUgc2FtZSBhcyBVYnVudHVz
J3MgNi41LgoKPiAtICpXaGljaCBMaW51eCBkaXN0cmlidXRpb24gYW5kIHZlcnNpb24gYXJlIHlv
dSB1c2luZz8qIAo+ICDCoCBSdW5uaW5nIGBsc2JfcmVsZWFzZSAtYWAgZ2l2ZXMgbWU6Cj4gIMKg
IGBgYAo+ICDCoCBObyBMU0IgbW9kdWxlcyBhcmUgYXZhaWxhYmxlLgo+ICDCoCBEaXN0cmlidXRv
ciBJRDogVWJ1bnR1Cj4gIMKgIERlc2NyaXB0aW9uOiDCoCDCoFVidW50dSAyMi4wNC40IExUUwo+
ICDCoCBSZWxlYXNlOiDCoCDCoCDCoCDCoDIyLjA0Cj4gIMKgIENvZGVuYW1lOiDCoCDCoCDCoCBq
YW1teQo+ICDCoCBgYGAKPiAKPiAtICpBc3N1bWluZyB5b3VyIGRpc3RyaWJ1dGlvbiBoYXMga2Vy
bmVsIHBhY2thZ2VzLCB3aGljaCBkbyB5b3UgaGF2ZSAKPiBpbnN0YWxsZWQsIGFuZCBkbyB5b3Ug
aGF2ZSB0aGUgY29ycmVzcG9uZGluZyBrZXJuZWwgaGVhZGVycyBwYWNrYWdlIAo+IGluc3RhbGxl
ZD8qCj4gCj4gIMKgIFJ1bm5pbmcgYGRwa2cgLWwgfCBncmVwIGxpbnV4LWltYWdlYCBzaG93cyB0
aGVzZSBpbnN0YWxsZWQgcGFja2FnZXM6Cj4gIMKgIGBgYAo+ICDCoCBpaSDCoGxpbnV4LWltYWdl
LTUuMTUuMC0xMTYtZ2VuZXJpYyDCoCDCoCDCoCDCoCDCoCA1LjE1LjAtMTE2LjEyNiAgICAgCj4g
IMKgYW1kNjQgwqAgU2lnbmVkIGtlcm5lbCBpbWFnZSBnZW5lcmljCj4gIMKgIGlpIMKgbGludXgt
aW1hZ2UtNi41LjAtMjgtZ2VuZXJpYyDCoCDCoCDCoCDCoCDCoCDCoCA2LjUuMC0yOC4yOX4yMi4w
NC4xIAo+ICDCoGFtZDY0IMKgIFNpZ25lZCBrZXJuZWwgaW1hZ2UgZ2VuZXJpYwo+ICDCoCBpaSDC
oGxpbnV4LWltYWdlLTYuNS4wLTQxLWdlbmVyaWMgwqAgwqAgwqAgwqAgwqAgwqAgNi41LjAtNDEu
NDF+MjIuMDQuMiAKPiAgwqBhbWQ2NCDCoCBTaWduZWQga2VybmVsIGltYWdlIGdlbmVyaWMKPiAg
wqAgaWkgwqBsaW51eC1pbWFnZS02LjUuMC00NC1nZW5lcmljIMKgIMKgIMKgIMKgIMKgIMKgIDYu
NS4wLTQ0LjQ0fjIyLjA0LjEgCj4gIMKgYW1kNjQgwqAgU2lnbmVkIGtlcm5lbCBpbWFnZSBnZW5l
cmljCj4gIMKgIGlpIMKgbGludXgtaW1hZ2UtZ2VuZXJpYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDUuMTUuMC4xMTYuMTE2ICAgICAKPiAgwqBhbWQ2NCDCoCBHZW5lcmljIExpbnV4
IGtlcm5lbCBpbWFnZQo+ICDCoCBpaSDCoGxpbnV4LWltYWdlLWdlbmVyaWMtaHdlLTIyLjA0IMKg
IMKgIMKgIMKgIMKgIMKgNi41LjAuNDQuNDR+MjIuMDQuMSAKPiAgwqBhbWQ2NCDCoCBHZW5lcmlj
IExpbnV4IGtlcm5lbCBpbWFnZQo+ICDCoCBgYGAKPiAKPiAgwqAgQW5kIGBkcGtnIC1sIHwgZ3Jl
cCBsaW51eC1oZWFkZXJzYCBzaG93cyB0aGVzZSBpbnN0YWxsZWQgaGVhZGVyIHBhY2thZ2VzOgo+
ICDCoCBgYGAKPiAgwqAgaWkgwqBsaW51eC1oZWFkZXJzLTUuMTUuMC0xMTYgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgNS4xNS4wLTExNi4xMjYgwqAgwqAgwqBhbGwgCj4gIMKgIMKgIEhlYWRlciBm
aWxlcyByZWxhdGVkIHRvIExpbnV4IGtlcm5lbCB2ZXJzaW9uIDUuMTUuMAo+ICDCoCBpaSDCoGxp
bnV4LWhlYWRlcnMtNS4xNS4wLTExNi1nZW5lcmljIMKgIMKgIMKgIMKgIDUuMTUuMC0xMTYuMTI2
ICAgICAKPiAgwqBhbWQ2NCDCoCBMaW51eCBrZXJuZWwgaGVhZGVycyBmb3IgdmVyc2lvbiA1LjE1
LjAgb24gNjQgYml0IHg4NiBTTVAKPiAgwqAgaWkgwqBsaW51eC1oZWFkZXJzLTYuNS4wLTI4LWdl
bmVyaWMgwqAgwqAgwqAgwqAgwqAgNi41LjAtMjguMjl+MjIuMDQuMSAKPiAgwqBhbWQ2NCDCoCBM
aW51eCBrZXJuZWwgaGVhZGVycyBmb3IgdmVyc2lvbiA2LjUuMCBvbiA2NCBiaXQgeDg2IFNNUAo+
ICDCoCBpaSDCoGxpbnV4LWhlYWRlcnMtNi41LjAtNDEtZ2VuZXJpYyDCoCDCoCDCoCDCoCDCoCA2
LjUuMC00MS40MX4yMi4wNC4yIAo+ICDCoGFtZDY0IMKgIExpbnV4IGtlcm5lbCBoZWFkZXJzIGZv
ciB2ZXJzaW9uIDYuNS4wIG9uIDY0IGJpdCB4ODYgU01QCj4gIMKgIGlpIMKgbGludXgtaGVhZGVy
cy02LjUuMC00NC1nZW5lcmljIMKgIMKgIMKgIMKgIMKgIDYuNS4wLTQ0LjQ0fjIyLjA0LjEgCj4g
IMKgYW1kNjQgwqAgTGludXgga2VybmVsIGhlYWRlcnMgZm9yIHZlcnNpb24gNi41LjAgb24gNjQg
Yml0IHg4NiBTTVAKPiAgwqAgaWkgwqBsaW51eC1oZWFkZXJzLWdlbmVyaWMgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA1LjE1LjAuMTE2LjExNiAgICAgCj4gIMKgYW1kNjQgwqAgR2VuZXJp
YyBMaW51eCBrZXJuZWwgaGVhZGVycwo+ICDCoCBpaSDCoGxpbnV4LWhlYWRlcnMtZ2VuZXJpYy1o
d2UtMjIuMDQgwqAgwqAgwqAgwqAgwqA2LjUuMC40NC40NH4yMi4wNC4xIAo+ICDCoGFtZDY0IMKg
IEdlbmVyaWMgTGludXgga2VybmVsIGhlYWRlcnMKPiAgwqAgYGBgCj4gCgpTaW5jZSB5b3UndmUg
Z290IGEgZmV3IGRpZmZlcmVudCBpbWFnZXMgYW5kIGhlYWRlcnMgaW5zdGFsbGVkLCBpdCBpcyAK
cG9zc2libGUgdG8gY2hlY2sgdGhhdCBzYW1lIGluZm8gdGhlIGxpbnV4LXNvdXJjZSBwYWNrYWdl
OiBgZHBrZyAtbCB8IApncmVwIGxpbnV4LXNvdXJjZWAuCgpNYXliZSBvbmUgdGhpbmcgdHJpcHBp
bmcgdGhpcyBwcm9jZXNzIHVwIGlzIHRoYXQgeW91IGRvbid0IGhhdmUgYW4gYXB0IApzb3VyY2Ug
dGhhdCBwcm92aWRlcyBsaW51eC1zb3VyY2UgdGhhdCBtYXRjaGVzIHRoZSBrZXJuZWwgeW91IGFy
ZSB1c2luZy4gCkNvdWxkIHlvdSBydW4gZWl0aGVyIGBhcHQtY2FjaGUgcG9saWN5YCBvciBgYXB0
IHBvbGljeWAgYW5kIGBhcHQtbWFyayAKc2hvd2hvbGRgIGluIG9yZGVyIHRvIGtub3cgd2hpY2gg
c291cmNlcyB5b3UgaGF2ZSBjb25maWd1cmVkLgoKVGhlcmUgYXJlIGFsc28gYWx0ZXJuYXRpdmUg
c291cmNlcyBmb3IgdGhlIGZ1bGwgc291cmNlIHRyZWU6CgotIFlvdSBjb3VsZCBkb3dubG9hZCB0
aGUgc3BlY2lmaWMgcGFja2FnZSBmcm9tIHBhY2thZ2VzLnVidW50dS5jb20uIFNlZSAKaHR0cHM6
Ly9wYWNrYWdlcy51YnVudHUuY29tIGFuZCB1c2UgYGFwdCBpbnN0YWxsIC4vZG93bmxvYWRlZF9w
YWNrYWdlLmRlYmAKCi0gWW91IGNvdWxkIGNsb25lIHRoZSBrZXJuZWwgc291cmNlIGZvciBVYnVu
dHUgYW5kIGNoZWNrb3V0IHRoZSAKYXBwcm9wcmlhdGUgdGFnLiBTZWUgCmh0dHBzOi8vZ2l0Lmxh
dW5jaHBhZC5uZXQvfnVidW50dS1rZXJuZWwvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2dpdC9qYW1t
eS9yZWZzL3RhZ3MKCnRoYW5rcywKa2llbmFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
