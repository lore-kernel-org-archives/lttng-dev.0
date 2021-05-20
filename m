Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FBBC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:28:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C5D60FEE
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 08:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C5D60FEE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fm2vW35JFz1rFP;
	Thu, 20 May 2021 04:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621499336;
	bh=qbrF+tuKWgXIyyovYAEPZUV9vIae1kBQwUI5B2O77Io=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rPDywPEDzXEIQ8j1MbPB3QgFY8lFYDrdcdZVctkAr3a3P1CkFpGSloozFrfcBojCL
	 8QruoEmdZIHkVRgRvVK9ucB21hAb3/ju49jDle8Z9Chc307E/qbBE1LtcnxmsFeXtd
	 EXsnNn9ym4dKNEojfLebPm96kB+wElnmwd9La9nok6NhJn/OWR2yJ7J/cpEKs8DEno
	 O1PD1MNGVfql/T5UPIhSKTmSn4QmJqo6j/C2aat+ZXI59eC9QzUtdivbJQgzU0IKnF
	 6bJtiBCyJPg+DyUPdJl/lMwKh0NruOCfa4IMgFa2JVyO3mIstPtY3ZP+XbnD+q69yc
	 JFzyfmgHlWUgg==
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fm2vT3sj0z1rFM
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 04:28:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKdGGWiJHr4xT5KI+HarFFAJ6CErc/VXpWuxALz2EQ6vE3B/G7TGvfm65hXi98ZO/I8gTvjirsysxMRfS4/A8xVxdcRdhhSL1t31pkpH7NvInF25oXmgoy5RSgVQhUGyU6Yeg1eRgWzN4B5dkmM1YgHLc63pMLnHDq/T2+yXEh+DkkUJp1TT/vucsx14LfUzNOfA9WtxLmO8v0OlJZ4kLcwBvoxRgSgYjTySHQJ372lRHCHdoC2Q+QQXzckljHxlk1f1kzP7WOVvpv8fxHLmCknL8Zn713YGoEXH7YWlEfGWh9hnIwSmZdsGDzlns2oq0mhPYxRObqPknK8998JF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJvySztc7cw3mZYkdNZ9lVhalTdWjfbvP8IMzHDQCFU=;
 b=Oqkr3DcDylXj1qUlD/+XAG4w7aoDmUa0FlBdl8RggHc/4o+cqGguxuc7jcPXiVFQEF04OR4/2ZS544fyY/U5gWzTiy/6YevvmnOaULnUj6VUxuHJ1q8Srj4OdNZmTIuKeaajAm1y92OmvG8jpVUbwZAeRyrqOp0Cynhx68NzZ7TVJli7lfxH6OyGA9M63Tl4RtnncDEcPJL6UHgCq4M7Poy92aghBjvFwYSoKcsDJVHqM2CLEZy0+pMugkPniRsV0Qtmbarpvk42Iix+qFSD2fDugCG4e6zc0n8wiqo8SGL64DcBCrt0m36BMZZcWhO8Ujh8fWTClO6SmDaMaSU5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from AM7PR02MB6194.eurprd02.prod.outlook.com (2603:10a6:20b:1a5::14)
 by AS8PR02MB6536.eurprd02.prod.outlook.com (2603:10a6:20b:25d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 08:28:50 +0000
Received: from AM7PR02MB6194.eurprd02.prod.outlook.com
 ([fe80::49c3:b7c0:3c04:80f8]) by AM7PR02MB6194.eurprd02.prod.outlook.com
 ([fe80::49c3:b7c0:3c04:80f8%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 08:28:50 +0000
To: Norbert Lange <nolange79@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
Thread-Index: AQHXTK3+V6xPgg5JGUSEQZtxbA1QkarsCL+AgAAAvjk=
Date: Thu, 20 May 2021 08:28:50 +0000
Message-ID: <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>,
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
In-Reply-To: <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 917d5b94-fbae-4673-d58f-08d91b694ba2
x-ms-traffictypediagnostic: AS8PR02MB6536:
x-microsoft-antispam-prvs: <AS8PR02MB6536C3BBFC53E6E7EE87A0CCD12A9@AS8PR02MB6536.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fl6y2ThVac67hOEX9gRy/FHYgF+AgiFIZFoYBFKwu1Iu93oB5rM39qEUXdFcKpzXXuaJcobcaa6Mu/4DprVJPZUHQK7s62BrK1nk+lhI4FjEQKgADmxNF+cMMmNAcMzMuGdAXXL6syo8MjKCjvyanJRWwN+GbEI2fUi2LF1NUapoLqIjKIydt2uYdRooq8CmJLF6EMMMB5POv1BZiQvyChJMSMyorZmzS2k6r3P0yaT5WjCkyTb36AXbad8FCa9Us7yhnNaPsiSoeI0+yvUm2+LZTWBSv8T48nFn0Y2j2f+ARGTiU67IpyWgY44HDNlHTm1jTij3NuYbUmUIi7tmrTS7Qsgpv6CX3ih0xtoaN7rjvjZQbqEmzbo6tTwi7xyGd7GLw17P9ipnTaqoGb1UqhRera/VTiDERmeRZkXiu4bFqsBAEHwNXA84HP/IZl6/m/Yg6gjzdrgewn4PP4KLtVJYgTSL4xjoyZiAGsAEnu+OIMV4otjeXCl/SAUXDPvG+PWqNGi9r2WxdVeaVrOX9ADEdyhrElFTxAvjme/h3sT7m37nUwSlnsTKv500IyDxngmFFbG/1gwAP8rsbTF7DH0j+E2uWFTltw0+3Sc+Ziw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR02MB6194.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(346002)(396003)(136003)(366004)(8936002)(66946007)(316002)(86362001)(6506007)(76116006)(19627405001)(186003)(66446008)(91956017)(786003)(52536014)(71200400001)(83380400001)(66476007)(478600001)(55236004)(66556008)(64756008)(33656002)(38100700002)(5660300002)(9686003)(2906002)(6916009)(8676002)(55016002)(4326008)(7696005)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RvMGT6WL8vx1tppTNA5p4x8/9COMsx0BXgQR3Hm66KX/cRkUbea87ODX+p?=
 =?iso-8859-1?Q?sa11gwzWMPSRHyGtBfXxGH01xzpyVXG8mjOj4D5NV8XS2qHs3LjK5BdPSi?=
 =?iso-8859-1?Q?SevrYI8fbEvkAaTV8KTqVDpigaGu4lLm8W1Te6cdx3pOBXSgT+ZQ/LeEPk?=
 =?iso-8859-1?Q?Swn4gZXcwA+hAH04SdYvtPVngwjc7KdHeHR08L1oXbdF540/9n5ZUVQjsa?=
 =?iso-8859-1?Q?4g+WICj87ATsIw95MTfk0BWPdWOI8b1zvLfHos5Ltjior++G8U9Lwnbn3W?=
 =?iso-8859-1?Q?hsA3Wuf0AELnbDbM5IPPuxCpZknrOD6rLOdSSZWrjSeeFLMOO8KN7izxcf?=
 =?iso-8859-1?Q?aaEYh8o3HgBnjcZImlpYs5TUcgtlzJcNBGxCoT58mtLgWZxia1/3RCJ/DF?=
 =?iso-8859-1?Q?YiB08iVMjDSyudssTkScQdPdyuJwps2LSXqQwsIpXhj6AdEbLuElGQoXSA?=
 =?iso-8859-1?Q?YB8wZ2voXnqBZ4hklGKBKantrPs1TVb00y1ajSlmll+9iEaPeBONWkuKhq?=
 =?iso-8859-1?Q?PJClGk3xHqrsBFUjpEAIG+M6cPqBm/CIImnYaIHg744GXd/zHIbiBBN/oT?=
 =?iso-8859-1?Q?rvb5LhNNNq1EaegoLhKOllkWdgj0hK3zoH6B6Fzf2ggyiVYBKNsb1BnvRx?=
 =?iso-8859-1?Q?kD0jcpvc3gvMqKbBICEgvxoOawra6vT2dBOwRWO9Mov2zvRmsM6t+vZbKV?=
 =?iso-8859-1?Q?m/2+8e2Bvi/eaijMpmDN5i5nIRAPFCi791cxHijUZOk7D0NEznPWAwpHqX?=
 =?iso-8859-1?Q?aNFw2woWbLY39U1YsNVwxgSks9mGiF4WlEAl7dbjWzHEfq0SgBpsEmrLUU?=
 =?iso-8859-1?Q?A/aVOx4Zcbug6+Q+GiQAQiWmvvfexYvKU2CJ+c5Mqhu7uNm5e7Nh34QBDm?=
 =?iso-8859-1?Q?RqJ6162Yp//4D1bMRuEbk2GvFVJckpvyOpOk+XZokqMcLFEiRoAi4+BWb3?=
 =?iso-8859-1?Q?7cG5+b3Hx9JsJV1KTGB/fRv6p+pcUPc8whI+3DD1BT5pCdHWgYIvojuoNz?=
 =?iso-8859-1?Q?ANOiypSBI7GY3Y8hMbRFkxZxjGL9hwhO5kqBaVn2BJIb/tcbPbcDd1UqPP?=
 =?iso-8859-1?Q?wBP5big7STJKWj2peNv/tJyKh1xLNcLloTfs2m8WtPX48Vm1k/e9KiLE9l?=
 =?iso-8859-1?Q?jRWJ0U4qli7oRAdVWixh4+x9z8B23h8EfIfBi94kbpog2zdCVK3HiyABse?=
 =?iso-8859-1?Q?T/0myv8nwYkylfrLzd/Hrr6p/f8o1fUdu07TDp20v15Eo3FurOfSp64P7s?=
 =?iso-8859-1?Q?y628JvntOYLRmxn2jRJfdB91KISHDKrmuitYeDC6W7ENOt+a4GsntW+yNY?=
 =?iso-8859-1?Q?Cwaj784n9r6MDobUERfVFkLjfI5PZwk1LYFniUkIVxNFJ7Y=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6194.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917d5b94-fbae-4673-d58f-08d91b694ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 08:28:50.3576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzOtAapXQ7IbmWFhgt3+JRy7iJR0RjXWBePhYrNGycVnmG73RK2nRoB4JDUipFQsW+2aUbdWZtbdETyFbkUMXb8FDPv9I0E2NDqHpTE2Nkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6536
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
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
Content-Type: multipart/mixed; boundary="===============7721089565356983973=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7721089565356983973==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_AM7PR02MB6194C2E06B14077092AA06A0D12A9AM7PR02MB6194eurp_"

--_000_AM7PR02MB6194C2E06B14077092AA06A0D12A9AM7PR02MB6194eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Norbert,

Thank you for your answer !

Yes, I am using a Xenomai cobalt - xenomai is 3.1
cat /proc/xenomai/version =3D> 3.1

After the installation, I tested "test tools" in /proc/xenomai/ and it work=
ed nice.

What do you mean by "it might deadlock really good" ?

Cheers,


________________________________
De : Norbert Lange <nolange79@gmail.com>
Envoy=E9 : jeudi 20 mai 2021 10:20
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Objet : Re: [lttng-dev] LTTng - Xenomai : different results between timesta=
mp-lttng and rt_time_read()

Am Do., 20. Mai 2021 um 09:58 Uhr schrieb MONTET Julien via lttng-dev
<lttng-dev@lists.lttng.org>:
>
> Hi the developers !
>
> CONTEXT
> I am currently working on a Raspberry pi 3B with Xenomai and LTTng tools.
> Raspbian 10.9 Buster - kernel 4.19.85
> uname -a : Linux raspberrypi 4.19.85-v7+ #5 SMP PREEMPT Wed May 12 10:13:=
37
> Both tools are working, but I wonder about the accuracy of LTTng librarie=
s.
>
>
> METHOD
> The code used is quite simple, it is written with the alchemy skin.
> A rt_task_spawn calls a function that has rt_task_set_periodic(NULL, TM_N=
OW, period) and rt_task_wait_period(NULL).
> ->The rt_task_set_periodic is based on 1ms.
> ->The  rt_task_wait_period(NULL) is of course inside a while loop (see be=
low at the very end).
>
> My goal is to get accurate traces from Xenomai.
> I took two methods to do so :
> -> lttng
> -> basic calculation based on  rt_timer_read()
>
> What a surprise when I found both method have two different results.
> -> LTTng shows me traces [0.870;1.13] ms (or even less precise)
> -> rt_time_read shows me traces [0.980;1.020] ms
>
> Thing to note :
> -> The use of LTTng has no influence on rt_time_read(), you can use both =
methods at the same time.
>
> Then, I saved the output of rt_time_read inside a tracepoint.
> It appeared the LTTng is always called at the right time because the valu=
e got by rt_time_read () is really good.
>
>
> QUESTIONS
> These are now my questions :
> - What is the method I should trust ?
> - I have searched on the forum and I found LTTng uses a MONOTONIC clock f=
or the timestamp. Can/Should I modify it ?
>
>
> CODE
> -----------------------------------------------------------------------
> A small part of my function called by rt_task_spawn :
> [...]
>     RTIME period =3D 1000*1000; // in ns
>     RTIME now;
>     RTIME previous =3D 0;
>     RTIME duration;
> [...]
>  while(1)
>     {
>         overruns =3D 0;
>         err =3D rt_task_wait_period(&overruns);
>         now =3D rt_timer_read();
>         tracepoint(tp_provider, tracepoint_tick_ms, now, "tick");
>
>         if (previous !=3D 0)
>         {
>             duration=3Dnow-previous;
>             rt_printf("%llu\n \n", duration/1000);
>         }
>        previous=3Dnow;
>    [...]
> }

Are you using the Xenomai kernel ("Cobalt"), or just skins via
copperplate ("Mercury")?
You have some file /proc/xenomai/version?

The Xenomai kernel has his own clock, which in general is not
correlated to the linux monotonic clock.
(Under some circumstances it might be identical).

My plan is to use a clock plugin for Lttng, particularly because if
lttng uses the linux monotonic clock from a realtime thread
it might deadlock really good ;)

Norbert

--_000_AM7PR02MB6194C2E06B14077092AA06A0D12A9AM7PR02MB6194eurp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Norbert,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you for your answer !</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yes, I am using a Xenomai cobalt - xenomai is 3.1</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
cat
 /proc/xenomai/version =3D&gt; 3.1</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<br>
</span></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;">After the installation, I tested &quot;test tools&quot; in&nbsp;/proc/xe=
nomai/ and it worked nice.</span></font></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;"><br>
</span></font></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;">What do you mean by &quot;it might deadlock really good&quot; ?</span></=
font></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;"><br>
</span></font></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;">Cheers,</span></font></div>
<div style=3D""><font color=3D"#201f1e"><span style=3D"font-size: 14.6667px=
;"><br>
</span></font></div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> Norbert Lange &lt;nola=
nge79@gmail.com&gt;<br>
<b>Envoy=E9 :</b> jeudi 20 mai 2021 10:20<br>
<b>=C0 :</b> MONTET Julien &lt;julien.montet@reseau.eseo.fr&gt;<br>
<b>Cc&nbsp;:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt=
;<br>
<b>Objet :</b> Re: [lttng-dev] LTTng - Xenomai : different results between =
timestamp-lttng and rt_time_read()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am Do., 20. Mai 2021 um 09:58 Uhr schrieb MONTET J=
ulien via lttng-dev<br>
&lt;lttng-dev@lists.lttng.org&gt;:<br>
&gt;<br>
&gt; Hi the developers !<br>
&gt;<br>
&gt; CONTEXT<br>
&gt; I am currently working on a Raspberry pi 3B with Xenomai and LTTng too=
ls.<br>
&gt; Raspbian 10.9 Buster - kernel 4.19.85<br>
&gt; uname -a : Linux raspberrypi 4.19.85-v7+ #5 SMP PREEMPT Wed May 12 10:=
13:37<br>
&gt; Both tools are working, but I wonder about the accuracy of LTTng libra=
ries.<br>
&gt;<br>
&gt;<br>
&gt; METHOD<br>
&gt; The code used is quite simple, it is written with the alchemy skin.<br=
>
&gt; A rt_task_spawn calls a function that has rt_task_set_periodic(NULL, T=
M_NOW, period) and rt_task_wait_period(NULL).<br>
&gt; -&gt;The rt_task_set_periodic is based on 1ms.<br>
&gt; -&gt;The&nbsp; rt_task_wait_period(NULL) is of course inside a while l=
oop (see below at the very end).<br>
&gt;<br>
&gt; My goal is to get accurate traces from Xenomai.<br>
&gt; I took two methods to do so :<br>
&gt; -&gt; lttng<br>
&gt; -&gt; basic calculation based on&nbsp; rt_timer_read()<br>
&gt;<br>
&gt; What a surprise when I found both method have two different results.<b=
r>
&gt; -&gt; LTTng shows me traces [0.870;1.13] ms (or even less precise)<br>
&gt; -&gt; rt_time_read shows me traces [0.980;1.020] ms<br>
&gt;<br>
&gt; Thing to note :<br>
&gt; -&gt; The use of LTTng has no influence on rt_time_read(), you can use=
 both methods at the same time.<br>
&gt;<br>
&gt; Then, I saved the output of rt_time_read inside a tracepoint.<br>
&gt; It appeared the LTTng is always called at the right time because the v=
alue got by rt_time_read () is really good.<br>
&gt;<br>
&gt;<br>
&gt; QUESTIONS<br>
&gt; These are now my questions :<br>
&gt; - What is the method I should trust ?<br>
&gt; - I have searched on the forum and I found LTTng uses a MONOTONIC cloc=
k for the timestamp. Can/Should I modify it ?<br>
&gt;<br>
&gt;<br>
&gt; CODE<br>
&gt; ----------------------------------------------------------------------=
-<br>
&gt; A small part of my function called by rt_task_spawn :<br>
&gt; [...]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; RTIME period =3D 1000*1000; // in ns<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; RTIME now;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; RTIME previous =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; RTIME duration;<br>
&gt; [...]<br>
&gt;&nbsp; while(1)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; overruns =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_task_wait_p=
eriod(&amp;overruns);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; now =3D rt_timer_read(=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tracepoint(tp_provider=
, tracepoint_tick_ms, now, &quot;tick&quot;);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (previous !=3D 0)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; duration=3Dnow-previous;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; rt_printf(&quot;%llu\n \n&quot;, duration/1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; previous=3Dnow;<br>
&gt;&nbsp;&nbsp;&nbsp; [...]<br>
&gt; }<br>
<br>
Are you using the Xenomai kernel (&quot;Cobalt&quot;), or just skins via<br=
>
copperplate (&quot;Mercury&quot;)?<br>
You have some file /proc/xenomai/version?<br>
<br>
The Xenomai kernel has his own clock, which in general is not<br>
correlated to the linux monotonic clock.<br>
(Under some circumstances it might be identical).<br>
<br>
My plan is to use a clock plugin for Lttng, particularly because if<br>
lttng uses the linux monotonic clock from a realtime thread<br>
it might deadlock really good ;)<br>
<br>
Norbert<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM7PR02MB6194C2E06B14077092AA06A0D12A9AM7PR02MB6194eurp_--

--===============7721089565356983973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7721089565356983973==--
