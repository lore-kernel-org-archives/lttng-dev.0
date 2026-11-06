Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3E606A328
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.lttng.org header.i=@lists.lttng.org header.a=rsa-sha256 header.s=default header.b=ibt9L4GJ
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4jLY3L2RyMz25jl
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1793955455;
	b=iEOLHQ1Il4HEjklchNMgFVxWepimkxGngLYyqux1JOxMTi7k9TlzpLCM4aqQuUn8CC6u
	 Z5y/VLhFhzO86jq9vQbLMqobjvOK+0WNpSaYY5jlrVPPDpG1+2ZygBNIAifz2xhmrfh/Y
	 YG88rRiDwQeWVHtwXoFxFuxuWXzuQ87AhIw52khUVgfBAuCADMMKi3JtMit2EWOSJYpoa
	 KPHGBzz7kjT6a13IB+rIbhGr+zJJJzWGoTxlL4qMAQuOaISyxi7EV6nmSGurkOQTMXdS0
	 zFRzu0aMzqPPvmMkAnU1CG8KHzkVA8MBJ77coFDLNn+/3bLLNguR/pySOqdLPlA7UOg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1793955455;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=kqHthzojZgbF1UxQuivT5kfKELsaqz7JtT3Yzc8psUo=;
	b=JHEsCZ1WPL7ANzzzN53sc4mZ4JD2MG7BKNttCxHHdpI30QrVWEkMO3Y1kG2uObL/3iaY
	 sxARcCM78x/resOSWPZYjOX78Pv8l6pld9mNfiB8fCcxfK48TqYfaSeZtTppAPlgHQUfe
	 auOv/egNbiunwgsb7b9SwNePyRYRAxKBVBpFlIdF+qXELe9WUtwB+cJrZjIsUBBWXuwhE
	 M9Ik5JJhITUN1B8JuD5FkAmcf6CwwMw0tV68o9ZKe8NSIcOv+VAFqur0mYXG5SVal10Ln
	 PCSu+oCAQIV/CyYH5AeOVvetbZE0wSGIkHbBOkNjUzmlEUkV9yrsr69Sf9qbDbTkx/w==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4jLY3L2RyMz25jl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1793955455;
	bh=kqHthzojZgbF1UxQuivT5kfKELsaqz7JtT3Yzc8psUo=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ibt9L4GJjXPjnsjbIIwaWFpFgX51K7YYCrwoKqvv+ITsSkJdae3Tzfmp1UWT/JZwX
	 YMCSVbOviEwQI2ajI3hEjPMUDpVQhHFvOotNFHb8ZjDvajRxVC+TYVQCfbG5P41UUh
	 W7vBQGNdD7knol9f1t4m/aOCrZDzP3dxl34oB4z0pgVBHnGzH33zusuqfW7uHLAztc
	 i1Gjs/aSwZCbsDFAxJIYJobq6/iKv7GcMejn7buURk40AghiHd1BL8HfCSabwIQiBX
	 I8FRHmuPSFyLa+6VDKShFgjjlhUmYkI2Wkkxxl2d5DXX6fneHH7o5w6zrckCWU0F/9
	 AtWUlBCb9J/IQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4jLY3L2RyMz25jl;
	Fri,  6 Nov 2026 03:57:34 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4jLY3H3rXQz25Rs
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4jLY3H3rXQz25Rs
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4jLY3H3rXQz25Rs
 for <lttng-dev@lists.lttng.org>; Fri,  6 Nov 2026 03:57:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlSYWkJmDHv25oqFV1adWl51SoK6V61+ewBJhbvryr0eBokzaz/I3DJ9bbMPSBo1AJiyhrY8K9XtV/vZgVh5bONlQ7THA9Wofvf8QoA/CHjwHpuDdgGMjGtmrktZf+UdxfSHjAnKHa2m0E4+GnfN+eve/IU4oDbw3/8ZOFCUBg6/x6YyBoHIWT9qjuLdnQaqJBMUGs65s2skSJnVwC1JDZqakhgZcuZsruAyJHyBvmSdGUoeRiw0bsyKfZF3eYFEyxlA+1+UO22903YAzKRYB4aIMsfhFRF6yD6COe7QOE7tasdaSRHK+T4WkxYpaJhw/SeLNwJqSBjOH92cfkHWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqHthzojZgbF1UxQuivT5kfKELsaqz7JtT3Yzc8psUo=;
 b=LPgUX8BXeG9xHVehTzMzG6RJVv11oekRpNbhRPmSXRbXdIsBKMcxVQcc/FtWfWK7dzrVuXFgnavmWuAeboLUhNzLkX9cfem8U4UhvdHSM7l6qHf/dfSDlYk59HA2XKvAThM0CLm/ChJfKCtzs7/zipfA8dDmG8T3Sc59nP5tJEl23H3AoTajAYMIFD95BYyOCmAmOw58aLVX6FMqYPiIvH5ZqT13l5aOTKT32/cBseRM0XkmjIiyVrJrxLj/aNo/NFBD8eWiMJs78cRmB5dZwgbTqp5kEo8ShG7cGngtG9dF5CaiT69wnLGkEXlF3cQoE6TyeOYd5xaYuf7knQ7biA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AM0PR10MB3219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 08:57:21 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.003; Fri, 6 Nov 2026
 08:57:21 +0000
