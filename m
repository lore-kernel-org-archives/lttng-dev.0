Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485DCCA471
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Oct 2025 12:36:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1759754200; x=1759761400;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Type: Message-ID: Date: Subject: Subject: To: To;
 bh=OV9tZeZHSjFUoC9AUIl0MjsgkMYR61Qpn4Xblhkj4d0=;
 b=fLoDuKFObBfPT+hlaWX0RzdzPZfK+XRZwyaEAS10qC4kzqTsMMAjADcU6QksLTm8JlICr+bLyjLeJ8qn8T103SChF2iWYyuZQVWY+gnhaHlpwnbibwYt5IYt6w4PewRN6Zdrp8NgBn9bcHuZOW4OrqplI3/zrXSulDB6JznoDqxjZOxdTzuaLmPMpfzK5MELogD3wHlHPGXa/AeK7n5PXTq96fhwSK0lJ8d8sLsjwIvGXXrjZ7KljIC/kT4pdljrpgTXbwvC009HTHMwaq1m/IJlQqdItBw0D99hziM2IRJNFYzr2VaPESHEP39lttXzWoZViWY6uSIlGqgbJdFaPA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 cb7ce21763157a2fccef01b8f7c8d4510fe846c167bd69d886d22849823a47b3 with SMTP id
 68e3b7d8428ade1a86934734 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 06 Oct 2025 12:36:40 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cgJft14rDz25RM
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1759754200;
	b=FJW5sE5uOa6k0+XMcCKFZxh6QVF8J+OBMjA5/Xm06fjMruLXpMEAe/LZdUiTWuPJZg+1
	 ilPXbBPZ10xpJFP/R3bkHEpLbnbIK2Q0OqgEvMhhJiy6JPKr2tAjKJw0vH0udV9n3MR2B
	 Eqkgl2MojIh0Ur7QMBaCqyjrcZimX/6yeKLVYJEIJSq3Cz/eTordkG6N3sS3Yy2n2kZuz
	 qRPhF89nEsAXr4XhdxEk90QkhN1ryoMhDDtDIrKWk4/Na2Olw2luEByMAxjp7iUMZynnh
	 huoZMCcPrFx9lGBonm7MCS77ZlByvRtP9JbuBFGm8iZs+d2m/WRPhpy4AVW/9cDtnxw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1759754200;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=OV9tZeZHSjFUoC9AUIl0MjsgkMYR61Qpn4Xblhkj4d0=;
	b=gUlg0d6Zxspw29b3RJid3Xq+fc4Lqj9gOMzUVhwjbk8NkftKuLA16PyMAgYRh54H9cRd
	 S5Jko6ceMUqeGdi9BxaO8Qfn/YLChTptEmRgiOFAvAAMGNdi/tol/SIRgrbI37ef4gw4i
	 f88pqEH5YP08HihmMPuoMOPUbZS1jKKgMOHBmb5hWfKzXd9TYmftbv8bknulEa5WGgXl4
	 oH8xtIt/htntwtWmRJbHAYCT9X3Wy7T8+w8AU4cwCuzCXg4bWVcR6RQIFK7MCx6+xP5B6
	 jTt2x9jy/COzYgs2NCp2G0h+aBeeiR6T7ZojsxWo0SA3HbZTROG+H5mtTX122Nn9SYA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cgJft14rDz25RM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1759754200;
	bh=OV9tZeZHSjFUoC9AUIl0MjsgkMYR61Qpn4Xblhkj4d0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=dyGnmCymp8P06zY3mRITvO2OrYCF2sRNkS6CiGjPW+j5VSIXCK6Vyo+yVVr7w0h9m
	 YU5uc5M1rfPesVGUvxNdRgz2BO2Hl2SFBMn36pBGDqjhCDzc+S1BJ/2TgkV1n4k6us
	 t9NBkNG0Dd1woIOob+iFP1yM/hVEKPYy4y6pX/ryh1NZ7Rg1IyGxt10a6/a/X4HpNY
	 C11fzjjcCXnIEvfYdp2GDsKTTkfngLrbKNh3RfiidAKN+cCCmofI9AR4ukyv6XKrWg
	 GV2K30r5NwI8IMXtAniAN7T3O4AycPR/wSUevxG1F8YnPaC3fYpImLhgRpOu2emd0z
	 An+ofGh72U1xQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cgJft14rDz25RM;
	Mon,  6 Oct 2025 08:36:38 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cg3gt0Grrz20h9
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cg3gt0Grrz20h9
Received: from iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com
 (iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com
 [54.211.126.101])
 by lists.lttng.org (Postfix) with ESMTPS id 4cg3gt0Grrz20h9
 for <lttng-dev@lists.lttng.org>; Sun,  5 Oct 2025 22:51:37 -0400 (EDT)
