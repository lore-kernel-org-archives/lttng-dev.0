Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD9D216A3
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Dec 2025 15:47:29 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764863248; x=1764870448;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-ID: Content-Type: In-Reply-To: References: Message-ID: Date: Subject: Subject: CC: To: To;
 bh=RQ1uiBVVxZyOZU4It4Z4/j1u8aYdcMGDl4pbefvnMUs=;
 b=Dvr49QkjdmJhgikwFG05OvmL9kNKE4MbWf5KgID+TZuRlfXxfwsPcWJsLGnD565253zR2pLBpOfPCLa0y2hyKRwuE1VPFenLVS88jF3cjP/D4L/hjYKRY6IyKioH3PIDU/TnQ4hxEZ9QKlZ3yAY7LKVw8LJ+F0WfnEgPHxxWylOSZ5ZTHfiWRNgjIJFgZGSXMw5ETg8guwBwfEyL9cfOeoer1mBM6wxYFWzOZHPjXCvQ7RqBpjAZL/cJbb1BUDlYXbEAdVM9/5apvi4d1E/VaZlyH8zMJEwsDRIDb6cJCwyzF1PGtVdAFoCSgFYgGDvkYWp5IPX5WV90N0rwCLwrrw==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 c0d246312f8d2deecf0f28a432e09f92ad75e31a936639c9efa78748f27de215 with SMTP id
 6931ad105fa28524f4a871ac (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 04 Dec 2025 15:47:28 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMf5r0D1Tz10jZ
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1764863248;
	b=MmgGPGOzVkK4eLDQdvEIzqCWEwcHrY5tQHStXMry1wri3jdVVeVR/HiuZb/wgNkIc/7h
	 8qeDvAY6m5c4cWz1zoLiB3YfnDUykBmAQW05W+27POZxpnQsFt7xh4NlT2Ld9EkqKWLVg
	 v7TZ/C5iCllyY0cw6m/J4OZHkxbfMELK7Ck7jrnlGwna/2qmcNTjjrSJcDDUsen1iUFsC
	 jNwnwt0TvIBhv2YT9UaY7v/Rh3uZ8ORQ4DIE7YNkqKShWL0azWjy5txmQw5Ax87sQUKy6
	 i50/bM3JZStlMQwBsCqnKKENJgrgTDnnPhaZ82vNVRsQgzucFO3nXjLr2UqOQO8L0yg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764863248;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=RQ1uiBVVxZyOZU4It4Z4/j1u8aYdcMGDl4pbefvnMUs=;
	b=R1t9G8ZQv10sHrjdadu99WNaBQ14EVfXcUqd6eJHX9QI8+0XdMsvQiZe0HQ55fMBAZsj
	 yr6sx5jjvF6Flt+ft4m293zZyfyfyQheHYRfsAPY+QXLgC//X13HD9UgdbYkuYCXvx/eT
	 kP6my/K/1PT9rFiKyHSfmTQ+eDZGRV4Nb6C+FPDL368cEuD7Yv8zxmaHmWfCCGoEK0g4d
	 Hjw/g9yljhqELIdtcAR62DqsI1Qznpkk5U5Vpql5MpDnZ5TZiV8CWRlP7mj6MwTTfQhW7
	 c/2BeYLErCfGljC2eSTFwyNvOpZvCGheGxn/7UJ9axzUiDcM2FYjfefVSsh49GjjnyQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMf5r0D1Tz10jZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764863248;
	bh=RQ1uiBVVxZyOZU4It4Z4/j1u8aYdcMGDl4pbefvnMUs=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cQ6zNuCaarvNbX31YnJVi1PpNV8D7RMQdX3OTN0f2ZMPeDDntxfvIsdgdPyX1CIRT
	 lwx+rG6UKfB1m5MlsMhzirCwNS60Y2Q2BZf8uDoa6HDTNP01BcjNSnq7rvu+RTCQya
	 xePgxJ/JRAhYt9VLSgAQZvMmPnoUU4hDyTYB3t0hVM+F8Hdn2kcPYlxJuuhOfFWx9M
	 UCOargRcMd0RK+PVSBnEssrqop4TLrQfKf577O/SrRaJoPfThBb9cw654M0c/yYhef
	 6ROwSTo06oe6fnvblZwMD7rtx4idMWRMqSX/5RbD0i8zFvzvmNUQdP/nMFn3YbXq6m
	 KGWoLyLtmSMmQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dMf5r0D1Tz10jZ;
	Thu,  4 Dec 2025 10:47:28 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMf5p5gRHz10vy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMf5p5gRHz10vy
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by lists.lttng.org (Postfix) with ESMTPS id 4dMf5p5gRHz10vy
 for <lttng-dev@lists.lttng.org>; Thu,  4 Dec 2025 10:47:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwqaws/qS2b1pDDEvxkBi+hHSf9xzneZot8zqLt8cAXgngNclQrzorg3umBTp7K++LTTOEJCIQph9T5MZPkpBfIck0CMuRmwKe2BlfrywD7EyzN8YOuzb3RK4zn1uThH/AJaZ7ZMvFx0z8XjiIbYKgxaHMbCnqEh+4DqlJ9tzkRkF+CKaUaG+3YeXyoMA/cQomSvvExCw3xW5TzuukW2qtDaY+ONV4WHAVvBN1woopINJizd6h43fk5uKM1+mkh0xaESvyOIevL+1r9oMfYWIHllKk+6ktB2kPJYe4HRhAcn5+HNH1De0aFKZkVf43oRX+JpnQlBZnM1+XikoSbN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ1uiBVVxZyOZU4It4Z4/j1u8aYdcMGDl4pbefvnMUs=;
 b=BtmFzwPMWlL5ARqVjuQSMgHbtlYQqq46GbflRQRGoQqzgnVHjDLHX+2IyllHSgv2lVLrqK+NYrq2EY0FTK7IpgKC2hR7aBm0AwglFjQp0P6YPtLou0Wpzhq6LDb1mWDM8nnVkB5VBR8cGCJDr/c77tZ/e5dA7q00Q4FsS6ny/KVgAYOWjLAhKdDh7yHS1s8W8iMkvVNBnr6M4telFR9SgQi5irWonKVkJ4deqhFMAFvXOKHFWTF/mACZCLa47PjO73F+nP+IDfZX0lPKsu+2szFTDRQUrnt/UM4ZgKCa+4KuAFhPTq0vbyHHLk5FIB+aDjTkagHmRdasZQWOrI3kPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 15:47:23 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 15:47:23 +0000
To: "eeppeliteloop@gmail.com" <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "Poljakow, Andre" <andre.poljakow@siemens.com>
Subject: Re: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Topic: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Index: AQHcZQY0v/YP1lJ+F02U1q1NkpgqwLURl5eAgAAI6wA=
Date: Thu, 4 Dec 2025 15:47:23 +0000
Message-ID: <6407e79bb0b5bc49f73b200d9a5f40eef14e70af.camel@siemens.com>
References: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
 <CAB4xu_3fbK=-+B1=oo5oLk7jXVZgBEQjr99N6jpygX0SkuxAfA@mail.gmail.com>
In-Reply-To: <CAB4xu_3fbK=-+B1=oo5oLk7jXVZgBEQjr99N6jpygX0SkuxAfA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-7 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM0PR10MB3459:EE_
x-ms-office365-filtering-correlation-id: 9f8cf275-e604-42c7-2858-08de334c6adc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SnRZdkVDc2x3WTJSUkdBb0Q1eUdQdW1kVUhqdlV2RGJXd0RPbG40VmdZMmt5?=
 =?utf-8?B?ejFna0NnNUI1WnZDNVRWUjF3V2o2US9ESjh1QUE0bzNZbHBtekVtM29EWGpn?=
 =?utf-8?B?QVFtQjVyck5hUmRjYXg5UFE5c2pOaEROdWcwVmxadERzTU1ZK3k3bGU4a2I4?=
 =?utf-8?B?N2xDU3V6TWNWcVgwSW43dUhWNE80blJlcFRjeFBzSTdhV1A3dHBaVXBPaVBM?=
 =?utf-8?B?V25ONWtSUzR4QjVFTWhUOUdlZkdxd0sxTVNQSHJtTGJ5WWxhdzh0TXJVSjlK?=
 =?utf-8?B?SmpVcDhVYVFKR0MwaG9VNGErUURUTW45UHlpYlgxQllEOFRZZ2RWeG1wWFVy?=
 =?utf-8?B?cWQvQUpTcjNaa1JicDhrNUk5KzZMbnk1NkFGMkYycG9MYlphTkg5SVZ2d05w?=
 =?utf-8?B?Q2VObmJMeVl5YkFDMGdlV21vNmlhRFJoWnpZcERSRVdheE4rQWk2MlN2ckZ3?=
 =?utf-8?B?MTRhWE9Fak8wWTd1RTRtWnhzR1Vrc1lUcVJoWWwrWGlta3JiM29EbmhxZ1Yy?=
 =?utf-8?B?bjl0eUdBdG81cWRybGpzd0o1SHQwak9Pckk5MjhNSkVGVjQzNVkySE5LeVEw?=
 =?utf-8?B?MWdBeHlrbTlad2dWYU56U2wzN29JV3Q4WXlKTVR5VlQ0UWxLQk1rT0RVL0NB?=
 =?utf-8?B?K254MnBrM3dUazlRWTJ0VkJDSWh1TmNBdVl4WXZzRHJodE5IbWh3ODV5VjJv?=
 =?utf-8?B?MGppenJaUy9kZ0prWG1oQmNvL2JhTHZMOGJHbmpFd2dFSUhnd3RBYmRUWk1B?=
 =?utf-8?B?aXhKSmlaYStCTUl2NjV6SHhGUElESE5rVjdzd0U1VEhWV0ZBQXdtK1dqSWpt?=
 =?utf-8?B?ZWRFeUFMWHlhTzN1MGM0TDhwd3h2Wnp3bmhCMjNDaGx4NUt2b3RVbU04aEVD?=
 =?utf-8?B?dGVaUmlrQnZGMEFpL0ZXd3RxMUFuTmh0TWxIdUhQemdlUnZxbEJPZUhiN2pa?=
 =?utf-8?B?NTZmbkdXRzdOVTJFY0FVWnFJdGlVVmFDcktFNXJLV1hrK1lPajAxT3pwemJD?=
 =?utf-8?B?dEo0b1drcWFXS3ZYNVczRWNMN0F2Ym9mTWJidVhYN0dqNHRmbWoweHlMc2Fn?=
 =?utf-8?B?OE9objFzVXdtQ3VoMXBJMmQwR2kybm5aU1dmOVFsQ0lTZFhyNitvSm1rYU5M?=
 =?utf-8?B?VzdWeHJ3NDJ3cTE1bjVybStGemQxWnB5eS9jOVg1WUduTk0zZjcrSFdXVzhS?=
 =?utf-8?B?Ky9XQzBIcTRpU1hzUXEzSmg0QkN5U1Q1V1JmbGp5Y2o0RWY3WHBsamZWR1pz?=
 =?utf-8?B?R0pQUWNWdy9UNDBUc2Z0K25odXl2ZDMwVWtJZjZzaGFpWUlkSitoWVFVbGJp?=
 =?utf-8?B?RkhqS2JHZ0MzWm5OZ2c3c24zb0EyVWhOdjBSN3F6by9RdG1EbzBqNEVjbUI5?=
 =?utf-8?B?eWxsZTluc1hJMlQvQVlnLzJuYUNENG15VTFRU1Y5L0J6RUZyU1N1ZGw1dE53?=
 =?utf-8?B?Ly9KSXRpSk1CVXIyN1NtS0diamdYWkNtQ3EyTG1neFZPRVFDekI4NUdnYW5G?=
 =?utf-8?B?VHc4QXlCay9meXVmWWVSRDkyRlBGY2l2bFhuVGVYVkt6MU5rbTZtOFRTdUYr?=
 =?utf-8?B?OVlLRDRHV3N0VHhkOUxXZnliSG9YZ29hL2g2NEtuaEVkbUZuM3hrKzVQQTJo?=
 =?utf-8?B?RWZrK3lVaVI0SnRHaG1HU2FjLzFLVGVFTnRqT1EzdUpDN2lzZHcxTGhIbFBL?=
 =?utf-8?B?K0dITzhMUDM0WGRUZ1ZPMWtZR241RUR6eHZoR1V2SzhWNEtkcDFoUmE0Vi85?=
 =?utf-8?B?LzdMaFZ5cFo4SklUajZ3cHE4ck5qWFJPWjVWKzY2Qk55UzZSd2Q3QStseFpT?=
 =?utf-8?B?d29qaWNBcVRDTDc1c3NLSUhUbUxCM3B1NXYvNDA1TWRnSEFUZ3hUakJrb3R1?=
 =?utf-8?B?aDFVVTdnR0Nzai9MUzFBZlNBUDVXNUlnSzhJMzJJOWE4dWdSR3JDdjVFM1dr?=
 =?utf-8?B?RFU5anhra1RDYk1Fd28yVkZQbUI3dHBxZ1RlbW45QUVIbThTZDZwTkZWTjZM?=
 =?utf-8?B?dmZ3Nmh1SDVnNU84QW1EditBNXV6RVpHUGMyYW5rekc2Sm1USmppanRZbnBr?=
 =?utf-8?Q?7mktwA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RwbEt4YVVQUHluY1d4N2V4dGI0K3ZJbUlTVHJaNU1xQmtXYXM0UFUzb0RI?=
 =?utf-8?B?cVJIWUlPaERLQUJvc1FqL2xEZldDWkQ0LzI3aW9NUnJUaWw0alJjR1d2cEdw?=
 =?utf-8?B?OTBpbWhuV0Q2WXZjQWdjQ0F1Nm84OEtVeUxrTjlVcmVIdUh0OVE5Wmh0TVpD?=
 =?utf-8?B?c1NBTGFVd1ZsZXhsdGxGRmp6SUo1STY5OXN3QzVjNkk1bmg3Ym9BMFoyQUJG?=
 =?utf-8?B?MURRTElHRS96OU85U3pKKzN3UFhod2V6TFFCaWJrYVFKNklGN285V1RaNmpx?=
 =?utf-8?B?Y0hkMEQ5WElMcENtK0lyTVpQazkwTGxOdlJhbnY4Z1dDZE1aN1lDR0FxcmdG?=
 =?utf-8?B?cDdkNzlGcldEZmJMM3pOMzB4SmpwRFVjRHI3dzR5Z1ZVbWx5S1dmOERGb2Jj?=
 =?utf-8?B?K0xPeTR3ZUpqcVMzcGV2RFhScU82WUNIbFE2eGFxVnVZTFR0RGJTLzJ6eDNv?=
 =?utf-8?B?RUUyc1d5MU41ZlBneE04TmRXVEZWbzhESk1XaHQyZENqNGRPSHZlN3hHZzdT?=
 =?utf-8?B?ZTlITSsvdS9nV2NKV2RXWmdIb3hFMVo2c3ZjNzQzSTczZVo4eitJQkpGeDlK?=
 =?utf-8?B?MmRJUHAwR1Nhd1pwUmRpSjFnbkdpdnRCdEoyN3E4VnhEbHdCam56WTBMYitz?=
 =?utf-8?B?Yis0VU5RNWgzSjdIeEJyZS9GQTZtelVka0QxaTlHS25PK1lvWmd1c2JzYS9T?=
 =?utf-8?B?Vmh5RE1hdWxOdnpaWVdqUVNZSG5BRjNjZ3h3OHQ1Y3BHNW9Fc1NqTVA1RlE2?=
 =?utf-8?B?YlRMajNoZkJ6d3ZQMCtDcU9ESm8wcWdxQm9xRjB0U280Vmw5U1dFTkx1dnJO?=
 =?utf-8?B?N1kxMzN3VlNmNU5HWDRpYVlOQ1dzMEJ5ZWRoeDBpOE5GWGR2TnBYMFBCVVFB?=
 =?utf-8?B?Zi9Bbk51V0E2SERSSDJ1TXl5dDFhNmJDK2Rsb0pOS1FqZ3JpZk9vdm9seUFY?=
 =?utf-8?B?b2VBSHRiM3Y3bHVsWDh5dWJhVDlHb0xOMEVSU0Y0ZTJMT1BsVFA5Qi9LbjZr?=
 =?utf-8?B?cEhDZVArT0kwUUF5NEdJa0NycExPOTBPanpEQXJzSkh5UWFpU0pBS1E3aWJM?=
 =?utf-8?B?aC9acUJkS3Y4QkF0SjNPQm9IQ2xLQmxCemdEYVQvcjdoRFhiZ0lIYllQbVZF?=
 =?utf-8?B?Rko0RWFHMnBOdXdwTHVKZGpta2JHMGljTUdqQXFCSUMreWl2UEl6MWROOU1i?=
 =?utf-8?B?OFRicWZLZnV6M25TZjRlSHBjMDBpbStIV2hPa0JKZnhDQTU1VXRCbFc4ckx0?=
 =?utf-8?B?Zk0xTDg5eVRQSytmaUpaWWxhMkxXQUFRaEZGSVJDeWlzcXN6UU0vWE15WHRp?=
 =?utf-8?B?K3JvVzFvYnYxVjNmaldYazhXQk5PQ01STGZ1ejQwOUNNZ2p0c3cxWm5VTk9O?=
 =?utf-8?B?V3V1enhrS3lYWGcwbExaVG0zUXJPMzRVYVpRRlVhc1Y2eUFCd056R3R5UmRV?=
 =?utf-8?B?M0FDM2dUN1Z5MVpacTZHQVl3OEVteU1UUEh4ODlmTkdRbFpvZUtyRmJ2d2ls?=
 =?utf-8?B?Rkp6bmRvOTJwaG96d1Z3VTY2UDd0eFF4OThyTVRzNk54QW1hOXl1VTJDLzBn?=
 =?utf-8?B?aStUajJPakVVZ0R1UWdiZWFyL2VKdURNZEppdEE4U2pPekFnYWREN0ZrVmx4?=
 =?utf-8?B?bTJHYU1BOXBib0dLbDJCTTlnUjd3N1U4OXQrcTU2bitZbzFKRTF2QnhoVzBv?=
 =?utf-8?B?VHNmSGIvR0ZNRVhYdFlCZTdHalhEVWp4ZXFJTEtjcWpCKzFVaWNOWHk1ZWhL?=
 =?utf-8?B?ZjgxcVFwSFB2RzhIT1liTElHWjc0RGpHbXlSTU0rSTlBU0t4cnlVeVFEbkZy?=
 =?utf-8?B?eXBWMFE2OVNWQ3BDcXQyTFpGLzY4bFU2dUp0Zi9aMW5jTUN4cnVpMzBBL1ho?=
 =?utf-8?B?dUU2VHhXb0xMSldDY3UwM0FIazFxZkFjZUJJS3ZjSlFUdHp4bTh3aXpCcTRG?=
 =?utf-8?B?MjFwL0wzQWFFNUp0TVVrTWJNOWkyRzc3UzFoSkIvUTRoRElIUUhPOUl6TEFZ?=
 =?utf-8?B?bkJjdlFIME5NMlJPdG9jSVMvVHBEd2R2MW9DNkhVc1FKeEVwQ2ZxTUZpNkZ2?=
 =?utf-8?B?alpqRnh4alpZRjl0MXUvUytERms3c2xZWm9YLzlOejNUc1V1WHRlQkRBQkJw?=
 =?utf-8?B?cXNpT0VSV0daLzEybU1VYm1PMkZMdEpOS2dsU3Rwc09FUjlPcFJTSUNuVlV3?=
 =?utf-8?B?a0JYeEJEMWxIeENHNis2V2xWeHloeXozYlhscG50MUtpY2pFdUI2WFJZM1BV?=
 =?utf-8?B?Wngza2J6R2x0TXhKTHRBc3NoL25RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3D7C85CBAEFBB45B8084752B8BB786D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8cf275-e604-42c7-2858-08de334c6adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 15:47:23.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGuREkopxRtPnD/iGiT7F3XRACIjzeQElQl5R9fSyxNhGcuAIRgtBBsJGNlKnTg9mWa+fsb7QdfBK3JoYzOkTiK7gvkdOIj0SVk+ku2iiWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3459
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

T24gVGh1LCAyMDI1LTEyLTA0IGF0IDEwOjE1IC0wNTAwLCBQaGlsaXBwZSBQcm91bHggd3JvdGU6
DQo+IE9uIFRodSwgRGVjIDQsIDIwMjUgYXQgNToxMOKAr0FNIE1PRVNTQkFVRVIsIEZlbGl4IHZp
YSBsdHRuZy1kZXYNCj4gPGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc+IHdyb3RlOg0KPiA+IA0K
PiA+IEluIG15IG9waW5pb24sIHRoZSBlc2NhcGluZyBvZiB0aGUgc3RydWN0IG1lbWJlciBuYW1l
cyBpbiB0aGUgQ1RGDQo+ID4gd3JpdGVyIGlzIG5vdCBjb3JyZWN0IGFjY29yZGluZyB0byB0aGUg
Q1RGIDEuOC4zIHNwZWM6IFNlY3Rpb24gNC4yLjENCj4gPiBzdGF0ZXMsIHRoYXQgcmVzZXJ2ZWQg
a2V5d29yZHMgbXVzdCBub3QgYmUgdXNlZCBhbmQgdGhlIHJlY29tbWVuZGVkDQo+ID4gZXNjYXBp
bmcgaXMgYSB1bmRlcnNjb3JlIHByZWZpeC4gSG93ZXZlciwgdGhlIHNwZWMgZG9lcyBub3Qgc3Rh
dGUgYW55DQo+ID4gb3RoZXIgbmFtZXMgdGhhdCBuZWVkIHRvIGJlIGVzY2FwZWQgYW5kIGJ5IHRo
YXQgYWxzbyBub3QgbmFtZXMgc3RhcnRpbmcNCj4gPiB3aXRoIGFuIHVuZGVyc2NvcmUgaXRzZWxm
Lg0KPiA+IA0KPiA+IElPVzogVGhlIENURiB3cml0ZXIgY3VycmVudGx5IHVuY29uZGl0aW9uYWxs
eSBlc2NhcGVzIGFsbCBzdHJ1Y3QgbWVtYmVyDQo+ID4gbmFtZXMsIHdoaWNoIEkgYXNzdW1lIHRv
IGJlIGluY29ycmVjdA0KPiANCj4gSXQncyBub3QgaW5jb3JyZWN0IHBlciBzZS4NCj4gDQo+IFVu
ZGVyc2NvcmUgYXMgYSBtZW1iZXIgbmFtZSBlc2NhcGluZyBtZWNoYW5pc20gaGFzIGFsd2F5cyBi
ZWVuIGENCj4gbmlnaHRtYXJlIGluIENURiAxLjguIEZvciBleGFtcGxlLCBnaXZlbjoNCj4gDQo+
ICAgICB1aW50OCBfbGVuOw0KPiAgICAgc3RyaW5nIF9zdHJpbmdzW2xlbmd0aCBoZXJlXTsNCj4g
DQo+IFNob3VsZCB3ZSB1c2UgYF9sZW5gIG9yIGBsZW5gPyBBbmQgd2hhdCBhYm91dCB0aGlzOg0K
PiANCj4gICAgIHN0cnVjdCB7DQo+ICAgICAgICAgdWludDggbWVvdzsNCj4gICAgICAgICB1aW50
OCBfbWVvdzsNCj4gICAgIH0gX21peDsNCg0KT2theS4uLiB0aGF0J3MgdGhlIHJlYXNvbi4gVGhh
bmtzIGZvciB0aGUgZXhhbXBsZS4NCg0KPiANCj4gTFRUbmcgY2hvb3NlcyB0byBlc2NhcGUgZXZl
cnl0aGluZyB3aXRoIGBfYCwgZXhjZXB0IHRoZSBwYWNrZXQgaGVhZGVyLA0KPiBwYWNrZXQgY29u
dGV4dCwgYW5kIGV2ZW50IHJlY29yZCBoZWFkZXIgbmFtZXMgaXQga25vd3MuIFdlIGRpZCBleGFj
dGx5DQo+IHRoZSBzYW1lIGluIGBzaW5rLmN0Zi5mc2AuDQo+IA0KPiBDVEYgMS44IGRvZXNuJ3Qg
c3BlY2lmeSBgY3B1X2lkYCBieSB0aGUgd2F5OyBpdCdzIGFuIExUVG5naXNtLg0KDQpXZWxsLi4u
IFRoaXMgaXMgYSBtb3JlIGdlbmVyaWMgcXVlc3Rpb24gaWYgaXQgaXMgcmVhbGx5IHRoZSBqb2Ig
b2YgdGhlDQpzZXJpYWxpemVyIHRvIGZpeCBwb3NzaWJsZSBuYW1lIGNsYXNoZXMgaW4gdGhlIG91
dHB1dC4gQW55d2F5cywNCnVuZm9ydHVuYXRlbHkgTFRUbmcgdXNlcyB0aGlzIGZpZWxkIGFuZCBk
b2VzIG5vdCBhbGxvdyBlc2NhcGluZy4NCg0KPiANCj4gQ1RGIDIgc29sdmVzIGFsbCBvZiB0aGF0
IQ0KDQpJIHdvdWxkIGxvdmUgdG8gc3dpdGNoIHRvIENURjIsIGhvd2V2ZXIgd2UgbmVlZCBzdXBw
b3J0IGZvciBpdCBpbg0KdHJhY2UtY29tcGFzcywgd2hpY2ggQUZBSUsgaXMgbm90IGV2ZW4gaW1w
bGVtZW50ZWQgeWV0Lg0KDQo+IA0KPiBTaW5jZSBDVEYgMS44IGlzIHByZXR0eSBtdWNoIGRlcHJl
Y2F0ZWQgYXQgdGhpcyBwb2ludCwgSSB3YW50IHRvIGludmVzdA0KPiBhcyBsaXR0bGUgdGltZSBh
cyBwb3NzaWJsZSBpbiBhbnl0aGluZyByZWxhdGVkIHRvIHRoaXMgbGVnYWN5IGZvcm1hdCwNCj4g
d2hhdGV2ZXIgdGhlIHByb2plY3QuIEp1c3QgbWFrZSBpdCB3b3JrIGNvbnNpZGVyaW5nIHRoZSBr
bm93biB1c2UgY2FzZXMuDQo+IA0KPiBUaGVyZWZvcmUsIGZvciB5b3VyIHNwZWNpZmljIHByb2Js
ZW0sIEkgc3VnZ2VzdCB0aGF0IHlvdSBzcGVjaWZpY2FsbHkNCj4gYXZvaWQgdGhlICJwcm90ZWN0
aW9uIiAoZXNjYXBpbmcpIGZvciBgY3B1X2lkYCBpbiB0aGUgcGFja2V0IGNvbnRleHQNCj4gZmll
bGQgY2xhc3MgX29ubHkgZm9yIExUVG5nIHRyYWNlc18uIEl0IHNob3VsZCBiZSBnb29kIGVub3Vn
aCBhbmQgbWFrZQ0KPiBUcmFjZSBDb21wYXNzIHdvcmsuIFRyYWNlIENvbXBhc3MgY291bGQgYWxz
byB1bmVzY2FwZSBwYWNrZXQgY29udGV4dA0KPiBtZW1iZXIgbmFtZXMsIGJ1dCBpdCB3aWxsIGJl
IGZhc3RlciB0byBkbyB0aGlzIGluIEJhYmVsdHJhY2UgMiBhbmQgaXQNCj4gd2lsbCBtYXRjaCB0
aGUgTFRUbmcgYmVoYXZpb3VyIG1vcmUgY2xvc2VseS4NCg0KVGhpcyBpcyB0cmlja3ksIGFzIHdl
IGRvbid0IHJlYWxseSBrbm93IGlmIHRoZSB0cmFjZSBpcyBhbiBMVFRuZyB0cmFjZQ0Kb3Igbm90
LiBIb3dldmVyLCB3ZSBjYW4gaGlkZSBpdCBiZWhpbmQgdGhlIHByb3Bvc2VkIGNyZWF0ZS1sdHRu
Zy1pbmRleA0KZmxhZywgYXMgaXQgaXMgYW55d2F5cyBvbmx5IG5lZWRlZCBpbiBjb21iaW5hdGlv
biB3aXRoIGFuIGluZGV4IChJDQpzdGlsbCBkb24ndCBrbm93IHdoeSwgYnV0IG9rLi4uKS4NCg0K
PiANCj4gPiANCj4gPiBJIHRyaWVkIGZpeGluZyB0aGlzIHdpdGggdGhlIGF0dGFjaGVkIHBhdGNo
LA0KPiANCj4gSWYgeW91IG5lZWQgY29tbWVudHMgb24gYSBwYXRjaCwgZXZlbiBpZiBpdCdzIGFu
IFJGQywgcGxlYXNlIHByZWZlcg0KPiBHZXJyaXQgc28gdGhhdCB3ZSBjYW4gY29tbWVudCBzcGVj
aWZpYyBsaW5lcyBhbmQgZm9sbG93IHRoZSBkaXNjdXNzaW9uDQo+IG1vcmUgZWFzaWx5Lg0KDQpP
aywgZ290IGl0LiBJJ2xsIGFkZCB0aGUgbmV3IGltcGxlbWVudGF0aW9uIHRvIHRoZSBjcmVhdGUt
bHR0bmctaW5kZXgNCnNlcmllcyAoYXMgaXQgYW55d2F5cyBkZXBlbmRzIG9uIHRoaXMpLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpGZWxpeA0KDQo+IA0KPiBCUiwNCj4gDQo+IFBoaWxpcHBlDQoNCi0tIA0K
U2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1T
dHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==