To: Simon Marchi <simark@simark.ca>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Subject: Re: libbabeltrace2: question about thread safety
Thread-Topic: libbabeltrace2: question about thread safety
Thread-Index: AQHdYsYUcjT7hQzBSUe+mBwIDBagyLcf91KAgADczIA=
Date: Fri, 6 Nov 2026 08:57:21 +0000
Message-ID: <e78314ce6644c53ec7dda1e1761e37e58a4c7011.camel@siemens.com>
References: <44074c36528ca4a30909e21072ae67f37b0c244b.camel@siemens.com>
 <4b159ade-97af-4008-be23-c81be291f948@simark.ca>
In-Reply-To: <4b159ade-97af-4008-be23-c81be291f948@simark.ca>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|AM0PR10MB3219:EE_
x-ms-office365-filtering-correlation-id: b045955b-7400-4282-f7bb-08df3be3f7f5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|5023799004|11063799006|4143699003|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261102123227099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|10067099003|55112099003|18092099006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: UmqLHvC84Ig1QRKlAxYtdAnyb5f1ijWYU4RMmrKUiMDwHtgFfklnOBsuBqROhzfRXd1bYICDdEFvb8OJwb9fqvwQDwusOVLCcziyBXUB7iXh+CLd4S9R5KPaQ7Oqun0HQltAwD5ADYShwTRelC9dPhJBpI3B1fkuGgBzG53HAtysRKDuXWuEWOAyy0GCCp/CShF9/frsROG29o9/RWc8l81v01hLfQxdGXKdT1FxHzmPr/D46UD1l9mZwv8U2a5JjTHCiXWE3YSkvdDW7c3OIhb95mw/neapS13a3bxyFvIrtwnvfRl3cSZpQetT3UGd+GPdrRFkzEZOS0OcVccuZgjFeokXMOIsbvsJAaDbxShiAub6E3WBXh2t3RFwJpv/cje4u2DXbG2ejX4A3wCIIVmZ51djNPnUAak4uWaj7gSby3+nmzNtBfWGKpM0vkqZ/L3y1I5M+/VTPD1Vqr9kBxs2T0xAbKvTNwATIoPjvAd8rvBgoIn+Hst8LJ/uZ/ZiYzLrkUzEggOhq3g8KKwF956aS8f8S/elKd360r2C3k8JtrbjnmwbymGoKGcbJCbPPZiYR39yrHZC06P2MTcZ7RZPly9c8oNzkX8JmaJn66bPadXCghWTXJVpx8KcCC0aZgW2y8OMDI5CfETWA4tZsphanHi6TzLQvY9ev3boz9Jby2SyKo4N6eoxOeonMECBkkYgaZy+zmzn8TVHcveemfPx93Kv3rAVqcRZTLsGgFM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(5023799004)(11063799006)(4143699003)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(10067099003)(55112099003)(18092099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXRCOFFoVUpUZnR1ejhZVUt3OHpPMU5wc01Md3dKTHlXNUJnTFdCSXdIWG1Q?=
 =?utf-8?B?MU4zeG5MamY4bFNmTjVCRytiNmU5TEY5OHdPdTd5cXAyejVvZkZ2ekRpNWFl?=
 =?utf-8?B?eUpLalJSZ0I5ZHF2anNmMHRoKzJzbDg2V3Jkd1JUY2FwZzg3RVY5djFYNk9y?=
 =?utf-8?B?OXpUSDNiMXFkRXcwOWExVzVqTllRZlFOTndxVTNGWVpVTXZuWit3dGZneWVK?=
 =?utf-8?B?aCtMWGdRUmFjZjBiaGVydXlmWERHcEhlMHF1Zko1aFZhTDJGZ0x3UDZIMGtU?=
 =?utf-8?B?RUlwSWpDZHo5aFpXaHlKSHIxdytaTk1LOVRiUElRUVNKMm84VHNiaFk3Sm5j?=
 =?utf-8?B?alIvVjJ2MXJFd3F3RUc3V1RoUUM1MlBXMlRHQkNxcFE3bWs4bE1tYm5STXVN?=
 =?utf-8?B?SGszS1hOTzgxSDQxUEU1Qnc5L2pMZitzdG9vSyswTGUvOEhXWUlSVVNHQldx?=
 =?utf-8?B?N2lGWnVERzlRQVZMKy9CN2lVUmVsQ3NPVmFqaUhUa0dLTWpUZjRPOGhvTm1U?=
 =?utf-8?B?WFJMZ29jWkZXZ2w5RS83SUhVaVIwK3JoSitaNXhMOGpYWS9Xb0srNTFtRmkz?=
 =?utf-8?B?Yjg3Y0ZXN0pCMWRMZlB3UDZnMERhWUdkTjBVUGxVQ2ovM3RqbGpDVVNVTjVQ?=
 =?utf-8?B?dGdtbjY1Q2lXL2JHVkMzTzN1a1lURFBaQUgzV01YTGxBY3BTb3BmYmpYZ0dZ?=
 =?utf-8?B?bGI5R1pEMGNOZWRYVzdqL2NWTGxJNWdVOHFZd2tOYjBIK0FzTWZyaXhaQTA4?=
 =?utf-8?B?QjJHM0FXZHh2Zjc2U2IwdGxBcldIQkVKbitURlZjNmpmcWdSTzIrSWlvdENm?=
 =?utf-8?B?WFJnNTE2N2JpUElmRUIyOXByOW5NeVlsUVZ3ZjRyY0d5K3h6MlRZSTRsRjRJ?=
 =?utf-8?B?MW5mdGN0Vk5PbjN2SnlUN2FIWDF5RGVORURvckU1eHkyN2xsOG5VZDFXRzVt?=
 =?utf-8?B?ejNFaDBiVko1aGxmN1RVZFMrOVMyNXVHNlR2OHRBUStmbW54SXNucnk2dFdW?=
 =?utf-8?B?Z0l1Sm5Sb3VOOXJ1VVYvaXkwQy8reXJ2RlUrNVJCVFRaSUhSalF1RFZndHli?=
 =?utf-8?B?RlhMOWFXNzh0VTVQN2dxT0FnT2FadUVaNnQyWmg1K3lyclpPVjRLaXg0Y2VK?=
 =?utf-8?B?RGY1Z1lmVGJoR1paQURVUGtKU1VSUHRibE0wOEJZckt1K1liTGh4aThOU1RV?=
 =?utf-8?B?WHAwbzIzR0pEWi9DRTR6Sldwbk43NSttejlaMmlFMEpqdi8rUUhZV25ZQkdO?=
 =?utf-8?B?d0loN3NoeWkrUm1vU3BwMUpXTVZVZjh2L0VWU1ZTZTQ5bWZ6OU1kbTFHeFZj?=
 =?utf-8?B?Z1FTM0IvTFZyYSthVzRBQ1IvMCs0V2g2TDIzelRXRFY3b2hvSnBOZFBjeGdi?=
 =?utf-8?B?YTRZL0t3R0FTaGgxQ1RMRzB2R0VnblE5VHRNaDBDRGRhUUEvTkVYcTFyeEU1?=
 =?utf-8?B?bXgzanF6VHo1aUFRRWFPNWl4dmNPUWxGZkh3NXJON2R2aUNYTzZOTDlmUkZE?=
 =?utf-8?B?MmpVZ1lvUnQwUVdhZzI2VmFKOVFGZ3hZQ2ZSaVJQMW1KQXhSaU9SVjVxQXNV?=
 =?utf-8?B?NFRaWERJcTNKa25pUHhoNUNIVjNHR05SOUdQNWEvV09RWE1xaWFKbkRlQkZ6?=
 =?utf-8?B?WldxWWtPSzhsZDVHZFk2MVpyQlkxTjVrK3RZcm9xaTJYekgxdkIrTXMxVmIw?=
 =?utf-8?B?Tnc2MzI1ZHBBaExuRXo1dUhFc2pubGVQUUxHTjlUM0FJVHV6ZjIraW9RMTBH?=
 =?utf-8?B?aW40bnpIMUZONEkzMmZ1SVhxUGptaVBHYnY1c0xvK2VyQURHT0trV1dlcXA2?=
 =?utf-8?B?KytkeVIzYUVUT244SXRmWnZLVmNISTJUWkF1WlQzV2p0Y0ZlbW85Q0gxaVZh?=
 =?utf-8?B?UUNDTDcwSXlYaEdNYW5QZnJYMkFWaS85OFJzaGRLRW5qRWpidUFtSWQvamhl?=
 =?utf-8?B?Z3M1Q3llZzU3NWY1N0UzTENtWDFYNlZYVmRhNjVjYy8yNkQ0dFZ2ZnBIamhp?=
 =?utf-8?B?MG1SbGQ1Z2JlUGlqQjcyRGRFZ3BCY0Z4bUxMM0NDUG1lSnNpWHBRNVo2ZkpX?=
 =?utf-8?B?RkdkcUcrczl5WTNzRGRkck5IMjVTWkVrdEJCRWxqbDB2UXFYY01vL1FMUTJ6?=
 =?utf-8?B?VlVXUk1mWkxkaTlZNG9IUTljcjFoenEzNGJreXR0WnlXQVZtYTFmaHpxM3Fv?=
 =?utf-8?B?NlJpZFZTbWtMK2xJcTNKYTRKK05vZnY2UkFTV3JUY2o0N3BSTndVT2JJR0JN?=
 =?utf-8?B?cTdqNGEvZ01xUHp2K01tM0lKNXh4ZmNxeGl0R1p4am5yNGdQbFhXem1ldDlS?=
 =?utf-8?B?bU9ESjcwNkUzdWR4eGZVRkF3dy9pWUp4Mlh3RWJNbFZEOWs0UnlrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBB359C0B5A7F4F9E6EF43EC734D8FA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b045955b-7400-4282-f7bb-08df3be3f7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 08:57:21.3295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25A8nvQaaZlW1qAGFYj2bxrAIiVVrGgB+8hFUaA0Ai/Q/Zl4OE4J5/fMtdnnQ1uzaYWB9tBHajsSrE9vu08tDSHL77niHAc8Ftd9PESWRL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3219
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Moessbauer, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTA1IGF0IDE0OjQ3IC0wNTAwLCBTaW1vbiBNYXJjaGkgd3JvdGU6Cj4g
T24gMTAvMjMvMjYgNDoxMSBBTSwgTU9FU1NCQVVFUiwgRmVsaXggdmlhIGx0dG5nLWRldiB3cm90
ZToKPiA+IEhpLAo+ID4gCj4gPiBJIGp1c3Qgbm90aWNlZCB0aGF0IHRoZSByZWZlcmVuY2UgY291
bnRpbmcgaW4gbGliYmFiZWx0cmFjZTIgaXMgbm90Cj4gPiBhdG9taWMgLSBhbmQgYnkgdGhhdCBu
b3QgdGhyZWFkIHNhZmUuIEFzIEkgY2FuJ3Qga25vdyB3aGVyZSByZWZlcmVuY2UKPiA+IGNvdW50
aW5nIG9uIGdsb2JhbCBvYmplY3RzIChsaWtlIHRoZSBwbHVnaW4gb3IgY29tcG9uZW50IGluc3Rh
bmNlcykgaXMKPiA+IGRvbmUgaW50ZXJuYWxseSwgSSdtIGFzc3VtaW5nIEkgY2FuJ3QgZXhlY3V0
ZSB0d28gKGluZGVwZW5kZW50KSBncmFwaHMKPiA+IGluIHBhcmFsbGVsLiBTb21lIHF1aWNrIHRl
c3RzIHdpdGggdHNhbiBzZWVtIHRvIGNvbmZpcm0gbXkgYXNzdW1wdGlvbi4KPiA+IAo+ID4gSXMg
dGhlcmUgYW55IChkb2N1bWVudGVkKSB3YXkgdG8gcnVuIHR3byBncmFwaHMgaW4gcGFyYWxsZWw/
IE9yIHNoYWxsCj4gPiB0aGUgd2hvbGUgbGlicmFyeSBqdXN0IGJlIHVzZWQgYmVoaW5kIGEgZ2xv
YmFsIG11dGV4Pwo+IAo+IEkgdGhpbmsgdGhlIGlkZWEgd2FzIHRoYXQgcnVubmluZyB0d28gZ3Jh
cGhzIHNpbXVsdGFuZW91c2x5IGluIHR3bwo+IHRocmVhZHMgd291bGQgbm90IGJlIGEgcHJvYmxl
bSwgYmVjYXVzZSB0aGV5IGRvbid0IHNoYXJlIGFueXRoaW5nLsKgIEJ1dAo+IHlvdSBhcmUgcmln
aHQgdGhhdCBwbHVnaW5zIGFuZCBjb21wb25lbnQgY2xhc3NlcyBhcmUgYWN0dWFsbHkgc2hhcmVk
Lgo+IFRoZSBhY3Rpb24gb2YgYWRkaW5nIGEgY29tcG9uZW50IHRvIGEgZ3JhcGggdG91Y2hlcyB0
aGUgY29tcG9uZW50IGNsYXNzJwo+IHJlZmNvdW50LCBhbmQgc28gZG9lcyBkZXN0cm95aW5nIHRo
ZSBncmFwaCAoYW5kIHRoZXJlIGlzIHRoZSAiZnJlZXplIgo+IHN0YXR1cyB0b28sIGlmIHRoZSBs
aWIgaXMgYnVpbHQgaW4gZGV2IG1vZGUpLgoKSGksIHRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRp
b24uIFRoaXMgYmVoYXZpb3Igc2hvdWxkIGF0IGxlYXN0IGJlCmRvY3VtZW50ZWQuCgo+IAo+IEkg
dGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSBmb3IgbGliYmFiZWx0cmFjZTIgdG8gaGF2ZSBzb21l
Cj4gc3luY2hyb25pemF0aW9uIGluIHRoZSBwbHVnaW4gLyBjb21wb25lbnQgY2xhc3MgYXJlYSB0
byBhbGxvdyBmb3IgdHdvCj4gdGhyZWFkcyB0byBidWlsZCwgcnVuIGFuZCBkZXN0cm95IGdyYXBo
cyB3aXRob3V0IHJlcXVpcmluZyBhbnkgbG9ja2luZwo+IG9uIHRoZSB1c2VyIHNpZGUuwqAgQnV0
IHRoYXQgd29uJ3QgYmUgdHJpdmlhbCwgYW5kIGl0J3Mgbm90IG9uIHRoZQo+IHJvYWRtYXAgYXMg
d2Ugc3BlYWsuCgpXaXRob3V0IGxvb2tpbmcgaW50byBpdCBtb3JlIGRlZXBseSwgSSBndWVzcyBq
dXN0IG1ha2luZyB0aGUgcmVmCmNvdW50aW5nIGF0b21pYyB3b3VsZCBiZSBzdWZmaWNpZW50LiBU
aGF0IHNob3VsZCBiZSBhIHJhdGhlciBzbWFsbApjaGFuZ2Ugd2l0aCBhIG1pbmltYWwgcGVyZm9y
bWFuY2UgaW1wYWN0IG9uIG1vZGVybiBwbGF0Zm9ybXMuCgo+IAo+IEluIHRoZSBtZWFuIHRpbWUs
IHlvdSBjb3VsZCB0cnkgaGF2aW5nIGEgZ2xvYmFsIGxvY2sgYnV0IG9ubHkgZm9yIHRoZQo+IGdy
YXBoIGJ1aWxkaW5nIGFuZCBkZXN0cnVjdGlvbiBwaGFzZXM/wqAgT3IgaGF2ZSBhIHNpbmdsZSB0
aHJlYWQKPiByZXNwb25zaWJsZSBmb3IgYnVpbGRpbmcgYW5kIGRlc3Ryb3lpbmcgZ3JhcGhzLsKg
IEknZCBiZSBjdXJpb3VzIHRvIGtub3cKPiBpZiB0aGlzIGlzIGVub3VnaCBvciBpZiB0aGVyZSBh
cmUgb3RoZXIgY29uY3VycmVudCBhY2Nlc3NlcyB3ZSBoYXZlbid0Cj4gc3BvdHRlZC4KCkFzIEkg
d2FzIHVuc3VyZSB3aGF0IGV4YWN0bHkgaXMgc2hhcmVkLCBJIGp1c3QgbW92ZWQgdGhlIGdyYXBo
CnByb2Nlc3NpbmcgdG8gaW5kaXZpZHVhbCBwcm9jZXNzZXMgKHRoZSBwcm9jZXNzaW5nIGlzIGRv
bmUgYXMgcGFydCBvZgphbiBIVFRQIE1DUCBzZXJ2ZXIsIHNvIEkgZXhwZWN0IG11bHRpcGxlIGNh
bGxzIHRvIGFycml2ZSBpbiBwYXJhbGxlbCkuCgpQUzogV2hpbGUgdGhpcyBzb2x2ZXMgdGhlIHJh
Y2UgY29uZGl0aW9ucyBvbiB0aGUgcmVmY291bnRpbmcsIGl0IGRvZXMKbm90IGhlbHAgdG8gc3Bl
ZWR1cCB0aGUgZ3JhcGggcHJvY2Vzc2luZywgYXMgdGhpcyBzdGlsbCBoYXBwZW5zCnNlcXVlbnRp
YWxseS4gSWRlYWxseSB0aGF0IGNvdWxkIGJlIHBhcmFsbGVsaXplZCBhcyB3ZWxsLCBlc3BlY2lh
bGx5IGFzCndlIGtub3cgdGhlIGdyYXBoIGxheW91dCB1cGZyb250LgoKRmVsaXgKCj4gCj4gU2lt
b24K
