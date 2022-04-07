Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBE4C433EF
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Apr 2022 00:51:46 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KYjWN343zz2NQ;
	Wed,  6 Apr 2022 20:51:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649292705;
	bh=KnCIYa/am7EoHr82SOgvNYSSZGZ6Dq53Mfslq/n/AHk=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=H+aoHJoz344IqrKaaynEzQwJiiTXESu5dJDuzk4SqfNzPMcegvT6B90zDqq8U4DK9
	 qxiM/Mxiw1tMJ7VdemRJhJzf5gRVbNbkWq4flwHbAEDw2gi1bRDiHI+0DgbHlnhRqd
	 QDiXygUI06XI/tdcmcw+BH+9Rq1LALECjrgh5COFstG4rDn/hp9KIayPMSWHsV2dek
	 kLV6pEGgfqS/HTjiIb9F4UZaM6jX454QDa7RqZwFy8dlM02tIxwqRajyBb14KTCMsV
	 LMIrpjnMQ1dtnZrnpoIx8IpLaYV3jqFlPiwWaYIHjwl9KJMMkZVOy1c9v3M3GZMH79
	 rA2bWNI+9AMUA==
Received: from na01-obe.outbound.protection.outlook.com
 (mail-cusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::3])
 by lists.lttng.org (Postfix) with ESMTPS id 4KYjWL1DDpz2HP
 for <lttng-dev@lists.lttng.org>; Wed,  6 Apr 2022 20:51:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brEaTR/PCbaWXq318cg0407WI7+qT9Gdv4Bz5qWbfRD/IjShmKYoEF1WnNCwndL+bmwiIuMe8f0hq27nT/IL1/vNcKPnQl4KEEkDy4d6fdL+g1kco6bqN8AIb+5OObq0ujW4WdkufzG06AbE5SzpgBdDpl3jijt0EcW/axCl/DIunqiG0siWGEg1nQtcDtL5xGEkdMtlOdpGuXyP6LPmUu8nsktF3388gM8BOQcscINiiV5wK1OCQ+fggKeMKJs+DUA/eAEM1/hhBYgbf34FIkjEn0CxSA88LCrC98eWHaXkvux93BNaKa8Y50j+8pjchBQHeLF1DjdklLsZd2vWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th6FhisAWt9HN9ajEhPjm9C9P7BD2i34873cZTYufbY=;
 b=KWG6+/JwfidhqOSANEWpRQ7E6iEhTn/fRlhbL78uHQIhNDNzoP5ch2U2OdD3NtKEdYxlznlHKKT1GUGbOhg0B5ryLU/F7j6t9uCOJGMW/f5ijkwm8C25sUGiKotW5KLIRSbmK+g1XrYT07rK0idsVRU1e3y7G8bUs+k5Llxtcdc/0uVD6ut3YX3QhLYRO0T6Y1tKDDXSLtWXHx3weMJV6e89VUMMHmQ+8AiEk/FtWhkZ+jUkvBi1eSrzqwA6sDaCBrnlYU7FQs/xHrG5G/PmQI7FTGewlpruzoGL7Z2tF9ebKcG842WzpYc1EwFPhWl8Ayb4AhGakfdPTXug8CV1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from SN6PR2101MB1343.namprd21.prod.outlook.com
 (2603:10b6:805:107::17) by BL0PR2101MB1057.namprd21.prod.outlook.com
 (2603:10b6:207:37::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Thu, 7 Apr
 2022 00:51:39 +0000
Received: from SN6PR2101MB1343.namprd21.prod.outlook.com
 ([fe80::c952:df16:ef52:94ac]) by SN6PR2101MB1343.namprd21.prod.outlook.com
 ([fe80::c952:df16:ef52:94ac%4]) with mapi id 15.20.5164.008; Thu, 7 Apr 2022
 00:51:33 +0000
To: Philippe Proulx <pproulx@efficios.com>, diamon-discuss
 <diamon-discuss@lists.linuxfoundation.org>, Eric Warden
 <ericwarden@microsoft.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>, tracecompass-dev
 <tracecompass-dev@eclipse.org>
Thread-Topic: CTF2-SPECRC-5.0
Thread-Index: nMgR3zVo89XTXbOJAaCfWCEdSjUhvKBwdNbw
Date: Thu, 7 Apr 2022 00:51:33 +0000
Message-ID: <SN6PR2101MB13433DE20434FDD6FECC80B681E69@SN6PR2101MB1343.namprd21.prod.outlook.com>
References: <1481555190.3990.1649187227493.JavaMail.zimbra@efficios.com>
In-Reply-To: <1481555190.3990.1649187227493.JavaMail.zimbra@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73b08a24-fc74-4f8c-bc70-f3f9d1467bcf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-07T00:49:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab0950e5-4aa2-4d89-614d-08da1830c335
x-ms-traffictypediagnostic: BL0PR2101MB1057:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR2101MB1057517658D6E2D671F2923D81E69@BL0PR2101MB1057.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oV3KiTWcx2Rknmv/l+h7X58PEmV07W+LUTnbpUXPn7fv7SqNufAbDYHfaTe+h4P8neOn6ZWbcAftTa08FX6cRk4mwaWOtfJpE9IZKyqEQtbid+82iri5+Q/9IscooTyUv2Af/4srcaN9I+hAp4us0Qowf2dgmALtDGAlhSzrAB+3DNeuDKyK954oSFUH7fmAa59kyFx3faqtRm2wKSVvGqxUejKwXbF9cj9EIgJBvRI+p6N8wDICf1KaK66R2qIt0kVp5oWdBDw1gF25Q44Gv/8ueiHoi0E03iDVsiotLlwfH+nT440f2F4QwPurzhhuX5DLHHOXiPTxeMZQuyEJVkz22cKdKAKzsY9SHdxapmKo8QYwO02CmVH0699YcwRqlFGuvLgO9pfac26cPy8zYTzh2dDZAYDy/KuS+ZEMPK78yS48azjnAvgXA/SvPHqKxmd8GObMwCCVWVtygXBuFIyCctlBdkicJf8GMiFW01b9HgH7QcmKZeXDIXBH+NR8SRXfagJbb7wxy7aVSuaZCkQyt0kx8TzbBpngfOJhvotTJWPdvvp7aCdA/SDcWukzZ8m+wXMZ9J8IJ+lncz7OkXOVGIeAc+cCyXTWB4A/SG0/4JhzcLMcKGUP2MIhqYHp0a9SC1SdngNKevxKlaH6DsX8aaIJkojD4v57pY6Q/0wUFHPTUn5bU5utxpf9TR6VXZkGZsv64Flf78CEH6ZWhs5KoKt2cyZQ0CwPDRPPkn3uNVHaijZWABp2pkYzl3kqVWyXhk6pfTH5JjHdrCTcCSi+KNYLyF3AK9RyEXxTL6ID5iaCxTZC/GTu8qlLi0Ou7cuCkM2WUN74kLJ9zOx2hg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR2101MB1343.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(6636002)(54906003)(110136005)(2906002)(38100700002)(55016003)(82950400001)(5660300002)(83380400001)(53546011)(6506007)(82960400001)(122000001)(316002)(966005)(508600001)(10290500003)(52536014)(38070700005)(33656002)(4326008)(66946007)(66556008)(66476007)(66446008)(8936002)(64756008)(8990500004)(86362001)(26005)(9686003)(71200400001)(186003)(8676002)(7696005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X0T4Z8wb1FVk/jKq7FjYMxBgxq8lIVHPJEHFhXk0041SoL5wOIeprITVZA+q?=
 =?us-ascii?Q?tcCZ8aOTbkdRb4r+RyQyXyjGsXou53J4imXEeJtpF3ApLRhHiHe8Y8TX1nl2?=
 =?us-ascii?Q?ET/YUmJm8VDvdY5h+nXB6+P/oAtqyKonUkLcGFkTgWlmKmBAVwjjPze5uh/R?=
 =?us-ascii?Q?U8fkQuj+7e9XxAxzsJFbJ59KxHM41a/TG39j5/4+WdRMtFJCaaKHqrKv97C+?=
 =?us-ascii?Q?qMRJju3fAP5nL2AbYA5bEbqqFYV5p2XlOqHBHryOfJi8p5mf1X1g5fis/XCr?=
 =?us-ascii?Q?KKp2+YDF8XZ8QNRsfDZaV36MzFuwjFRvw7LXcE6YPI+OzGrcSNnK8V8iafgK?=
 =?us-ascii?Q?PEARuv+gbfok8GUONj2WTepJn4tiMFkonlmF7Q73yXj+BmP5IbFWrHV2HBJu?=
 =?us-ascii?Q?oIUeJUZ107Tt1tbmhMVkbE8tZE6+Si7WWvAaFjcdyHsuWKSspK9tD3WdKVBo?=
 =?us-ascii?Q?2EeKkmPGSkv7/hs/inA00N3Iz0Rl2NBD/vzMhFnYTzMaCAK8ktaeAxzcHdAq?=
 =?us-ascii?Q?LNa0R5aL7yGt2r4zz0uVmA+pIxhkTJ5lTulod2h+6RMlbosCDes7igBiIb4B?=
 =?us-ascii?Q?VKXIWA77zUs0TU+MJkLvWeXaGLUB5TtimvQDX28/ZCAsFgNvlg6ECD6HvpjK?=
 =?us-ascii?Q?kN4dYjrDF8ycTHq6E3ZuZWNlUn2n1VrzbF2ha7AvlvEquqvgIHwXyB63RxAw?=
 =?us-ascii?Q?mC+BG72lF79IZYmxUhMV3i8iMYhxi6f++PtNcntOx2+lnlA+tmLGZBgVoVPT?=
 =?us-ascii?Q?viDHbir0IGLKAGIB+n7qzvdAQFxuooL3M4XKmSXueATnhB4FeXakBCeXCxCn?=
 =?us-ascii?Q?/0GQF0td926bCkbSFhxc4CtTB0eC0I3tFCBZ/RN7M30Q2Y/5myZecb9B5j9x?=
 =?us-ascii?Q?ATP1UopN0Fbs8PbYx4ccJfgbFsSoyGnkXi2SOnh06dEC24K0Y3A53wYX1blI?=
 =?us-ascii?Q?YKInuZwnafa3dnY65Uu7oPLT1qpVJPdTcE+3oM42f8zCfcDlb3/2tjPl+lrX?=
 =?us-ascii?Q?qcvpHNw6gADROjCpn3Qmijp8RIMpl6TpUCCsAT3K7H/TVgxbOeF3WfL0P1BP?=
 =?us-ascii?Q?aI7pGFDAf43ec1pxOulcc7+yVYCcpWSmEDu9Da6rvqCytV9449XQb8wMdyEv?=
 =?us-ascii?Q?2NssYUvVM3szg0oakGF1u+PNoIHHbURCV0SaOgYZX9XGVewCQbqr/RcTb0GQ?=
 =?us-ascii?Q?chdpHL/ewJPyHi5mXHu1qabPuAgDa4BkkfZWZK6bvwulWM6tOXSsRZuXcrKv?=
 =?us-ascii?Q?ZKMzVfrSfPdlfY7uJODfEEmaP+mXaSKiWtkaWdXKBmX536ORs6/IeCiSqZvl?=
 =?us-ascii?Q?5/OoqmrhjulJu799C07+cKf2iDodubRlZiB0MgCy6N4/iUjAGXi5gPwvXtPB?=
 =?us-ascii?Q?rvpbVZJwUJMkSWHnzVffKZj9BRHHIJ9bltB2jT5kicrzHHnz1u/HCy4UMfAf?=
 =?us-ascii?Q?mENtSzDUnCQBRHRGo9G3thqignYHLPnLO2dHax8zCdw8dA3IOMEGK6UychWp?=
 =?us-ascii?Q?GfIEACics/w+/31si4ANsC73ZASi1w2rP4ghAT4fHbgPFu45VKKtbazVUh7C?=
 =?us-ascii?Q?kua2cBV38bEOWNjrzAMOPEQoCaHDbwROSK8o1BkLbjjBKg0CIjzd2YELdm8z?=
 =?us-ascii?Q?THU3KWUwv4kvbptmvxG/iO5a9Tt06f75ag/k3tB1eJhcOmWdwZdVM5qJRC/R?=
 =?us-ascii?Q?PkDJCsm/kvU62VAqjVEDkZR0s6HZNL0kRT39064K4JI6X5bjsTUjXyEoMty7?=
 =?us-ascii?Q?qj6r7atd9g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1343.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0950e5-4aa2-4d89-614d-08da1830c335
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 00:51:33.8199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9ThMO9BS1MbltmjKSxUcdyKdvOCWBaqKFuhUCAt8O3r7KluK251YZcoUsAgcoXBi/B0Ep4uLgoRZk8IEz1lfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1057
Subject: Re: [lttng-dev] CTF2-SPECRC-5.0
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
From: Aprameya Rao via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Aprameya Rao <Aprameya.Rao@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi

Is there a document that provides a diff between CTF1 and CTF2? 

Thanks
Aprameya

-----Original Message-----
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> On Behalf Of Philippe Proulx via lttng-dev
Sent: Wednesday, April 6, 2022 1:04 AM
To: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>; tracecompass-dev <tracecompass-dev@eclipse.org>
Subject: [EXTERNAL] [lttng-dev] CTF2-SPECRC-5.0

Hello,

This is an update of the CTF 2 specification release candidate from
v4.0 to v5.0.

This document, named CTF2-SPECRC-5.0, is available here:

    <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdiamon.org%2Fctf%2Ffiles%2FCTF2-SPECRC-5.0.html&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=A%2Fyq3aTYQqYaqpfvlL9k17oLOuYm6OxWLMryIKFZnIQ%3D&amp;reserved=0>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fefficios.com%2F&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=AhDC1Ux4VudGgiah363vlBDTOmHyc9yJXLH1ccE6Bz8%3D&amp;reserved=0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=04%7C01%7Caprameya.rao%40microsoft.com%7C4bfcea22579c423d02be08da173b38b1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847840395810150%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ORy9ounXHajWfDfpa6dkokRZC0pkIVJ6s2r0TL4tYr8%3D&amp;reserved=0
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
