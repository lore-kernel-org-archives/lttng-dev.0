Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E670E77179
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Dec 2024 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733467723;
	bh=g9CeqF5B8EUu1mxah6mbHKBb3dZ0rVuOBRWeQaK3z1U=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=AXKSBJoRKe7leSeJ84tThoz54D6xa7VGsqtpxEortPzhjtvjFmmT2xDu93+JDalRb
	 na0tqWsef0On9GLtX53qClA/fvAMCRdQTWuHGDZ4glygYqqcK/Q6sr6a9XfnbOZEgC
	 6oYV9wMsKPfmNBjz8fnI2Ar46M5lzGhW2lHK5Lu6Pj+DJrIQ6dsLVnO+y9ZzJN/Ck2
	 KMAqatwtUtmnJOYoVgRSebb4EtgS10JAc9t5gbXcu1rVNbMNFOYUXxZrx67IDAnabB
	 6mr0n8QOUFqOPg1MiEybr6iHBswgJzvbAkzSGE2Q/DqemTnmDWGQ4lRvtoEtCLdCRm
	 SAseKQCHG3QPw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y4MKk69xcz16rR;
	Fri,  6 Dec 2024 01:48:42 -0500 (EST)
Received: from HK2PR02CU002.outbound.protection.outlook.com
 (mail-eastasiaazon11020105.outbound.protection.outlook.com [52.101.128.105])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y4MKh1cX8z16rP
 for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2024 01:48:40 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBOZs2kirSzzeHU1mIVvXjOZPjlNRL8TVWLcvBqmxdVdJFU0l4OIrNWC6wLRU2wsCESrcDymhpHbpo2GRuKK8u2L7NGMr7rUlf0eFvv5Bk8AnO2satlww6a6tSUg3OvwWtXP5/uM2XM87aXW80r5OR7gCtAD5WlAsrdF8EiLG27rPNXVIJ5vp8igSOKscllar47eGpQeZ3RnoAD1x6i19yWE76mIISu8fUJIjfM/QU3Jg3SlOzSZ/wNyhBOpso+nkzz7NYyfS9LH430CmcajDZ/veSsdVofP5RemL7nBVxBbXxjyzrc8j865uhSFhu+rtCO/0rN0SiiXWMx/mNq2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9CeqF5B8EUu1mxah6mbHKBb3dZ0rVuOBRWeQaK3z1U=;
 b=nEcmQ6+qThcuYWbjebS0cxbMIKMnQVy40bPLI+dxhhRcCPv7briTFAyJbnwKoFDUdx1j0zmpxenJ9zf0UTszFvQRoeGmYBqBEtQGlH6CcZh4L8F5XkPyvWiuigHXrncqqx+7HITq0SGEfvVhUmu1V0RF/qeEyX032gNsX9H9xQBrBY4gOHbYdsINyMcrtmTtQ2JJeSzu6gF2RxMGWKg4foaRLgqvHhCFJZyzokk+Zsxexbd0inYQuqcXVqDqMGIgNcCpFqjbftSrNsAJwfvYQy2S6FwkBb/zMHx24VYeW5MgW2Gy5DAI7VKNuD4M4KJL6Vq7KEgY0aOHC5G/qqVNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bc-s.com; dmarc=pass action=none header.from=bc-s.com;
 dkim=pass header.d=bc-s.com; arc=none
