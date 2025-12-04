Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6BAD216A6
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Dec 2025 16:07:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764864469; x=1764871669;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-ID: Content-Type: In-Reply-To: References: Message-ID: Date: Subject: Subject: CC: To: To;
 bh=+zVUqvSoxFUUnqx3ffmg/eVevkhq/RlZoIEWcrfbTes=;
 b=nsY5JQh80xWq0B7fgww/7OCvSO6CgtKkJMD5MlA0tEPpYQPDdpoZ+81HdzsoFVva6sr+/8sifK9cZlaKdCp4Uvqkqn+CzHzJ+Snl2lB8xX9YEqyidc5Jn77P8G7gsJ5ipHwiwyBoJUQ5q38iFU5ZddLZ3KZo9islCTzDBRPXh0DQUXY01wsUpMgT8rDPjUhmnpIkrfymIMgFYJtb+CqyIci+b6O9MC6UPZ1umCuEyQVk7zO7rtAHGe+A6/fWNybxM67537YHSOEGmiDjC12WD6ENAi1ZGR4YnobjI3hl3ggucNWqzczD/zyRd+8cZUCvYetotwqy3aqHFILZhCKszw==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 a3194a0b42411ba3dd16f8261a36bcda3964f9ff3bd2b33c55b0614b3a7bbb61 with SMTP id
 6931b1d56333663c656614ef (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 04 Dec 2025 16:07:49 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMfYH6j0Xz10h1
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1764864467;
	b=IqUZbGYq/D7NWSTWJeusmneBhWUbDsAfq+eLpRF5fLdmqVkW7h18qh/INrnMiseoFvCM
	 71S0OTPGPBjm/AWIln9X7HliiaPYxg9P7zra6N1Smrz8sNSZFZTBF5BkR2t94JFGi6bJT
	 mE1LmOGy0S65BY241sT7UA2uXNQlPm+qEnkms/A5El2aH6Od+42MBFs/Riu1TmsaTQmeR
	 HRY5EzMS5goikoP8fHmBbuvMReFMMBPM/CVB+ot2sTdbma4ex37tews8199vZnDgJEYPp
	 0VKNBpI2IjAdv/eP0J4rSIU0mgqYy4ul2QeR7u8o97ePXOwgoP/+pU92R4mZOTSUAxA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764864467;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=+zVUqvSoxFUUnqx3ffmg/eVevkhq/RlZoIEWcrfbTes=;
	b=hq6jWCS260IdkoS330ktT8UObX+mWCnUsOuXnyY28aN5N6fuAskJKcAgTgt8VRsBIX5N
	 OndFiRodkmWHZnVifimzaHs/SebA8Owll82H4ISdcvMwLKwPo5Bqbp84nsW8d6XLxY/ov
	 0SqGpMLUptxSdKEaeozTgIbFk3pPdDb6CgObkXL1FRufugggrlS4STLvYYblbl05WwznJ
	 ijmz+Om5wvA+/9I4z2rCIYmzBMHe8NAMjBEhMO3mCA28PIIxr5E7Jw1g4q9jOtSL11d/l
	 tCIlhfR5vtXJazjJMsme0efjBkrE42YMJBYojP80a71bdNHfymsOnsyUvCpt+wLacsw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMfYH6j0Xz10h1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764864467;
	bh=+zVUqvSoxFUUnqx3ffmg/eVevkhq/RlZoIEWcrfbTes=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RoXQeTyvcFrE90qNEgwU4muHwezsZJduj8HTMqDPNDlVn/dVy7iEDlaIl/8TBaV/K
	 pAkQR0d3iZqke4mtyXGvQgksiR8pOIQ5yU39VSzTZz3/IsvUMXT6lDMh2nqRQtYvnp
	 GRq5qC9Oyn61JoDxbIuFwdk4FVh1KhrH07MciFeUz2FsCfXuNVdWG70BmIuu9qdszr
	 1xA4AMxQ6TjMRMJpNOH1vLOhYTu6MYlm3KhBCr/vWVM65KlcyvCmatgP8MIysNuubB
	 dYPEbkOCJWQh71VDAkU1P55QZPwBocWGzmgJcaugG3JZirkq1YZcgfO9dYyQ2qIO0W
	 uqvbRV5xj4aoA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dMfYH6j0Xz10h1;
	Thu,  4 Dec 2025 11:07:47 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMfYG4vN0z111C
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMfYG4vN0z111C
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4dMfYG4vN0z111C
 for <lttng-dev@lists.lttng.org>; Thu,  4 Dec 2025 11:07:46 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8QxJ44ipqxlVBW03myXJipFvrJjuDgmRWSWLVW5buWErsQAaW9hV0I4z30+qHb3zui3DN7TVNnhEYogjHUJXQYH7G4c/v0U/83BEzjyg8wXZfvw0dgzcGdJ/S5ktfYuXEZq8QVJ+4WtVmqKz2IE5Tpx4Z1qPaqqICOxHqrbLgrCll1RtII9V9GUSSZUsWjryqt17X3IYO4xKTl0mobwBPTN70BtXWIQJKpOPb/cAiM5gUxw42UABOy9zzeqwWNfdAHDlhx9dCLTChPetvcON5ajzNKfhuaA+3u1yY2e55jH1cUt12m+9LlOxihhf4//TamU2UFI25XdsgT1u9Psyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zVUqvSoxFUUnqx3ffmg/eVevkhq/RlZoIEWcrfbTes=;
 b=ys5TDXwf7nolPVgKdRi9FMD3KVtwioTg3dWBk+2zSmi5Z9E05pKnQDnkDn+6Zhs54xKA1v91GHbz7Fmxd5P38pQQB6WEwmP5393txxZY4v+hqADYTsYfh7pjXUkYlzoT9Jnwr4ufIFxHM+0bR+Kjf5Ns3hTe+beauKRuMV16MJFViBDsazHggZ2xMvcIhZdMebFdjM1S8BhEGYZMjHqfg4ErdmEw2/N/wOLoPGLimT7ZYTyuZe39oMWN/bN5fPfTp0Yf/iAz5ITkjxhYVdRMD2HN/oa7n5ZObV0C1lUyx17yvrPh96soz0h2bZ/u3yHv8/3oZx8AaiMuoZNlmubEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB5880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 16:07:43 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 16:07:43 +0000
To: "eeppeliteloop@gmail.com" <eeppeliteloop@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "Poljakow, Andre" <andre.poljakow@siemens.com>
Subject: Re: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Topic: babeltrace | sink.ctf.fs escaping of struct member names
Thread-Index: AQHcZQY0v/YP1lJ+F02U1q1NkpgqwLURl5eAgAAI6wCAAAPVgIAAAdkA
Date: Thu, 4 Dec 2025 16:07:43 +0000
Message-ID: <8eb94fdf35b763ed20b6470f737c55926cd0f0ca.camel@siemens.com>
References: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
 <CAB4xu_3fbK=-+B1=oo5oLk7jXVZgBEQjr99N6jpygX0SkuxAfA@mail.gmail.com>
 <6407e79bb0b5bc49f73b200d9a5f40eef14e70af.camel@siemens.com>
 <CAB4xu_3+ve5iusvBMPhN2cv9K7N-r4qwa92k4RrFT_WNMPqi4w@mail.gmail.com>
In-Reply-To: <CAB4xu_3+ve5iusvBMPhN2cv9K7N-r4qwa92k4RrFT_WNMPqi4w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-7 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB5880:EE_
x-ms-office365-filtering-correlation-id: 22b22f5e-bf7e-4b94-de80-08de334f41db
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QmRjcHl6Yko3UCs0a281S0R0aVl4aXNGeUZtOEppNkFaaEU2N2thaG5kZTU3?=
 =?utf-8?B?M0F3VVMybytVMVVkcHljTXpaNEF5eTg5SlhXSTdESnFHUm5TTlhLOXNad0Nj?=
 =?utf-8?B?Zll6aE1XUXhZSEU1YTBFZDJtbE1vNDNCN0I5NUpDMXRwSlpabGdiRzdnVHJK?=
 =?utf-8?B?dnlwRVRpQkJPdFJaVzQ1dHRxN1Y5d29Zd0xrUDQzN2pZTGZVeW5Td2pOVXJv?=
 =?utf-8?B?bkRpbUcxd0k1NXZEczg2dTRJUUtnTStpbzU0SlJ2RVJiREF5REpQY2FGeHFZ?=
 =?utf-8?B?MmlNSFBkV0crQUVYOWRVYXljMTliSTlZR3RhR0JyN2tGbXNWUlpWc2VUUUlm?=
 =?utf-8?B?eVF2TlZUc0I5anNzSTNIajVpM2VPRWdqelRxMGhRdWJGelFXWnJNaS93MU00?=
 =?utf-8?B?TksrNVl1aUpaZ0hhS0pUdU5BOXM0ZmVUbVEzU0x5dGRidTBOUDdKSmJDL3pU?=
 =?utf-8?B?ZHFLWHR1azFVREhpemFUNU1aWmtWRTRGTTVEcVljK2R2TEpma0pWNlpwZTBS?=
 =?utf-8?B?bE1RWm9Vdm5EdHl4Nk1acmVDWFh4QzBySWFwRUhZeEMrOUN1WEdpQ1dIa25o?=
 =?utf-8?B?ZDcrMnhoWEhLbWFyaFBGRUhuRE5JeXBkSmxoaVh5Vk1UcUU1UW9XWXhnbUwz?=
 =?utf-8?B?OURvNWQxdm9jZTFwZlNvTTVKSXM3UnBGZEdXUDFKdGtBUmx1ckdZV1VlNWx2?=
 =?utf-8?B?d040aGFEdlZ5bE9zVnlGZzM2MVMrR3U5d3QrS3A5Mkp0cHNJaktDUW9tZlU1?=
 =?utf-8?B?ZHdNVXAvbzQ3ZmdwempRSkNpQVVrZWIwd1lraUZmRVlTS1FSbXdVTERIb3Rs?=
 =?utf-8?B?R2lLRldrSVBieTA3ZldqQ3YyR2RjL1gvRlNHcHVaN1N6NlMvQmliRjUwMEtT?=
 =?utf-8?B?RCtodGxnVi9oNkNCcFJGZDdCcWJibVFMc0hTdjJVajF5RW9IWW1sQjFtZEJk?=
 =?utf-8?B?NFUwVFRPTFRnUzJFb1VSYXlwTzBvV2MrVzBtejdVK0Zrcnl4VFRjVzVYUTZF?=
 =?utf-8?B?WnlTR2taOUZYT1grU2VEcmJTT0lydmN2Y01sYjNuUGl5V1hnRldYZnJwL0FH?=
 =?utf-8?B?RUVFOEZSelp0ckd5SUpkZTl2OHE2bmFHL3pRamJjTy9NTlhpMU5ORHhBVlVO?=
 =?utf-8?B?cmtDZmhwcE54U2xRRXI4OGMwMVNNTDE3WTA4UVY0ZE01MEhpa2FhRlNJSUZH?=
 =?utf-8?B?V29mejFKOFZ1a0x5QjAvK05ubVNaQWUxRmlJS0RnaE1EMWNCejhDeW5XQ1ow?=
 =?utf-8?B?bzdBN3Vmd3JZZHBRTElINmhtVXBick14bVhWZkhNR0ViZVJXU3VJdFI0MFJ2?=
 =?utf-8?B?bWNrVFJWYzFRcDVndkJGRUgxUkFJVUlJQ2ZDZEFBTXNieDlPY1VGRC8zbk43?=
 =?utf-8?B?TmdVU1JlZ3ZpTEpIUERVVmF4WjNlMDdnZWIrSUdzRUxjVnJ4akl2ZGxwU3d3?=
 =?utf-8?B?SU01ck5ZQzA5R0tSczJrLzMwbDZjRFlTdnI3SDYwRVZhKzl6WW9mTG9iaTll?=
 =?utf-8?B?K2htYXBzUXUzNjRpRlZNMjFFZ3FUZjV2cVZaV3Rza3RKSnF1NXlFRGZzY1BK?=
 =?utf-8?B?QXI3aW9Ua1NhSG5jVkRRZU9Ib1VTbDNDc2Y0dFZMT1N6WGxaVGNaYkEyVkNm?=
 =?utf-8?B?SVFXVXVsZlAvSW95S0xNc2xrZExuQ0ZPVDM5NWxXZUhya08wd25BbXZYQ2Fl?=
 =?utf-8?B?S2s0WEpSbzNmZU5DNGlmUFdYbDVGWmpzcUc2MURhQkM3ZDNSbXlSdlo5eVNr?=
 =?utf-8?B?M0E4R2JacngzVGlMa1BMdENnbG8za2NSdWpwSE41MkJtZjJ4K3FTdE1MWVdC?=
 =?utf-8?B?WUVuUVF5S2ZNYlZZbzd6QjhlZVoyUks5WW1pQXI1Ym5nald4WDBkdno5clVs?=
 =?utf-8?B?MXpVUG95N2tueXlzeDhkWDBvZWJyeG5VaXp3ODBEc2pBVDRsVW5NQ0lRWTZP?=
 =?utf-8?B?czdSLytXOEkrMTZuMjFqcU5UUXJHa3htZXlRT2NRY2VzOTBEc3NmYUpaRENY?=
 =?utf-8?B?ajZFVVdQYWdyMW8rRWVXd3BTaTNUY1kwdHZiWTFsM2dDRndLMS8rNVJqYXhH?=
 =?utf-8?Q?T3RYDC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBlNSthVWNuYWI1YnZLL2todmJwT1NoaEE2eDdNcHJlY3RqK0lvQ1FWM0J1?=
 =?utf-8?B?S2xvTXV3eEpnU2Fqc0JkL0hwdTVLamJ1UjIwMFdtWWthKy9yY2pHMG1JYzFR?=
 =?utf-8?B?bDgzT1FDZnRIM2Q5VDdDcnZudEhRK3dMM1BXV3Y3dkRXK2JJcHpWeHlGaXhz?=
 =?utf-8?B?YlUraUJiYlNVNDhGdzVVbmFGK2RVekFvT1c1Y01jbFhhdHF6QVp4ajlQTVZ4?=
 =?utf-8?B?T3pFWk5KTHhBNHdLckFDS0M0dTc2Z0pIWUtZdnhldnNPS1dKa0sreUFQQ0Na?=
 =?utf-8?B?N3FhTEllMEdIUnloRVY1aHJ1V1BNbG5nYkYzTkRJa29lWG0yTkx1cnVkc2JE?=
 =?utf-8?B?TUF4Q0RJbDRNR2NOK3JUTDArdXdwSTJyMDl0cm5iWDM4OUZyZzh0QU5wZmpt?=
 =?utf-8?B?VHIxaytBeGcrWHZsOVhEeFlTUDVJUkg3NzdLUi93eXRXVnB3a0UwWDl1QlhE?=
 =?utf-8?B?N0l2UlQ1c3c5Ym5uQTF6RzhGNFNQeEJQdSs1cnFXK3Q4RGxhTXZsTitRa1FN?=
 =?utf-8?B?b2F2MUhEbGJjQmgvVnBqWUhIYlhXenpYZjRMMWxxS2VNYSt6b0IrK2MzR0ht?=
 =?utf-8?B?VGZRZ2hFbmJZK0ExcUZnVVZacmxUNXlsWFNVc0VKQmpOU3U2N1huT1lIQ04y?=
 =?utf-8?B?eTZLMUFRNnZ2cVVJVTlqUGN0VjJnUmY5cFlmbDQ1Sld3NzVoWTkrY2dsM2FQ?=
 =?utf-8?B?T1JyM1lQdjFnRXEvQkt2cGh2T01LSk54TVNHeXRQM2V6bERxT0w0U2JRUmJJ?=
 =?utf-8?B?UXhiNzNodmlrLzBRMjRHSG8zakowUngwdzZIY2hwREMzTzlzZXFqemVETDh1?=
 =?utf-8?B?WmZabXhFKytjcFhpUWN1aUNMV1V0bzFuM3doelN3eXQ4a0FFNVNKei9scDNt?=
 =?utf-8?B?UjlUUllEM1J4bDRWbmwrbWJlVEVyRjdWd1ZtVVhQM2o3ZWNHWUNZMUhVeThT?=
 =?utf-8?B?WEpEa2JicEVMMHdSclJka1lBbEtsQ1BKVThBMXpRcVEzbmlVelJxVy93S1VD?=
 =?utf-8?B?c1Ewc001WGlhZERqb2NlRXFWZitBdSt2dE9BTUlvRUVKS1A5RmtEdWRCd0lT?=
 =?utf-8?B?MTgvNHhtYnd0Z1FudjhrR252ZnFncGlVVHdhUG5TU0g3ajBTSzNpVmF2WDl0?=
 =?utf-8?B?UFNEVE03aGRwTW5nNUFlWEZFK1d5OFVsai9NVUFtZlprRlV4dmgxS1ljRXJH?=
 =?utf-8?B?eGdBSHo3cTBPN2QxTjF6ZEZzQ3EzWlRqSFRTejVDczZUVFlLbHFDSVdoNEwr?=
 =?utf-8?B?MTBYUDgyVmtDcitnSkNxZ1hnc0YwYWxyK1did2Y1OXJVYTVod1U4WE5BTkU5?=
 =?utf-8?B?azFha1hpTUdma1M2K1ZOaGJqSUpvaVg1V25HbzJxN3FHdTNzdk5JUHlJRTZV?=
 =?utf-8?B?OHhxOS9rUWQ1ejJ1MVBzOEZHejVNVVJhdjRlZzl5dWF6WjZmcEJYR2dpRkww?=
 =?utf-8?B?MzljdkcrRmd4dXlHcU5mVUNFOFgzT3ZVdkJaQWlEamZRTk5YV0kveHZJZmxt?=
 =?utf-8?B?RGdPb1F4TENzY0ovajI0WldzOW5hU0Voc3l4NHFtRCtEam5xNGwxaEFBM2dD?=
 =?utf-8?B?cE5tUE9MeE5hZlJVY01XaTg3eFp1aDdjamErdkZ0OGJmVFNGOEFXZUw3bkVw?=
 =?utf-8?B?Vmhxeit6YTVlVW5NWWVXQmVVSWNNZ2JmTFc4dVRmRmcyS3BlQnBydmZZaFdS?=
 =?utf-8?B?WEtOWFRtRWljOWxkMzBNaFpWZm1yTE5BLzNxS1dZMjNVSENLUkJXLzBZZ1B2?=
 =?utf-8?B?aE0vNTBIL1MrUllvYzBQejBFRkdZWnI1VXJ1Mk9SRGlDOFZ2RjVPMThlUkRi?=
 =?utf-8?B?Vk5LS2NibDd6NTArRGZVRjRvcFBFOElscm5JRG1GRml0QW5rTVZwYUwyNnd3?=
 =?utf-8?B?aUo3OXo1U0xuejM2bDRxNkgrdjkyZVcvUDZ5TjZtM2tTb1kzLytHZlJ5Q1Zj?=
 =?utf-8?B?WTdwY3ZHenVkRFAxdVRpSEFiUDYzR2xDRlhuMUZER3IrNWhjVjNRTHYwNlQx?=
 =?utf-8?B?djlBN3lUdldRdnBKbEhRQktPYU9JOW5COXdDL1Q1MGMwdUtWaGFkNlZzY0hS?=
 =?utf-8?B?TGlWZTE0NTNML2hQd0Mzd3BTb05zRHBRNFpKOWhaWURPQi8wbkNLQUxncVJo?=
 =?utf-8?B?RjNPYU5rUEFWYWdVVEFNY1MzZCtUeC9zTUpYSGxCdVN5QlpUelBDQWtpSzlz?=
 =?utf-8?B?WHNDUUlEREZsWitRbzk3NHRneVNFK1FEMVFsNFRRcExNbGxJR0JVVGhHd0Ey?=
 =?utf-8?B?ZnJVcUlGVlJza01jOVhqTk9lanZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB464A35F6F23441AEEE840AF90F4EA9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b22f5e-bf7e-4b94-de80-08de334f41db
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 16:07:43.3092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjN3im5nTr7+nXEM0TKli9V45nx/Gu0Ft85U4f8hUTmOal3PlEpg/OLsk3DNusCMnGFw/gMcf9ZP1oq12zmZEFrZdE0DMIwzCjbQglfpnQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5880
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

T24gVGh1LCAyMDI1LTEyLTA0IGF0IDExOjAxIC0wNTAwLCBQaGlsaXBwZSBQcm91bHggd3JvdGU6
DQo+IE9uIFRodSwgRGVjIDQsIDIwMjUgYXQgMTA6NDfigK9BTSBNT0VTU0JBVUVSLCBGZWxpeA0K
PiA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gV2VsbC4u
LiBUaGlzIGlzIGEgbW9yZSBnZW5lcmljIHF1ZXN0aW9uIGlmIGl0IGlzIHJlYWxseSB0aGUgam9i
IG9mIHRoZQ0KPiA+IHNlcmlhbGl6ZXIgdG8gZml4IHBvc3NpYmxlIG5hbWUgY2xhc2hlcyBpbiB0
aGUgb3V0cHV0LiBBbnl3YXlzLA0KPiA+IHVuZm9ydHVuYXRlbHkgTFRUbmcgdXNlcyB0aGlzIGZp
ZWxkIGFuZCBkb2VzIG5vdCBhbGxvdyBlc2NhcGluZy4NCj4gDQo+IEFsdGhvdWdoIEkgdW5kZXJz
dGFuZCB0aGUgcXVlc3Rpb24sIEkgd2lsbCBub3QgdGFrZSB0aGUgdGltZSB0bw0KPiByZS1ldmFs
dWF0ZSBhIGRlc2lnbiB0aGF0IGludm9sdmVzIENURiAxLjguIEknbSBjdXJyZW50bHkgaW4gYSAi
cXVpY2sNCj4gZml4ZXMgb25seSIgbW9kZSBmb3IgdGhpcyBmb3JtYXQsIHdpdGggdGhlIHNvbGUg
YWltIG9mIGtlZXBpbmcgZXhpc3RpbmcNCj4gc2NlbmFyaW9zIHdvcmtpbmcuDQo+IA0KPiA+IEkg
d291bGQgbG92ZSB0byBzd2l0Y2ggdG8gQ1RGMiwgaG93ZXZlciB3ZSBuZWVkIHN1cHBvcnQgZm9y
IGl0IGluDQo+ID4gdHJhY2UtY29tcGFzcywgd2hpY2ggQUZBSUsgaXMgbm90IGV2ZW4gaW1wbGVt
ZW50ZWQgeWV0Lg0KPiANCj4gV2UncmUgY3VycmVudGx5IGludmVzdGlnYXRpbmcgdGhlIHN0YXR1
cyBvZiBDVEYgMiBzdXBwb3J0IGluIFRyYWNlDQo+IENvbXBhc3MgYW5kIHdoYXQgYW1vdW50IG9m
IHdvcmsgaXMgcmVtYWluaW5nLiBXZSdsbCBsZXQgeW91IGtub3cuDQo+IA0KPiA+IFRoaXMgaXMg
dHJpY2t5LCBhcyB3ZSBkb24ndCByZWFsbHkga25vdyBpZiB0aGUgdHJhY2UgaXMgYW4gTFRUbmcg
dHJhY2UNCj4gPiBvciBub3QuIEhvd2V2ZXIsIHdlIGNhbiBoaWRlIGl0IGJlaGluZCB0aGUgcHJv
cG9zZWQgY3JlYXRlLWx0dG5nLWluZGV4DQo+ID4gZmxhZywgYXMgaXQgaXMgYW55d2F5cyBvbmx5
IG5lZWRlZCBpbiBjb21iaW5hdGlvbiB3aXRoIGFuIGluZGV4IChJDQo+ID4gc3RpbGwgZG9uJ3Qg
a25vdyB3aHksIGJ1dCBvay4uLikuDQo+IA0KPiBZZXMgd2Uga25vdy4gSGF2ZSBhIGxvb2sgYXQg
bWFrZV9sdHRuZ190cmFjZV9wYXRoX3JlbCgpLg0KDQpJIGFscmVhZHkgY2hlY2tlZCB0aGlzIGZ1
bmN0aW9uLCBidXQgdGhpcyBpcyBhIGJpdCB0b28tc3RyaWN0LCBhcw0KcmVhbGx5IG9ubHkgYWRk
aW5nIHRoZSBpbmRleCBicmVha3MgdGhlIGltcG9ydC4gSSBhbHNvIHdhbnQgdG8gYmUgYWJsZQ0K
dG8gYWRkIHRoZSBpbmRleCB0byBub24gbHR0bmcgdHJhY2VzICh3aGljaCBmb3IgaW5zdGFuY2Ug
bGFjayBzb21lIGVudg0KbWV0YWRhdGEpIGFzIG90aGVyd2lzZSB0aGUgZnRyYWNlLXRvLWN0ZiBj
b252ZXJ0ZXIgbmVlZHMgdG8gZmFrZSB0aGUNCm1ldGFkYXRhLg0KDQo+IA0KPiBgY3JlYXRlLWx0
dG5nLWluZGV4YCB3b3VsZCBiZSBhbm90aGVyIGhpbnQsIGJ1dCB0aGUgdHJhY2UgZW52aXJvbm1l
bnQNCj4gaGFzIGJlZW4gZ29vZCBlbm91Z2ggc28gZmFyLg0KDQpUaGlzIGlzIGVhc3kgdG8gaW1w
bGVtZW50IGFuZCB3b3JrcyBwZXJmZWN0bHkgZmluZS4gQnkgdGhhdCwgdHJhY2VzDQp3aXRob3V0
IGFuIGx0dG5nIGluZGV4IGhhdmUgIl9jcHVfaWQiIGFuZCBjYW4gYmUgaW1wb3J0ZWQgaW4gdHJh
Y2UtDQpjb21wYXNzLiBUcmFjZXMgd2l0aCBhbiBsdHRuZyBpbmRleCBnZXQgImNwdV9pZCIgYW5k
IGFsc28gbm93IGltcG9ydA0KY29ycmVjdGx5Lg0KDQpJIGhvcGUgdGhpcyBzb2x1dGlvbiBpcyBh
Y2NlcHRhYmxlLg0KDQpBbnl3YXlzLCB0aGFua3MgZm9yIHRoZSBxdWljayBzdXBwb3J0Lg0KDQpG
ZWxpeA0KDQo+IA0KPiBQaGlsDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRl
cg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55
DQoNCg==
