Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6CCD1F9A7
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Dec 2025 10:10:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764843033; x=1764850233;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-ID: Content-Type: Message-ID: Date: Subject: Subject: CC: To: To;
 bh=8qtmSIJZcmd+c23Pl90hvcJmqMzh7TWeG1FJVKLPUWw=;
 b=sgNgWtV8zJAvpD5W7BggBZFAxzxBO8iDSZk2dzONNxNyaUhVdsDFKcVlmmgTUcKZ+nV+6ICWkke9GNWa9DwZy3SEBWf14fr3jZDoJi9D7Q/Avgt8h3zK9Uxa0TRzAoDz9v68uWtSxGFB8F8dBLf3p3iqCWty04KhMOrB4F6+x5/JnQI8+M57buoqAYAREeqczV+WY99oUK7xJLqJT0m6AOJC7NmnCr6pvl+PogTeWOVOjJAw7wAVKVlGDQ8y7jbbKhpXeNVsqI6YQe+5DBYqKkurjbJTl4YGKD/dUTnJCaR3TDJv+x/epGr9kBqdoIn1/JL8eD/Q2c2ztYf8sR3Qeg==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 132f431f4c8e9587dccf8c53258228023a2131a88151b390cf253b9b09a0abdf with SMTP id
 69315e199ead11955a995849 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 04 Dec 2025 10:10:33 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMVd335NNz29pk
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1764843033;
	b=gO0fiuKaoIb/AxU3coBlzaWKOXTS1QyHRWIRGPgHeZZN0b3IGCSEVhZx0WWnZZb5GSZb
	 UoSCYv1W8DrO9i7K6aTWRvklkWs6NIR5kpiaCac/5CjJGQa0sjYfTI72r0FqyofbaGEZL
	 x5+KTb1Q0HNegyxiPyE8rgX3sFlj+cfx+TrqrxkoDazipynwuDW8rFggXQKantfIHYrWg
	 Zkeh/9GQg9RJd8eIhTVKtKEGngCrXftv9kvPK1RGDHuenPRLCiYheb0vDiLE5m40j/0yj
	 KIeDomLy3QPIIVms1SilG+atTg3CVQ2aE5OJOTWPnZuJLxwiOfV2ZC15ZMi+UMocCLA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764843033;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=8qtmSIJZcmd+c23Pl90hvcJmqMzh7TWeG1FJVKLPUWw=;
	b=nQIMSAh2+QHWxTO/Pp8bY2CLq5ey/Ol0D/Q80Hz9FY/pCDEgLewZwUGUtrl8s2/YQfjM
	 rzNqeU1UcvHSYYG81/xrgkKJQMwy75ImIzbglcU1NAmy2EwOD7qzdr37X5GhaTnYPIhNV
	 kNDX+P6XU/6+Kxm2cczDeYWN3uSLuBWK9YT5EVj+ByWC4nebAh3ZzPh0AP97QHhqP0gsT
	 FAlAJsbtH7RQi+1RM+ATVO6zPE3zdHBNAaX1lQ9JGGdWmfac8K0Q+a/yuubhgKzZB44Bt
	 8wNpbxcQWmbeaIIDTawZLFS53YT/rsXHECrvOxLwOrm6+ZYWLObp7jBmLk3gEe1pxhw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMVd335NNz29pk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764843033;
	bh=8qtmSIJZcmd+c23Pl90hvcJmqMzh7TWeG1FJVKLPUWw=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=JzDXJemV1v2/iGur7R1qsmPVJU9eBzF9kixirADX+sRGJSY8rz1UfEUKOqH57dyMU
	 VPnOUgDRd+hLL/MtCVUlyKRyyi0PrOp83dg4JCmFUhQTJo/sxzFSVekEPomiml2qdo
	 jhymCpH0DWR4D4QTqTnjikAZ/YZm5A5eKhWtZcIe5lr2rPD0nTgbsKcG38uCnI53ii
	 gGf+s4A8awrQY9p2BNmIU3kxmcUr/vrwpQoEedPXOfOWetzXfTzHLSqFCJ/nJ8Ib4r
	 TUAxe488dexF1VaIolYDcrmbsZjPKAecCKBFLUhcGQvpVHrPtR2OqVUkFcNsQc7Du2
	 Bu8UY5BQbU+Dg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dMVd335NNz29pk;
	Thu,  4 Dec 2025 05:10:31 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMVd05xYFz2B85
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMVd05xYFz2B85
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
 by lists.lttng.org (Postfix) with ESMTPS id 4dMVd05xYFz2B85
 for <lttng-dev@lists.lttng.org>; Thu,  4 Dec 2025 05:10:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLNddOy/LDwmR+cJrZsx104EnZ85tYdEfIp+Jv6Zg2uvt3HxNMeFh3HDYYdkSJY+jE5J4qe/ZLZsNdcJvR9xqAMuFYrppADZJ7QzSm0ReX1DVijK+LHAt3e8mOxFFx+UPHP0l24+eFh6uvJvCtuzHbNslYrP59MTqgsg0ZyuNcCApgsPspTwYhcXhAo2GOGjbGFgmjGli1VAWfbPvHr+Mj86CtoBb7UmsRsKgQddjTj3C0kwWBzDGZKdWunYqWxpa63HgRzeTqyDzzLQND/59NH7prb9cpBD4JdCSibtcFXEaS4Rw9xGJcmvR1JFsoFkBjtOSgu1tYJ5hHvVCvcr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qtmSIJZcmd+c23Pl90hvcJmqMzh7TWeG1FJVKLPUWw=;
 b=GKyHP19vtxsuLit1Avy3JWBxRtikMS7NY9GH7+tcyWmU6YfAaJ5y6bHtkmosX4kgKuNzAVjKzVnr5K4ysqp7c57OJEbZqcZX/BnH2hVAZTyY1kPzWLPOHQ/Ukh4qf7Y+pnYECdongRhc3qikoT51AfgbBF385R7m7BSRnh0KuUUIDcsslVnzUMpqP3IlEzXlcp1WPmNOgpmq0nTCmMH76UcHsgAb/ljXvM+9+aN6/m0XRukxGU2DKyzn9LmUlRi9/Q3EH460YO5OIyLG1blM/6yyoKEwa9W3NJX4LpnSo008FweDFJA4gfMuMlKmbWN4bst6Kv9ZU2IgqWJji+F7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV1PR10MB6442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:10:24 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 10:10:24 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Poljakow, Andre"
 <andre.poljakow@siemens.com>
