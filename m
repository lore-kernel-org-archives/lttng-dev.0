Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3341606A32C
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Oct 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.lttng.org header.i=@lists.lttng.org header.a=rsa-sha256 header.s=default header.b=OuDQTX5l
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j9whW3L2Kz1nfV
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1792743085;
	b=WAnM3oeK2DjeeJBI6+l9Y/CBRiY6zOAjDld846FiR6sywusbuIhhZFUGTWyISGOwibj2
	 wQD9pSEfTr+5qhn+qDmwTk63s+d+vMKftYoOuQOFI8WluWMdj5H2g9QsFZ5KLr8ce5kQw
	 hrqPECRDeMkByHCCMdEF3owOHfMRUR8IWqlAUPn+qtx8H/dl1Lxb86a9eaPmAS26Bq86g
	 FbjkJ+K/mtKLiqcNeWEo4MuaJ/gKT0ouWJ/SPk7HyYzFxCrCx6+BPGNOeer9tYoopEW2v
	 4Pf1vU5xl3SdBRubmNRsRYydMR1cgJPUAxvriJGInWzR6QtF6AaDF+vATLOkIr9sQSQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1792743085;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=uEZK+YPSQYd0GNqjkwY34APVXZ3+a7HT7NpVHC30Jpk=;
	b=eYxmE/cKz6CrFeZlOuoSbcKIGN/Wp2KnBFPizeqp92MmXyJ5VxCZjtXhaXOQNZXbGWwZ
	 k6ar6oGTLvu3Eov3qyMQR7OJcFjc4KuJYEjMCZbRJdVXTzXasSbDNeNGFT8jufzDcm27o
	 s/T6QK7IXPLqfEbDgdk9E7E8omnctTKVBsbqdfXbVLrjI8acihnp17MNOAqSx7SxVIBcm
	 uFYt0GK/YWHKX8lPG5gShENYUXR+34/QjDz3eQhCxkfcyYEGrZs2ik7e/IWz0B0PGUCHQ
	 w8NBmMRxLycrKkdMk2oeGs6f0hWYX8iJQjsR+8nGUdsIbX6JLelr2NuMZMlJE7R1zdg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j9whW3L2Kz1nfV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1792743085;
	bh=uEZK+YPSQYd0GNqjkwY34APVXZ3+a7HT7NpVHC30Jpk=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OuDQTX5lbCHJMPkBkkXDCgEn8E6ztUeX5+uTjZ/5eBnVXhFG9xNx8gbx0o1eq8jyd
	 TBXfHXZYAWzfNt2M1xjgDMwwYxT0Hb1iLrj45G1kBh7jvGNnE/QS3Z7mZDHarEBtjL
	 Gw3JLgJAtVVHnIZNpc2z8wN1zCPDjHMHHAdmm6qzAqy6FZXhzEWiuk64PZbRuW6Wk7
	 yDzib6p59BlUQbT00OaVL6om19HcZmr6PSMVCA3SLJ/OA/Qr2tGao0fmdmh6ntZQ+w
	 jr1CQKDOC6K/6oR/EuOEv3SZ1Zg8L5rAYhOijyeG6A1Dy4duk/2oBKBsJ+pH6NXaZv
	 Z3HXBuryZIU8g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4j9whW3L2Kz1nfV;
	Fri, 23 Oct 2026 04:11:23 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j9whT6jwpz1nkW
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j9whT6jwpz1nkW
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4j9whT6jwpz1nkW
 for <lttng-dev@lists.lttng.org>; Fri, 23 Oct 2026 04:11:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itcphSvEBSvaX15jdjDKmLYyeOmVsTFtKACAyU3ZHBodEq/IjLdiYlX5xuFdJvLIwjj3bMcV+oRSYwtwVfZRJubq7VD6xZCJB2NVFNVUeHbp5+i385RKzM4ZDHW8TBJPRZ0WyafckmIPt/2WGACteLc3ywuKHf5uINktIgTPUErz9gaQGUUFetCHbk7IK1CpWeVTlsZsNnTuQjnOwCJBH6D7tVLOwiKOzn6+OAIo0Dfy9paeizebNXi8N7OKaInFBcG+kS2N8Y4ThWlyezUbTMIMdSO/HyP+LN/uEXbk7lsrBk4MUdKXgx/SCAzBHpVkffFa53f2d0Xtugq6M8H/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEZK+YPSQYd0GNqjkwY34APVXZ3+a7HT7NpVHC30Jpk=;
 b=v8cJmCeRIUi4vL5cLn7sFVq0AOf6xCLfFbQAzD+5QPgNtj+abtwmWM2MsxkIKo8WG8tL4Tf+pqYv/mn6PPUZSQ1E9b/0EBEOGoy/nxg1khCzTWPu7e4ExtywYj6lKa5bYThRLe+sRtLLcD2ocihGrKceSIHpfys13VLsmlubyw8/tAlqrTxUtU7dgOz1/untiSLnPKDY8CMAUZ8yWq5OAB/YTinHfJoznIN4FecuAyhgPFIxI1RYbP6RrzXguQgc3WQijNGvw4p0j4MYiOBH37MtznKgNOg9nDic/xUT7CzFDdUm4gZ0HP6uA71Gi3/P3JaqGzyCyWcbXygzXZzxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DB5PR10MB7702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.3; Fri, 23 Oct
 2026 08:11:17 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0569.000; Fri, 23 Oct 2026
 08:11:17 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: libbabeltrace2: question about thread safety
