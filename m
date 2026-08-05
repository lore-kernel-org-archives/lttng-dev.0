Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE550C55174
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Aug 2026 10:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hFRCW71nHz18g2
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1785925001;
	b=gpj/OHoY1kWlsDN8h8h/C8cLKmGKZ1+F+dJl4wZcuPBV61kbb3stnj8dYN2b1Az6gBl2
	 LjpGCQx+Tlx6oBh6oxe5ROHQ2YRXWKo/FQxzsuFuHE3VvJkUCvwMuTpWbqcGk436scLcl
	 rAlahXJ42V3IXG+EU5FArFqCSzQ+3oCfB3s1nFXSuk48zF4rMBeRQhJBelUJizKWbiqP4
	 AZgd3vQEYE80iMyH32CWbEh/gE+ntqMFEmA1uygFF9m67iDjX+0nktsgYdjEoUJDG2cpV
	 +iXVl38RXFJv8UCfyDf9yrue7tidO2h7NSewsD9WwcjGYUU0NPdXhKh9nYXtyB6oV2A==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1785925001;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=kgLUFvX2gO/2qi/q4yQ8cecioUIcMONzNPkBQh38q0E=;
	b=IGWVIRZ6Rqkvr/8k+wPTmL+Du2b/AZLUBCHrddFu5tKuqqhTBXsHMx5t/AXwSjaDexDM
	 Ej2iB8WtmELC8QbiJj335DxglbINqoiB6z2ASOeo5UeEoQcayol1SRb7klY89o0XZn6+U
	 LodAttd630EgP0VMLw4G5bQk+xJkg/SanqvmJO0xfxHm0qjO+GQnzHei1AKcAC6maBA4n
	 a/xODKcO1qAQLPSPm5URLuNh6S0cxx388VjVjYhyrIQMojXULJZ0HBs2E7p4cR5dKp5s8
	 ihVuWTpGPMHK6hg2RxXBWcNDimD+VdwTV/zBCPOaeTjAfo8V0cRzdRun9/38kn2Oufw==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hFRCW71nHz18g2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1785925001;
	bh=kgLUFvX2gO/2qi/q4yQ8cecioUIcMONzNPkBQh38q0E=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=XNyCXxmD64wpI/clYpesy/CY8MrWBt0sFBBxm462Ef3a/+a46ZhYGFuGV5JW7S8YQ
	 RBt7GG0ae7f5z8ihqxMXRmzvQOXdGvulz7zr4XmzNJ6XNT3QBITKbFj4coS4twk7f4
	 ix9Oqkne6ZydyVm7Uyjx0Qz8GoTG69Ec/ciqxHyig0OQu8NjIkRbdEqAgSRQi/wpNv
	 uiYMCxDS59cvumiZPjqPN/MEYDbDGbpPNVX5tR9YBaBkXQhSRqna3MRTKnXgQPcWsa
	 Onso7zi8oKKEeKgDNWvsasy7RNm9aXaQGJdZ1fNSqoMS1y//M7XI+AYfuqPQEZdIiG
	 ZAMrfKNOpGeGg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4hFRCW71nHz18g2;
	Wed,  5 Aug 2026 06:16:39 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4hFRCT05gVz18g1
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4hFRCT05gVz18g1
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4hFRCT05gVz18g1
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2026 06:16:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB3Y7IMFWIkr8nR3hpGlQij9mm++cCha7q7nahsj691MhuNBWLnGqx44Rmv1Mjd+p9XFokXgtsLbFs3YzzWUrxpcaEDHZBQt5CHS7yWp2W3SCjkZfMiJ7F8vzkywB3bysjqfh77rfC29jsSa1yUtr4A5WxrdHEiOwSsX59PwBTSnSOQEJ5Fl0/4yrU2fQsmqvmiYDf9Gbd5zp+vCEnZCgcN0S2nDA0ufE56W7U4n/NERFginwX7Pn8kpjGt1yc5gYShG3qGjK+A8WXS0SmEwIvAtBaMaMwCB6r4O0UBiQKT3BGajWnuXRVFgrPERx6KKg1cwNsJa5t4gN2GSq+ExLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgLUFvX2gO/2qi/q4yQ8cecioUIcMONzNPkBQh38q0E=;
 b=QTPsKDshoPF/ftvZwOPHa3wkYeCHa5/NcDqhnQLtYhA5mj3AENb5NWizkY7m6LFQvmy3o7HoU09CBMrCPs7odNfaGwrh4WscctjbLt+bUcdfj3kIxUXJIOEcFFfSEZYam/IO692aeD+E+b9PhtobwKu1QsztpZVSeJsFeC3VF7JZLTE0FcbweBC8sNnkQvwyKwLcWvTCMnAshAEeDdhS3J4oyk/VxB+edtHBnkfJXr53baTxUBQJ7z0rR91aJj/OOoW9q39DUeXw/rgyLZCOcsgJUd6/kArkma6Ax5bOYea/r7898uuJvxrRpBr2R94fBXsAWdOa9PtK3Q3GVK2ETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:16:33 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 10:16:33 +0000
