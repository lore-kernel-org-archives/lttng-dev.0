Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CAAC3DA59
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Jul 2024 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721135120;
	bh=MdR71fHqbWLvXA9vnoQ+y0qALPR+rlqPXMBGgXklcmc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=0a5M+G42/P9doLk8lgjmgQQURAWqnwUeON3cyY8oOa3+1PY/vgxLTmWYU+oV5ySUF
	 VmvvvUsGyz15flEpw/HbFKYfIT+/Dm0IHvPhRYckeF1EOsmN7VLnPLVUp/5Teu0ET+
	 S5WhHEjH0vuAxihBGsY1iaXl/j0PQfDyzfqiPdJi0dTPBBUGpAkiODt8hHTpTk21Sy
	 II+CfQGw7BRNn8CPlsFQO4CvU9V6G4Bqf7nQPio/TAKL+MaFQ9uyFsH3uyy6pcXrMg
	 UTAG2W8QY76KTMrL3ZKHmHBh1vMLQDuIt5eQZRlkuJ0ytc2sKHfkZzLZjDbREvbA/x
	 hrNxDc5/MAeVQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WNfSH5n5Bz11cP;
	Tue, 16 Jul 2024 09:05:19 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020122.outbound.protection.outlook.com
 [52.101.191.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4WNfSF6hZFz11cN
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 09:05:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmRtMo4hE8HCkuugjip70JHMZV5fpejENg87PRkDg2+Tta+VKUGta78qpNpRFGd3tb7YeoNKNJXDps4w7PD8hc+IN8+cUZDRBcYdFmQZ1cZVnPs7c1CDMbm04lTvLM+dCuZWUcmgGR+9hCWReUgErjF2eFyFnoyWIQ+VR1Vb6y6hS/4UDlUVJq1pTs/3IWwA2qZS86eKQffiK8d1yRU6nwW2T9N/dxt4yGQY4F6gj80HHQb6u7iGCKckYEGqcReCe70ygnBDukJMZtHQ2clN3ZeWTUu2XrGHnQ3k4vwwBPTDDHlln/tlTcdEg8D/dOST8DWWQJb2sua1Ol4F7tqsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwEsx5CXpMGnXhZN3UP6iheyNP8NNy6blnEWuka8yCQ=;
 b=lTAkPVt8nih65fWDxtwOOJL4YyuJ/3XCNcriISqoi8m6Edao1ut/+K+ed38sqwMSK+XD5Kv9nPVMbLi+LhMAGLk3JyLWYOHIieSzQt3HgbNTM7r1GsB+ju2PRZlPaLlPBCjEsT67ZzFo48hX0cjJGjGQzBSlGTcDvJrxIpq9fpfAp5a0hOO2/GaKVqs/TZsxvTWVnF9R8vKY5Am/HIf3mqMrW6BeSJ0IgVX1yC47d1/YfwteJybA8RdcrOWd33h1Aqu9K8i830Tx6F5/7vCt1brTSKf4XAc9THlFQyiIZq79ZbBSpcefSN/yeNRDpEsSb9d1Ep84W/LC73mesjITdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT3PR01MB5828.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 13:05:15 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%4]) with mapi id 15.20.7762.030; Tue, 16 Jul 2024
 13:05:15 +0000
Message-ID: <6deffa1d-4d46-4445-a510-a3aac271cc80@efficios.com>
Date: Tue, 16 Jul 2024 09:05:13 -0400
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>,
 lttng-dev@lists.lttng.org