Thread-Topic: libbabeltrace2: question about thread safety
Thread-Index: AQHdYsYUcjT7hQzBSUe+mBwIDBagyA==
Date: Fri, 23 Oct 2026 08:11:17 +0000
Message-ID: <44074c36528ca4a30909e21072ae67f37b0c244b.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DB5PR10MB7702:EE_
x-ms-office365-filtering-correlation-id: eb7d0242-fb95-4e89-be01-08df30dd36c7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|55112099003|6133799003|18002099003|11063799006|261009223027099003|10067099003|261021121427099003|56012099006|38070700021;
x-microsoft-antispam-message-info: oQ/2ctknBoiXAx/3bd3IfFajq269S6K1xlt9mIlKcrt1BLvyA4W/Wrt2zptnloz/gdRk39fYs//UM1HUSMX3JU7g3N8Yu9S/4e15QXjKWylOH2t2VeMSuh1DyjcI5GjwckD0TnYVlDQ4WtE04gKUVViYIU51d1En/9GzleY1ZkBuv70lP0U/Y/EtVtRiXXn8HhJ4AMG/lZsO4+hUyqfnaps890pELkwtWHx4RmkPCswGYDrtuRxzsBbo1IWp7BIRcJIZ5UKGTsfuj/hsXZZiPVZVJ5w8DyT3Sre3ugM3skHdmxnFOsW/XkAgmVMpt8+N9S8Kn/Oh/PzNytcBf3IRVlveIwLWMhAhiNmifOd3UDeQQe2AWJ7Dzo/MNvJciVoNIFn2Q8rdZwncA/aRN8oD6jyHwOh9tbyy0gvrCLkztrd6tAapF1eOjBxqWgVwWJ2Zos5NdSMsvP5nxMbvakO6vF5IrhBRmS7eD4t6fXV6USFUsO+WxBPw3G/jmIgPZujO10SN3aZC0dIifBxU2ZokZ1CjZV0vsKEGnkConKrKZmdMbWIBkJUurCAxLQKc3Io39ioaIonKHCjwz4ElFrf8mJk3kcJ36HTwtnzDtbYiMcHbX8Gcb3VqgzpIuylgMi7QV689d/zLuhCOki957fXKqaPjWZis2l0IRSBKj7qOqTx0SSE2T9cYnaL9UIek0TwlfOzzFiozAz9c+QOidGhFGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(55112099003)(6133799003)(18002099003)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGkzL2RpTC9SOGpRZ1lGTTZxR3ZNZDE0Y0lpRFJ4VFovUmxUUDRBYm9QTUpL?=
 =?utf-8?B?TDRaTWM2RFRZL1ZCZFV2Tk5OczhCRFljRncyNGQ2N1ZiL3ozNUJFWDFqWG9n?=
 =?utf-8?B?QVFTTUgxOGpVbWNVWGY3WTZhVk1uV0kySGh6L2RySHJ6dm5sZG50cHdUY0Ny?=
 =?utf-8?B?VW4xVGU4VUZpcFg1SWVsb1JhSUhqVy9hc0NMSDBrekNsU1FhTWxBQXlMUjIy?=
 =?utf-8?B?VWRybnJQdlhxSEkzdVdzOE56OGttNU1IK081eG8rTWhDNXcyNUQ4RSt0ZmJZ?=
 =?utf-8?B?ZFdXMlR1MVd6K2d6YVlpWERrQks3aERhSnVtRURUeDdRaG5yN2FmWmxLNnAv?=
 =?utf-8?B?NEhHbGRJUlRDemd5SnJyTEhVVWFCY2FaMXdsYzFiZnFQYUw5ZUp4S3hxTkE5?=
 =?utf-8?B?MUpTVGt5TDM0SUxPWlNFUmY0c2pIL2tHL1g0ak5VMHJqK20xdkhrYlYrSzFl?=
 =?utf-8?B?ZVBZZmFFL1BZYzBlU29SSlBoQW5oejZJSEhQY3oza0hDTmVuSVZsRExXNVBR?=
 =?utf-8?B?TkZEYlc3dkJwYkdWQlhEelRQVGczeG94bUNOL0trR2N3Nkt1VmF0SlBRek5a?=
 =?utf-8?B?SE1rNG5IM2p0ZlBRZjQ5Vk5saS82TGhtYjI0SG9aOHVJVzBZWXk5clJhWmRB?=
 =?utf-8?B?dEg1L2FWcnU5bzZJelVjTVdtNVZTTEp6dUMwM1hrUUVETzdyK0FhUzlQaDlQ?=
 =?utf-8?B?VTJIaWFIeXhVL3o0S3lJUnhnZ2xRRlE2WENWY1VLcmIvZFhIZ0Q4K2xOdWV1?=
 =?utf-8?B?TzVBVzdSaldZZUFlNEluK0YrM25UTy9iYmhYdE9WdHpKa3oyYkJHb0h3RmlY?=
 =?utf-8?B?Sy9kYTJpSGl0RFBmdnFNd1czek1PWVhPWlpEVkN1ekMzY1dDNndoS2R0dnVx?=
 =?utf-8?B?RW1UU3VJVUlJTERRcVhoYU9ZRWFnSG4vZXVYZVFucmhadkJtVTRTWUhwNWlD?=
 =?utf-8?B?c3Y5QUcxNGkrRUZXdUF4cU1kZnBpajB2RmZjdXpKaEJaYnpxWDJYWGRmc2dB?=
 =?utf-8?B?cm9oRnI1cWdtSjZoVGJjdlVNcWlhckxSTmJVY3dkd0p0QjJSQ2JtQ0FtM3pm?=
 =?utf-8?B?V2JwYkk5MzF5ZS9ZQkxHRHlVZGNKOENsRGhlZ2R5MjhtOFFXMWRVUmhiNkJO?=
 =?utf-8?B?MFZ6a1IzTVRsRmpmUDJMMmZlc3pEVmJYT0FPUUJLL2M4UlRrZjhGTWMwRDl4?=
 =?utf-8?B?Mkc1Uk9OUU5HQmJocWZPM2p2eG14YnRFdXZ6SGk1SEk0K0tTQ2VyWEJSY0NK?=
 =?utf-8?B?NmlsbE5oKytTckZaYWtibXRYVFJQdHlRalZTQUJGemFNK2FZOWtUbW1qbGUr?=
 =?utf-8?B?N3RETW5ZRmR5cTBhS0ZuaUY5NW9FR09jeTlpNW03TFBrN3p0Zk0rRjllM2xo?=
 =?utf-8?B?bEFwMVFMcGhESndXdjBRbzlQcTdLVWxFU25jLzJJc2NVK2tMczVTS29rODRK?=
 =?utf-8?B?am5GbGI0SVVYbVp2dGJyUkZPenJ4WkE1eDBDNTJLb1NEai91VURrRGJSR3ZX?=
 =?utf-8?B?VmRPV3JrSk5HUXV3ZXlQR1BkcEo1azFZUXRqcU5VYjJxbXkzeW9NektsSWhr?=
 =?utf-8?B?K0FQbmtxWnk1UFpsYmRWbHdLM0NoSWpnblZXSTJHbVFzWFZHVC83TVpYSkJu?=
 =?utf-8?B?Tks5ZHdNMjd1eEFDdzBWd1prUUtnVTNEbFJTOEJxbjJCaDNOUDNDZEZnTzhz?=
 =?utf-8?B?bXY1QUVVNnVHK1hzajhpRHB5SndlZFkyckF4Vms5emthUk9jUlllOStVbE5Z?=
 =?utf-8?B?b2dlUjFLeU44SDhQL2d1ZWtiN09HY0NxalpEK1ZzMGxtS2o2VHF1bkMrZjFL?=
 =?utf-8?B?cCtrbXl5d3FKV1FjeEp1SVM0VmE3SGsrM2pMSnV6TVRtRDVjcEFCMHUrU0JM?=
 =?utf-8?B?Z3Z6aWRZclQzNWJpaDFMQVk1OFIra21KZGxDcnFuUHBRZGEyNmcwRzZFM2VP?=
 =?utf-8?B?K1FqazFSY0dreWt2VWROcXdVMXlLOGlxbldKWndlVy8vL1phNWdjbTdJemdx?=
 =?utf-8?B?S1d5WW00andDLzl2OThLbzhmU1lxZFkrc2s5U1l4aXNGY0NZSy8vVnVaNEdp?=
 =?utf-8?B?Z2pScldOVkw4OGVXcG5IazYzSDA5VXdUYnAwRGphdVhxQVNuU1NDdVNvMkc1?=
 =?utf-8?B?dCtnVU9wLzhxV2orTHpVMTdrekNsZVVzTkhuK09CVzdBVUd5bm5rbGIvWWtR?=
 =?utf-8?B?S0tTODdSYXhSaUg2Z1dKVWhYTlJuZThDTUFnZkRGczJGY0Z2MWhqWnJZaXZq?=
 =?utf-8?B?Qk1lRU02TUlJT2FVYjNTcjlRWWNTYXpkaWNaTTJEcGE1RzVudzRRSnJ0WnRU?=
 =?utf-8?B?bWtmSjBtNThza0ZVMGFpMk5xWU5hanh3M0V4RlZpcDhsTmMzSzBwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19CD173EB133C5459D7285613B6E2C60@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7d0242-fb95-4e89-be01-08df30dd36c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 08:11:17.4339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXLQ6K3XaBp1lwPmhtHmXUiLZ7XDlisCEAL0VxgeV7ggvPlbj6fVUAE4v0hoD1W+7HSxthIbz8jE5WzRtWWgAZ6dQm7qcRfwxR6xg7cyF20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7702
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGksCgpJIGp1c3Qgbm90aWNlZCB0aGF0IHRoZSByZWZlcmVuY2UgY291bnRpbmcgaW4gbGliYmFi
ZWx0cmFjZTIgaXMgbm90CmF0b21pYyAtIGFuZCBieSB0aGF0IG5vdCB0aHJlYWQgc2FmZS4gQXMg
SSBjYW4ndCBrbm93IHdoZXJlIHJlZmVyZW5jZQpjb3VudGluZyBvbiBnbG9iYWwgb2JqZWN0cyAo
bGlrZSB0aGUgcGx1Z2luIG9yIGNvbXBvbmVudCBpbnN0YW5jZXMpIGlzCmRvbmUgaW50ZXJuYWxs
eSwgSSdtIGFzc3VtaW5nIEkgY2FuJ3QgZXhlY3V0ZSB0d28gKGluZGVwZW5kZW50KSBncmFwaHMK
aW4gcGFyYWxsZWwuIFNvbWUgcXVpY2sgdGVzdHMgd2l0aCB0c2FuIHNlZW0gdG8gY29uZmlybSBt
eSBhc3N1bXB0aW9uLgoKSXMgdGhlcmUgYW55IChkb2N1bWVudGVkKSB3YXkgdG8gcnVuIHR3byBn
cmFwaHMgaW4gcGFyYWxsZWw/IE9yIHNoYWxsCnRoZSB3aG9sZSBsaWJyYXJ5IGp1c3QgYmUgdXNl
ZCBiZWhpbmQgYSBnbG9iYWwgbXV0ZXg/CgpCZXN0IHJlZ2FyZHMsCkZlbGl4CgotLSAKU2llbWVu
cyBBRwpMaW51eCBFeHBlcnQgQ2VudGVyCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzCjg1
NzQ4IEdhcmNoaW5nLCBHZXJtYW55Cgo=
