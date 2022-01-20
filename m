Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B04C433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 15:38:11 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Jfmqk2HLSzKZS;
	Thu, 20 Jan 2022 10:38:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642693090;
	bh=l1Ogb1xE2YHrAvh+7ByW7OEGzofdmtFheAg7gqVoKVM=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NlPSFBAFIshR9Gf17SVIStrC9Flfvg+8+63bcVEEcIw2FoWgJcKJHayrqgrcTAqh6
	 rPipowUiWNLNfKaHQldSW90Fm25B+SNg8+TcoPRSoPdrZ3/KT9QUo2GTXR2udtnF34
	 Xof7JY6aERNn2+ihYrAyING35AHHLueKY2J37EbZwfR9pu5V6zv+se0CHaAHgney8L
	 J0PfHa/FKlszjLOpoGWm4uKSPHsDi1ow8YoDYdP283VF+766foGCz7MawN2aLm83Zz
	 BW/RUEtcYJQx4ebsyuGHUCwDH7Inm1MB3Mnjlf6JHfPgygGSAWeUNCvnVkuYb2yDsQ
	 YUQIrYBORK8Yw==
Received: from CAN01-TO1-obe.outbound.protection.outlook.com
 (mail-to1can01on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5d::60f])
 by lists.lttng.org (Postfix) with ESMTPS id 4Jfmng45PDzKgQ
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:36:22 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFdfv6cXxJnat7tY3g2GhzUe2hvob4aNW7IFlyEcF13bHbIJFg44HC5pffEcQ2wSZxZ0xvcBnUoRXzqlo7wiBbNquFKMwVT1ORDHnJcs4OJa+069jXR8jAEeGZtGx8KqNKJchDpHzfeGWoUnVzYfJnSPkDvkohi5KP2Oyehtw5C3tYVg17pOBdgboTBe4nG0F4uOVg33ATCW+cHpRgrSDuwXELWgMQmiI+zaXlbTUZCwPhGS3F7bHZv5wR0zAgcbi1yG7Aa3jC7RaFVpJiG1/yYGSMRW8PXyLvjuF6MkteDwvmy7g2bATSFbKn6tNB4zAOtJ7WRQG18DpulSYyXx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DswAoaW9+xVKXvn1Fl0pyJsO4JdU7zvmc/gHoP0QGjk=;
 b=PL3RMFwgI8zIMLJTPUdphUsmooZPmmkMsnUwUsl77D6A5GnRCry2i3YxRv5LWtjC/mW8yZAOcZlm3Sp8zJb/Z6Us7CNtVpPu6acAx6Mi9PeLUwRJYTvmcfJ3Lu6OKquF7dACZbmJSHltVTyGxCzK7oRyhROQk1Vm4ndWBashBXo4Oxfg/u71CNE11lqaxEsJU4sMjXHxX98amzeHgVFumUxyBwsc5d41KKphzfjmwjzdFqlxFeBN1BLxtDvhkQxmIQyCegIYFxD5SvE/isJ+PaXwqJmLyv8lguD/qqRh/L4rNmzb728R4kI/X62I/HGZDSVuN3myUl4WedpxUYP43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::21)
 by YT2PR01MB8549.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 15:36:20 +0000
Received: from YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e1af:b1b:25f8:3f6d]) by YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e1af:b1b:25f8:3f6d%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 15:36:20 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Jeremie Galarneau <jgalar@efficios.com>, Jonathan Rajotte-Julien
 <joraj@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: Transfer of LTTng copyright ownership: Olivier Cotte
