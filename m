Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D6CD1292
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Apr 2024 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712262602;
	bh=DNov8amjtiQeLWXbkX3veCqTs1TDPnSvp+SVk2j/0qw=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ZuV8e+n+Qlt3xVVxQJddMU+qq3Uw6x7Ye1ZEeGHIwN8SPp93U0zZwiveI4M6HvAA0
	 M89DBPOUXIL6ocZjyvNDL+S7HxNcN+wLFbImFXQ6YMJLl15ZoQlOZzwsFs27S+fHKO
	 3yLFvD86e/+KqO3VEEFYzgzA8yGMvUYdVEZEBamlxxtcOyteqfEtq+RhVgQ1Wn4Tep
	 4zNaSugkl+5wQU/ZW5J2ONlY6u8z+4NUce0CS3z/WBcCt9USsyc4LPzMQvafBqFdu3
	 Kk1PmfSKkLuTul0LvgQZSL5ZRdZ2YoiA234YjWIADDGwKlXGOvEzu6gi5tJXkXXD+i
	 Of9z8jfBtIf+w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V9YBy0xZ1z2bBB;
	Thu,  4 Apr 2024 16:30:02 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020003.outbound.protection.outlook.com [52.101.191.3])
 by lists.lttng.org (Postfix) with ESMTPS id 4V9YBx0f8zz2bB8
 for <lttng-dev@lists.lttng.org>; Thu,  4 Apr 2024 16:30:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8aZoXBob7Iin60bafgFr9yFzGInGO+k91vmq7vQvyy1D4hPKcL/pzBnsKHYSBUuC3baJR7C96X1aSftjBTxgVreOC9C9gM1B+J4HIXLclKAxg8kUBPWcoLekQY29fF+KBwXV8xegaq5ng67wz7dzff+jjyRtv8vwACEHBfm3onrjrnZsa2FaVGNTrWEpuBEaDJWpTkPEMjAR1fhnvQgl8YmzPXvqkoRjZ2FfMnpinZ7kUm/tnByAl7GujdwwOzFJpVYW0bi1LF0i5nUKSsllzEKNUQgoZcchJH60OBv0FmhtoBO14stmJcTr6xPzWdUV6x/T23do4m2Vta14QqUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBMrlxOnW2yJeFFINRcXtZE21LkGdZloGT/1dcRGyS0=;
 b=kODyRS4Ed3nDY07mT821j4lNfxKFF13zZ7g0bwpJLhOXL9LnHBQrZW1FvgOH8aBAvOQ/nBPISor8XlFzTPPHok7AhQVFAQmqx7QYyLojWvMKdlj7V4vfRCnhW6ItU2brF7mRW5L1VaYaQrb1MDc971VGDOckKg/c3JueKdqKQlO4ATWahUG7fuwwQ8HPUMeyCObeCkrUGD/1aAX/lXdNugmlKgO0KlxD+EFNFIQ1MklR9Kq3HJJOKCm1g/L9kn6KgXsYheDg2uNFoMQQKe0OGWGBBi0iTshwoHSDWhUoMzlD7X5RhJbxwWDxlyqoVRw5GclC3alZB1nC3h6JvXW9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::14)
 by YQBPR0101MB8814.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 20:29:59 +0000