Received: from KL1PR0601MB3987.apcprd06.prod.outlook.com (2603:1096:820:2f::6)
 by SEZPR06MB5317.apcprd06.prod.outlook.com (2603:1096:101:7c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Fri, 6 Dec
 2024 06:48:35 +0000
Received: from KL1PR0601MB3987.apcprd06.prod.outlook.com
 ([fe80::8724:e9ca:8159:fcf8]) by KL1PR0601MB3987.apcprd06.prod.outlook.com
 ([fe80::8724:e9ca:8159:fcf8%6]) with mapi id 15.20.8251.007; Fri, 6 Dec 2024
 06:48:34 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: [babeltrace2] Integration with Wireshark
Thread-Topic: [babeltrace2] Integration with Wireshark
Thread-Index: AdtHqRAiOYXvEzIjQ+CJwHCh00nSVQ==
Date: Fri, 6 Dec 2024 06:48:34 +0000
Message-ID: <KL1PR0601MB3987E8EC377E357825D82546C2312@KL1PR0601MB3987.apcprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB3987:EE_|SEZPR06MB5317:EE_
x-ms-office365-filtering-correlation-id: dac7cef9-cd75-45a5-5df9-08dd15c20111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dTFxRlJDcmEvS0tMVWNmTVd6SWF2YTJ2ZzV4Uy8wNW93Tjh2ajZLdlJTK1Nv?=
 =?utf-8?B?c3A2a0FLc2c5V0RHSTVaeWtsUjV0VXM1SjV5c2YwZDJtYmhBSTdHUEpERG9T?=
 =?utf-8?B?WGxtM24vdjVJaFdndkorOW1pdFJNdlVzajNCZFpjZlUyYy91bmxVL1RTckJl?=
 =?utf-8?B?bXRFd1ZuRVZrYkRpVkwyWnNtdGZNVXVzOEg3NFpYbGY3RmxpOFI3cDVNOHFP?=
 =?utf-8?B?T3FLT1ZJbFZuaHpaQkJ3QVpYZlZvaWMyTTd3NE9ueVhpaEdPZWJ4RFJuUkNy?=
 =?utf-8?B?MGJPcTZjenU4UkNwZ1ZsMDlZYTN2eW1lMmUyUlVmSkVFREp1cjZkbGdHZUVp?=
 =?utf-8?B?ZDN2dkdTZk0xazVYK01JV3VSeFJMR1YxalFlWUNidlNpUUZJWDNzaHNOaFhk?=
 =?utf-8?B?dU01QUNTM0pZNDkvSHNnRHJSSkllN09YV2VINlVYT2VqZlR0b1JSNVhQcXlQ?=
 =?utf-8?B?a2Y4M1NrWmsyMXFwSXZGOFNvSGYxRjRoc09Bd25hYXBIbVc5Mit2Y3ZBWnhv?=
 =?utf-8?B?TTRtK04wa3RIVzJiUGNnMVlBVU5tSDJiVEppRVk1ZEZGTXFIU1dVcSs4b1lI?=
 =?utf-8?B?TTdqRHo2YnFuZEhyUHFaVW1kYkpjOG1vUkJWWHZGRkhPWlp1b0xxYytrMVpK?=
 =?utf-8?B?UlpnbForSWlUckxoQmJ0UllpS2ZqVFBCL2FVWFVieG1LdnZ1YUREOFBjeGoy?=
 =?utf-8?B?Njl1R2F3NldZRnFmYkNQWkgxR3ZnSXduWXFJa2VmK3BZQlhINEFVeDdSeHM2?=
 =?utf-8?B?cUZjMkd6QXdHRzI3Z1o4Qk14OGRsaURTd25GT1VxbTBMbUZNWEdtYUptakl4?=
 =?utf-8?B?bHR5V0w3OXBSSDhGZGJLdDBCblhPZlRwMitzRHR2SFBpWldTZ1l2YjgwbG92?=
 =?utf-8?B?Z2kySFBBcUtNbkNqWm4xeDlvSEJJNEpzc3V0UWJVMkNTcnVBZzg2RitmajdX?=
 =?utf-8?B?Yk9JRFNTMk9UUlJiOWN2cUJXNnhhSUlZZk5qY2J1UVNPTElaZ2JLMTViQ3Fn?=
 =?utf-8?B?V0FZdjVxYldVVEpEZ0NIRXdEODN5L2FaNEY1VVV6STFocy9ySURJdzFNVUFu?=
 =?utf-8?B?cmV6NEQxY1Y5d1J0R3dFSHJvOFFwSnRWSHJrNm51M3ptR0VBSXhCaStJdEtM?=
 =?utf-8?B?YXQ1ZEpodTJoY21qOWhubnlLaE15alJLTGZWRmh6cEs0THR2a0pRUnVGWWhC?=
 =?utf-8?B?MEYva1dxVW5JZkVkdzBTYmdTcm5sd3FCR0hlYUovajIxaUtFUEYya1BYamYz?=
 =?utf-8?B?RlZvNFdIZmw0cTJ4VlNWSGhjVHhIZ1pKM05lTTU3QjBHYkYxYzl5TS8wdzFh?=
 =?utf-8?B?MkYwd3ZnV0hiTlo2WWU2UVRBK1NiR1EwZFppOVdpblhkYnYzZGxCajlqSnBi?=
 =?utf-8?B?bGt3OWtEWHJRM1dSQURnVGx4OEhRYWdFTU1hNzFsQVhya2NqT0JPcnJmVVoy?=
 =?utf-8?B?UFRxTHM0YzlqeFd5MGsveXVacDdRN1RxQUtDMWNlVjJETGZVUkcrWnllVE51?=
 =?utf-8?B?cHFjWXBiOU5MKzdnUStNVTZjUXBzNlUrUG1BU1VqVXUxWENJaTdVRHJHN1RR?=
 =?utf-8?B?bXpDU1gwc3dEVUVONWZESUJ5RWNxVlE5M0t2OVhSMEFKSW42VnYvaUVSVTgr?=
 =?utf-8?B?RERMZlE1Y3BRT3hzaVhmVmdKRDJzN3FaMkFpUXR6Uld5UDJwaGVJc09iaTBx?=
 =?utf-8?B?UFJhZGRqclRXZE1MSDUzU1RDMXM2S3VKbVBHZXNHdmlNaGJDanQydm1QMndS?=
 =?utf-8?B?MjA1ZGhnWjRWNWorMGpxTHQ1Smo0S0xJY2p6bDl1TDd5ZkF1MXg2dURlL1VF?=
 =?utf-8?B?MHkzeDI5QVhaeENrcmk3UERSa2luK2w0bGtLS1g5MSs2aFFwTWY1RFVBNkRT?=
 =?utf-8?B?MTlVbExKNEdUNFFQSFpSREkyTlAweDN0b09oR1dUUEJrTWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB3987.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBNOUxrYXZrRUxBeTczWm9TTVc3R2Y2dnJHSUgzK3RCZzBMUUlIbjZEYUh2?=
 =?utf-8?B?NHFKMW8xWm5paktibGFxNnVPcy96ZHl3SzA3M1lsSW9zeW8zT0RrYXhxbnJh?=
 =?utf-8?B?TzVtd0lTZTJJTmcvSmZiWS9wT0lORzF0c0xFOG5WNURURkxjUHNkSEo3OUhn?=
 =?utf-8?B?cnVvanFhaVRzZXkzMUlrS0N1ZEk5ZnNIVVlNUC9SeFB0d2FJUVdEcUJKaFR1?=
 =?utf-8?B?STlNZUR0aElSN2xLY2pPSTZ1MlhaN2wxR3hCc09iUUhpRzIraVVMNFh1VDFz?=
 =?utf-8?B?UE9uNUF5dURaWDhQMmtNTVNTVkdXRUNhaEsreVJLYzE2L25PUGZtQkVCZjlX?=
 =?utf-8?B?Rk9KZ0hseWo0YUk3TGFld1lnbnV6ZHgxNUExZEFYQXZ4RWRBSEFnaDA4M1or?=
 =?utf-8?B?b1hXeXZ3TUc4YmVrK0ljck5HQ0xkQ1hncnBTR2t3aFFVM1BuOE9wN1piSWp6?=
 =?utf-8?B?NDZkaC9vdjZPSmF4MzcvT0loNy92Mng4Mm93NndOdDdKakJmWHEzQ3VyaCtx?=
 =?utf-8?B?K1FXMnpSK25QQjByZFFOTnhWNW5DbG83Vm1ZL202SzBoRjR6WWIxT3pOSzlo?=
 =?utf-8?B?SDZxUHl1cHJHaHFzc2FGRlU1Z2VLMndxSDVyeEI2WDhTQ2RzdG1ML1Q4TU9E?=
 =?utf-8?B?MThTQzI3bkw1UmhrS1FPTEd1dkJraUtDQUEwNGozUm5JSWxZRzhrN1FMM2hR?=
 =?utf-8?B?N2Iwa0ZIc0ZoYmdTSEFEMjhsRzFaYStrZkluTTRFdWRFWWtJZ3lKZUJCMG04?=
 =?utf-8?B?eEF6S0xONkNDWThNUFBTVFg2TGNpdExKUmdiYmx4UEsxSE9rTHFLWjcyMTRV?=
 =?utf-8?B?cThlRWtlYmVndmlZWkE1WU5QdjRsUEtRMFNWejdzQ0pUQTFpTFg3dncwcC9r?=
 =?utf-8?B?YURWYVN3MHBsTk5VM2ljSk5wQnJGaFJMQ2Vvd0NjNlQ4em5qMDZyOUZJbmU2?=
 =?utf-8?B?UUFyL3E2ZlVBNUlNYWdRSHBlOGwwalNvOFNmSDl5dWxNU09MZzFFd2VVdzJm?=
 =?utf-8?B?RTRZTzR4L3JLWFpuV25qZXBnVHVTMDZiWlZHaU5INEJZcEo2d3g5QnVFeXZL?=
 =?utf-8?B?Si9UeTM3L3lIKzRrQitTTnA5UjdicUVDbEkxSHZsSDZQaWtVQmlhZ3pGTE1P?=
 =?utf-8?B?RjZIYTdhMStXZ29OZ09BS0xWQ0FQZURjbmtPdWh2dXkwNCtGZng1bTVQcEdl?=
 =?utf-8?B?eDBWaWxZSU1QMGNieVFmZEV6ZlIvdmx3Q2VhQkVWdlc4NWNwb2p1YnNvNldw?=
 =?utf-8?B?eEgwTkx4QnZEcllMZlM3U3h3WnlwSERJc2l1UHZSNmd6Vk92U3Q5dDgwQ3Vz?=
 =?utf-8?B?NFJpWERKTmM2VmIvRnN0VHBsTVIzWDB2Ym5JWkFWQS9HUndya1RYbzEwQk5u?=
 =?utf-8?B?STRsK2pZTFl4WGxsc2tYZXpvSkxBUXFqM1hQTTh3NytwUEVRZWdwMG4veXZB?=
 =?utf-8?B?YUlKbkFlOE83a2ZHdGl0eDZVcjJhQ2xrZC9ZQ2pFVHI2eENYME8yYjZuY0x5?=
 =?utf-8?B?UzFxd3lqNmFDbVY4ZmhKQmxoNUIwcjR2TDFyTmNlanM0SnB3MmhnRnVqeGg1?=
 =?utf-8?B?Q05NZUpMVXNMMGV6N2tjdmhDQmVMRkYzRlRScFkzMUtEM1hrVVg1UE83aUJq?=
 =?utf-8?B?OHdvcDhZY1lFRmF4RXBnaFhPdFNIZTVYOUIzUnFSTjY3cTNhc2pvZy9rOUNS?=
 =?utf-8?B?UnhIMnJOTDE4RVpKT3Eza1QxSHAwTmJhZllvNHZ5bE5mL3lsUTZyR2hqYjlM?=
 =?utf-8?B?b2xybUdRRWFXL1pQbjVseTZvcmFSZkNxSjVJd01aS3VRbHhNQU5NRGV2NHEv?=
 =?utf-8?B?WGtreVZvNFY0VlZ1Yll5eTBaR1UrNlhZaDl2NlVOVXA3RXhJdFlIdzBHc2hP?=
 =?utf-8?B?RFlCclh1ZTlJZThjQmlUQms3NkhrTlBNWkZiUTVvdFV5c3owb1ZkaTc3a24w?=
 =?utf-8?B?WHdETDR1UkRrQjA4VVo5ZWJtZHAzLzJ3WGQzTFJTcmRKeGs5RHpRczdHN2E5?=
 =?utf-8?B?VHhCU3Z3NHpqQ0VRamliRUFBVi83aHFYY2pKYmptdDdvclRnVTEzVFlUWTFD?=
 =?utf-8?B?OUFXNTcvVHFubmF4Mm5ubFBHOWlOeFNrOHdCNW83UDJhVXVvVDh2RkNTaHJy?=
 =?utf-8?Q?s1iLcQEkjRB/qovFnkPUbad3M?=
Content-Type: multipart/alternative;
 boundary="_000_KL1PR0601MB3987E8EC377E357825D82546C2312KL1PR0601MB3987_"
MIME-Version: 1.0
X-OriginatorOrg: bc-s.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB3987.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac7cef9-cd75-45a5-5df9-08dd15c20111
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 06:48:34.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c81d1899-770c-4e1c-8e2e-65ecbb06024a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgheMeC3kanEsGTfcLgbW6sMn2kNEdQvnsaOjKXKpHsUB8d7+RVbpMxcOrFj8vON7Ibv8H24UQ8cKOOhk6VpBfwx9DHxhgB4RnozgQCD2Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5317
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
From: Gige Atanasoaie via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Gige Atanasoaie <Gige.Atanasoaie@bc-s.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_KL1PR0601MB3987E8EC377E357825D82546C2312KL1PR0601MB3987_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkZpcnN0LCBJ4oCZZCBsaWtlIHRvIHRoYW5rIHlvdSBmb3IgdGhlIENURiwgYmFyZWN0
ZiBhbmQgYmFiZWx0cmFjZTIgcHJvamVjdHMuDQoNCldl4oCZZCBsaWtlIHRvIHVzZSBDVEYgaW4g
b25lIG9mIG91ciBwcm9qZWN0cyAodHJhY2VzIGdlbmVyYXRlZCBieSBiYXJlY3RmIGFuZCBsdHRu
ZykuDQoNCldvbmRlcmluZyBpZiBzb21lb25lIHRyaWVkIHRvIGludGVncmF0ZSBsaWJiYWJlbHRy
YWNlMiBpbiBXaXJlc2hhcmsgcGx1Z2lucyAod2lyZXRhcCwgZXBhbiksIHRvIGdldCB0aGUgQ1RG
IHRyYWNlcyBkZWNvZGVkIHRvZ2V0aGVyIHdpdGggb3RoZXIgcGFja2V0IHR5cGVzIGJ5IFdpcmVz
aGFyay4NCklzIGFueSBwcm9qZWN0IG9mIHRoaXMgdHlwZSBrbm93biBieSBjb21tdW5pdHk/DQoN
ClRoYW5rIHlvdSBhbmQgYmVzdCByZWdhcmRzLA0KR2lnZQ0KDQpDb25maWRlbnRpYWxpdHk6IFRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIG5hbWVkIHJlY2lwaWVudCwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhl
IGNvbnRlbnRzIHRvIGFub3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBz
dG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLg0K

--_000_KL1PR0601MB3987E8EC377E357825D82546C2312KL1PR0601MB3987_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWws
IGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBjbTsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQt
ZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmOw0KCW1zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVT
O30NCnNwYW4uRW1haWxTdHlsZTE3DQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7
DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJY29sb3I6d2luZG93dGV4dDt9
DQouTXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LWZh
bWlseToiQ2FsaWJyaSIsc2Fucy1zZXJpZjsNCgltc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUzt9
DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7c2l6ZTo2MTIuMHB0IDc5Mi4wcHQ7DQoJbWFyZ2luOjcy
LjBwdCA3Mi4wcHQgNzIuMHB0IDcyLjBwdDt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29y
ZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFw
ZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZd
LS0+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+
DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3ht
bD48IVtlbmRpZl0tLT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9ImVuLURFIiBsaW5rPSIjMDU2M0Mx
IiB2bGluaz0iIzk1NEY3MiIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIj4NCjxkaXYgY2xh
c3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSw8bzpwPjwvbzpwPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+Rmlyc3QsIEnigJlkIGxpa2UgdG8gdGhhbmsgeW91IGZvciB0aGUgQ1RGLCBi
YXJlY3RmIGFuZCBiYWJlbHRyYWNlMiBwcm9qZWN0cy48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
V2XigJlkIGxpa2UgdG8gdXNlIENURiBpbiBvbmUgb2Ygb3VyIHByb2plY3RzICh0cmFjZXMgZ2Vu
ZXJhdGVkIGJ5IGJhcmVjdGYgYW5kIGx0dG5nKS48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+V29u
ZGVyaW5nIGlmIHNvbWVvbmUgdHJpZWQgdG8gaW50ZWdyYXRlIGxpYmJhYmVsdHJhY2UyIGluIFdp
cmVzaGFyayBwbHVnaW5zICh3aXJldGFwLCBlcGFuKSwgdG8gZ2V0IHRoZSBDVEYgdHJhY2VzIGRl
Y29kZWQgdG9nZXRoZXIgd2l0aCBvdGhlciBwYWNrZXQgdHlwZXMgYnkgV2lyZXNoYXJrLjxvOnA+
PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SXMgYW55IHByb2plY3Qgb2YgdGhpcyB0
eXBlIGtub3duIGJ5IGNvbW11bml0eT88bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhhbmsgeW91
IGFuZCBiZXN0IHJlZ2FyZHMsPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5H
aWdlPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpw
PjwvcD4NCjwvZGl2Pg0KQ29uZmlkZW50aWFsaXR5OiBUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBuYW1lZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbm90aGVyIHBl
cnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weQ0KIHRoZSBpbmZv
cm1hdGlvbiBpbiBhbnkgbWVkaXVtLg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_KL1PR0601MB3987E8EC377E357825D82546C2312KL1PR0601MB3987_--
