Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A24C3DA6E
	for <lttng-dev@archiver.kernel.org>; Mon,  8 Jan 2024 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1704726638;
	bh=4Xb0/0u4IRqcwQeZhfxDEe/n+iPKJ0PlDcWT7pKClXw=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EDFxU1bB/0h2upozzWNEhqhTxzjVUWFgUfG9jLLBJf5AvxclWcN1C61lkBHIAgtgk
	 vHIFrhr1triKktXEysmtQFuZ7QRpRoHMjNixOaSsyif6Q6nlF1HjIXkpcL7Ra70Xsd
	 QSzWiXSEaOBCxFo5QM5rwg9P014ePdXq0q5kObU2Tnx0cYkwT/wsbwdaatTcGAvGFW
	 KQ+cB/bGdEeweohhyYLgLegDMVzPYEyVmuH5MVq3UYG04Uwo48r2KWKZldo4bn1Q/z
	 a5hqmYobFqQ6a8bjXbgGgMSSD77mUugukPedHDII7EAALCkitwliI6jCb4EFC+Ctg5
	 jJ8IcsKsIZN1A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4T7yDY69Dcz1HBN;
	Mon,  8 Jan 2024 10:10:37 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::601])
 by lists.lttng.org (Postfix) with ESMTPS id 4T7yDX1xwJz1HKQ
 for <lttng-dev@lists.lttng.org>; Mon,  8 Jan 2024 10:10:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiZv/Ju9JPZNll3TahMv7QS5C44DqEgyioikL8nlOJCKIvuLGZaOCvbfduwVEa8b1cVaDUsHOaW5ozRGcv0AFNq+W5qJcIhyAm4Z9+u5Ls11pZBnpOKdLqyTZQtkWDwCIL+tUkmksQyV0XT+ZZlrHQDQtkZx+/kdBs0FLLy8sqba7+5e5E2oQh4/VFOFGO3Xi0f4EjOsF5g8u0moq+tZRRxaKrxxzUvpFliFUgszAnRbjo1o+rEs8JFryJARdhtoMYIR7eY8fNV6bpTeowg578P8nnByKQnZoyWoZmpKRlDHqb0zPBx/3hFqDL053XjKfqIbmeNbBlm5oLLlAXPRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiqKJwXBapGwBuzC1ubi+bB6WeF/fBXsvElHE+QQapw=;
 b=AJe86iBC9L+HFPis4s+amcF1S1uGjLGXBl01NXSjeeuv8icNh0XaUCYrmH4286iIqMlIpqAAueqTBUtzMYTWIivdg59XZZcgfPi0Md7XXEx//Ps4yfBsv9inoXGXjghcSVtKh4suTO0yT/mgBYeD4WX1NcTWXaeDqRzxQEDvNyH5eOHaOnNh9IvL6DF4mzWvR2ej4meRbLIikm7/UlE/21+q13CLIlp5Dh2umZmv4dTZ0TgjaNvJbqVqFnL+UbW7ziqDbeBixf5aTYrKIEsogUChRrZDnInWlwGvJgtva+b2Eo/q9bqGjbLt7fJ1v9hqaFIeMMNKf2iUQqlZoXxtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:28::14)
 by YT2PR01MB8181.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:10:33 +0000
