Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA8C3ABCC
	for <lttng-dev@archiver.kernel.org>; Tue, 13 May 2025 14:39:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZxfHY3Fbcz1xlV
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1747147147;
	b=E9UJ++IkvkNfb4NGLq8ZlUYnvO3sdVqnUWrUaWFKeZ45y610747cWFLRmaOCX2Av5rfR
	 S5moVFXA4BfwhWIPQ/kfEsTY9yO98v3TtNDH4AyDJR+6aemJZY4HJ4vmsmeH8/qz/3o4a
	 YwhNhFqJNmYj6lLUyZT32zypdR7Mli9CaUembsQlG4laLLUdDqBHrTnfr2rWoRaGapzV7
	 ew9mXRdyK3aRTpXUhSwLgqDzFVh+XoYxrcgb6o/QTt7qeODFgAZez3x6d/ltdQ9WMhSZu
	 EtORABf+O0hTo5K/7Yn+B5h1l4lj/xKvLXiZwabIi179Xozs3zWRK+SPqs37GI1xNdA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1747147147;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=yU+a5kMcC+0/J96UVe8Iz0v52zv3t2Sgnlq07Le9Pi4=;
	b=TeM/BM4ycBBT9oTjkDo9EOMghOiHXBFRyomnnOvBNdtcqY/+m8zzdahBCLQBjL0duVjl
	 v4a/t56N9QAJInbrPh1sikIocaSmFgA+3xkftNg72MSRu/UiJCnRplwPyJti8tkVp+eug
	 UI6UUpGeqksM+30AJAU6SubcOGTBzWcjTXn/rwecYTpgKcQwRyTSlW4FepOkxFtwKlq+X
	 nfpIxDwvlws6d1j6CaRaFUxoieDG7Ni7vqD5DAOh43YSaSx2Y26MMcQTHobUG74I/91b9
	 FKPY11B5fOcV2JI68TNaG8md69jhSL4nJIU8TJHrehCMaFbMaliX2PYxY3/Vp0phIbA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZxfHY3Fbcz1xlV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1747147147;
	bh=yU+a5kMcC+0/J96UVe8Iz0v52zv3t2Sgnlq07Le9Pi4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hwu70ojvpQBfzE3XoAHwX13zD1FBxlh8FzdQX7IQO9oznvoN/JP6S0dvtGIsYG0ep
	 ip1hFuEqHnXWXZrv7nQAeiWmn1Jy/6Lfl9mYaSdxuIgyqLyMKhDiKnMdJRzcO3AOmV
	 1MpVMtSnSQdM7BpHYwoh29huOPthz2kPhkrJp6QE24drAPZjH6pwuz7cxJvAMj4ZWn
	 k5SEORRxwcImbxC1pKOtme4VlC0Nji0neUrI4xuCH8Xs4lgc/MAsc5cLZzNKuzNfer
	 14LH9DaJIyIWg70TIVCI9g1N1GBI3UoJjVPxdyqq8vLORLdeBUIcGyZ4suCXthrO8K
	 /dq++EUNa9IGA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZxfHY3Fbcz1xlV;
	Tue, 13 May 2025 10:39:05 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZxfHW5256z1xrD
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZxfHW5256z1xrD
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZxfHW5256z1xrD
 for <lttng-dev@lists.lttng.org>; Tue, 13 May 2025 10:39:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOs0IEc56fX4qsgmOKbcqHLRIG14RmMCo9Bfey8zVXT9eOXpDkh8JMT3DY/+04vB1THsvkLPHrzvJvNTSmF9buBq786T4gyC1T+UMK90pZahySXtdCQhKRC6Jw4+o2+D0zzuBemw+EQF+gwcz4vhK+FeRMSpJ1spIED0Z/r3357pvg3/OVUQY8jNEoYBaxRTWUTmOw4rbaoGWK6bAo4iM1zE7+mDRE0PR47gvRbOCtME9K2LebVKmUamGF8medFruHCUafDYPeJqX7Pbuw06IFqvis5CMBdyaZAXFqbL4KhUllNMcVreBfxeySCa0nIWKbmd3BdOJBIxD/2B3Jr0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OaYn05aXfHhjQrkK+rKEMXJRpyQcOBGNe31OPn2xug=;
 b=Yf2LA1+eZT6aDRuRQPyb1f/XVvuEIaCze7REnd3HLifYMLrTTZD9r/doM8MyLWYpTqI88FpcX2YbsfFLCyiZKdt2wrn/2SefzHbORS6abE2MvDUtU+YFFe9LKs8Pt8N4NNntng3giKtvez54AaPrIDP+lAKakcSP8U7XijGP6tzSk+uaPB865we04E+WL98HlqNhVe+kPQyi7d1JTOixJ99AMar7EIqGJPKrAn0FYGhFnsoeJd+qt1z8jYZ17s2Ef/SI7bDDhkiOZjQkCqSrKXryJAD+XG0lheHKiZ+j8CJLrRhm/qLImRvqB/xfw+F34RMLMZ4t8LD4FH1FUItWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YT2PR01MB8184.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 14:38:58 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e27c:c1e2:e6e:9256%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 14:38:58 +0000
