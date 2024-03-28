Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21511CD11DD
	for <lttng-dev@archiver.kernel.org>; Thu, 28 Mar 2024 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711655322;
	bh=QOCkovU99C9RJWCeygBQ32eVJVwv3Lr8Zc/PTudIBcw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=y5G2waycChfBBaLD+FmnqIayaz5Ag+aQSqD9ONWfC/eVIzYmW1eNHbXOJfbHOVdDv
	 jWrvkTjEFM8jOI8w8zM8lOKKDBdhc7kuXawV2N0sOwgPM6kJ/vfV5Td07xmwx1DYBB
	 pfS74X584df5wVxQkg0xR1fy/ApHYCpM6zxCxhl1WhWrwMbVrpJqTOIU6JNBuGWIGu
	 pO7BrMSASBv6D7ZoJFtNAmAnIUEjo9/RkKzlV6MQFJDfkRK/2so4krRweG9XFFQguS
	 /lodAFcSwk8GybLNj29uG52zbQ5dN9WFCJ9KU2WOonfzS7YQHss6G7Hdb2MXnDnlvN
	 w7cZ6emkZB/sg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V5DcV0glcz2XND;
	Thu, 28 Mar 2024 15:48:42 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4V5DcS62ZFz2Xbs
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2024 15:48:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDXYDF8fdf+mt1BNqGLjVE+A0a0iY80SzaUW7MkSK71qw5MY293jjD0k/imzQlDZHTGdZHJqUh3PGOj0wfvK4ZJUqPkoy0K1DZEBb3iW3sFOKy5ao/upl8DWxyOWOUjxaSNFrwDxk0EFQwaXhk2X/MkuK6GqpeU7TXd8LpDC4n+ZkpC9WjrCeoLDELJI96mGdcHcDc7HmBBg/jOrV5R0gX6FCANZo0S6nM2nFgNpQSYwry3rDYL+tsZW63E8vd2I1OkvIC1/D0xbDkpvQBc61eaz7nlgDL4l6Vi6aJOS7zX+vF3r0PMTNnFfJnOE14i+oqHY9UWNZ7gVImHcgwxJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7myJDkLfvT7oKblLOWRCUECB28sk7IiGjY7OQIQTbkQ=;
 b=UyaC3Y9ep5iw8dAPPzFjGBz0s0J47fMv6BX3KS2uVz3WReh8bcrydJiLbO/SDmd8SXFNvmUe0AiX+1MUdlrbAd/HUGXqBCal3slCtEtR+Ps9jhlGJHLDrT00DsZx8kwdETXwjzzC1oKVhmoKQl/gYOiRAZsdUSZ41PaIkbcLYh2Rp/aewzpfSB24siNJDKouoEd9oHWWKhQY8nobaS6hKyf4JFFWUBsNAakCbOHjpvrjobuu26fobOM2z8/bsdef8Mn7CWkNRpj1GV9ZFT40SADk5aLxZCLvSZZYsk1kNABwMAReQWSFgyj2WBWsAMD3FpydTcCMYsUu82uG3Mtc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PR01MB4144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:30::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:48:38 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 19:48:38 +0000
