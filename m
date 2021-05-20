Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D694C43461
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 07:58:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA4A61001
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 07:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA4A61001
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm2DQ2ylGz1rNQ;
	Thu, 20 May 2021 03:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621497511;
	bh=lfRxCA1QHJXn4qpwufdAXcWtaXla6trv/9ewc7tYsx8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=yvo31yTZYiMhRS67mlp1Yi3su3/0m/qar7v+XAhqZMJMHAOok1wtFVwqYv4TtCZjT
	 UB7AaZ6wboDZy5p5hQlL4oyPoXgQnL3zMd5uxZ+jJAY6bCxh/ZK1QlotRs/iaz8aiC
	 jCMgV3YX6OcVmNHWfB/kOvRjK1qZbAh1WiYGMJWShwuUd1C8aaydYIKjBKJWdVCRQo
	 UxWkZLi4RVdxsH1IVadLFB8VJchIYKKQOVY62RTKc8m5/KdeQif/Z74U2Lwga1rAei
	 U687HaniUaP52M6COjUN1SeGAv/MfyeU5NV+1sxCwI4k0gjFrYrCwPxeiz50L4gM53
	 65XZ9YCNty6bg==
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm2DM1Yqqz1rYG
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 03:58:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il/a0kASBZ1pwMLVPICPDorHqCrKXrTANq4Q0UpTbZe/ten2B69bHswopGHXuAZAK4M5Jmx55W5nFhgYjCy8z/J74bzZbFY+Mu7qLNCcLULxQ25gaGMTlCZXGxhvEsTqO8Zz0ewF4YztIbLni+NjD4hF1JsDHcaJXA2MUeysrfuA9EAnV6CyYQvcrVNp5HQY0v9jh2jKj+/c+h4Sc8BMY8BNQ4YGl0M6HcBjiDVh2T8Hyw49ukZ8vJyDPPQOTmV3uS5Uhq7o/phcKbSmESYrnlCLcAjIe3l6u86nKqXgV4Bd6xLtrsD4uiNtUdRrmsGJ4dQ6kvVTJD3orkt2wlboaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3ZEmwn2BZkWBzLAz4B6WEBt6K+8ZKnIQF2Layr4nNY=;
 b=XwHkTStyfngpRKIi95NT2CkKGSqJ9B6ZIswLlv/Ncsg5NDhIbHsDt2tEjd92gCxR5RuuRR9GfjzmhJLSkrw78s+3D5p7G6BN0hSXwPnsVzxkqicg4WdxhWHm1Pg86kbOh0JRtKLD+GMyqIAg0xYH9/mzv0KGfW1BDByvw/85RLEuwLCEp55mbhqpg8rPVIGqJwZHXLbZAlZKjjVeh7ONPTSA3IgaAVLuIrBn2aqP+jr65HoT+3bZqdw448JdZbTci2xZ/D0C3y7/rFjYc2nPoekoDqDhjRgi+Jq2598RYmaP0loS0uYkklRIZPaOhQmiWvj4Wb3hq+6ZfXsi/+sWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from AM7PR02MB6194.eurprd02.prod.outlook.com (2603:10a6:20b:1a5::14)
 by AM7PR02MB5986.eurprd02.prod.outlook.com (2603:10a6:20b:18f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 07:58:21 +0000
Received: from AM7PR02MB6194.eurprd02.prod.outlook.com
 ([fe80::49c3:b7c0:3c04:80f8]) by AM7PR02MB6194.eurprd02.prod.outlook.com
 ([fe80::49c3:b7c0:3c04:80f8%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 07:58:21 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng - Xenomai : different results between timestamp-lttng and
 rt_time_read()
Thread-Index: AQHXTK3+V6xPgg5JGUSEQZtxbA1QkQ==
Date: Thu, 20 May 2021 07:58:20 +0000
Message-ID: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cea0365-b3ff-40ba-8f38-08d91b650939
x-ms-traffictypediagnostic: AM7PR02MB5986:
x-microsoft-antispam-prvs: <AM7PR02MB598655A97F5E31BD558C3DEBD12A9@AM7PR02MB5986.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T598IP713IliY+u6NYpwzSHfp5MfcIkIjQI2oUCaqkVzYsF4WgGIIS3PvkoS4PPpWxwY6CORuevMLA9gLa5nev9mUDEq42PbkdK+t0SF65PMLbo1iT2jAgCd/B1C0QyqNQlySAgm9rklO24r6/yfZvBR9C49hQUm9IHZ3FKVS/nFzcMqiqutQWyanA2GylLm7YJG2u8MkvOCHcKFr+Duh6UCNDm2IZ2nA6WJ4sbwSi5m/RSPl1JrdC4FdUG7xAGtjL1ZP1PdT7lWbAF6IHj1F7hXex4DWwJS544ku/mS2r4HxbUL0bNGUJmOqvA2GR3qDAO/TvzzZbs1+m75B4iiojqH+AUp0vSu0omIWudH7Qo4RtXQS9KpETY+nqnN3HMG6GhtXGdV747Asdj5IKZW0j2dG+DkCDIJXN59wafSE4mRPTaBR3GwKxqEmyux/+lRiTVF4Q7hbHwBQIbLjHhJ5IBVLeOxofaAausrsjTThTUjGGvU1f1LI4+bkX7XA/Tt/JbkEaW4rVkyiev6anhk0LROWhxB4ULkVKfz2PaD8e6XBXFAcySB81HrMxarDjlIFE2E42QJA1nSdk3CyVkTyuavwwIpYPf6hH1eF2gjdVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR02MB6194.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(376002)(366004)(346002)(396003)(6512007)(83380400001)(86362001)(478600001)(9686003)(71200400001)(6486002)(6506007)(52536014)(38100700002)(19627405001)(66476007)(66556008)(66446008)(64756008)(76116006)(91956017)(66946007)(55236004)(8936002)(5660300002)(26005)(8676002)(6916009)(786003)(316002)(33656002)(2906002)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SgbTs5oKU8v0h1ag8niVXH9fJ+1Viudo7M8fA9ANp76jQ5PzSzxF+MmqcM?=
 =?iso-8859-1?Q?luWrdQRQ7h40lrD6vUPDcDfUoflj/Cns10LQitY8U98PRuEVzDeN5BWcu4?=
 =?iso-8859-1?Q?TmEpsVL+uILce5EsuQ1q7kreeYctq9/aM+5NIBx4GC4F0z/EkPiBd04D8V?=
 =?iso-8859-1?Q?6BwMuYLKCxEdIRXY/k6PCx6sgUqms4hxO3qsRE32MrS5VQQKgcV7y52cPj?=
 =?iso-8859-1?Q?JZtYYYZh+wTXLFuXeSMLlRKchNjXYLHypcHN2RTcEAc6M0BbW1XEjdKM/n?=
 =?iso-8859-1?Q?1lhN/uX7CnfyUChLNLGwybO2NQVgjP20ZlWPDPdo8Rbd9dRhA3dIdzi8fb?=
 =?iso-8859-1?Q?R2tlAaFYFDWocYN5qFLiNCRnBLJmAXlu3Mjtx71fc+hLzS7War9AmbJsYM?=
 =?iso-8859-1?Q?OSGkAUYByfKIBNEvr4L+4XNOeGCupheh+rS6egDY5gtrSto8OwZKq49/dy?=
 =?iso-8859-1?Q?a7E1J9+taTY21XqaWyx83gETnvrKnpVG9oWOSzliTU5c9lpnFqH0iyorB6?=
 =?iso-8859-1?Q?trhqwA5QDD1RTDMNA9RKs5CqqUcGlFWTLfitAOc3QJRAxlXtkwSwwqE9Gv?=
 =?iso-8859-1?Q?Xbte3bp3LaBB1WUOzK1Cor3CMSbUnm03vUCrRtXap6pLwcLGuIHlmNCKU8?=
 =?iso-8859-1?Q?ofYB0AjvKpFrBwgX/SAWVDHUqfJSDl3c5Q24H+pEcbIavhsbe/qd+DhzQ0?=
 =?iso-8859-1?Q?aYdxuuDHAoycZaRjcV5pG2fR4aYCF8ClTNXXO8R7dTqhUCqBG5rpth13uc?=
 =?iso-8859-1?Q?2ZSwQ1YtSA8n4NkiFR76hE1tF1WxLYdkMQdtzQnQxl2oTPkxECMXuXoOOp?=
 =?iso-8859-1?Q?h/KK1KTBKjR/wtFaM/vviHXpMeOH4FsY3IqIyFndVvI+nRbWG5rTFu8E9n?=
 =?iso-8859-1?Q?7HjeneoE3X5wwNVzOQhHfllu6jjrBqoypsnmavbBR/MjIQ5V6sK52n/9pe?=
 =?iso-8859-1?Q?9bapecEFLnzw4i2U245LyfbVdohEpzEymFp1K2mpmA8oMFRDX7jZtLvMwf?=
 =?iso-8859-1?Q?He9SYz/Cu9kMvgTL/dO8GFVb704beq1ZeynIDrMgx5mlEBEU2bwE/dWeBu?=
 =?iso-8859-1?Q?4Um3961KuFc8dUbZcXynS17OQMPK32Gc/PvDPEdOVXSrmiONI2UUduZwub?=
 =?iso-8859-1?Q?JjR3svm4c/oka3VKiUyZQsxSwtCYQJW8BSRCL/NlFlbwNxQUbeZnudjMKQ?=
 =?iso-8859-1?Q?1PdNk8D7FPP2ZU8GG4FTgPKsg9kLU5Jt3KnMsq4wQbXPc0oa0eMRG9IRLZ?=
 =?iso-8859-1?Q?XW3irA3Elcc8WGVWtnZVPQFz71iZ1HiYPW7VT97dxa8JNtV+X7YGktcugJ?=
 =?iso-8859-1?Q?w9mDiemOENIeVvFoZ2fY/UddnesWIyPPh1UXyme5Gog/mtY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6194.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cea0365-b3ff-40ba-8f38-08d91b650939
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 07:58:20.9591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaZhctMnMsBTPX41FsGvnhoeiQJBsbRT/noSF6usj35wRV5Z1CVF1uADTfGfAZcgsTFey6Uiz4VV/NhV8FxNLMpc8RRcTIZnoel4i9nYUbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5986
Subject: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============3751622801301347410=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3751622801301347410==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB6202C5373D6CECC72EBF45DAD12B9PR3PR02MB6202eurp_"

--_000_PR3PR02MB6202C5373D6CECC72EBF45DAD12B9PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi the developers !

CONTEXT
I am currently working on a Raspberry pi 3B with Xenomai and LTTng tools.
Raspbian 10.9 Buster - kernel 4.19.85
uname -a : Linux raspberrypi 4.19.85-v7+ #5 SMP PREEMPT Wed May 12 10:13:37
Both tools are working, but I wonder about the accuracy of LTTng libraries.


METHOD
The code used is quite simple, it is written with the alchemy skin.
A rt_task_spawn calls a function that has rt_task_set_periodic(NULL, TM_NOW=
, period) and rt_task_wait_period(NULL).
->The rt_task_set_periodic is based on 1ms.
->The  rt_task_wait_period(NULL) is of course inside a while loop (see belo=
w at the very end).

My goal is to get accurate traces from Xenomai.
I took two methods to do so :
-> lttng
-> basic calculation based on  rt_timer_read()

What a surprise when I found both method have two different results.
-> LTTng shows me traces [0.870;1.13] ms (or even less precise)
-> rt_time_read shows me traces [0.980;1.020] ms

Thing to note :
-> The use of LTTng has no influence on rt_time_read(), you can use both me=
thods at the same time.

Then, I saved the output of rt_time_read inside a tracepoint.
It appeared the LTTng is always called at the right time because the value =
got by rt_time_read () is really good.


QUESTIONS
These are now my questions :
- What is the method I should trust ?
- I have searched on the forum and I found LTTng uses a MONOTONIC clock for=
 the timestamp. Can/Should I modify it ?


CODE
-----------------------------------------------------------------------
A small part of my function called by rt_task_spawn :
[...]
    RTIME period =3D 1000*1000; // in ns
    RTIME now;
    RTIME previous =3D 0;
    RTIME duration;
[...]
 while(1)
    {
        overruns =3D 0;
        err =3D rt_task_wait_period(&overruns);
        now =3D rt_timer_read();
        tracepoint(tp_provider, tracepoint_tick_ms, now, "tick");

        if (previous !=3D 0)
        {
            duration=3Dnow-previous;
            rt_printf("%llu\n \n", duration/1000);
        }
       previous=3Dnow;
   [...]
}
------------------------------------------------------------------------

Regards,

Julien

--_000_PR3PR02MB6202C5373D6CECC72EBF45DAD12B9PR3PR02MB6202eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi the developers !</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
CONTEXT</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I am currently working on a Raspberry pi 3B with Xenomai and LTTng tools.</=
div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Raspbian 10.9 Buster - kernel 4.19.85</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">uname -a :&nbsp;Linux raspberrypi 4.19.85-v7+ #5 SMP PREEMPT Wed May 12 =
10:13:37</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div style=3D"margin:0px; font-size:12pt">Both tools are working, but I won=
der about the accuracy of LTTng libraries.</div>
<div style=3D"margin:0px; font-size:12pt"><br>
</div>
<div style=3D"margin:0px; font-size:12pt"><br>
</div>
<div style=3D"margin:0px; font-size:12pt">METHOD</div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
The code used is quite simple, it is written with the alchemy skin.</span><=
/div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
A&nbsp;</span><span style=3D"font-size: 12pt;">rt_task_spawn calls a functi=
on that has rt_task_set_periodic(NULL, TM_NOW, period) and rt_task_wait_per=
iod(NULL).&nbsp;</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
-&gt;The&nbsp;<span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important">rt_task_set_periodic is based on 1ms.</span></span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
-&gt;The&nbsp;<span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important"><span>&nbsp;</span>rt_task_wait_period(NULL) is of course =
inside a while loop (see below at the very end)</span>.</span><br>
</div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<br>
</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
My goal is to get accurate traces from Xenomai.</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
I took two methods to do so :&nbsp;</span></div>
<div style=3D"margin:0px; font-size:12pt">
<div><span style=3D"font-size: 12pt;">-&gt; lttng</span></div>
<div><span style=3D"font-size: 12pt;">-&gt; basic calculation based on&nbsp=
;<span style=3D"text-align:start;background-color:rgb(255, 255, 255);displa=
y:inline !important"><span>&nbsp;</span>rt_timer_read()</span></span></div>
<div><span style=3D"font-size: 12pt;"><span style=3D"text-align:start;backg=
round-color:rgb(255, 255, 255);display:inline !important"><br>
</span></span></div>
<div><span style=3D"font-size: 12pt;"><span style=3D"text-align:start;backg=
round-color:rgb(255, 255, 255);display:inline !important"><span style=3D"ba=
ckground-color:rgb(255, 255, 255);display:inline !important">What a surpris=
e when I found both method have two different
 results.</span></span></span></div>
<div>-&gt; LTTng shows me traces [0.870;1.13] ms (or even less precise)</di=
v>
<div>-&gt; rt_time_read shows me traces [0.980;1.020] ms</div>
<div><br>
</div>
<div>Thing to note :&nbsp;</div>
<div>-&gt; The use of LTTng has no influence on rt_time_read(), you can use=
 both methods at the same time.</div>
<div><br>
</div>
<div>Then, I saved the output of&nbsp;<span style=3D"background-color:rgb(2=
55, 255, 255);display:inline !important">rt_time_read inside a tracepoint.<=
/span></div>
<div><span style=3D"background-color:rgb(255, 255, 255);display:inline !imp=
ortant"><span>It appeared the LTTng is always called at the right time beca=
use the value got by&nbsp;<span style=3D"background-color:rgb(255, 255, 255=
);display:inline !important">rt_time_read<span>&nbsp;()
 is really good.</span></span></span></span></div>
<div><span style=3D"background-color:rgb(255, 255, 255);display:inline !imp=
ortant"><span><span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important"><span><br>
</span></span></span></span></div>
<div><span style=3D"background-color:rgb(255, 255, 255);display:inline !imp=
ortant"><span><span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important"><span><br>
</span></span></span></span></div>
<div><span style=3D"background-color:rgb(255, 255, 255);display:inline !imp=
ortant"><span><span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important"><span>QUESTIONS</span></span></span></span></div>
<div>These are now my questions :</div>
<div>- What is the method I should trust ?</div>
<div>- I have searched on the forum and I found LTTng uses a MONOTONIC cloc=
k for the timestamp. Can/Should I modify it ?</div>
</div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<br>
</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<br>
</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
CODE</span></div>
<div style=3D"margin:0px; font-size:12pt">---------------------------------=
--------------------------------------</div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt">A small part of my function calle=
d by&nbsp;<span style=3D"margin:0px;background-color:rgb(255, 255, 255);dis=
play:inline !important">rt_task_spawn<span style=3D"margin:0px">&nbsp;:</sp=
an></span></span>
<div style=3D"margin:0px;font-size:12pt">[...]</div>
<div style=3D"margin:0px;font-size:12pt">&nbsp; &nbsp; RTIME period =3D 100=
0*1000; // in ns
<div style=3D"margin:0px">&nbsp; &nbsp; RTIME now;</div>
<div style=3D"margin:0px">&nbsp; &nbsp; RTIME previous =3D 0;</div>
&nbsp; &nbsp; RTIME duration;<br>
</div>
<div style=3D"margin:0px;font-size:12pt">[...]</div>
<div style=3D"margin:0px;font-size:12pt">&nbsp;while(1)
<div style=3D"margin:0px">&nbsp; &nbsp; {</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; overruns =3D 0;</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; err =3D rt_task_wait_=
period(&amp;overruns);</div>
<div style=3D"margin:0px"><span style=3D"background-color:rgb(255, 255, 255=
);display:inline !important">&nbsp; &nbsp; &nbsp; &nbsp; now =3D rt_timer_r=
ead();</span><br>
</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; tracepoint(tp_provide=
r, tracepoint_tick_ms, now, &quot;tick&quot;);</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; </div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; if (previous !=3D 0)<=
/div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; {</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; duratio=
n=3Dnow-previous;</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rt_prin=
tf(&quot;%llu\n \n&quot;, duration/1000);</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"margin:0px">&nbsp; &nbsp; &nbsp; &nbsp;previous=3Dnow;</div>
&nbsp; &nbsp;[...]<br>
</div>
<span style=3D"margin:0px;font-size:12pt">}</span><br>
</span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt">---------------------------------=
---------------------------------------</span></span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt"><br>
</span></span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt">Regards,</span></span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt"><br>
</span></span></div>
<div style=3D"margin:0px; font-size:12pt"><span style=3D"font-size: 12pt;">=
<span style=3D"margin:0px;font-size:12pt">Julien</span></span></div>
<span style=3D"margin:0px; font-size:12pt"></span></div>
</body>
</html>

--_000_PR3PR02MB6202C5373D6CECC72EBF45DAD12B9PR3PR02MB6202eurp_--

--===============3751622801301347410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3751622801301347410==--