Message-ID: <6159fd56-a363-48f6-a3a5-b829fbaf313a@efficios.com>
Date: Tue, 13 May 2025 10:38:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with arrays of floats (lttng 2.13)
To: Herman Bruyninckx <herman.bruyninckx@kuleuven.be>
Cc: lttng-dev@lists.lttng.org
References: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
 <7078c448-41bb-4ec3-be56-cfd93ea94ce7@efficios.com>
 <c25050a5-9e48-1042-5428-a33c4602fcdf@kuleuven.be>
Content-Language: en-US
In-Reply-To: <c25050a5-9e48-1042-5428-a33c4602fcdf@kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::19) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YT2PR01MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 803463aa-563e-4ee5-cc35-08dd922be517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFd1MFpGV3RzRHFYc1pUczVFUTd2ZkNxTWpEbEdIY05HaXR5TUdnWlhUNC9p?=
 =?utf-8?B?a2dxU2M0cWRWL20zTndQT0s2cGRBb1F1RFhRc05xcVEwVzVFWjZ1c3gxRHdK?=
 =?utf-8?B?QVBNUDQyUkIrN3ZQYWp4MUdwQ2EweVNmV1BCZndTKzJYWlRDMW5kTVdNZ0hK?=
 =?utf-8?B?RTc4Y2l6U3ZJNG1HTnkyMjJlcEVjbHMxeU1YS3F2aXRKcmU4c0J0MG1vZEgr?=
 =?utf-8?B?amMzc0FHZktmTERZTFdscy94M2liV1lnWFlnVFkxOHN2WEFkRjIzZDcyekZn?=
 =?utf-8?B?OXdUN3k2L0NIVFRxQnEyUzlMQ2lRRXByRzdEWXNlczlvK0ZsNVRzZW9mWTUy?=
 =?utf-8?B?UDA3MElWRSsxOVkwaDlhdXVOVDFTQXZmWGZXeDNVblZ2Y09ObGFjVmNROXpC?=
 =?utf-8?B?akRwRUV6RXhPVjRVSnpQbk1YMi9KeTRmNm8wSUdtNjRTcitLVDVoTFpydkZi?=
 =?utf-8?B?RzFUWDJObTZjaGZ2ZGd5T2k2ZmVyaEtld1U4VWVadUZFUnpmMFd4YU0rUkhS?=
 =?utf-8?B?MnB3VjlLVWI0RjNRSVJsSlBWYmJDNDVFeFNQcXJnSFNzQlFwQ3gvOEJLckRj?=
 =?utf-8?B?WXhuOU9oWm8rRDRoT3plcEhkZUxGQTljV1BGUk1QeVpUMGVyRXhvSlM1aC83?=
 =?utf-8?B?OEZHSjlMSzd2TFRIb25lNjZ0Nll0Yk9VTGdILzJLWk1iV0k0QytKaXY5WGVP?=
 =?utf-8?B?Z0VMcElzcmpUV05oUGJtVVVyM1A4cFVraUFlSm5td2JCRGNnT2M5OFp1SSt5?=
 =?utf-8?B?cWJLeGVpWlJyTHU0dEVRYlpkcmxIaUpadGlmNmtDT0dINTQ0elg0a2o0cXdr?=
 =?utf-8?B?SHVQWGdOUDNsSGg5ZEdrUGt2MmJxVDJJeDAxTjN1OUFyMG1TYzdMREozcURR?=
 =?utf-8?B?NW81SHl2bXpjeG42aE5qQUdjTkdpQnRVTnp1bWx4S21YUVpiNlBJVkI3NVJK?=
 =?utf-8?B?bzFrRE1jVkJzWXRUZUJkTVh6cVg4QzYwdENWaEk3V2JzelRHYzVQR0dRVkha?=
 =?utf-8?B?YlY1SzhlZ2FXc1hUd2xmRmJZYU10dTZXZlg0VHp4RlMwU3c5cDRBMllEUnlZ?=
 =?utf-8?B?TE1VaXErcU9wTEJRbEtib1FUOHFvK1pNcUlyV0VyMitPYTZQWVh1RVlScTdU?=
 =?utf-8?B?MHBxbDhrVS90UU9ieUV5YlhabWdOMElsU2QraEFUbVZRT0RVMW9JWWR5R3lK?=
 =?utf-8?B?S0tUZXVHM3puK01va3VJMGx6dkFIc0FvTWEwbUFsclZVUWNZOTVBSnJQRDZu?=
 =?utf-8?B?OUpmb0U2bW9RVDFhMWJMbUFrbC9mYWowenlhK2psWis4UGVqWHJ2dDg2U3JR?=
 =?utf-8?B?dEJ5WlpMcHkxOVV2ZDVNTVZQRHNFMHhCTVpEU0laak51eXhwbkdheENZMmVn?=
 =?utf-8?B?NGtyUk1SQmFiN0c1TkIraU5ySTlGWlM4TEdPbzkrclpVbzZXMTJyWjlWeFp0?=
 =?utf-8?B?L2xNTlU3aWs2K0FEL0krWmg4L2R2a3F3WjFVanYzOWdkQTJsT0RKTFlWZjdx?=
 =?utf-8?B?dkd4bFRvRjdrV2d4SGJLSXRSMFZBU0t1a1FqRENSZUJOMHpKa3l2VE8za2h6?=
 =?utf-8?B?VUkzYlhEYVJjRjhBQnlKaWMrZ2E2RlFXWjJNZ1htdnpRNVpZQ3U3U2J0WXo0?=
 =?utf-8?B?RFRKOVB6aUpienRKYTNMVC9QOUZIVXFaRjNhdE52YXZMbStZZnNWakk2aTd4?=
 =?utf-8?B?d2E3UW1xQ1dsdkNQOTdyOGVLU2ZaVEZzL1pYYXRsTjh2czBXWFhlUjVpczF2?=
 =?utf-8?B?VE9sR2NTbEVJQXI3TUtyTGNRb3czb0crVzRrNGJSdmRrZEc0ZTgwZGVKR0Nu?=
 =?utf-8?Q?TjkE60OLJHwBiNelfkTJ+pSXu3ceNT9YUNa0Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWs5QVBwcThvNjRsdUgzZm4zTGtha21wZ1VCWjN5SDdoUDRVYXQrN2dQOFkv?=
 =?utf-8?B?TFN5alMzd3I3b2I0UlBNeGVUakRMTmJ0ZkhDaUw3Zi9JUndUczhpbHBwVDgy?=
 =?utf-8?B?U1BFdEJDUXVxelNlT1pZeFRJSGJNWDJiL2w4NVJyMGcydHlZamUrbkdjSGlo?=
 =?utf-8?B?SGFRSnBRQkRmcytyeXdYalZvYVFiRVlWeE1TRDA4bDVDS2phNmRzR3pCNEdm?=
 =?utf-8?B?M1lFRHZJU213RGIzMVdiekJDZDBtZGt3cXlBZlIvbEZpNmM1d3BKdzhZS0Qw?=
 =?utf-8?B?Wk0rRGNzdVovVjV0TFZ1eHg0Z2h0RXdzL05kTFo2RHZPZzZvYjcvWTNYL0sy?=
 =?utf-8?B?M0xCS0dKQVRmT0s1NVl6MVhVRm5SeDdDY0kzWmcxMElUaTQydkVvN3FlcXB1?=
 =?utf-8?B?d1o5RnB1OTM3ZUcyc2FYT1JoOWxjNFgrRGlRWUluR1ZEVFozZ29GaDdQUElh?=
 =?utf-8?B?UjlWUUdxUi9qaytQOUpUYUtqd2hzbmFQMzhBaStUZTQxYUtPYnQ0d2czMVVF?=
 =?utf-8?B?aEJ1T3ZhdXR4SW1acHVtK3gyd3dNSkgrcXcxUXFRUkVsTVpBN25qN1FzSDFq?=
 =?utf-8?B?WmFHdnRJUVc4Tjh2bFZQZE5maGVXWXUyOEpoZjg1Z24zWW85ck45QkF3UUNr?=
 =?utf-8?B?bWRLcEJHYXZkUDJhOFF0TnFOODJKaEFiSm5DeGZjbkRoV0c5TzNRVnpSR3h4?=
 =?utf-8?B?Uy85TlZXVmpzQURtTVY1dDVKSml4WHR0RDNXWTRiMngzMTFhRFZpZm1oalhT?=
 =?utf-8?B?YUI4bmFRdXFWaXdDbHhuMXVseEtzaThyYWlYSjhKQytWaVduaER2RkVDejA3?=
 =?utf-8?B?eXM0UTMzSWFaVUlSZGdGODlRNytaaFEwM09YM1lTbGM2WkxBb0d4MHdmZ2hP?=
 =?utf-8?B?T0ZqRTFvY0orVUQ3Tlgwb21qdzlhY2M2dm4ySjJaWVFOeW9yeHVoY2IyK0pj?=
 =?utf-8?B?Q1JmRjZ2R3cvWmhnTVArbG5lQSttRnVOYnZKUk1WNnowZFZuNG9GN0tTbHRB?=
 =?utf-8?B?MWk3RC9XaG5ZcWt1dEV2U1VHODhhS3g5NWhhMmcyQUhzQ1R0dThDcERqQlhZ?=
 =?utf-8?B?RWlxOUlVK2RyTDJQc0RMbWE4KzhqOGpSL0crczRxNlM3RFozQkErSElESGRN?=
 =?utf-8?B?U2VlYy83QnFVd3llN1JyKzQ3eWpVUVlyTHZkUDIwbFhvZnFGaks4S0ZYM2xJ?=
 =?utf-8?B?KzNsQUtyelNqbWRrZnY3Mnh6KzlpY09NRXFmUDRTSGo2ZkJGTlRySU0rZGI0?=
 =?utf-8?B?QXJ3NWdxdFhHOHRVazVLZUVVbExDUEl4aVdSS1FsOEhzczRqRm5xRDdwaXJB?=
 =?utf-8?B?NzRGdGZUNm9BQ2xPVFNxVlhZeXc5L1JqSlJrWkpuditlMHFmOVVHN1NyVC9L?=
 =?utf-8?B?S2prM0pmcTB1U1hwTVYrSGh2VlFyendFdnpMeVJCcjdZcWZDN2FTN0VaNW1v?=
 =?utf-8?B?eEZ3bFlmVFNMTmpaSWZMQ1YrWUNnbUxTQ1hUY0N3eUkrU211N1JGc21vNzJT?=
 =?utf-8?B?USs3OHZXQXV6bDVReU9VeXVhbWRJeEd5WVdVS0l2YWd0VEc5aXd2cG9Bd3hl?=
 =?utf-8?B?THdUKzNvbnZJd09NR2RZWG15dUJyWkxFaVJHSXBwdDRZSTMvLzU4RUNoYXlL?=
 =?utf-8?B?eXNkTWdxRmdQUlJpcmFLMWpuSGtNdlJTZ1BiMXhTTW1iUzFEQkxFakVQM09X?=
 =?utf-8?B?WFh2VW1MdHQ2cHNGWkNvTHcvTVBCL1BGdFdIM3dSMzV4UDAwS2hSNVg0VzRG?=
 =?utf-8?B?S0JRaVo3d1lPZjVPcU1DSzQ2ajg0UnEzWStaSDBnOFllb2ZqM2JPRVJVUU1p?=
 =?utf-8?B?OW94OXJBN3NYWXZ5Q1JMK2xSQkVxSXI2TlVySnpLVUdYSTlzTUJobjBGN3Vo?=
 =?utf-8?B?OVVKSnFEMGZiNDIvQjBDVVRRbjhKRDdBUWxJT0QwbjFQRjRXM2lDa1RuUFFO?=
 =?utf-8?B?aDRyTHBWandCTDFBVnkweCtoYWkzOWNKMFVoK1Y4ZTRzaUUydkxFYVdFVW8y?=
 =?utf-8?B?aDJZTXBrcVBtOHcvaFA3OEhIZEExQU0zdzJocHE0bEtjVFFyYnpJamhoRy81?=
 =?utf-8?B?bFVLWmRZVE1XbnZ0b0NVM0tiSCthMjRSeHVpNG5mcStGKzdCaGxzd2N6RWgr?=
 =?utf-8?B?dVdTK2phb0ZaOTYwOVVoQ0s1TjZNdlJwUEdaSUd6QmNaOU1qWi9zcU1JQnZl?=
 =?utf-8?Q?CcGIBNAXQUsVguMHFJl+tYeKbPopwaNtEMHZxNf/B4qg?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803463aa-563e-4ee5-cc35-08dd922be517
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 14:38:58.2699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZo6XTb7VITpuVEfwKV6yedJn7StPL/IEynu7lvWLcgPn6QEI/PidKqGqD3oazb15d9VXDKl7zt5ODdz6D36YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8184
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

