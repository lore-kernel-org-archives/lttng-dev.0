Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD36BC76195
	for <lttng-dev@archiver.kernel.org>; Mon, 27 Mar 2023 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679941790;
	bh=6zYSHG1clH63+Uk5UCunzECMqy2RgpyAOKIl5NF4kTg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mBCa+HSn0Pcsmkp6pjW1yrN7juZquM211dGlmMpKwB4tO2Z0nVR1tr9wWeHLGFKsQ
	 YyKIG4vxVF67skk3S2yRDf8QNokI6CkjeFx7raPlyK5QWy9VJ427K4Zwi+oh2hj3+D
	 4CivBqEUVqim1B573bEhH/U29JYbsBTc0Z7KmCqZKtoCExjvUnm6DRW41feAno9g6B
	 3mCGK9vW5AhdEFFw7qMpi/GTbeLGiqHntupWbgEyX80hzdirOsjDYyMb/aOgONdRG2
	 iGwZo4WMY+dtnQ8w6cLyFETBrsT5WbDUzMm97hY7CLQ5sFtgCbE4QjgDWCPsVa7EFC
	 QARCQH0AWaTlg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PlhDs5WNwz2Jpt;
	Mon, 27 Mar 2023 14:29:49 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2077.outbound.protection.outlook.com [40.107.116.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4PlhDp5c89z2Jpr
 for <lttng-dev@lists.lttng.org>; Mon, 27 Mar 2023 14:29:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWLRzYo5a40t9oe7z5GGk0iMXjxPkGBjNfVRoDgrtekUuAkHUD+Sg8YvTeN0quB2Zf1GAoqm46V0sJeTOuv7rx/xKWgJQiY5+R0ElLrW5vNrCCaF4oCDo6OPZeW98eeYPposFvMugGI7wwgHwMZhv1NtalN3IGggPHqARr4HAJvCwBQ4e1QhQYgIQfRHUAk2JrdQhr/QZHIfAC7cMZ6saeTakrFmwRhXXvqQlsu75gA8PUVmDLhMLS+M9RtoPxtVHgKp9kIkA3EdyVJorKRsBbxJvLfWWWF3gc+owdCScI/pyy5DXMkSmaX+mU+2JWVQlFNrBSPrryqGgv/nz4dLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b58m9dRjeOyXKP0DafCiMIhRLHJp1CTyE4miDQNPAs=;
 b=Cu28T0TR7/5aGIGe6lp700ES69Y5fI6Y2BzjP3JToyKMnfKnn2u5SRdf5mUkX3yBR2VlM9yAVe+uS24N2XmXpEDHBAg2LSj41srnyYyOoXtH7L6T90HYFjd/qqVdZTr6R72f6aVrX0K+b0tYqqZ0FE53ap4uPWlzMec8BYJ36DXKK+fB47wHIf99ONLg3e6N/vHXgHrcBGCPOSKIx/zu+7N3jBNfIomDunHihGzSTD9l0zqp/fjFo7EmyI25cvxHu2duz6glAdIRyYO/oM0HMzMlRLGks1mg51Lw5JETXzrqhvqeqM03x30Sib8ggBtbIlotNBto0yVggpxJU6BF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQXPR01MB6346.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 18:29:28 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dc59:f9f6:4a73:cde4]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dc59:f9f6:4a73:cde4%9]) with mapi id 15.20.6222.031; Mon, 27 Mar 2023
 18:29:28 +0000
Message-ID: <9bf67681-e3c7-0b25-07b7-40c0a85aee67@efficios.com>
Date: Mon, 27 Mar 2023 14:29:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: yashvardhan kukreti <yashvardhankukreti@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
References: <CALx39aqN_YvfcDhhKgURZZU-bWZvuiZptbb-kJDYerEex9Q-7A@mail.gmail.com>
 <CALx39arqYKMj_M1q_XDBfCSrSruJ5obUuNHeN4Cu7a1sVDwwbw@mail.gmail.com>
 <3056c476-0e3a-8cde-39e4-907602d26d76@efficios.com>
 <CALx39aqPFVKGCv+jqvgdxge6mew0+Wg4cH-PnBB8Z_LhO6rOig@mail.gmail.com>