Received: from YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb]) by YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::999e:b830:64f7:13eb%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 15:10:33 +0000
Message-ID: <c0837834-d205-4aec-be6a-f46d25ffc35d@efficios.com>
Date: Mon, 8 Jan 2024 10:10:31 -0500
User-Agent: Mozilla Thunderbird
To: lttng-dev@lists.lttng.org
References: <MW3PR12MB4555207ADC0ECAF8DA3EFF74D998A@MW3PR12MB4555.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: laksd@nvidia.com
In-Reply-To: <MW3PR12MB4555207ADC0ECAF8DA3EFF74D998A@MW3PR12MB4555.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::14) To YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:28::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT1PR01MB4153:EE_|YT2PR01MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: d525a161-469f-40f4-11b2-08dc105bf60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XagqbVqRAjV0KE0awe0THpbsAEho2vlEhnxqG2KLcw8f89Lhqd3z+QNiDXL2AxKJ8kh3ZJI+cdhA6vwhHLy4Kg18a8moMuiracQGHHVOa9V2NzE8z6HmMjsENfKtkGpN7liueSLSXUFfymR4bwByxjoVcphqdrbpz6nrt9DvRfyRig0e/wR6/suz6Yt6gWJs/SRAmEx2wBYBNaKfWUM1I6dNf1lif/RPvZ9+WaMAeDShPwR7z4j2gsFk9PoDXWCBLqs8KBibTEeqw//Kto1ZStwZnXSLteDSEzOgPWzfuDsUKuEt5pvdCSCJylldzca2RS79u4nA2ibHe0UhKNwL8+Ew9cYZgTjFsaXLqNcGAG8CK3ndeu2ZcBhl67peQhKpP4mI6I/fujzE4VulN1EJ+By2eNgV8IqlmA6DvmS3sDAFoWTTRrVioXKSR+y75F+tVXHv4/QiLRdYzIySsD67DWWUN6HHTxifp8JYwu4odMiw69johxoXdYLpvILA0h7+kzolGYA0Y7nXkVHNZUomn62s5M2PE9zoTCZdYeSM44Wgl41Q9oYU1+g+PeIKLhCHF/xvSf/B2M2v9cR59sqqGGFtRX8KVUSsidXS9wgnNHlhDN8pyrHSO0WOVcTHjt7FA7DMYgRS3u3tiQRfgu3m8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39830400003)(376002)(396003)(346002)(366004)(84040400005)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(31686004)(2906002)(6916009)(5660300002)(6486002)(53546011)(36756003)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(31696002)(83380400001)(966005)(26005)(478600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajhDTjRydm41eDZrSFVjWnhFeWRXQlYySmo3R3Nac24yMW1MbUlUb0ZDaGU1?=
 =?utf-8?B?UE9iNGtTMzkvWkZnQlRueXAzU2ovUHM0ZTU1c2RzejExRmc4MTA5TVNNN013?=
 =?utf-8?B?VGx2anVYS2VGc1NrazJsY3hMS3hWclBnbDNRNzdBM3NYMm9tdUlKQ2FWRFpN?=
 =?utf-8?B?empacnIrMFN5WFdIRmlQOFJnL1UzZSs2ZUR2YWErUElsMEJhM3RKREJVbm42?=
 =?utf-8?B?UnJILy9ORGlVTHdidWZiTi96a1JtcTBZbStZWFNvWmdmdklncVlLbVhwZHpE?=
 =?utf-8?B?ejRZT0IxMXk5ZWRoV3VJKzA3TnhIWktuM1ZidERneFZIOEJUcFdNRTRyeElB?=
 =?utf-8?B?THdCVFZUZmhFR1JITysycXE5QjJOT0dMS2w1R3YrNWRtdVVkV3FGQm9DQjRY?=
 =?utf-8?B?bzQrUzRwdklPNHE0YTQ3NUc2eDdFWm9IQ2ZYTTMrSCsxYktnOEg5UWpaY09V?=
 =?utf-8?B?ZWxtaVFQeHgzb1hWTEk5a2pKZlpmMDVBb2lFU0F6QnNPZkMxT1BoRnJVcDdh?=
 =?utf-8?B?Uk11eVFETHk2cVptaWovTS9wVWsxK1JwNmluZWsrYlE5cFRzVURDYlAvcmZB?=
 =?utf-8?B?K1k4K2lBMDJOWGZwRGxTdW9RblZGL1hEUkN6eENOVlBCVVdKWHhhNnVVNHpx?=
 =?utf-8?B?Q0pVaWlIeURlaUtUcGs4cXJ0QVZMWW4zeTNhMUlRdmRDWXRRVTBPYW14eXJP?=
 =?utf-8?B?NWl2VXJzeHBGS1J5ZENWNG1aSjg2eDd6RzMwR3JML3FsN3pFS3AvamhQK1VE?=
 =?utf-8?B?em4rMEIyREsvdnltQXFEMTBlNzYxR2ZMdG1sR2d6RlhMK1Nwa0NDdmNWRWdl?=
 =?utf-8?B?bGhUUkVGSGNGT2RMWExOVnhjS1FBVzZ2ZHVvZmJHbFFjR1BJYXE4L1NHK3pP?=
 =?utf-8?B?Q2JoU0RiSE5COTlGTVJiTzFNVFZiNm42YWxsNmZwSEttMWc2RGxtV3lyYkJP?=
 =?utf-8?B?UjJIT1lxSHc0Qm85bm9SVW54YWZ2czJtQzdmTFZkaDNRNHNxR3RhNWU2Z0tG?=
 =?utf-8?B?L2VvZTRSQVNDWjlySkNHSVNFR1VLUjB5YkR5dHhBYzFyS1hRTjdPN244UHQ3?=
 =?utf-8?B?bnlvTmpSbWNlNmxEc21Xa2FUUmwyUGZpbmlpQ2cyRmpJQk8wYm5mbVVaZTRi?=
 =?utf-8?B?ZTZJcmxVaU9VYjRIR2Fvb29ESWVGc0dWQ1FLS1ZCbVNydlBnR2w0Y0hNdVNQ?=
 =?utf-8?B?eWVEaHhld1oxNlQrUFc1WmZCY1ArMDh5NWQ0b2VNRWhvSXlpWlBJRkhBcXZO?=
 =?utf-8?B?NHFFZ210cnJvRittYzFOSHZFSGQwczhzdG5TVnIzdGlvWktCa3V6VXpLMHBw?=
 =?utf-8?B?UllEdlhlcitBdDdLQTBQTGJ4TlBRZXVVdVg0ZlJTWVY3YUltMDhFdDhKWU9i?=
 =?utf-8?B?eC9manF5R2hjV1FheWlUd3RDOS9NbDB1dDBIZXE3S2pBUEh4b0NDTG1Ta2pZ?=
 =?utf-8?B?Z0JoOFNXQXhRR1NOYVF5YURIS2RVQVY3L1B6WXdEKzZWU0xNaUxhVXV4TEx2?=
 =?utf-8?B?TXp5azhaQlNidWJuWlc0OHVSd2ZUanpGYkxSdkhhQlNXZ0wva05PemhoaXlp?=
 =?utf-8?B?bkZ2VGwrcTVMWmFkVUpIMUlQY0pCeXdpVDlGdFFRWi8rOWFlME15aFE1REpZ?=
 =?utf-8?B?aFdQcGR0ajVndGw2YTg2c3ViYmJyTWdRazd4dzM3Z3Y0aFFRTTlSY3luNTdX?=
 =?utf-8?B?OE84RDlxQ2VzVmxZRFRSekk4SXE5QzUyR1E4L2lmSjRiK29Zdm1PUk5wM2xp?=
 =?utf-8?B?NmFFeExNZzc4S2dqYTRXb0Y1dWZhV0F3eGZ6dmE0aWFnb1J1cCt5c1hnWkI2?=
 =?utf-8?B?cUhpc2o5Z3RYZ2d2N3A2c2R6WW5qNjh4cU9UejBhVDdkSHROUHgrbVRPNmxT?=
 =?utf-8?B?NVY5VG4yelZoMGhhb0dxQmZHbGt5bFdEbVQ2QXpQbnJLay9rSGJic0tCK1NV?=
 =?utf-8?B?SVl5UlJpZXI5K1N0RjFvNHJKb1M3b2x2U3daanpwUURpR0FBSk9oYUhYS0hy?=
 =?utf-8?B?ZVB4YUl6eEdPaUlUM2h1WjZRY01WcHNwWmc5VHBROTdpQkVmc2JtbHpkbVd6?=
 =?utf-8?B?MldNakFpZmRWa0dpT0pndnFkNE9udDA0MXNabXd2bU9QUWVzSFkwRmJjNnYy?=
 =?utf-8?B?MitaWENXVk5udzBWdkZrQ1ZyazJaalRYYzBjSEtSb2FXZWxuZ0tENlBac3Zk?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d525a161-469f-40f4-11b2-08dc105bf60b
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4153.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:10:33.6931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7yPh8tdIwwVatcN52W+Nmv4P0Ix5WWphFnW4gAC7XP5ztRYV5D5DYbl5O7hGuRjuyDXXy3uQDeKKBf+VbxC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8181
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgTGFrc2htaSwKCmNvdWxkIHlvdSBlbGFib3JhdGUgb24gd2hpY2ggdmVyc2lvbiBvZiBsdHRu
Z3VzdCB5b3UgaGF2ZSBhbmQgaG93IHlvdSAKaW5zdGFsbGVkIGl0PwoKT25lIHBvc3NpYmlsaXR5
IHRoYXQgSSBjYW4gaW1hZ2luZSBpcyB0aGF0IHlvdXIgbGRjb25maWcgY2FjaGUgaXMgb3V0IG9m
IApkYXRlIGZvciBzb21lIHJlYXNvbiAtIGBsZGNvbmZpZyAtcGAgd2lsbCBzaW1wbHkgcHJpbnQg
dGhlIGNvbnRlbnRzIG9mIAp0aGUgY2FjaGUgLSBwZXJoYXBzIHRoZSBmaWxlcyBhcmUgbm8gbG9u
Z2VyIGluIHRoZSBsb2NhdGlvbiBzcGVjaWZpZWQgaW4gCnRoYXQgY2FjaGU/Cgp0aGFua3MsCmtp
ZW5hbgoKCk9uIDEyLzI2LzIzIDExOjE5LCBMYWtzaG1pIERldmVya29uZGEgdmlhIGx0dG5nLWRl
diB3cm90ZToKPiBIaSwKPiAKPiBJJ20gb2JzZXJ2aW5nIGFuIGlzc3VlIHJlY2VudGx5IHdydCBp
bXBvcnQgb2YgcHl0aG9uMyBsdHRuZyBtb2R1bGUuCj4gRm9sbG93aW5nIGlzIHRoZSBlcnJvciBh
bmQgbmVlZCB5b3VyIGhlbHAgdG8gZmluZCBvdXQgd2hhdCBpcyB3cm9uZy4KPiAKPj4+PiBpbXBv
cnQgbHR0bmd1c3QKPiBFeGNlcHRpb24gaW4gdGhyZWFkIHN5c3RlbToKPiBUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6Cj4gIMKgIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuNy90aHJl
YWRpbmcucHkiLCBsaW5lIDkxNywgaW4gX2Jvb3RzdHJhcF9pbm5lcgo+ICDCoCDCoCBzZWxmLnJ1
bigpCj4gIMKgIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuNy90aHJlYWRpbmcucHkiLCBsaW5lIDg2
NSwgaW4gcnVuCj4gIMKgIMKgIHNlbGYuX3RhcmdldCgqc2VsZi5fYXJncywgKipzZWxmLl9rd2Fy
Z3MpCj4gIMKgIEZpbGUgIi91c3IvbG9jYWwvbGliL3B5dGhvbjMuNy9kaXN0LXBhY2thZ2VzL2x0
dG5ndXN0L2FnZW50LnB5IiwgbGluZSAKPiAyOTEsIGluIF9jbGllbnRfdGhyZWFkX3RhcmdldAo+
ICDCoCDCoCBjbGllbnQgPSBfVGNwQ2xpZW50KG5hbWUsIF9TRVNTSU9ORF9IT1NULCBwb3J0LCBy
ZWdfcXVldWUpCj4gIMKgIEZpbGUgIi91c3IvbG9jYWwvbGliL3B5dGhvbjMuNy9kaXN0LXBhY2th
Z2VzL2x0dG5ndXN0L2FnZW50LnB5IiwgbGluZSAKPiA3NiwgaW4gX19pbml0X18KPiAgwqAgwqAg
cmFpc2UgZQo+ICDCoCBGaWxlICIvdXNyL2xvY2FsL2xpYi9weXRob24zLjcvZGlzdC1wYWNrYWdl
cy9sdHRuZ3VzdC9hZ2VudC5weSIsIGxpbmUgCj4gNzMsIGluIF9faW5pdF9fCj4gIMKgIMKgIHNl
bGYuX2xvZ19oYW5kbGVyID0gbHR0bmd1c3QubG9naGFuZGxlci5fSGFuZGxlcigpCj4gIMKgIEZp
bGUgIi91c3IvbG9jYWwvbGliL3B5dGhvbjMuNy9kaXN0LXBhY2thZ2VzL2x0dG5ndXN0L2xvZ2hh
bmRsZXIucHkiLCAKPiBsaW5lIDMyLCBpbiBfX2luaXRfXwo+ICDCoCDCoCBzZWxmLmFnZW50X2xp
YiA9IGN0eXBlcy5jZGxsLkxvYWRMaWJyYXJ5KF9IYW5kbGVyLl9MSUJfTkFNRSkKPiAgwqAgRmls
ZSAiL3Vzci9saWIvcHl0aG9uMy43L2N0eXBlcy9fX2luaXRfXy5weSIsIGxpbmUgNDM0LCBpbiBM
b2FkTGlicmFyeQo+ICDCoCDCoCByZXR1cm4gc2VsZi5fZGxsdHlwZShuYW1lKQo+ICDCoCBGaWxl
ICIvdXNyL2xpYi9weXRob24zLjcvY3R5cGVzL19faW5pdF9fLnB5IiwgbGluZSAzNTYsIGluIF9f
aW5pdF9fCj4gIMKgIMKgIHNlbGYuX2hhbmRsZSA9IF9kbG9wZW4oc2VsZi5fbmFtZSwgbW9kZSkK
PiAqT1NFcnJvcjogbGlibHR0bmctdXN0LXB5dGhvbi1hZ2VudC5zbzogY2Fubm90IG9wZW4gc2hh
cmVkIG9iamVjdCBmaWxlOiAKPiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Kgo+IAo+IAo+Pj4+
Cj4gCj4gSSBoYXZlIGluc3RhbGxlZCAqbGlibHR0bmctdXN0LXB5dGhvbi1hZ2VudC5zbyoKPiAq
Cj4gKgo+IC8jIGxkY29uZmlnIC1wIHwgZ3JlcCBsaWJsdHRuZwo+IOKAguKAguKAguKAguKAguKA
gmxpYmx0dG5nLXVzdC5zby4wIChsaWJjNix4ODYtNjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4
LWdudS9saWJsdHRuZy11c3Quc28uMAo+IOKAguKAguKAguKAguKAguKAgmxpYmx0dG5nLXVzdC10
cmFjZXBvaW50LnNvLjAgKGxpYmM2LHg4Ni02NCkgPT4gCj4gL2xpYi94ODZfNjQtbGludXgtZ251
L2xpYmx0dG5nLXVzdC10cmFjZXBvaW50LnNvLjAKPiDigILigILigILigILigILigIIqbGlibHR0
bmctdXN0LXB5dGhvbi1hZ2VudC5zby4wIChsaWJjNix4ODYtNjQpID0+IAo+IC9saWIveDg2XzY0
LWxpbnV4LWdudS9saWJsdHRuZy11c3QtcHl0aG9uLWFnZW50LnNvLjAqCj4g4oCC4oCC4oCC4oCC
4oCC4oCCbGlibHR0bmctdXN0LXB0aHJlYWQtd3JhcHBlci5zby4wIChsaWJjNix4ODYtNjQpID0+
IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3QtcHRocmVhZC13cmFwcGVyLnNv
LjAKPiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtbGliYy13cmFwcGVyLnNvLjAgKGxp
YmM2LHg4Ni02NCkgPT4gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC1saWJj
LXdyYXBwZXIuc28uMAo+IOKAguKAguKAguKAguKAguKAgmxpYmx0dG5nLXVzdC1mb3JrLnNvLjAg
KGxpYmM2LHg4Ni02NCkgPT4gCj4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmx0dG5nLXVzdC1m
b3JrLnNvLjAKPiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtZmQuc28uMCAobGliYzYs
eDg2LTY0KSA9PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LWZkLnNvLjAK
PiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtZGwuc28uMCAobGliYzYseDg2LTY0KSA9
PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LWRsLnNvLjAKPiDigILigILi
gILigILigILigIJsaWJsdHRuZy11c3QtY3lnLXByb2ZpbGUuc28uMCAobGliYzYseDg2LTY0KSA9
PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctdXN0LWN5Zy1wcm9maWxlLnNvLjAK
PiDigILigILigILigILigILigIJsaWJsdHRuZy11c3QtY3lnLXByb2ZpbGUtZmFzdC5zby4wIChs
aWJjNix4ODYtNjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11c3QtY3ln
LXByb2ZpbGUtZmFzdC5zby4wCj4g4oCC4oCC4oCC4oCC4oCC4oCCbGlibHR0bmctdXN0LWN0bC5z
by40IChsaWJjNix4ODYtNjQpID0+IAo+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJsdHRuZy11
c3QtY3RsLnNvLjQKPiDigILigILigILigILigILigIJsaWJsdHRuZy1jdGwuc28uMCAobGliYzYs
eDg2LTY0KSA9PiAKPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlibHR0bmctY3RsLnNvLjAKPiAK
PiAKPiBSZWdhcmRzLAo+IExha3NobWkKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCj4gaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