Hi Herman,

On 5/10/25 4:14 AM, Herman Bruyninckx wrote:
> On Fri, 9 May 2025, Kienan Stewart wrote:
> 
>> Hi Herman,
>>
>> On 5/9/25 6:03 AM, Herman Bruyninckx via lttng-dev wrote:
>>> Dear all,
>>>
>>> I want to trace an array of floats, but I always get bogus output at the
>>> (Python) Babeltrace2 site...
>>
>> could you give an example of the tracepoint you have setup in your 
>> code that doesn't work, with the corresponding output?
> 
> Thank you for your swift reaction. Much appreaciated.
> 
> First of all, my apologies: I should have provided the required 
> information the first time around already.
> 
> ---
> This is the information about the installed versions of the relevant 
> software:
> 
> $ uname -a
> Linux SET-L-ME-P22061 6.11.0-24-generic #24-Ubuntu SMP PREEMPT_DYNAMIC 
> Fri Mar 14 18:13:56 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ lttng -V
> lttng (LTTng Trace Control) 2.13.13 - Nordicité
> 
> $ babeltrace2 -V
> Babeltrace 2.0.6 "Amqui"
> ---
> 
> 
> ---
> My application code generates a trace as follows:
> 
> Tracepoint "-tp.h":
> LTTNG_UST_TRACEPOINT_EVENT(
>      comm_activity,
>      range_scan,
> 
>      /* Input arguments */
>      LTTNG_UST_TP_ARGS(
>          int *, distances,
>      ),
> 
>      /* Output event fields */
>      LTTNG_UST_TP_FIELDS(
>          lttng_ust_field_array(int, distances,distances,5)
> )
> 
> 
> int testmeas[5] = {1, 2, 3, 4, 5};
> // double testmeas[5] = {1., 2., 3., 4., 5.};
> // (one array for test with integers, one with doubles):
> 
> lttng_ust_tracepoint(comm_activity,range_scan,5,testmeas, "range_scan");
> 
> ---
> 
>> Could you explain what you mean by (Python) babeltrace2 site?
> This is the Python code I use to display the trace generated above:
> (inspired by <https://babeltrace.org/docs/v2.0/python/bt2/examples.html>)
> 
> ---
> file tt.py:
> 
> import bt2
> import sys
> 
> # Get the trace path from the first command-line argument.
> path = sys.argv[1]
> 
> # Create a trace collection message iterator with this path.
> msg_it = bt2.TraceCollectionMessageIterator(path)
> 
> # Iterate the trace messages.
> for msg in msg_it:
>      # `bt2._EventMessageConst` is the Python type of an event message.
>      if type(msg) is bt2._EventMessageConst:
>          # An event message holds a trace event.
>          event = msg.event
>          # Only check `range_scan` events.
>          if event.name != 'comm_activity:range_scan':
>              continue
>          print(event.payload_field)
> ---
> 
> and these are the resulting traces (for int and double, respectively, 
> and with the C and Python versions of Babeltrace):
> 
> $ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
> [12:19:11.381152129] (+?.?????????) SET-L-ME-P22061 
> comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 1, [1] = 
> 2, [2] = 3, [3] = 4, [4] = 5 ] }
> 
> $ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
> {'distances': [1, 2, 3, 4, 5]}
> 
> ----
> 
> bt2$ babeltrace2  ~/git-repositories/communication_5c/build/test_session/
> [10:04:51.068836215] (+?.?????????) SET-L-ME-P22061 
> comm_activity:range_scan: { cpu_id = 6 }, { distances = [ [0] = 0, [1] = 
> 1072693248, [2] = 0, [3] = 1073741824, [4] = 0 ] }
> 
> $ python3 tt.py  ~/git-repositories/communication_5c/build/test_session/
> {'distances': [0, 1072693248, 0, 1073741824, 0]}
> 
>> Are you instrumenting python code, or are you instrumenting a C/C++ 
>> application with lttng-ust?
> 
> The latter.