In-Reply-To: <CALx39aqPFVKGCv+jqvgdxge6mew0+Wg4cH-PnBB8Z_LhO6rOig@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::39) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQXPR01MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: f31673fa-85be-4d8d-5885-08db2ef1331c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCegiERsldVDFuGK6i3rb83APxOS0h4Xhpr54Bw47//jDm3omseakTivXINOjqt+vD6GUvfyul4yI0wAGbbRnQIoCdFXMPHBrggtjhHj57a3f8fDIp+ji7DBiL7TdnqeqAOaFzfotLxAB1KJlhDG3aSJF2ch5u6n8gEQGcOtnW2cXewRFIk5i5bcRh0G1k1dVufwix9yXErAbOP7/Bb/oAtT9IMv3b77tw0M8wju455M269ENI5sAU4qFL5IvMQKunhl8OYvY1bOeyl3wcAjmt6WsjY0WBpFotHXM5XMxouFHGJRp+BkI584fXeeLy4W1jGnjpJAFzCAPwTvvrJzTaul5XPHYQXYvX5//U4hNuRK67vvHNXg57TM8QOCV7ZwNo4J5rCsbEoQoTNS2+qpnsxRtaT+VwcQ4jfjXXcIyvRiQjaTGdVIJdw3KzzMeLVrsmYKb0gyDGJ/d8yI5Y2B92QQUPSpiTt+y6TSK0lMyTsSRUZQZbCgJdgTrha4JpkqT2PzlQMAxWnM+VeDPFVNCd8x8U9bjn3ZzJ++ZYt8/deMoorh4QQdpLZCuhe/PEr3ASjRqwt72FSWaFNWZXVNn8J1S7uO2k881GrOQGLUMObJ9SAqAFrY2J89mZXyK2o64+RBO62PL7xsHjVEwI1T1/aD6elJjq45MJQwJBvBI94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39830400003)(451199021)(31686004)(2616005)(83380400001)(41300700001)(31696002)(36756003)(86362001)(5660300002)(38100700002)(8936002)(6486002)(6636002)(966005)(478600001)(8676002)(66946007)(66556008)(4326008)(2906002)(66476007)(6512007)(53546011)(6506007)(316002)(186003)(26005)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZpNllZRndIR0gwam4rM2hyV1hpejdCTjRyeUNTVWpnUGdQV3VneW9nZFRz?=
 =?utf-8?B?QmQxU1NNV3N1UUQzNG9ySWY1OGFPWjdKU0dMT0pqdy9TL3lNaHpYK2JOYyt0?=
 =?utf-8?B?YXJzcmVpbVdyRWtsS0tZWmhTdXpTdFhjWGM5dC9teXRmUHVldFprQ0drKzlo?=
 =?utf-8?B?UmNOS1kxbW9ndlM0dWpXN0tteCtXNTJYdTZtWSt6ZDV3ZW4zUWRhTzdEa1hB?=
 =?utf-8?B?L21CQW9hT042alFTblp3OFV3eGphYldmQ0QzcVI2MWJFUWVKNVJ4ZVZ2VTFP?=
 =?utf-8?B?MVVxNXo2QkdBVWlNT2xDVlpkSkdjMHUrK1JpTFNJbWloYTFYTGJwdHdpUldI?=
 =?utf-8?B?NnM3eUZ4UnhtVG9ZUmNMKzdHMWFXS20xaHQwcTJ3RUQ4ZGE2RHZucmd4YllT?=
 =?utf-8?B?VzZ0YlNubm5vS0k0ZDRnNnAza2tnaFlKSmZDaVphR01ka3lVZ1hGaytFN3RE?=
 =?utf-8?B?YktmWEJibHlhQVlsSkdmZlhoOEVXa0duZHl4UnZZTEpCT1RIYnlsbDlQKzZR?=
 =?utf-8?B?WGJSZUNPZXFmTTR3bk8veXRYZkRMRDJMdTZRZjZObzR5NlRTc2JNVGFTU3li?=
 =?utf-8?B?ZjV0MVlNSW10czkyeHhJWGxXSHp5OTdndzU2cEExOW9semZOU0Q4VnBnZGk4?=
 =?utf-8?B?YldhRUp1a3NZZlE5U1g5OWRuYXlOL3dHeWJhbzZhTCtyZktOeUNJdkNVWnVp?=
 =?utf-8?B?Ulh6c3dkaUN1bjI1NFVhV29QWmoxMnZnbC81Z2VYN1VYNlh2SDl3VmhZS1Rw?=
 =?utf-8?B?bVViaHE0K1ZoYzNoTzV6STZncit5QnBwR2s4bWh3ellMZ1hwd2lVL1UxeHpX?=
 =?utf-8?B?YTZoMnBKNCt1UmFxY3VzSExjQkQwZ2VJK3FPbWxCakU5SmxvaTgyUjhvcFBa?=
 =?utf-8?B?THE3SGNMUzNqUjV1MWNISnBvcURjcjdMcUJzeEtUWWlOeUppVXRRN0xOOXlS?=
 =?utf-8?B?akxDSmxlRisrMzJZMHJ6Y3V0V3hMbTUxdFZlb3NtWmNDQVgyYkdteHIrcUIz?=
 =?utf-8?B?YUNlSGdoTTZOWmw0ZXBmbW9XUndWeUd1VmQyd3oxNzdIdzdtRU9GelMwOGQ2?=
 =?utf-8?B?WEFzTU42MXpNR2hMTVRsOG0vRE9WWXZsZjNhVURuNFpsUnF2clBVd29zeU16?=
 =?utf-8?B?bkxJZjZReEU3aTRQRnJZZ1R3cWw1RjMwb3lxWDFjZ200US9tS1dIc3c2T0V6?=
 =?utf-8?B?RThRNm8yVU96Tmp4dUJkVm85bGZZeDlpK1NDbS80VzhidFB2RXVHS2xlT1dF?=
 =?utf-8?B?V3ZBc2pjK0VvaE1hNXRjU0lRc01Ob0xRVHpzS0oySGZFdjJUcGptMzFveGUw?=
 =?utf-8?B?YnVKdFV0SWJnb01QQU9hemNZTDYrcmltaVV6MkFJVjd2bTB5aUNCTEdmK0Ir?=
 =?utf-8?B?TzF4dHY5ZFpOb25NTmFOc2Q4b2E1enBGRzJmSEl5UC9Ib01JOHNUTHdlTjFh?=
 =?utf-8?B?MlIwZ2FTS3d5MVQvZ0xLV3VCMU5FeFdHZHBFaUxOOHg3a3Y2eU5yMDNZME9p?=
 =?utf-8?B?bUxMbGZkM0Q5N3R6RThTQldWcmtESUN0NTZoNWdWL2NDQWNQMUpteGdhSEdi?=
 =?utf-8?B?WGVSZnhLRHhZMUZKaWt0Q3hDUng3NUtOS3hVL2xiejdIV3pYakZ5amRPYzBK?=
 =?utf-8?B?MXA4VnI5OWt0QXcvOEpFdHJCZ01YTHpFZ09VS3hHK3dYUjJHQXV2UnRJbEpY?=
 =?utf-8?B?blFyT0xjWUowdHFuaHIrYzNJK0VqK2hCWExETi8rWGh1M083TFZkNlJCV3pU?=
 =?utf-8?B?Tm1nVlE3eGxZVzk1WitPeVhwWFJHaUU5UmdiaW9RL2R5dkduV1ZjZVlSNXUw?=
 =?utf-8?B?YXNYMjlNMzRsYmw3azZzNTk4RnZiTHlzd3dGVEttbHQxbTExUFlOWUc0UzZv?=
 =?utf-8?B?bzFuQXVKT1h1RTB3OG0rT0RBZjgxaHVzZUx1cnE3VkRuNmRtdTlHRE05eXM3?=
 =?utf-8?B?RVJNQkt0YmRQNHNlbnRZL282ZnYrbFREOWxxQjJXQ3pqdDdLVktHTnVVcU5V?=
 =?utf-8?B?VUlCUmlhVWVXc3hsOGd0MTBHMG1FK2QveldBbFJQTFhFMkM3aUFxTmFZZkJu?=
 =?utf-8?B?alpkK3VqeWljSUpjUVdscFVYSGl6WXRrL0lNM1Nqa3hvbmJsOU1qTzRkNEtk?=
 =?utf-8?B?ZXBMcVdnQm13UHhOcjJRbFd5OUtBSHkzSHhmQUplSWt4RGZJdC8vNmRsTmVF?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31673fa-85be-4d8d-5885-08db2ef1331c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:29:28.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/vhsdlMQAPk9SK1sTF/cT0fWpkfnlAmqKyERgDtzx8JPX0Vf9CWhv+DYJIECHI5DL0ljfQJ0R5Qyv0HpchHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6346
