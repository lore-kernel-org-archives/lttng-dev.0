Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840C4C3DA6E
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Jan 2024 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1704732737;
	bh=w17cNEORGUaunBG1okxXxdoVCMEQuhDRe+yIoH+b+qs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=tN7+X0BDZSL7xqq0VzriXV2wuuFGNUDhl8qQ5ROqg25c4DxcoAc+upCkfqBQA1VJk
	 ZA75kQyIuWxdVv8lXoJNXBuIPjP+S/b1TEwX9LrUHBF9ScwSL6gLyaHXjNTHonAVeJ
	 VNCFvO/iOGBL0OUjuu4FhGX6IpZKhTLeSgrXv6LBZILXJbnoDmj3XYLd4JRqCmaF8z
	 6thoD9gnlRrtNuk6XLzWQmm5fyuDNIbxyh8QD1su/STGU4XYuBiSxyN1QF2F50i01B
	 JzCskiZRPFe2Q8cpI8nL7otv7c7Q6XSQCMas9D8L+xKQ9K3edK9+1utzBVVAqGqg2n
	 8VdDbkLaJ3zMg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4T80Tr6jfjz1H8X;
	Mon,  8 Jan 2024 11:52:16 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2081.outbound.protection.outlook.com [40.107.116.81])
 by lists.lttng.org (Postfix) with ESMTPS id 4T80Tq0K9Zz1H8V
 for <lttng-dev@lists.lttng.org>; Mon,  8 Jan 2024 11:52:14 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNDIu/2RupFbucTu2jWGquI5WMaE6Rh90fsBU8C8ucMgYd19/BJ+bVqDq7+tMcabhLKlj9xp9lxMi1GHQkkWT573sRXUD41SZZBYOBVMAqW+EosrnIynLbmDf3KY6TGAQapO5eqpCgFBvoJjzl6r80KHZlhb25jZ1y5uIbLr68vI7EN3qeNTUHN1uq7X6PJ/Gwy/SdGe8hIrRLyP2I+peADLHC1ogOazx059mKc+9pYeYii5gS1glne7gYzyj2nipXo83BAMiHJi7jrOMeo2f+DjRpNQWy++0YMsiHUYYUGHOJQJqVGS5z6ve5u8yLgtUz6Zy2og4RTiPMK+i7nSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp6gl8QpSNK8AVlT5WWeu/GDHmHR8Uuf7OVh79a9YPU=;
 b=lL6DlxloTl78ub6u9V1xoi3BMDaet3VI5lpJZhS81Cz+cZC5ZEoekniaEo4mS4SA/IRZcrEt/82Hg7RgBKE9dMw1xykgjNgjcLW/N3XKRbKaTVOpPlv6bCQxJ7QEclod/59dBJDUxS5eKAn1rooscxpaXAKXlMIb0aC2Lg3NkC1laKldXGQK4e3CNTP7Y/meHBAjCPHWnST2LBOWjMRH5zK7L9CC5q7zpFYweBAGBOTnIzGFXsVgSMfaWByVsdR/Uii/2Li0BG4wzcUgK1f0t35jB/+O01gVRskwWsU6en+39+/xW/a0H/Nsr5GXyxXfh6pRhL+zv2XuBcXncQ7RZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQBPR0101MB6650.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:49::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 16:52:12 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5d8a:713:bb2d:31ed]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5d8a:713:bb2d:31ed%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:52:12 +0000
