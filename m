Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A58C7619A
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Apr 2023 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1681324197;
	bh=470Nxabsr9PwLZCCJXQ+BFyL6DW2pgqBM1rn5UpIHpk=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pBVYd3BWefeTVwExJ1BH+ZJm+hBoRI/k75r9DYl3vAPlCHckDy+uBUFOjj5NyIUWV
	 94h+6b8lZjKH9CV9Zx7CEYBFOG4L90L7aMUCg4jxdh/5Dt1LXIg5MmdUIbphmC7yMQ
	 GDQ5BoWnci4y+NrNdcdOaj5ff+JA2nrKKBqkHBQE2SHl8IFLqBxVE7mOMEKug0cMG8
	 Jog6BApyqml8PMHB6QRoDyAcDJDjt2Xcdoa+L2qsZQ433a5fCXB7WQ8SAvHwTC50QM
	 1KoRwtEyxIYIAgAxGbonAMpcalrKwCe74rCOsQI8v/0R4Ew60XYipdwS2yCvvSnmXp
	 9b5Ae8P+2CFGw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PxWTc5tgrz2QCb;
	Wed, 12 Apr 2023 14:29:56 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2069.outbound.protection.outlook.com [40.107.116.69])
 by lists.lttng.org (Postfix) with ESMTPS id 4PxWTb1pWbz2QCY
 for <lttng-dev@lists.lttng.org>; Wed, 12 Apr 2023 14:29:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBqMdy5UswVKBAdL5lEjifa0HmcNLEc8VDo0uzBk9Z9Oi5Dt/b+cKnQfo2Fzk+g1i1QC4No/tPseMy+eFIl1+UffkpqY1aG7Pf7KoWlFUkTOq/37eWVUpp3W7rbGFEDADRe3QlXuTjXMCwviQ6E5NRr0CUmJas6//3RaTx3axo4kxYPyQmGSYHfFHvK+4+z6nox2fpXkZM41Fo/EVpTib7NkAjD2BDIZfhgP7YyTd9gkjEl7ilkhJ0IIoktvRLCeD5Ts4nKZ6s00QWB7iF1gNu1IXyUueicZ3GM3kRDK9LmCOmifB8ZRp5XU3lhZm/zSfZKByPnZuBVlc8T2A6j81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtzmFPN2U65k9BR8HREwkg4xvEN7HBwjBdzZ7jfGUhE=;
 b=Wjtd1KKfLhyA1w6xIKwjw1URq8g2rcR9UQl9jiwJ9g4Tzn40XpzgZOFV0i9g7B2j9EgaqEFTchgf/5C6hjJNdbWM0cNYPQPUp+aCSRijZKtOnFJtlJ+yyDVtwt6fVrlK1pkCiOTUIcdH4waXBOkv/wfVLLsWgq7Wk9RgmHYBRWWXM02SjfIY+pqftF8ivr7GY846qc6g9JDdew5JJhl4wNLMwi8+t+xk2+SDHzBI/AadXcBdy2dCczQcV9dZjyj8xQQjTgYDyFEFhD1waIDkgnaDJuDsbx9dVd6Cb0yLAEjfQdYTSNeRRXIx0s9pJBBW8b+PMJO+WodEWanOR2LyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1b::15)
 by YQBPR0101MB6304.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:39::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 18:29:40 +0000