Subject: Re: [lttng-dev]
 https://lists.lttng.org/pipermail/lttng-dev/2020-May/029631.html
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

T24gMjAyMy0wMy0yNyAxMTo1MiwgeWFzaHZhcmRoYW4ga3VrcmV0aSB3cm90ZToKPiAgwqA2MiAj
aWZkZWYgTFRUTkdfQ09ORklHX1BQQzY0X0VMRl9BQklfVjIKPiAgwqA2MyDCoCDCoCDCoCDCoCAv
KiBTdWJzdHJhY3QgNCBieXRlcyB0byBnZXQgd2hhdCB3ZSBvcmlnaW5hbGx5IHdhbnQgKi8KPiAg
wqA2NCDCoCDCoCDCoCDCoCBhZGRyID0gKHVuc2lnbmVkIGxvbmcpKCgoY2hhciAqKXByb2JlLmFk
ZHIpIC0gNCk7Cj4gIMKgNjUgI2VsaWYgZGVmaW5lZCooTFRUTkdfKkNPTkZJR19QUEM2NF9FTEZf
QUJJX1YxKcKgIMKgPDwgaW5jb3JyZWN0IE1BQ1JPIHRvIAo+IHVzZWTCoGluIGdlcnJpdCByZXZp
ZXcuIHRoaXMgaXMgdGhlIGNvcnJlY3Qgb25lLgo+ICDCoDY2IMKgIMKgIMKgIMKgIC8qCj4gIMKg
NjcgwqAgwqAgwqAgwqAgwqAqIEJ1aWxkIGEgZnVuY3Rpb24gZGVzY3JpcHRvciBmcm9tIHRoZSBh
ZGRyZXNzIG9mCj4gCj4gL2x0dG5nLW1vZHVsZS0yLjEzLjgvc3JjL3dyYXBwZXIva2FsbHN5bXMu
Yzo3MjozMjogZXJyb3I6IGludmFsaWQgdXNlIG9mIAo+IHVuZGVmaW5lZCB0eXBlICdzdHJ1Y3Qg
ZnVuY19kZXNjJwo+IHwgwqAgwqA3MiB8IMKga2FsbHN5bXNfbG9va3VwX25hbWVfZnVuY19kZXNj
LmFkZHIgPSAodW5zaWduZWQgbG9uZylwcm9iZS5hZGRyOwo+IC9sdHRuZy1tb2R1bGUtMi4xMy44
L3NyYy93cmFwcGVyL2thbGxzeW1zLmM6NzM6MzI6IGVycm9yOiBpbnZhbGlkIHVzZSBvZiAKPiB1
bmRlZmluZWQgdHlwZSAnc3RydWN0IGZ1bmNfZGVzYycKPiB8IMKgIMKgNzMgfCDCoGthbGxzeW1z
X2xvb2t1cF9uYW1lX2Z1bmNfZGVzYy50b2MgPSAoKHN0cnVjdCBmdW5jX2Rlc2MgKikgCj4gJnNw
cmludF9zeW1ib2wpLT50b2M7Cj4gCj4geW91IGVpdGhlciB3YW50IHRvIHVzZSBmdW5jX2Rlc2Ny
X3QKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xNS4xMDQvc291cmNlL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS90eXBlcy5oI0wzMCA8aHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjUuMTUuMTA0L3NvdXJjZS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vdHlw
ZXMuaCNMMzA+Cj4gb3IKPiBzdHJ1Y3QgcHBjNjRfb3BkX2VudHJ5Cj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTcuMTUvc291cmNlL2FyY2gvcG93ZXJwYy9pbmNsdWRlL3Vh
cGkvYXNtL2VsZi5oI0wyOTMgPGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE3
LjE1L3NvdXJjZS9hcmNoL3Bvd2VycGMvaW5jbHVkZS91YXBpL2FzbS9lbGYuaCNMMjkzPgo+IAo+
IGJvdGggb2Ygd2hpY2ggYXJlIGRpc2NvbnRpbnVlZCBmcm9tIDUuMTgKCgpIaSwKCkkgdXBkYXRl
ZCB0aGUgcGF0Y2ggYXQgaHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvbHR0bmctbW9kdWxlcy8r
LzkxMTMgdG8gCnN1cHBvcnQga2VybmVscyBvbGRlciB0aGFuIHY1LjE4LiBJdCdzIG9ubHkgYnVp
bGQgdGVzdGVkIG9uIHY1LjE3IGFuZCB2NS4xOC4KCk1pY2hhZWwKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