Received: from YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed]) by YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::17ea:ed8e:e437:46ed%5]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 20:29:58 +0000
Message-ID: <3fab293c-8714-4533-ab8d-942b81ec294d@efficios.com>
Date: Thu, 4 Apr 2024 16:29:57 -0400
User-Agent: Mozilla Thunderbird
To: lttng-dev@lists.lttng.org
References: <CABRndgyg2U-N9s5HtM1V=t89sBsr5Jt1LXbE3M+6e1=tNy3y9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABRndgyg2U-N9s5HtM1V=t89sBsr5Jt1LXbE3M+6e1=tNy3y9A@mail.gmail.com>
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10341:EE_|YQBPR0101MB8814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfrHgbagEhmU+1Fg8ClSFSrnWQlA3jW+VHEs1mTuAJ5ldbfOIxL2jblQNZIKyOqPEfFm3LCAR5cSxqHZkWt0qdWnj0Wto4ph9alienZJK4a9AzqNA2r9y2e1uqcaC6ThTAB3VC0YFnW4cjLun+ybDrBQKi1g7G+udFJlFYtufmsw3vQg+4DuE12Gk3quKrFXnxo5NZ+ZNBNXPlgvdS+nGCqwk7bwoJoZOqhlYVcj97Vw+FiL54eK6q0Mxxs6QbTa8O3zB2E5xYdZuXj3JZ29iTc38X/RaufHa2+rAfsJLWNQMp+d/BrxPNIJXoBewrkn99VEkwOM1p4xRfSWyuxERDH8GjLNK6nYQps/+PK7723CLdm/CVh7IUb87/4CT858iusiQu8QHyqnAq62n2EEjH2nWtazuB7DgGXNTt1TAsCELSAXF40/1mvI5d0VvrI2Ciu1u2Aly8/T58ijHhAkk5PncEKMlNgoxIhyqOtr0A4lPpYujT2mg487wRWRZFR0DMhvFeFqgqkUsUncpuXVPiSdIGSQjYptVR5MBjnf7iWYLhy/Q1nREzEt+zl0S6GwM/Wq6xZ9HjH4059TwifIXBgorts/g4p48RmfOuWg3CY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUUxSHNObXpwTmh3MnpzZ21hOXlOazhSYVQyT01OU0lVckdYc2hhaEEySTVQ?=
 =?utf-8?B?NU11UVZOWjFVMTFQU09YcHNOUi9UdUJoSSt4OTB2Z2QrcnBQZGZjRGhSdWI1?=
 =?utf-8?B?R05XaGh2eWxuVzZwUG5EcXcvOXZkblpaZ25jRXEvb2N3S3FPei9NeE95WXFU?=
 =?utf-8?B?RjBpVDFMemE0MVR1aDB6TDVEcTB3N21RL2pKVlFmeVNJT1JrTWFOY1YxcFNX?=
 =?utf-8?B?U25hZWJmZG9sY3U0NHljdmxKbXg0Z3NkWStDRlpPemYrRWEzcDhvQmkzbVk1?=
 =?utf-8?B?UTJXeU9FM2xKbWhyUFFCUzk5SWkxbVZKclp0VENWMS9ybDA5a3FGTEtlTEVm?=
 =?utf-8?B?WUhUNlNwRGhyZmRyMnVheEdFeUhpanZUTGlwZUdORTk0M05XQTlGR082ZEIx?=
 =?utf-8?B?Ny9TQVU4QW1oT04rUHRzRTczQzdTWGM2aXYreVJ4QUhHcVplZU9HZ1lwRDho?=
 =?utf-8?B?WFN0L01vL2FwMEFCL2lIMUo3SEhwM1BNMHdaaktqaW5QUlhiTHZFQWR6Ti9N?=
 =?utf-8?B?RVVKUEhCMExyU0tiWGpYd0JzSjdhakVpV3Irc2tkdTZzMVdyZHdGTkNMY0h5?=
 =?utf-8?B?U1h2RGhMSmRsMGdQZjdSVnNPRWxTTlBpRCtTQkRwdzlXS2pHbTFERHUwOWtq?=
 =?utf-8?B?MW5EM1M0WDUyNGtPWWczQVZsUjE4Zk9MTGpiTjZVSUtreXpLVUUwa2grR1p5?=
 =?utf-8?B?ZzZYZmQ4aU9WVnNPbnlKREIrWTBmMEJRbElGUkt5VE1IdmsyR2tOY2RWNXFk?=
 =?utf-8?B?blJKMEdzdDlhY1dLLzJwVGhMWDNlVnFjVWd2azR5SW1zNGt0M1FUay9hM1JF?=
 =?utf-8?B?c05rRmFSWTZMMnpyNHd2U3dZTjhydnlVSlc3dGVLSDVGMWhkbkwzVkN6THZV?=
 =?utf-8?B?eGs3RUZCOEJXU21ZVHJ6Z3pkWUJRekVnc1I3R2xOSE1aQURiUWEweVdtVE1O?=
 =?utf-8?B?MXVUNkJQbGFpRHVTWlIxbUdpc1U3VTEyMWlxb3d2M3F3RyswMGthUDMwZDBK?=
 =?utf-8?B?d2Z5dDlLa3ROTW5yYjFRc0tCSG5pVXZDNHo2QWZhMWJia2hHN3FpSW1ja1Fq?=
 =?utf-8?B?UEd5Mm5HSmhkcTlnQUxZNTRnbEx0aUh1R0lYV0ZsZGxONFV3VDBIcGVYUEdZ?=
 =?utf-8?B?VGZxQ1QyY3FCL1pXSU1zTWxIS0VxV0x0blAvU0lpODNoSE0vQ3F6VGZPWFhy?=
 =?utf-8?B?UlNaVGgzZG5ycGx4eG43TysxZGkwYklTeGJvbTQxRTJpOTJJSDJoMkFKVk94?=
 =?utf-8?B?RlFDZHVkQWtnWkxEcE0zNUJ5Q1Z6aHBwSEZXSkFjci8ySkdvSHRkT1M2aGFI?=
 =?utf-8?B?aTl1QVJRSzRhWUM4cnpCSWZSMEEyblRGSE0zVWhBU1RIcTJHaWJMc0U4a2xU?=
 =?utf-8?B?b1poODZKTGZJNXBHWThaUWVmd0RjQXA1cHpOemFrS3NINUhZYXlXU3pjcFBm?=
 =?utf-8?B?OUIyZXZXVmhRUXdQWllkT2trUHhxbys2S3BrbHRnS2RCZXZaM3M2V3liSEVj?=
 =?utf-8?B?UWZjY2F1dFpxYVFZcTZnVlp5V243VHdhU25FaVRyYk54OXg5SzExVHBhVUcz?=
 =?utf-8?B?QjQrQllDVTI1bXhjTnNRT2RkeWE3UktwQjg2K2pGUEtpMTl3STZ3eGp2MUdF?=
 =?utf-8?B?UFBLc2NvcHVJaHVlWE9RZXFTNmtCcThjRThDS2JqeTJBS0hCTjR4M2lUdGZT?=
 =?utf-8?B?ZGdpL1NWb0RabGtnKzg0eUNjWXJPdnovSnppNHhqY050TlIremkyQzRLUjZJ?=
 =?utf-8?B?VVI2L2lUcUR6NU9BZ2hiR3hDUDhMUlR5YjQvNFdaYUhYa1RFTE1Uc0JhNG1v?=
 =?utf-8?B?eHhTRE85dVQ2Tk9CaVM3NXhRRVYzY2N1WmJvUUlBb29xS1F6cHBsVjVEQVFr?=
 =?utf-8?B?dEh2aW4rWjAzVEthUzBrQkJ0TG96Vm13Y2NJVXd3STNlZ0FoUHd3NFJ5R0ZJ?=
 =?utf-8?B?cUtRZEpmc3hFZjVYc3hBTmxndUZBTTlFWFJxLzZ2WDhsQWV5aFNZM2o5cjhI?=
 =?utf-8?B?MkowSElZWU9ZRjE5aGRySmxSVTJzVE1Nd0I4YU9RR21TYWx5MGNCRm9JK3pF?=
 =?utf-8?B?UEE5RXdJcG4vY3dQN2RSMHN6aUdPekpQTDFvVysyQ2pwV3g0M09URFdiSmwr?=
 =?utf-8?B?ZlltTWhwME5TbHlEMVhJaE9aUzgvYzBxa2JTN3ZCOFZFcm1vVitJOUFkUjd6?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504f02f7-22b1-4a4e-6097-08dc54e5ff3f
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10341.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:29:58.8825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW0v7ekX3GGpiOX6ckylSDRZbYtG+aLrQ06C6kekP0Og3aXfDz/AVIdDS4n6eLdYaUjOTfucc1tNDOXvI4++AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8814
Subject: Re: [lttng-dev] babeltrace2 on windows
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