Thread-Index: MdjTM5J+pJqA6C4FQZzeZ6aa9M8Czv51v1Bf
Date: Thu, 20 Jan 2022 15:36:20 +0000
Message-ID: <YQXPR01MB2712147C9653E6026971BAACAE5A9@YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM>
References: <1338660677.61818.1642692030254.JavaMail.zimbra@efficios.com>
In-Reply-To: <1338660677.61818.1642692030254.JavaMail.zimbra@efficios.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8f683140-9262-f156-2e1b-2b8956e43bce
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0d21a52-47cd-4cdd-432b-08d9dc2a9ba4
x-ms-traffictypediagnostic: YT2PR01MB8549:EE_
x-microsoft-antispam-prvs: <YT2PR01MB85491E2EA9FB180AA4909396AE5A9@YT2PR01MB8549.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faCVY6tzEPcaghHUPIX++D0DpJYjHRor4qYdzUxIjz5oMFZVfq2Gpc45SywP58zXz6WzZQTjOFWn/vFMj9JVGT8/V2ZBsmv5yI8Qzp0QlUqsz4DeteIoHzH7lwdx1llPFVkx757iXpoNGMwu+dyJBWti2y0T5Fo0K7LOc84T4Ww1wTUK85pZ6/dRa58hBSPldhJkgRJ3bFwJhGdwS2CSnYlpcHatjXLh5jM3Yc1mLt/b3KAV6FzHhrqWfURl0dTv/c6fQ5A4qnAVVhl0R6kIgiS9QzKv5z0oCZBjuaHW01QD8dFXSeFD+eqxdmgfiuN60VUw6m5gWQEi9nUVd9Ns28lriSmKaiRoGX/PkPw3CQu1+mFJmOGmcXFFs7fb4ZPdlgfItwUn5h79PW41TxgbP6zvnUCsCTj+MLz02sa5dVck1WWXZd2qDgxYxNpUG7pL9z2jRlWA0G51H36Da2APu5rmS/kMakCMfymE4Jhreh56nofzSGN3Yi9x/h9dRy/XmcmK+m38itd/Y2tikKf2/7vGelAiMoQfMroqiMtU5uI7cVHxCsM8baDxkMnJUIySIsaygiec04tM8HKTjgwloyTrs4MuhSmK/ir7bRLA7zi5TOkULvqlV4LfIJNAXwu1F2I6wkT5sUrqJDxBPhJozv8J0XSWVGgeEhlmXs2PFLhodyf/lI1KKp8LkAwxZ5dJoXUeaHrD7LiwSAq1EDXHh9HIYC1gwS/iqIoy9Rrr7amxHM3jmw5VT4z9hz1sGQz61BF/gIOSCfhlga/hST0IafOwzMlmlULnXaUJlQZffDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(19627405001)(316002)(966005)(7696005)(4744005)(55236004)(52536014)(55016003)(6916009)(8676002)(53546011)(6506007)(186003)(2906002)(33656002)(38070700005)(66446008)(66556008)(64756008)(66476007)(83380400001)(86362001)(71200400001)(8936002)(38100700002)(54906003)(76116006)(786003)(5660300002)(4326008)(66946007)(9686003)(122000001)(166002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c4ox6dkGxicbtW6tsEyM6jnkoiGt48FtfS+9+s00dMt/5z/vhKf0gOkRJs6T?=
 =?us-ascii?Q?KSiFJfWJ7QGqYVNbbjDZkzGC4WppTyvnuGCd/ZOGIdC1SON9KizbrFaVSDMZ?=
 =?us-ascii?Q?wU6tAY5JP67+GjH5luxWVvzJvk/z529q68uLLh03XxRoPswj0ghZ3NSMgGet?=
 =?us-ascii?Q?35vGZkzG7fGeesneJDS57Ui7PtluU0EE1eOE8AS6YN3C1MryaWpqCfyRNoLJ?=
 =?us-ascii?Q?yFcpKE3uaEyWnFPIIlkF5/QphvO3igznFOXU4HWoaxoSSt8KKKYQ3tiCz6wr?=
 =?us-ascii?Q?3OQIiyuWgm/FDCHV8PCOFPccMXGwQP15T1X5X8sqRZh8yalugINbBOn0Db6G?=
 =?us-ascii?Q?mP5nYdpGiH+0r7cv/qJ2VC5IDfVMJDLky9mjK81J7Bi0jMHGA79M0Hxm4HiO?=
 =?us-ascii?Q?jl216TcNp0Ds8IIY0iGxZgt9I6sVbIZH0ga11xv4C5S7Q3D5kmWxs7dlvMNa?=
 =?us-ascii?Q?6M84CTM/D+BTOvWUtZADid3wOHm5keRNz9j1g9wXyli31bxagiMhP+0eWQRl?=
 =?us-ascii?Q?3VVH4QhzUi1L3Uh7X6/mb+V0lLKvKy2eRVMuapxDp2rjVU8D0JjlAla3c41U?=
 =?us-ascii?Q?bh+0XarvMad/2Mh0u5ndLp4MMbGRKyeHkzhUAsONs5n1g4euRJoMiWdzjnvQ?=
 =?us-ascii?Q?qndDeMxqR6SYxuAyYUCjQpqTaryfDCwbYpktQvoiLDF91iekPtKyvSZPggXg?=
 =?us-ascii?Q?ttfYEofDzyDA84vQX8w+R/AoJEu77rFP6syj+WKQTeCiAWJhnjX5H3+M8UeC?=
 =?us-ascii?Q?ZDPbvh/AefvP2vztt+dfMF8j1sHYnZipJNWxckJo30CW8Gl6QIoOfluLJOl3?=
 =?us-ascii?Q?LpwPQ+4s/qbqD+DEexNCpD2WvGt7taMI0C3kWn11Td5Dwsfdh+lhIH1r8lVd?=
 =?us-ascii?Q?BorS5exOmh9X4hJv8TzzI+Lpn0ycxEIja31FGHsVqMUW3lKF9ZUHPdPVdf2i?=
 =?us-ascii?Q?RnegzlT0e1XiMAQOJABf/OJiI1tqm07ZjeSTsMwMqMF0XhArcG4yW3u7gaHy?=
 =?us-ascii?Q?mKGq8QHThHlEY3OPHd0Zha/HhEJ7f4Zz4cs/HaO9wNwuKWqU0YmgDAB77r0c?=
 =?us-ascii?Q?+VYwqpwu1XSZkne+soL8AarLHY59xap+9gj1HdJomXqF8qd4etO1P1aOxwS7?=
 =?us-ascii?Q?aci/QbXt8Z6EevEO87yVmI5vZtrXokUS77dj2KX1xswSwIvPcQA4lpyEtYxG?=
 =?us-ascii?Q?7FZhIADeEpHfsGs9U/fPKY6/K7EHJ6dyuZWhSVam/GlfT3y1Vso3xJWi+174?=
 =?us-ascii?Q?okWB0Gh4CccX3jAPA5I4XWAJd675VCoXtmiQdXQIcVhw4YH1I6wOa57QwpS2?=
 =?us-ascii?Q?mdVLgDhZTgxe0pILyWnTFNcpuqus4nCdkluUYYZx2Z9t5/Pzal3j30X7KfAL?=
 =?us-ascii?Q?nNnou87VSGB7R2msEJg7QDo6ipNBJTXZs90T8Y63sqzkn2PUmvorG5CdT6xK?=
 =?us-ascii?Q?R9ABnDUNTNAkIxp4OCk/LVklFGg7PBJGblhELsDuOWJ5F/bRkH1V8C+FVHhj?=
 =?us-ascii?Q?CWiDAFKI3B+LjuQdirzc8JgBzIilOYg0H5W073N4A7w1P1TN5hkj7AWBjXcn?=
 =?us-ascii?Q?2+ndjvqEhDN2/beCNnUENnDkZz0C/QYIFgRrdi/CeH8trNml13aD9JyI0+oM?=
 =?us-ascii?Q?PJ01AWE6lVVWpfiOxvBnpDw5MiEK/6zi+2Z+Q124sd7jO4S0EuA4/bLcPXX+?=
 =?us-ascii?Q?Y3Q99yg4QMITUu4XqOeu61NcfKmxBL0VjqayYiG9zdJDNhkE?=
MIME-Version: 1.0
X-OriginatorOrg: mail.mcgill.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d21a52-47cd-4cdd-432b-08d9dc2a9ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 15:36:20.6825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd319671-52e7-4a68-afa9-fcf8f89f09ea
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70LDcq0QvWkGsYAUevoS82EQSQMjgw+/qf5Vj4N8BJF1+LAIDMQebpTe+Lo9x8O+UoJJWdpOBl8u2YArB4fpbEHYiqUI7VmGjS3ftPlfhEI24IwU4shPRELf1BUfb0sW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8549
X-Mailman-Approved-At: Thu, 20 Jan 2022 10:38:09 -0500
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Olivier Cotte
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Moussavou Cotte via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Moussavou Cotte <olivier.moussavoucotte@mail.mcgill.ca>
Content-Type: multipart/mixed; boundary="===============1684614268346836928=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1684614268346836928==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YQXPR01MB2712147C9653E6026971BAACAE5A9YQXPR01MB2712CANP_"

--_000_YQXPR01MB2712147C9653E6026971BAACAE5A9YQXPR01MB2712CANP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I see no inconvienecne into transfering the license to EfficiOS Inc.

Wish you all best of luck with this work,

Best,
Olivier
________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: January 20, 2022 11:20 AM
To: Olivier Moussavou Cotte <olivier.moussavoucotte@mail.mcgill.ca>
Cc: Jeremie Galarneau <jgalar@efficios.com>; Jonathan Rajotte-Julien <joraj=
@efficios.com>; lttng-dev <lttng-dev@lists.lttng.org>
Subject: Transfer of LTTng copyright ownership: Olivier Cotte

Hi Olivier,

In order to facilitate maintenance of the LTTng project, would you agree to
transfer your copyright ownership for LTTng code co-authored with Jonathan
Rajotte at Polytechnique to EfficiOS Inc. ?

The copyright in question is for the files mi-lttng.cpp, mi-lttng.h and
mi-lttng-4.1.xsd in the lttng-tools project:

Copyright (C) 2014 Olivier Cotte <olivier.cotte@polymtl.ca>

Thanks,

Mathieu

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--_000_YQXPR01MB2712147C9653E6026971BAACAE5A9YQXPR01MB2712CANP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi everyone,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I see no inconvienecne into transfering the license&nbsp;<span style=3D"fon=
t-size:12pt;background-color:rgba(0, 0, 0, 0);display:inline !important">to=
 EfficiOS Inc.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt;background-color:rgba(0, 0, 0, 0);display:inl=
ine !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt;background-color:rgba(0, 0, 0, 0);display:inl=
ine !important">Wish you all best of luck with this work,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt;background-color:rgba(0, 0, 0, 0);display:inl=
ine !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt;background-color:rgba(0, 0, 0, 0);display:inl=
ine !important">Best,
<div>Olivier</div>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mathieu Desnoyers &lt=
;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> January 20, 2022 11:20 AM<br>
<b>To:</b> Olivier Moussavou Cotte &lt;olivier.moussavoucotte@mail.mcgill.c=
a&gt;<br>
<b>Cc:</b> Jeremie Galarneau &lt;jgalar@efficios.com&gt;; Jonathan Rajotte-=
Julien &lt;joraj@efficios.com&gt;; lttng-dev &lt;lttng-dev@lists.lttng.org&=
gt;<br>
<b>Subject:</b> Transfer of LTTng copyright ownership: Olivier Cotte</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Olivier,<br>
<br>
In order to facilitate maintenance of the LTTng project, would you agree to=
<br>
transfer your copyright ownership for LTTng code co-authored with Jonathan<=
br>
Rajotte at Polytechnique to EfficiOS Inc. ?<br>
<br>
The copyright in question is for the files mi-lttng.cpp, mi-lttng.h and<br>
mi-lttng-4.1.xsd in the lttng-tools project:<br>
<br>
Copyright (C) 2014 Olivier Cotte &lt;olivier.cotte@polymtl.ca&gt;<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com">http://www.efficios.com</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_YQXPR01MB2712147C9653E6026971BAACAE5A9YQXPR01MB2712CANP_--

--===============1684614268346836928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1684614268346836928==--