References: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHD10UjoaOjqZUH4j55Ra7zJ2HVRLOyk7xnjv+BjnJxs6rN6Aw@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::16) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT3PR01MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3b00f2-c861-46e8-5f57-08dca597ef39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC9nT3cwQndwaXhHdEY4K0xOQVk2QldvVkN4NER4NkI0OGdiVDFIdmhSemFG?=
 =?utf-8?B?M25KOHlDZDI0Snh0WjV1VUh0QThPK0hiWmdHb2IwcXBLZmhvV1RvdUR3MG8v?=
 =?utf-8?B?VXplY2dWS0ZmaTMwSXVSNHZUNmN3UzIvOWVkZjBXMDJyY3Nmb2ZrdCswU21M?=
 =?utf-8?B?aXRXR1RLVmlYZDg0N3JIc085ZVFSV0I0NGRSclEwVFpKQXJIck9EbUhLOXJr?=
 =?utf-8?B?S2wvMlppVko0SHl0dnZxY25zbTlzY2FiWVJvaEdmc1FOcngzRHNKVS9FcjYr?=
 =?utf-8?B?UWpnaXJMY2lNVVZFSEhJN1dyQXRtQjVBK0ZPTUx0VFZuMks2TVY4SGp1NGRP?=
 =?utf-8?B?b2F5ZUthSDdHUE01UE1nK1IzSlZSSC9PMkt3a3BzYUFNcmxVRGdxSXdJS2wv?=
 =?utf-8?B?bXllT0JXbHhNc2NoMmFTcGtkYmlCRFhQSDdLV1EyVlFmNUlTUVZlQUxPajNv?=
 =?utf-8?B?azhidWwwdWthTXpUNlpxdUdJK0VJTmgzMjVXc0ExMWlwSTM4Y1RFNmNieFd2?=
 =?utf-8?B?akQ5UTVhM0hoNldCQVIxUHo5TGE0akZwTUNNbFhROU05TEl5SmNLZlY5eGlo?=
 =?utf-8?B?N1ZNaENJOXVnL3E2SWRzTzJGT1BBL2tYdFd3cVMwclFYUnBoTit3aDUvcDVZ?=
 =?utf-8?B?MnVWdmhpOEdYQ3BLbXpBNGxxMklhenZVRGJjalQyQUlDRU0vT0NUYWJRd21Y?=
 =?utf-8?B?SHByelJDQ1Y5SE5OSmU0NkYyNy9IN0hBTkVzVkpSVi9xVWRVNDNaMTBkVTFH?=
 =?utf-8?B?K21vNG5mUDFzbm03UzlpcTdlUW1PMWRMTyttRUw2bmlPQ2Q1RDRZb0U2amZz?=
 =?utf-8?B?MHdNcFA0VXpYZ3VKYkJiS29iSUtZZE9iRW1DK2FDOVR1VHRvT2hrZ2hVak1V?=
 =?utf-8?B?SklDYTVkWjJTdUdDSWZoMW1GalE2eDQySEd0UmF1ZERrWHk5UzdKWVRLWVNp?=
 =?utf-8?B?c3d1NU5WS0FSa2JzSVZtTHdMd3U4Ni9lSmtFYjFKZVJCaXZSbUxXeTJCUU9l?=
 =?utf-8?B?SlpCVitTVHBKVUhOTTRFREFjdHJ6MVBpVUZCVWlUUWJPbDB3djdzMjk3QzlX?=
 =?utf-8?B?Um9idTF6bk9mWFYvWExhM2JIZUlNU3NGWElXcUI5RG9YTUIwWWgxckVEZlNN?=
 =?utf-8?B?VHNEY1dtTWVzU1Bkdlc0VjRQTGtlYUlHcXE5TUJZdHk5RWxVWTd3UHB3MmFG?=
 =?utf-8?B?TEdxWnB3djNEUDQyY3RWVVQzNHpLWXNVREh1N1JsR3hyQkZSMVVIV0h5Q2t1?=
 =?utf-8?B?NER1MkFJS2U2Z1JRZ1lDNWphVDQxS2I2Z1g5anRvcVdXUGI4MnJocXQwVnBo?=
 =?utf-8?B?MWZPN2pYU0d1RkNtai9ReDB6OFR1M0pTYW1yNmRWUmxSSTVvWllwM2pKU2hX?=
 =?utf-8?B?OTEvVFZBd0FpL2o2dmRVOFpRNHVVSzZETUFrM0YyOVhUTERMbzdweVZlVlRZ?=
 =?utf-8?B?YytTTWxMVWdlV0JwZVFTUlBKS3RJUi9UcWVidkhoZ2JlMFRVOWdkTjd0NWdq?=
 =?utf-8?B?Vjc2SjVBam5VVDlZT1RFT2hSVmRHNGh0dXUza0ZoWEdqWWpRY0xIeDE3Mm54?=
 =?utf-8?B?cnllTm1wUlVUaGt5b2lBWExVTWFOL1FRalJLMTAvTDFMRFBrdWZTUWw4cXpX?=
 =?utf-8?B?U3pIUUM0WjlSN3R0alVpbTRGZUo5aXdIUjNaNmZKa3I3ZEdmUGhIVkN2a2dx?=
 =?utf-8?B?MGVuUjVpbTRVKzJYM0FuVHY5VDFWeGVxSkxGNW0rQkNKN05sT3VOV21GN25X?=
 =?utf-8?Q?OErtJKJVwaUPDi6pEg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFN6NHNLWCt4WmhRSCtKUlFDNXJ0ckxLSEY2aWxBalZDc050ME9GMnFSb1Nk?=
 =?utf-8?B?cHZWZFp4cDdaWWtLU2crWVVuTDVlb29sZFNRMEtqL1EybHZWbWk3YUpYczZG?=
 =?utf-8?B?NHczWlpjTHh6S2g4V294Ry91OEJuZkQzSG9kRy92WU1RN0VXTmpjYWF0NTdF?=
 =?utf-8?B?OENQZGM3L2ZRd0x5T0p6K3E3R3V1VkpmRWxncGVhWEpIY3FlNjRwMG5iOHVR?=
 =?utf-8?B?SzBpNUNsQWczUHQ3aXIwVlNSd005aGJqeEl4bTVaMHdFOGtpQ3hMVmtGdnF2?=
 =?utf-8?B?dUFzTWtxQXkweHJNc0wwQ2FGeVhzb2YrM3lDazFsRVlvU0I5WHExQjM1eUFR?=
 =?utf-8?B?RHlmdS9Uczhnblg1Qk15VXRxSEVXaVhKdW5uYzRad1Vpd3BHcVYvVnZ2UDZM?=
 =?utf-8?B?Y3FxaTlNVzRyU1FWQnJvbjRTejlFbTY4Y0I5d1VSMmRNbkpxN2tsTEVmblZE?=
 =?utf-8?B?UklKNmpFUHB5U3RiQTg5MEVZcHk3MFpSeTNueVdKZnl6eTRWTGQyN3BRUVla?=
 =?utf-8?B?NFN0bWh2VEE4WFcrNGtEMm5lMlNBaW12dG1mVk9wR2x4YWtZL1VkeGJZa3dT?=
 =?utf-8?B?UEtIYzN2VlV1bExZSXJORi9CR245V2xqRFY0RmRVUFhycWk3alYvZFFFMS9l?=
 =?utf-8?B?N3lxTEtrcHlkbG92VXZZVUhvMVJHelRhK1E2SHJQZ09lTzk3VXBhem1XTEVP?=
 =?utf-8?B?SEw3OEpWUFlHNUFNdVBRNThqNzkwbmtTY2krZ3AzUklYUXBuYVQwQ2tSd3BS?=
 =?utf-8?B?Y0F5eTBSRVc0cmtDek1WLzB4cE9zNVNBWHlWdWZLSTJmRk5WWmpjUGtkM0dn?=
 =?utf-8?B?YkN3UGh2V1RKNXhJY2p0b2dXNmZJYmhUOHA4OWlvVm5YZ2Yxd2E0R3g0c1pt?=
 =?utf-8?B?TEFWYUQxVXFrczZwbVY3VGZaUFFlLzhWWE9temlPcVVjUENkem5qdFgvYzhp?=
 =?utf-8?B?MW93YzBhdjh2cDdhdVJnM25tZld6c29xcXZ3ZVdvTHVMZEZ1ODVIWFVsZFpK?=
 =?utf-8?B?RHdKY1RQUzdrUTBEYmZNOFVWckJMdFBNK2J3SnlmZHM2Sk11N096SFNPb0FN?=
 =?utf-8?B?U1l6RUN5dVJLSFlMUDRldmNKL1FWV0NoY0lvSDU3SUxKbDdxeEFjQ0hUV0Nn?=
 =?utf-8?B?azJCUzc0Z2VyNnhGK2Y3cTNpeEQyQk5GU3FxUmdUR0wzUjNqaGVLeTFRNVNZ?=
 =?utf-8?B?TmpyaHlvc3RlYm03ek5RNmJ4U3ZUU1lhd2wxUU04UjhsUzlSekdQdy9aUDBH?=
 =?utf-8?B?RHN5QTFCMjUxb1EvRlRaL0FsRHVLeWdVS3lKYTF6aGQrZWtscURNQlRyWkhO?=
 =?utf-8?B?bVhyMEx1Snc4aW1sbS9vS2NQUlc0N0hrQks4NkZWbmIrNC9BN3czRmVPWmVr?=
 =?utf-8?B?Q2xEUG5kQWxaRWM4bVlkNXZnZ0F0Q3J2bHNhek0wUnRmd3p5SDNsUXZqYS9x?=
 =?utf-8?B?WkRLd3EwR1ZXdzdObWVCam9yeU5kS3ZEeEd0NFN6MmZ2dzVveHZqOGxrVW5C?=
 =?utf-8?B?K2VnUGFWK0RQbEo5ZVVsWXFDL3grQkp0czJmais2aGY0b3MvRDVSaXZKVVZi?=
 =?utf-8?B?SzZFZ0V5b1NGbmtwc3FsczFJZm1yMk5oSW1QMjNOMjlnM2xjampVNjhLOVlt?=
 =?utf-8?B?b1lxa2t4a3F0QjAwREJ4bDU1Z0RoVjZBNXpKSDJ6V1RZMXFwU01FREQwaEEz?=
 =?utf-8?B?WEZUeFdnbVhGaVVJQjFwckRwNmlSVDg5dzVqdGJSUDltMkVsNi9Xa05iYjFH?=
 =?utf-8?B?d01wY3JYSG50bWthYTBOZDZEWnBRM3U2R3hTZkMwUWtFMno3cXBvaVFBQ1Iy?=
 =?utf-8?B?cTlRWHVMb3YvSmNLYjlXY05GUUVqa0lBeFhVbXBJV2FQWlZaZk8vVlMxTTF4?=
 =?utf-8?B?d2RWWWxtVFhyUndDMlJIYU5YVWE3bzRhNnY5dXVnWCtVcC83NEtCak5zdTFk?=
 =?utf-8?B?c2RQMER4N29pUUFleVl4dHNWYkZwL2xXcmlzT3BINXQrOXpScGdwbHJITHV6?=
 =?utf-8?B?bjJqc2tQUEx2K2d2NlBHYStZSGlPbnl1RXNTVllYZTVkbUFrNVNZWjc2OXRB?=
 =?utf-8?B?SWd1NGxVMFZQZzAra3BONzlKekRMWE5TZUloYU12dHlYNDBTbGtDbFBuVWZR?=
 =?utf-8?B?Qmg2cjVSSi9BM05QbVBmdTd4UmVsU01LTzJUTXIzSTlNaU0raTBvTitUb0x6?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3b00f2-c861-46e8-5f57-08dca597ef39
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:05:15.2845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzTSTH6B7SA2Q2LqAFFeDst9stYRU3014m2eUXTuP3H1QWFtHoX5vC0asdqiUdydMWFMNN5ogdioKUg7E8l3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5828
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