Message-ID: <0b43d97b-2b22-4cdc-8044-4b1ccc315a65@efficios.com>
Date: Mon, 8 Jan 2024 11:52:11 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <MW3PR12MB4555207ADC0ECAF8DA3EFF74D998A@MW3PR12MB4555.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4555207ADC0ECAF8DA3EFF74D998A@MW3PR12MB4555.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::6) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQBPR0101MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f1dab0-86ad-412b-eeac-08dc106a2966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMvpHAPEXe+4L4fRVhfg1wRZKcF4AD5BAQopkmIvUMheSplaEAVm4S9K/wOre+mMQzAsggSF1vpipjdcBWZR1iisw+yZNeBy7BBNy+c63ik5jw9wVa+jXsb82wo0D2aWxL6rbcaRN9fsjClcU+oQW+oDW3pOX649AgH0y05DJ8a86Q3Ps+MHTAMXfHtyBxeq/Zy1HnPIndoPKiQMq27y3NEEKkXqWV7vJIR+VWQPcFVfyiMjlQsKx3znWjps3v/WCRnSszHrOc+/RovmAAjOsjPaqWH1NgQ4726MV3RWqO3WjqlotPY9xvrwPrvPNWeL1LEwN2CIlzmzc4aBpP11/fXwLS77/E5lLAkpQHvdV3D7g++lwj9nde7M4h5Ap173Fxw2b5uctBKTJ5OIor1Lqo2Wn718jroiqdhnCbpH7H4dka9fLS+/oqryn1CfSMtAL9O4udcvi5eOswESatu7PHI/CpG8W/7F/BgHh2zx/iZ5ds0bKGnhZooe/+H66takesbVmKtJu1C3Qf70xhWQad1iJxtJtwpSFhMJNMhHZrGVqhHqEj6JiJCxtmgk2RD3kHm/1tpKBm2Zq5D8/Ugzr63EclwG0aa8umWaxTttB6tq0OB+GtzlA+fYkdQ8WyeRA6K74YOcxRKtPCBo9KETSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39830400003)(346002)(366004)(396003)(136003)(84040400005)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(31686004)(8936002)(8676002)(36756003)(31696002)(6506007)(83380400001)(53546011)(66946007)(66556008)(2616005)(6512007)(6486002)(478600001)(26005)(66476007)(6916009)(4001150100001)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am12eWtLNWMzcmdwdmFCMFNRNGJ5UWsrL1VneUdNRjFQVWxzWXA0ejhHRmZM?=
 =?utf-8?B?V0NuOUw1MG1oVm1hSUtNVXFobDlTNS8yL056S0RaOXVmMmIwSGhqZnRSYnpm?=
 =?utf-8?B?M3paMDZsaG5JcThEbUtFaHhGQ3g3NVNsZVdUODZQc2RMdzByRmVLTW53VDM2?=
 =?utf-8?B?bjI4WDRxYjRBY0FnNTV1MWRURGdDVy9sZWF1VFJFL0FWUEc1YkZOSlc2dGhu?=
 =?utf-8?B?T0FqR2xlRDdOVW9uaUhUY3hqemV0OGxJTHZKMDRyZFUwUW93dFd3em1jc3F6?=
 =?utf-8?B?VGVNTHhkMzlxNXBaTUlYUFErR0tFNVpQZ2Z6NlNzdXFseGY4emRmWHZSeTU2?=
 =?utf-8?B?WHNUcDQ3MUI3ajJWRWhibHFkUXc1c1BMSWs2V0QzYjUvazR6YVVZT1JUOTVP?=
 =?utf-8?B?dTFLN3o4eVNNZ2pJRFpnZ3V1alBISE9aeUJsY0VTTUlZWW9zdFlObjlVS2Qr?=
 =?utf-8?B?akRMVmI0bFpRTW5nYTFxNUhDWmswUlJaSWFSdTFqSjJ0ZDB2bE84SzYzZDRi?=
 =?utf-8?B?REk5dGpPd3VDVWJWNnFqSzZuK0cwOFM1ZThFR0dPK21jQ1REcSt2SjBsZW44?=
 =?utf-8?B?Vy85Y2I2QlZvYkRDcVhMblhSTFg5OE1KbWdhSW9HMVpWQzJxbEQwZnR0bUU3?=
 =?utf-8?B?UXFIRFBjN1NRYU85YlM5WXpxalMycEZjdFRhWmlDek1RZ0Z6VTltUUtBeG9y?=
 =?utf-8?B?WmVDRkljcU1KdHRlREpvamMzOVNFbjhhNE04VkJBMC8zSVB5VGl0RTZxUm8r?=
 =?utf-8?B?aFpXSUxCRzg0SXE2Z21zdzFWcnRHeFkzV0VUMmtkN29nckNXamp5L2xPcnBo?=
 =?utf-8?B?SmlPYjR0Z1NQSFJKNklPeVU3ZkhtZW8rYWpRb0pzc3Z1T3Y1V2MxU29zbXVG?=
 =?utf-8?B?N2M5QlBvUjdNS1NpRW9jdythcWlFRWhHTmdYcWp5SFV2REhHbDlKbXdtZHpO?=
 =?utf-8?B?LzdXZVVDQitETjBaNVpZeTFqNG5BeFRVdXM5eDF6T2VDall0RHNreUF4Qk9Q?=
 =?utf-8?B?dkdXaFR1ViswTmwrTUFma2RyTFQxT0VSaCtUdnRpNlpYMmJvV0RQT1RWRkV4?=
 =?utf-8?B?Ly9FVWtSeXNRVDNJSTR0VUc5d0lEVTEwM1JQbWVrZkU4S3JBR0tTdHVRaERM?=
 =?utf-8?B?T2Q3ZFdEcXloaEVydHRQQWp2eCtNTXpYaHdZS3VWcDU3NVI4dURncTMwejdM?=
 =?utf-8?B?anJSeGJRY3FPVkIyeGFOanVYMHozUzdQd2NHcWNIZjJMQkFWR3ZZTi9NN1pv?=
 =?utf-8?B?WUtKcnVNQnBkcGFEZExZb2UzT0ZMUklKNXdGZWZmalpUTDcvS3JOQngrSGJr?=
 =?utf-8?B?SjhSajhqTy85dU5uS0xyWnU0cCtVYVphdk9nNW5QRjR2N3A1MXdBWXhma3Ru?=
 =?utf-8?B?NGtqdTJJMFRJcnNxdndPUG5vbDEwR0JDQm4xOTZBa3ZLWWtyZ1RWb3BURitw?=
 =?utf-8?B?NHQvOW1lNzJXSHZVQmtJRTJLZ0pURW5uN1ZjR2JqdzlrZEVXTUZkdGJvd1Ju?=
 =?utf-8?B?WFgvRUtmeFZNdkZad3F3a0l0NzJRaVlWb2hUdllxYjE1Rll2UW9nS1RGeVow?=
 =?utf-8?B?WCttTHlqMDlLNEQ2dHBrbSt2ZktnYTJCYi9RYmV1d0F4dHdiWFJDdXRNVUkv?=
 =?utf-8?B?MS92VGdBVnlqZmVjdncyaWdRRitVMHltT1lNYWxzYWQxME1VV2l0cEJPWFkz?=
 =?utf-8?B?Rkd0anN0eWI3WDFRQTI1aTdmSFNCS3JHajBWb3Y0N3FtQ2JRNHpkSlVsdGxM?=
 =?utf-8?B?UTIzciswOTgwNnFNc3pFWHp0R3NFNjhQZ2JBRWd1UWFiditEU2tYeUNzQUgr?=
 =?utf-8?B?TmxmNHEremJqTzArTzFTU1BFZTEvSnVJeXh5UCtkOU0xSG9mTDgrZEErS05T?=
 =?utf-8?B?L2ZKVFZYQzJRV2RCdkFWSWFqTm9EVjYwM0NnNjFzRWs2MzZiUTUveVZqTWkv?=
 =?utf-8?B?dnkvZjRvQWZDV0F1a1lEMEM2STkrNnR4NG1GNG1Wb0wySkJ2N21OZWVFTXgw?=
 =?utf-8?B?NXNpVnZKSTBWNkludHBDUW02ZVgrRXBmb1F4RTFZVFc0TDVQYzdRam54YmNz?=
 =?utf-8?B?bzNmeGtXR3VvN1M0alNYYnFINjZKRjNsekdYZkNVb1VZSEgwa05MOE1QN204?=
 =?utf-8?B?Snp5VVJ3Q0tHVW5Za25JV3NyQlhMMENUcldwMnFTN3pnWkNVSWd5YW5kVVZp?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f1dab0-86ad-412b-eeac-08dc106a2966
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:52:12.8187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xvsa7zn5Yhtjtw/x3DsMwO9ZxD02w1P6pSFjpnHrZN+zD6amLjsK6g+/xrcMOoVnp/xepkcFptGxguBfOORHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6650
Subject: Re: [lttng-dev] Python lttngust module import error
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0xMi0yNiAxMToxOSwgTGFrc2htaSBEZXZlcmtvbmRhIHZpYSBsdHRuZy1kZXYgd3Jv
dGU6Cj4gSGksCj4gCj4gSSdtIG9ic2VydmluZyBhbiBpc3N1ZSByZWNlbnRseSB3cnQgaW1wb3J0
IG9mIHB5dGhvbjMgbHR0bmcgbW9kdWxlLgo+IEZvbGxvd2luZyBpcyB0aGUgZXJyb3IgYW5kIG5l
ZWQgeW91ciBoZWxwIHRvIGZpbmQgb3V0IHdoYXQgaXMgd3JvbmcuCj4gCj4+Pj4gaW1wb3J0IGx0
dG5ndXN0Cj4gRXhjZXB0aW9uIGluIHRocmVhZCBzeXN0ZW06Cj4gVHJhY2ViYWNrIChtb3N0IHJl
Y2VudCBjYWxsIGxhc3QpOgo+ICDCoCBGaWxlICIvdXNyL2xpYi9weXRob24zLjcvdGhyZWFkaW5n
LnB5IiwgbGluZSA5MTcsIGluIF9ib290c3RyYXBfaW5uZXIKPiAgwqAgwqAgc2VsZi5ydW4oKQo+
ICDCoCBGaWxlICIvdXNyL2xpYi9weXRob24zLjcvdGhyZWFkaW5nLnB5IiwgbGluZSA4NjUsIGlu
IHJ1bgo+ICDCoCDCoCBzZWxmLl90YXJnZXQoKnNlbGYuX2FyZ3MsICoqc2VsZi5fa3dhcmdzKQo+
ICDCoCBGaWxlICIvdXNyL2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9sdHRuZ3Vz
dC9hZ2VudC5weSIsIGxpbmUgMjkxLCAKPiBpbiBfY2xpZW50X3RocmVhZF90YXJnZXQKPiAgwqAg
wqAgY2xpZW50ID0gX1RjcENsaWVudChuYW1lLCBfU0VTU0lPTkRfSE9TVCwgcG9ydCwgcmVnX3F1
ZXVlKQo+ICDCoCBGaWxlICIvdXNyL2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9s
dHRuZ3VzdC9hZ2VudC5weSIsIGxpbmUgNzYsIAo+IGluIF9faW5pdF9fCj4gIMKgIMKgIHJhaXNl
IGUKPiAgwqAgRmlsZSAiL3Vzci9sb2NhbC9saWIvcHl0aG9uMy43L2Rpc3QtcGFja2FnZXMvbHR0
bmd1c3QvYWdlbnQucHkiLCBsaW5lIDczLCAKPiBpbiBfX2luaXRfXwo+ICDCoCDCoCBzZWxmLl9s
b2dfaGFuZGxlciA9IGx0dG5ndXN0LmxvZ2hhbmRsZXIuX0hhbmRsZXIoKQo+ICDCoCBGaWxlICIv
dXNyL2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdlcy9sdHRuZ3VzdC9sb2doYW5kbGVy
LnB5IiwgbGluZSAKPiAzMiwgaW4gX19pbml0X18KPiAgwqAgwqAgc2VsZi5hZ2VudF9saWIgPSBj
dHlwZXMuY2RsbC5Mb2FkTGlicmFyeShfSGFuZGxlci5fTElCX05BTUUpCj4gIMKgIEZpbGUgIi91
c3IvbGliL3B5dGhvbjMuNy9jdHlwZXMvX19pbml0X18ucHkiLCBsaW5lIDQzNCwgaW4gTG9hZExp
YnJhcnkKPiAgwqAgwqAgcmV0dXJuIHNlbGYuX2RsbHR5cGUobmFtZSkKPiAgwqAgRmlsZSAiL3Vz
ci9saWIvcHl0aG9uMy43L2N0eXBlcy9fX2luaXRfXy5weSIsIGxpbmUgMzU2LCBpbiBfX2luaXRf
Xwo+ICDCoCDCoCBzZWxmLl9oYW5kbGUgPSBfZGxvcGVuKHNlbGYuX25hbWUsIG1vZGUpCj4gKk9T
RXJyb3I6IGxpYmx0dG5nLXVzdC1weXRob24tYWdlbnQuc286IGNhbm5vdCBvcGVuIHNoYXJlZCBv
YmplY3QgZmlsZTogTm8gCj4gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSoKPiAKPiAKPj4+Pgo+IAo+
IEkgaGF2ZSBpbnN0YWxsZWQgKmxpYmx0dG5nLXVzdC1weXRob24tYWdlbnQuc28qCj4gKgo+ICoK
PiAvIyBsZGNvbmZpZyAtcCB8IGdyZXAgbGlibHR0bmcKPiDigILigILigILigILigILigIJsaWJs
dHRuZy11c3Quc28uMCAobGliYzYseDg2LTY0KSA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGli
bHR0bmctdXN0LnNvLjAKPiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtdHJhY2Vwb2lu
dC5zby4wIChsaWJjNix4ODYtNjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRu
Zy11c3QtdHJhY2Vwb2ludC5zby4wCj4g4oCC4oCC4oCC4oCC4oCC4oCCKmxpYmx0dG5nLXVzdC1w
eXRob24tYWdlbnQuc28uMCAobGliYzYseDg2LTY0KSA9PiAKPiAvbGliL3g4Nl82NC1saW51eC1n
bnUvbGlibHR0bmctdXN0LXB5dGhvbi1hZ2VudC5zby4wKgo+IOKAguKAguKAguKAguKAguKAgmxp
Ymx0dG5nLXVzdC1wdGhyZWFkLXdyYXBwZXIuc28uMCAobGliYzYseDg2LTY0KSA9PiAKPiAvbGli
L3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LXB0aHJlYWQtd3JhcHBlci5zby4wCj4g4oCC
4oCC4oCC4oCC4oCC4oCCbGlibHR0bmctdXN0LWxpYmMtd3JhcHBlci5zby4wIChsaWJjNix4ODYt
NjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3QtbGliYy13cmFwcGVy
LnNvLjAKPiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtZm9yay5zby4wIChsaWJjNix4
ODYtNjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3QtZm9yay5zby4w
Cj4g4oCC4oCC4oCC4oCC4oCC4oCCbGlibHR0bmctdXN0LWZkLnNvLjAgKGxpYmM2LHg4Ni02NCkg
PT4gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC1mZC5zby4wCj4g4oCC4oCC
4oCC4oCC4oCC4oCCbGlibHR0bmctdXN0LWRsLnNvLjAgKGxpYmM2LHg4Ni02NCkgPT4gCj4gL2xp
Yi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC1kbC5zby4wCj4g4oCC4oCC4oCC4oCC4oCC
4oCCbGlibHR0bmctdXN0LWN5Zy1wcm9maWxlLnNvLjAgKGxpYmM2LHg4Ni02NCkgPT4gCj4gL2xp
Yi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC1jeWctcHJvZmlsZS5zby4wCj4g4oCC4oCC
4oCC4oCC4oCC4oCCbGlibHR0bmctdXN0LWN5Zy1wcm9maWxlLWZhc3Quc28uMCAobGliYzYseDg2
LTY0KSA9PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LWN5Zy1wcm9maWxl
LWZhc3Quc28uMAo+IOKAguKAguKAguKAguKAguKAgmxpYmx0dG5nLXVzdC1jdGwuc28uNCAobGli
YzYseDg2LTY0KSA9PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LWN0bC5z
by40Cj4g4oCC4oCC4oCC4oCC4oCC4oCCbGlibHR0bmctY3RsLnNvLjAgKGxpYmM2LHg4Ni02NCkg
PT4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLWN0bC5zby4wCj4gCj4gCj4gUmVnYXJk
cywKPiBMYWtzaG1pCgpIaSwKCllvdSBtaWdodCBiZSBtaXNzaW5nIHRoZSB1bnZlcnNpb25uZWQg
c3ltbGluayBmcm9tICcuc28nIHRvICcuc28uMCcsIGxpa2Ugc286CgogICBsaWJsdHRuZy11c3Qt
cHl0aG9uLWFnZW50LnNvIC0+IGxpYmx0dG5nLXVzdC1weXRob24tYWdlbnQuc28uMAoKQ2hlZXJz
LAoKTWljaGFlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