thanks for the extra info, it's much clearer to me now!

When you're passing the pointer to the array of floats, you get the 
weird values because there's not an explicit type conversion so the raw 
data of the floats is being interpreted as integer values.

As there is no lttng-ust function to handle an array of floats at this 
point there's a few other options you could try.

In your example you're using a fixed length array, so it's possible to 
define a tracepoint with 5 floats like this

```
/* note, this version isn't doing any bounds checking */
LTTNG_UST_TRACEPOINT_EVENT(
   my_provider
   my_tracepoint
   LTTNG_UST_TP_ARGS(
     float*, my_float_array_ptr
   )
   LTTNG_UST_TP_FIELDS(
     lttng_ust_field_float(float, float0, my_float_array_ptr[0])
     lttng_ust_field_float(float, float1, my_float_array_ptr[1])
     ...
     lttng_ust_field_float(float, float4, my_float_array_ptr[4])
   )
)
```

Here's a couple of ideas for a more general approach

1. Define a tracepoint with an integer length, maybe the base pointer 
identifier (for correlation) and the offset. You'd have to have a 
smaller helper that calls the tracepoint one or more times depending on 
the length of your array.

Something a bit like the following. Note that I didn't do a full test.

```
LTTNG_UST_TRACEPOINT_EVENT(
   my_provider,
   my_tracepoint,
   LTTNG_UST_TP_ARGS(
     float*, my_float_array_ptr,
     size_t, my_float_array_len,
     size_t, my_float_array_offset,
   )
   LTTNG_UST_TP_FIELDS(
    lttng_ust_field_integer_hex(void*, array_ptr, my_float_array_ptr)
    lttng_ust_field_integer(size_t, array_len, my_float_array_len,
    lttng_ust_field_integer(size_t, array_offset, my_float_array_offset),
    lttng_ust_field_float(float, float1, (my_float_array_offset + 0 >= 
my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + 0])
    lttng_ust_field_float(float, float1, (my_float_array_offset + 1 >= 
my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + 1])
    ...
    lttng_ust_field_float(float, float1, (my_float_array_offset + n >= 
my_float_array_len) ? 0.0 : my_float_array_ptr[my_float_array_offset + n])
   )
)
```