Received: from YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1baf:e5b3:e2df:5ddc]) by YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1baf:e5b3:e2df:5ddc%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 18:29:40 +0000
Message-ID: <8c167748-42bd-9959-0e33-03bc24e22f95@efficios.com>
Date: Wed, 12 Apr 2023 14:29:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Benjamin Saint-Cyr <benjamin.saint-cyr@polymtl.ca>
References: <20230406195630.Horde.jhBZfsMqxFud8S3napU7CjJ@www.imp.polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
In-Reply-To: <20230406195630.Horde.jhBZfsMqxFud8S3napU7CjJ@www.imp.polymtl.ca>
X-ClientProxiedBy: YQXP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::25) To YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB5082:EE_|YQBPR0101MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6387813c-d979-447b-c00a-08db3b83e0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +39OIWDXNyClvJQbHUQ/iNfnkA+Pn7lpduwzEML06QUzuyXwrEg1UYAckfJWZRt9YqAeqcGNFKBeW0V8a6pnjhQ1wjmrueGhCgOKZjXZxiOGcv1fmNEXC7CCtI5OD2z0a4tSetaKA6HZUbBn9dAKUqhJKyTg1Ya3PH7B9lV9c2VqIC2LsGz30Kb/5rGQyv9fv+OoZvJJqIEJ5wmIJDnF2u4SObMpqWjEJpgWLTYmuBuvX3PwlNBtP1Vw0+CHOROY9e9J4VCWLwwdjf1i2xI28Kgl2E57QJlZDG8pdJCiQDJNPaYBL/roOA5bozgjO03niLVCi4XgAlFT/mAnbLXwkK2YkxpMxZI3zRiJAqmf7v3vL9sTFK51rnuSQ3fk7sAZkGjb3o0g2PW8USSx4vltvLyHL1UcO0uMZ5QT/tFxZrVWQkGpg5PnPLre92rqRj1lj2Qgc9azcwejksnxuaCXtY3XhdbrAo7MmULnmIYpkKw9ZuRWCGzDMLN6thOZ1/7kygRMGnZAsLlGDcqDeLSEKKzUAwdaL3Wjky1SavnJrklw5xcVMNJd6WJGlWJOoaXQKze9GrU5C6jHBebLnJpqRzRQvHOIdhDYrIDXitPWZGu2/dveXtqTuRbsDf4IpivUg6NlyRBkPdMrYO5aiRSwmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39830400003)(136003)(366004)(346002)(396003)(451199021)(2616005)(83380400001)(41300700001)(5660300002)(2906002)(31686004)(38100700002)(8936002)(8676002)(186003)(53546011)(6506007)(6512007)(26005)(6486002)(36756003)(66476007)(4326008)(66556008)(6916009)(86362001)(66946007)(31696002)(316002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpiR3l5cm5ha2ppMFhoamFhSWp5Q0EvV2lkSE0rRjJESHZ3YXdYSmpLNkxS?=
 =?utf-8?B?TERucXRkNHI2Uk9nL25FTExOZ0kxSkRyNko0MW9IY1UyWHBKaUxOUnN0Ykpy?=
 =?utf-8?B?emdWU1VncmlhYjNsc1Z6L3d5WnR5VTQzUXR3TlFFY1hWQ21wemJVTG1adzFN?=
 =?utf-8?B?SkpiR3VMdnRiNVNEcDI1UHJNZzJpUytQQTF0N2RCWXgzb2kwU1FUa1duZVp2?=
 =?utf-8?B?WXlaNytHczFyeVQwOTBiK0lzNi9oYU5LMk1OK2tINGt2NW45VDVTTUZzenN6?=
 =?utf-8?B?QlBMNXA2c2loQUFxdWdQbkNnci9sZDI1OHdWSmY5T3hWZ2F1bkRxMGNZZldr?=
 =?utf-8?B?TW5kZ2FmTmFUUnBSNWg3WTlDb3ZRc0V2Y2svKzhIYWdlNHV5bEdPUWRKMjRo?=
 =?utf-8?B?VVJTSzZjUmdHTlNHRlNhUGxNRk0yWjVwSlVINEp0VTNrMFY1ZFhULzB6dmNK?=
 =?utf-8?B?R3QwTkdLL005Z0J0c1hlM2JoSEVvVmY3RndtZ1E4ZnBNVmtsUUtaY2E4b1Vo?=
 =?utf-8?B?VHZvREcwRjUvcjZUUStYWjUrb1lrZ0dEcVp0bXRPd08ybUR6SFdiVGVBdzZW?=
 =?utf-8?B?VllBVGZDSXRlemRQcTFTQlBRTnUyMGtNYmJzOU1FTTBPVmlLTnpxSFcrRXhP?=
 =?utf-8?B?SlNMRS9LZmpMVGovNkh5YXBBMVUwZmZLK2dnUFlDUWtGWVkyaXQ3VE9NbXBv?=
 =?utf-8?B?WTVBdThoUlprWWx3em5kMndFQXdqQSs2a3VHbUdPZVF1aGFub3A1TnBVWVRX?=
 =?utf-8?B?UXMzQXo0eGxFcFF1bkdjdXdYUnFVbjZncFBlT1lvM3BnL0hiWXU4ek9UTWRL?=
 =?utf-8?B?dlk1U3ZpeGpjR3luakxMQm9xcGJCNzBLZTBZUlhHRVlYRDFjYmUxYkxxOFlX?=
 =?utf-8?B?aFBMUmhTNzRHM3J5aVdDZEt2d1V2MGEyVXUyT1JOcXg0b3p4SEYxd2V0OGZm?=
 =?utf-8?B?QlZCbXo2aDR5QjJZOUgxb3dxY08vakI3MVZybWQ1MTgxZ0tmZzVYQ0NjelMr?=
 =?utf-8?B?SDB6azd5QlVRd2NjamZicU5OR1ZPQXZxUkpodmpIK3o3VzBGVXN0MDQ2VmZX?=
 =?utf-8?B?U3MwZ09POFVwclRMTS83clprc2EwSExjSXFMeVRJTmZmM3M1ME1JSmhRNlJr?=
 =?utf-8?B?cndaTkU5bDJteE55cDlMUDZvYjJmaTczOW5HZm54c09pa3U2cGV2NGhOdFdz?=
 =?utf-8?B?S2QyTGQ5ejFzSlI5b1FRT3BlSVdJcmFxdjdyUmtBV2dLUDhlVmEyTksvT3I0?=
 =?utf-8?B?aGF1WU05WW4rWGxyK0IvSEtydmp6UkI2aVJ0ejBWQWJIdkV4SE5kQlV2SmFL?=
 =?utf-8?B?a2NDcUtnWk5mL0V2MGtIbXN0aTNuRk5YZjJGZ3I3QXh5MnhGMCtYU3hnSHh0?=
 =?utf-8?B?N0ljY01jSzZhNTZLNm1xWEtLd2tONXZzYjQ2TG5ITWozQmVLL3l1THdDc3pz?=
 =?utf-8?B?MW43MGNJczhyVFZEQ0VkZ3ZGc0hnVzk3VjY2KytVcWRLK1dNUGQvWkxpUjFi?=
 =?utf-8?B?WWVCMUNmbmRvUVhyUm5aRDlZclVCczJYMm1iNWtuR0JYaFJwTEhGM1IvQVh1?=
 =?utf-8?B?akJWWjZtNTJTZUxqTFFKUlNEZzEwc240YWRZMG9tVHZDc09LN1FpWXF4MkVu?=
 =?utf-8?B?WlVzWkdraWdZa3NDbXpqZFk2R0NIRlZqOWhDK2xoVHh1UC9GNlJ4QXo0R1dh?=
 =?utf-8?B?MHdxRmZDWWE3WkR4Vmoxb0V2N2lwMXRFYjlRQjBBeVJNSTRBbHFTT25NV3Fz?=
 =?utf-8?B?N3F0dTY3dU5FSDFHK3pnLzhFa2UwVTRzd3Y3ekZvaHdkdnJKeEhRVjFaUkg2?=
 =?utf-8?B?eUVTY3BBNDNsMHlHM3hGa1hWV1Rwd1gxeUF0QUd4TkpKK1o5bGZ6MUdDMjBj?=
 =?utf-8?B?b3VHS2RPbjN2OHBxUUZFOXJwSTFHcXFELzJONGFVZXJBbU1ZSkw4R1BKc1lO?=
 =?utf-8?B?TzZxZVdUZXMyTWpIQzNYaUFPUTdLWm9XOXlFOWdzTTFZRk9FWHArWEg3d2VU?=
 =?utf-8?B?QzFRUkhxWTVFMFRVa0N4dHB4TDlQUmpiazVMYjV0RWlkSmhkZWtYR1B2Z3ph?=
 =?utf-8?B?MWdtZ0l4aXFrN3ZVUWl3SGtUajdiL3V5cERHMmRqYmJsOE1KTFQraDhwU3Vx?=
 =?utf-8?B?d0RWcEY0dzhLOW5qc3lOUnBiWVBJcjNtWW1YS0pHTHcydUVKVWxoU2I1c1BC?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387813c-d979-447b-c00a-08db3b83e0c9
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5082.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 18:29:40.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QgK90GAVR5pHXeik35eRbsg7XWIgI+08PDrjMOI44CPHEtISwDTHpUST3VKjHh1ndElqRpAjbfR9oiMKCUTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6304
Subject: Re: [lttng-dev] Seeking Assistance on LTTng for Kubernetes
 Performance Research
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

T24gMjAyMy0wNC0wNiAxNTo1NiwgQmVuamFtaW4gU2FpbnQtQ3lyIHZpYSBsdHRuZy1kZXYgd3Jv
dGU6Cj4gRGVhciBMVFRuZyBEZXZlbG9wZXJzLAo+IAo+IEkgYW0gY3VycmVudGx5IGNvbmR1Y3Rp
bmcgcGVyZm9ybWFuY2UgcmVzZWFyY2ggb24gS3ViZXJuZXRlcyBmb3IgbXkgbWFzdGVyJ3MgCj4g
dGhlc2lzIGFuZCBhbSB1c2luZyBMVFRuZyBmb3IgZGF0YSBjb2xsZWN0aW9uIGFuZCBUcmFjZSBD
b21wYXNzIGZvciBhbmFseXNpcy4gCj4gSSBoYXZlIGEgY291cGxlIG9mIHF1ZXN0aW9ucyBhbmQg
Y29uY2VybnMsIGFuZCBJIHdvdWxkIGFwcHJlY2lhdGUgeW91ciAKPiBndWlkYW5jZSB0byBlbnN1
cmUgSSBhbSB1c2luZyB5b3VyIHRvb2xzIGVmZmVjdGl2ZWx5Lgo+IAo+ICDCoMKgwqDCoDEuIElu
IHRoZSBDb250cm9sIEZsb3cgdmlldywgSSBjYW4gc2VlIHRoZSBDUFUgdGhyb3R0bGluZyBkdWUg
dG8gdGhlIAo+IHF1b3RhIGRlZmluZWQgaW4gdGhlIENncm91cCBhcyB0aGUgcG9kIHJ1bnMgYW5k
IHRoZW4gd2FpdHMgZm9yIHRoZSBDUFUgCj4gcGVyaW9kaWNhbGx5LiBIb3dldmVyLCBpdCBpcyB1
bmNsZWFyIHdoZXRoZXIgdGhlIHBvZCBpcyB3YWl0aW5nIGR1ZSB0byBhIGZ1bGwgCj4gQ1BVIG9y
IGJlY2F1c2Ugb2YgdGltZXNoYXJlcy4gSSBjYW4gZWFzaWx5IGZpbmQgdGhpcyBpbmZvcm1hdGlv
biBpbiAKPiAvc3lzL2ZzL2Nncm91cC9jcHUsY3B1YWNjdC9rdWJlcG9kcy88YnVyc3RhYmxlIG9y
IAo+IGJlc3RlZmZvcnQ+L3BvZDxVSUQ+L2NwdS5zdGF0IGlmIHRoZSBwb2QgaXMgYmVpbmcgdGhy
b3R0bGVkLiBJcyB0aGVyZSBhIHdheSB0byAKPiBleHRyYWN0IHRoaXMgaW5mb3JtYXRpb24gdXNp
bmcgTFRUbmcgb3IgVHJhY2UgQ29tcGFzcz8KPiAKPiAgwqDCoMKgwqAyLiBJIGFtIGF0dGVtcHRp
bmcgdG8gZGV0ZXJtaW5lIHdoaWNoIFBJRCBpcyBydW5uaW5nIGEgc3BlY2lmaWMgCj4gQ29udGFp
bmVyL1BvZCBVSUQuIEN1cnJlbnRseSwgSSBjYW4gZGVkdWNlIHRoaXMgYnkgb2JzZXJ2aW5nIHRo
ZSBwcm9jZXNzIG5hbWVkIAo+IHJ1bmNbKjpJTklUXSwgYXMgaXQgY3JlYXRlcyB0aGUgY2dyb3Vw
IGFuZCBjbG9uZXMgdGhlIHByb2Nlc3MgZm9yIHRoZSAKPiBjb250YWluZXIuIEhvd2V2ZXIsIHRo
aXMgYXBwcm9hY2ggaXMgZnJhZ2lsZSBhbmQgb25seSB3b3JrcyBkdWUgdG8gYW4gCj4gaW1wbGVt
ZW50YXRpb24gZGV0YWlsLiBJdCBhbHNvIGZhaWxzIGlmIHRyYWNpbmcgc3RhcnRzIGFmdGVyIGRl
cGxveW1lbnQuIFRoaXMgCj4gaW5mb3JtYXRpb24gaXMgZWFzaWx5IGF2YWlsYWJsZSBpbiAKPiAv
c3lzL2ZzL2Nncm91cC9jcHUsY3B1YWNjdC9rdWJlcG9kcy88YnVyc3RhYmxlIG9yIAo+IGJlc3Rl
ZmZvcnQ+L3BvZDxVSUQ+Lzxjb250YWluZXIgSUQ+L2Nncm91cC5wcm9jcy4gSXMgdGhlcmUgYW4g
ZXhpc3RpbmcgbWV0aG9kIAo+IHdpdGhpbiBMVFRuZyB0byBvYnRhaW4gdGhpcyBpbmZvcm1hdGlv
biB0aGF0IEkgbWF5IG5vdCBiZSBhd2FyZSBvZj8KClRoZSBQSUQgbmFtZXNwYWNlIGNvbnRleHQg
aXMgcHJvYmFibHkgdGhlIGNsb3Nlc3QgdGhpbmcgdG8gd2hhdCB5b3UgYXJlIApsb29raW5nIGZv
ciwgc2VlIAoiaHR0cHM6Ly9sdHRuZy5vcmcvbWFuLzMvbHR0bmctdXN0L3YyLjEzLyNkb2MtX2Nv
bnRleHRfaW5mb3JtYXRpb24iLiBUaGUgCmhpZXJhY2h5IG9mIHRoZSBuYW1lc3BhY2VzIGNhbiBi
ZSByZWNvcmRlZCBpbiBhIHN0YXRlZHVtcC4KCj4gCj4gSSBoYXZlIGJlZW4gaW5mb3JtZWQgdGhh
dCBpdCBtaWdodCBiZSBwb3NzaWJsZSB0byByZWFkIHRoZSBpbmZvcm1hdGlvbiBpbiAKPiBjcHUu
c3RhdCBvciBjZ3JvdXAucHJvY3MgdXNpbmcgYSBzdGF0ZSBkdW1wIGF0IHRoZSBiZWdpbm5pbmcg
b3IgZW5kLCBidXQgdGhlIAo+IHByb2Nlc3MgcmVtYWlucyB1bmNsZWFyLiBBbHRlcm5hdGl2ZWx5
LCBJIGNvdWxkIGluc3RydW1lbnQgdGhlIGtlcm5lbCBvciB0aGUgCj4gcHJvY2VzcyBoYW5kbGlu
ZyB0aGUgYWNjb3VudGluZywgYnV0IHRoaXMgd291bGQgYmUgcXVpdGUgY2hhbGxlbmdpbmcuIEFu
b3RoZXIgCj4gb3B0aW9uIHdvdWxkIGJlIHRvIHVzZSBzb21ldGhpbmcgc2ltaWxhciB0byBjQWR2
aXNvciwgYnV0IGl0cyBlZmZpY2llbmN5IGlzIAo+IHF1ZXN0aW9uYWJsZSBzaW5jZSBpdCBkZWRp
Y2F0ZXMgYW4gZW50aXJlIHByb2Nlc3MgdG8gcmVhZGluZyBhIGZldyBmaWxlcy4KCkkgZG9uJ3Qg
dGhpbmsgd2UgaGF2ZSBhbnl0aGluZyBjZ3JvdXAgcmVsYXRlZCBpbiB0aGUgc3RhdGVkdW1wIGF0
IHRoZSBtb21lbnQsIApub3QgdGhhdCBpdCdzIGltcG9zc2libGUgYnV0IGl0IHdhcyBuZXZlciBp
bXBsZW1lbnRlZC4KCj4gCj4gSSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgYW55IGd1aWRhbmNl
IG9yIHN1Z2dlc3Rpb25zIHlvdSBtYXkgaGF2ZSBvbiAKPiBpbXByb3ZpbmcgbXkgYXBwcm9hY2gg
YW5kIGVmZmVjdGl2ZWx5IHV0aWxpemluZyBMVFRuZyBmb3IgbXkgcmVzZWFyY2guCj4gCj4gVGhh
bmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGFzc2lzdGFuY2UuCj4gCj4gQmVzdCByZWdhcmRzLAo+
IAo+IEJlbmphbWluIFNhaW50LUN5cgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
