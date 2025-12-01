Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE75D111A8
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Dec 2025 09:34:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764581672; x=1764588872;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-ID: Content-Type: Message-ID: Date: Subject: Subject: To: To;
 bh=br7V4vW85ew1APXIxV4B0eUAKebef78D79qUQX0xQsU=;
 b=WvK7+KUv0ZJ4ZAZICkxil0hwdjRHI+OJA2W+A1w5KHv6SV2+MYj1B8YguPG99wcJQ8rCe14cXB+Cjnw7t+PsDFBvFSwW+LSP/Y/ODrw8Tnmii5Wx3taIlAfWljYcEQBkm2S50iE2No+u+GhvSLih14YBW/nSfyOl+ADrmlMqXWzMsbxpUmV7nBt3ZBKxYh6MfoRlLVYKjJMLV7ZJNNWSEAvg//+cCRG7QUsG+g1WMvPPWlEs0ojvvq0z/uzS5hct5+PQVAH2jAFcUgjo84TZTLVY4yBeGz/oX8KXu6792y6adFYbIyVe1xcq6bTLlty23Q86XZFZbc9ydfSQC7HiXg==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 fd190a619a94d60d5556b9f7e5c68c34bae293099c2b629016c7a2e02f917cac with SMTP id
 692d612892080432d8b9e54f (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 01 Dec 2025 09:34:32 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dKdyt2235z1C9R
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1764581672;
	b=Z8wVhLh0nSknyTi2m//mRpu3sQ9TXeXlzzUY0ONXQdy0usbLOlilSBLGT/oEOTON3gl7
	 1fwmEnHqll3smhihUrJt+6r2DYXPYz29qjs8ai/Fl5F4RzTX0UIV1wVwNC+wquS7eFTjU
	 zSLO0KVo4a3YLrEV07iaRQ+Wnb7wYZUwEE4ey5kly9dAlO29owXX3sxXATVxJIAn3B1ih
	 T1hLXOD181T22erJ/6TkOeUT6My32gPlzCGkq+VqqleWEP/KevvAmSwP7oTeyOSSLmaQ0
	 gozi+2OcXrDjJ7r2Ef5x03hxBC/93/0KfFS4tQBgFXrFuq3Qe3mbB7/KjCqJuOTMwSA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764581672;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=br7V4vW85ew1APXIxV4B0eUAKebef78D79qUQX0xQsU=;
	b=GU6zDzjPUCoZ7gUF3TmITR2KXT7Pbztz9GEGQ9fT7GqzNFifzUP4gVyEM5wSXuZvDU0b
	 ZOCqN156SRFa6gF1vW9qBDRukCV/E5WV1Ns7Gl3rVWiz+q40aVlBuJyv9srMDMmcuA3Vm
	 aba65GBybmXBuljGPlUOc7GTUU2Aov/Yv9iWTUa4KUCp+Uxc2+lEDiliL+RRCdJ57aVlp
	 /rLULHIZYfREA620JcOQ7L07edC3SEvPgaEP/dNm8FSSBRmWpw7RBM/BkpaajNDKL/l6v
	 gAzLQtVhZJ9iKPPpi9O8ldPmoERitDJi3s8W1lgRjineBAK4LmK40q9+5P0H+ec1Z5Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dKdyt2235z1C9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764581672;
	bh=br7V4vW85ew1APXIxV4B0eUAKebef78D79qUQX0xQsU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=i1X9gaClu6BfPDWxOCGILk5mK6GpPLcmRqf8YolxVjyp4XSqI9cIAY/je7VpBnDg/
	 GLnGu2GrhuZEo8o9Wfo3VJQDiFjMKbAJSqHBVRcwRjc5krMLY1SPsxPH9hTl7aUCfp
	 nmEqyc2FcEwSCOJxc2xJiJbbwcbBkLKtgkGt7TMrYvD68ywGTTvhK2jIo1nUQ4w8r5
	 QTvBF20zp3s9+v3Wgf2NG0hxyFsVflInCI2zQGXZ2645z1yeB9rCoHz54/iz9LnDS7
	 eSDDe262+ASVWaqzq5Of7JPJ2qv3UGNy7JPRPmxT/1WXas0lul5OKrVtRQLLZAw3wG
	 BJZYMMu/XTO5A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dKdyt2235z1C9R;
	Mon,  1 Dec 2025 04:34:30 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dKdyr10qhz1Shb
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dKdyr10qhz1Shb
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by lists.lttng.org (Postfix) with ESMTPS id 4dKdyr10qhz1Shb
 for <lttng-dev@lists.lttng.org>; Mon,  1 Dec 2025 04:34:27 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy2sDK4PzDsqSAk9bieXtKExTX50LwhbZR139KVCfCuc1bUarGPr3lOLJh9VGLzsy5yurd/nMuL0ZZk4Y6u+hG3ywOsnLYZqLkrNGuI+lY5V6sj5nFVrC0k9uu30ILDxvKuLx7d68kymnPRX+HRsnZG3ggi4m0RQrEyqYgcxW9H9qzTLKq6F6yZfhMpbG9csQuqZn4WFEBJH3uywjIBN4IAVYevCn3VhlfB6xroViD39QFIFWD8+Fmzt1w8n0OhOpZadhphyutyQt1IwjO2mOHZGOZgp1z+TltGwcF7OZUCgtosC8wG3RKI4UU5T546tLM9fzE9RH01WLa+4FiPqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br7V4vW85ew1APXIxV4B0eUAKebef78D79qUQX0xQsU=;
 b=nsTCmYzpk0X6nkJIvD8YECfiQf7BIs0mh/iovA2PMQfGPYXmd4UN/z+Q2yF4Hb1sei876iS1lru5mbnnaaQlM25udkFuMtt+y2gOqFsplO4oCWPfMjhV0e20/MYo2UejUPDRa0BheP3brlMjkPmVw331wK4RCrau7Pe7SEdGyWTRkIskqxDvcMUeHoiixEI25XJjfJLUFFkUn5Db+jxmU48dYcIS2hg6NFAw1A5Oqhh3GkIvvent/cEDUXnxq5jSYyQTt0BSPhnU4TxzNLG0BRLGOaE5AfS7JpH1ykcKwviLhY7bUc7exDWdZxW3C/5ye52fVTAGfkFZLXWa8D2DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by FRWPR10MB9279.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:188::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:34:23 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:34:23 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: babeltrace | sink.ctf.fs: add support to create LTTng index
Thread-Topic: babeltrace | sink.ctf.fs: add support to create LTTng index
Thread-Index: AQHcYqWtcyrB96cmi0G5chrH4BvgJw==
Date: Mon, 1 Dec 2025 09:34:23 +0000
Message-ID: <cd2f473df84132beca2d926819e15de514e10589.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-7 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|FRWPR10MB9279:EE_
x-ms-office365-filtering-correlation-id: 19f97ef3-824c-4905-1a7d-08de30bcd011
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RWtOa3p5VGxXUXh6RWRvYk1rbzExNlYyZkpJTlRhcnkxOGFsVVE4WEhrRFpL?=
 =?utf-8?B?amQ0L0hqY2J1aS9QdHFTN1dxdjhPNldIdi9SRVk4bG5vSFVoNjE0ZUQ2cGZZ?=
 =?utf-8?B?RktTRzc4OHltaFA4bGZjMWtWUVFScG1pNzJSSDA0clpvRlBNbkpubUpNWUsx?=
 =?utf-8?B?MVc3Z2F5d2RXNkRKclBiMGtHZG9DOG1aSzREdTV2ZThhT3hjMlNTRHRKMWJk?=
 =?utf-8?B?c0JvYThlUjNnMlBEQUcxWTQ1R0VTZytBWGt4NitKV3dLZENvWmp4QjA1dVIz?=
 =?utf-8?B?Tjl1SjRxcnF4U1BuYTFhek9xMC8zYlMxR2lOVlJia2FUVlFUNXIrZ1RFeGlZ?=
 =?utf-8?B?Z1dnbE9WVE5kT2Y4YUFVWUV5N2VzMHhkWGpBbW9sazdhd1VMejRVVnI0c2Zy?=
 =?utf-8?B?ZjcvbjAwcVJhUXFrZ3FJK2ZRU0ZmWVBnM1B3U24xTU5ycmprYVE1YzMweWNh?=
 =?utf-8?B?Q2dOMlg0Y0ovbktOOHhrYTAxMmxBa1ZRMGNHZzcxWmFkYWFDNmVrOWZHWGFv?=
 =?utf-8?B?MExMR0l2N0hzZ2pLT1NLU3g5ckZhZzgwMXM4bzhQaytQQUdJcy9GeGJiOHNr?=
 =?utf-8?B?M1NEcXlUTmsyVUFSYU02TnRaSDl0MWpEMEhabTFtampCdHV6djVmQUU0YTVF?=
 =?utf-8?B?RW44b0xnTHc5Wmk0ak42bW5WektQSk5KcHY2Zi92MEQ0YmdJR3liN2NVbXNj?=
 =?utf-8?B?R0d6cTYrSWE1ZVdSbE50NzVicVVrZFJmMEJjTXlrWGdlOEdjSC8wYVZneTZU?=
 =?utf-8?B?NEFKY2psNFdPRWsrT2NvVHM1T0x4WFRUQklFVG42SSs2UXQ4dmJja0ljK3Rs?=
 =?utf-8?B?WkhmNzhBTG1VaW5ha05YN0h2SWxXbnY3UG5zMkpwT3prUkQ2ZTdiWUtyUDZx?=
 =?utf-8?B?eW9PRTJ0UVlkcCtrNEZFKzQvSjkycHBSa29Pb0VPR2xtZVlCWjFhRE83aGlT?=
 =?utf-8?B?SGlKZ0xIV1pSRjQzZzhZaFQzNHdheTViYnpsdEY5QVpzZjZIbWhBN1BBTDc1?=
 =?utf-8?B?K2xwbElWTElHY3RaUkxvU1Z2Sk9MVWdiR0lKb1M3RGc4bTB3Y2tqNnJmSWI4?=
 =?utf-8?B?c3dMaVoyYWFKNGNxcGtKZXVqUWp0MXFDZVFMek9mYmpBamczdllrbnRiRFJ1?=
 =?utf-8?B?T2UrTytOeGtiTHIvWUV5U09taW0rVUx5eHVkVytpOHZScVNlUnVrT1A1ZHVw?=
 =?utf-8?B?VFhxWlE2dzZzU3ZWUmZuSlFxbmJFZFp4Q2VnN0NpaDhvbkpGeFRYRkpWVWRN?=
 =?utf-8?B?MUNiMFZSeXc0Yk02ZUYwd2ZienR0YWNENVY5WFBxcHVPSUFrTExhQlpCM3lC?=
 =?utf-8?B?eXZ3S21vVURQQ01BOWc1dmVEQjJSaGxvckdLbEJGTzY1SjUyY3JHWnd2WGpL?=
 =?utf-8?B?MHJDTzA3SkVmL2ZTemJXYzVEYlkwQkc4c2NONXBib1hBUlZxT2hPVDRqNnRn?=
 =?utf-8?B?cGFWWm5KY0U2Q0tUL08yalVSTUJUY1JKMGQ3WG9NK2FER0xVaXFmS21aNzla?=
 =?utf-8?B?SEozMzhoZDVYa21BRVg1U29nVDFvamE5YytCcG9iZXdKdjliZk5aUUVxcy83?=
 =?utf-8?B?NFNnOFE0d2Q2cEdrSkdZVzBZRnlLbWFZa09MUzc4RGhIV2FpWG01SVpLd0RV?=
 =?utf-8?B?STJacEs3QVlXRDdLQ1FpOExKSjcvWlREYWsrZkxIZ2VjNG0wandvcG9uejRU?=
 =?utf-8?B?TUFiNU84dU5RSDl2MExHUkVQeHhMSmplbU50UE0vcnJ0UlhaY2w0dlI0eCtw?=
 =?utf-8?B?SlhNd2IvWG1mZmFsZHFPb29mcHRBR2VDbUpnUzBPSy9oUGNzUHlWeFJGMC9q?=
 =?utf-8?B?ZFk5UlY0SFJoOXNpTFRzaWp1TnpEL2Jtb1U5ak5TYlNxRi9zYWFlR3htRGs2?=
 =?utf-8?B?UThWbks5MEE5RFJ6OFFpUk5xcnl1eUlrTWxQSGRHR0RRSFJTNkQrbTZGK09K?=
 =?utf-8?B?ZlNXdnJBdW9sbURIVGVhaWpxbHpNZnZDQnF6OXo4MUkyZGpXTmVWUitEZlZ2?=
 =?utf-8?B?VlRUOWV3akVUL1hOV2Y2RHZsdjZ4ZlliK2pNNG1DWVJyZDBZM296N0I3T0xD?=
 =?utf-8?Q?srOpWo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eThpZVJhd3FGNHRGNWJBZERGVVEvVnVBM21TTVp6Z0tFMmUxdU85OGVROVFE?=
 =?utf-8?B?TWIyNzJrQU5MU0t0ejhjdTNXQjIyeWhOUXpQNi9oakxCTXB1aVUrV1pnS3Ja?=
 =?utf-8?B?VERaenM5d1lIOXIyd0R4YmFPSzgrWXBDclpIME8zMlpGdkY5Mlk0REMxR0w0?=
 =?utf-8?B?ZHZqRE5kSUhpVmpkWmZVdWdVZVhUcUxadmV3QzQzaGVzT28xanU1eVF0UEdV?=
 =?utf-8?B?WHVkZkV2NTBjSUdjZ0FBY2l0YmtIWHpMRDdJVDFxalNHYjRCK082bEt5UEZo?=
 =?utf-8?B?TXVDdjZDNXFvYVlFUVRKRERPZ3VScEExTko4OGtrVXljUkZBTlB6bDMrTlpn?=
 =?utf-8?B?ajNkdzBQTEtSc3JZUGVEVWhFNnUzemUxR0JVQkZLM2YrWDZWbDNNckNnT2Ey?=
 =?utf-8?B?VzZpSW9UYUk3L28yRGg0S0hBeURYL1JwYnJWanBXcUNWa1hFUUJlOGM4SGwv?=
 =?utf-8?B?TFArbVk1cU0zTkRkaFVMUFZDSmwrYTdNcyt5N2g4UjBXN3RENFk4SGVmdWgw?=
 =?utf-8?B?Tkg1TVI2OFFJaDlRamRrVVdESVJRVUxzSDhmZTdTbXMrZnp3Q0xIUEhwMEdX?=
 =?utf-8?B?NUVOd3o3SFlWd3RIa0I4OXY2bWJsOFdQV2t5UGwwdWtXYkt6eEUySDNROWM2?=
 =?utf-8?B?bzRUdUsvZGVwVnZlaVZ6ZzJlOVh3U2c0RWRMVGV4YmlrWWlmcWRjQTY5OGpp?=
 =?utf-8?B?VmpTMW1mdFVBZGR0am9rd2s4aCt6Q2lvZzlUUWRibWUrV2NTZEMyNlVhRVNI?=
 =?utf-8?B?MVJwUTBKaDlJTTJlVlA3SUx2TlE4ajNkYU4wVVZmRDhPbTIwMmxmRHU4Wmw3?=
 =?utf-8?B?bUtnUS9PL3pnMU1lZERPcy9xU2ZudE8zdzM1TUZ2bUJXZG9mRUErMUtiR2do?=
 =?utf-8?B?K09VbGtKQXY0a0JOTW9WSGxnMUM3b1ZTeVNuR01HeEt0WG9Td29USUhGemQw?=
 =?utf-8?B?MjJ5dmdncVZKaUF6bkQwR2xkOHdOT09ScTA1Z24welpTblNURDFMMjU1b1pJ?=
 =?utf-8?B?TmNXam91R1BuUEttRWFzU0QrZVNiTi9ZWWlnRU5VR2YxVnJxQ3JRSVNUUG1I?=
 =?utf-8?B?Yy9QeHkraEs5bGM0dlRKN214OVdSTXpiSUlxaGJCdHF5bUdkOU05MmxwV2tr?=
 =?utf-8?B?cFpIcTgyQ2p6cGtWdXZ1eHM2UW9FVzhGY2xjU0pZUGhYdXpjbzZoY2dRbzJ3?=
 =?utf-8?B?MnZ3Sm02QjEyUjVJdmMvUkI3a1BYZFJ3VitLMzFrU2FSSmVSZTVPZnVGbGxo?=
 =?utf-8?B?NmFXTUlqQkZPQVlzNUM1VzFMNUpDSXlTU2dHbHlwaVdjTzFRbXVxMGYzY1Fa?=
 =?utf-8?B?RzFWMDkwWUQyWjJ1cTdqRjBqdmZ5RjFPNTJqdnlPc0hVSTBuVXBQUEhxTmVj?=
 =?utf-8?B?dFhHcEZPTnFFanlHYUdIWE4zakFOeTBhcHVWWmpqMTVkV09tUTc1ejZlQ3Uy?=
 =?utf-8?B?ZFVqS1plQTZUbEhhYkxTc0pPOCtWSDZCKzNTblppcHRFM08zcWwwR0pKSnda?=
 =?utf-8?B?eCtJbEdEa3RBZGJROFgyQmpmZVMrbVVGUmczOG1LWjlWcFI1MlZtZklpK0wv?=
 =?utf-8?B?SzBPM05taUVyZ2c4Sk4xSmp3N0E5aFZUQS8wVHhvbXkxVXlWb2txSGIwMTF0?=
 =?utf-8?B?KzhnQjc0T2tsdDUwdUxOblo4dExoM25qVnB0UWhIVUkxMk9aeVZiV29pZGlJ?=
 =?utf-8?B?alR0T0NYOGM5YlNobmdNU0tXYWVrV1BBRVlZYUJ4cmkyRkN3M3pZUUZ0U0xn?=
 =?utf-8?B?cGNDT3dQaUJ3elNIWERyU1dnZ1RXMmZ5cnA0U2s3OEVyazZWNUlVZW0rRnlP?=
 =?utf-8?B?VGhmQWFHRGdnQzZwbytneEhXdmR1NUpjN2FoTEgvUGJGZG4rSHBnWWRZcGp3?=
 =?utf-8?B?WG9GTkEvanJ3UFhDQWpqSG9KcGZKSU02UEJ2MXFRc0ZHeUVBVGVQZUp0bHI0?=
 =?utf-8?B?N2thRVBya3RaeUhzMU9VOVJwQ2FycDVkbjMrTGxqQlcrWlRxdTJjcGl5Rktp?=
 =?utf-8?B?eGxCS04xVFg0RmdHczNqTE92WUhiWUF1a3IycmRtWGo5NkZGdVpPZUxna0Jz?=
 =?utf-8?B?Q1I1UzFxMmM0dVBxNTJYd2thNWVEdUZydjM3UTc5ZXd1RjZCVFB4TlhwNzdT?=
 =?utf-8?B?alVHMGllOW5YNzRHanRKTmwrN0dMeGtKSGpLaFhTcXlZeFRjOVdNVHNXc0VD?=
 =?utf-8?Q?C1PYy/F40bNQtXLXVbdXeq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44750B55A74CAB41AD7666FFB2ECC06D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f97ef3-824c-4905-1a7d-08de30bcd011
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 09:34:23.5661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laIDjadjz0cyrrR3OlbCst6L8AOKZ3HgxYNAGD2h6NY+v041lt0OR6BGaUMrPVhfqxNTumeGy/vu++Qmbp1l8YcS8X7JP3GijASp4vftYiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9279
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

SGksDQoNCkkgcmVjZW50bHkgY3JlYXRlZCBhIGJhYmVsdHJhY2UgcHVsbCByZXF1ZXN0IHRoYXQg
YWRkcyBzdXBwb3J0IHRvDQpjcmVhdGUgYW4gQ1RGIExUVG5nIGluZGV4IGZpbGUgYWxvbmcgdGhl
IENURiBmaWxlcyBbMV0uDQoNCkl0IHdvdWxkIGJlIGdyZWF0LCBpZiBzb21lb25lIGNvdWxkIHJl
dmlldyBpdC4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9lZmZpY2lvcy9iYWJlbHRyYWNlL3B1
bGwvMTIzDQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4IE1vZXNzYmF1ZXINCg0KLS0gDQpTaWVtZW5z
IEFHDQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJpY2gtTHVkd2lnLUJhdWVyLVN0ci4gMw0K
ODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0K
