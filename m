Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DE0C83F1B
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Jul 2025 09:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bgcgl1JF2z1Fw0
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1752485893;
	b=kg/iKrdfj/4RLwR3AltfGc1ui92shKsqL5XmLc4ehKmPRolPltUWXC5NRgI3xxLs1rlr
	 LgUKEwdsGZASFCnIYnUrIwH7PSJkPqPFBH1DgjU9jXv60WCp18+R8Fx2oJc6r3Hj+u7j/
	 k0DHjqvUodfn76oh4Yv6aCCLHegrVx+W9Z0Nxe7tyaBI/eKtcNsbN19wtCLyXQCi9QGhw
	 /71UfQSg0lzrzlM0gl75Y6FtjpsmJlQS6IPYCpfKpJC1ikOJir7DTFuTa5OfSnZQRUW8z
	 Y2N2qtFna1hvpTzZpbdLA4L3CADwuPoefXjJeBJsc3um9z37bqP2ACzrv5m4srRyv0g==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752485893;
	h=DKIM-Signature:Message-ID:Date:To:Subject:MIME-Version:From:From;
	bh=bmxVhwDpmIUo006zPnqe0zIntz6sHeUJcEBG3qRtRho=;
	b=hGGxeNPU//wzMpTMHGL15QMmyI7ALqI9FjqeNEdn9+B213oQGIt1bbtAYCBgOgsT/onG
	 lGm3NggjCcW0N8dCiop4CD8FLlgJJlFC7yCVOHvyZrcAFk6t1FEX/IhNGDwZ9hioKC1LK
	 oc3Vg7r/LyTXYPZgsz3ob7Q5o92eVFAexmCu4fycR2HbIGT9WWDy7vCoR6EjUxD8Ey9wu
	 UmzZ34rIHcGQtQoVO30o234OHH+5JQKXc3qMLQr/u3XrzOY4UudKmPqoDXDpSLPNyR17h
	 rZBTeRsm9meaY/x0bQGyA4tnhVVG4B2/COGdC5x14CxLsJTnRC30Usx8H6z8t2kLoMA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bgcgl1JF2z1Fw0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752485893;
	bh=bmxVhwDpmIUo006zPnqe0zIntz6sHeUJcEBG3qRtRho=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Re3cb1TPIXkrgQSMnj94kKY19zzvFIzjNIt8eERR1EM/nNQrWZ3CQPstZRerGSMpD
	 /CckrpXK37LxGndtBqo793rFEdiC5MIPMT6VO+3BzCX+sWg92QIeCXxkyU2hF1xr/O
	 m8Lc59Cj8K7XwuOfnHR4a0Qq7FNu0XSmb7Vo/UIWon66a29ZNPZ4MLwNAKgzuZr4dj
	 cqPdti7PHLzkbXJLitm6r6+C+bLPrqdMIZG2a2WGqCYZdp66vd1qiOblbzpKKd25oN
	 nonCAl8vhnQfPxXJ8yTMEY0iPikWc4yl1sid/cYOvIfkfmbgvAOP+gqy1Gwc1xCiH7
	 LVx06ZfhIokYw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bgcgl1JF2z1Fw0;
	Mon, 14 Jul 2025 05:38:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bgcgj0VwPz1Fvy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bgcgj0VwPz1Fvy
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4bgcgj0VwPz1Fvy
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jul 2025 05:38:07 -0400 (EDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56E3j3rv638922
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jul 2025 09:38:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47uf2v9vck-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jul 2025 09:38:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5bDRC0fHoiJFG13HxsuNFwGZ76Uk0Dh6ADtNHNHCKPJbRldVwhz4ADf9CO0blwQNLtPyMD1QhDgsRR0irHrbiYqE5U7i7ZsADY+wKmXfSyUWV7cUTF1bOVRyIcLhJq6FPettMl411H0zUMPdXctKiNhKROdqmdTK/r14wCTFYBdNQCX9tf5iJ6cxmyZZK9mc8fbGPuadTefSZcARCUbtjIQ9EZDHyRD94T2d4u2oZPfEEwnUd49N2qkk8Qrd6ktITqJ2n1U7RyHk60W4fDMnG7dwexvWMuq3XP5vEZk9Txh0PN+jYcX4V9xb3u6GijdqC4ZO+o6U+jlZFAzU+t0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4RCYn703EOAszsJrHRTdJEGpMwRNa8LRSPp2K+yX8g=;
 b=Fb66mqJxFKgUKcHUYcln9wRusnEqgSY80ESlya5rTGbfKY/0AaOLZkYIjCwNaDS1RTigelJJFmoFyh/UPdmTpfUedGwoksQr33XraB35WzoC5MqvJG7XDQGN07imlEIkROyS6+IXFvY0b3hUamCEFQXaVxLviYjAZop6xzdlzuaxksFlMLcZSCwkM5UO4lTnZU1mU1xyMFYkDhAYpGtqB+DeDVTf+Eedvz57Gu/+Wj1LJc0kD/KAbIPCmesR8/cKrXMoLK4u+q5xlRRxFTeOH2GQo/gTZxiJMMMO0SjNwpl+RpnY2Oqu4D0FPKU67b7Clc/BtvANJ8HN7r/w9aTDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MW4PR11MB6668.namprd11.prod.outlook.com (2603:10b6:303:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Mon, 14 Jul
 2025 09:38:02 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::7ff0:a398:beba:1ce7]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::7ff0:a398:beba:1ce7%4]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 09:38:02 +0000