Date: Thu, 28 Mar 2024 15:48:37 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <ZgXJlRnySWf3l-JN@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::20) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PR01MB4144:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48+ANdfFLxpSeC5d1KcmEhb8FYXMN5A0wliiKc3FnAcqxDTnTcwoX7Pk2LxsZxuOfPwjshF+OwgkGGmpCVnnAPcgT6bZ3WmG37iIFvi2U5aMJP5bfqmUWltnIdOHteXGx9UN+excraV0mY38yDtULTNYZJPkGXlKyjbjvlxQIlMjO3jPFyJiPjJ62JgN8oUAKeYVyb67mb3csRXtpAxMQf8Z6T3ftdwOeQXnFtsVbYzGCcv6RcrV6VdgeKEYur3jrKMHlcCaNRdcFGdJ2zhS3w+RjUgwr11ESvItMgATzPleiWYzMxcp7ZC6JAdBNOEFYR4jlTza5Z6tlnCAutvEfFqUFmdhp6MjXq8lKbEQhkw6qU9FtFt2vjFghun/yLNIwDiAWeB9XURtxUvgw4l8gcLDlkxIaaCH1cD10aPWI1SGD0DLJ4XeeJgIHXiO5xmUC4l8aMdWyl+8xVVGkfmrTh01wpPcjwHsRCVsPDYR+NzZXjY6mR6PjeUNyTV8fewga91y0MllETxfGis8GlOtx27O+T3kUeWsvVtQdf2/cKoFC2Z9ipV2EBjLAKgB2K4uMhRaZffHLOFZDBjSgoWYXzAgdybLKtcdoqArGbh7xlkEWrF9Whz4SmQ3rz+GaiaF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRqMm5IWUt1VXAxeCtTMjBGeVc2S3VRd3BHQ210TVZxUGp3UEFILy80UmVl?=
 =?utf-8?B?UjJVaktKdzZvRDRibmFmVkJLYUhTRkhUeC9UbkhlSTNKK2FZOHBGUHErY0or?=
 =?utf-8?B?M3prRDJ2RGF2YjMyQjJoUzJmWWd2bURDZE4xMWVkdWY4bENmS2RzdUNmdzhn?=
 =?utf-8?B?ZmdLV0dzcytSVmtFOU0xWUpiUWtNeUJpcnBZZmJROUNUSHNYaW4xSEZDOG5n?=
 =?utf-8?B?d1VHdnA0SEFWRXlKV0w5ZFIyRmhqcFVKMmdNN0NEbFZDcFNmNFdCcHNDaEc5?=
 =?utf-8?B?bUZjejloempUVndYT2hMUHphV1VYcENIY0dBUktiVHNqNXM0eTJ2VCtXWDJq?=
 =?utf-8?B?UGJWd0FIQ3ZiZDVSQXdiTkt1OGdwN1NiSDBRYTVPNlY0c3N1U0c4djR1S0tx?=
 =?utf-8?B?VmJTNi9qMFlJTzJRalI1NFFpcjFPRFVNRGJLNkxlMTk3Yk8vaVNGcEpkUFpW?=
 =?utf-8?B?OElpeGRGWEFKMGhaQ2RBK2o2S010RXFta2M1cFRvaHJ4VnlXUkFzSGZ0MjhI?=
 =?utf-8?B?T2NzdnV1L3BxSzhPODRPTlhyOGdtT3M4RlhLT2NZTm9uUTA5ZGhFS2phQ0dL?=
 =?utf-8?B?a3duWVp4Y3JZcElZVENmRkI4eDRkdjRZL1FCSkNoc01aYnFDMFpNR09GY0dD?=
 =?utf-8?B?Y2pvVU5yRWR3akdvT1B5cW5wSGVUakxubldYLzNHWGJDZW1zcm1xRnhVRFNT?=
 =?utf-8?B?QXM0Qm0yYjNPY3Y2cGNoZlNYekp5RU5uMHRGaGhRcnVkNW1RUExqZVU4T0hm?=
 =?utf-8?B?ZDlWd1VGbGFsakl0MFJWaGczYjUrNHh0eGwvWFVuaEk2STBnVGdDZ1B0RmU1?=
 =?utf-8?B?bjZqUFpCT2h1SGNHSUh0Sjh0VWtiWVNpWWNJb3NnRzNOTXp1QzhnNGFnUlg2?=
 =?utf-8?B?bGJtVUlPU1lUajFFUWpqZmlacy9VazVsTlhCS0J2RVhjc1RNN21ndCtrUm9G?=
 =?utf-8?B?TkpsYi9XL0xuM0pVWko2dEJFUkF0Z1pkY3J5YjNqZzFuUjZhVTRleUZ2V2M1?=
 =?utf-8?B?bmdDN3lNelZ2VE9UOUlWWk9EN3NsSkh2eEl0VjNodHNhZVlqZ3kwR2NBS2tx?=
 =?utf-8?B?NTJBVWhuSTJmQmdTMWtsL3phZlUybnAzTGVCOHpBaHJKb3FPczVRMjB3UlVw?=
 =?utf-8?B?cTVrTkRYK0dJcmdITkNHOU5XcmlLS0RZb0hzM1lIVzA0K3V1Z1BhSFN5Qno2?=
 =?utf-8?B?M3N5ZUtlTGd2aE8vV3BHL09hNy9KSkl4Vk1RUXZwdFFrUHgyTXhraVJCaHZJ?=
 =?utf-8?B?aWxqcjBBMmVpWUdEaWM0U3VDZTZhYzBzbm5Sc0w1UmE2SWlTa0d3Z3ZNam5C?=
 =?utf-8?B?bzVYSFpUeDA2K3JxYjBTQVBsQkY1Z292YUFtZkYzNWNSNHFPZ3d6cFBXTmhy?=
 =?utf-8?B?bnFWdkI5WnBqNDViWHlReUFrc1FOYU0xTks4YWxJK1lNOFJaR1hSWThabmc5?=
 =?utf-8?B?NGZNNnF3UlRZclNDVjJockIyZ3djODhCVURsWUY5b1QrZkJGOFhXNHhPTmFK?=
 =?utf-8?B?ejFRS2NqakErNll5ZHdhcHpNVFprVDRvVVgxRUlhbFhXVUV1RXhFMEFsamxw?=
 =?utf-8?B?cDgza0pwNVRNVWNla1R4MjZIS2dkSjRCN25tTVFKUXhaM1JPcWRpNmFINVJk?=
 =?utf-8?B?ZEFnVTYwM2t2QjZHRFduRDZHbG1ZZkZtell1N0ZOMk1tcUU4YTZSckVDUnY3?=
 =?utf-8?B?WVlDbTY3ajJsdFpPeEEyLzZvZkp0TVdObjBXeFFlNWxwcFFibUZvSisxMVZa?=
 =?utf-8?B?YWJwTHZCR1IwY011QTRIY2RxSzVxaHRwRjBRamluNUdNb1M5bXZIYk5zaEd3?=
 =?utf-8?B?eHJBVW1hdk1jY2dpd2JZdndCUGFXbG1OVVBSaVJDSW4yUjRHMjlXeko1V2VD?=
 =?utf-8?B?TThLUmhBeHVpZGtpTEhoZUdMRUpSNy9haTJMYzJkc2tRdXhRWWhXTll1SWhX?=
 =?utf-8?B?QVdYSWlTbWYvR2ZuaTU3dGswRXlvLzhqYm9rTHg0RFl3akoyNS9SM09ybTlU?=
 =?utf-8?B?b0tyRklnaEFIOGlxT1NrUG4vZ1JvdXFxVE4rQklrZVJJaU1tTTNwQXF4Y1dK?=
 =?utf-8?B?VnhaZ2JtWU9NM2E5VHZ1bHhSTnF4YmZrOW54QTMydVN0bGcrSFJnRzQvWHRv?=
 =?utf-8?Q?gbraxG3ueeQdVKlVwT0LRcWyW?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3359b2c2-e248-4842-e737-08dc4f600ffb
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:48:38.4434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7otd0fx+bkzY18HgeV/xPpAsE18BZD4Ddi9tbUl2KGEAmWlKe70c9qhNiPlxnKbrPZ+caB87ySgN35aia6b8Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4144
Subject: [lttng-dev] [RELEASE] Babeltrace 2.0.6 - Amqui
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgZXZlcnlvbmUhCgpUb2RheSBtYXJrcyB0aGUgcmVsZWFzZSBvZiBCYWJlbHRyYWNlIDIuMC42
LCBjb2luY2lkaW5nIHdpdGggIlJlc3BlY3QgWW91ciBDYXQKRGF5IiDigJMgYSBub2QgdG8gb3Vy
IGZlbGluZSBmcmllbmRzIGFuZCBwZXJoYXBzIGEgY2FsbCB0byBlbmpveSBhIG1vbWVudCBvZgpy
ZWxheGF0aW9uIGFmdGVyIHVwZGF0aW5nIHRvIHRoaXMgbGF0ZXN0IHZlcnNpb24uCgpXaGF0J3Mg
bmV3IHNpbmNlIEJhYmVsdHJhY2UgMi4wLjU/Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KClRoaXMgcmVsZWFzZSBicmluZ3MgYW4gYXNzb3J0bWVudCBvZiBmaXhlcyBhbmQgaW1w
cm92ZW1lbnRzIGFjcm9zcyB0aGUgYm9hcmQuCgpIaWdobGlnaHRzIGluY2x1ZGUgbnVtZXJvdXMg
Zml4ZXMgdG8gZW5zdXJlIHRoZSBjb21wYXRpYmlsaXR5IG9mIHRoZSBQeXRob24KYmluZGluZ3Mg
d2l0aCBuZXdlciBQeXRob24gdmVyc2lvbnMsIGVuaGFuY2VtZW50cyBmb3IgaGFuZGxpbmcgaW5h
Y3RpdmUgc3RyZWFtcwppbiB0aGUgTFRUbmcgbGl2ZSBzb3VyY2UsIGFuZCB2YXJpb3VzIGRvY3Vt
ZW50YXRpb24gYW5kIHRlc3Qgc3VpdGUgcmVmaW5lbWVudHMuCgpCZWxvdyBpcyB0aGUgZnVsbCBs
aXN0IG9mIGNoYW5nZXMgaW4gdGhpcyB1cGRhdGU6CgoyMDI0LTAzLTI4IEJhYmVsdHJhY2UgMi4w
LjYgKFJlc3BlY3QgWW91ciBDYXQgRGF5KQogICAgKiBidDI6IGRpc2FibGUgc29tZSB3YXJuaW5n
cyBmb3IgYG5hdGl2ZV9idC5jYAogICAgKiBidDI6IGNvbXBpbGUgYG5hdGl2ZV9idC5jYCB3aXRo
IGAtV25vLXVuZGVmYAogICAgKiBGaXg6IHNyYy5jdGYubHR0bmctbGl2ZTogZXhwZWN0IE5FV19T
VFJFQU0vTUVUQURBVEEgZm9yIGluYWN0aXZlIHN0cmVhbXMKICAgICogRml4OiBgYmFiZWx0cmFj
ZTIgY29udmVydGA6IGRvbid0IGNvbnNpZGVyIHRoZSBgLS1wbHVnaW4tcGF0aGAgb3B0LgogICAg
KiBpbmNsdWRlL2JhYmVsdHJhY2UyL3BsdWdpbi9wbHVnaW4tZGV2Lmg6ICJkZWZpbmUiIC0+ICJk
ZWZpbml0aW9uCiAgICAqIEZpeDogZG9jOiBlc2NhcGUgZG91YmxlIHF1b3RlIGluIGJ0X3AgYWxp
YXMKICAgICogRml4OiBidDI6IHBhc3MgX1RyYWNlQ2xhc3NDb25zdCB0byBkZXN0cnVjdGlvbiBs
aXN0ZW5lcnMKICAgICogZml4OiAnbG9hZF9tb2R1bGUoKScgZGVwcmVjYXRlZCBpbiBQeXRob24g
My4xMgogICAgKiB0ZXN0czogcmV0cnkgb3MucmVuYW1lIG9uIFBlcm1pc3Npb25FcnJvciBmYWls
dXJlIGluIGx0dG5nX2xpdmVfc2VydmVyLnB5CiAgICAqIGRvYzogZml4IHVwdHJlYW0gLT4gdXBz
dHJlYW0gdHlwb3MKICAgICogZml4OiB0ZXN0X21lc3NhZ2VfaXRlcmF0b3IucHkgaGFuZ3Mgb24g
UHl0aG9uIDMuMTIKICAgICogcGx1Z2luLWRldjogbWFyayBzeW1ib2xzIG1lYW50IHRvIGJlIHB1
YmxpYyB3aXRoIF9fYXR0cmlidXRlX18oKHZpc2liaWxpdHkoImRlZmF1bHQiKSkpCiAgICAqIFNp
bGVuY2UgLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZSBlcnJvciB3aXRoIGNsYW5nCiAgICAqIEZp
eDogV2luZG93cyBETEwgcGF0aCBsb29rdXAgd2l0aCBQeXRob24gPj0gMy44CiAgICAqIGRvYy9t
YW46IG1ha2UgZGVmYXVsdCB2YWx1ZXMgb2YgYm9vbGVhbiBpbml0LiBwYXJhbXMuIGNsZWFyZXIK
ICAgICogUkZDOiBkb2NzOiBmaXg6IE1hdGNoIHN0YXRlZCBhdXRvbWFrZSByZXF1aXJlbWVudAog
ICAgKiBmaXg6IG1ha2UgZmxha2U4IDYueCBoYXBweQogICAgKiBmaXg6IHJ1bm5pbmcgYmxhY2sg
b24gcHl0aG9uIDMuMTEKICAgICogYnRfcXVlcnlfZXhlY3V0b3JfY3JlYXRlX3dpdGhfbWV0aG9k
X2RhdGEoKTogZml4IGRvY3Mgbm90ZQogICAgKiBGaXg6IGN0Zi13cml0ZXI6IG51bGwgZGVyZWZl
cmVuY2UgaW4gYnRfY3RmX3RyYWNlX2NvbW1vbl9hZGRfc3RyZWFtX2NsYXNzCiAgICAqIFVwZGF0
ZSB3b3JraW5nIHZlcnNpb24gdG8gQmFiZWx0cmFjZSB2Mi4wLjYKCldlJ3ZlIHdvcmtlZCBoYXJk
IHRvIGFkZHJlc3MgaXNzdWVzIGFuZCBlbmhhbmNlIHRoZSBCYWJlbHRyYWNlIHByb2plY3QsIGFu
ZCB3ZQphcHByZWNpYXRlIHRoZSBjb21tdW5pdHkncyBmZWVkYmFjayBhbmQgY29udHJpYnV0aW9u
cy4gQXMgYWx3YXlzLCB3ZSBsb29rCmZvcndhcmQgdG8gaGVhcmluZyBhYm91dCB5b3VyIGV4cGVy
aWVuY2VzIHdpdGggdGhpcyByZWxlYXNlIGFuZCBob3cgd2UgY2FuCmNvbnRpbnVlIHRvIGltcHJv
dmUgQmFiZWx0cmFjZSEKCkFzIHdlIGNlbGVicmF0ZSB0aGUgcmVsZWFzZSBvZiBCYWJlbHRyYWNl
IDIuMC42LCBsZXQncyBhbHNvIHRha2UgYSBtb21lbnQgdG8KYXBwcmVjaWF0ZSBvdXIgZmVsaW5l
IGNvbXBhbmlvbnMsIHdobyBvZnRlbiBrZWVwIHVzIGNvbXBhbnkgZHVyaW5nIHRob3NlIGxvbmcK
ZGVidWdnaW5nIHNlc3Npb25zLgoKSGFwcHkgY29kaW5nLCBhbmQgZ2l2ZSB5b3VyIGNhdCAob3Ig
cGV0IG9mIGNob2ljZSkgc29tZSBleHRyYSByZXNwZWN0IHRvZGF5IQoKSW1wb3J0YW50IGxpbmtz
Cj09PT09PT09PT09PT09PQpCYWJlbHRyYWNlIDIuMC42IHRhcmJhbGw6CiAgICBodHRwczovL3d3
dy5lZmZpY2lvcy5jb20vZmlsZXMvYmFiZWx0cmFjZS9iYWJlbHRyYWNlMi0yLjAuNi50YXIuYnoy
CgpCYWJlbHRyYWNlIHdlYnNpdGU6CiAgICBodHRwczovL2JhYmVsdHJhY2Uub3JnCgpNYWlsaW5n
IGxpc3QgKGZvciBzdXBwb3J0IGFuZCBkZXZlbG9wbWVudCk6CiAgICBgbHR0bmctZGV2IGF0IGxp
c3RzLmx0dG5nLm9yZ2AKCklSQyBjaGFubmVsOgogICAgYCNsdHRuZ2Agb24gYGlyYy5vZnRjLm5l
dGAKCkdpdCByZXBvc2l0b3J5OgogICAgaHR0cHM6Ly9idWdzLmx0dG5nLm9yZy9wcm9qZWN0cy9i
YWJlbHRyYWNlCgpHaXRIdWIgcHJvamVjdDoKICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9lZmZpY2lv
cy9iYWJlbHRyYWNlCgpDb250aW51b3VzIGludGVncmF0aW9uOgogICAgaHR0cHM6Ly9jaS5sdHRu
Zy5vcmcvdmlldy9CYWJlbHRyYWNlLwoKQ29kZSByZXZpZXc6CiAgICBodHRwczovL3Jldmlldy5s
dHRuZy5vcmcvcS9wcm9qZWN0OmJhYmVsdHJhY2UKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