Subject: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Topic: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Index: AQHcZQY0v/YP1lJ+F02U1q1NkpgqwA==
Date: Thu, 4 Dec 2025 10:10:24 +0000
Message-ID: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-7 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GV1PR10MB6442:EE_
x-ms-office365-filtering-correlation-id: fe813ff0-e320-4a3d-1317-08de331d576a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VVBTbW1IRUUreUNnUFhYeVBrWkpMYmJoa2ZSeUJWd3d2dFBvTHlTejBQeWRo?=
 =?utf-8?B?K2RXRnIxaG9zWE5ySGd4cDBkNkNlZXBJeDRpdGw5U2phekFoT051UG9YNkpr?=
 =?utf-8?B?MTc4MEY1ZTdQaFV3SXV2bmVDbzBGdlB6OXNVY3l1WU8zN2t2V1JCb2ZLQWZo?=
 =?utf-8?B?UlRiWDVMOW41Z2JVeXdpRmhiK3BvWGk5RTRSQW9jc3YrSkhEdGF1VSt4OXBV?=
 =?utf-8?B?SzJSRWhzZDNLYTlzZGNodW1obytOS1FIVm9YdHZBT2xJR05SbE9DdWhDTTJJ?=
 =?utf-8?B?MkdZQ015NlJOdUV4Vmc0UTNXZ25hLzVadnl6VnRjRGt3WHhqOFU4NU9la2JF?=
 =?utf-8?B?QStkMnVQS1dVdGRyYzhvMFBEUzJzd05POFRJQ2s2Tk8wUHh1R2NLSFljeHZJ?=
 =?utf-8?B?YzdGNkVFL2VybVFORmYxVDhqeHl4Yk9QTWl4VmRIMTJFb3d3UHdjK0psRUV1?=
 =?utf-8?B?UTd6VVRYTFUvTDdHbUhZNmRoVS95OGptaHBHVHdYbUFpTHdIUVhlMTNuWGEw?=
 =?utf-8?B?bTF2RVVnUFF4THdLc2xBSzVpdURtK1RGSEhHS2Q2SnpjZmphZ1k0cVozWGFQ?=
 =?utf-8?B?VjdBank5Y1FlNG5yZlBuUkUvQVlGYzI2UzBkNUJUTmtsaGpjTUE5UHZxQzlz?=
 =?utf-8?B?VFgrMHdkOTFHZ2lHNlI1QTIweHNVOWtMUkRVQWNGYmx0WGtkeE44K1lBZS9H?=
 =?utf-8?B?YmhPVXVZcGltc2RDN0VJdGxNK3ZkSzRyK0UvejFWZkZPa3dmL2Qra05tcU1I?=
 =?utf-8?B?YnVHRmphTldkVmdhRXhMRXpDbTNJZlIzZnRUQ2dtT2s3QlFnT1dsV3kvUDcv?=
 =?utf-8?B?ak5ZWmpiUGwwZ2xOVXRGdUZiQ0xJR1ZUSG9YR1djNkE3SlEyWWRQa25DUzlx?=
 =?utf-8?B?UTI3VTJpdG5SV21CZnZhVXNoMkIxdnN0OTZSS1NmYStxdStWR0lXUGd4eGk0?=
 =?utf-8?B?RVI0eEhEck5nSXIwSm1ETGx1dndWYzVBSUk2Y0hYMDhQSUR5MnFGVHIzYU0y?=
 =?utf-8?B?NTVvaXVYQzR6WnR4K3E0WEQ0dEZSQzRLSzgzbytBSkhNTVJ3Tk9BY1NaV3Za?=
 =?utf-8?B?ZEVSNEZBSVlndkRJTytLbG00cDFpRm1HR1FOa05MR2J4K05NWkpHWVg4MHI2?=
 =?utf-8?B?UVZyMDVVUWM2SXlGalIyTEdaazF2N0NMNnA4L3RNZ09NWC9Dd3VMRXRXc0ZC?=
 =?utf-8?B?TlBvbXNWSFNLYXBGL3c3NHJIbHh4eXA2TVFURFIzakdnWVJmcklVaHlMNTFQ?=
 =?utf-8?B?Wm4wOFhiMDJMTXhVZVlDYmVrNzJMYTM1VmRYT0V4QTZwalgrZmJuUmpQSHFI?=
 =?utf-8?B?dHVHcDJJSk0wblhOd2RqOHAvL3Y1NVpNNzlVU0NndEhRTXBxRnRJbVphY05P?=
 =?utf-8?B?WmlaMkluT1R5V2E3aUllR0dRZElWSEg4aWJzVDBaZTRmeXFCN2I3c255V1Z2?=
 =?utf-8?B?Zlo4alJka1JnMklselBEUjMyZVc4RTVNbjBKRDArQVRVeXdRQk5WYXR3VGo5?=
 =?utf-8?B?N2ZMaDRzR2ZDVHZiZU43TlpTWmVxeXV0Y0wzd2hrOGRaRXFMSUVTS084NXFK?=
 =?utf-8?B?dU1QYXc3ejl0dTBkQncwUXNMcUpCL2V1SXo1L0pPYmIvU0lzcThJQzFScTRp?=
 =?utf-8?B?cThhU0dIWkRmUU5ZckpBUW5oNThKYnQzWDlGWnh0Ynh0bnBJNTJQN2JFa1B4?=
 =?utf-8?B?V2Y1M00wRnRMaXJzZG9QcDAzSkZLUlpPMmYzT0xEcnBtZUdLdXJLTWNTRzNa?=
 =?utf-8?B?bUsrMHhTZVBFcjlZREpaeE0vaHhwZzBIKzF2MG4ycDQ3ZmdGNHo0a283Slda?=
 =?utf-8?B?cVEvKzhFSDRTcXVmUGxJSFducHRYbk5QdFZ0eXgzNWhWa1JMSlkrTW1hUHN4?=
 =?utf-8?B?L2tieXRsVWVNWFl4SjRsVlBZSE42TkNLY3UxcnlWZ2V2b0ZuTzVtcU5sL2JV?=
 =?utf-8?B?dVAxckM5NWwzSG5HclFJSUlxK3FwY2ZWcHhibXVETExaY2hZZGk4TitqN05N?=
 =?utf-8?B?djNPMGNhUzRBeWhBNHppUi9CdmpVMlNTSS8vNWtyYXBaL0FtaURoQUlpM0V2?=
 =?utf-8?Q?3Sv8yP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUhVTDJ5b0tSbWpRVUN3SDkyQlY4b3UyN1M5UTk4dUJvWnNKUjZLUVhQVE85?=
 =?utf-8?B?THJBZWJMdTE1SWYreHEyMU9VTU1NZS9tMXZ0QlJkTDZMUWpjdHNjWGdIbEFE?=
 =?utf-8?B?a0tZaGdzdWtubGRBUHRTU0tEcUtTcEtoYmdrS0Juejl0L2lEeFpUanFlbGlR?=
 =?utf-8?B?cFloN2kwbVptQzRwc0FhbzVjTzRPdm1YUW40MWlINTNZUzlTb2xJZmM4UStq?=
 =?utf-8?B?YS95RVNTcitoQUdQdHo2MGRIaVBOaEF6K0lGN2x5SFlJNm1JY2d0VFJockV1?=
 =?utf-8?B?bUFELzVjVTdJbnZybzkvWStucktUQmxDQmZIMW5NZTl4SkhmM2s4Q3hmb1ll?=
 =?utf-8?B?WFpUN3RkckJlOFVvbjNBREs3REpXZkVldFJmYVdTaDFvMnZnTlAyaHFiL0J0?=
 =?utf-8?B?WS9TZkcvenhYb0ZRZ1p5SFpBTU5jQjJ4dmw1bFlRSHMwWXMra21WckQxNjJh?=
 =?utf-8?B?RUU2dEZtYTUvOHlUSzU1aitDbzYrSEZORUsvaUMyR3FONDhNcnY3TWNRMzB0?=
 =?utf-8?B?cHZ2Ri92bldINHNxQ2JQcEE0WUJEcjcycWFBRElncGJxc3owMmc4bVZDRFhO?=
 =?utf-8?B?cWJqVUFnY2NOYmFHOTR6Q0ZGRTFkK0prUDVwZjlCeHhtdWdPM01CR3RMdExN?=
 =?utf-8?B?Q1FydnFhMVlRTWRvejhzbnFrSXpqdEY0WnVyZ3I1SDRSYUhZVVE5a1V3Q1lE?=
 =?utf-8?B?WVFyY0k2QWJPaFNxTHpwcERrbGpZeFZJcFpWVGZxZHdVc3ZzekRJNGRlV1NC?=
 =?utf-8?B?L3BVU1BGR2JsVXB4RTVHV3YyVkJvRFJTemZLc3g5c01HOHo2Ym5tbFVQSXMw?=
 =?utf-8?B?aEhudHMxQlJ1cnFHaG9PMG44RkwrRlArMzBlZXhZTEZGa05tUXBETU1yNFRa?=
 =?utf-8?B?am4yMWFyRDQ5Qm9Bd3Jvam1HTlR6QXZzNFFFRUFoUitvMCs4T2xnR2M2L0pQ?=
 =?utf-8?B?V08wTUs2U0pXbVVFLzBuWjAyK1UrdmdLZGdVbjJwOUhaSzQ2anVYT0hXRSts?=
 =?utf-8?B?bzNhckErczRQNHZyeXJkY0toeU5PQXVjeGJlU0xnc0JtQXc0TG0zblpSNWda?=
 =?utf-8?B?cmsreGpJSVo0Und1dmdyVkNlNTRWNVBKb1FmR3VuNUNpckN4NlRTc2tMSU1u?=
 =?utf-8?B?Rm1nZ1N2bUU3YmxTRTdOZHFJT2RLcDZBeU9zaFJ6V0xZUFY5bFRYTU9xeGZP?=
 =?utf-8?B?OHJ4TEV6dHYrVGtxR05tRTVicmYwSXVPeHdLVXpyT3JMRnBBSTIwcURBYWNn?=
 =?utf-8?B?a0JhZVRUU0M2cmtGc2dYSjJqMDgzWEprem9wWCtJeWZHL1NhZEJwM2g3YXJ4?=
 =?utf-8?B?QSsvRzIzWDNtRHcrWllyUFp5bFEzUEVrRDU3dkkrcEVFTWozU1FDaUp0c1Np?=
 =?utf-8?B?MmtyazhPNUdzWlRGK1VOeXNkQnFCb0hWanYvVjI3cDR3S0ZXb3pUeGtid3cw?=
 =?utf-8?B?cTNXNlhzQ0ZzUGllZEJLQ3pYb0NHTmlMaHpsQ0hDcHhvdXF0cElrOE1yUC81?=
 =?utf-8?B?bXRTc21MS1AvSWZyMDB2SGN3MlhiS2VyOVlVRXBzcnNCYkEvdFhObVI1TDV0?=
 =?utf-8?B?SVZSQ2FqTGFsS3hHUDl5d3o0dS9YUUdXcU5INmJwRzRwcGgwNEJTTC9mOHBp?=
 =?utf-8?B?NmN1RXA4WWEwdldzYmFUbGlWdzVtY3p4YmlVVDRlUUt2OVpTVGtVUldMbnFu?=
 =?utf-8?B?VHRVcWtCbU1mY2ZRWVh2ek1YUkJGSUkwNnJ2eFpRNlM4NWlCcmZHWE1kM1VH?=
 =?utf-8?B?NlhIaGdKWk5EU1ZkODM4ZnVudUppU3plYWEyK0wzMFZkSnkrUEM0RmJKbGUz?=
 =?utf-8?B?ZkxtVHFEN09qZ3hkMUxNTEFKT25KbE9UUUVrYTd1OFBvd1FrRG5wUGJ5Ym5j?=
 =?utf-8?B?Mk9NMkYxWG92aFRIL04rUWhZc3BMam04WnNmMzRubWRoaHl5UjJMZ2ZOY09O?=
 =?utf-8?B?cEFRRlhBdjUrL3Q5UzZyZFdRTDFhSzkweVF6d3duV0FzN1RidUVuRk9qTFlF?=
 =?utf-8?B?Nk95Z0RTYUhDSnVWVzgrVit2djVpc1dZT3NZUkZsZExvUDZrYXdDWi9tbzlr?=
 =?utf-8?B?VXpBVHZaakFKNDlaTDRkMWhWK0M2bUFiWG9MVGdqNVdYeW5ZQTIxajh2SThS?=
 =?utf-8?B?RFRvVkZGUEJneFNCeW52Z041THdXR1Bha29YTnIwQjJhRjF6aU16YTlNbDE4?=
 =?utf-8?B?WEpjaFkxT1F3MWg5VCs0a0dyQ0VNbUwyQlNmSHBsRzNicEt6SXZDZjlPaHdY?=
 =?utf-8?B?M1lWYWpMdXVBZVZjL09lUGluY3FnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8847D9B7AC0064395832F43F98BECE5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe813ff0-e320-4a3d-1317-08de331d576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 10:10:24.6486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E35fvnkrTzg+if9x82IYsTF2P+1GcD1uEdEcBI8vJES4EoR7gSpye28rBOzxKZcPsz+K8F4Uadzha1aVs2APYfxoSajXTNxJTggE1jG/UwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6442
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
From: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGksDQoNCndoaWxlIHdvcmtpbmcgb24gdGhlIExUVG5nIGluZGV4IGFkZGl0aW9uLCBJIG5vdGlj
ZWQgdGhhdCB0aGUgdHJhY2VzDQp3aXRoIGluZGV4IGFyZSBub3QgcGlja2VkIHVwIGNvcnJlY3Rs
eSBpbiB0cmFjZS1jb21wYXNzLiBUaGUgcmVhc29uIGZvcg0KdGhhdCBpcyB0aGUgZXNjYXBpbmcg
b2YgdGhlIHBhY2thZ2UuY29udGV4dCAtPiBjcHVfaWQgZmllbGQuIFdoZW4NCmNyZWF0aW5nIHRo
ZSBDVEYgbWV0YWRhdGEgd2l0aCBzaW5rLmN0Zi5mcywgYWxsIHVzZXItcHJvdmlkZWQgc3RydWN0
DQptZW1iZXIgbmFtZXMgYXJlIGVzY2FwZWQgd2l0aCBhbiB1bmRlcnNjb3JlLg0KDQpBcyBvZiBD
VEYgMS44LjMsIHJlYWRlcnMgYXJlIG9ubHkgcmVjb21tZW5kZWQgdG8gc3RyaXAgc2luZ2xlDQp1
bmRlcnNjb3JlcyBmcm9tIGZpZWxkIG5hbWVzLCBidXQgdGhleSBkb24ndCBoYXZlIHRvLiBBbmQg
dW5mb3J0dW5hdGVseQ0KdHJhY2UtY29tcGFzcyBkb2VzIG5vdCBkbyB0aGlzIGZvciB0aGUgcGFj
a2FnZSBjb250ZXh0IGNwdV9pZCBmaWVsZA0KKHN1cnByaXNpbmdseSBvbmx5IHdoZW4gaGF2aW5n
IGFuIGluZGV4Li4uKS4gSnVzdCBtYW51YWxseSBjaGFuZ2luZyB0aGUNCnBhY2tldC0+Y29udGV4
dCBfY3B1X2lkIHRvIGNwdV9pZCBmaXhlcyB0aGUgaXNzdWUuDQoNCkluIG15IG9waW5pb24sIHRo
ZSBlc2NhcGluZyBvZiB0aGUgc3RydWN0IG1lbWJlciBuYW1lcyBpbiB0aGUgQ1RGDQp3cml0ZXIg
aXMgbm90IGNvcnJlY3QgYWNjb3JkaW5nIHRvIHRoZSBDVEYgMS44LjMgc3BlYzogU2VjdGlvbiA0
LjIuMQ0Kc3RhdGVzLCB0aGF0IHJlc2VydmVkIGtleXdvcmRzIG11c3Qgbm90IGJlIHVzZWQgYW5k
IHRoZSByZWNvbW1lbmRlZA0KZXNjYXBpbmcgaXMgYSB1bmRlcnNjb3JlIHByZWZpeC4gSG93ZXZl
ciwgdGhlIHNwZWMgZG9lcyBub3Qgc3RhdGUgYW55DQpvdGhlciBuYW1lcyB0aGF0IG5lZWQgdG8g
YmUgZXNjYXBlZCBhbmQgYnkgdGhhdCBhbHNvIG5vdCBuYW1lcyBzdGFydGluZw0Kd2l0aCBhbiB1
bmRlcnNjb3JlIGl0c2VsZi4NCg0KSU9XOiBUaGUgQ1RGIHdyaXRlciBjdXJyZW50bHkgdW5jb25k
aXRpb25hbGx5IGVzY2FwZXMgYWxsIHN0cnVjdCBtZW1iZXINCm5hbWVzLCB3aGljaCBJIGFzc3Vt
ZSB0byBiZSBpbmNvcnJlY3QNCg0KSSB0cmllZCBmaXhpbmcgdGhpcyB3aXRoIHRoZSBhdHRhY2hl
ZCBwYXRjaCwgaG93ZXZlciB0aGlzIGJyZWFrcyB0aGUNCnRlc3QtdHJhY2UtY29weS5zaC4NClRv
IG1lIGl0IGF0IGxlYXN0IHBhcnRpYWxseSBsb29rcyBsaWtlIHRoZXNlIHRlc3RzIGp1c3QgY2hl
Y2sgYWdhaW5zdA0KdGhlIGltcGxlbWVudGF0aW9uLCBidXQgbm90IGFnYWluc3QgdGhlIHNwZWMu
DQpBbnl3YXlzLCBJIHdvdWxkIGxpa2UgdG8gY2xhcmlmeSB0aGlzIHRvcGljIHVwZnJvbnQgYmVm
b3JlIHByb3Bvc2luZw0KYW55IGNoYW5nZXMuDQoNCkkgYWxzbyB0cmllZCB0byBmaW5kIHRoZSBy
ZWFzb24gdmlhIGEgZ2l0IGJsYW1lLCBob3dldmVyIHRoZXJlIHdlcmUNCnRoYXQgbWFueSByZWZh
Y3RvcmluZ3MgdGhhdCB0aGUgb3JpZ2luYWwgaWRlYSByZW1haW5zIGhpZGRlbi4NCg0KQmVzdCBy
ZWdhcmRzLA0KRmVsaXgNCg0KZGlmZiAtLWdpdCBhL3NyYy9wbHVnaW5zL2N0Zi9mcy1zaW5rL3Ry
YW5zbGF0ZS10cmFjZS1pci10by1jdGYtaXIuY3BwDQpiL3NyYy9wbHVnaW5zL2N0Zi9mcy1zaW5r
L3RyYW5zbGF0ZS10cmFjZS1pci10by1jdGYtaXIuY3BwDQppbmRleCAxMmFiMjEzZDEuLjQzYmM4
ZTA5OCAxMDA2NDQNCi0tLSBhL3NyYy9wbHVnaW5zL2N0Zi9mcy1zaW5rL3RyYW5zbGF0ZS10cmFj
ZS1pci10by1jdGYtaXIuY3BwDQorKysgYi9zcmMvcGx1Z2lucy9jdGYvZnMtc2luay90cmFuc2xh
dGUtdHJhY2UtaXItdG8tY3RmLWlyLmNwcA0KQEAgLTE1OSwxMiArMTU5LDYgQEAgc3RhdGljIGlu
bGluZSBib29sIG11c3RfcHJvdGVjdF9pZGVudGlmaWVyKGNvbnN0DQpjaGFyICpuYW1lKQ0KICAg
ICAgICAgfQ0KICAgICB9DQogDQogICAgIH0NCiANCi0gICAgLyogUHJvdGVjdCBhbiBpZGVudGlm
aWVyIHdoaWNoIGFscmVhZHkgc3RhcnRzIHdpdGggYF9gICovDQotICAgIGlmIChuYW1lWzBdID09
ICdfJykgew0KLSAgICAgICAgbXVzdF9wcm90ZWN0ID0gdHJ1ZTsNCi0gICAgICAgIGdvdG8gZW5k
Ow0KLSAgICB9DQotDQogZW5kOg0KICAgICByZXR1cm4gbXVzdF9wcm90ZWN0Ow0KIH0NCkBAIC0x
ODIsNyArMTc2LDcgQEAgc3RhdGljIGlubGluZSBpbnQNCmN1cl9wYXRoX3N0YWNrX3B1c2goY3Rm
OjpzaW5rOjpUcmFjZUlyVG9DdGZJckN0eCAqY3R4LCBjb25zdCBjDQogDQogICAgIGlmIChuYW1l
KSB7DQogICAgICAgICBpZiAoY3R4LT5jdGZfdmVyc2lvbiA9PSAxKSB7DQotICAgICAgICAgICAg
aWYgKGZvcmNlX3Byb3RlY3RfbmFtZSkgew0KKyAgICAgICAgICAgIGlmIChmb3JjZV9wcm90ZWN0
X25hbWUgfHwgbXVzdF9wcm90ZWN0X2lkZW50aWZpZXIobmFtZSkpIHsNCiAgICAgICAgICAgICAg
ICAgZ19zdHJpbmdfYXNzaWduKGZpZWxkX3BhdGhfZWxlbS0+bmFtZSwgIl8iKTsNCiAgICAgICAg
ICAgICB9DQogDQpAQCAtNjQxLDcgKzYzNSw3IEBADQp0cmFuc2xhdGVfc3RydWN0dXJlX2ZpZWxk
X2NsYXNzX21lbWJlcnMoY3RmOjpzaW5rOjpUcmFjZUlyVG9DdGZJckN0eA0KKmN0eCwNCiAgICAg
ICAgIG1lbWJlciA9DQpidF9maWVsZF9jbGFzc19zdHJ1Y3R1cmVfYm9ycm93X21lbWJlcl9ieV9p
bmRleF9jb25zdChpcl9mYywgaSk7DQogICAgICAgICBuYW1lID0gYnRfZmllbGRfY2xhc3Nfc3Ry
dWN0dXJlX21lbWJlcl9nZXRfbmFtZShtZW1iZXIpOw0KICAgICAgICAgbWVtYl9pcl9mYyA9DQpi
dF9maWVsZF9jbGFzc19zdHJ1Y3R1cmVfbWVtYmVyX2JvcnJvd19maWVsZF9jbGFzc19jb25zdCht
ZW1iZXIpOw0KLSAgICAgICAgcmV0ID0gY3VyX3BhdGhfc3RhY2tfcHVzaChjdHgsIG5hbWUsIHRy
dWUsIG1lbWJfaXJfZmMsDQomc3RydWN0X2ZjLT5iYXNlKTsNCisgICAgICAgIHJldCA9IGN1cl9w
YXRoX3N0YWNrX3B1c2goY3R4LCBuYW1lLCBmYWxzZSwgbWVtYl9pcl9mYywNCiZzdHJ1Y3RfZmMt
PmJhc2UpOw0KICAgICAgICAgaWYgKHJldCkgew0KICAgICAgICAgICAgIEJUX0NQUExPR0VfU1BF
QyhjdHgtPmxvZ2dlciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNhbm5vdCB0cmFu
c2xhdGUgc3RydWN0dXJlIGZpZWxkIGNsYXNzDQptZW1iZXI6ICINCg0KLS0gDQpTaWVtZW5zIEFH
DQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJpY2gtTHVkd2lnLUJhdWVyLVN0ci4gMw0KODU3
NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0K