SGkgWnZpa2EsCgpiYWJlbHRyYWNlMiB3aXRoIHRoZSBweXRob24gYmluZGluZ3MgY2FuIGJlIGJ1
aWx0IG9uIHdpbmRvd3MuIE91ciBDSSAKZG9lcyB0aGlzIGluIHR3byBlbnZpcm9ubWVudHM6IGN5
Z3dpbjY0IGFuZCBtc3lzMi11Y3J0NjQuCgp0aGFua3MsCmtpZW5hbgoKCk9uIDQvNC8yNCA0OjA4
IFBNLCBadmkgVmVyZWQgdmlhIGx0dG5nLWRldiB3cm90ZToKPiBIZWxsbywKPiAKPiBJJ20gcmVx
dWlyZWQgdG8gYW5hbHl6ZSBhbiBsdHRuZyB0cmFjZSB3aXRoIEJhYmVsdHJhY2UyIHB5dGhvbiBB
UEkuCj4gVGhlIGhvc3QgaXMgcnVubmluZyB3aW5kb3dzIDEwLgo+IEJ1dCBhY2NvcmRpbmcgdG8g
OiBodHRwczovL2JhYmVsdHJhY2Uub3JnLyNidDItZ2V0IAo+IDxodHRwczovL2JhYmVsdHJhY2Uu
b3JnLyNidDItZ2V0Pgo+IFdpbmRvd3MgaXMgbm90IG1lbnRpb25lZCBhdCBhbGwuCj4gCj4gSSBw
cmVmZXIgcHl0aG9uIGJ1dCBJIGNhbiBhbHNvIGNvbnNpZGVywqB1c2luZyB0aGUgQyBsaWJyYXJ5
wqBmb3LCoHdpbmRvd3MuCj4gCj4gVGhhbmsgeW91LAo+IFp2aWthCj4gCj4gCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFp
bG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