X-CSE-ConnectionGUID: pNsUXERZTXyx7KqYWexaow==
X-CSE-MsgGUID: Xb0ixjhlTKW+ME1I2fi8kQ==
X-IronPort-AV: E=Sophos;i="6.18,292,1751241600"; d="scan'208,217";a="3833834"
Received: from ip-10-4-10-75.ec2.internal (HELO
 smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
 by internal-iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 02:50:26 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:27230]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.196:2525]
 with esmtp (Farcaster)
 id 3ed94c91-7747-45f4-9d68-030b4e595ffd; Mon, 6 Oct 2025 02:50:26 +0000 (UTC)
X-Farcaster-Flow-ID: 3ed94c91-7747-45f4-9d68-030b4e595ffd
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 02:50:26 +0000
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 02:50:26 +0000
Received: from DM2PR0701CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20
 via Frontend Transport; Mon, 6 Oct 2025 02:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5h92tS7kytIA0+0A2UKB7e3gnZCpzMvpQOgclpu287mStihG8ofY9gVgJ3rLZzo+VW4gJQ6DjPuZXb0gq5GUgG7du5r8zxoya7oEo+WlpTrHjKx4+7Cg58xPyqLFcNxBFd1g+AFkuhfCAajm4ccsHe4xB2PkdG4noBYk3AFpXU6WH7DIMvXlTHsWcXGapY+Dkm9Re20V3o2LQqYwKVID5ZljqDlaAAltt6efq8IEyQVwXxYsKshQg09cYrEiOxji2TujtxMRsn1SetySnj75kkRW2saa8nmS3ySqYD+/RkrAV6PqC89mum29l1RaE5xaHItbqLwD/mdyjJn10PB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV9tZeZHSjFUoC9AUIl0MjsgkMYR61Qpn4Xblhkj4d0=;
 b=EyBnqsEH3RUmGElMiUhUyZeX17FsgT5+dK5iUBDXhtYhZ1LwB2sWyGM611vqHpn1QJQbr6zk521rtHYI/GEMXYkIPuwqArTHxwSlFQxGxqP2NrsczSY42E2t9IKWBxcVL6Oa2s4PAZO4f1AtX96swdpfBEU0Y+nuKqaSM5Sce/RxGjAaUyLMUHbWkZACD5r4fHjcTjB3iup36rYtB9UpMTaBVdvuoLyhhsXanEj5DRxFeg/rX+y8VnjjKR43N+usQsDJV2e9qlSRobYRTAj/hLvpF+ekWzUkpIfvmkWT9ap5GmcatTIsAPIb3IELQQEFJM/hNx6jZre4z7lb0DV2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SN6PR18MB3709.namprd18.prod.outlook.com (2603:10b6:805:5f::32)
 by MW3PR18MB3674.namprd18.prod.outlook.com (2603:10b6:303:56::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 02:50:21 +0000
Received: from SN6PR18MB3709.namprd18.prod.outlook.com
 ([fe80::5e6d:ef43:2a94:299a]) by SN6PR18MB3709.namprd18.prod.outlook.com
 ([fe80::5e6d:ef43:2a94:299a%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 02:50:20 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Call stack context for user space trace points
Thread-Topic: Call stack context for user space trace points
Thread-Index: AQHcNmv0dWoGdA72Dk6mjtZhg4XLGQ==
Date: Mon, 6 Oct 2025 02:50:20 +0000
Message-ID: <870C2018-7321-4478-9609-9A75F99468A7@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR18MB3709:EE_|MW3PR18MB3674:EE_
x-ms-office365-filtering-correlation-id: c0507469-f49b-4f1a-ca94-08de0483171e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OWpIVFN4dk5zQnREUUZCSzhVekJrZzJEYjB4VUJVeTBlS2pYeG9iaXROY1RP?=
 =?utf-8?B?b3JIZy9CWFZoWnkzenJ4RDI5b0xRTGlVazM4Z0NWeVU3NXNRR0hqM0RUaEM2?=
 =?utf-8?B?Y1ZabE0zY0NlLzg0Y01pLzlMeVBrRjg1TDMvamQ1c3JwbGpGaG5oRDJ0TVZp?=
 =?utf-8?B?U2grTFZrM2w3dythUVRoNTVjcXFVOEtmbkxOWVdUTWtXMG1NbmYvVHZXRTlk?=
 =?utf-8?B?cVljdUg0TXpEbjhlb3liaDg2cHgweEdqWHFIUzk4L2VuRVJCbkc1a0JXVTF5?=
 =?utf-8?B?T0hPU09uSlNsNTcwZ0Z0alFXektBNGVFVXJlKzdSZ2ZXbUFjUWhTTkxLa3NG?=
 =?utf-8?B?NmNnUHg1a0pBRmtzendpalcvdXNIOStGaEJqLzZTQXN6b2FGY2tHc1ZwVCtU?=
 =?utf-8?B?K0k0RXVibXBmQkhZS2RUa25PTzQ5cVpxQTRDU2VoRXM0VHNqcU1wNGhISlgy?=
 =?utf-8?B?WXRjY1ZTelZaM1Z5QXhOTDRscE93VlVLWm1zVTdLZnNDemdmQ3BxektWWXFy?=
 =?utf-8?B?K1I2aXlGK3F5RENZQ0ZYcEc5S2t0YUdESDlLVDZvcURqa0tpdTQ2eTNjdEgx?=
 =?utf-8?B?YXlzSnVwVjBVYTJXZ21wbmhINXhuakhad0xsVmVYRUJ4WlEvN25HVmppU25t?=
 =?utf-8?B?d1JtcnJkaStTWFFGVGNVQUJJbExGUThuaFRKUFd4L24vN2p5a0xtVWdWK1hB?=
 =?utf-8?B?QlRTRVdxZUZjbVVyM3hJWTlJY3pXaXM2YUoyVHB2RzkzVnlkV2drSGtsNFJ0?=
 =?utf-8?B?bmQzMncxODdJcExYWEp2SnRyUkVaYmcwd3V6SFdnSUk2RUhyQUk0RDg0SGRT?=
 =?utf-8?B?SVBsSE9jMGdsdGRybWVmeFVGYXdJeUtFNWgwVWJZem95Z21seXdJU05NMXpS?=
 =?utf-8?B?bWFiYTYvTjJDa0pPVGN5dk95WFkyMzlUTGpTQ0xHRWdSLzJ1QjdWdlg2anE3?=
 =?utf-8?B?QWdsbzdCM3JUSk1URzJJTDNKMkhQOFpSZDVaSXlybXFTUE40eExSWUpxMFBy?=
 =?utf-8?B?dzhQdlVMK1RIQjBSWGQvbHNRMGpRUHFRWXdLbmxtOFNtaDZVNk9FbmNYczBM?=
 =?utf-8?B?UEltVm1jdmxka2VlenFzTVhvZGZhSFVFZ2hnQ0pmc0xMUm1aNmY5L2VaQnRr?=
 =?utf-8?B?RVcrTUcrL2w4TmNDMFI0d2RyeWZUcm5yRUlvaXNBWkxITEo2ZmE1OWFpRlNL?=
 =?utf-8?B?NXh0ckRTbGhHSjA2ZEtaM0s2QUc0Vzd1RVllbWJ0M2NicXNLT0N4am10ZHB1?=
 =?utf-8?B?NzlLMnVhUFR2UW04aEJQTEFoelF2TzQwZStKK1FoTlRwajBlWmpZNzhxVFRx?=
 =?utf-8?B?cllNZ0lnL3AzSEcxUWlKaXRqOVN1ZWlWSW9LVjUvbjJTU1FMTUhlUVpHR21w?=
 =?utf-8?B?WCtRUzFjei8zY0dVaUw1VXNaUWxjYktXZmZKaXlzL3hTTlIzMHVYN1hXSlR2?=
 =?utf-8?B?Wmp0WjhRVllzRE9yTmZMdEs2dkFPTWlyUXBEL29abFJFWDRwd0MxRnVRYnA2?=
 =?utf-8?B?bHg5YjdGclhMaFdIWThLeXo5UmxSazBHN3NmbmYwNTM2elllMEZ5QUIwQmJD?=
 =?utf-8?B?N3JEOURtb0VMUHFZNVNCV0dPa0xPeGFZbXI0c2pxeXJ4Tk5lY3lzdGtNSi9F?=
 =?utf-8?B?MmMrY1RHNCswSFN1a0VWd0x5aXNHeURmOElTMmpQZ0tlQVVjL240UXBTRkRN?=
 =?utf-8?B?S0hnSEVpMmFCRUZubU9JMjhpdUJWc0JMbi9paDRQOGRnbWtOY0dBMWxQUTJt?=
 =?utf-8?B?OGo5RHkya2NLU0RXK05hWXVhamZLZy9BUDVwU2JyeVM3SUhJTUtFU2xSS1E2?=
 =?utf-8?B?SCtUTC96V0F6VUlSVEU5Y1dmcUhkOCs0bitWWi9rbzFIT2FUaHlacU5CRyt4?=
 =?utf-8?B?cTdyYVIvSk9lQWoyRVQxTkJyVGxNOG50eVN2K3haTGZKbzY3c29mSU8wZlBM?=
 =?utf-8?B?QnlJd21XeW14S1VlSGgremQxRTlYbVdhMlMyQ251VEw4K0RXYXdVQWRreHk3?=
 =?utf-8?B?bE0zSzJ0UlU5OHc1YjkvcDMvVDRqRWNiSU0vZXRrYXg0N0FPZG9HVnliQlFr?=
 =?utf-8?Q?+lG9f/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR18MB3709.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlYOW1UZTlFelViMXYrSG5Ja0ZibGdqcVU2Z21CTExDc2diSFp4YTBGUWlL?=
 =?utf-8?B?S2xGbTNVaUcrU0d2U3lqMGpKN2VFNHpVWEFyWlFKSWxzbUQvZ0dCTG5QTEJ5?=
 =?utf-8?B?MVByVWIwWnp4RnZWd2V0SVNqY3pNTlhXcDNLamVzeXV0elhSbThxV3BCSGJq?=
 =?utf-8?B?L3F2MGhVLzBpTDVYdk9QYzFmcUJGSXA5WDJhTkF6K3JielZKT0xMWFllOHFv?=
 =?utf-8?B?TXh0ZVRFQU1TOUtmS1ROTnliRVUyT2lEYU9sVjNWTFFJSW9Cd0tlME5hNjhr?=
 =?utf-8?B?c0trakptSytKbjBhYmYraUxEYUxMb0N3c0pRMzB3clg4VTRuSk1uSGRrYjRz?=
 =?utf-8?B?djVvanBjeU5KdmFPWkNWdkhvN3FZSUJyVlRnTjR5Vmdrb2lKbGRqaG5oS1FJ?=
 =?utf-8?B?R2ZwdEdrWTJMWU4zRytsZFJBY0cwdzg3bTdBemhvVFFENHBkRStUNENSb3lw?=
 =?utf-8?B?MEZXUjg5ODh6dVBhNDc0NjBJUkFERHZ4QTVsV2FDbzNpMmVhSlFydVBhVjBk?=
 =?utf-8?B?VDlWcm1UeHNPNE5zd05xVVM4RHV2VFZxM3hPb1FSeHkzRDNBQklZZWZIdlRa?=
 =?utf-8?B?T1FQV2xvNTlGbkpvM2p5VmVSeVNwalNZMGFJcFp6bmtUWTRKckNLNnVLWG41?=
 =?utf-8?B?TFlpZ09NeU01aHVYNlBLTGZuclZtT1lzR3pOMFF1TER3MFVxM09SN2pCMlFs?=
 =?utf-8?B?RmhyMWhtTnZVVE5DdzYvY3hrR0RRcXlLOHRRZUNwOEFWZmhhM3Y0dlZjb0tG?=
 =?utf-8?B?dXpXUjB3d0FwNStTamJkb1ZDRnpZQTk2U2FCcGdQZEtiaXI0Z3N0Tmd3YWJP?=
 =?utf-8?B?QXZURVN4MEM5d0ZQMUQ4UnMrQThDUUdJSUxrNTlhL1hrVzdEOGhHejVzSkll?=
 =?utf-8?B?Sm1oRU9JRktVbDRUYVh0ZlJNVk8zYUtXcm1zb2U3OXR1eHMrTGRWSEVVcWMv?=
 =?utf-8?B?a0EzVE9IRXRzblFhMVdPaUhnRDBuR1JnMmxzcEdCaTd4RW9GN0hpVVB6Smx5?=
 =?utf-8?B?YmdqVWowbENzSHhnTjVFcVVwVmw0ZlZrMDVvRklXVFcxbHZFb2k5SG9Id0NM?=
 =?utf-8?B?VGl0U2d1WFFIbWFpVllNWFdNSWJTc0NLMjNNSEFPNUdjbEFnMTRTcE0yNWY2?=
 =?utf-8?B?ZjNtTGJHN1JDOWptR2I3SFdjRVhmMmdqOFJJOHFZaGtpWmJOVW1MUzhQdFNO?=
 =?utf-8?B?NU9zQUxxdDVNQVdodCt1UGV0VDFUSE5uNjZTYlovTTFUamswRDhiK3JQTU9P?=
 =?utf-8?B?dmk1eFgxUzNkTS9MU1Axalc5bWR1aHFSRlhWNTBraUx4ZGJEZ0VNVVdvYUdv?=
 =?utf-8?B?OW9xeTZkVHZvU1FWVlNMY0pGL2lFK3BWcE5YbC9JNGtiZkpGN1oyZnRyYndY?=
 =?utf-8?B?YVpWTHkwQkYvakFOcW9EdXBLeXZJWnJVQU1TVHlVdzlRNTZtQm1YdVpkOWU1?=
 =?utf-8?B?Y2UxTDYwN1dtcURKUHdOeHZ4VGxiSExTeElsN1lXMUtRTUcyT1haSGFST0Ur?=
 =?utf-8?B?djdvNVlkOVpHRjlxNTMxVWZwbkdJektJb0V6bVVRU3ZRZHpDZnBLc0JXb2E2?=
 =?utf-8?B?RHFteUJIR2pJWjduckFrOXRGNDJIeFljcVg3Vnd5bHFyYjFmYUk4TmdhUms3?=
 =?utf-8?B?TWRKMFRNQXZMNTA4ak53ZFZVenhNbTRGRi9rNytIVVMwdnB3VjI1QzJQZ21h?=
 =?utf-8?B?NmtmRTZaZGJOaGViVlRCVC81UW8vNVR6RTc3UG1nSko4enhTR05Pc2pLV3JC?=
 =?utf-8?B?QU9oWFg5dzFjZG03c3lObHJlOWZ2VXRwZENoSmZ0ay9RUng2NUNSdDAxUUFk?=
 =?utf-8?B?ZnBYb2pxMzIxb0dJSUE3dWI1MzBBRkxBenZjVUwzWnhtLzVqSFNWZ0g0WElB?=
 =?utf-8?B?dUhyMlk2MjU2TytkWjZZdGNIL2NKcUY4OVI4Ti9Yd0NvVVZ4cDQwUXZRYkw3?=
 =?utf-8?B?RGF5ZGYrKy92Y0Mwc2VvMFphS2FjYkh5ZVYzdzJyYjRXUWgrZ2Z1Y1hSNEQ2?=
 =?utf-8?B?QVE4NGhpdldobjRCNnY5R3BDRUFYbDdGbzdYVmNmQ1lJeXIvZENmem12Qko5?=
 =?utf-8?B?UFoxSXAvbTFpT3gwRDhwWTlENDczcGVCajJ5clBBN3Uwd2xpMUFSRjdoK3Bu?=
 =?utf-8?Q?2EX6L5IvK+SWFA49hroBeMN3D?=
Content-Type: multipart/alternative;
 boundary="_000_870C20187321447896099A75F99468A7amazoncom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR18MB3709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0507469-f49b-4f1a-ca94-08de0483171e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 02:50:20.7859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAt145zRCpJZ4tt297lS3wh7wnBHMd9Zuw3aHVMy7/K8b/HFN8XkpLsF8Gxzk98eV8LrqoAWFoQf3hkHTa9swg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3674
X-OriginatorOrg: amazon.com
X-Mailman-Approved-At: Mon, 06 Oct 2025 08:36:36 -0400
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
From: "Sunku, Sai via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Sunku, Sai" <sunkusa@amazon.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_870C20187321447896099A75F99468A7amazoncom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgaGF2ZSBhIGNvbXBsZXgsIG11bHRpdGhyZWFkZWQgYmVuY2htYXJrIHRoYXQg
ZW1pdHMgTFRUbmcgdHJhY2UgcG9pbnRzIGF0IHZhcmlvdXMgc3RhZ2VzLiBJIGFtIHRyeWluZyB0
byB0cmFjZSBhbGwgbWFsbG9jIGNhbGxzIG1hZGUgYnkgdGhpcyBiZW5jaG1hcmsuIEknbSBzcGVj
aWZpY2FsbHkgdHJ5aW5nIHRvIGdldCBtYWxsb2MgdHJhY2UgcG9pbnRzIGFsc28gdGhyb3VnaCBM
VFRuZyBzbyB0aGF0IEkgY2FuIGlkZW50aWZ5IHdoZW4gdGhlIG1hbGxvYyBjYWxsIHdhcyBtYWRl
IHJlbGF0aXZlIHRvIG90aGVyIHRyYWNlIHBvaW50cyBmcm9tIHRoZSBiZW5jaG1hcmsuIEkgYWxz
byB3YW50IHRvIHNlZSB0aGUgc3RhY2sgdHJhY2UgZm9yIGVhY2ggbWFsbG9jIGNhbGwgc28gdGhh
dCBJIGNhbiBpZGVudGlmeSB3aGVyZSBpbiB0aGUgYmVuY2htYXJrIHRoZSBtYWxsb2MgY2FsbCBp
cyBjb21pbmcgZnJvbS4NCg0KSWYgSSBwcmVsb2FkIHRoZSBsdHRuZyBsaWJjIHdyYXBwZXIgd2l0
aCBgTERfUFJFTE9BRD1saWJsdHRuZy11c3QtbGliYy13cmFwcGVyLnNvYCwgSSdtIGFibGUgdG8g
c2VlIHRoZSB0cmFjZSBwb2ludHMgZnJvbSBtYWxsb2MgY2FsbHMuDQoNCkJ1dCB3aGVuIEkgdHJ5
IHRvIGFkZCB0aGUgY2FsbHN0YWNrLXVzZXIgY29udGV4dCB3aXRoIHRoaXMgY29tbWFuZCBgbHR0
bmcgYWRkLWNvbnRleHQgLS11c2Vyc3BhY2UgLS1jaGFubmVsIDEgLS10eXBlIGNhbGxzdGFjay11
c2VyYCwgSSBnZXQgYW4gZXJyb3Igc2F5aW5nICJFcnJvcjogY2FsbHN0YWNrLXVzZXI6IFVTVCBp
bnZhbGlkIGNvbnRleHQiDQoNCkkndmUgc3VjY2Vzc2Z1bGx5IGFkZGVkIHVzZXIgc3BhY2Ugc3Rh
Y2sgdHJhY2VzIGZvciBrZXJuZWwgdHJhY2UgcG9pbnRzIHdpdGggYSBzaW1pbGFyIGNvbW1hbmQg
YGx0dG5nIGFkZC1jb250ZXh0IC0ta2VybmVsIC0tdHlwZSBjYWxsc3RhY2stdXNlcmANCg0KSXMg
dGhlIGNhbGxzdGFjay11c2VyIGNvbnRleHQgb25seSBhdmFpbGFibGUgZm9yIGtlcm5lbCB0cmFj
ZSBwb2ludHM/IElzIHRoZXJlIGFub3RoZXIgd2F5IHRvIGdldCB0aGUgY2FsbCBzdGFjayBmb3Ig
bWFsbG9jIGNhbGxzPw0KDQpUaGFuayB5b3UsDQpTYWkgU3Vua3UNCg0K

--_000_870C20187321447896099A75F99468A7amazoncom_
Content-Type: text/html; charset="utf-8"
Content-ID: <9430C34D7178F6448C104955C6B5F9DF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6Q2FsaWJyaTsNCglwYW5vc2UtMToy
IDE1IDUgMiAyIDIgNCAzIDIgNDt9DQovKiBTdHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3Jt
YWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJnaW46MGluOw0KCWZvbnQtc2l6
ZToxMi4wcHQ7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJbXNvLWxpZ2F0
dXJlczpzdGFuZGFyZGNvbnRleHR1YWw7fQ0Kc3Bhbi5FbWFpbFN0eWxlMTcNCgl7bXNvLXN0eWxl
LXR5cGU6cGVyc29uYWwtY29tcG9zZTsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsc2Fucy1zZXJp
ZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBl
OmV4cG9ydC1vbmx5O30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXplOjguNWluIDExLjBpbjsN
CgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47fQ0KZGl2LldvcmRTZWN0aW9uMQ0KCXtw
YWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPg0KPC9oZWFkPg0KPGJvZHkgbGFuZz0iRU4t
VVMiIGxpbms9IiMwNTYzQzEiIHZsaW5rPSIjOTU0RjcyIiBzdHlsZT0id29yZC13cmFwOmJyZWFr
LXdvcmQiPg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkhlbGxvLDxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8
L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JIGhhdmUgYSBjb21wbGV4LCBtdWx0aXRo
cmVhZGVkIGJlbmNobWFyayB0aGF0IGVtaXRzIExUVG5nIHRyYWNlIHBvaW50cyBhdCB2YXJpb3Vz
IHN0YWdlcy4gSSBhbSB0cnlpbmcgdG8gdHJhY2UgYWxsIG1hbGxvYyBjYWxscyBtYWRlIGJ5IHRo
aXMgYmVuY2htYXJrLiBJJ20gc3BlY2lmaWNhbGx5IHRyeWluZyB0byBnZXQgbWFsbG9jIHRyYWNl
IHBvaW50cyBhbHNvIHRocm91Z2ggTFRUbmcgc28gdGhhdCBJIGNhbg0KIGlkZW50aWZ5IHdoZW4g
dGhlIG1hbGxvYyBjYWxsIHdhcyBtYWRlIHJlbGF0aXZlIHRvIG90aGVyIHRyYWNlIHBvaW50cyBm
cm9tIHRoZSBiZW5jaG1hcmsuIEkgYWxzbyB3YW50IHRvIHNlZSB0aGUgc3RhY2sgdHJhY2UgZm9y
IGVhY2ggbWFsbG9jIGNhbGwgc28gdGhhdCBJIGNhbiBpZGVudGlmeSB3aGVyZSBpbiB0aGUgYmVu
Y2htYXJrIHRoZSBtYWxsb2MgY2FsbCBpcyBjb21pbmcgZnJvbS48bzpwPjwvbzpwPjwvcD4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+SWYgSSBwcmVsb2FkIHRoZSBsdHRuZyBsaWJjIHdyYXBwZXIgd2l0aCBgTERfUFJFTE9B
RD1saWJsdHRuZy11c3QtbGliYy13cmFwcGVyLnNvYCwgSSdtIGFibGUgdG8gc2VlIHRoZSB0cmFj
ZSBwb2ludHMgZnJvbSBtYWxsb2MgY2FsbHMuPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkJ1dCB3
aGVuIEkgdHJ5IHRvIGFkZCB0aGUgY2FsbHN0YWNrLXVzZXIgY29udGV4dCB3aXRoIHRoaXMgY29t
bWFuZCBgbHR0bmcgYWRkLWNvbnRleHQgLS11c2Vyc3BhY2UgLS1jaGFubmVsIDEgLS10eXBlIGNh
bGxzdGFjay11c2VyYCwgSSBnZXQgYW4gZXJyb3Igc2F5aW5nICZxdW90O0Vycm9yOiBjYWxsc3Rh
Y2stdXNlcjogVVNUIGludmFsaWQgY29udGV4dCZxdW90OzxvOnA+PC9vOnA+PC9wPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5JJ3ZlIHN1Y2Nlc3NmdWxseSBhZGRlZCB1c2VyIHNwYWNlIHN0YWNrIHRyYWNlcyBmb3Iga2Vy
bmVsIHRyYWNlIHBvaW50cyB3aXRoIGEgc2ltaWxhciBjb21tYW5kIGBsdHRuZyBhZGQtY29udGV4
dCAtLWtlcm5lbCAtLXR5cGUgY2FsbHN0YWNrLXVzZXJgPG86cD48L286cD48L3A+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PklzIHRoZSBjYWxsc3RhY2stdXNlciBjb250ZXh0IG9ubHkgYXZhaWxhYmxlIGZvciBrZXJuZWwg
dHJhY2UgcG9pbnRzPyBJcyB0aGVyZSBhbm90aGVyIHdheSB0byBnZXQgdGhlIGNhbGwgc3RhY2sg
Zm9yIG1hbGxvYyBjYWxscz88bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxv
OnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhhbmsgeW91LDxvOnA+
PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+U2FpIFN1bmt1PG86cD48L286cD48L3A+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9i
b2R5Pg0KPC9odG1sPg0K

--_000_870C20187321447896099A75F99468A7amazoncom_--