Message-ID: <5fd7be0d-a6dd-49c1-b59b-34735e69b1f6@windriver.com>
Date: Mon, 14 Jul 2025 17:37:56 +0800
User-Agent: Mozilla Thunderbird
To: lttng-dev@lists.lttng.org
Content-Language: en-US
Subject: tests/regression/tools/clear/test_ust fails occacionally
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:100:55::36) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|MW4PR11MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f063740-4dfe-4246-2895-08ddc2ba203b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3hYMEhOWnArbTVOallHN3B6Q0lzMWt1M0hxNXpyR1grWmswemlQMmo5bEYz?=
 =?utf-8?B?YUYyUGl3clJlR1RwVGM5UmhhcDhTQUVucHRhdXpKc21nNDNUMy9ieGtEUUV5?=
 =?utf-8?B?UHFDZjJMQmF0Tlp5K3VwQ2xpSDZMbzkrOThjU21OdkZ2Qk82RytBVWhSRmNF?=
 =?utf-8?B?cWtJQVEvcFBwb1lqVlM5YWlpbnc4NHdLQlF0VWVnbnB0bkpBeE1aa0lKQi9s?=
 =?utf-8?B?YitRN1dVRWQ5MldZblp6VDBsVndvT1k1ZkRnSU9LVURuMkJTeTNXTEUzay9Y?=
 =?utf-8?B?Z2lhSmk0aUJXWDhsWnlOVU5ETkNiSWVrZHlLMEdFTzI1RUo0b2c0TGNjUlda?=
 =?utf-8?B?UFhoZXYyUENIZ2F1eHN2ZktMcnZONTFEMmdrMk1aRnBmS0lpQWtmcStGcnF4?=
 =?utf-8?B?QUFOZ202c3Q5d3ZSaFJXT1VSaDAyVG8xamNhUlJ0MTZYT2xVUnBFbXpsSVky?=
 =?utf-8?B?bFBRT1dxUENwaWw2cUdNc0dSbU9aUDJzWFlER2lsYThua1Qwb1o1Rk1uOTJU?=
 =?utf-8?B?Vk1zcERTTkdUdFFybEFxNzJPZVFuV3AxREY3dUJhTFYvb2dpelBudzhpdW95?=
 =?utf-8?B?dzErN1cvNWMvZkprY055VW1YRmZGamQzOWlYSWNBSi9iMGZneHVnYkM2eUpp?=
 =?utf-8?B?dWRycW8xZkhjalpHcFFCQTJ5VG1qRUJyTCtETkc1NjFMUDE3NEZQM0FrSnVK?=
 =?utf-8?B?d2NTcFFmNTdyQzBManJEWVhiYTNjeGFxSUN5K1NVSThRb2luVkszYzNNNFBy?=
 =?utf-8?B?VURHNWVyVG5oK3JTK3dtc041TjZ6STNxdmJqRGIzSi9LR0RwMEN0WG4xWU9Z?=
 =?utf-8?B?MGQ0RTcvREFZNHFzOVlhTWsvc0ZQUkxpOG50K0NBUG5jTXg3bjVkc0ZZMHZV?=
 =?utf-8?B?OVBSSUFtQ29yNWJBUmZGVm04dVlCeTVBZEZBQmhLOG1vNk5yRSsyMXp4TmFI?=
 =?utf-8?B?SEJKQkw2WFVNcTVKelZzQmN5UjVOb3FrbzBiL1NzZjZvdElnaGJmZUxqZGtK?=
 =?utf-8?B?UXFmT1hvMnV4ODNlOVNxSHlzSFVIak1JUGczY29RckNwb1NySDJhcjl1ZXh5?=
 =?utf-8?B?NkliZm9VSnNPU2ZyNlhKYXpCNnEycU8rNDFpd0ZLNCtsSWJhQ0tnREdFWVox?=
 =?utf-8?B?QnhTSFBvOGo1N2JmSVBsUXlaNkNiVzhmVEEzU1VGcmp4azNldnFOVjRiVGEx?=
 =?utf-8?B?R082RjlvYnBrbWRwWnpEejBPRDVuM2JPZE9hVVVFRnUxTll0RU5QVnliS1Nm?=
 =?utf-8?B?YVl5NFh1Umd6RHJXYnh1d2d4SHJpMGlsa1VubXlscm5aMUJ4dXdzLzFGZTRH?=
 =?utf-8?B?eHRMMDZLUkpjc0VLN2RNYTd6bVZnZ3l2WnkrZklQcE1uNTh3Y2dwSWI0dWti?=
 =?utf-8?B?eStWcWJjQXBmanhBVjBIL0s5REFhQTQ2YUxrQk9TRldzYTVneXR2cjg4S2tI?=
 =?utf-8?B?YXp2c2JiTVFIZkZGUHkrQ3F6VXZuVW90aUZuSVhVZUpocStPbHkwZGltdHVk?=
 =?utf-8?B?K2JFY0NBNTN1WlJpVFhJaDYvSVRKUG1hSDNXVHZSSGE1NHhPcmx0WWV2K3ZY?=
 =?utf-8?B?NDFjb01qdlptVThrUy9pUTJlZmY5Qzk4Y2J6NW5BbG1GMVJjTWRxcUtuekZn?=
 =?utf-8?B?UXYvL3U3YXY4QUk1UE9XejJWVE1nWEZuQm9WZXMzSjhBT2FBN2oxMXdLWWFR?=
 =?utf-8?B?dWJnVk14Q1RuV0p0YjU1aW5JdkU2M1ArVUY1ZTRsUVBpOXVNNmxZcEpKcDda?=
 =?utf-8?B?WFJTL3FwZGIvSWd4MXNGbjhJbFNpcHZYRUx0QUZoZFFvWFhlT3hyb3dtaUc3?=
 =?utf-8?B?UWQycFo0VCtUbGt6NjFqNlFhZE9uTzVlRU91M2huRlJlL29CMTRvUUZYRVQ1?=
 =?utf-8?B?K1ZEeWNRd21ROVpOK1dVVllocnNJOHpqY240eHdLVkEzLzdlcnpBNHFaMmow?=
 =?utf-8?Q?fSAs5aI+7qQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJjWVdWTFFJdk11TWhKbStHUi8zcWFWQU1EOUNzb1JLbWxITDBjZnZNQnVx?=
 =?utf-8?B?RDJFOGZVOXloK0EzeTEveHEzcnhacnlYY1pjVDFNejFPdm1GV1FRb3hQQ0pV?=
 =?utf-8?B?Z29oUFVpbTdCZ0RSUVBySlQ3RlRpYmMxUkZGRFRSRDBPUkEyLzBoK3dXNU9T?=
 =?utf-8?B?NUFUbll2VnZNc1ZvUk1jSGs3bHFEVnJ2WGR5WG1nWkhxaytsMnBqNG4vUDZn?=
 =?utf-8?B?K2ZHSUlDMmRyNXRqQk9ZQ2NMZ0RSanJNcTZtcWhLZHhWZzBlK3gxY2NKUzNi?=
 =?utf-8?B?KzZzSUMyRjFsa1d1MkZ3WVZVdUJXdXlGQngrSEtuek1xb3cvWlZzbitRckFR?=
 =?utf-8?B?YlgxWDBTWURybnN3K2VXRU1IalR5NXl1Vko1VXR6MW1IVTJscFJkME9sdzJ4?=
 =?utf-8?B?WVJLZFdYT2FNRFp1QlRoNFZzOGZkR2IwckFlRDUxK0V3d09iTm9LWWY2MGlm?=
 =?utf-8?B?bVkxVnVKcWN2SG9adFNuLzJjbGREWEwvNFJDN0N5aTAxaU5Gc2J2azBHRWRo?=
 =?utf-8?B?Zm9XcDJQcFlJSDZNai9EZE1mRnBDU0p3Skt6Slg0S3JhdHh2TDRLdFNuVFVG?=
 =?utf-8?B?a1ZEMUJvTTlRR25kTHpOblgycWd6S3VmQyt5VVZwb28rbHgrRDZ2OEVSZ2Y0?=
 =?utf-8?B?V1hhSmVzY2ViTnVtWWFOVUg2ait0UGxONWptWklJYWo3Ry85bXFnTm5CRWda?=
 =?utf-8?B?TGhHQnIwSk9ONSt6QW9waER4M1ZsZ2hOVjhuTEVOdUdIc1ZLOGhQNThwRnBZ?=
 =?utf-8?B?aTZ2RWw5cFFyWnA1KzY1eklUWi9rT2tKQXU2TUk2THQ2KzNUKzBhb255eVBU?=
 =?utf-8?B?LzFRMnBVb1l0ZnJqbmJzMmdVZ2xFN2JGQXJxQ2VNdys3M255aUZ3MU5RaXFk?=
 =?utf-8?B?WmluY2JBTDlhaVpQbU80WGYwcW91MkZvRitJdmtSdW5aSmdSRUkxeG53endh?=
 =?utf-8?B?c29TcGpPT21ER3hpUnpaSkFDWFBWc1BvTjBwcVg0RVFyRWNhaXY0WVJkaG50?=
 =?utf-8?B?d1E1THRrcGdaUm9GZ3I4VDFwVnU4YW9RY1QwS0hqRHVkV2NmaDR0OWc5VXox?=
 =?utf-8?B?emJJTk1XZHQvcnY0MVhrODNvbytqVHo0NUhmb2VEeVdJVFoxUzlhSS9YVG9w?=
 =?utf-8?B?cUZlWWxQV243VDBSakRrcWZKM0svM00vYVU4UlRiaWFpVVZWS05BZFVNSnF4?=
 =?utf-8?B?ZzZqVEk0Wi80TlpITmd5bDFVYXFEcjNPdHA5U0JJeEpBV2lPOXVxL1ZhVzNC?=
 =?utf-8?B?dEhiSzd6a0FhM0taL2FVRFppZjVyMys0eHRLQmRWd1Q4aTJCNlRwa3RjQUs2?=
 =?utf-8?B?UURGajdwWWJjZy9lUkpKNEpsT0ozSExObXVzQ0EzdWdGWmxjUERNUFZHa2ND?=
 =?utf-8?B?eFA3bGNRb0l5WG1tRkFsNEc0OE9tYmcvaHdZTm5jbUdjWldsSVU2YVJYaE1x?=
 =?utf-8?B?V1gvTWpHNlFncVRSZ3NIWEhiZjlQQUp5N253MmFvYW1wQlM4NVFNWFArYTJr?=
 =?utf-8?B?cGxPc2IyK2FpOUhCTEQ5RmVjcGFrZDFTbkFqSEJSMlZuYk1EcmJudnV1eGh6?=
 =?utf-8?B?YTJjNEJaMTNUTWwvMUhFQjhwUjZvVG1WY3RzTzNoYUN5dGorOFhGMDNKN0Fr?=
 =?utf-8?B?b0ZDYjdMRWtUTVI2QUpNV1Bvb3BBYU00bHBabUpuNUVSTzBwVTNiRTBBd29z?=
 =?utf-8?B?WkdQSGtKaXM3MGErdHBlMzRpdEtZSTgzNmtjOG0wRklVS3VqZ2VMZHA1eWVK?=
 =?utf-8?B?azRKQ3orbUNqVW5tSjI3cy9pcm5XSTJuZGZYS3pxZi9VcUo0KysybWtiK1hX?=
 =?utf-8?B?c214bHZaWHQ3SDMzQllWM0xaRlVlb0RtY09tU3NIYjk5SmQ3OHVKeSsyZHkv?=
 =?utf-8?B?Q0JpUy9iNnBkbnp5bDk2aG15NGpjVHJlZVJEb3dDT2tDUS9VbFRXc29HbUdE?=
 =?utf-8?B?dXdRcnUxNzN3bE15c2FDcDRIREVuMXhPdVF3Z0Z6c3l6U05ZMXoyd1RpVCtv?=
 =?utf-8?B?ZFA3RHN6ZE41Y2U1OFJDWFVGRnU1dC92aVVjdzFMRytIU2UyREhObFUzVE5Z?=
 =?utf-8?B?WVlLclZIeXZFRU40UW85dmRZanRGVk5saW40L3BndTNCWnYreGNKbDc3c1d5?=
 =?utf-8?B?clBWMWdySDVhS3prc0dhdk9mTlJycUV0TmlnQlVLTHp3NXV6M0t0SC9UVHZY?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f063740-4dfe-4246-2895-08ddc2ba203b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:38:01.9417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE4a5LOBxJH5bSTPlit16AJxgHluXM5P/0e9GxvIX4f9+xuWyQVZv914F+zun6kghpfd+Ktdjmq2VSDW4IyTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6668