To: "MOESSBAUER, Felix via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: babeltrace master: trace-compass is unable to open trace with index
Thread-Topic: babeltrace master: trace-compass is unable to open trace with
 index
Thread-Index: AQHdJMN9J+nDISDJA0e9fh1jxkhO2w==
Date: Wed, 5 Aug 2026 10:16:33 +0000
Message-ID: <5eed80a93b79f22f7c30a383f2a7b4d6f7068a97.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|AM9PR10MB4038:EE_
x-ms-office365-filtering-correlation-id: d0ee4e6e-660a-4a85-6a74-08def2daa02c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: Yf36j1Sm2Ye7bQ3sZPTGZv4mtRbxLALajF6syIANP57T8a7FGNTnbr6eSNUdnKfoUSrdX2oYRocLaQ+PBIy61tCagIGYbquWgxKM7fI9b7kX1TZORMz88NjGUbzKSKrkSDiGmYRoUFqqgb7eDCExHonCHlozsyWMnxYd6l9gidQHazMDIfHC+7Jf0yQ6rMRvLY7SvaxGZkDZJf5IyfKRcz1vfw/HFk/rZYYAnPytz29+o8UITaD0vVekpZCn72lE1wgJQ/vibDtLTThr4j4SAlD/qTJA7TRJsHL33uv7TZa0YxC7zVAABGhEYWgjNP2JDq89mgUecsbiJooj16/8dwSW0CXTXKfaGHrICro5D+7VLZ+iMHnRqCxbswoA2WslQay3dG+JSIh5D6rTDlwSzbEP2zOBmY5AlL5RQnUE4M2M4DC6YjM7SnEOS3ntUAwUMa4s5G3I9xRJ2YSmDUUedz1dSjOpZOWuGOezIOzdg2Wx/NmapJ+SWeCgiZxcOlVSMhnmdd6/V1B/FNfWliGOzAEAyJO845cqa835PrVF0I6EXVT8Uh0jIZ6bfzP9DRgJAM4/v2FQmTfhQ1uZxhsLFTR2ZH5MYoe74ka7puB9PazSDBwWVervUyOOkQtUaveTChj8NsixWRGli4FeQO+7/KgCidbbExqxlogbgdLP9AWRzTHoqW+1OxOt4RfwiPkdmQFFSF+S7jV96psYBB6u0GnlSCeCOBPzcHa4wt7gP5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NjVlFZK0Y4dnZIK0tmM2dLT29QakZHejVIRksyVG1Sck9tWVJETnMrd3U4?=
 =?utf-8?B?cmE3QWw2THZ6dlBySzdTQkg3a1RVY3RXM1dpVFRudjhYckVwZG9pczBoMTQ5?=
 =?utf-8?B?UGl6UVkzdjlBVkVuWm1WQVlCVUE3UE1GVzVOVzZjUjNqM3R5dXVxS01nTUY1?=
 =?utf-8?B?OUFCWDlxTlFqSmdsUHBuSlJDYXNpc1ZUNWlvV3g0UlkyUjRUZkVvc0VoT2gv?=
 =?utf-8?B?RkRBSS82TFREZHRWSnM1VlJLb1NlYTRZNUN5Qk94K3ZIL3FRZGNxdFdpdFdp?=
 =?utf-8?B?QVpzZEg0ZlJnQTdtWjMrYzUrVmtjNEJDakF1U0JoUzNjUGpsZG9UV3FsYWJL?=
 =?utf-8?B?Unk3anRhNWhZWVdXWFVURGhzYkdxN0R3SHVndW5DY3dTc3F3VlhTTjE4ZVZ0?=
 =?utf-8?B?NWlsaXBFYVB4QnNLVVY2NmlIWnFweGdBSjAyb3dIWTB3aE9tYUdWUkZqLzcy?=
 =?utf-8?B?MWpMUW16d0dva0t3NzZhMzZwZGh5N0VxM1JIMlRhYlFCVTQ3MDhSem03VytP?=
 =?utf-8?B?dDdNaERxbHJhKzhsNWNQZUZ0UEZSSHF0WnU2ZGJXUTkvR0owRmFRSW91bDRL?=
 =?utf-8?B?c1B3dmJYMUVpakMrdWNmcXgvRUZ0MFJaMEZPMUxpR1RPekF1VVZ1SjVOMFRS?=
 =?utf-8?B?TWp6U0NzaUplUml1SjM4dUYrcVgyZXkvKzJNQTBPTHRMQm5ydU9MTDZYSU9T?=
 =?utf-8?B?Z0xMZGYza1gzK043dVFYV0lkTm9DYjEyOHJlMDkwdmNadXdSU2c4MHRtSzMw?=
 =?utf-8?B?UURIRnBjbVRhTG5Hc1RqUlNiTS9mN3QxUzRtM1F5a29wVFByZi9wdGpYVENn?=
 =?utf-8?B?Z3BBMURCdmREbUtiU2crOXE2QTVWaHViWGFWRHhDYnZBZnVvYnc4UlpValJE?=
 =?utf-8?B?U2Z2K2x0cVA3bmsrM3RhNzRDTGczZFdHRjhiRnorUlNFeUQ0SGRlRnhFRnFP?=
 =?utf-8?B?dEpSNlA1S2Q4SnU1bkl4T04vNTNPczIramVPQ016ZWJRN29nUExiMnQwS210?=
 =?utf-8?B?RTY3b0lrNEF3REl4TEF0ZTRDc2hYcWNxaE5lWkM4RjJZYzVZUTk0N2k0aVV0?=
 =?utf-8?B?eDN3eFF4U29JMkRyWkpvZVB3WkhWNUI0eUZUK3R2Q3hONzVIY0taeGFPaldX?=
 =?utf-8?B?RXp5eUhsZjVvL1pWV1VSVXJFTjVYSktSbU9hbnVQMm4wZG5jMFF1NjJCUXpj?=
 =?utf-8?B?YWF0SDRXbjFWSTJvSE41Z1psWHBRVmF2RTlDYjdxVWxCRHRZdDh0VFpqdThJ?=
 =?utf-8?B?RS9qOE1qc3BMSnUyb0Q5dmlsSHl3Q25SdEE0MVptUXZHRkh2TEl0R0VwUUFE?=
 =?utf-8?B?WDE4SmNWbS9xeDQvdWhoOVA4TmNwd055OFBNWGloWGRIb1VuUnRQSXJOaTBM?=
 =?utf-8?B?ZnNLMXJWam1lemlXUkwremNvRHN3TXp5alVEaDhFT1JoTmIveEwzMlJmTTZl?=
 =?utf-8?B?aktmSUp2MURuSVNYRXZ6c0dzV3c2SG0zMmdSOGVhVGxaVmFJTnpLK3lSK1BX?=
 =?utf-8?B?ZEhpdlZzNjRCbVA4Zyt0RGh3R1NMM2pzdWphK0srQkhGd3pCdmFKbU9uaERv?=
 =?utf-8?B?UUppNnRCd1lZTzlyR0lJY0wyaFpCVGZnRFBGdWVoL2Jwa0ZBMWtoQmh6VVVN?=
 =?utf-8?B?dmV6Mm5ZTTcwWHp3cFNOR3piWUEvWFVsQnBvaTl1MEtnL1BYNU9ib1JGRFN1?=
 =?utf-8?B?elJYUVoxUk04OHB4YU5RSlQ4dEp5NnVQTjRTZkNXeS94UW1kOUNvdUJYY2Fr?=
 =?utf-8?B?cjFnMnZGWndsd0liSTRkNFVVQnJMd0VGU0szdlB1SEZhaXg2Z1ZPdFJ0ZzJx?=
 =?utf-8?B?eTVCWDFxK1VvcWdwMkdPeWFPaCtSL0hzeVhUNXMraGJQZW9Ob1paSDlzQXc0?=
 =?utf-8?B?YWNNSzhXaXhsWkdTeEVpcnRvL1F5bUxpMGpkeUVxcUp4UTVWL2h2STVOeFdh?=
 =?utf-8?B?eXJ2dE5BWTRtc3IwNGZUS3J6bUFVVnFFbmhINitiN2NXTjFialgrTjJmYjlW?=
 =?utf-8?B?NUgzTjJCRGMzVitnbjFIcVdISlp5UktYb1RaVnVqNTFVUUo0WlovU1N5MzFH?=
 =?utf-8?B?Ry9zUmYvV0x2SWpDWjZ0SFRvNUJqc1ZSbEhpQ2NjZVMxNVM4R01xaTdWOUQ4?=
 =?utf-8?B?Y2tIeDJvUEFGK29iNTZKM1NPbmtMZ0ltaDVxOXJ4d293SlNnQVlXWkxnblhw?=
 =?utf-8?B?NXZtV1RpVG1Hdmx5RTJmOTZ1aEEyTmRyMGlQZElaV3FqSXBzWks4a2Jwdmhw?=
 =?utf-8?B?RzYrT1lUV1lEd1NCWkdWTklPNHdXdHVPbXJNTnpoQ1psaTNuZlJqU0hsd2hI?=
 =?utf-8?B?Z2ZqeUR2bzI2bWU1TkJDcHdMSEFwQnlHVndrMXBtV3FqVWVVSGVRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5530CCA4C0B2FC4B88D35E43BD37ADF7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee4e6e-660a-4a85-6a74-08def2daa02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 10:16:33.6930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZG2XOfQfLn3a1/N1SGuoxYe8oenr5sokAjJBYvF5ALU/W+d/13lLOCMXVfok9HY9oXZaRgmi1p0R/Sqg44VW1qFFbWk3LIsDzhvXQN1T+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
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