2. or, use a structure with N floats and a process similar to the above.

It's a bit inelegant until there is support for array of floats in 
lttng-ust.

3. Use the int or char array and rebuild the float values in post



Hope this gives you an option to work with for the moment.

thanks,
kienan

>>> I have no problems with arrays of integers, though.
>>>
>>> Is the float array feature not yet implemented in lttng 2.13?
>>> Will it be in 2.14? (Also the "BLOB" feature is useful for me.)
>>>
>>
>> I don't see any changes in lttng-ust for 2.14 that allow for 
>> tracepoints that have float arrays or blobs. lttng-modules 2.14 does 
>> add support for CTF 2. The support for CTF 2 in lttng-tools 2.14 will 
>> remain at an experimental level.
>>
>> From the release notes:
>>
>>      CTF 2 output isn't enabled by default and is intended solely for
>>      preview and feedback purposes: having an experimental support will
>>      allow users to test and evaluate CTF 2 until we make it the
>>      default output format.
>>
>>
>>> Thanks for your help.
>>>
>>> Herman
>>
>> thanks,
>> kienan
> 
> Herman
> 
>> [1]: https://git.lttng.org/?p=lttng- 
>> tools.git;a=blob_plain;f=ChangeLog;hb=11f963148df9597de6d891d96d748bae5ced7149
>>
>>