X-Proofpoint-GUID: TRoGmGMpYksHo6xXSAorBAi3UJuULZY7
X-Authority-Analysis: v=2.4 cv=TYqWtQQh c=1 sm=1 tr=0 ts=6874cffd cx=c_pps
 a=2PF/rzsYy3Hr2OqMyPqH5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=SufIU1wYzQAA:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oNB0EVl51CnOnwl0ee0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TRoGmGMpYksHo6xXSAorBAi3UJuULZY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAxOSBTYWx0ZWRfX8PRADJoZVt2R
 lGzpWHDsQ1oyCWG9BTxGgfETkGAdnNWEBTLlpRmfHiEAxHHusTQq/lMZo0IXjAkbTtsUS7CxXds
 anJS5oJRkknmQiuaLMBzyTyN9BNvwsxf8/btkTu4lINBraNr9oCejL8LSxWYhck+/1lUwYA5Sc4
 A7hmOYJBYnpjmAZXY4R/LKgLC1m8YsG9vKqwhvXq6F/54aUmTP+n/6vTw0i86DIXi8saDGapvFF
 GEQ5WesDhhhc0WmW8RRzSSXr747rquyxX+aUi8Wl+3vquWb8zpdKslRB7VnMgMN5IFXzWxNFNSx
 4gyVN2p3PSbyKD08VGiI810fIgJPu/iNkpAMOwXRB3Tc+XVg0zRo8q+/BpIqjCup4dB/lkpZbzG
 2WJBsnUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507120019
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
From: "Yu, Mingli via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Yu, Mingli" <mingli.yu@windriver.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

The lttng-tools test fails as below, is there anyone meet the same issue 
and how to fix this?  Thanks!


FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
[snip]
FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
[snip]
FAIL: tools/clear/test_ust
[snip]
# Wait for viewer to exit
not ok 486 - Babeltrace succeeds
FAIL: tools/clear/test_ust 486 - Babeltrace succeeds
#   Failed test 'Babeltrace succeeds'
#   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.
[snip]
# Wait for viewer to exit
not ok 706 - Babeltrace succeeds
FAIL: tools/clear/test_ust 706 - Babeltrace succeeds
#   Failed test 'Babeltrace succeeds'
#   in ./tools/clear/test_ust:test_ust_streaming_live_viewer() at line 324.


Thanks,
Mingli