SGksCgp0aGUgYmFiZWx0cmFjZSB2ZXJzaW9uIGZyb20gdGhlIG1hc3RlciBicmFuY2ggKDY1ZmI0
NjY5ZikgaXMgYWJsZSB0bwpjcmVhdGUgTFRUbmcgaW5kZXggZmlsZXMuIEhvd2V2ZXIsIHRoZXNl
IGluZGV4IGZpbGVzIHNlZW0gdG8gYmUKaW5jb21wYXRpYmxlIHdpdGggdHJhY2UtY29tcGFzcy4K
Ck9uIGxvYWRpbmcgc3VjaCBhIHRyYWNlLCB0cmFjZS1jb21wYXNzIChpbmN1YmF0b3IgdmVyc2lv
biwgMC4xOC4wLQoyMDI2MDcxMS0wNTU4LCBvciByZWxlYXNlIDEyLjAuMCkgaXNzdWVzIHRoZSBm
b2xsb3dpbmcgZXJyb3IgbWVzc2FnZToKCj4gRXJyb3IgaW5pdGlhbGl6aW5nIHRyYWNlLgo+IG9y
Zy5lY2xpcHNlLnRyYWNlY29tcGFzcy50bWYuY29yZS5leGNlcHRpb25zLlRtZlRyYWNlRXhjZXB0
aW9uOgo+IEZhaWxlZCB0byBhbGxvY2F0ZSBtYXBwZWQgYnl0ZSBidWZmZXIgYXQgMzYgb2Ygc2l6
ZSA0MTYgb24gYQo+IGZpbGUgb2Ygc2l6ZSAxNzYKCkkgZG91YmxlIGNoZWNrZWQgdGhlIHRyYWNl
cyB3aXRoIGJhYmVsdHJhY2UgYW5kCmh0dHBzOi8vZ2l0aHViLmNvbS9lZXBwL2phY3F1ZXNjdGYg
LCB3aGljaCBhcmUgYm90aCBhYmxlIHRvIHByb3Blcmx5CnJlYWQgdGhlIHRyYWNlcy4KCkZvciBy
ZXByb2R1Y2luZywgcnVuIHRoZQp0ZXN0cy9wbHVnaW5zL3NpbmsuY3RmLmZzL3Rlc3RfY3JlYXRl
X2x0dG5nX2luZGV4LnB5IHRlc3QgYW5kIG9wZW4gYW55Cm9mIHRoZSBnZW5lcmF0ZWQgQ1RGIGZp
bGVzIGluIHRyYWNlLWNvbXBhc3MuIEkgZXhwbGljaXRseSB0ZXN0ZWQgYW5kCnJlcHJvZHVjZWQg
aXQgd2l0aCAid2l0aC1wYWNrZXRzLWN0Zi0yIiBhbmQgIm5vLXBhY2tldHMtY3RmLTIiLgoKVGhl
IHRyYWNlcyBpdHNlbGYgYXJlIHZhbGlkLCB3aGljaCBjYW4gYmUgcHJvdmVkIGJ5IHJlbW92aW5n
IHRoZSBpbmRleApmaWxlIGFuZCBzdWNjZXNzZnVsbHkgcmUtb3BlbmluZyB0aGVtIGluIHRyYWNl
LWNvbXBhc3MuCgpQUzogSSdtIHByZXR0eSBzdXJlIHRoaXMgaXMgYSB0cmFjZS1jb21wYXNzIGJ1
ZywgYnV0IGFzIEknbSBub3QgYQptZW1iZXIgb2YgdGhlIHRyYWNlY29tcGFzcy1kZXYgTUwsIEkg
cmVwb3J0IGl0IGhlcmUuIEZlZWwgZnJlZSB0bwpmb3J3YXJkLgoKQmVzdCByZWdhcmRzLApGZWxp
eCBNb2Vzc2JhdWVyCgotLSAKU2llbWVucyBBRwpMaW51eCBFeHBlcnQgQ2VudGVyCkZyaWVkcmlj
aC1MdWR3aWctQmF1ZXItU3RyLiAzCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55Cgo=