SGkgRnJhbsOnb2lzLAoKT24gNy8xNS8yNCA2OjEwIFBNLCBGcmFuw6dvaXMgQmVsaWFzIHZpYSBs
dHRuZy1kZXYgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gSSdtIGN1cnJlbnRseSBydW5uaW5nIExpbnV4
IGtlcm5lbCB2ZXJzaW9uIDYuNS4wLTQxLWdlbmVyaWMgYW5kIAo+IGF0dGVtcHRpbmcgdG8gaW5z
dGFsbCBMVFRuZyBmcm9tIHNvdXJjZS4gSGVyZSBhcmUgdGhlIHN0ZXBzIEkgZm9sbG93ZWQ6Cj4g
Cj4gIMKgLSBJIGNsb25lZCB0aGUgTFRUbmcgZ2l0IHJlcG9zaXRvcnkgdG8gbXkgY29tcHV0ZXIg
ZnJvbSAKPiBbaHR0cHM6Ly9naXRodWIuY29tL2x0dG5nL2x0dG5nLW1vZHVsZXMuZ2l0XShodHRw
czovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcy5naXQpIDxodHRwczovL2dpdGh1Yi5j
b20vbHR0bmcvbHR0bmctbW9kdWxlcy5naXRdKGh0dHBzOi8vZ2l0aHViLmNvbS9sdHRuZy9sdHRu
Zy1tb2R1bGVzLmdpdCk+Lgo+IC0gRG93bmxvYWRlZCB0aGUga2VybmVsIHNvdXJjZSB0cmVlIGNv
cnJlc3BvbmRpbmcgdG8gbXkga2VybmVsIHZlcnNpb24gCj4gdG8gZW5hYmxlIGNvbXBpbGF0aW9u
Lgo+IC0gRXhlY3V0ZWQgYG1ha2UgS0VSTkVMRElSPS9wYXRoL3RvL215L2xpbnV4L3NvdXJjZWAs
IHdoaWNoIHdhcyAKPiBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Lgo+IC0gUmFuIGBtYWtlIEtFUk5F
TERJUj0vcGF0aC90by9teS9saW51eC9zb3VyY2UgbW9kdWxlc19pbnN0YWxsYCwgYWxzbyAKPiB3
aXRob3V0IGFueSBpc3N1ZXMuCj4gLSBGaW5hbGx5LCBJIGV4ZWN1dGVkIGBzdWRvIGRlcG1vZCAt
YWAsIHdoaWNoIHdhcyBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Lgo+IAo+IEhvd2V2ZXIsIHdoZW4g
SSBhdHRlbXB0IHRvIGxvYWQgYSBtb2R1bGUgd2l0aCBjb21tYW5kcyBsaWtlIGBzdWRvIAo+IG1v
ZHByb2JlIGx0dG5nLWtldHByb2Jlc2Agb3IgInN1ZG8gbW9kcHJvYmUgbHR0bmctdHJhY2VyIiwg
SSBlbmNvdW50ZXIgCj4gdGhlIGZvbGxvd2luZyBlcnJvcnM6Cj4gCj4gLSBGb3IgYGx0dG5nLWtl
dHByb2Jlc2A6IGBtb2Rwcm9iZTogRkFUQUw6IE1vZHVsZSBsdHRuZy1rZXRwcm9iZXMgbm90IAo+
IGZvdW5kIGluIGRpcmVjdG9yeSAvbGliL21vZHVsZXMvNi41LjAtNDEtZ2VuZXJpY2AuCj4gLSBG
b3IgYGx0dG5nLXRyYWNlcmA6IGBtb2Rwcm9iZTogRVJST1I6IGNvdWxkIG5vdCBpbnNlcnQgJ2x0
dG5nX3RyYWNlcic6IAo+IEV4ZWMgZm9ybWF0IGVycm9yYC4KCklmIHlvdSByZWJ1aWx0IG1vZHVs
ZXMgb24gdGhlIG1hc3RlciBicmFuY2ggYXMgb2YgeWVzdGVyZGF5IHlvdSBtYXkgbmVlZCAKdG8g
Y2xlYW4gdGhlIExUVG5nIG1vZHVsZXMgaW5zdGFsbCBkaXJlY3RvcnksIHJlYnVpbGQsIGFuZCBy
ZWluc3RhbGwuCgpUaGlzIGlzIGR1ZSB0byBrcHJvYmVzLCBrcmV0cHJvYmVzLCBhbmQgdXByb2Jl
cyBtb2R1bGVzIGJlaW5nIGluY2x1ZGVkIAppbiB0aGUgdHJhY2VyIGNvcmUgbW9kdWxlLiBDLmYu
IApodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcy9jb21taXQvMGMyYzY2MDZl
YjY2Y2I1MjIyYWI3YTJhNGY4MzI5ZmQ1ZGZkZWY3MAoKWW91IG1heSB3YW50IHRvIHN0aWNrIHdp
dGggcnVubmluZyBsdHRuZy1tb2R1bGVzIDIuMTMueCB3aGljaCB3aWxsIG5vdCAKaGF2ZSBicmVh
a2luZyBjaGFuZ2VzIG1lcmdlZCBpbi4KClRoZSBleGVjIGZvcm1hdCBlcnJvciBhbHNvIGNvdWxk
IGJlIGR1ZSB0byBtb2R1bGVzIHRoYXQgYXJlIGluc3RhbGxlZCAKYnV0IGJ1aWx0IGFnYWluc3Qg
YSBkaWZmZXJlbnQgdmVyc2lvbiBvZiB0aGUgTGludXgga2VybmVsLgoKQSBmZXcgdGhpbmdzIHRv
IGNoZWNrCgotIElmIHlvdXIga2VybmVsIGhhcyBiZWVuIHVwZ3JhZGVkIHJlY2VudGx5LCBlbnN1
cmUgdGhlIG5ldyBrZXJuZWwgaXMgCnRoZSBvbmUgYWN0dWFsbHkgcnVubmluZwotIElmIHRoZSBt
b2R1bGVzIGhhdmVuJ3QgYmVlbiByZWJ1aWx0IHNpbmNlIHRoZSB1cGdyYWRlLCB0aGV5IHNob3Vs
ZCBiZSAKcmVidWlsdCBhbmQgcmVpbnN0YWxsZWQKLSBBcyBJIHJlY2FsbCwgeW91IGFyZSBwbGF5
aW5nIGFyb3VuZCB3aXRoIHNvbWUgYWRkb24gbW9kdWxlcyAtIGRvIGFueSAKb2YgdGhvc2UgbW9k
dWxlcyBkZWZpbmUgZGVwZW5kZW5jaWVzIG9uIHRoZSBrcHJvYmVzLCBrcmV0cHJvYmVzLCBvciAK
dXByb2JlcyBtb2R1bGVzIHdoaWNoIG5vdyBhcmUgbm8gbG9uZ2VyIHByb2R1Y2VkIGJ5IGJ1aWxk
cyBvZiB0aGUgbWFzdGVyIApicmFuY2gKCklzIHRoZXJlIGZ1cnRoZXIgaW5mb3JtYXRpb24gaW4g
ZG1lc2cgb3Igam91cm5hbGN0bCByZWdhcmRpbmcgdGhlIG1vZHVsZSAKbG9hZGluZz8KCmhvcGUg
dGhpcyBoZWxwcy4KCnRoYW5rcywKa2llbmFuCgo+IAo+IEkndmUgY29uZmlybWVkIHRoYXQgdGhl
IG1vZHVsZXMgZXhpc3QgYnV0IGNhbid0IGxvYWQgdGhlbS4gSSdtIHVuc3VyZSAKPiBob3cgdG8g
cmVzb2x2ZSB0aGVzZSBpc3N1ZXMuIENvdWxkIHNvbWVvbmUgcGxlYXNlIGFzc2lzdCBtZT8KPiAK
PiBUaGFuayB5b3UuCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
